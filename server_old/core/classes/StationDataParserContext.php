<?php
require "ClientRawParser.php";
require "SClimaParser.php";
require "WundergroundParser.php";
require "WLLiveMapParser.php";
require "TagmerParser.php";
require "StationDataParser.php";
require "Downld02Parser.php";
require "LogDatParser.php";
require "CurrDataParser.php";
require "RealTimeParser.php";
require "WlinkParser.php";

class StationDataParserContext{
	private $strategy = null;
	public function __construct($type) {
		switch ($type) {
				case "CLIENTRAW":
					$this->strategy = new ClientRawParser();
					break;
				case "SCLIMA":
					$this->strategy = new SClimaParser();
					break;
				case "WUNDERGROUND":
					$this->strategy = new WundergroundParser();
					break;
				case "WL_LIVEMAP":
					$this->strategy = new WLLiveMapParser();
					break;
				case "TAGMER":
					$this->strategy = new TagmerParser();
					break;
				case "DATI_STAZIONE":
					$this->strategy = new StationDataParser();
					break;
				case "DOWNLD02":
					$this->strategy = new Downld02Parser();
					break;
				case "LOGDAT":
					$this->strategy = new LogDatParser();
					break;
				case "CURRDATA":
					$this->strategy = new CurrDataParser();
					break;
				case "REALTIME":
					$this->strategy = new RealTimeParser();
					break;
				case "WLINK":
					$this->strategy = new WlinkParser();
					break;
		}
	}
	public function getMeasure($data_url){
		$this->strategy->getMeasure($data_url);
	}
}