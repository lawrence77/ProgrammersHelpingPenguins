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
  <?php if ($_SESSION['role'] == 0): ?>
	<button id="edit-campaign-button">Edit Campaign </button>
  <?php endif; ?>
	<!-- <button id="delete-campaign-button" name="delete-campaign-button" value="<?php echo $campaign->id; ?>">Delete Campaign </button> -->
</div>

<div id="edit-campaign-menu">
  <a href="<?= BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Edit Campaign: <?php echo $campaign->name; ?></h1>

  <form  method="post">
  Name:<br />
  <input id="editCampaignName" type = "text" name="name" value="<?php echo $campaign->name; ?>" /><br />
  Date:<br />
    <input id="editCampaignDate" type="date" name="date" value="<?php echo $campaign->date; ?>" /><br />
    Description:<br />
    <input id="editCampaignDescription" type="text" name="description" value="<?php echo $campaign->description; ?>" /><br />
    <br />
	<button  id="updateCampaignEdit" name="updateCampaignEdit" value="<?php echo $campaign->id; ?>" type="button">Update</button>
	<button  id="cancelCampaignEdit" name="cancelCampaignEdit" type="button">Cancel</button>
  </form>


</div>
