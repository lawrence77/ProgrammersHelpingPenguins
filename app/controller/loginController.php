<?php

include_once '../global.php';

//get the identifier for the page we want to load
$action = $_GET['action'];

$logCtrl = new LoginController();
$logCtrl->route($action);

/**
 * Controls extra functionality the login page includes
 */
class LoginController
{
    public function route($action)
    {
        switch ($action) {
            case 'out':
                $this->logOut();
                break;
            case 'process':
                $this->processLogin($_POST['username'], $_POST['password']);
                break;
            case 'newUser':
                $this->createNewUser($_POST['firstName'],
                    $_POST['lastName'],
                    $_POST['age'],
                    $_POST['username'],
                    $_POST['password'],
                    $_POST['role']
                );
                break;
            default:
                break;
        }
    }

    //Ends the current session to enable a user to log out.
    public function logOut()
    {
        #session_start();
        if (isset($_SESSION['username'])) {
            unset($_SESSION['username']);
            unset($_SESSION['user_id']);
            unset($_SESSION['role']);
            session_destroy();
        }
        header('Location: '.BASE_URL);
    }

    //Starts a new session for a logged-in user and redirects the page.
    public function processLogin($un, $pw)
    {
        $user = User::loadByUsername($un);
        //successfully found user in db and correct password
        if ($user != null && $user->password == $pw) {
            $relocation = 'Location: '.BASE_URL.'/campaigns/';
            session_start();
            $_SESSION['username'] = $un;
			$_SESSION['user_id'] = $user->id;
            $_SESSION['role'] = $user->role;
        } else {                //failed to find user in db
            $relocation = 'Location: '.BASE_URL.'/login/';
        }
        header($relocation);
    }
    //Creates a new user in the database
    public function createNewUser($firstName, $lastName, $age, $username, $password, $role=null)
    {
        if (empty($firstName) || empty($lastName) || empty($age) ||
            empty($username) || empty($password)) {
            header('Location: '.BASE_URL.'/login/');
            exit();
        }

        //create new User based on parameters
        $user = new User();
        $user->firstName    = $firstName;
        $user->lastName     = $lastName;
        $user->age          = $age;
        $user->username     = $username;
        $user->password     = $password;
        if ($role) $user->role = 1;     //historian access
        else $user->role = 2;           //viewer access

        echo $role."\n";
        echo $user->role;
        $relocation = '';
        if ($user->save() == null) {
            //failed to save to db
            $relocation = 'Location: '.BASE_URL.'/campaigns/';
        } else {
            $relocation = 'Location: '.BASE_URL.'/home/';
            session_start();
            $_SESSION['username'] = $user->username;
            $_SESSION['user_id'] = $user->id;
            $_SESSION['role'] = $user->role;
        }
        header($relocation);
    }
}
