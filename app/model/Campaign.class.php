<?php

/**
 * Campaign class for handling CRUD methods for the Campaigns table
 */
class Campaign {
    const DB_TABLE = 'Campaigns';     //database table name

    //database table fields
    public $id = 0;
    public $name = '';
    public $date = '';
    public $description = '';

    //gets a campaign by a primary key
    public static function loadById($id)
    {
        $db = Db::instance();   //database connection

        //build query
        $q = sprintf("SELECT * FROM `%s` WHERE pkCampaign = %d;",
            self::DB_TABLE,
            $id
        );
        $result = $db->query($q); //execute query

        if ($result->num_rows == 0) {
            return null;    //no user
        } else {
            $row = $result->fetch_assoc(); //get results as associative array
            $campaign = new Campaign();

            //store db results
            $campaign->id                 = $row['pkCampaign'];
            $campaign->name               = $row['name'];
            $campaign->date               = $row['date'];
            $campaign->description        = $row['description'];

            return $campaign;   //return filled campaign info
        }
    }
    //get all campaigns in the database
    public static function getPeople()
    {
        $db = Db::instance();   //db connection
        $q = sprintf("SELECT pkCampaign FROM `%s` ORDER BY date ASC;", self::DB_TABLE);
        $result = $db->query($q);

        $campaignArray = array();
        if ($result->num_rows != 0) {       //traverse all pkCampaigns found from the query
            while ($row = $result->fetch_assoc()) {
                $campaignArray[] = self::loadById($row['pkCampaign']); //fetch all data based on pk
            }
        }
        return $campaignArray;
    }
    //inserts or updates a campaign into the database
    public function save()
    {
        if ($this->id == 0) {
            return $this->insert();     //new campaign
        } else {
            return $this->update();     //updating existing campaign
        }
    }
    //saves a new campaign into the database
    public function insert()
    {
        if ($this->id != 0) {
            return null;    //can't insert something that already has an Id
        }

        $db = Db::instance(); //connect to db

        $q = sprintf("INSERT INTO `%s` (`name`, `date`, `description`) VALUES
         (%s, %s, %s);",
            self::DB_TABLE,
            $db->escape($this->name),
            $db->escape($this->date),
            $db->escape($this->description)
        );

        $db->query($q);
		$res = array('id' => $db->getInsertID(), 'query' => $q);
        return $res;
    }
    //saves changes to an existing campaign in the database
    public function update()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("UPDATE `%s` SET
            `name` = %s,
            `date` = %s,
            `description` = %s
            WHERE `pkCampaign` = %d;",
            self::DB_TABLE,
            $db->escape($this->name),
            $db->escape($this->date),
            $db->escape($this->description),
            $db->escape($this->id)
        );

        $db->query($q); //execute query
        return $db->id; //return this object's id
    }

    //deletes crew from SQL
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();

        $q = sprintf("DELETE FROM `%s`
            WHERE `pkCampaign` = %d;",
            self::DB_TABLE,
            $this->id
        );
        $result = $db->query($q);
        return $result;
    }
    /*
    //Deletes a campaign from the database.
    public function delete()
    {
        if ($this->id == 0)
            return null;

        $db = Db::instance();
        $q = sprintf("DELETE FROM `%s` WHERE `pkCampaign` = %d;", self::DB_TABLE, $id);

        return $db->query($q);  //return true if successful, false otherwise
    }*/
}

 ?>
