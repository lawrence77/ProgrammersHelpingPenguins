// Main Scripts
var BASE_URL;
$(document).ready(function(e) {

	if($('#beforeRaid').length){
		drawBeforeMap();
	}
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
	//$('#delete-campaign-button').on('click', function(e) {
    //    window.location.href = BASE_URL + "/campaigns"
	//	deleteCampaign( parseInt($(this).val()))
    //})
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
    $('#showEditCrewButton').on('click', function(e) {
        $(this).hide()

        $('#editCrewForm')
            .fadeIn()
            .children('#newFirstName').focus()
    })
    $('.divPicture').on('mouseenter', function (e) {
        getPicture($(this).find('img').attr('alt'), $(this).find('img'))
    })
    $('#editProfileButton').on('click', function(e) {
        $(this).hide()

        $('#editProfileForm')
            .fadeIn()
            .children('#updateFirstName').focus()
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
			$('#edit-campaign-button').show()
            $('#edit-campaign-menu').hide()
        }
        else if (buttonName == 'updateCampaignEdit') {
            editCampaign($(this).val())
            $('#view-campaign-menu').show()
			$('#edit-campaign-button').show()
            $('#edit-campaign-menu').hide()
        }
        else if (buttonName == 'cancelNewPersonButton') {
            $('#newPersonButton').fadeIn()
            $('#newPersonForm').hide()
        }
        else if (buttonName == 'editCrewButton') {
            editCrew($(this).val())
            $('#showEditCrewButton').fadeIn()
            $('#editCrewForm').hide()
        }
        else if (buttonName == 'cancelEditCrewButton') {
            $('#showEditCrewButton').fadeIn()
            $('#editCrewForm').hide()
        }
        else if (buttonName == 'cancelProfileButton') {
            $('#editProfileButton').fadeIn()
            $('#editProfileForm').hide()
        }
        else if (buttonName == 'updateProfileButton') {
            data = {}
            data.id = parseInt($(this).val())
            data.firstName = $('#updateFirstName').val()
            data.lastName = $('#updateLastName').val()
            data.age = parseInt($('#updateAge').val())
            data.username = $('#sameUsername').val()
            data.password = $('#updatePassword').val()
            data.role = $('.radioRole:checked').val()

            if (data.id == 0 || data.firstName == "" || data.lastName == "" ||
                data.age == NaN || data.password == "")
                return;

            editProfile(data)
            $('#editProfileButton').fadeIn()
            $('#editProfileForm').hide()
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
    }
}

//Clears the text fields of a child type given the parent container
function clearTextOfType(parent, children) {
    $(parent).find(children).each(function(e) {
        $(this).val('')
    })
}
function deleteCampaign(id) {
    data = {'id' : id};
    $.ajax({
            type: 'POST',
            url: BASE_URL +'/campaigns/delete/' + id + '/',
            data: data,
            dataType: 'json',
            success: function(resp) {
		console.log(resp);
		if(resp.success)
		{
		    $('#campaign_' + id).remove();
		}
            },
	    error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
function editCampaign(id){
	console.log("Testing");
    data = {};
	data.id=parseInt(id)
    data.name = $('#editCampaignName').val();
    data.date = $('#editCampaignDate').val();
    data.description = $('#editCampaignDescription').val();
    console.log(data);
    $.ajax({
            type: 'POST',
            url: BASE_URL +'/campaigns/edit/'+id,
            data: data,
            dataType: 'json',
            success: function(resp) {
		console.log(resp);
		if(resp.success == true) {
			var n_data = JSON.parse(resp.data)
                        console.log($("#view-campaign-menu"));
                        $("#view-campaign-menu").replaceWith("\
						<div id='view-campaign-menu'>\
						  <a href='"+ BASE_URL +"/campaigns'>Back to Campaign list </a><br />\
						  <h1>Campaign:" + n_data.name + "</h1>\
						  <table id='campaign' class='left'>\
							<tr>\
								<td>Name:</td>\
								<td> " + n_data.name + " </td>\
							</tr>\
							<tr>\
								<td>Date:</td>\
								<td> " + n_data.date + " </td>\
							</tr>\
							<tr>\
								<td>Description:</td>\
								<td> " + n_data.description + " </td>\
							</tr>\
						  </table>\
							<button id='edit-campaign-button'>Edit Campaign </button>\
						</div>");
                }


            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
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
                        $(".campaign-list").append("<span id='campaign_" + resp.id + "'><h1><a href='" + BASE_URL + "/campaigns/view/"+ resp.id +"'>"+ n_data.name  + " </a></h1>\
						<img class ='campaign-thumbnail' src ='https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg/1200px-B-17F_formation_over_Schweinfurt%2C_Germany%2C_August_17%2C_1943.jpg'> <button onclick='deleteCampaign(" + resp.id + ")'>X</button></span> <br /><br />");


                }


            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
function deleteCrew(id) {
    data = {'id' : id};
    $.ajax({
            type: 'POST',
            url: BASE_URL +'/crews/delete/' + id + '/',
            data: data,
            dataType: 'json',
            success: function(resp) {
		console.log(resp);
		if(resp.success)
		{
		    $('#bomber_' + id).remove();
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
                        $(".crews").append("<div class='row bomber-sqaud-content' id='bomber_"+ resp.id +"'><div class ='col-lg-8'><img src ='https://static1.squarespace.com/static/524df78fe4b0b2a8d9f7c12f/58e43533e3df281cebd52e33/52c2ec0ee4b0cf91c44a2b37/1486245662492/B-17_01.jpg?format=1500w' class='crew-thumbnail'> </div> \
            <div class ='col-lg-4'> <table><tr><td> <div class='bomber-table-title'><a href='" + BASE_URL + "/crews/" + resp.id + "'>Bomber Group  " + n_data.bomberGroup  + "</a> </div> \
            <div class='bomber-squad-table-title'>Provisional Wing <div class='bomber-squad-table-content'>" + n_data.provisionalWing + "</div></div> \
            <div class='bomber-squad-table-title'>Stationed Airfield<div class='bomber-squad-table-content'>" + n_data.stationedAirfield + "</div></div> \
	    </td> </tr> </table><button onclick='deleteCrew(" + resp.id + ")'>X</button> </div></div><br/><br/>");

                }


            },
			error: function(resp) {
	        console.log("error!");
		console.log(resp);
            }
        });
}
function editCrew(id) {
    data = {};
    data.id=parseInt(id)
    data.provisionalWing = $('#sameWing').val();
    data.bomberGroup = $('#sameGroup').val();
    data.trainingSchool = 0;
    data.sent = parseInt($('#updateSent').val());
    data.losses = parseInt($('#updateLost').val());
    data.stationedAirfield = $('#updateAirfield').val();
    console.log(data);

    $.ajax({
        type: 'POST',
        url: BASE_URL +'/crews/edit/'+id,
        data: data,
        dataType: 'json',
        success: function(resp) {
            console.log(resp);
            if(resp.success == true) {
                var n_data = JSON.parse(resp.data)
                $("#divSent").replaceWith(n_data.sent)
                $('#divLost').replaceWith(n_data.losses)
                $('#divField').replaceWith(n_data.stationedAirfield)
            }
        },
		error: function(resp) {
           console.log("error!");
	       console.log(resp);
        }
    });
}

function editProfile(data) {
    //console.log(data);
    $.ajax({
        type: 'POST',
        url: BASE_URL +'/users/edit/'+data.id,
        data: data,
        dataType: 'json',
        success: function(resp) {
            console.log(resp);
            if(resp.success == true) {
                var n_data = JSON.parse(resp.data)
                $(".tdFirstName").replaceWith(n_data.firstName)
                $(".tdLastName").replaceWith(n_data.lastName)
                $(".tdAge").replaceWith(n_data.age)
                $(".tdUsername").replaceWith(n_data.username)
                $(".tdPassword").replaceWith(n_data.password)
                var string = n_data.role == 0 ? "Admin" : n_data.role == 1 ? "Historian" : "Registered";
                $(".tdRole").replaceWith(string)
            }
        },
		error: function(resp) {
           console.log("error!");
	       console.log(resp);
        }
    });
}


function follow(id, f_id) {
    data = {};
    data.id = parseInt(id);
    data.f_id = parseInt(f_id);

    $.ajax({
        type: 'POST',
        url: BASE_URL +'/users/follow/',
        data: data,
        dataType: 'json',
        success: function(resp) {
            console.log(resp);
	        $('#user_b_' + f_id).after("<button id='randomSTUZCZ' onclick='unfollow(" + id + ", " + f_id + ")'>Unfollow</button>");
	        $('#user_b_' + f_id).remove();
		$('#randomSTUZCZ').attr("id", "user_b_" + f_id);
        },
	error: function(resp) {
           console.log("error!");
	   console.log(resp);
        }
    });
}
function unfollow(id, f_id) {
    data = {};
    data.id = parseInt(id);
    data.f_id = parseInt(f_id);

    $.ajax({
        type: 'POST',
        url: BASE_URL +'/users/unfollow/',
        data: data,
        dataType: 'json',
        success: function(resp) {
            console.log(resp);
	    if(resp.result == true) {
	        $('#user_b_' + f_id).after("<button id='randomSTUZCZ' onclick='follow(" + id + ", " + f_id + ")'>Follow</button>");
	        $('#user_b_' + f_id).remove();
		$('#randomSTUZCZ').attr("id", "user_b_" + f_id);
	    }
        },
	error: function(resp) {
           console.log("error!");
	   console.log(resp);
        }
    });
}

function drawBeforeMap(){
	var stage = new createjs.Stage("canvasStage");
	var redZone = new createjs.Shape();
	redZone.graphics.beginFill("Red").drawCircle(0, 0, 50);
	redZone.x = 200;
	redZone.y = 200;
	redZone.alpha = .65;
	var redZoneLabel = new createjs.Text("This is the red-zone, the area where bombers are travelling alone and face heaviest resistance", "bold 14px Arial", "#000000");
	var redZoneRect = new createjs.Shape();
	redZoneRect.graphics.beginStroke(createjs.Graphics.getRGB(0,0,0)).rect(0, 0, 200, 100);
	
	redZoneLabel.lineWidth = 200;
	
	var redZoneContainer = new createjs.Container();
	redZoneContainer.addChild(redZoneRect ,redZoneLabel);
	redZoneContainer.x = 150;
	redZoneContainer.y = 50;
	
	stage.addChild(redZone);
	stage.enableMouseOver();
	redZone.on("pressmove", function(evt) {
    evt.target.x = evt.stageX;
    evt.target.y = evt.stageY;
	stage.update();
	});
	redZone.on("pressup", function(evt) { console.log("up"); })
	/*redZone.on("mouseover", function(e) {
		stage.addChild(redZoneContainer);
		stage.update();
	});
	redZone.on("mouseout", function(e) {
		stage.removeChild(redZoneContainer);
		stage.update();
	});*/
	
	stage.update();
}
