<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class Parser {
	protected $logger;
	function __construct(){
		$this->logger = \Logger::getLogger('parser');
	}
}