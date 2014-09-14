<?php
namespace StationDataParser;
require_once "vendor/autoload.php";

class LogDatParser implements StationParserInterface{
	public function getMeasure($data_url){
		$dataraw = file_get_contents($data_url);
		$datagus= explode(" ", $dataraw);
		$ora = "$datagus[0]";
		$datagio = "$datagus[1]";
		$datame = "$datagus[2]";
		$dataanno = "$datagus[3]";

		// data
	   	$data = $dataanno . "/" . $datame . "/" . $datagio;
	 	$datetime = $data . ' ' . $ora;

	    $measure = new \Measure();
		$measure->setTemp($datagus[4]);
		$measure->setTempmax($datagus[6]);
		$measure->setTempmin($datagus[5]);
		$measure->setHum($datagus[7]);
		$measure->setDp($datagus[8]);
		$measure->setWchill(null);
		$measure->setHindex(null);
		$measure->setWspeed($datagus[9]);
		$measure->setDir($datagus[10]);
		$measure->setBar(null);
		$measure->setRain($datagus[11]);
		$measure->setRr(null);
		$measure->setRainmt($datagus[12]);
		$measure->setRainyr($datagus[13]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;

	}
}