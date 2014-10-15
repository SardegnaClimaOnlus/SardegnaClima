#Sardegna Clima - CORE

##Technical Specifications

###Measure Snapshot

Read the values from every station data source, and persist measures in db.

Call the script

	php project_path/Apps/Core/measures_snapshot.php

#### Filter snapshot by station type
It is possible to filter the station data measure acquisition, by station type:


	php project_path/Apps/Core/measures_snapshot.php TYPE_1 TYPE_2 ... TYPE_N

Example - save measures of stations with type  DOWNLD02, ignoring stations with other types:

	php project_path/Apps/Core/measures_snapshot.php DOWNLD02


#### File Log
File path:

	project_path/Apps/Core/logs/measures_snapshot.log

###Configuration file
[Example](https://github.com/buele/SardegnaClima/blob/master/server/config/yaml/configurations.yml)

