<div class="container">
    <button id="newCrewButton" type="button" name="newCrewButton">New Bomber Group</button>
    <form id="newCrewForm">
        <p> Provisional Wing </p>
        <input id="newCrewWing" name="wing" type="text" placeholder="Provisional Wing" required><br>
        <p> Bomber Group </p>
        <input id="newCrewGroup" name="group" type="text" placeholder="Bomber Group" required ><br>
        <p> Stationed Airfield </p>
        <input id="newCrewAirfield" name="airfield" type="text" placeholder="Airfield" required><br>
        <p> Sent </p>
        <input id="newCrewSent" name="sent" type="number" placeholder="Aircraft Sent" required ><br>
        <p> Lost </p>
        <input id="newCrewLost" name="lost" type="number" placeholder="Aircraft Lost" required><br>

        <button id="createNewCrewButton" name="createNewCrewButton"  type="button">Add</button>
        <button id="cancelNewCrewButton" name="cancelNewCrewButton" type="button">Cancel</button> <br>
    </form>
</div> <br>
<div class="container crews">
     	<?php
		$crews = Crew::getCrews();
		foreach($crews as $c)
		{

            echo "<div class='row bomber-sqaud-content' id='bomber_". $c->id ."'><div class ='col-lg-8 bomber-img'><img src ='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='crew-thumbnail'> </div>";
            echo "<div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'><a href='".BASE_URL."/crews/$c->id'> <strong>$c->bomberGroup</strong> </a> </div>";
            echo "<div class='bomber-squad-table-title'>Provisional Wing <div class='bomber-squad-table-content'>" . $c->provisionalWing ."</div></div>";
            echo "<div class='bomber-squad-table-title'>Stationed Airfield<div class='bomber-squad-table-content'>" . $c->stationedAirfield . "</div></div>";
	    echo "</td> </tr> </table><button onclick='deleteCrew(". $c->id .")'>X</button> </div></div><br/><br/>";
        }
      ?>
</div>
