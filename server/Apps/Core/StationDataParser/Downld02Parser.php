<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

class Downld02Parser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){


        $file = file("$data_url");
        $lines = count($file);
        if($lines < 4) return null;


        $line = $file[$lines - 1];


        $line = trim(preg_replace("/[\s,]+/", " ", $line));
        list($date, $time, $temp, $tempmax, $tempmin, $hum, $dp, $wspeed, $dir, $wrun, $whi, $whidir, $wchill, $hindex, $thwi, $bar, $rain, $rr, $inutile2, $cooldd) = explode(" ",$line);
        // date
        list($giorno, $mese, $anno) = explode("/",$date);
        $anno = '20' . $anno;
        $date = $anno . "/" . $mese . "/" . $giorno;
        $datetime = $date . ' ' . $time;
        //cast null cases
        if($wdir == '---') $wdir = null;
        if($whidir == '---') $whidir = null;

        $measure = new \Measure();
        $measure->setTemp($temp);
        $measure->setTempmax($this->em->getRepository('Measure')->getTempMaxByStation($this->station));
        $measure->setTempmin($this->em->getRepository('Measure')->getTempMinByStation($this->station));
        $measure->setHum($hum);
        $measure->setDp($dp);
        $measure->setWchill($wchill);
        $measure->setHindex($hindex);
        $measure->setWspeed($wspeed);
        $measure->setDir($dir);
        $measure->setBar($bar);
        $effectiveRain = $this->em->getRepository('Measure')->getLastRainDuringTheDayByStation($this->station) + $rain;
        $measure->setRain($effectiveRain);
        $measure->setRr($rr);
        $measure->setRainmt(null);
        $measure->setRainyr(null);
        $dateObj = date_create($datetime);
        $measure->setDate($dateObj?$dateObj:null);

        return $measure;

	}
}