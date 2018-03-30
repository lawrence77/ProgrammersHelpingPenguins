
<div class="container">
     	<?php
		$crews = Crew::getCrews();
		foreach($crews as $c)
		{
            
            echo "<div class='row bomber-sqaud-content'><div class ='col-lg-8'><img src ='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='crew-thumbnail'> </div>";
            echo "<div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'><a href='$BASE_URL/crews/$c->id'>Bomber Group  $c->bomberGroup  </a> </div>";
            echo "<div class='bomber-squad-table-title'>Training School <div class='bomber-squad-table-content'>" . $c->trainingSchool . "</div></div>";
            echo "<div class='bomber-squad-table-title'>Provisional Wing <div class='bomber-squad-table-content'>" . $c->provisionalWing ."</div></div>";
            echo "<div class='bomber-squad-table-title'>Stationed Airfield<div class='bomber-squad-table-content'>" . $c->stationedAirfield . "</div></div> </td> </tr> </table></div></div>";
        }
      ?>
</div>
