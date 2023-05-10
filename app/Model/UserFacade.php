<?php
namespace App\Model;

use Nette;

final class UserFacade
{
	public function __construct(
		private Nette\Database\Explorer $database,
	) {
	}

	public function getAllUsers()
	{
		return $this->database->table('users')->fetchAll();
	}

	public function getUserById(int $id)
	{
		return $this->database
			->table('users')
			->get($id);
	}
    
} 
