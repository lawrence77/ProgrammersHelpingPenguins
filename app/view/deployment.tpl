<?php
		$campaigns = Campaign::getPeople();
		foreach($campaigns as $c)
		{
			//Replace with ajax call to get image
			echo "<div class='campaignItem'  data-campid=" . $c->id . " data-name='".$c->name."'></div>";
			echo "<div class='campaignDesc'  id='campaign" . $c->id . "' >
					<h3>".$c->name."</h3>
					<p>".$c->description."</p>
					</div>";
		}

		$crews = Crew::getCrews();
		foreach($crews as $cw)
		{
			//Replace with ajax call to get image
			echo "<div class='crewItem' data-partof='".implode(" ", $cw->getCampignsPartOf())."' data-crewid=" . $cw->id . " data-name='".$cw->bomberGroup . " " . $cw->provisionalWing."'></div>";
		}
	?>
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
<canvas id="demoCanvas" width="1600" height="1200" onload="drawBeforeMap()" >
</canvas>
<script type="text/javascript">drawBeforeMap();</script>
