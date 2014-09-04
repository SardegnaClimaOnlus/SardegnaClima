<?php
require '../classes/DBManager.php';


$dbm =  DBManager::getInstance();    
$all_stations_query = "SELECT id, data_url from sardegna_clima.stations ;";
$stmt = $dbm->prepare($all_stations_query);
$stmt->execute();
$stations =$stmt->fetchAll(PDO::FETCH_ASSOC);	

//var_dump($stations);
$dataUrl = $stations[0]['data_url'];
//echo $stations[0]['data_url'] . "\n";

$response =  file_get_contents($dataUrl);
echo "dataUrl: $dataUrl";
var_dump ($response);

