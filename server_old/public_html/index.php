<?php

require '../slimFramework/vendor/autoload.php';

$app = new \Slim\Slim();
require '../core/classes/DBManager.php';
require '../webservices/routes/mobile_client.php';


$app->run();
