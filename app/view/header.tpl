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
		<title> <?= $pageTitle?> </title>
		<link rel="stylesheet" href="<?= BASE_URL ?>/public/css/stylesheet.css"/>
		<script type="text/javascript" src="<?=BASE_URL ?>/public/scripts/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="<?=BASE_URL ?>/public/scripts/scripts.js"></script>
	</head>
	<body>
		<div class="header">
			<a class="headerStage1" href="<?= BASE_URL ?>/">Home</a>
	        <a class="headerStage1" href="<?= BASE_URL ?>/something1">Generic Tab 1</a>
	        <a class="headerStage1" href="<?= BASE_URL ?>/something2">Generic Tab 2</a>
			<a class="headerStage2" href="<?= BASE_URL ?>/something3">Generic Tab 3</a>
            <a class="headerStage2" href="<?= BASE_URL ?>/signin<?= $extend ?>"><?= $loggedin ?></a>
		</div>
