<?php
# Defines Globals Used Throughout the Project

session_start();

set_include_path(dirname(__FILE__)); # include path - dont't change

include_once 'config.php'; # include the config file

// this function automatically loads any classes in the specified folder
function __autoload($className) {
	require_once 'model/'.$className.'.class.php';
}

?>
