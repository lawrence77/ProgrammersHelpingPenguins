<?php include_once 'view/helpers.php' ?>

<div class="container">
    <div class="row">
        <div class="col-sm-6 col-lg-6 my-profile ">
    		<h3> <span class="tdFirstName"><?php echo $user->firstName; ?> </span> <span class="tdLastName"><?php echo $user->lastName; ?></span> </h3>
            <!--<img src="../public/images/question.png" id ="profilepic">-->
            <table class="table-striped profile-info">
                <tr><th>First Name</th><td class="tdFirstName"> <?= $user->firstName ?> </td></tr>
                <tr><th>Last Name</th><td class="tdLastName"><?php echo $user->lastName; ?></td></tr>
                <tr><th>Age</th><td class="tdAge"><?php echo $user->age; ?></td></tr>
                <?php if ($_SESSION['role'] == 0) : ?>
                    <tr><th>Username</th><td class="tdUsername" ><?php echo $user->username; ?></td></tr>
                    <tr><th>Password</th><td class="tdPassword" ><?php echo $user->password; ?></td></tr>
                    <?php
                        function determineRole($user) {
                            $stringRole;
                            if ($user->role == 0) {
                                $stringRole = "Admin";
                            } else if ($user->role == 1) {
                                $stringRole = "Historian";
                            } else {
                                $stringRole = "Registered User";
                            }
                            return $stringRole;
                        }
                    ?>
                    <tr><th>Role</th><td class="tdRole"><?php echo determineRole($user); ?>
                <?php endif; ?>
            </table>
            <div class="col-sm-6 col-lg-6 my-profile"><br><br>
                <?php if($_SESSION['user_id'] == $user->id): ?>
                    <button id="editProfileButton" class ="btn btn-info button-padding">Edit My Profile</button>
                <?php elseif ($_SESSION['role'] == 0): ?>
                    <button id="editProfileButton" class ="btn btn-info button-padding">Edit This Profile</button>
                <?php endif; ?>
                <form id="editProfileForm" style="display:none;">
                    <input id="sameUsername" style="display:none" type="text" name="username" value="<?= $user->username ?>">
                    <p> First Name </p>
                    <input id="updateFirstName" name="firstName" type="text" placeholder="New First Name" required><br>
                    <p> Last Name </p>
                    <input id="updateLastName" name="lastName" type="text" placeholder="New Last Name" required ><br>
                    <p> Age </p>
                    <input id="updateAge" name="age" type="number" placeholder="New Age" required ><br>
                    <p> Password </p>
                    <input id="updatePassword" name="password" type="password" placeholder="New Password" required><br>
                    <p> Role </p>
                    <?php if ($_SESSION['role'] == 0): ?>
                        <input id="adminRole" type="radio" class="radioRole" name="role" value="0" checked="checked">
                        <label for="adminRole">Admin</label> <br>
                        <input id="historianRole" type="radio" class="radioRole" name="role" value="1" >
                        <label for="historianRole">Historian</label> <br>
                        <input id="registeredRole" type="radio" class="radioRole" name="role" value="2" >
                        <label for="registeredRole">Registered</label> <br>
                    <?php elseif ($_SESSION['role'] == 1): ?>
                        <input id="historianRole" type="radio" class="radioRole" name="role" value="1" checked style="display:none;">
                        <label for="historianRole">You're a Historian!</label> <br>
                    <?php else: ?>
                        <input id="registeredRole" type="radio" class="radioRole" name="role" value="2" checked style="display:none;">
                        <label for="registeredRole">You're a Registered User!</label> <br>
                    <?php endif; ?>
                    <br>
                    <button id="updateProfileButton" name="updateProfileButton" value="<?= $user->id ?>" type="button">Update</button>
                    <button id="cancelProfileButton" name="cancelProfileButton" type="button">Cancel</button> <br>
                </form>
            </div>
        </div>
        <div class="col-sm-6 col-lg-12 profile-inner-contents">
            <!--
            add the activity feed here
            -->
            <h3>Recent Activity</h3>

            <?php if(empty($fes)): ?>
                <p>No events yet.</p>
            <?php else: ?>
		<table class="table table-striped">
                <?php foreach($fes as $fe): ?>
            	    <?php if($fe->creator_id===$user->id): ?>
			<tr>
				<td>
				<?= formatEvent($fe) ?>
				</td>
			</tr>
            	       <?php endif; ?>
                <?php endforeach; ?>
		</table>
            <?php endif; ?>
        </div>
    </div>
</div>
