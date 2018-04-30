<?php

/**
 * Training School class for handling CRUD methods for the School table
 */
class TrainingSchool {
    const DB_TABLE = 'TrainingSchool';     //database table name

    //database table fields
    public $id = 0;
    public $name = '';
    public $duration = null;
    public $description = '';
    public $level = '';

    //gets a school by a primary key
    public static function loadById($id)
    {
        $db = Db::instance();   //database connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE pkSchool = %d;",
            self::DB_TABLE,
            $id
        );
        $result = $db->query($q); //execute query

        if ($result->num_rows == 0) {
            return null;    //no user
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $school = new TrainingSchool();

            //store db results
            $school->id                 = $row['pkPerson'];
            $school->name               = $row['name'];
            $school->duration           = $row['duration'];
            $school->description        = $row['description'];
            $school->level              = $row['levelNumber'];

            return $school;   //return filled school info
        }
    }
    //get all schools in the database
    public static function getPeople()
    {
        $db = Db::instance();   //db connection
        $q = sprintf("SELECT pkSchool FROM `%s` ORDER BY levelNumber ASC;", self::DB_TABLE);
        $result = $db->query($q);

        $schoolArray = array();
        if ($result->num_rows != 0) {       //traverse all pkSchools found from the query
            while ($row = $result->fetch_assoc()) {
                $schoolArray[] = self::loadById($row['pkSchool']); //fetch all data based on pk
            }
        }

        return $schoolArray;
    }
    //inserts or updates a school into the database
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();     //new record
        } else {
            return $this->update();     //updating existing record
        }
    }
    //saves a new school into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`name`, `duration`, `description`,
            `levelNumber`) VALUES (%s, %s, %s, %s);",
            self::DB_TABLE,
            $db->escape($this->name),
            $db->escape($this->duration),
            $db->escape($this->description),
            $db->escape($this->level)
        );

        $db->query($q);
        return $db->getInsertID();
    }
    //saves changes to an existing school in the database
    public function update()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("UPDATE `%s` SET
            `name` = %s,
            `duration` = %s,
            `description` = %s,
            `levelNumber` = %s
            WHERE `pkSchool` = %d;",
            self::DB_TABLE,
            $db->escape($this->name),
            $db->escape($this->duration),
            $db->escape($this->description),
            $db->escape($this->level),
            $db->escape($this->id)
        );

        $db->query($q); //execute query
        return $db->id; //return this object's id
    }

    //Deletes a school from the database. Currently not accessible from anywhere in the webapp
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();
        $q = sprintf("DELETE FROM `%s` WHERE `pkSchool` = %d;", self::DB_TABLE, $id);

        return $db->query($q);  //return true if successful, false otherwise
    }
}

 ?>
