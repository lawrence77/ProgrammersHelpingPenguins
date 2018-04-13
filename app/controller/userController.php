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
        $pageTitle = 'My Profile';
        $user = User::loadById($id);
        $fes = FeedEvent::getFeedEvents();
        include_once SYSTEM_PATH.'/view/header.tpl';
        include_once SYSTEM_PATH.'/view/profile.tpl';
        include_once SYSTEM_PATH.'/view/footer.tpl';
    	}

	public function follow($id, $f_id) {
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
            $json = array('success' => true, 'id' => $id['id'], 'data' => json_encode($_POST));
        }
        header('Content-Type: application/json'); // let client know it's Ajax
        echo json_encode($json);
    }
}
