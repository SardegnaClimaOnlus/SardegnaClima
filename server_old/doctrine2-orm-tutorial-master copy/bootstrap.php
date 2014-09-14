<?php
use Doctrine\ORM\Tools\Setup;

require_once "vendor/autoload.php";

// Create a simple "default" Doctrine ORM configuration for XML Mapping
$isDevMode = true;
echo __DIR__;
$config = Setup::createAnnotationMetadataConfiguration(array(__DIR__."/src/Entities"), $isDevMode);
// or if you prefer yaml or annotations
//$config = Setup::createXMLMetadataConfiguration(array(__DIR__."/config/xml"), $isDevMode);
//$config = Setup::createYAMLMetadataConfiguration(array(__DIR__."/config/yaml"), $isDevMode);

// database configuration parameters
$conn = array(
    'driver'   => 'pdo_mysql',
    'host'     => '127.0.0.1',
    'dbname'   => 'sardegna_stazioni_new',
    'user'     => 'root',
    'password' => ''
);


// obtaining the entity manager
$entityManager = \Doctrine\ORM\EntityManager::create($conn, $config);
