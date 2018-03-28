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
                    $_POST['password']
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
            $relocation = 'Location: '.BASE_URL.'/home/';
            session_start();
            $_SESSION['username'] = $un;
        } else {                //failed to find user in db
            $error = 'Incorrect Username or Password';
            $relocation = 'Location: '.BASE_URL.'/signin/error/'.$error.'/0/';
        }
        header($relocation);
    }
    //Creates a new user in the database
    public function createNewUser($firstName, $lastName, $age, $username, $password)
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

        $relocation = '';
        if ($user->save() == null) {
            //failed to save to db
            $relocation = 'Location: '.BASE_URL.'/login/';
        } else {
            $relocation = 'Location: '.BASE_URL.'/home/';
            session_start();
            $_SESSION['username'] = $user->username;
        }
        header($relocation);
    }
}
