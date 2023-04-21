<?php
namespace App\Model;

use Nette\Database\Context;


class CommentManager
{
    /** @var Context */
    private $database;

    public function __construct(Context $database)
    {
        $this->database = $database;
    }

    public function deleteComment($id)
    {
        $this->database->table('comments')->where('id', $id)->delete();
    }
    
    public function getCommentsByPostId(int $postId): array
    {
        return $this->database->table('comments')->where('post_id', $postId)->order('created_at')->fetchAll();
    }
}
