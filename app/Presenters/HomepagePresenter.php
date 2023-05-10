<?php
namespace App\Presenters;

use App\Model\PostFacade;
use App\Model\UserFacade;
use Nette;

final class HomepagePresenter extends Nette\Application\UI\Presenter
{
    private UserFacade $userFacade;

    public function __construct(
        private PostFacade $facade,
        UserFacade $userFacade
    ) {
        $this->userFacade = $userFacade;
    }
	public function renderDefault(): void
	{
		$this->template->posts = $this->facade
			->getPublicArticles()
			->limit(100);
	}
	
	/**
 * @Authorize("admin")
 */
public function renderAdmin(): void
{
    $users = $this->userFacade->getAllUsers();
    $this->template->add('users', $users);
}
	
}
