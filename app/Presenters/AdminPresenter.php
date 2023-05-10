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

	public function renderDefault()
	{
		$users = $this->userFacade->getAllUsers();
		$this->template->users = $users;
	}
} 