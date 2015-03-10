<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";



class SClimaParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){
	try{
		$dataraw = file_get_contents($data_url);
        }catch(\Exception $e){
		return null;
	}
	if(!$dataraw) return null;
		$databu = explode("  ", $dataraw);
		$datagio23b = $databu[16];
		$giorno = substr($datagio23b, -2);
		$mese = trim($databu[17]);
		$anno = trim($databu[18]);
		$ora = date('G:i:s' , strtotime("$databu[19]:$databu[20]"));
		$data = $anno . "-" . $mese . "-" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp(trim($databu[22]));
		$measure->setTempmax($databu[24]);
		$measure->setTempmin($databu[26]);
		$measure->setHum(trim($databu[28]));
		$measure->setDp(trim($databu[34]));
		$measure->setWchill(null);
		$hindex = $databu[52];
        $measure->setHindex($hindex);
		$measure->setHindex($databu[52]);
		$measure->setWspeed(trim($databu[38]));
		$measure->setDir(trim($databu[42]));
		$measure->setBar(trim($databu[36]));
		$measure->setRain(trim($databu[46]));
		$measure->setRr(null);
		$measure->setRainmt($databu[48]);
		$measure->setRainyr($databu[50]);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
		
		return $measure;
	}
}
