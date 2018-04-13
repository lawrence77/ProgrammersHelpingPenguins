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
    public $role = 0;
    public $following = array();

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
            $user->role =       $row['role'];
	    $user->getFollowing();

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
            $user->role =       $row['role'];
	    $user->getFollowing();

            return $user;   //found filled user info
        }
    }

	//get all campaigns in the database
    public static function getUsers()
    {
        $db = Db::instance();   //db connection
        $q = sprintf("SELECT pkUser FROM `%s` ORDER BY lastName ASC;", self::DB_TABLE);
        $result = $db->query($q);

        $userArray = array();
        if ($result->num_rows != 0) {       //traverse all pkCampaigns found from the query
            while ($row = $result->fetch_assoc()) {
				$user = self::loadById($row['pkUser']); //fetch all data based on pk
				//if(!$user->deleted)
				//{
					$userArray[] = $user; //only fetch campaings that are not deleted
				//}
            }
        }
        return $userArray;
    }

    //save function for a new user. Do not support user updates at the moment
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();
        }
        else {
            return $this->update();
        }
    }

    //inserts a new user into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`firstName`, `lastName`, `age`, `username`, `password`, `role`) VALUES (%s, %s, %s, %s, %s, %d);",
            self::DB_TABLE,
            $db->escape($this->firstName),
            $db->escape($this->lastName),
            $db->escape($this->age),
            $db->escape($this->username),
            $db->escape($this->password),
            $this->role
        );

        $db->query($q);
        $res = array('id' => $db->getInsertID(), 'query' => $q);
        return $res;
    }

    public function update()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("UPDATE `%s` SET
            `firstName` = %s,
            `lastName` = %s,
            `age` = %s,
            `username` = %s,
            `password` = %s,
            `role` = %d
            WHERE `pkUser` = %d;",
            self::DB_TABLE,
            $db->escape($this->firstName),
            $db->escape($this->lastName),
            $db->escape($this->age),
            $db->escape($this->username),
            $db->escape($this->password),
            $this->role,
            $this->id
        );

        $db->query($q); //execute query
        $res = array('id' => $this->id, 'query' => $q);
        return $res; //return this object's id
    }
    public function getFollowing()
    {
        $fArray = array();
        $db = Db::instance();   //create db connection
        $q = sprintf("SELECT followee_id FROM `relationships` WHERE follower_id = %d;",
	    $db->escape($this->id)
	);
	$result = $db->query($q);
        if ($result->num_rows != 0) {       //traverse all pkCampaigns found from the query
            while ($row = $result->fetch_assoc()) {
	        $fArray[] = $row['followee_id'];
            }
	}
	$this->following = $fArray;
    }
    public function follow($id)
    {
        $db = Db::instance();   //create db connection
        $q = sprintf("DELETE FROM `relationships` WHERE follower_id = %d AND followee_id = %d;",
	    $db->escape($this->id),
	    $db->escape($id)
	);
	$db->query($q);

        //build query
        $q2 = sprintf("INSERT INTO `relationships` (`follower_id`, `followee_id`, `follows`) VALUES (%d, %d, %d);",
	    $db->escape($this->id),
	    $db->escape($id, 1),
	    1
	);
	$result = $db->query($q2);
	return $result;
    }
    public function unfollow($id)
    {
        $db = Db::instance();   //create db connection
        $q = sprintf("DELETE FROM `relationships` WHERE follower_id = %d AND followee_id = %d;",
	    $db->escape($this->id),
	    $db->escape($id)
	);

	$result = $db->query($q);
	return $result;
    }
}

 ?>
