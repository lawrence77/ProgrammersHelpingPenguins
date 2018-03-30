<?php

/**
 * Crew class for handling CRUD methods for the Crews table
 */
class Crew {
    const DB_TABLE = 'Crews';     //database table name

    //database table fields
    public $id = 0;
    public $provisionalWing = '';
    public $bomberGroup = '';
    public $trainingSchool = null;
    public $sent = '';
    public $losses = '';
    public $stationedAirfield = '';

    //gets a crew by a primary key
    public static function loadById($id)
    {
        $db = Db::instance();   //database connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE pkCrew = %d;",
            self::DB_TABLE,
            $id
        );
        $result = $db->query($q); //execute query

        if ($result->num_rows == 0) {
            return null;    //no crew
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $crew = new Crew();

            //store db results
            $crew->id                 = $row['pkCrew'];
            $crew->provisionalWing    = $row['provisionalWing'];
            $crew->bomberGroup        = $row['bomberGroup'];
            $crew->trainingSchool     = $row['trainingSchool'];
            $crew->sent               = $row['sent'];
            $crew->losses             = $row['losses'];
            $crew->stationedAirfield  = $row['stationedAirfield'];

            return $crew;   //return filled crew info
        }
    }
    //get all crew in the database
    public static function getCrews()
    {
        $db = Db::instance();   //db connection
        $q = sprintf("SELECT pkCrew FROM `%s` ORDER BY provisionalWing ASC;", self::DB_TABLE);
        $result = $db->query($q);

        $crewArray = array();
        if ($result->num_rows != 0) {       //traverse all pkCrew found from the query
            while ($row = $result->fetch_assoc()) {
                $crewArray[] = self::loadById($row['pkCrew']); //fetch all data based on pk
            }
        }
        return $crewArray;
    }
    //inserts or updates a crew into the database
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();     //new crew
        } else {
            return $this->update();     //updating existing crew
        }
    }
    //saves a new crew into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`provisionalWing`, `bomberGroup`,
             `trainingSchool`, `sent`, `losses`, `stationedAirfield`) VALUES
              (%s, %s, %d, %d, %d, %s);",
            self::DB_TABLE,
            $db->escape($this->provisionalWing),
            $db->escape($this->bomberGroup),
            $db->escape($this->trainingSchool),
            $db->escape($this->sent),
            $db->escape($this->losses),
            $db->escape($this->stationedAirfield)
        );

        $db->query($q);
        return $db->getInsertID();
    }
    //saves changes to an existing crew in the database
    public function update()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("UPDATE `%s` SET
            `provisionalWing` = %s,
            `bomberGroup` = %s,
            `trainingSchool` = %s,
            `sent` = %s,
            `losses` = %s,
            `stationedAirfield` = %s
            WHERE `pkCrew` = %d;",
            self::DB_TABLE,
            $db->escape($this->provisionalWing),
            $db->escape($this->bomberGroup),
            $db->escape($this->trainingSchool),
            $db->escape($this->sent),
            $db->escape($this->losses),
            $db->escape($this->stationedAirfield),
            $db->escape($this->id)
        );

        $db->query($q); //execute query
        return $db->id; //return this object's id
    }

    //Deletes a crew from the database
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();
        $q = sprintf("DELETE FROM `%s` WHERE `pkCrew` = %d;", self::DB_TABLE, $id);

        return $db->query($q);  //return true if successful, false otherwise
    }
}

 ?>
