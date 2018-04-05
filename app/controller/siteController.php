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
		}

	}
  public function home() {
      $pageTitle = 'Home';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/home.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function dashboard(){
	  $pageTitle ='Dashboard';
	  if(!isset($_SESSION['username'])) {
			header('Location: '.BASE_URL); exit();
		}
		
	  $fes = FeedEvent::getFeedEvents(5);
	  include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/dashboard.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }

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
          include_once SYSTEM_PATH.'/view/header.tpl';
          include_once SYSTEM_PATH.'/view/peopleList.tpl';
          include_once SYSTEM_PATH.'/view/footer.tpl';
      } else {
          header('Location: '.BASE_URL.'/login/');
      }
  }


}
