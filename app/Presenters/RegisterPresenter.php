<?php
namespace App\Presenters;

use Nette;
use Nette\Application\UI\Form;

final class RegisterPresenter extends Nette\Application\UI\Presenter
{
    private Nette\Database\Explorer $database;

    public function __construct(Nette\Database\Explorer $database, private Nette\Security\Passwords $passwords)
    {
        $this->database = $database;
    }

	protected function createComponentRegisterForm(): Form
	{
		$form = new Form;
		$form->addText('username', 'Uživatelské jméno:')
			->setRequired('Prosím vyplňte své uživatelské jméno.');

		$form->addPassword('password', 'Heslo:')
			->setRequired('Prosím vyplňte své heslo.');

		$form->addSubmit('send', 'Registrovat');

		$form->onSuccess[] = [$this, 'register'];
		return $form;
	}

    public function register(Form $form, \stdClass $data): void
    {
        $this->database->table('users')->insert([
            'username' => $data->username,
            'password' => $this->passwords->hash($data->password),
			'role' => 'user',
        ]);

        $this->flashMessage('Děkuji za registraci', 'success');
        $this->redirect('this');
    }

}
