<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class TagmerParser  extends Parser implements StationParserInterface{
	public function getMeasure($data_url){
	try{
		$dataraw = file_get_contents($data_url);
        }catch(\Exception $e){
		return null;
	}
	if(!$dataraw) return null;
		$datagus= explode("|", $dataraw);
		$ora = "$datagus[0]";
		$data = "$datagus[1]";
		list($giorno, $mese, $anno) = explode("/",$data);  
		$data = "20" . $anno . "-" . $mese . "-" . $giorno;
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
		$measure->setDir($this->windDirectionToDegree($datagus[45]));
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
