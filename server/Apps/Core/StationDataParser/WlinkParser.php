<?php
namespace StationDataParser;
require_once "vendor/autoload.php";

class WlinkParser implements StationParserInterface{
	public function getMeasure($data_url){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $data_url);
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
		$pbotte = curl_exec($ch);
		curl_close($ch);

		$meteostr = $pbotte;
		$meteostr = substr($meteostr, strpos($meteostr,"Current Conditions as of ")+25);
		$pos = strpos($meteostr,"</td>");
		$ora = substr($meteostr, +0 , $pos);

		$parametri = explode(", ", $meteostr);
		$oragiorno = $parametri[0];
		$ora = explode(" ", $oragiorno);
		$ora = $ora[0];

		$mesegiorno = explode(" ", $parametri[1]);
		$mese = $mesegiorno[0];
		$giorno = $mesegiorno[1];

		$annoburdo = $parametri[2];
		$annoburdo2 = explode("<", $annoburdo);
		$anno = $annoburdo2[0];

		$meteostr = substr($meteostr, strpos($meteostr,"Outside Temp")+58);
		$pos = strpos($meteostr,"C</td>");
		$temp = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"C</td>");
		$tempmax = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,":")+49);
		$pos = strpos($meteostr,"C</td>");
		$tempmin = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Outside Humidity")+62);
		$pos = strpos($meteostr,"%");
		$hum = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Dew Point")+55);
		$pos = strpos($meteostr,"C</td>");
		$dp = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Barometer")+55);
		$pos = strpos($meteostr,".");
		$bar = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Wind")+2);
		$pos = strpos($meteostr,"Speed");
		$nullo2 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$wspeed = substr($meteostr, 0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$ventomax500 = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Wind Direction"));
		$pos = strpos($meteostr,"&deg;");
		$dir = substr($meteostr, 0 , $pos);

		$dir2 = explode(";", $dir);
		$dir3 = $dir2[1];

		$meteostr = substr($meteostr, strpos($meteostr,"Average Wind Speed")+2);
		$pos = strpos($meteostr,"Wind Speed");
		$nullo4 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$ventomedio500 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$raffica10min500 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"Rain")+2);
		$pos = strpos($meteostr,"Rate");
		$nullo3 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"Rain")+50);
		$pos = strpos($meteostr,"mm/Hour");
		$rr = substr($meteostr, +0 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$rain = substr($meteostr, -2 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$pioggiastorm500 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$rainmt = substr($meteostr, -2 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$rainyr = substr($meteostr, -2 , $pos);

		$meteostr = substr($meteostr, strpos($meteostr,"Last Hour Rain")+2);
		$pos = strpos($meteostr,"Rain");
		$nullo5 = substr($meteostr, +0 , $pos);
		$meteostr = substr($meteostr, strpos($meteostr,"summary_data")+14);
		$pos = strpos($meteostr,"</td>");
		$rainrateoggi500 = substr($meteostr, +0 , $pos);

		$mese = date('m', strtotime($mese));
		$data = $anno . "/" . $mese . "/" . $giorno;
		$datetime = $data . ' ' . $ora;

		$measure = new \Measure();
		$measure->setTemp($temp);
		$measure->setTempmax($tempmax);
		$measure->setTempmin($tempmin);
		$measure->setHum($hum);
		$measure->setDp($dp);
		$measure->setWchill(null);
		$measure->setHindex(null);
		$measure->setWspeed($wspeed);
		$measure->setDir($dir3);
		$measure->setBar($bar);
		$measure->setRain($rain);
		$measure->setRr($rr);
		$measure->setRainmt($rainmt);
		$measure->setRainyr($rainyr);
		$dateObj = date_create($datetime);
		$measure->setDate($dateObj?$dateObj:null);
			
		return $measure;

	}
}