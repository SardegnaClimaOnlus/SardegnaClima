<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class ClientRawParser extends Parser implements StationParserInterface{

	public function getMeasure($data_url){
		$datarawstazione = file_get_contents($data_url);
		if(!$datarawstazione)
            return null;

		$datagus = explode(" ", $datarawstazione);

		// date
		$date = $datagus[74];
		$hour = ("$datagus[29]:$datagus[30]:$datagus[31]");
		list($giorno, $mese, $anno) = explode("/",$date);
		$date = $anno . "-" . $mese . "-" . $giorno;
	
		$measure = new \Measure();
		$measure->setTemp($datagus[4]);
		$measure->setTempmax($datagus[46]);
		$measure->setTempmin($datagus[47]);
		$measure->setHum($datagus[5]);
		$measure->setDp($datagus[72]);
		$measure->setWchill($datagus[44]);
		$measure->setHindex($datagus[112]);
		$measure->setWspeed($datagus[1]);
		$measure->setDir($datagus[3]);
		$measure->setBar($datagus[6]);
		$measure->setRain($datagus[7]);
		$measure->setRr($datagus[10]);
		$measure->setRainmt($datagus[8]);
		$measure->setRainyr($datagus[9]);
		$dateObj = date_create($date . ' ' . $hour);
		$measure->setDate($dateObj?$dateObj:null);	

		return $measure;
		
	}

	
}