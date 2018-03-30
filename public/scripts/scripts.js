// Main Scripts
$(document).ready(function(e) {
    $('#newUserButton').on('click', function(e) {
        $(this).hide() //hides the 'Create Account' button

        //shows and focuses on the form
        $('#newUserForm')
            .fadeIn()
            .children('#newUserFirstName').focus()

        clearTextOfType('#newUserForm', '.formInputBox') //clears the input boxes
    })
	$('#add-campaign-button').on('click', function(e) {
        $(this).hide()

        $('#add-campaign-menu')
            .show()
    })
	$('#edit-campaign-button').on('click', function(e) {
        $(this).hide()

        $('#edit-campaign-menu')
            .show()
		$('#view-campaign-menu').hide()
    })
    $('#newCrewButton').on('click', function(e) {
        $(this).hide()

        $('#newCrewForm')
            .fadeIn()
            .children('#newCrewWing').focus()
    })
    $('#newPersonButton').on('click', function(e) {
        $(this).hide()

        $('#newPersonForm')
            .fadeIn()
            .children('#newFirstName').focus()
    })
    $('#divPicture').on('mouseenter', function (e) {
        getPicture($('#loadPicture').attr('alt'), '#loadPicture')
    })

    $('body').find('form').find('button').on('click', function(e) {
        var buttonName = $(this).attr('name')
        if (buttonName == 'cancelNewUserButton') {
            $('#newUserButton').fadeIn() //the 'Create Account' button reappears
            $('#newUserForm').hide()  //hides the new user form
            clearTextOfType('#newUserForm', '.formInputBox')  //clears any text in the form
        }
        else if (buttonName == 'cancelNewCrewButton') {
            $('#newCrewButton').fadeIn()
            $('#newCrewForm').hide()
        }
        else if (buttonName == 'createNewCrewButton') {
            newCrew()
            $('#newCrewButton').fadeIn()
            $('#newCrewForm').hide()
        }
		else if (buttonName == 'cancelNewCampaignButton') {
            $('#add-campaign-button').fadeIn()
            $('#add-campaign-menu').hide()
        }
        else if (buttonName == 'createNewCampaignButton') {
            newCampaign()
            $('#add-campaign-button').fadeIn()
            $('#add-campaign-menu').hide()
        }
		else if (buttonName == 'cancelCampaignEdit') {
            $('#view-campaign-menu').show()
            $('#edit-campaign-menu').hide()
        }
        else if (buttonName == 'updateCampaignEdit') {
            newCampaign()
            $('#view-campaign-menu').show()
            $('#edit-campaign-menu').hide()
        }
        else if (buttonName == 'cancelNewPersonButton') {
            $('#newPersonButton').fadeIn()
            $('#newPersonForm').hide()
        }
    })
})

function getPicture(callName, obj) {
    if (callName != null) {
        var stringUrl = 'https://en.wikipedia.org/w/api.php?action=query&titles='.concat(callName, '&prop=pageimages&format=json&pithumbsize=300&callback=getContent&formatversion=2')
        console.log(stringUrl);
        $.ajax({
            url: stringUrl,
            jsonpCallback: 'getContent',
            dataType: 'jsonp',
            success: function(res) {
                if (res.query)
                    $(obj).attr('src', res.query.pages[0].thumbnail.source)
            }
        })
        .fail(function () {
            alert('AJAX failed')
        })
    }
}

//Clears the text fields of a child type given the parent container
function clearTextOfType(parent, children) {
    $(parent).find(children).each(function(e) {
        $(this).val('')
    })
}
function newCampaign(){
}
function newCrew() {
/*
        $crew->provisionalWing    = $_POST['provisionalWing'];
        $crew->bomberGroup        = $_POST['bomberGroup'];
        $crew->trainingSchool     = $_POST['trainingSchool'];
        $crew->sent               = $_POST['sent'];
        $crew->losses             = $_POST['losses'];
        $crew->stationedAirfield  = $_POST['stationedAirfield'];


        <input id="newCrewWing" name="wing" type="text" placeholder="Provisional Wing" required><br>
        <p> Bomber Group </p>
        <input id="newCrewGroup" name="group" type="text" placeholder="Bomber Group" required ><br>
        <p> Stationed Airfield </p>
        <input id="newCrewAirfield" name="airfield" type="text" placeholder="Airfield" required><br>
        <p> Sent </p>
        <input id="newCrewSent" name="sent" type="number" placeholder="Aircraft Sent" required ><br>
        <p> Lost </p>
        <input id="newCrewLost" name="lost" type="number" placeholder="Aircraft Lost" required><br>
*/
    console.log("Testing");
    data = {};
    data.provisionalWing = $('#newCrewWing').val();
    data.bomberGroup = $('#newCrewGroup').val();
    data.trainingSchool = 0;
    data.sent = parseInt($('#newCrewSent').val());
    data.losses = parseInt($('#newCrewLost').val());
    data.stationedAirfield = $('#newCrewAirfield').val();
    console.log(data);
    $.ajax({
            type: 'POST',
            url: 'http://ec2-18-216-185-213.us-east-2.compute.amazonaws.com/crews/add',
            data: data,
            dataType: 'json',
            success: function(resp) {
	        console.log("Success!");
		console.log(resp);
            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
