<?php

require_once __DIR__ ."/../../../bootstrap.php";

#summary
$app->get('/v1/summary', function () use ($app, $serializer, $entityManager)  {
    $stations = $entityManager->getRepository('Station')->findAll();
    $result = array();
    for($i = 0; $i < count($stations); $i++){
        $measure = $stations[$i]->getLastMeasure();
        $date = new \DateTime();
        $date->modify('-3 hours');
        if($measure->getDate() > $date )
            $result[] = array(
                "id" =>$stations[$i]->getId(),
                "name" =>$stations[$i]->getName(),
                "latitude" => $stations[$i]->getLatitude(),
                "longitude" => $stations[$i]->getLongitude(),
                "measure"=> array(
                    "temp" => $measure->getTemp(),
                    "date"=>$measure->getDate()->format('Y-m-d H:i:s'),
                    "tempmax"=>$measure->getTempmax(),
                    "tempmin"=>$measure->getTempmin(),
                    "hum"=>$measure->getHum(),
                    "dp"=>$measure->getDp(),
                    "rain"=>$measure->getrain(),
                    "wspeed"=>$measure->getWspeed(),
                    "dir"=>$measure->getDir()
                )
            );
    }
   	$app->response->write(json_encode($result));
});

