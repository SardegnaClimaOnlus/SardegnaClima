<?php

require_once __DIR__ . "/vendor/autoload.php";
use Doctrine\ORM\Tools\Setup;




$isDevMode = true;

$path  = __DIR__."/src";
$config = Setup::createAnnotationMetadataConfiguration(array($path), $isDevMode);
date_default_timezone_set("Europe/Rome");
// database configuration parameters
$conn = array(
    'driver'   => 'pdo_mysql',
    'host'     => '127.0.0.1',
    'dbname'   => 'sardegna_stazioninew',
    'user'     => 'root',
    'password' => ''
);


$entityManager = \Doctrine\ORM\EntityManager::create($conn, $config);
