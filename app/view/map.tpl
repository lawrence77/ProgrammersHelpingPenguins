<?php
		$campaigns = Campaign::getPeople();
		foreach($campaigns as $c)
		{
			//Replace with ajax call to get image
			echo "<div id='campaign_" . $c->id . "' data-name='".$c->name."'></div>";
		}
		
		$crews = Crew::getCrews();
		foreach($crews as $cw)
		{
			//Replace with ajax call to get image
			echo "<div id='crew_" . $cw->id . "' data-name='".$cw->bomberGroup . " " . $cw->provisionalWing."'></div>";
		}
	?>
<canvas id="beforeRaid" height="524" width="1440" ></canvas>