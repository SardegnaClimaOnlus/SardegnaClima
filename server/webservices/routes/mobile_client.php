<?php


#station last update
$app->get('/v1/last_update', function () use ($app)  {
	$dbm =  DBManager::getInstance();    
	$last_station_update_query = "SELECT max(creation_date) as last_update from sardegna_clima.stations";
   	$stmt = $dbm->prepare($last_station_update_query);
	$stmt->execute();
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	
});

#station 
$app->get('/v1/stations', function () use ($app)  {
	$dbm =  DBManager::getInstance();    
	$all_stations_query = "SELECT id, latitude, longitude, name from sardegna_clima.stations ;";
   	$stmt = $dbm->prepare($all_stations_query);
	$stmt->execute();
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	
});

#station 
$app->get('/v1/stations/:id', function ($id) use ($app)  {
	$dbm =  DBManager::getInstance();    
	$station_query = "SELECT latitude, longitude, name  FROM sardegna_clima.stations where id = :id;";
   	$stmt = $dbm->prepare($station_query);
	$stmt->execute(array(':id' => $id));
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	
});

#summary
$app->get('/v1/summary', function () use ($app)  {
	$dbm =  DBManager::getInstance();
	$summary_query = "	SELECT s.id as station_id, s.latitude, s.longitude, s.name, m.temp, m.tempmax, m.tempmin, m.hum, m.dp, m.wchill, m.hindex, m.wspeed, m.dir, m.bar, m.rain, m.rr, m.rainmt, m.rainyr, m.date_time as measure_time
						FROM sardegna_clima.stations s 
						LEFT JOIN sardegna_clima.measures m ON m.id =s.last_measure_id;"; 
	$stmt = $dbm->prepare($summary_query);
	$stmt->execute();
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	

});

#station last measure
$app->get('/v1/stations/:id/measure', function ($id) use ($app)  {
	$dbm =  DBManager::getInstance();    
	$station_last_measure_query = "SELECT  m.date_time, m.temp, m.tempmax, m.tempmin, m.hum, m.dp, m.wchill, m.hindex, m.wspeed, m.dir, m.bar, m.rain, m.rr,  m.rainmt, m.rainyr  from sardegna_clima.stations s LEFT JOIN sardegna_clima.measures m ON m.id = s.last_measure_id where s.id = :id ;";
   	$stmt = $dbm->prepare($station_last_measure_query);
	$stmt->execute(array(':id' => $id));
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	
});

#last measures
$app->get('/v1/measures', function () use ($app)  {
	$dbm =  DBManager::getInstance();
	$last_measures_query = "SELECT s.id as station_id, m.temp, m.tempmax, m.tempmin, m.hum, m.dp, m.wchill, m.hindex, m.wspeed, m.dir, m.bar, m.rain, m.rr,  m.rainmt, m.rainyr  from sardegna_clima.stations s LEFT JOIN sardegna_clima.measures m ON m.id = s.last_measure_id ;";
	$stmt = $dbm->prepare($last_measures_query);
	$stmt->execute();
   	$app->response->write(json_encode($stmt->fetchAll(PDO::FETCH_ASSOC)));	

});


