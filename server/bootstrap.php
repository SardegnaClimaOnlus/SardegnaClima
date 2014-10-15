<?php

require_once __DIR__ . "/vendor/autoload.php";
use Doctrine\ORM\Tools\Setup;
use Symfony\Component\Yaml\Exception\ParseException;
use Symfony\Component\Yaml\Parser;
use Doctrine\ORM\Proxy\Autoloader;



// get configurations
$yaml = new Parser();
$configuration = null;
try {
    $configuration = $yaml->parse(file_get_contents(__DIR__ ."/config/yaml/configurations.yml"));
} catch (ParseException $e) {
    $this->logger->error("ERROR loading YAML config:" . $e->getMessage());
}
$configDB = $configuration['db'];


$path  = __DIR__.$configuration['doctrine']['entitiesRelativePath'];
$config = Setup::createAnnotationMetadataConfiguration(array($path), $configuration['core']['devMode']);
if($configuration['proxy']['custom']) $config->setProxyDir(__DIR__ . $configuration['proxy']['relativePath']);

date_default_timezone_set("Europe/Rome");

$entityManager = \Doctrine\ORM\EntityManager::create($configDB, $config);


