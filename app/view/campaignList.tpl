<div id="campaign-list">
	<?php
		$campaigns = Campaign::getPeople();
		foreach($campaigns as $c)
		{
			echo "<div class=\"left-box\">";
			//Replace with ajax call to get image
			echo "<img class=\"thumbnail\" src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg/1200px-B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg\" alt=\"pic of campaign\" />";
			echo "</div>";
			echo "<div class=\"right-box\">";
			echo "<h1> <a href=\"".BASE_URL."/campaigns/view/".$c->id."\">Campaign: ".$c->name." </a></h1>";
			echo "</div>";
		}
	?>
</div>
<button id="add-campaign-button" class="large"> Add new Campaign</button>

<div id="add-campaign-menu" class="hide" style="display:none">

  <h1>Add Campaign</h1>

  <form method="post">
  Name:<br />
  <input type = "text" name="name" value="" /><br />
  Date:<br />
    <input type="date" name="date" value="" /><br />
    Description:<br />
    <input type="text" name="description" value="" /><br />
    <br />
  </form>
  <button id="createNewCampaignButton" name="createNewCampaignButton"  type="button">Add</button>
    <button id="cancelNewCampaignButton" name="cancelNewCampaignButton" type="button">Cancel</button> <br>

</div>