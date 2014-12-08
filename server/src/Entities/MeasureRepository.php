<?php


use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;

class MeasureRepository extends EntityRepository
{
    
    public function getTempMaxByStation($station, $day){
        $date = new DateTime($day);
        $tomorrow = $date->modify('+1 day');
        $tomorrowTimeStamp = $tomorrow->format('Y-m-d H:i:s');
        $queryString = "SELECT max(m.temp) as tempmax FROM measures m WHERE station_id = (?)  AND  m.date >= '$day' AND m.date < '$tomorrowTimeStamp';";
        $max = $this->runQuery1Param1Result($queryString, $station->getId(), 'tempmax');
        return $max;
    }
    

    public function getTempMinByStation($station, $day){
        $date = new DateTime($day);
        $tomorrow = $date->modify('+1 day');
        $tomorrowTimeStamp = $tomorrow->format('Y-m-d H:i:s'); 
        $queryString = "SELECT min(m.temp) as tempmin FROM measures m WHERE station_id = (?)  AND  m.date >= '$day' AND m.date < '$tomorrowTimeStamp';";
        $min = $this->runQuery1Param1Result($queryString, $station->getId(), 'tempmin');
        return $min;
    }


    public function getLastRainDuringTheDayByStation($station, $day){
        $date = new DateTime($day);
        $tomorrow = $date->modify('+1 day');
        $tomorrowTimeStamp = $tomorrow->format('Y-m-d H:i:s'); 
        
        \Logger::getLogger('measure_repository')->debug("lineday:");
        \Logger::getLogger('measure_repository')->debug("'$day'");

        \Logger::getLogger('measure_repository')->debug("tomorrow:");
        \Logger::getLogger('measure_repository')->debug("'$tomorrowTimeStamp'");

        $queryString = "SELECT m.rain as rain FROM measures m WHERE station_id = (?) AND m.rain > 0  AND  m.date >= '$day' AND m.date < '$tomorrowTimeStamp' ORDER  BY m.date DESC  LIMIT 1;";
        return $this->runQuery1Param1Result($queryString, $station->getId(), 'rain');
    }

    private function runQuery1Param1Result($queryString, $param, $resultPlaceholder){
        $rsm = new ResultSetMapping;
        $rsm->addEntityResult('Measure', 'm');
        $rsm->addScalarResult($resultPlaceholder, $resultPlaceholder);
        $query = $this->_em->createNativeQuery($queryString, $rsm);
        $query->setParameter(1, $param);
        $result = $query->getResult();

        return ($result)?((isset($result[0]) && isset($result[0][$resultPlaceholder]))?$result[0][$resultPlaceholder]:null):null;
    }
}