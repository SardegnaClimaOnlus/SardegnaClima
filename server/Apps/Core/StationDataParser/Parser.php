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
}