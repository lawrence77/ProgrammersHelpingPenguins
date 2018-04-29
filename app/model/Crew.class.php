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
    public $apiName = null;
	public $deleted = 0;

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
            $crew->apiName            = $row['apiName'];
			$crew->deleted			  = $row['deleted'];

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
				$crew = self::loadById($row['pkCrew']); //fetch all data based on pk
				if(!$crew->deleted)
				{
					$crewArray[] = $crew; //only fetch crews that are not deleted
				}
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
        $q = sprintf("INSERT INTO `%s` (`provisionalWing`, `bomberGroup`, `sent`, `losses`, `stationedAirfield`) VALUES (%s, %s, %s, %s, %s);",
            self::DB_TABLE,
            $db->escape($this->provisionalWing),
            $db->escape($this->bomberGroup),
            $db->escape($this->sent),
            $db->escape($this->losses),
            $db->escape($this->stationedAirfield)
        );
	/*
	$q = sprintf("INSERT INTO `%s` (`provisionalWing`, `bomberGroup`,
             `sent`, `losses`, `stationedAirfield`) VALUES
              ('%s', '%s', %s, %s, '%s');",
            self::DB_TABLE,
            $db->escape($this->provisionalWing),
            $db->escape($this->bomberGroup),
            $db->escape($this->sent),
            $db->escape($this->losses),
            $db->escape($this->stationedAirfield)
        );*/

        $db->query($q);
	$res = array('id' => $db->getInsertID(), 'query' => $q);
        return $res;
    }
    //deletes crew from SQL
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

		$q = sprintf("UPDATE %s SET `deleted` = 1 WHERE `pkCrew` = %d;",
            self::DB_TABLE,
            $this->id
        );
        /*$q = sprintf("DELETE FROM `%s`
            WHERE `pkCrew` = %d;",
            self::DB_TABLE,
            $this->id
        );*/
        $result = $db->query($q);
        return $result;
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
            WHERE `pkCrew` = %s;",
            self::DB_TABLE,
            $db->escape($this->provisionalWing),
            $db->escape($this->bomberGroup),
            $db->escape($this->trainingSchool),
            $db->escape($this->sent),
            $db->escape($this->losses),
            $db->escape($this->stationedAirfield),
            $this->id
        );

        $db->query($q); //execute query
		$res = array('id' => $this->id, 'query' => $q);
        return $res; //return this object's id
    }
	
	public function getCampignsPartOf()
    {
        $fArray = array();
        $db = Db::instance();   //create db connection
        $q = sprintf("SELECT campaignID FROM `crewspercampaign` WHERE crewID = %d;",
	    $db->escape($this->id)
		);
		$result = $db->query($q);
        if ($result->num_rows != 0) {       //traverse all pkCampaigns found from the query
            while ($row = $result->fetch_assoc()) {
	        $fArray[] = $row['campaignID'];
            }
		}
		return $fArray;
	}
	
	public function deploy($camp_id) {
		$db = Db::instance();   //create db connection
		//build query
        $q2 = sprintf("INSERT INTO `crewspercampaign` (`crewID`, `campaignID`) VALUES (%d, %d);",
	    $db->escape($this->id),
	    $db->escape($camp_id)
		);
	$result = $db->query($q2);
	return $result;
	}
	
	public function undeploy($camp_id) {
		$db = Db::instance();   //create db connection
		//build query
        $q2 = sprintf("DELETE FROM `crewspercampaign` WHERE crewID = %d AND campaignID = %d;",
	    $db->escape($this->id),
	    $db->escape($camp_id)
		);
	$result = $db->query($q2);
	return $result;
	}

    //Deletes a crew from the database
    /*public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();
        $q = sprintf("DELETE FROM `%s` WHERE `pkCrew` = %d;", self::DB_TABLE, $id);

        return $db->query($q);  //return true if successful, false otherwise
    }*/
}

 ?>
