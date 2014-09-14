<?php

require_once "bootstrap.php";

use StationDataParser\StationDataParserContext;

$stations = $entityManager->getRepository('Station')
                         ->findAll();


foreach ($stations as $i => $station) {
	$stationType = $station->getType();
	echo "$i) type: $stationType,";
	$stationDataParserContext = new StationDataParserContext($station->getType());
	$measure = $stationDataParserContext->getMeasure($station->getDataUrl());

	if($measure){
		$measure->setStation($station);
		$entityManager->persist($measure);
		$station->setLastMeasure($measure);
		$entityManager->flush();
		echo " Your new Measure Id: ".$measure->getId();

	}		
	echo "\n";
}




