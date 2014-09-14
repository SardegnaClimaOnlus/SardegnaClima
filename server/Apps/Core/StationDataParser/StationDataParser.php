<?php
namespace StationDataParser;
require_once "vendor/autoload.php";



class StationDataParser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents($data_url);
		$datagus = explode("\n", $dataraw);
		$data = "$datagus[0]";
		$ora = "$datagus[1]";
		
		list($giorno, $mese, $anno) = explode("/",$data);
		$anno = "20" . $anno;
		$anno = date('y', strtotime($anno));
		$ora = date('G:i', strtotime($ora));

		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp($datagus[9]);
		$measure->setTempmax($datagus[10]);
		$measure->setTempmin($datagus[12]);
		$measure->setHum($datagus[18]);
		$measure->setDp($datagus[27]);
		$measure->setWchill($datagus[28]);
		$measure->setHindex(null);
		$measure->setWspeed($datagus[36]);
		$measure->setDir($datagus[43]);
		$measure->setBar($datagus[59]);
		$measure->setRain($datagus[69]);
		$measure->setRr($datagus[73]);
		$measure->setRainmt($datagus[71]);
		$measure->setRainyr($datagus[72]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;

	}
}