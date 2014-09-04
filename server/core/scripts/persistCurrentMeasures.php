<?php
require '../classes/DBManager.php';

//-- TODO: move in proper files
class StrategyContext{
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

interface StrategyInterface{
	public function getMeasure($data_url);
}

class ClientRawParser implements StrategyInterface{
	public function getMeasure($data_url){

	}
}
//--


$dbm =  DBManager::getInstance();    
$all_stations_query = "SELECT id, data_url from sardegna_clima.stations ;";
$stmt = $dbm->prepare($all_stations_query);
$stmt->execute();
$stations =$stmt->fetchAll(PDO::FETCH_ASSOC);	



foreach ($stations as $stationDey => $stationValue) {
	$strategyContext = new StrategyContext($stationValue['type']);
	$measure = $strategyContext->getMeasure($stationValue['data_url']);
	// process measure here

}

