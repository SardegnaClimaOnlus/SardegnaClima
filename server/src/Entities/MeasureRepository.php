<?php


use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;

class MeasureRepository extends EntityRepository
{
    public function getTempMaxByStation($station){
        $queryString = "SELECT max(m.temp) as tempmax FROM measures m WHERE station_id = (?) AND date >= CURDATE();";
        return $this->runQuery1Param1Result($queryString, $station->getId(), 'tempmax');
    }

    public function getTempMinByStation($station){
        $queryString = "SELECT min(m.temp) as tempmin FROM measures m WHERE station_id = (?) AND date >= CURDATE();";
        return $this->runQuery1Param1Result($queryString, $station->getId(), 'tempmin');
    }


    public function getLastRainDuringTheDayByStation($station){
        $queryString = "SELECT   m.rain as rain FROM measures m WHERE station_id = (?) AND m.rain >0  AND  m.date >= CURDATE()  LIMIT 1;";
        return $this->runQuery1Param1Result($queryString, $station->getId(), 'rain');
    }

    private function runQuery1Param1Result($queryString, $param, $resultPlaceholder){
        $rsm = new ResultSetMapping;
        $rsm->addEntityResult('Measure', 'm');
        $rsm->addScalarResult($resultPlaceholder, $resultPlaceholder);
        $query = $this->_em->createNativeQuery($queryString, $rsm);
        $query->setParameter(1, $param);
        $result = $query->getResult();

        return ($result)?((isset($result[0]) && isset($result[0][$resultPlaceholder]))?$result[0][$resultPlaceholder]:0):0;
    }
}