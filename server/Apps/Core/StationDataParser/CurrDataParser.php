<?php
namespace StationDataParser;
require_once "vendor/autoload.php";

class CurrDataParser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents($data_url);

		$datafil = explode(" ", $dataraw);
		$data = $datafil[0];
		$ora = $datafil[1];

		list($giorno, $mese, $anno) = explode("/",$data);
		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp($datafil[2]);
		$measure->setTempmax($datafil[13]);
		$measure->setTempmin($datafil[16]);
		$measure->setHum($datafil[6]);
		$measure->setDp($datafil[5]);
		$measure->setWchill($datafil[3]);
		$measure->setHindex($datafil[4]);
		$measure->setWspeed($datafil[9]);
		$measure->setDir($datafil[11]);
		$measure->setBar($datafil[7]);
		$measure->setRain($datafil[43]);
		$measure->setRr($datafil[12]);
		$measure->setRainmt($datafil[119]);
		$measure->setRainyr($datafil[157]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}
}