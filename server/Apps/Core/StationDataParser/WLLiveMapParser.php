<?php
namespace StationDataParser;
require_once "vendor/autoload.php";

class WLLiveMapParser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents("http://isolasub.altervista.org/alberti/WL_livemap.htm");
		$datagus= explode(",", $dataraw);
		$ora = "$datagus[0]";
		$data = "$datagus[1]";

		list($giorno, $mese, $anno) = explode("/",$data);
		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;
		
		$measure = new \Measure();
		$measure->setTemp($datagus[2]);
		$measure->setTempmax($datagus[17]);
		$measure->setTempmin($datagus[18]);
		$measure->setHum($datagus[5]);
		$measure->setDp($datagus[6]);
		$measure->setWchill($datagus[4]);
		$measure->setHindex($datagus[3]);
		$measure->setWspeed($datagus[9]);
		$measure->setDir($datagus[10]);
		$measure->setBar($datagus[7]);
		$measure->setRain($datagus[11]);
		$measure->setRr(null);
		$measure->setRainmt(null);
		$measure->setRainyr(null);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;
	}
}