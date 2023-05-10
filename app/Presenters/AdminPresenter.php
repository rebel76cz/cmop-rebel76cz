<?php
namespace App\Presenters;

use App\Model\UserFacade;

final class AdminPresenter extends BasePresenter
{
	private UserFacade $userFacade;

	public function __construct(UserFacade $userFacade)
	{
		$this->userFacade = $userFacade;
	}
    public function startup()
	{
		parent::startup();

		if ($this->getUser()->isLoggedIn() === false && $this->getAction() !== 'signIn') {
			$this->flashMessage('Tato sekce není přístupná bez přihlášení', 'danger');
			$this->redirect('signIn');
		}
	}

	// http://localhost/admin/sign-in
	public function actionSignIn()
	{
		$this->setLayout('admin.signIn');
	}

	// http://localhost/admin/dashboard
	public function actionDashboard()
	{
		$this->setLayout('admin');
	}
	public function renderDefault()
	{
		$users = $this->userFacade->getAllUsers();
		$this->template->users = $users;
	}
} 