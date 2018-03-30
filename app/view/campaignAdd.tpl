<div id="main-content">
  <a href="<?= $BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Add Campaign</h1>

  <form method="post">
  Name:<br />
  <input type = "text" name="name" value="<?php echo $campaign['name']; ?>" /><br />
  Date:<br />
    <input type="text" name="date" value="<?php echo $campaign['date']; ?>" /><br />
    Description:<br />
    <input type="text" name="description" value="<?php echo $campaign['description']; ?>" /><br />
    <br />
    <input type="submit" name="submit" value="Update"  />
  </form>

</div>