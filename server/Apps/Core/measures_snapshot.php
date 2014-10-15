<?php

require_once __DIR__ ."/../../bootstrap.php";

use StationDataParser\StationDataParserContext;

$config = $configuration['core']['measuresSnapshot'];
Logger::configure($config['logger']);

//get station types filters
\Logger::getLogger('measure_snapshot')->debug('Getting filters from user...');
$filter = array();
for($i = 1; $i < count($argv); $i++)$filter[] = $argv[$i];
\Logger::getLogger('measure_snapshot')->debug('filters: ' . json_encode($filter));

// get measures
\Logger::getLogger('measure_snapshot')->debug('Getting stations list...');
$stations = $entityManager->getRepository('Station')->findAll();
foreach ($stations as $i => $station) {
    \Logger::getLogger('measure_snapshot')->debug('_____________________________________________________________________');
    \Logger::getLogger('measure_snapshot')->debug('Processing station with name: ' .$station->getName() . ", and id: " . $station->getId());
	$stationDataParserContext = new StationDataParserContext($station,$filter);
    if($stationDataParserContext) {
        $measure = $stationDataParserContext->getMeasure($station->getDataUrl());
        //persist measure
        if ($measure) {
            $measure->setStation($station);
            $entityManager->persist($measure);
            $station->setLastMeasure($measure);
            $entityManager->flush();
            \Logger::getLogger('measure_snapshot')->debug('Persisted new measure with id: '. $measure->getId());
        } else {
            \Logger::getLogger('measure_snapshot')->error("measure invalid, for station with name: " . $station->getName() . ", and id: " . $station->getId());
        }
    }
}


\Logger::getLogger('measure_snapshot')->debug("DONE.");




