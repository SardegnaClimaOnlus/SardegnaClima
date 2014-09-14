<?php
// create_measure.php
require_once "bootstrap.php";

$stationId = 2;


$station = $entityManager->find("Station", $stationId);
if (!$station) {
    echo "No station.\n";
    exit(1);
}

$measure = new Measure();
$measure->setTemp(23);
$measure->setTempmax(33);
$measure->setTempmin(19);
$measure->setHum(0.3);
$measure->setDp(20.0);
$measure->setWchill(22.22);
$measure->setHindex(23.3);
$measure->setWspeed(100.0);
$measure->setDir("NW");
$measure->setBar(23.4);
$measure->setRain(0.2);
$measure->setRr(33.2);
$measure->setRainmt(87.8);
$measure->setRainyr(77.8);
$measure->setStation($station);


$entityManager->persist($measure);
$entityManager->flush();

echo "Your new Measure Id: ".$measure->getId()."\n";
