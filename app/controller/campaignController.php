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
			case 'newCampaign':
				$this->newCampaign();
				break;
			case 'view':
				$this->view($_GET['id']);
				break;
			case 'deleteCampaign':
				$this->deleteCampaign($_POST['id']);
				break;
		    case 'editCampaign':
				$this->editCampaign($_POST['id']); //update campaign with this id
				break;
		}

	}
    public function deleteCampaign($id)
    {
        $c = Campaign::loadById($id);

	$result = $c->delete();
	if(!$result)
	{
		$json = array('success' => false);
	} else {
		$json = array('success' => true, 'id' => $id);
	}
	header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
    }
  public function newCampaign()
    {
        $campaign = new Campaign();
		$campaign->id                 = 0;
        $campaign->name    				= $_POST['name'];
        $campaign->date        			= $_POST['date'];
        $campaign->description     		= $_POST['description'];
	$id = $campaign->save();
	
	// log event
		$fe = new FeedEvent();
		$fe->creator_id = $_SESSION['user_id'];
		$fe->item_1_id = $id['id'];
		$fe->type = 'add_campaign';
		$fe->save();
		
	if($id['id'] == 0)
	{
		$json = array('success' => false, 'query' => $id['query']);
	} else {
		$json = array('success' => true, 'id' => $id['id'], 'data' => json_encode($_POST));
	}
	header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
        

    }

  public function editCampaign($id)
  {
		$campaign = Campaign::loadById($id);
		$campaign->name    				= $_POST['name'];
        $campaign->date        			= $_POST['date'];
        $campaign->description     		= $_POST['description'];
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
