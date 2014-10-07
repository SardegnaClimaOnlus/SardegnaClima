<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class Downld02Parser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){
		$handle = fopen("$data_url", 'r');
		if (!$handle) {
			fclose ($handle);
			return null;
		}
		$i = 1;
		while ( !feof ($handle) ) {
			$riga = fgets($handle,4096);
		   	//Clean row
		   	$riga = trim(preg_replace("/[\s,]+/", " ", $riga));
		   	//Filter the proper row
		   	if($i > 3){
			   	// get data from row
			   	list($date, $time, $temp, $tempmax, $tempmin, $hum, $dp, $wspeed, $dir, $wrun, $whi, $whidir, $wchill, $hindex, $thwi, $bar, $rain, $rr, $inutile2, $cooldd) = explode(" ",$riga);   
			   	// Date
			   	list($giorno, $mese, $anno) = explode("/",$date);
			  	$anno = '20' . $anno;
			   	$date = $anno . "/" . $mese . "/" . $giorno;
			   	$datetime = $date . ' ' . $time;
			 	//cast null cases
			   	if($wdir == '---') $wdir = null;
			   	if($whidir == '---') $whidir = null;

			   	$measure = new \Measure();
				$measure->setTemp($temp);
				$measure->setTempmax($tempmax);
				$measure->setTempmin($tempmin);
				$measure->setHum($hum);
				$measure->setDp($dp);
				$measure->setWchill($wchill);
				$measure->setHindex($hindex);
				$measure->setWspeed($wspeed);
				$measure->setDir($dir);
				$measure->setBar($bar);
				$measure->setRain($rain);
				$measure->setRr($rr);
				$measure->setRainmt(null);
				$measure->setRainyr(null);
				$dateObj = date_create($datetime);
				$measure->setDate($dateObj?$dateObj:null);
				
				fclose ($handle);

				return $measure;
		 	}
		   	$i++;
	   	}
	   fclose ($handle);
	}
}