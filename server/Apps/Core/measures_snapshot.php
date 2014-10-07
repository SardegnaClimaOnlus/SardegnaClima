<?php

require_once __DIR__ ."/../../bootstrap.php";

use StationDataParser\StationDataParserContext;

$logger = Logger::getLogger('measure');
$stations = $entityManager->getRepository('Station')
                         ->findAll();

$logger->info("measure_snapshot");
foreach ($stations as $i => $station) {
	$stationType = $station->getType();
	
	$stationDataParserContext = new StationDataParserContext($station->getType());
	$logger->info("processing station -----------");
	$logger->info("name: " . $station->getName());
	$logger->info("type: " . $station->getType());
	$measure = $stationDataParserContext->getMeasure($station->getDataUrl());

	if($measure){
		$measure->setStation($station);
		$entityManager->persist($measure);
		$station->setLastMeasure($measure);
		$entityManager->flush();
	

	}		
	
}




