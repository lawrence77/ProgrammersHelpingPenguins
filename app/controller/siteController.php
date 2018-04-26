<?php

include_once '../global.php';

// get the identifier for the page we want to load
$page = $_GET['page'];

// instantiate a SiteController and route it
$sc = new SiteController();
$sc->route($page);

class SiteController {
	// route us to the appropriate class method for this page
	public function route($page) {
		switch($page) {
			case 'home':
				$this->home();
				break;
			case 'dashboard':
				$this->dashboard();
				break;
            case 'login':
                $this->login();
                break;
			case 'campaigns':
				$this->campaigns();
				break;
			case 'crews':
				$this->crews();
				break;
			case 'people':
				$this->people();
				break;
			case 'users':
				$this->users();
				break;
            case 'myprofile':
                $this->myprofile();
                break;
			case 'map':
				$this->map();
				break;
		}

	}
	
	public function map(){
		$pageTitle = 'Map';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/map.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}
	
	public function users() {
		if(!isset($_SESSION['username'])) {
          header('Location: '.BASE_URL.'/login/'); exit();
		}
      $pageTitle = 'Users';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/userList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function home() {
      $pageTitle = 'Home';
	  
	  // log view page event
		$fe = new FeedEvent();
		$fe->creator_id = -1; //this information should not show up in any activity feeds
		if(isset($_SESSION['user_id'])){
			$fe->item_1_id = $_SESSION['user_id']; //log user who visited this page
		}
		else
		{
			$fe->item_1_id = -2; //unknown user (in a real system could possibly log ip address)
		}
		$fe->type = 'visit_page';
		$fe->data_1 ='Home'; //Which page was visited.
		$fe->save();
		
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/home.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function dashboard(){
	  $pageTitle ='Dashboard';
	  if(!isset($_SESSION['username'])) {
			header('Location: '.BASE_URL); exit();
		}
		$user = User::loadByUserName($_SESSION['username']);
		// log view page event
		$fe = new FeedEvent();
		$fe->creator_id = -1; //this information should not show up in any activity feeds
		if(isset($_SESSION['user_id'])){
			$fe->item_1_id = $_SESSION['user_id']; //log user who visited this page
		}
		else
		{
			$fe->item_1_id = -2; //unknown user (in a real system could possibly log ip address)
		}
		$fe->type = 'visit_page';
		$fe->data_1 ='Dashboard'; //Which page was visited.
		$fe->save();
		
		
	  $fes = FeedEvent::getFeedEvents();
	  include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/dashboard.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
    /*public function myprofile(){
	  $pageTitle ='My Profile';
        //$_Session username should always be set when viewing the user profile
	  if(!isset($_SESSION['username'])) {
			header('Location: '.BASE_URL); exit();
		}     
	  include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/profile.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
    */
  public function login()
  {
      $pageTitle = 'Login';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/login.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }

  public function campaigns()
  {
      if (isset($_SESSION['username'])) {
    	  $pageTitle = 'Campaigns';
		  
		  // log view page event
		$fe = new FeedEvent();
		$fe->creator_id = -1; //this information should not show up in any activity feeds
		if(isset($_SESSION['user_id'])){
			$fe->item_1_id = $_SESSION['user_id']; //log user who visited this page
		}
		else
		{
			$fe->item_1_id = -2; //unknown user (in a real system could possibly log ip address)
		}
		$fe->type = 'visit_page';
		$fe->data_1 ='Campaigns'; //Which page was visited.
		$fe->save();
		  
          include_once SYSTEM_PATH.'/view/header.tpl';
          include_once SYSTEM_PATH.'/view/campaignList.tpl';
          include_once SYSTEM_PATH.'/view/footer.tpl';
      } else {
          header('Location: '.BASE_URL.'/login/');
      }
  }
  public function crews()
  {
      if (isset($_SESSION['username'])) {
    	  $pageTitle = 'Crews';
		  
		  // log view page event
		$fe = new FeedEvent();
		$fe->creator_id = -1; //this information should not show up in any activity feeds
		if(isset($_SESSION['user_id'])){
			$fe->item_1_id = $_SESSION['user_id']; //log user who visited this page
		}
		else
		{
			$fe->item_1_id = -2; //unknown user (in a real system could possibly log ip address)
		}
		$fe->type = 'visit_page';
		$fe->data_1 ='Crews'; //Which page was visited.
		$fe->save();
		  
          include_once SYSTEM_PATH.'/view/header.tpl';
          include_once SYSTEM_PATH.'/view/crewList.tpl';
          include_once SYSTEM_PATH.'/view/footer.tpl';
      } else {
          header('Location: '.BASE_URL.'/login/');
      }
  }
  public function people()
  {
      if (isset($_SESSION['username'])) {
    	  $pageTitle = 'People';
		  
		  // log view page event
		$fe = new FeedEvent();
		$fe->creator_id = -1; //this information should not show up in any activity feeds
		if(isset($_SESSION['user_id'])){
			$fe->item_1_id = $_SESSION['user_id']; //log user who visited this page
		}
		else
		{
			$fe->item_1_id = -2; //unknown user (in a real system could possibly log ip address)
		}
		$fe->type = 'visit_page';
		$fe->data_1 ='People'; //Which page was visited.
		$fe->save();
		  
          include_once SYSTEM_PATH.'/view/header.tpl';
          include_once SYSTEM_PATH.'/view/peopleList.tpl';
          include_once SYSTEM_PATH.'/view/footer.tpl';
      } else {
          header('Location: '.BASE_URL.'/login/');
      }
  }


}
