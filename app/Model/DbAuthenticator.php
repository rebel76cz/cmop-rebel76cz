<?php
namespace App\Model;

use Nette;
use Nette\Security\SimpleIdentity;

class DbAuthenticator implements Nette\Security\Authenticator
{
	public function __construct(
		private Nette\Database\Explorer $database,
		private Nette\Security\Passwords $passwords,
	) {
	}

	public function authenticate(string $username, string $password): SimpleIdentity
{
    $row = $this->database->table('users')
        ->where('username', $username)
        ->fetch();

    if (!$row) {
        throw new Nette\Security\AuthenticationException('User not found.');
    }

    if (!$this->passwords->verify($password, $row->password)) {
        throw new Nette\Security\AuthenticationException('Invalid password.');
    }

    $roles = ['user'];
    if ($row->role === 'admin') {
        $roles[] = 'admin';
    }

    return new SimpleIdentity(
        $row->id,
        $roles,
        ['name' => $row->username],
    );
}
}
