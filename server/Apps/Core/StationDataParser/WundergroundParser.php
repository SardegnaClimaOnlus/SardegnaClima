<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";


class WundergroundParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){
		$dataraw = simplexml_load_file($data_url);
        if(!$dataraw)return null;
		$array_data = $dataraw->observation_time_rfc822; 
		$array_data = explode(",", $array_data);
		$array_data = $array_data[1];
		$datetime = date("Y-m-d H:i:s", strtotime($array_data));
		$array_datetime = explode(" ", $datetime);
		$lineday = $array_datetime[0] . ' 00:00:00';

		\Logger::getLogger('measure_snapshot')->debug("WUNDERGROUND DEBUG");
		\Logger::getLogger('measure_snapshot')->debug("line date DEBUG: ");
		\Logger::getLogger('measure_snapshot')->debug($lineday);

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
		$measure->setTemp(floatval($array_temp));
		$maxInDB = $this->em->getRepository('Measure')->getTempMaxByStation($this->station,$lineday);
		$measure->setTempmax(($maxInDB===null)?$temp:max(array($maxInDB, floatval($array_temp))));
		$minInDB = $this->em->getRepository('Measure')->getTempMinByStation($this->station,$lineday);
		$measure->setTempmin(($minInDB===null)?$temp:min(array($minInDB, floatval($array_temp))));
		$measure->setHum(floatval($array_hum));
		$measure->setDp(floatval($array_dp));
		$measure->setWchill(null);
		$measure->setHindex(null);
		$measure->setWspeed($wspeed);
		$measure->setDir($this->getDirByWunderDireciton(strval($array_dir)));
		$measure->setBar(floatval($array_bar));
		$measure->setRain($rain);
		$measure->setRr(null);
		$measure->setRainmt(null);
		$measure->setRainyr(null);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}

	private function getDirByWunderDireciton($wunderDirection){
        switch($wunderDirection){
            case "North":
                $wunderDirection = 'N';
                break;
            case "South":
                $wunderDirection= 'S';
                break;
            case "East":
                $wunderDirection= 'E';
                break;
            case "West":
                $wunderDirection= 'W';
        }
		return $wunderDirection;
	}


}