<div class="container users">
     	<?php
		$users = User::getUsers();
		foreach($users as $u)
		{

            echo "<a href='".BASE_URL."/users/view/".$u->id."'><div class='user-table-content'>" . $u->firstName . " " . $u->lastName ."</div></a>";
        }
      ?>
</div>
