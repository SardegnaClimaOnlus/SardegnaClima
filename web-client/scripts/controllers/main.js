'use strict';

/**
 * @ngdoc function
 * @name sardegnaclima.controller:MainCtrl
 * @description
 * # MainCtrl

 */


angular.module('sardegnaclima')

    /*
     * Sardegna Clima Marker Object
     */
    .factory('SardegnaClimaMarker', function($rootScope, $location){
        return function(station, color, value){
           // console.log("constructor of a marker");
           // console.log(station);
            var div = document.createElement('DIV');
            div.innerHTML = '<div style="border-radius: 50%;width: 20px;height: 20px;opacity:0.9;background-color:' + color +  ';color:#34495e;font-size: 11px;padding: 2px 2px 2px 2px;text-align: center;">'+ parseInt(value)+ '</div>';
            var marker = new RichMarker({
                map: null,
                position: new google.maps.LatLng(station.latitude, station.longitude),
                draggable: false,
                flat: true,
                anchor: RichMarkerPosition.MIDDLE,
                content: div,
                station: station
            });
            google.maps.event.addListener(marker, 'click', function() {
                $rootScope.$apply(function() {
                    console.log("marker.station clicked");
                    console.log(marker.station);
                    $location.path('/station/' + marker.station.id);
                });

            });
            return marker;
        }
    })

    /*
     * Stations model Singleton
     */
    .factory('Stations2', function(){
        return {
            model: null
        };
    })

    /*
     * Sardegna Clima Map Object
     */
    .factory('SardegnaClimaMap', function(SardegnaClimaMarker,Stations2,App,MapUtilities , $rootScope){
        var defaultCoordinates= {lat:40.026053, lon: 9.101251},
            mapOptions = {
                center: new google.maps.LatLng(defaultCoordinates.lat, defaultCoordinates.lon),
                zoom: App.configurations.currentMapZoom,
                disableDefaultUI: true,
                mapTypeId: google.maps.MapTypeId.TERRAIN,
                minZoom: 7
            };

        var SardegnaClimaMap = {
            map: null,
            init: function(){
                this.map = new google.maps.Map($("#container").find("#map")[0], mapOptions);
            },
            markers: {
                temp: [],
                rain: []
            },
            settings:{ mode: 'temp'},
            markerTypes: ["temp", "rain"],
            showMarkersByType: function(type){
                console.log("showMarkersByType");
                for(var i = 0; i < this.markers[type].length; i++){
                    console.log("this.markers[type][i]: " );
                    console.log(this.markers[type][i]);
                    this.markers[type][i].map = this.map;
                }

            },
            hideMarkers: function(type){
                console.log("hideMarkers()");
                console.log();
                for(var i = 0; i < this.markers[type].length; i++)
                    this.markers[type][i].map = null;
            },
            cleanMap: function(){
                for(var i = 0; i < this.markerTypes.length; i++)
                    this.hideMarkers(this.markerTypes[i]);
            },
            generateMarkers: function(){
                for(var i = 0; i < this.markerTypes.length; i++)
                    this.generateMarkersByType(this.markerTypes[i]);
            },
            generateMarkersByType: function(type){
                for(var i = 0; i < Stations2.model.length; i++)
                    this.markers[type].push(new SardegnaClimaMarker(Stations2.model[i], MapUtilities.getColorByTypeAndValue(type, Stations2.model[i].measure[type]), Stations2.model[i].measure[type]));
            }
        };

        SardegnaClimaMap.init();
        return SardegnaClimaMap;
    })
    .controller('MainCtrl', function ($scope, $rootScope, $location, $anchorScroll, MainService, MapUtilities, Stations2, currentStation, App,SardegnaClimaMap) {

        function init(){
            SardegnaClimaMap.init();
            SardegnaClimaMap.cleanMap();
            SardegnaClimaMap.showMarkersByType('temp');
        }

        if(!Stations2.model)
            MainService.getSummary().then(function(summary){
                console.log("//// http /////");
                Stations2.model = summary;
                SardegnaClimaMap.generateMarkers();
                init();
            });
        else
            init();

        $rootScope.setMapMode = function(mode){
            console.log(mode);
        }
    });
