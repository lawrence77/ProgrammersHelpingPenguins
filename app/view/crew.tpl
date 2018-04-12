<div class="container">
    <h2>Bomber-squad</h2>

    <div class ="row bomber-sqaud-content">
        <div class="divPicture col-lg-8">
            <img class="loadPicture crew-thumbnail" src="https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w" alt="<?= $crew->apiName?>" >
    </div>
        <div class ="col-lg-4">
            <table>
                <tr>
                    <td>
                        <div class="bomber-table-title">Bomber Group
                            <div class="bomber-table-content"><?php echo $crew->bomberGroup; ?></div>
                        </div>
                        <div class="bomber-squad-table-title">Provisional Wing
                            <div class="bomber-squad-table-content"><?php echo $crew->provisionalWing; ?></div></div>
                        <div class="bomber-squad-table-title">Training School
                            <div class="bomber-squad-table-content"><?php echo $crew->trainingSchool; ?></div></div>
                        <div class="bomber-squad-table-title">Sent
                            <div class="bomber-squad-table-content">
                                <p id="divSent"><?php echo $crew->sent; ?></p>
                            </div>
                        </div>
                        <div class="bomber-squad-table-title">Losses
                            <div class="bomber-squad-table-content">
                                <p id="divLost"> <?php echo $crew->losses; ?></p>
                            </div>
                        </div>
                        <div class="bomber-squad-table-title">Stationed Airfield
                            <div class="bomber-squad-table-content">
                                <p id="divField"> <?php echo $crew->stationedAirfield; ?></p>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="bomber-sqaud-info">
        <h2>Other Important Information</h2>
        Currently Active
        <hr>
    </div>
    <div class="container">
        <?php if ($_SESSION['role'] == 0): ?>
            <button id="showEditCrewButton" type="button" name="showEditCrewButton">Edit Bomber Group</button>
        <?php endif; ?>
        <form id="editCrewForm">
            <input id="sameWing" style="display:none" type="text" name="provisionalWing" value="<?= $crew->provisionalWing ?>">
            <input id="sameGroup" style="display:none" type="text" name="bomberGroup" value="<?= $crew->bomberGroup ?>">
            <p> Stationed Airfield </p>
            <input id="updateAirfield" name="airfield" type="text" placeholder="Airfield" required><br>
            <p> Sent </p>
            <input id="updateSent" name="sent" type="number" placeholder="Aircraft Sent" required ><br>
            <p> Lost </p>
            <input id="updateLost" name="lost" type="number" placeholder="Aircraft Lost" required><br>

            <button id="editCrewButton" name="editCrewButton" value="<?= $crew->id ?>" type="button">Edit</button>
            <button id="cancelEditCrewButton" name="cancelEditCrewButton" type="button">Cancel</button> <br>
        </form>
    </div> <br>
</div>
