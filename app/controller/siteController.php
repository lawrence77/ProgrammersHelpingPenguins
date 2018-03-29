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

  public function login()
  {
      $pageTitle = 'Login';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/login.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function campaigns()
  {
	  $pageTitle = 'Campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/campaignList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  public function crews()
  {
	  $pageTitle = 'Campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/crewList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  public function people()
  {
	  $pageTitle = 'Campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/peopleList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }


}
