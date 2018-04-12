<div class="campaign-list">
	<?php
		$campaigns = Campaign::getPeople();
		foreach($campaigns as $c)
		{
			//Replace with ajax call to get image
			echo "<span id='campaign_" . $c->id . "'>";
			echo "<h1><a href=\"".BASE_URL."/campaigns/view/".$c->id."\">".$c->name." </a></h1>";
			echo "<img class='campaign-thumbnail' src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg/1200px-B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg\" alt=\"pic of campaign\" />";
            if ($_SESSION['role'] == 0) {
	    		echo "<button onclick='deleteCampaign(". $c->id .")'>X</button>";
            }
			echo "</span>";
			echo "<br /><br />";
		}
	?>
</div>
<p>
<?php if ($_SESSION['role'] == 0): ?>
<div class="left-align">
	<button id="add-campaign-button" class="large"> Add new Campaign</button>
</div>
<?php endif; ?>
<div id="add-campaign-menu">

  <h1>Add Campaign</h1>

  <form method="post">
  Name:<br />
  <input id="newCampaignName" type = "text" name="name" value="" /><br />
  Date:<br />
    <input id="newCampaignDate" type="date" name="date" value="" /><br />
    Description:<br />
    <input id="newCampaignDescription" type="text" name="description" value="" /><br />
    <br />
	<button id="createNewCampaignButton" name="createNewCampaignButton"  type="button">Add</button>
    <button id="cancelNewCampaignButton" name="cancelNewCampaignButton" type="button">Cancel</button> <br>
  </form>


</div>
</p>
