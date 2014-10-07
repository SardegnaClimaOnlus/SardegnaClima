<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";


class WundergroundParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){
		$dataraw = simplexml_load_file($data_url);
		$array_data = $dataraw->observation_time_rfc822; 
		$array_data = explode(",", $array_data);
		$array_data = $array_data[1];
		$datetime = date("Y-m-d H:i:s", strtotime($array_data));

		$array_temp = $dataraw->temp_c; 
		$array_hum = $dataraw->relative_humidity; 
		$array_dp = $dataraw->dewpoint_c;
		$array_wind = $dataraw->wind_mph;
		$array_dir = $dataraw->wind_dir;
		$array_rdy = $dataraw->precip_today_in;
		$array_bar = $dataraw->pressure_mb;

		$wspeed =  floatval($array_wind)*1.609;
		$wspeed =  number_format($wspeed, 1, '.', '');
		$rain = floatval($array_rdy)*25.4;
		$rain = number_format($rain, 1, '.', '');

		// -- create measure -- //
		$measure = new \Measure();
		$measure->setTemp($array_temp);
		$measure->setTempmax(null);
		$measure->setTempmin(null);
		$measure->setHum($array_hum);
		$measure->setDp($array_dp);
		$measure->setWchill(null);
		$measure->setHindex(null);
		$measure->setWspeed($wspeed);
		$measure->setDir($this->getDirByWunderDireciton($array_dir));
		$measure->setBar($array_bar);
		$measure->setRain($rain);
		$measure->setRr(null);
		$measure->setRainmt(null);
		$measure->setRainyr(null);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}
	private function getDirByWunderDireciton($wunderDirection){
		return "N"; // TODO: remove dummy code
	}
}