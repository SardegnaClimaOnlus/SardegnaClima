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
$json = array();
foreach ($stations as $i => $station) {
    \logger::getLogger('measure_snapshot')->debug('_____________________________________________________________________');
    \Logger::getLogger('measure_snapshot')->error('Processing station with name: ' .$station->getName() . ", and id: " . $station->getId());
	$stationDataParserContext = new StationDataParserContext($station,$filter);
    if($stationDataParserContext) {
        $measure = $stationDataParserContext->getMeasure($station->getDataUrl());
        //persist measure
        if($measure == "DONE") continue;
        if ($measure) {
            $measure->setStation($station);
            $entityManager->persist($measure);
            $station->setLastMeasure($measure);
            $entityManager->flush();
            // add to json
            $json[] = array(
                "id" =>$station->getId(),
                "name" =>$station->getName(),
                "latitude" => $station->getLatitude(),
                "longitude" => $station->getLongitude(),
                "measure"=> array(
                    "temp" => $measure->getTemp(),
                    "date"=>$measure->getDate()->format('Y-m-d H:i:s'),
                    "tempmax"=>$measure->getTempmax(),
                    "tempmin"=>$measure->getTempmin(),
                    "hum"=>$measure->getHum(),
                    "dp"=>$measure->getDp(),
                    "rain"=>$measure->getrain(),
                    "wspeed"=>$measure->getWspeed(),
                    "dir"=>$measure->getDir(),
                    "bar"=>$measure->getBar()
                )
            );

            \Logger::getLogger('measure_snapshot')->debug('Persisted new measure with id: '. $measure->getId());
        } else {
            \Logger::getLogger('measure_snapshot')->error("measure invalid, for station with name: " . $station->getName() . ", and id: " . $station->getId());
        }
    }
}



// generate the json
file_put_contents(dirname(__FILE__).'/../WebServices/MapClient/cache/summary.json', json_encode($json));


\Logger::getLogger('measure_snapshot')->debug("DONE.");




