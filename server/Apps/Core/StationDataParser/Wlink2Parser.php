<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";


class Wlink2Parser extends Parser implements StationParserInterface{
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
		$array_min = $dataraw->davis_current_observation->temp_day_low_f; 
		$array_min = floatval($array_min-32)/1.8;
//		$array_min = number_format($array_min, 1, '.', '');
		$array_max = $dataraw->davis_current_observation->temp_in_day_high_f; 
		$array_max = floatval($array_max-32)/1.8;
//		$array_max = number_format($array_max, 1, '.', '');
		$array_hum = $dataraw->relative_humidity; 
		$array_dp = $dataraw->dewpoint_c;
		$array_wind = $dataraw->wind_mph;
		$array_wind =  floatval($array_wind)*1.609;
//		$array_wind =  number_format($array_wind, 1, '.', '');
		$array_windchill = $dataraw->windchill_c;
		$array_heatindex = $dataraw->heat_index_c;
		$array_dir = $dataraw->wind_dir;
		$array_rdy = $dataraw->davis_current_observation->rain_day_in;
		$array_rdy = floatval($array_rdy)*25.4;
//		$array_rdy = number_format($array_rdy, 1, '.', '');
		$array_rmt = $dataraw->davis_current_observation->rain_month_in;
		$array_rmt = floatval($array_rmt)*25.4;
//		$array_rmt = number_format($array_rmt, 1, '.', '');
		$array_ryr = $dataraw->davis_current_observation->rain_year_in;
		$array_ryr = floatval($array_ryr)*25.4;
//		$array_ryr = number_format($array_ryr, 1, '.', '');
		$array_bar = $dataraw->pressure_mb;


		// -- create measure -- //
		$measure = new \Measure();
		$measure->setTemp(floatval($array_temp));
		$measure->setTempmax(floatval($array_max));
		$measure->setTempmin((floatval($array_min)););
		$measure->setHum(floatval($array_hum));
		$measure->setDp(floatval($array_dp));
		$measure->setWchill(floatval($array_windchill));
		$measure->setHindex(floatval($array_heatindex));
		$measure->setWspeed($wspeed);
		$measure->setDir($this->windDirectionToDegree(strval($array_dir)));
		$measure->setBar(floatval($array_bar));
		$measure->setRain($rain);
		$measure->setRr(null);
		$measure->setRainmt(floatval($array_rmt));
		$measure->setRainyr(floatval($array_ryr));
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}
