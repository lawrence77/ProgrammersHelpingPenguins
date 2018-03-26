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
		}

	}
  public function home() {
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/home.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }


}
