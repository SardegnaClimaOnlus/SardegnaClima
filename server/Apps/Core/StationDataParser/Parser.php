<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../bootstrap.php";


class Parser {
	protected $logger;
    protected $station;
    protected $em;
	function __construct($station){
        global $entityManager;
        $this->station = $station;
		$this->logger = \Logger::getLogger('parser');
        $this->em = $entityManager;

	}
	protected function windDirectionToDegree($dir){
		$windDirections = array("N"=> 0,"NNE"=>22.5,"NE"=>45,"ENE"=>67.5,"E"=>90,"ESE"=>112.5,"SE"=>135,"SSE"=>157.5,
"S"=>180,"SSW"=>202.5,"SW"=>225,"WSW"=>247.5,"W"=>270,"WNW"=>292.5,"NW"=>315,"NNW"=>337.5);
		return 	$windDirections[$dir];
	}
}
