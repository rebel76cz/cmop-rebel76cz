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
        $form->addUpload('file', 'Upload file')
            ->addCondition(Form::FILLED)
            ->addRule(Form::IMAGE, 'Only image files are allowed');
        $form->addText('title', 'Title');
        $form->addTextArea('content', 'Obsah:')
		->setRequired();
        $form->addSubmit('submit', 'Submit');
        $form->onSuccess[] = [$this, 'postFormSucceeded'];

        $id = $this->getParameter('id');
        if ($id) {
            $post = $this->database->table('posts')->get($id);
            if ($post) {
                $form->setDefaults([
                    'file' => '',
                    'title' => $post->title,
                ]);
            }
        }

        return $form;
    }

    public function postFormSucceeded(Form $form, array $data): void
    {
        $file = $data['file'];
        $title = $data['title'];
        $content = $data['content'];
        $fileName = '';

        if ($file->isOk() && !$file->isImage()) {
            $form->addError('The uploaded file is not a valid image');
            return;
        }

        $fileName = null;

        if ($file->isOk()) {
            $fileName = uniqid() . '.' . $file->getImageFileExtension();
            $file->move(__DIR__ . '/../../www/img/upload/' . $fileName);
        }
        

        $id = $this->getParameter('id');
        if ($id) {
            $post = $this->database->table('posts')->get($id);
            if ($post instanceof ActiveRow) {
                $post->update([
                    'file_name' => ($file->isOk()) ? $fileName : $post->file_name,
                    'title' => $title,
                    'content' => $content,
                ]);
                $this->flashMessage('The item has been updated.', 'success');
            } else {
                $this->flashMessage('The item could not be found.', 'error');
            }
        } else {
            if ($file->isOk()) {
                $this->database->table('posts')->insert([
                    'file_name' => $fileName,
                    'title' => $title,
                    'content' => $content,
                ]);
                $this->flashMessage('The item has been created.', 'success');
            } else {
                $this->database->table('posts')->insert([
                    'file_name' => null,
                    'title' => $title,
                    'content' => $content,
                ]);
                $this->flashMessage('The item has been created without image.', 'success');
            }
        }

        $this->redirect('this');
    }


    public function renderEdit(int $id): void
    {
        $post = $this->database->table('posts')->get($id);

        if (!$post instanceof ActiveRow) {
            $this->error('Post not found');
        }

        $this->getComponent('postForm')
            ->setDefaults($post->toArray());
    }

    protected function startup(): void
    {
        parent::startup();

        if (!$this->getUser()->isLoggedIn()) {
            $this->redirect('Sign:in');
        }
    }
}