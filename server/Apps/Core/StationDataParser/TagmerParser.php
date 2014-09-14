<?php
namespace StationDataParser;
require_once "vendor/autoload.php";

class TagmerParser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents($data_url);
		$datagus= explode("|", $dataraw);
		$ora = "$datagus[0]";
		$data = "$datagus[1]";

		list($giorno, $mese, $anno) = explode("/",$data);  
		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;
		
		$measure = new \Measure();
		$measure->setTemp($datagus[2]);
		$measure->setTempmax($datagus[14]);
		$measure->setTempmin($datagus[11]);
		$measure->setHum($datagus[3]);
		$measure->setDp($datagus[4]);
		$measure->setWchill($datagus[6]);
		$measure->setHindex($datagus[5]);
		$measure->setWspeed($datagus[46]);
		$measure->setDir($datagus[45]);
		$measure->setBar($datagus[7]);
		$measure->setRain($datagus[54]);
		$measure->setRr($datagus[55]);
		$measure->setRainmt($datagus[56]);
		$measure->setRainyr($datagus[58]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}
}