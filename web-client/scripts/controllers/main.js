'use strict';

/**
 * @ngdoc function
 * @name sardegnaclima.controller:MainCtrl
 * @description
 * # MainCtrl

 */

angular.module('sardegnaclima')
.controller('MainCtrl', function ($scope, $location, $anchorScroll, MainService,MapUtilities,Stations, currentStation,App) {


        var addMarker = function(station){
            var div = document.createElement('DIV');
            div.innerHTML = '<div style="border-radius: 50%;width: 20px;height: 20px;opacity:0.9;background-color:' + MapUtilities.colorByTemperature[parseInt(station.measure.temp) + '']+ ';color:#34495e;font-size: 11px;padding: 2px 2px 2px 2px;text-align: center;">'+ parseInt(station.measure.temp) + '</div>';
            var marker = new RichMarker({
                map: Stations.map,
                position: new google.maps.LatLng(station.latitude, station.longitude),
                draggable: false,
                flat: true,
                anchor: RichMarkerPosition.MIDDLE,
                content: div,
                station: station
            });
            google.maps.event.addListener(marker, 'click', function() {
                Stations.map.setCenter(marker.getPosition());
                $scope.$apply(function() {


                    App.configurations.currentMapZoom = Stations.map.getZoom();
                    $location.path('/station/' + marker.station.id);
                });

            });
        };

        var setMarkers = function(){
            if(Stations.model)
                for(var i = 0; i < Stations.model.length; i++)
                    if(Stations.model[i].measure.temp)
                        addMarker(Stations.model[i]);
        };

        var loadMapPage = function(){
            var coordinates= {lat:40.026053, lon: 9.101251};
            if(currentStation){
                coordinates.lat =currentStation.latitude;
                coordinates.lon =currentStation.longitude;
            }
            var bounds = new google.maps.LatLngBounds(
                new google.maps.LatLng(38.773357, 9.986572),
                new google.maps.LatLng(41.321138, 7.998047)

            );
            var defaultCenter = new google.maps.LatLng(coordinates.lat, coordinates.lon);
            var mapOptions = {
                center: defaultCenter,
                zoom: App.configurations.currentMapZoom,
                disableDefaultUI: true,
                mapTypeId: google.maps.MapTypeId.TERRAIN,
                zoomControl: true,
                minZoom: 8
            };
            var mapElem = $("#container").find("#map")[0];
            var map = new google.maps.Map(mapElem, mapOptions);
            Stations.map = map;
            //var lastValidCenter = bounds.getCenter();
            //Stations.map.panTo(lastValidCenter)
            google.maps.event.addListener(Stations.map, 'center_changed', function() {

                if (bounds.contains(Stations.map.getCenter())) {
                    //lastValidCenter = Stations.map.getCenter();

                }else{
                    //Stations.map.panTo(defaultCenter);
                }

            });


            setMarkers();

        };
        var initStations = function(){
            MainService.getSummary().then(function(summary){
                Stations.model = summary;
                setMarkers();

            });
        };

        google.maps.event.addDomListener(window, 'load', function() {
            if(App.status == 'LOADING'){
                App.status = 'RUNNING';
                loadMapPage();
            }
            initStations();
        });

        App.status != 'LOADING' && loadMapPage();


  });
