<?php

namespace App\Presenters;

use Nette;
use Nette\Application\UI\Form;
use Nette\Database\Explorer;
use Nette\Database\Table\ActiveRow;

final class EditPresenter extends Nette\Application\UI\Presenter
{
    private Explorer $database;

    public function __construct(Explorer $database)
    {
        parent::__construct();
        $this->database = $database;
    }
    protected function createComponentPostForm(): Form
    {
        $form = new Form;
        $form->setMethod('POST');
        $form->addText('title', 'Titulek');
        $form->addTextArea('content', 'Obsah:')
        ->setRequired();
        $form->addUpload('file', 'Nahrát obrázek')
        ->addRule(Form::IMAGE, 'Only image files are allowed');
        $form->addSubmit('submit', 'Upravit');
        $form->onSuccess[] = [$this, 'postFormSucceeded'];
    
        $id = $this->getParameter('id');
        if ($id) {
            $post = $this->database->table('posts')->get($id);
            if ($post) {
                $form->setDefaults([
                    'file' => '',
                    'title' => $post->title,
                    'content' => $post->content
                ]);
            }
        }
    
        return $form;
    }
    
    public function postFormSucceeded(Form $form, array $data): void
{
    $form->addText('file_name', 'File name')->setDefaultValue('');

// In the postFormSucceeded method
$file = $data['file'];
$title = $data['title'];
$file_name = $data['file_name'] ?? null;

$content = $data['content'];

    if ($file->isOk() && !$file->isImage()) {
        $form->addError('The uploaded file is not a valid image');
        return;
    }

    if ($file->isOk()) {
        $fileName = uniqid() . '.' . $file->getImageFileExtension();
        $file->move(__DIR__ . '/../../www/img/upload/' . $fileName);

    }

    $id = $this->getParameter('id');
    if ($id) {
        $post = $this->database->table('posts')->get($id);
        if ($post instanceof ActiveRow) {
            $imageId = $post->image_id;

            // delete old image if new one is uploaded
            if ($file->isOk()) {
                $this->database->table('images')->wherePrimary($imageId)->delete();
                $imageId = $this->database->table('images')->insert([
                    'name' => $fileName,
                    'size' => $file->getSize(),
                    'data' => file_get_contents($file->getTemporaryFile()),
                ])->getPrimary();
            }

            $post->update([
                'image_id' => $imageId,
                'file_name' => ($file->isOk()) ? $fileName : $post->file_name,
                'title' => $title,
                'content' => $content,
            ]);
            $this->flashMessage('Příspěvek byl úspěšně upraven.', 'success');
        } else {
            $this->flashMessage('Příspěvek nebyl nalezen.', 'error');
        }
    } else {
        if ($file->isOk()) {
            $imageId = $this->database->table('posts')->insert([
                'name' => $fileName,
                'size' => $file->getSize(),
                'data' => file_get_contents($file->getTemporaryFile()),
            ])->getPrimary();

            $this->database->table('posts')->insert([
                'image_id' => $imageId,
                'content' => $content,
                'title' => $title,
            ]);

            $this->flashMessage('Příspěvek byl úspěšně vytvořen.', 'success');
        } else {
            $this->flashMessage('The uploaded file is not valid.', 'error');
        }
    }

    $this->redirect('this');
}
}