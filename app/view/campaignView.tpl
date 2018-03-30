<div id="view-campaign-menu">
  <a href="<?= BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Campaign: <?php echo $campaign->name; ?></h1>

  <table id="campaign" class="left">
	<tr>
		<td>Name:</td>
		<td> <?php echo $campaign->name; ?> </td>
	</tr>
	<tr>
		<td>Date:</td>
		<td> <?php echo $campaign->date; ?> </td>
    </tr>
	<tr>
		<td>Description:</td>
		<td> <?php echo $campaign->description; ?> </td>
    </tr>
  </table>
	<button id="edit-campaign-button">Edit Campaign </button>
	<button id="delete-campaign-button">Delete Campaign </button>
</div>

<div id="edit-campaign-menu">
  <a href="<?= BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Edit Campaign: <?php echo $campaign->name; ?></h1>

  <form  method="post">
  Name:<br />
  <input type = "text" name="name" value="<?php echo $campaign->name; ?>" /><br />
  Date:<br />
    <input type="date" name="date" value="<?php echo $campaign->date; ?>" /><br />
    Description:<br />
    <input type="text" name="description" value="<?php echo $campaign->description; ?>" /><br />
    <br />
	<button  id="updateCampaignEdit" name="updateCampaignEdit">Update</button> 
	<button  id="cancelCampaignEdit" name="cancelCampaignEdit">Cancel</button> 
  </form>
  

</div>