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
<<<<<<< HEAD
 	var stage = new createjs.Stage("demoCanvas");
	//VARIABLES
	//Drag Object Size
	dragRadius = 100;
	//Destination Size
	destHeight = 800;
	destWidth = 250;
	var startX = 50;
	var startY = 50;
	var radius = 50;
	$('.crewItem').each(function(){
		var label = new createjs.Text($(this).data("name"), "14px Lato", "#fff");
		label.textAlign="center";
		label.lineWidth=radius*2;
		label.y -= 7;
		var circle = new createjs.Shape();
		circle.graphics.setStrokeStyle(2).beginStroke("black")
		.beginFill("red").drawCircle(0,0, radius);
		
		var dragger = new createjs.Container();
		dragger.x = startX += radius*2 + 25;
		dragger.y = startY;
		dragger.addChild(circle, label);
		dragger.setBounds(100, 100, radius*2, radius*2);
		
		var label2 = new createjs.Text("Shweinfurt", "bold 20px Lato", "#000");
		label2.textAlign = "center";
		label2.x += 50;
		label2.y += 40;


		var box = new createjs.Shape();
		box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destHeight, destWidth);
		var destination = new createjs.Container();
		destination.x = 350;
		destination.y = 50;
		destination.setBounds(350, 50, destHeight, destWidth);

		destination.addChild(label2, box);

		//DRAG FUNCTIONALITY =====================
		dragger.on("pressmove", function(evt){
			 evt.currentTarget.x = evt.stageX;
			evt.currentTarget.y = evt.stageY;
			//console.log(evt.currentTarget);
			evt.currentTarget.setBounds(evt.currentTarget.x, evt.currentTarget.y, dragRadius*2, dragRadius*2);
			 stage.update(); //much smoother because it refreshes the screen every pixel movement instead of the FPS set on the Ticker
			 if(intersect(evt.currentTarget, destination)){
			   evt.currentTarget.alpha=0.2;
			   box.graphics.clear();
			   box.graphics.setStrokeStyle(3)
			   .beginStroke("#0066A4")
			   .rect(0, 0, destHeight, destWidth);
			   
			 }else{
			   evt.currentTarget.alpha=1;
			   box.graphics.clear();     box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destHeight, destWidth);
			 }
			  console.log("cTarget x   " + evt.currentTarget.x + "y    " + evt.currentTarget.y + "Stage x   " +  evt.stageX + "y    " +  evt.stageY );
		});

		//Mouse UP and SNAP====================
		dragger.on("pressup", function(evt) {
		  if(intersect(evt.currentTarget, destination)){
			dragger.x = destination.x + destWidth/2;
			dragger.y = destination.y + destHeight/2;
			dragger.alpha = 1;
			box.graphics.clear();     
			box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destHeight, destWidth);
			stage.update(evt);
		  }
		});
		
		stage.addChild(destination, dragger);
		stage.mouseMoveOutside = true;
		stage.update();
	});
	
	stage.update();


=======
    //Stage
var stage = new createjs.Stage("demoCanvas");

//VARIABLES
//Drag Object Size
dragRadius = 100;
//Destination Size
destHeight = 250;
destWidth = 800;

//Circle Creation
var label = new createjs.Text("Bomber Group 405th", "14px Lato", "#fff");
label.textAlign="center";
label.y -= 7;
var circle = new createjs.Shape();
circle.graphics.setStrokeStyle(2).beginStroke("black")
.beginFill("red").drawCircle(0,0, dragRadius);
console.log(circle);

//Drag Object Creation
//Placed inside a container to hold both label and shape
var dragger = new createjs.Container();
dragger.x = dragger.y = 100;
dragger.addChild(circle, label);
dragger.setBounds(0, 0, dragRadius*2, dragRadius*2);
//DragRadius * 2 because 2*r = width of the bounding box
var label2 = new createjs.Text("Shweinfurt", "bold 20px Lato", "#000");
label2.textAlign = "center";
label2.x += 50;
label2.y += 40;


