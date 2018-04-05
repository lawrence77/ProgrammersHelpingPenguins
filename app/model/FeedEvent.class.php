<?php

class FeedEvent {
  const DB_TABLE = 'feed_event'; // database table name

  // database fields for this table
  public $id = 0;
  public $type = '';
  public $creator_id = 0;
  public $item_1_id = null;
  public $item_2_id = null;
  public $item_3_id = null;
  public $data_1 = null;
  public $data_2 = null;
  public $date_created = 0;

  // return object by ID
  public static function loadById($id) {
      $db = Db::instance(); // create db connection
      // build query
      $q = sprintf("SELECT * FROM `%s` WHERE id = %d;",
        self::DB_TABLE,
        $id
        );
      $result = $db->query($q); // execute query
      // make sure we found something
      if($result->num_rows == 0) {
        return null;
      } else {
        $row = $result->fetch_assoc(); // get results as associative array

        $fe = new FeedEvent(); // instantiate new object

        // store db results in local object
        $fe->id           = $row['id'];
        $fe->type         = $row['type'];
        $fe->creator_id   = $row['creator_id'];
        $fe->item_1_id    = $row['item_1_id'];
        $fe->item_2_id    = $row['item_2_id'];
        $fe->item_3_id    = $row['item_3_id'];
        $fe->data_1       = $row['data_1'];
        $fe->data_2       = $row['data_2'];
        $fe->date_created = $row['date_created'];

        return $fe; // return the object
      }
  }

  public static function getFeedEvents($limit = null) {
    $db = Db::instance(); // create db connection
    // build query
    $q = sprintf("SELECT id FROM `%s` ORDER BY date_created DESC ",
      self::DB_TABLE
      );
    if($limit !== null)
      $q .= " LIMIT ".$limit;
    $result = $db->query($q); // retrieve results

    $objects = array();
    if($result->num_rows != 0) {
      while($row = $result->fetch_assoc()) {
        $objects[] = self::loadById($row['id']);
      }
    }
    return $objects;
  }

  public function save(){
    if($this->id == 0) {
      return $this->insert(); // soldier is new and needs to be created
    } else {
      return $this->update(); // soldier already exists and needs to be updated
    }
  }

  public function insert() {
    if($this->id != 0)
      return null; // can't insert something that already has an ID

    $db = Db::instance(); // connect to db
    // build query

    $q = sprintf("INSERT INTO `%s` (
        `type`,
        `creator_id`,
        `item_1_id`,
        `item_2_id`,
        `item_3_id`,
        `data_1`,
        `data_2`
      ) VALUES (%s, %d, %d, %d, %d, %s, %s);",
      self::DB_TABLE,
      $db->escape($this->type),
      $db->escape($this->creator_id),
      $db->escape($this->item_1_id),
      $db->escape($this->item_2_id),
      $db->escape($this->item_3_id),
      $db->escape($this->data_1),
      $db->escape($this->data_2)
      );
    //echo $q;
    $db->query($q); // execute query
    $this->id = $db->getInsertID(); // set the ID for the new object
    return $this->id;
  }

  public function update() {}

}
