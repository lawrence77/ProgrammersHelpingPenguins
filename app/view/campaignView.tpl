<div id="view-menu">
  <a href="<?= $BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Campaign: <?php echo $campaign['name']; ?></h1>

  <table id="campaign" class="left">
	<tr>
		<td>Name:</td>
		<td> <?php echo $campaign['name']; ?> </td>
	</tr>
	<tr>
		<td>Date:</td>
		<td> <?php echo $campaign['date']; ?> </td>
    </tr>
	<tr>
		<td>Description:</td>
		<td> <?php echo $campaign['description']; ?> </td>
    </tr>
  </table>
	<button onClick="$('#edit-menu').toggle()" id="edit-campaign-button">Edit Campaign </button>

</div>

<div id="edit-menu" class="hide">
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
  <button onClick="$('#edit-menu').toggle()" id="cancle-edit">Cancle </button> 

</div>
<div id="delete-menu">
	<button id="delete-campaign-button">Delete Campaign </button>
</div>