var box = new createjs.Shape();
box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destWidth, destHeight);
var destination = new createjs.Container();
destination.x = 350;
destination.y = 50;
destination.setBounds(350, 50, destWidth, destHeight);

destination.addChild(label2, box);

//DRAG FUNCTIONALITY =====================
dragger.on("pressmove", function(evt){
     evt.currentTarget.x = evt.stageX;
    evt.currentTarget.y = evt.stageY;
     stage.update(); //much smoother because it refreshes the screen every pixel movement instead of the FPS set on the Ticker
     if(intersect(evt.currentTarget, destination)){
       evt.currentTarget.alpha=0.2;
       box.graphics.clear();
       box.graphics.setStrokeStyle(3)
       .beginStroke("#0066A4")
       .rect(0, 0, destWidth, destHeight);
         console.log("INTERSECTING");
       
     }else{
       evt.currentTarget.alpha=1;
       box.graphics.clear();     box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destWidth, destHeight);
     }
      console.log("cTarget x   " + evt.currentTarget.x + "y    " + evt.currentTarget.y + "Stage x   " +  evt.stageX + "y    " +  evt.stageY );
});

//Mouse UP and SNAP====================
dragger.on("pressup", function(evt) {
  if(intersect(evt.currentTarget, destination)){
    dragger.x = destination.x + destWidth/2;
    dragger.y = destination.y + destHeight/2;
    dragger.alpha = 1;
    box.graphics.clear();     
    box.graphics.setStrokeStyle(2).beginStroke("black").rect(0, 0, destWidth, destHeight);
    stage.update(evt);
  }
});
>>>>>>> f469bbd97d0ba3d334cf1a43b7a2de2dc7aa74a0
//Tests if two objects are intersecting
//Sees if obj1 passes through the first and last line of its
//bounding box in the x and y sectors
//Utilizes globalToLocal to get the x and y of obj1 in relation
//to obj2
//PRE: Must have bounds set for each object
//Post: Returns true or false


}

function intersect(obj1, obj2){
  var objBounds1 = obj1.getBounds().clone();
  var objBounds2 = obj2.getBounds().clone();
<<<<<<< HEAD

 /* var pt = obj1.globalToLocal(objBounds2.x, objBounds2.y);
  
  var h1 = -(objBounds1.height / 2 + objBounds2.height);
  var h2 = (objBounds1.height / 2 + objBounds2.height);
  var w1 = -(objBounds1.width / 2 + objBounds2.width);
  var w2 = (objBounds1.width / 2 + objBounds2.width);
  console.log(objBounds2.x);
=======
  console.log(objBounds1);
  console.log(objBounds2);
  var pt = obj1.globalToLocal(objBounds2.x, objBounds2.y);
  console.log(pt);
  var h1 = -(objBounds1.height / 2 + objBounds2.height);
  console.log(h1 + "h1");
  var h2 = objBounds2.width / 2;
      console.log(h2 + "h2");

  var w1 = -(objBounds1.width / 2 + objBounds2.width);
      console.log(w1 + "w1");

  var w2 = objBounds2.width / 2;  
      console.log(w2 + "w2");

 
>>>>>>> f469bbd97d0ba3d334cf1a43b7a2de2dc7aa74a0
  
  if(pt.x > w2 || pt.x < w1) return false;
  if(pt.y > h2 || pt.y < h1) return false;
  */

	console.log(objBounds1);
	console.log(objBounds2);
	return objBounds1.intersects(objBounds2);

  
}

/*
function createRect(name, cid)
{
	var rect = new createjs.Shape();
	rect.graphics.beginFill("Yellow").drawRect(200, 200, 200,200);
	var rectLabel = new createjs.Text(name, "bold 14px Arial", "#000000");
	//crewLabel.lineWidth = 200;
	rectLabel.textAlign = "center";
	rectLabel.y = -7;
	
	var rectC = new createjs.Container();
	rectC.addChild(rect ,rectLabel);
	rectC.x = 200;
	rectC.y = 200;
	rectC.name = cid;
	
	rectC.addChild(rect, rectLabel);
	
	return rect;
}
*/