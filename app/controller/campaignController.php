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
		echo $action;
		switch($action) {
			case 'newCampaign':
			
				$this->newCampaign();
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
  public function newCampaign()
    {
        $campaign = new Campaign();
		$campaign->id                 = 0;
        $campaign->name    				= $_POST['name'];
        $campaign->date        			= $_POST['date'];
        $campaign->description     		= $_POST['description'];
		echo "stuff";
	$id = $campaign->save();
	if($id['id'] == 0)
	{
		$json = array('success' => false, 'query' => $id['query']);
	} else {
		$json = array('success' => true, 'id' => $id['id'], 'data' => json_encode($_POST));
	}
	header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
        

    }

  public function update($id)
  {
      $pageTitle = 'Update Campaign';
		$campaign = Campaign::loadById($id);
		//Check if is post request
		if($_SERVER['REQUEST_METHOD'] == 'POST') {

		  // Confirm that values are present before accessing them.
		  if(isset($_POST['name'])) { $campaign['name'] = $_POST['name']; }
		  if(isset($_POST['date'])) { $campaign['date'] = $_POST['date']; }
		  if(isset($_POST['description'])) { $campaign['description'] = $_POST['description']; }
		  //validate changes
		  //update database
		  $result = $campaign.save();
			header("Location: " . $BASE_URL . "/campaigns/view/".$result);
			exit;
		}
		
		
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/campaignEdit.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function delete($id)
  {
	  $pageTitle = 'DELETE THIS';
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/campaignList.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }
  
  public function view($id)
  {
      $pageTitle = 'View campaign';
	  $campaign = Campaign::loadById($id);
      include_once SYSTEM_PATH.'/view/header.tpl';
      include_once SYSTEM_PATH.'/view/campaignView.tpl';
      include_once SYSTEM_PATH.'/view/footer.tpl';
  }


}
