<?php


require_once __DIR__ ."/../bootstrap.php";
$app = new \Slim\Slim();
require '../Apps/WebServices/MapClient/MapClient.php';


$app->run();
