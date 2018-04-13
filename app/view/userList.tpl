<div class="container users">
<?php
	var_dump($_SESSION);
	$id = $_SESSION['user_id'];
	if(is_array($id))
	    $id = $id['id'];
	$user = User::loadById($id);

	$users = User::getUsers();
	foreach($users as $u)
	{

	echo "<div id='user_".$u->id."' class='user-table-content'>";
	echo "<a href='".BASE_URL."/users/view/".$u->id."'>";

	echo $u->firstName . " " . $u->lastName . "&nbsp;&nbsp;";

	echo "</a>"; 
	
	
	if($id && $u->id != $id && !in_array($u->id, $user->following)) {
	    echo "<button id='user_b_" . $u->id . "' onclick='follow(" . $id . ", ". $u->id .")'>Follow</button>";
	} else if($id && $u->id != $id && in_array($u->id, $user->following)) {
	    echo "<button id='user_b_" . $u->id . "' onclick='unfollow(" . $id . ", ". $u->id .")'>Un-follow</button>";
	}
	echo "</div>";

    }

?>
</div>
