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
</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
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
                    <li class="active"><a href="<?= $BASE_URL ?>/home">Home</a></li>
                    <li><a href="<?= $BASE_URL ?>/campaigns">Campaigns</a></li>
					<li><a href="<?= $BASE_URL ?>/crews">Crews</a></li>
					<li><a href="<?= $BASE_URL ?>/people">People</a></li>
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
