<?php

include_once '../global.php';

// get the identifier for the action we want to load
$action = $_GET['action'];

// instantiate a SiteController and route it
$cc = new CampaignController();
$cc->route($action);

class CampaignController {
	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'add':
				$this->add();
				break;
			case 'view':
				$this->view($_GET['id']);
				break;
            case 'update':
                $this->update($_GET['id']); //update campaign with this name
                break;
			case 'delete':
				$this->delete($_GET['id']); //delete campaign with this name
				break;
		}

	}
  public function add() {
      $pageTitle = 'Add new campaign';
      //$errors= array();
		$campaign = new campaign();
		//Check if is post request
		if(is_post_request()) {

		  // Confirm that values are present before accessing them.
		  if(isset($_POST['name'])) { $campaign['name'] = $_POST['name']; }
		  if(isset($_POST['date'])) { $campaign['date'] = $_POST['date']; }
		  if(isset($_POST['description'])) { $campaign['description'] = $_POST['description']; }
		  //validate changes
		  //update database
		  $result = $campaign.insert(); //returns true if successful or an array of errors if any exist
			header("Location: " . $BASE_URL . "/campaigns/view/".$result);
			exit;
		//  if($result === true) {
		//	redirect_to('/library');
		 // } else {
		//	$errors = $result;
		  }
		}
		
		
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/campaignAdd.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }

  public function update($id)
  {
      $pageTitle = 'Update Campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/login.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function delete($id)
  {
	  //$pageTitle = 'Campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/campaignList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function view($id)
  {
      $pageTitle = 'View campaign';
      include_once SYSTEM_PATH.'/view/header.tpl';
      //include_once SYSTEM_PATH.'/view/login.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }


}
