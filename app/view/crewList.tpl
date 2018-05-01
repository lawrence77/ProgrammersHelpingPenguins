<body>
<div class="container">
    <?php if ($_SESSION['role'] <= 1): ?>
        <button id="newCrewButton" type="button" name="newCrewButton" class="btn btn-info">New Bomber Group</button>
    <?php endif; ?>
    <form id="newCrewForm">
        Provisional Wing<br>
        <input id="newCrewWing" name="wing" type="text" placeholder="Provisional Wing" required><br>
        <br>Bomber Group<br>
        <input id="newCrewGroup" name="group" type="text" placeholder="Bomber Group" required ><br>
        <br>Stationed Airfield<br>
        <input id="newCrewAirfield" name="airfield" type="text" placeholder="Airfield" required><br>
        <br>Sent<br>
        <input id="newCrewSent" name="sent" type="number" placeholder="Aircraft Sent" required ><br>
        <br>Lost<br>
        <input id="newCrewLost" name="lost" type="number" placeholder="Aircraft Lost" required><br>
	<br>

        <button id="createNewCrewButton" name="createNewCrewButton"  type="button" class="btn btn-success">
	Add</button>

        <button id="cancelNewCrewButton" name="cancelNewCrewButton" type="button" class="btn btn-warning">Cancel</button> <br>
    </form>
</div> <br>
<div class="container crews">
        <!--getPicture($(this).find('img').attr('alt'), $(this).find('img'))-->
     	<?php
		$crews = Crew::getCrews();
		foreach($crews as $c)
		{

            echo "<div class='row bomber-sqaud-content' id='bomber_". $c->id ."'>";
	    echo "<div class='divPicture col-lg-8 bomber-img'><img src='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='loadPicture crew-thumbnail' alt='$c->apiName'></div>";
                    echo "<div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'><a href='".BASE_URL."/crews/$c->id'> <strong>$c->bomberGroup</strong> </a> </div>";
            echo "<div class='bomber-squad-table-title'>Provisional Wing <div class='bomber-squad-table-content'>" . $c->provisionalWing ."</div></div>";
            echo "<div class='bomber-squad-table-title'>Stationed Airfield<div class='bomber-squad-table-content'>" . $c->stationedAirfield . "</div></div>";
            echo "</td> </tr> </table>";
            if ($_SESSION['role'] <= 1) {
                echo "<button class='btn btn-danger' onclick='deleteCrew(". $c->id .")'>Remove</button>";
            }
            echo "</div></div><br/><br/>";
        }
      ?>
<script>
   /* $('.loadPicture').each(function (e) {
        getPicture($(this).attr('alt'), $(this));
    });*/
</script>
</div>
</body>
