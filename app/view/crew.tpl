<div class="container">
    <div class="panel panel-primary">
      <div class="panel-heading text-center"><b>Bomber Crew</b></div>
      <div class="panel-body">
    <br><br>

    <div class ="row bomber-sqaud-content">
        <div class="divPicture col-lg-8">
            <img class="loadPicture crew-thumbnail" src="https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w" alt="<?= $crew->apiName?>" >
    </div>
        <div class ="col-lg-4">
            <table>
                <tr>
                    <td>
                        <div class="bomber-squad-table-title">Bomber Group</div>
                            <div class="bomber-squad-table-content"><?php echo $crew->bomberGroup; ?></div>
                        
                        <div class="bomber-squad-table-title">Provisional Wing</div>
                            <div class="bomber-squad-table-content"><?php echo $crew->provisionalWing; ?></div>
                        <div class="bomber-squad-table-title">Sent</div>
                            <div class="bomber-squad-table-content">
                                <p id="divSent"><?php echo $crew->sent; ?></p>
                            </div>
                        
                        <div class="bomber-squad-table-title">Losses</div>
                            <div class="bomber-squad-table-content">
                                <p id="divLost"> <?php echo $crew->losses; ?></p>
                            </div>
                        
                        <div class="bomber-squad-table-title">Stationed Airfield</div>
                            <div class="bomber-squad-table-content">
                                <p id="divField"> <?php echo $crew->stationedAirfield; ?></p>
                            </div>
                     </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="bomber-sqaud-info">
        <div class="bomber-squad-table-title">Other Important Information</div>
        <div class="bomber-squad-table-content">Currently Active</div>
        <hr>
    </div>
    <div class="container">
        <?php if ($_SESSION['role'] <= 1): ?>
            <button id="showEditCrewButton" type="button" class="btn btn-info" name="showEditCrewButton">Edit Bomber Group</button>
        <?php endif; ?>
        <form id="editCrewForm">
            <input id="sameWing" style="display:none" type="text" name="provisionalWing" value="<?= $crew->provisionalWing ?>">
            <input id="sameGroup" style="display:none" type="text" name="bomberGroup" value="<?= $crew->bomberGroup ?>">
            <br> Stationed Airfield <br>
            <input id="updateAirfield" value="<?= $crew->stationedAirfield ?>" name="airfield" type="text" placeholder="Airfield" required><br>
            <br> Sent <br>
            <input id="updateSent" value="<?= $crew->sent ?>" name="sent" type="number" placeholder="Aircraft Sent" required ><br>
            <br> Lost <br>
            <input id="updateLost" value="<?= $crew->losses ?>" name="lost" type="number" placeholder="Aircraft Lost" required><br>
<br>
            <button id="editCrewButton" name="editCrewButton" value="<?= $crew->id ?>" class="btn btn-success" type="button">Edit</button>
            <button id="cancelEditCrewButton" name="cancelEditCrewButton" class="btn btn-danger" type="button">Cancel</button> <br>
        </form>
    </div> <br>
    </div> 
</div>
</div>
