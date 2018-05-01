<div class="left-align">
	<button id="add-campaign-button" class="btn btn-info">New Campaign</button>
</div>
<div id="add-campaign-menu">

  <form method="post">
  <br><br>Name<br>
  <input id="newCampaignName" type = "text" name="name" placeholder="Name" /><br />
  <br>Date<br>
    <input id="newCampaignDate" type="date" name="date" value="" /><br />
    <br>Description<br>
    <input id="newCampaignDescription" type="text" name="description" value="" placeholder="Description"/><br />
    <br />
	<button id="createNewCampaignButton" name="createNewCampaignButton"  type="button" class="btn btn-success">Add</button>
    <button id="cancelNewCampaignButton" name="cancelNewCampaignButton" type="button" class="btn btn-warning">Cancel</button> <br>
  </form>


</div>
<div class="campaign-list">
	<?php
		$campaigns = Campaign::getPeople();
		foreach($campaigns as $c)
		{
			//Replace with ajax call to get image
			echo "<span id='campaign_" . $c->id . "'>";
			echo "<h1><a href=\"".BASE_URL."/campaigns/view/".$c->id."\">".$c->name." </a></h1>";
			echo "<img class='campaign-thumbnail' src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg/1200px-B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg\" alt=\"pic of campaign\" />";
            if ($_SESSION['role'] <= 1) {
	    		echo "<br><br><button onclick='deleteCampaign(". $c->id .")' class='btn btn-danger'>Remove</button>";
            }
			echo "</span>";
			echo "<br /><br />";
		}
	?>
</div>
<p>
<?php if ($_SESSION['role'] <= 1): ?>
<?php endif; ?>
</p>
