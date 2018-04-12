<div class="container users">
<?php
	$user = User::loadById($_SESSION['user_id']);
	//var_dump($user);
	$users = User::getUsers();
	foreach($users as $u)
	{

	echo "<div id='user_".$u->id."' class='user-table-content'>";
	echo "<a href='".BASE_URL."/users/view/".$u->id."'>";

	echo $u->firstName . " " . $u->lastName . "&nbsp;&nbsp;";

	echo "</a>"; 

	if($_SESSION['user_id'] && $u->id != $_SESSION['user_id'] && !in_array($u->id, $user->following)) {
	    echo "<button id='user_b_" . $u->id . "' onclick='follow(" . $_SESSION['user_id'] . ", ". $u->id .")'>Follow</button>";
	} else if($_SESSION['user_id'] && $u->id != $_SESSION['user_id'] && in_array($u->id, $user->following)) {
	    echo "<button id='user_b_" . $u->id . "' onclick='unfollow(" . $_SESSION['user_id'] . ", ". $u->id .")'>Un-follow</button>";
	}
	echo "</div>";

    }

?>
</div>
