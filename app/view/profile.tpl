<?php include_once 'view/helpers.php' ?>

<div class="container">
    <div class="row">
    <div class="col-sm-6 col-lg-6 my-profile ">
		<h3><?php echo $user->firstName; ?> <?php echo $user->lastName; ?></h3>
        <img src="../public/images/question.png" id ="profilepic">
        <?php if($_SESSION['role'] ==0 or $_SESSION['user_id'] == $user->id): ?>
            <button id="small-button" class ="button-padding">Edit profile Pic</button>
        <?php endif; ?>
        <table>
            <tr><th>First Name</th><td><?php echo $user->firstName; ?></td></tr>
              <tr><th>Last Name</th><td><?php echo $user->lastName; ?></td></tr>
              <tr><th>Age</th><td><?php echo $user->age; ?></td></tr>
              <?php if ($_SESSION['role'] == 0) : ?>
                  <tr><th>Username</th><td><?php echo $user->username; ?></td></tr>
                  <tr><th>Password</th><td><?php echo $user->password; ?></td></tr>
              <?php endif; ?>
        </table>
        <?php if($_SESSION['user_id'] != $user->id):?>
        <form method="post" action="">
            <button type="submit">Follow</button>
        </form>
        <?php endif; ?>
        </div>
        <div class="col-sm-6 col-lg-12 profile-inner-contents">
           <!--
            add the activity feed here

            -->
            <h3>Recent Activity</h3>

            <?php if(empty($fes)): ?>
            <p>No events yet.</p>
            <?php else: ?>
            <ul>
            <?php foreach($fes as $fe): ?>
			<?php if($fe->creator_id===$user->id): ?>
            <li><?= formatEvent($fe) ?></li>
			<?php endif; ?>
                <?php endforeach; ?>
            </ul>
            <?php endif; ?>
        </div>



    </div>
    </div>
