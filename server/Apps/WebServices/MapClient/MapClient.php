<?php

require_once __DIR__ ."/../../../bootstrap.php";

#summary
$app->get('/v1/summary', function () use ($app, $serializer, $entityManager)  {
    $stations = $entityManager->getRepository('Station')->findAll();
    $result = array();
    for($i = 0; $i < count($stations); $i++){
        $measure = $stations[$i]->getLastMeasure();
        $result[] = array("name" =>$stations[$i]->getName(),
            "latitude" => $stations[$i]->getLatitude(),
            "longitude" => $stations[$i]->getLongitude(),
            "measure"=> array("temp" => $measure->getTemp(), "date"=>$measure->getDate()->format('Y-m-d H:i:s'))
        );
    }
   	$app->response->write(json_encode($result));

});

