<?php
//require_once "vendor/autoload.php";
require_once "bootstrap.php";
use Apps\Core\StationDataParser;


$stationId = 2;

$station = $entityManager->getRepository('Station')
                         ->findOneById($stationId);


echo $station->getName() . "\n";

//$measure = new Measure();
//$stationDataParserContext = new StationDataParserContext("CLIENTRAW");
//$measure = $stationDataParserContext->getMeasure($station->getDataUrl());
//var_dump($measure);

/*
$strategyContext = new StationDataParserContext($station->type);
$measure = $strategyContext->getMeasure($station->data_url);
*/