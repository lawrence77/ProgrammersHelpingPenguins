<?php

include_once '../global.php';

//get the identifier for the page we want to load
$action = $_GET['action'];

$userCtrl = new UserController();
$userCtrl->route($action);

/**
 * Controls extra functionality the login page includes
 */
class UserController
{
    public function route($action)
    {
        switch ($action) {
            case 'view':
                $this->view($_GET['id']);
                break;
        }
    }
	
	public function view($id)
	{
		if(!isset($_SESSION['username'])) {
          header('Location: '.BASE_URL.'/login/'); exit();
		}
      $pageTitle = 'My Profile';
	  $user = User::loadById($id);
      $fes = FeedEvent::getFeedEvents();   
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/profile.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
	}
}
