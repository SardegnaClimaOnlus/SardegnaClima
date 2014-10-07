<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class ClientRawParser extends Parser implements StationParserInterface{

	public function getMeasure($data_url){
		$datarawstazione = file_get_contents($data_url);
		if(!$datarawstazione){
			$this->logger->error("********************** no data from: $data_url");
			return null;
		}
		$datagus = explode(" ", $datarawstazione);

		// date
		$date = $datagus[74];
		$hour = ("$datagus[29]:$datagus[30]:$datagus[31]");
		list($giorno, $mese, $anno) = explode("/",$date);
		$date = $anno . "/" . $mese . "/" . $giorno;
	
		$measure = new \Measure();
		$measure->setTemp($datagus[4]);
		$measure->setTempmax($datagus[46]);
		$measure->setTempmin($datagus[47]);
		$measure->setHum($datagus[5]);
		$measure->setDp($datagus[72]);
		$measure->setWchill($datagus[44]);
		$measure->setHindex($datagus[112]);
		$measure->setWspeed($datagus[1]);
		$measure->setDir($this->getDirByDire($datagus[3]));
		$measure->setBar($datagus[6]);
		$measure->setRain($datagus[7]);
		$measure->setRr($datagus[10]);
		$measure->setRainmt($datagus[8]);
		$measure->setRainyr($datagus[9]);
		$dateObj = date_create($date . ' ' . $hour);

		//$this->logger->info("ClientRawParser----- ------------------------------------------------");
		//$this->logger->info("datae string");
		//$this->logger->info($date . ' ' . $hour);
		//$this->logger->info("RAW data: ");
		//$this->logger->info($datarawstazione);
		//$this->logger->info("Model:");
		//$this->logger->info($datagus);

		$measure->setDate($dateObj?$dateObj:null);	

		return $measure;
		
	}

	private function getDirByDire($dire){
		$dir ="";
		switch (TRUE) {
		  case (($dire >= 349) and ($dire <= 360)):
		    $dir= 'N';
		  break;
		  case (($dire >= 0) and ($dire <= 11)):
		    $dir= 'N';
		  break;
		  case (($dire > 11) and ($dire <= 34)):
		    $dir= 'NNE';
		  break;
		  case (($dire > 34) and ($dire <= 56)):
		    $dir= 'NE';
		  break;
		  case (($dire > 56) and ($dire <= 78)):
		    $dir= 'ENE';
		  break;
		  case (($dire > 78) and ($dire <= 101)):
		    $dir= 'E';
		  break;
		  case (($dire > 101) and ($dire <= 124)):
		    $dir= 'ESE';
		  break;
		  case (($dire > 124) and ($dire <= 146)):
		    $dir= 'SE';
		  break;
		  case (($dire > 146) and ($dire <= 169)):
		    $dir= 'SSE';
		  break;
		  case (($dire > 169) and ($dire <= 191)):
		    $dir= 'S';
		  break;
		  case (($dire > 191) and ($dire <= 214)):
		    $dir= 'SSW';
		  break;
		  case (($dire > 214) and ($dire <= 236)):
		    $dir= 'SW';
		  break;
		  case (($dire > 236) and ($dire <= 259)):
		    $dir= 'WSW';
		  break;
		  case (($dire > 259) and ($dire <= 281)):
		    $dir= 'W';
		  break;
		  case (($dire > 281) and ($dire <= 304)):
		    $dir= 'WNW';
		  break;
		  case (($dire > 304) and ($dire <= 326)):
		    $dir= 'NW';
		  break;
		  case (($dire > 326) and ($dire <= 349)):
		    $dir= 'NNW';
		  break;
		} 
		return $dir;
	}
}