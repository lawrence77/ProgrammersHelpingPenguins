
<div class="container">
     	<?php
		$crews = Crew::getPeople();
		foreach($crews as $c)
		{
        
            echo "<div class =\"row bomber-sqaud-content\"><div class =\"col-lg-8\"><img src =" . c['imageSource'] . " class =\"crew-thumbnail\"> </div>";
            echo "<div class =\"col-lg-4\"> <table><tr><td> <div class=\"bomber-table-title\"> Air Force <div class=\"bomber-table-content\">". c['division']. "</div></div>";
            echo "<div class=\"bomber-squad-table-title\">Type <div class=\"bomber-squad-table-content\">" . c['type'] ."</div></div>";        
            echo "<div class=\"bomber-squad-table-title\">Type category <div class=\"bomber-squad-table-content\">" . $c['typeCategory'] . "</div></div>";
            echo "<div class=\"bomber-squad-table-title\">Nicknames<div class=\"bomber-squad-table-content\">" . $c['nicknames'] . "</div></div> </td> </tr> </table></div></div>";
        }
      ?>
</div>