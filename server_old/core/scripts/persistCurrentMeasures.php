<?php

require_once '../classes/StationDataParserContext.php';
require_once '../classes/StationCollection.php';
require_once '../classes/Station.php';

$stations = new StationCollection();

$stationsDataUrl = $stations->getStationsDataUrl();

foreach ($stations as $stationKey => $station) {
	$strategyContext = new StationDataParserContext($station->type);
	$measure = $strategyContext->getMeasure($station->data_url);
}

