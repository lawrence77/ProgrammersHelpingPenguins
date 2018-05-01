<div class="container">
    <?php if ($_SESSION['role'] <= 1): ?>
        <button id="newPersonButton" disabled type="button" name="newPersonButton">New Person</button>
    <?php endif; ?>
    <form id="newPersonForm">
        <p> First Name </p>
        <input id="newFirstName" name="firstName" type="text" placeholder="First Name" required><br>
        <p> Last Name </p>
        <input id="newLastName" name="lastName" type="text" placeholder="Last Name" required ><br>
        <p> Description </p>
        <textarea id="newDescription" name="description" rows="8" cols="80" required></textarea> <br>
        <p> Birth Date </p>
        <input id="newBirthDate" name="birthDate" type="date"><br>
        <p> Died On </p>
        <input id="newDeathDate" name="deathDate" type="date"><br>

        <button id="createNewPersonButton" name="createNewPersonButton"  type="button">Add</button>
        <button id="cancelNewPersonButton" name="cancelNewPersonButton" type="button">Cancel</button> <br>
    </form>
</div> <br>
<div class="container">
     	<?php
		$people = Person::getPeople();
		foreach($people as $p)
		{
            echo "<div class='row bomber-squad-content'><div class ='col-lg-8'><img src =".LINK_URL."/public/images/question.png class='crew-thumbnail'> </div>";
            echo "<div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'> <strong> $p->firstName  $p->lastName </strong></div>";
            if ($p->birthDate != null) {
                echo "<div class='bomber-squad-table-title'>Birth Date<div class='bomber-squad-table-content'>" . $p->birthDate . "</div></div>";
            }
            if ($p->deathDate != null) {
                echo "<div class='bomber-squad-table-title'> Died On <div class='bomber-squad-table-content'>" . $p->deathDate ."</div></div>";
            }
            echo "<div class='bomber-squad-table-title'>Description<div class='bomber-squad-table-content'>" . $p->description . "</div></div> </td> </tr> </table></div></div>";
        }
      ?>
</div>
