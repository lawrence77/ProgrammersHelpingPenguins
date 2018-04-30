<div>
    <h1> Sign In </h1>
    <form method="post" action="<?= BASE_URL ?>/login/process/" id="loginForm">
        <p>Username
            <input type="text" name="username" placeholder="Username" maxlength="40">
        </p>
        <p>Password
            <input type="password" name="password" placeholder="Password" maxlength="40">
        </p>
        <button type="submit" name="loginButton">Sign In</button>
    </form>
    <hr>
    <h1>
        New User<br>
    </h1>
        <button id="newUserButton" type="button" name="newUserButton">Create Account</button>
    <form method="post" action="<?= BASE_URL ?>/login/newUser/" id="newUserForm">
        <p> First Name </p>
        <input id="newUserFirstName" name="firstName" type="text" placeholder="First Name" required><br>
        <p> Last Name </p>
        <input id="newUserLastName" name="lastName" type="text" placeholder="Last Name" required ><br>
        <p> User Age </p>
        <input id="newUserAge" name="age" type="number" placeholder="Age" required><br>
        <p> Username </p>
        <input id="newUserUsername" name="username" type="text" placeholder="Username" required ><br>
        <p> Password </p>
        <input id="newUserPassword" name="password" type="password" placeholder="Password" required><br><br>
        <p>Mark the Checkbox if Valid</p>
        <label style="font-weight:normal;" for="newUserRole">Historian: </label>
        <input id="newUserRole" type="checkbox" name="role"> <br><br>

        <button id="createNewUserButton" name="createNewUserButton"  type="submit">Add</button>
        <button id="cancelNewUserButton" name="cancelNewUserButton" type="button">Cancel</button> <br>
    </form>
</div>
