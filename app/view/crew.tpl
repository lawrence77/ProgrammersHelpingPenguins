<div class="container">
        <h2>Bomber-squad</h2>

        <div class ="row bomber-sqaud-content">
        <div id="divPicture" class="col-lg-8">
            <img id="loadPicture" src="https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w" alt="<?= $crew->apiName?>" class="crew-thumbnail">
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
                        <div class="bomber-squad-table-content"><?php echo $crew->sent; ?></div></div>
                    <div class="bomber-squad-table-title">Losses
                        <div class="bomber-squad-table-content"><?php echo $crew->losses; ?></div></div>
                    <div class="bomber-squad-table-title">Stationed Airfield
                        <div class="bomber-squad-table-content"><?php echo $crew->stationedAirfield; ?></div>
                    </div>
                </td>

            </tr>

            </table>
            </div>

        </div>
            <div class="bomber-sqaud-info">
                <h2>Other Important Information</h2>
                Currently Active
            </div>

        <div class="container">
