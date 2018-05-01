<?php

/**
 * Person class for handling CRUD methods for the People table
 */
class Person {
    const DB_TABLE = 'people';     //database table name

    //database table fields
    public $id = 0;
    public $firstName = '';
    public $lastName = '';
    public $description = '';
    public $birthDate = null;
    public $deathDate = null;

    //gets a person by a primary key
    public static function loadById($id)
    {
        $db = Db::instance();   //database connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE pkPerson = %d;",
            self::DB_TABLE,
            $id
        );
        $result = $db->query($q); //execute query

        if ($result->num_rows == 0) {
            return null;    //no user
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $person = new Person();

            //store db results
            $person->id                 = $row['pkPerson'];
            $person->firstName          = $row['firstName'];
            $person->lastName           = $row['lastName'];
            $person->birthDate          = $row['birthdate'];
            $person->deathDate          = $row['deathdate'];
            $person->description        = $row['description'];

            return $person;   //return filled person info
        }
    }
    //get all people in the database
    public static function getPeople()
    {
        $db = Db::instance();   //db connection
        $q = sprintf("SELECT pkPerson FROM `%s` ORDER BY lastName ASC;", self::DB_TABLE);
        $result = $db->query($q);

        $peopleArray = array();
        if ($result->num_rows != 0) {       //traverse all pkRecords found from the query
            while ($row = $result->fetch_assoc()) {
                $peopleArray[] = self::loadById($row['pkPerson']); //fetch all data based on pk
            }
        }

        return $peopleArray;
    }
    //inserts or updates a person into the database
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();     //new record
        } else {
            return $this->update();     //updating existing record
        }
    }
    //saves a new person into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`firstName`, `lastName`, `birthDate`,
            `deathDate`, `description`) VALUES (%s, %s, %s, %s, %s);",
            self::DB_TABLE,
            $db->escape($this->firstName),
            $db->escape($this->lastName),
            $db->escape($this->birthDate),
            $db->escape($this->deathDate),
            $db->escape($this->description)
        );

        $db->query($q);
        return $db->getInsertID();
    }
    //saves changes to an existing person in the database
    public function update()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("UPDATE `%s` SET
            `firstName` = %s,
            `lastName` = %s,
            `birthDate` = %s,
            `deathDate` = %s,
            `description` = %s
            WHERE `pkPerson` = %d;",
            self::DB_TABLE,
            $db->escape($this->firstName),
            $db->escape($this->lastName),
            $db->escape($this->birthDate),
            $db->escape($this->deathDate),
            $db->escape($this->description),
            $db->escape($this->id)
        );

        $db->query($q); //execute query
        return $db->id; //return this object's id
    }

    //Deletes a person from the database. Currently not accessible from anywhere in the webapp
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();
        $q = sprintf("DELETE FROM `%s` WHERE `pkPerson` = %d;", self::DB_TABLE, $id);

        return $db->query($q);  //return true if successful, false otherwise
    }
}

 ?>
