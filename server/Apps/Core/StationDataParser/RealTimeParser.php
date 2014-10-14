<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class RealTimeParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents($data_url);
        if(!$dataraw ) return null;
		$datagus= explode(" ", $dataraw);

		$data = "$datagus[0]";
		$ora = "$datagus[1]";

		list($giorno, $mese, $anno) = explode("/",$data);
		$anno = "20" . $anno;
		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp($datagus[2]);
		$measure->setTempmax($datagus[26]);
		$measure->setTempmin($datagus[28]);
		$measure->setHum($datagus[3]);
		$measure->setDp(null);
		$measure->setWchill($datagus[24]);
		$measure->setHindex($datagus[41]);
		$measure->setWspeed($datagus[4]);
		$measure->setDir($datagus[11]);
		$measure->setBar($datagus[10]);
		$measure->setRain($datagus[9]);
		$measure->setRr($datagus[8]);
		$measure->setRainmt($datagus[19]);
		$measure->setRainyr($datagus[20]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;


	}
}