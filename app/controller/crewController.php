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
                    this->loadCrew($_POST['crew'])
                break;
            case 'edit':
                $this->processLogin($_POST['username'], $_POST['password']);
                break;
            default:
                break;
        }
    }

    //Starts a new session for a logged-in user and redirects the page.
    public function loadCrew($c)
    {
        $crew = Crew::loadById($c->id);
        
      $pageTitle = $crew['bomberGroup'];
      include_once SYSTEM_PATH.'/view/crew.tpl';    
    }
   
}