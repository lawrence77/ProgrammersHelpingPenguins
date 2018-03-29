
<div class="container">
     	<?php
		$crews = Crew::getPeople();
		foreach($crews as $c)
		{
            echo "<div class =\"row bomber-sqaud-content\"><div class =\"col-lg-8\"><img src =\"../../public/images/question.png\" class =\"crew-thumbnail\"> </div>";
            echo "<div class =\"col-lg-4\"> <table><tr><td> <div class=\"bomber-table-title\"> Provisional-Wing <div class=\"bomber-table-content\">". $c-> provisionalWing "</div></div>";
            echo "<div class=\"bomber-squad-table-title\">Training School <div class=\"bomber-squad-table-content\">" . "TRAININGININ SCHool" ."</div></div>";
            echo "<div class=\"bomber-squad-table-title\">Bomber Group <div class=\"bomber-squad-table-content\">" . $c->bomberGroup ."</div></div>";
            echo "<div class=\"bomber-squad-table-title\">Stationed Airfield<div class=\"bomber-squad-table-content\">" . $c->stationedAirfield . "</div></div> </td> </tr> </table></div></div>";
        }
      ?>
</div>