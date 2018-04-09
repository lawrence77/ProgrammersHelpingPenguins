<?php

include_once '../global.php';

//get the identifier for the page we want to load
$action = $_GET['action'];

$logCtrl = new LoginController();
$logCtrl->route($action);

/**
 * Controls extra functionality the login page includes
 */
class LoginController
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
      $pageTitle = 'View campaign';
	  $user = User::loadById($id);
      include_once SYSTEM_PATH.'/view/header.tpl';
      //include_once SYSTEM_PATH.'/view/profile.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
	}
}
