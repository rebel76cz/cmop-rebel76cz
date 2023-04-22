<?php
namespace App\Presenters;

use Nette;
use Nette\Application\UI\Form;
use App\Model\CommentManager;

final class PostPresenter extends Nette\Application\UI\Presenter
{
    private Nette\Database\Explorer $database;
    private CommentManager $commentManager;

    public function __construct(Nette\Database\Explorer $database, CommentManager $commentManager)
    {
        $this->database = $database;
        $this->commentManager = $commentManager;
    }

    public function renderShow(int $postId): void
    {
        $post = $this->database
            ->table('posts')
            ->get($postId);

        if (!$post) {
            $this->error('Stránka nebyla nalezena');
        }

        $this->template->post = $post;
        $this->template->comments = $this->commentManager->getCommentsByPostId($postId);
    }

    protected function createComponentCommentForm(): Form
{
    $form = new Form;

    $form->addText('name', 'Jméno:')
        ->setRequired();

    $form->addEmail('email', 'E-mail:');

    $form->addTextArea('content', 'Komentář:')
        ->setRequired();

    $form->addSubmit('send', 'Publikovat komentář');

    $form->onSuccess[] = [$this, 'commentFormSucceeded'];

    $form->addProtection();
//zjisti, zda je uzivatel prihlasen
    if (!$this->getUser()->isLoggedIn()) {
        $this->flashMessage('Pro vytvoření komentáře se prosím přihlaste.', 'warning');
       // $this->redirect('in');
    }

    return $form;
}


    

    public function commentFormSucceeded(Form $form, \stdClass $values): void
    {
        $postId = $this->getParameter('postId');

        $this->database->table('comments')->insert([
            'post_id' => $postId,
            'name' => $values->name,
            'email' => $values->email,
            'content' => $values->content,
        ]);

        $this->flashMessage('Děkuji za komentář', 'success');
        $this->redirect('this');
    }

    public function handleDeleteComment(int $id): void
    {
        $comment = $this->database->table('comments')->get($id);

        if (!$comment) {
            $this->error('Komentář nebyl nalezen');
        }

        $comment->delete();

        $this->flashMessage('Komentář byl smazán.');
        $this->redirect('this');
    }

    public function actionDeleteComment(int $id): void
    {
        $this->commentManager->deleteComment($id);
        $this->flashMessage('Komentář byl smazán.', 'success');
        $this->redirect('this');
    }


}
