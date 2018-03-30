// Main Scripts
var LINK_URL = 'http://ec2-18-216-185-213.us-east-2.compute.amazonaws.com/ProgrammersHelpingPenguins'

$(document).ready(function(e) {
    $('#newUserButton').on('click', function(e) {
        $(this).hide() //hides the 'Create Account' button

        //shows and focuses on the form
        $('#newUserForm')
            .fadeIn()
            .children('#newUserFirstName').focus()

        clearTextOfType('#newUserForm', '.formInputBox') //clears the input boxes
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
    $('#loadPicture').on('mouseenter', function (e) {
        $(this).attr('src', getPicture($(this).attr('alt')))
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
        else if (buttonName == 'cancelNewPersonButton') {
            $('#newPersonButton').fadeIn()
            $('#newPersonForm').hide()
        }
    })
})

function getPicture(callName) {
    var newSrc = LINK_URL.concat('/public/images/question.png')
    var pic;
    if (callName == null) {
        pic = $('<img src="ProgrammersHelpingPenguins/images/question.png" class="bomber-squad-image">')
    } else {
        var stringUrl = 'https://en.wikipedia.org/w/api.php?action=query&titles='.concat(callName, '&prop=pageimages&format=json&pithumbsize=300&callback=getContent')
        console.log(stringUrl);
        $.ajax({
            url: stringUrl,
            jsonpCallback: 'getContent',
            dataType: 'jsonp',
            success: function(res) {
                console.log(res)
                console.log(res.query);
                console.log(res.query.pages;

            }
        })
        .fail(function () {
            alert('AJAX failed')
        })
    }
    return newSrc;
}

//Clears the text fields of a child type given the parent container
function clearTextOfType(parent, children) {
    $(parent).find(children).each(function(e) {
        $(this).val('')
    })
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
            }
        });
}
