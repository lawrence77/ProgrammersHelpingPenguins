// Main Scripts
var BASE_URL;
$(document).ready(function(e) {

  var x = setInterval(function () {
  	if ($('#BASE_URL_FIELD').val().length) {
        	BASE_URL = $('#BASE_URL_FIELD').val();
       		console.log(BASE_URL);
        	clearInterval(x);
   	}
   }, 100);
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
	console.log("Testing");
    data = {};
    data.name = $('#newCampaignName').val();
    data.date = $('#newCampaignDate').val();
    data.description = $('#newCampaignDescription').val();
    console.log(data);
    $.ajax({
            type: 'POST',
            url: BASE_URL +'/campaigns/add',
            data: data,
            dataType: 'json',
            success: function(resp) {
		console.log(resp);
		if(resp.success == true) {
			var n_data = JSON.parse(resp.data)
                        console.log($(".campaign-list"));
                        $(".campaign-list").append("<div class='row campaign-content'><div class ='col-lg-8'><img src ='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='crew-thumbnail'> </div> \
            <div class ='col-lg-4'> <div class='campaign-title'><a href='<?php echo BASE_URL; ?>/campaigns/" + resp.id + "'>Bomber Group  " + n_data.name  + "</a> </div>");

                }


            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
function newCrew() {
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
            url: BASE_URL +'/crews/add',
            data: data,
            dataType: 'json',
            success: function(resp) {
		console.log(resp);
		if(resp.success == true) {
			var n_data = JSON.parse(resp.data)
                        console.log($(".crews"));
                        $(".crews").append("<div class='row bomber-sqaud-content'><div class ='col-lg-8'><img src ='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='crew-thumbnail'> </div> \
            <div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'><a href='<?php echo $BASE_URL; ?>/crews/" + resp.id + "'>Bomber Group  " + n_data.bomberGroup  + "</a> </div> \
            <div class='bomber-squad-table-title'>Training School <div class='bomber-squad-table-content'>" + n_data.trainingSchool + "</div></div> \
            <div class='bomber-squad-table-title'>Provisional Wing <div class='bomber-squad-table-content'>" + n_data.provisionalWing + "</div></div> \
            <div class='bomber-squad-table-title'>Stationed Airfield<div class='bomber-squad-table-content'>" + n_data.stationedAirfield + "</div></div> </td> </tr> </table></div></div>");

                }


            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
