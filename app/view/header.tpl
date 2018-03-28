<?php

$loginLabel = '';
$extend = '';
if (isset($_SESSION['username'])) {
    $loggedin = $_SESSION['username'].': Sign Out';
    $extend = '/out/';
}
else $loggedin = 'Sign In';

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><?= $pageTitle ?> </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<?= LINK_URL ?>/public/css/stylesheet.css"/>
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
                <img src="" id="hokie-brand">
                <a class="navbar-brand"  href="<?= BASE_URL ?>">Bomber Training</a> ADD pic here
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="<?= $BASE_URL ?>/campaign">Campaigns</a></li>
                    <!--<li><a href="">TAB 2</a></li>
                    <li><a href="">TAB#</a></li>-->
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <!--<li><a href="">Signup  <i class="fa fa-user-plus"></i></a></li>-->
                    <?php if(isset($_SESSION['username'])) { ?>
                        <li><a href="">Logout <i class="fa fa-user"></i></a></li>
                    <?php } else { ?>
                        <li><a href="<?= BASE_URL ?>/login">Login <i class="fa fa-user"></i></a></li>
                    <?php } ?>

                </ul>
            </div>
        </div>
    </nav>
