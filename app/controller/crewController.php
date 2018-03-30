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
            default:
                break;
        }
    }

    //Starts a new session for a logged-in user and redirects the page.
    public function loadCrew($id)
    {
        $crew = Crew::loadById($id);

        $pageTitle = $crew->bomberGroup;
        include_once SYSTEM_PATH.'/view/header.tpl';
        include_once SYSTEM_PATH.'/view/crew.tpl';
        include_once SYSTEM_PATH.'/view/peopleList.tpl';
        include_once SYSTEM_PATH.'/view/footer.tpl';
    }
    public function newCrew()
    {
        $crew = newCrew();
        $crew->provisionalWing    = $_POST['provisionalWing'];
        $crew->bomberGroup        = $_POST['bomberGroup'];
        $crew->trainingSchool     = $_POST['trainingSchool'];
        $crew->sent               = $_POST['sent'];
        $crew->losses             = $_POST['losses'];
        $crew->stationedAirfield  = $_POST['stationedAirfield'];
	return json_encode($crew);
	$id = $crew->save();
	$json = array('id' => $id);
	return json_encode($json);
        

    }
   
}
