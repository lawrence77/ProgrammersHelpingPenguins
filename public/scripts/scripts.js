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

    $('body').find('form').find('button').on('click', function(e) {
        var buttonName = $(this).attr('name')
        if (buttonName == 'cancelNewUserButton') {
            $('#newUserButton').fadeIn() //the 'Create Account' button reappears
            $('#newUserForm').hide()  //hides the new user form
            clearTextOfType('#newUserForm', '.formInputBox')  //clears any text in the form
        }
    })
})

//Clears the text fields of a child type given the parent container
function clearTextOfType(parent, children) {
    $(parent).find(children).each(function(e) {
        $(this).val('')
    })
}

function newCrew() {
    data = {};
    $.post("http://ec2-18-216-185-213.us-east-2.compute.amazonaws.com/crews", data, function(res) {console.log(res);}, 'json');
}
