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
		$form->addText('username', 'Jméno:')
			->setRequired('Prosím vyplňte své uživatelské jméno.');

        $form->addText('lastname', 'Přijmení:')
			->setRequired('Prosím vyplňte své uživatelské jméno.');


		$form->addPassword('password', 'Heslo:')
			->setRequired('Prosím vyplňte své heslo.');

		$form->addSubmit('send', 'Registrovat');

		$form->onSuccess[] = [$this, 'register'];

		return $form;
	}

    public function register(Form $form, \stdClass $data): void
    {
        $existingUser = $this->database->table('users')
            ->where('username', $data->username)
            ->where('lastname', $data->username)
            ->fetch();

        if ($existingUser) {
            $form['username']->addError('Toto jméno je již zabrané.');
            return;
        }

        $this->database->table('users')->insert([
            'username' => $data->username,
            'lastname' => $data->lastname,
            'password' => $this->passwords->hash($data->password),
			'role' => 'user',
        ]);

        $this->flashMessage('Děkuji za registraci', 'success');
        $this->flashMessage('Teď se můžeš jít přihlásit', 'success');
        $this->redirect('this');
    }
    public function getAll(): array
	{
		return $this->database->table('users')->fetchAll();
	}
}

