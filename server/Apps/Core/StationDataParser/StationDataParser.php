<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";



class StationDataParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){

		$dataraw = file_get_contents($data_url);
        if(!$dataraw) return null;
		$datagus = explode("\n", $dataraw);
		$data = "$datagus[0]";
		$ora = "$datagus[1]";

		list($giorno, $mese, $anno) = explode("/",$data);
		$anno = "20" . $anno;
		$anno = date('Y', strtotime($anno));
		$ora = date('G:i:s', strtotime($ora));
		$data = $anno . "-" . $mese . "-" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp(floatval($datagus[9]));
		$measure->setTempmax(floatval($datagus[10]));
		$measure->setTempmin(floatval($datagus[12]));
		$measure->setHum(floatval($datagus[18]));
		$measure->setDp(floatval($datagus[27]));
		$measure->setWchill(floatval($datagus[28]));
		$measure->setHindex(null);
		$measure->setWspeed(floatval($datagus[36]));
		$measure->setDir($this->windDirectionToDegree($datagus[43]));
		$measure->setBar(floatval($datagus[59]));
		$measure->setRain(floatval($datagus[69]));
		$measure->setRr(floatval($datagus[73]));
		$measure->setRainmt(floatval($datagus[71]));
		$measure->setRainyr(floatval($datagus[72]));
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;

	}
}