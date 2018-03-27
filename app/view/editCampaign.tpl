<div id="main-content">
  <a href="<?= $BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Edit Campaign: <?php echo $campaign['name']; ?></h1>

  <?php echo display_errors($errors); ?>
  <form action ="edit?id=<?php echo $campaign['id']; ?>" method="post">
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