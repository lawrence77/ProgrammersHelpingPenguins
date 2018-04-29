<?php

include_once '../global.php';

//get the identifier for the page we want to load
$action = $_GET['action'];

$crewCtrl = new CrewController();
$crewCtrl->route($action);

/**
 * Controls extra functionality the login page includes
 */
class CrewController
{
    public function route($action)
    {
        switch ($action) {
            case 'load':
                $this->loadCrew($_GET['id']);
                break;
            case 'edit':
                $this->processLogin($_POST['username'], $_POST['password']);
                break;
            case 'newCrew':
	        $this->newCrew();
		break;
	    case 'deleteCrew':
	        $this->deleteCrew($_POST['id']);
		    break;
        case 'editCrew':
            $this->editCrew($_POST['id']);
            break;
		case 'deploy':
	        $this->deploy($_POST['crew_id'], $_POST['camp_id']);
		break;
	    case 'undeploy':
	        $this->undeploy($_POST['crew_id'], $_POST['camp_id']);
		break;
        default:
                break;
        }
    }

    //Starts a new session for a logged-in user and redirects the page.
    public function loadCrew($id)
    {
        if (isset($_SESSION['username'])) {
            $crew = Crew::loadById($id);

            $pageTitle = $crew->bomberGroup;
            include_once SYSTEM_PATH.'/view/header.tpl';
            include_once SYSTEM_PATH.'/view/crew.tpl';
            include_once SYSTEM_PATH.'/view/footer.tpl';
        } else {
            header('Location: '.BASE_URL.'/login/');
        }
    }
    public function newCrew()
    {
        $crew = new Crew();
	$crew->id                 = 0;
        $crew->provisionalWing    = $_POST['provisionalWing'];
        $crew->bomberGroup        = $_POST['bomberGroup'];
        $crew->trainingSchool     = $_POST['trainingSchool'];
        $crew->sent               = $_POST['sent'];
        $crew->losses             = $_POST['losses'];
        $crew->stationedAirfield  = $_POST['stationedAirfield'];
	$id = $crew->save();
	// log creation event
		$fe = new FeedEvent();
		$fe->creator_id = $_SESSION['user_id'];
		$fe->item_1_id = $id['id'];
		$fe->type = 'add_crew';
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
    public function deleteCrew($id)
    {
        $crew = Crew::loadById($id);
		// log deletion event
		$fe = new FeedEvent();
		$fe->creator_id = $_SESSION['user_id'];
		$fe->item_1_id = $id;
		$fe->type = 'delete_crew';
		$fe->save();

	$result = $crew->delete();
	if(!$result)
	{
		$json = array('success' => false);
	} else {
		$json = array('success' => true, 'id' => $id);
	}
	header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
    }

    public function editCrew($id)
    {
        $crew = Crew::loadById($id);
		$fe = new FeedEvent();
		$fe->creator_id = $_SESSION['user_id'];
		$fe->item_1_id = $id;
		$fe->type = 'edit_crew';
		$fe->data_1 = '';
		$fe->data_2 = '';
		
		//Check which parts got edited
		if($crew->provisionalWing  != $_POST['provisionalWing'])
		{
			$fe->data_1 = $fe->data_1. 'Old provisionalWing: ' . $crew->provisionalWing . ' / ';
			$fe->data_2 = $fe->data_2. 'New provisionalWing: ' . $_POST['provisionalWing'] . ' / ';
		}
		if($crew->bomberGroup != $_POST['bomberGroup'])
		{
			$fe->data_1 = $fe->data_1. 'Old bomberGroup: ' . $crew->bomberGroup . ' / ';
			$fe->data_2 = $fe->data_2. 'New bomberGroup: ' . $_POST['bomberGroup'] . ' / ';
		}
		if($crew->sent != $_POST['sent'])
		{
			$fe->data_1 = $fe->data_1. 'Old sent: ' . $crew->sent . ' / ';
			$fe->data_2 = $fe->data_2. 'New sent: ' . $_POST['sent'] . ' / ';
		}
		if($crew->losses != $_POST['losses'])
		{
			$fe->data_1 = $fe->data_1. 'Old losses: ' . $crew->losses . ' / ';
			$fe->data_2 = $fe->data_2. 'New losses: ' . $_POST['losses'] . ' / ';
		}
		if($crew->stationedAirfield != $_POST['stationedAirfield'])
		{
			$fe->data_1 = $fe->data_1. 'Old stationedAirfield: ' . $crew->stationedAirfield . ' / ';
			$fe->data_2 = $fe->data_2. 'New stationedAirfield: ' . $_POST['stationedAirfield'] . ' / ';
		}
		if($crew->trainingSchool != $_POST['trainingSchool'])
		{
			$fe->data_1 = $fe->data_1. 'Old trainingSchool: ' . $crew->trainingSchool . ' / ';
			$fe->data_2 = $fe->data_2. 'New trainingSchool: ' . $_POST['trainingSchool'] . ' / ';
		}
		
		//Only log event if anything actually changed
		if($fe->data_1 != '')
		{
			$fe->save();
		}
		
        $crew->provisionalWing   = $_POST['provisionalWing'];
        $crew->bomberGroup       = $_POST['bomberGroup'];
        $crew->sent     		 = $_POST['sent'];
        $crew->losses     		 = $_POST['losses'];
        $crew->stationedAirfield = $_POST['stationedAirfield'];
        $crew->trainingSchool    = 0;
        $id = $crew->save();
		
		

        if($id['id'] == 0) {
            $json = array('success' => false, 'query' => $id['query']);
        } else {
            $json = array('success' => true, 'id' => $id['id'], 'data' => json_encode($_POST));
        }
        header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
    }
	
	public function deploy($crew_id, $camp_id) {

		
	    $crew = Crew::loadById($crew_id);
	    $res = $crew->deploy($camp_id);
	    if($res) {
	        $msg = "deployment successful.";
	    } else {
	        $msg = "deployment failed.";
	    }
	    header('Content-Type: application/json'); // let client know it's Ajax
	    echo json_encode(array(
	        "result" => $res,
		"msg" => $msg
	    ));
	}
	
	public function undeploy($crew_id, $camp_id) {
		$crew = Crew::loadById($crew_id);
	    $res = $crew->undeploy($camp_id);
	    if($res) {
	        $msg = "deployment successful.";
	    } else {
	        $msg = "deployment failed.";
	    }
	    header('Content-Type: application/json'); // let client know it's Ajax
	    echo json_encode(array(
	        "result" => $res,
		"msg" => $msg
	    ));
	}

}
