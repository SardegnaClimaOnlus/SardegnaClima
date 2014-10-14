<?php

require_once __DIR__ ."/../../bootstrap.php";

use StationDataParser\StationDataParserContext;
use Symfony\Component\Yaml\Exception\ParseException;
use Symfony\Component\Yaml\Parser;

$time_start = microtime(true);



// get configurations
$yaml = new Parser();
try {
    $configurations = $yaml->parse(file_get_contents(__DIR__ ."/../../config/yaml/configurations.yml"));
} catch (ParseException $e) {
    $this->logger->error("ERROR loading YAML config:" . $e->getMessage());
}
$config = $configurations['core']['measuresSnapshot'];

//configuration logger
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

$time_end = microtime(true);
$time = $time_end - $time_start;
\Logger::getLogger('measure_snapshot')->debug('execution minutes: '. gmdate("H:i:s", $time));




