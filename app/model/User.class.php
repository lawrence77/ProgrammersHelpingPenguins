<?php

/**
 * User Model Class for inserting and users to the database
 * NOTE Updating and deleting users is currently not support on the web application.
 */
class User {
    const DB_TABLE = 'users'; //database table name

    //database fields for this table
    public $id = 0;
    public $firstName = '';
    public $lastName = '';
    public $age = 0;
    public $username = '';
    public $password = '';

    //Loads a user by username, not by id, since people type in their username and password
    public static function loadByUsername($username) {
        $db = Db::instance();   //create db connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE username = '%s';", self::DB_TABLE, $username);
        $result = $db->query($q);   //execute query

        if ($result->num_rows == 0) {
            return null;    //no user
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $user = new User();

            //store db results
            $user->id =         $row['pkUser'];
            $user->firstName =  $row['firstName'];
            $user->lastName =   $row['lastName'];
            $user->age =        $row['age'];
            $user->username =   $row['username'];
            $user->password =   $row['password'];

            return $user;   //found filled user info
        }
    }
	public static function loadById($id) {
        $db = Db::instance();   //create db connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE pkUser = %d;", self::DB_TABLE, $id);
        $result = $db->query($q);   //execute query

        if ($result->num_rows == 0) {
            return null;    //no user
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $user = new User();

            //store db results
            $user->id =         $row['pkUser'];
            $user->firstName =  $row['firstName'];
            $user->lastName =   $row['lastName'];
            $user->age =        $row['age'];
            $user->username =   $row['username'];
            $user->password =   $row['password'];

            return $user;   //found filled user info
        }
    }


    //save function for a new user. Do not support user updates at the moment
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();
        }
    }

    //inserts a new user into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`firstName`, `lastName`, `age`, `username`, `password`) VALUES (%s, %s, %s, %s, %s);",
            self::DB_TABLE,
            $db->escape($this->firstName),
            $db->escape($this->lastName),
            $db->escape($this->age),
            $db->escape($this->username),
            $db->escape($this->password)
        );

        $db->query($q);
        return $db->getInsertID();
    }
}

 ?>
