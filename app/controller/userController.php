<?php

include_once '../global.php';

//get the identifier for the page we want to load
$action = $_GET['action'];

$userCtrl = new UserController();
$userCtrl->route($action);

/**
 * Controls extra functionality the login page includes
 */
class UserController
{
    public function route($action)
    {
        switch ($action) {
            case 'view':
                $this->view($_GET['id']);
                break;
	    case 'follow':
	        $this->follow($_POST['id'], $_POST['f_id']);
		break;
	    case 'unfollow':
	        $this->unfollow($_POST['id'], $_POST['f_id']);
		break;
        case 'edit':
            $this->editProfile($_POST['id']);
            break;
        }
    }

	public function view($id)
	{
		if(!isset($_SESSION['username'])) {
		    header('Location: '.BASE_URL.'/login/'); exit();
		}
		$user = User::loadById($id);
		if($_SESSION['user_id'] == $user->id) {
			$pageTitle = 'My Profile';
		} else {
			$pageTitle = 'View Profile';
		}
		$fes = FeedEvent::getFeedEvents();
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/profile.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
    	}

	public function follow($id, $f_id) {
		// log follow event
		$fe = new FeedEvent();
		$fe->creator_id = $id;
		$fe->item_1_id = $f_id;
		$fe->type = 'follow';
		$fe->save();
		
	    $user = User::loadById($id);
	    $res = $user->follow($f_id);
	    if($res) {
	        $msg = "Follow successful.";
	    } else {
	        $msg = "Follow failed.";
	    }
	    header('Content-Type: application/json'); // let client know it's Ajax
	    echo json_encode(array(
	        "result" => $res,
		"msg" => $msg
	    ));
	}

	public function unfollow($id, $f_id) {
		// log follow event
		$fe = new FeedEvent();
		$fe->creator_id = $id;
		$fe->item_1_id = $f_id;
		$fe->type = 'unfollow';
		$fe->save();
		
	    $user = User::loadById($id);
	    $res = $user->unfollow($f_id);
	    if($res) {
	        $msg = "Unfollow successful.";
	    } else {
	        $msg = "Unfollow failed.";
	    }
	    header('Content-Type: application/json'); // let client know it's Ajax
	    echo json_encode(array(
	        "result" => $res,
		"msg" => $msg
	    ));
	}

    public function editProfile($id)
    {
        $user = User::loadById($id);
		
		$fe = new FeedEvent();
		$fe->creator_id = -1;
		$fe->item_1_id = $id;
		$fe->type = 'edit_Profile';
		$fe->data_1 = '';
		$fe->data_2 = '';
		
		//Check which parts got edited
		if($user->firstName  != $_POST['firstName'])
		{
			$fe->data_1 = $fe->data_1. 'Old firstName: ' . $user->firstName . ' / ';
			$fe->data_2 = $fe->data_2. 'New firstName: ' . $_POST['firstName'] . ' / ';
		}
		if($user->lastName != $_POST['lastName'])
		{
			$fe->data_1 = $fe->data_1. 'Old lastName: ' . $user->lastName . ' / ';
			$fe->data_2 = $fe->data_2. 'New lastName: ' . $_POST['lastName'] . ' / ';
		}
		if($user->age != $_POST['age'])
		{
			$fe->data_1 = $fe->data_1. 'Old age: ' . $user->age . ' / ';
			$fe->data_2 = $fe->data_2. 'New age: ' . $_POST['age'] . ' / ';
		}
		if($user->username != $_POST['username'])
		{
			$fe->data_1 = $fe->data_1. 'Old username: ' . $user->username . ' / ';
			$fe->data_2 = $fe->data_2. 'New username: ' . $_POST['username'] . ' / ';
		}
		if($user->password != $_POST['password'])
		{
			$fe->data_1 = $fe->data_1. 'Old password: ' . $user->password . ' / ';
			$fe->data_2 = $fe->data_2. 'New password: ' . $_POST['password'] . ' / ';
		}
		if($user->role != $_POST['role'])
		{
			$fe->data_1 = $fe->data_1. 'Old role: ' . $user->role . ' / ';
			$fe->data_2 = $fe->data_2. 'New role: ' . $_POST['role'] . ' / ';
		}
		
		//Only log event if anything actually changed
		if($fe->data_1 != '')
		{
			$fe->save();
		}
        $user->firstName    = $_POST['firstName'];
        $user->lastName     = $_POST['lastName'];
        $user->age          = $_POST['age'];
        $user->username     = $_POST['username'];
        $user->password     = $_POST['password'];
        $user->role         = $_POST['role'];
        $id = $user->save();

        if ($_SESSION['username'] == $user->username)
            $_SESSION['role'] = $user->role;

        if($id['id'] == 0) {
            $json = array('success' => false, 'query' => $id['query']);
        } else {
	    $user->id = $id['id'];
            $json = array('success' => true, 'id' => $id['id'], 'data' => json_encode($_POST));
        }
        header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
    }
}
