<?php

$loginLabel = '';
$extend = '';
if (isset($_SESSION['username'])) {
    $loggedin = $_SESSION['username'].': Log Out';
    $extend = '/out/';
}
else $loggedin = 'Login';

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><?= $pageTitle ?> </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<?= LINK_URL ?>/public/css/stylesheet.css"/>
    <!--<link rel="stylesheet" href="<?= LINK_URL ?>/public/css/hansonsitestyle.css"/>-->
    <script type="text/javascript" src="<?= LINK_URL ?>/public/scripts/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="<?= LINK_URL ?>/public/scripts/scripts.js"></script>
	<script type="text/javascript" src="https://code.createjs.com/1.0.0/easeljs.min.js"></script>
	<input type="hidden" id="BASE_URL_FIELD" value="<?= BASE_URL ?>">
</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container" style="width:96%">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Color_Photographed_B-17E_in_Flight.jpg/300px-Color_Photographed_B-17E_in_Flight.jpg" class="navbar-brand">
                <a class="navbar-brand"  href="<?= BASE_URL ?>">Bomber Training</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="<?php echo ($pageTitle == "Home" ? "active" : "")?>"><a href="<?= BASE_URL ?>/home">Home</a></li>
					<li class="<?php echo ($pageTitle == "Deployment" ? "active" : "")?>"><a href="<?= BASE_URL ?>/deployment">Deployment</a></li>
                    <li class="<?php echo ($pageTitle == "Campaigns" ? "active" : "")?>"><a href="<?= BASE_URL ?>/campaigns">Campaigns</a></li>
					<li class="<?php echo ($pageTitle == "Crews" ? "active" : "")?>"><a href="<?= BASE_URL ?>/crews">Crews</a></li>
					<!--<li class="<?php echo ($pageTitle == "People" ? "active" : "")?>"><a href="<?= BASE_URL ?>/people">People</a></li> -->
                    <?php if(isset($_SESSION['username'])): ?>
					<li class="<?php echo ($pageTitle == "Dashboard" ? "active" : "")?>"><a href="<?= BASE_URL ?>/dashboard">Dashboard</a></li>
					<?php endif ?>
					<li class="<?php echo ($pageTitle == "Users" ? "active" : "")?>"><a href="<?= BASE_URL ?>/users">User List</a></li>
                    <?php if(isset($_SESSION['username'])): ?>
                    <li class="<?php echo ($pageTitle == "My Profile" ? "active" : "")?>"><a href="<?php echo BASE_URL . '/users/view/' . $_SESSION['user_id']?>">My Profile</a></li>
                    <?php endif; ?>
					<!--<li><a href="">TAB 2</a></li>
                    <li><a href="">TAB#</a></li>-->
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <!--<li><a href="">Signup  <i class="fa fa-user-plus"></i></a></li>-->
                    <li><a href="<?= BASE_URL ?>/login<?= $extend ?>"><?= $loggedin ?> <i class="fa fa-user"></i></a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container control-group">
