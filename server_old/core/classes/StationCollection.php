<?php

require_once 'DBManager.php';
require_once "Station.php";

class StationCollection{
	
	public function getStations(){
		$all_stations_query = "SELECT * from sardegna_clima.stations ;";
		$stmt = DBManager::getInstance()->prepare($all_stations_query);
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);	
		$collection = array();
		foreach ($result as $stationKey => $stationValue) {
			$station = new Station();
			$station->id = $stationValue['id'];
			$station->dataUrl = $stationValue['data_url'];
			$station->type = $stationValue['type'];
			$collection[] = $station;
		}
		return $collection;
	}
}
