<?php
namespace StationDataParser;
require_once __DIR__ ."/../../../vendor/autoload.php";

/*
 *
 * DOWNLD02 STATION WITH SOLAR SENSOR
 *
 */

class Downld02AParser extends Parser implements StationParserInterface{
	public function getMeasure($data_url){

        $logger = \Logger::getLogger('downl02');
        $file = file("$data_url");
        $lines = count($file);
        if($lines < 4) return null;
        $lastMeasure = $this->station->getLastMeasure();
        $lastMeasureDate = $lastMeasure->getDate();
        for($i = 4; $i < $lines; $i++){
                $line = $file[$i];        

                $line = trim(preg_replace("/[\s,]+/", " ", $line));
                list($date, $time, $temp, $tempmax, $tempmin, $hum, $dp, $wspeed, $dir, $wrun, $whi, $whidir, $wchill, $hindex, $thwi, $bar, $rain, $rr, $inutile2, $cooldd) = explode(" ",$line);
                // date
                list($giorno, $mese, $anno) = explode("/",$date);
                $anno = '20' . $anno;
                $date = $anno . "-" . $mese . "-" . $giorno;
                $datetime = $date . ' ' . $time;
                $lineday = $date . ' 00:00:00';
                if($wdir == '---') $wdir = null;
                if($whidir == '---') $whidir = null;
                $lineDate = date_create($datetime);
                $logger->debug("lineDate:");
                $logger->debug($lineDate);
                $logger->debug("lastMeasureDate:");
                $logger->debug($lastMeasureDate);
                if($lineDate > $lastMeasureDate){
                        $measure = new \Measure();
                        $measure->setTemp($temp);
                        $maxInDB = $this->em->getRepository('Measure')->getTempMaxByStation($this->station,$lineday);
                        $measure->setTempmax(($maxInDB===null)?$temp:max(array($maxInDB, $temp)));
                        $minInDB = $this->em->getRepository('Measure')->getTempMinByStation($this->station,$lineday);
                        $measure->setTempmin(($minInDB===null)?$temp:min(array($minInDB, $temp)));
                        $measure->setHum($hum);
                        $measure->setDp($dp);
                        $measure->setWchill($wchill);
                        $measure->setHindex($hindex);
                        $measure->setWspeed($wspeed);
                        $measure->setDir($this->windDirectionToDegree($dir));
                        $measure->setBar($bar);
                        $rainInTheDay = $this->em->getRepository('Measure')->getLastRainDuringTheDayByStation($this->station,$lineday);
                        $logger->debug("rain during the day:");
                        $logger->debug($rainInTheDay);
                        $logger->debug("rain in the line:");
                        $logger->debug($rain);
                        $effectiveRain = $rainInTheDay + $rain;
                       
                        $measure->setRain($effectiveRain);
                        $measure->setRr($rr);
                        $measure->setRainmt(null);
                        $measure->setRainyr(null);
                        $dateObj = date_create($datetime);
                        $measure->setDate($dateObj?$dateObj:null);

                        $measure->setStation($this->station);
                        $this->em->persist($measure);
                        $this->station->setLastMeasure($measure);
                        $this->em->flush();
                        

                    }
	       }
        return "DONE";
        }
}