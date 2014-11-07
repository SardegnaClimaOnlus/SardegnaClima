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
            var div = document.createElement('DIV');
            value = (value==="null")?"ND":value;
            value = (value===null)?"ND":value;
            div.innerHTML = '<div style="border-radius: 50%;width: 25px;height: 25px;opacity:0.9;background-color:' + color +  ';color:#34495e;font-size: 11px;padding: 5px 2px 2px 2px;text-align: center;">'+ value + '</div>';
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
        var defaultCenter= new google.maps.LatLng(40.026053, 9.101251),
            defaultZoom = 7,
            mapOptions = {
                center: defaultCenter,
                zoom: App.configurations.currentMapZoom,
                disableDefaultUI: true,
                mapTypeId: google.maps.MapTypeId.TERRAIN,
                minZoom: defaultZoom
            };
        var SardegnaClimaMap = {
            map: null,
            init: function(){
                this.map = new google.maps.Map($("#container").find("#map")[0], mapOptions);
                this.settings.mode = "temp";
            },
            markers: {
                temp: [],
                rain: []
            },
            settings:{ mode: "temp"},
            markerTypes: ["temp", "rain"],
            resetPositionAndZoom: function(){
                this.map.setZoom(defaultZoom);
                this.map.setCenter(defaultCenter);
            },
            showMarkersByType: function(type){
                for(var i = 0; i < this.markers[type].length; i++)
                    this.markers[type][i].setMap( this.map);
            },
            hideMarkers: function(type){
                for(var i = 0; i < this.markers[type].length; i++)
                    this.markers[type][i].setMap( null);
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
            SardegnaClimaMap.resetPositionAndZoom();
            SardegnaClimaMap.cleanMap();
            SardegnaClimaMap.showMarkersByType(SardegnaClimaMap.settings.mode);
        }

        if(!Stations2.model)
            MainService.getSummary().then(function(summary){
                Stations2.model = summary;
                SardegnaClimaMap.generateMarkers();
                SardegnaClimaMap.init();
                init();
            });
        else
            init();

        $rootScope.setMapMode = function(mode){
            SardegnaClimaMap.settings.mode  = mode;
            SardegnaClimaMap.cleanMap();
            SardegnaClimaMap.showMarkersByType(mode);
            $location.path('/main/init');

        }
    });
