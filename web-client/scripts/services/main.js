'use strict';

/**
 *  ngdoc function
 *  name bueleApp.controller:MainCtrl
 *  description
 * # MainCtrl
 * Controller of the bueleApp
 *
 */

angular.module('sardegnaclima')
    .factory('MainService', function ($http, App) {
        return {


            summaryUrl:"../server/Apps/WebServices/MapClient/cache/summary.json",
            //summaryUrl: "C:\\xampp\\htdocs\\SardegnaClima\\server\\Apps\\WebServices\\MapClient\\cache\\summary.json",


            getSummary: function(){
                var self = this;
                return $http({
                    method : "GET",
                    url : self.summaryUrl
                }).then(function(result) {
                    return result.data;
                });
            }
        };
    }).factory('MapUtilities', function(){
        return {
            getColorByTypeAndValue: function (type,value) {
                var strategy = {
                    "temp": function(temp){
                        var lookupTable = {
                            "-10": " #0000FF",
                            "-9": "#001FFF",
                            "-8": " #003EFF",
                            "-7": " #005DFF",
                            "-6": "#007CFF ",
                            "-5": "#009BFF ",
                            "-4": "#00B9FF ",
                            "-3": "#00D8FF ",
                            "-2": "#00F8FF ",
                            "-1": "#01F9E9 ",
                            "0": "#02EFCC ",
                            "1": "#03E6AF ",
                            "2": "#04DC92 ",
                            "3": "#05D16E ",
                            "4": "#06C850 ",
                            "5": "#06BF33 ",
                            "6": "#07B516 ",
                            "7": "#1EBA0E ",
                            "8": "#3BC30C ",
                            "9": "#58CC09 ",
                            "10": "#75D507 ",
                            "11": "#92DD06 ",
                            "12": "#AFE605 ",
                            "13": "#CCEF03 ",
                            "14": "#E9F901 ",
                            "15": "#FFFC00 ",
                            "16": "#FFF100 ",
                            "17": "#FFE600 ",
                            "18": "#FFBB00 ",
                            "19": "#FFB000 ",
                            "20": "#FFA500 ",
                            "21": "#FF9100 ",
                            "22": "#FF7D00 ",
                            "23": "#FF6900 ",
                            "24": "#FF5000 ",
                            "25": "#FF3C00 ",
                            "26": "#FF2800 ",
                            "27": "#FF1300 ",
                            "28": "#FF0000 ",
                            "29": "#EC0010 ",
                            "30": "#D60021 ",
                            "31": "#C20031 ",
                            "32": "#AE0042 ",
                            "33": "#990052 ",
                            "34": "#850063 ",
                            "35": "#700073 ",
                            "36": "#5C0084 "
                        };
                        return lookupTable[parseInt(temp)];
                    },
                    "rain": function(rain){
                        console.log(rain);
                        if(rain === null) return "#BFBFBF";
                        rain = parseFloat(rain);
                            if(rain == 0)
                                return "#FFFFFF";
                            else if( 0 > rain && rain <= 0.5)
                                return "#D6E2FF";
                            else if(0.5 > rain && rain <= 1)
                                return "#B5C9FF";
                            else if(1 > rain && rain <= 2)
                                return "#8EB2FF";
                            else if(2 > rain && rain <= 5)
                                return "#7F96FF";
                            else if(5 > rain && rain <= 10)
                                return "#6370F8";
                            else if(10 > rain && rain <= 15)
                                return "#0063FF";
                            else if(15 > rain && rain <= 20)
                                return "#009696";
                            else if(20 > rain && rain <= 30)
                                return "#00C633";
                            else if(30 > rain && rain <= 40)
                               return  "#63FF00";
                            else if(40 > rain && rain <= 50)
                                return "#96FF00";
                            else if(50 > rain && rain <= 60)
                                return  "#C6FF33";
                            else if(60 > rain && rain <= 80)
                                return "#FFFF00";
                            else if(80 > rain && rain <= 100)
                                return "#FFC600";
                            else if(100 > rain && rain <= 120)
                                return "#FFA000"
                            else if(120 > rain && rain <= 150)
                                return "#FF7C00";
                            else if(150 > rain && rain <= 200)
                                return "#FF1900";
                            else if(rain > 200)
                                return "#FF1900";
                    },
                    "tempmin": function(tempmin){
                        return "#0000FF";
                    },
                    "tempmax": function(tempmax){
                        return "#FF0000";                    
                    }
                };
                return strategy[type](value);

            }
        };
    }).factory('Stations', function(){
        return {
            model: null,
            map: null
        };
    })

    /*
     * Sardegna Clima Marker Object
     */
    .factory('SardegnaClimaMarker', function($rootScope, $location){
        return function(station, color, value){
            var div = document.createElement('DIV');
            value = (value==="null" || value===null)?"ND":value;
            div.innerHTML = '<div style="border-radius: 50%;width: 25px;height: 25px;opacity:0.9;background-color:' + color +  ';color: #000000 !important;font-size: 11px;padding: 5px 2px 2px 2px;text-align: center;">'+ value + '</div>';
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
            model: null,
            cleanModel: function(){
                this.model = null;
            }
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
                var self = this;
                this.map = new google.maps.Map($("#container").find("#map")[0], mapOptions);
                this.settings.mode = "temp";
                $rootScope.mapMode = "temp";

               var strictBounds = new google.maps.LatLngBounds(
                 new google.maps.LatLng(38.855680, 7.915886), 
                 new google.maps.LatLng(41.359220, 10.464714)
               );

               // Listen zoom change
                google.maps.event.addListener(self.map, 'zoom_changed', function() {
                    App.configurations.currentMapZoom = (self.map)?self.map.getZoom():App.configurations.currentMapZoom;
                 });
               // Listen for the dragend event
               google.maps.event.addListener(self.map, 'dragend', function() {
                 if (strictBounds.contains(self.map.getCenter())) return;

                 var c = self.map.getCenter(),
                     x = c.lng(),
                     y = c.lat(),
                     maxX = strictBounds.getNorthEast().lng(),
                     maxY = strictBounds.getNorthEast().lat(),
                     minX = strictBounds.getSouthWest().lng(),
                     minY = strictBounds.getSouthWest().lat();

                 if (x < minX) x = minX;
                 if (x > maxX) x = maxX;
                 if (y < minY) y = minY;
                 if (y > maxY) y = maxY;

                 self.map.setCenter(new google.maps.LatLng(y, x));
               });
            },
            markers: {
                temp: [],
                tempmin: [],
                tempmax: [],
                rain: []
            },
            settings:{ mode: "temp"},
            markerTypes: ["temp", "tempmin", "tempmax", "rain"],
            resetPositionAndZoom: function(){
                //this.map.setZoom(defaultZoom);
                //this.map.setCenter(defaultCenter);
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
    
    /*
     *  Load Model thread
     */
    .run(function(MainService,Stations2,SardegnaClimaMap) {
        var fifteenMinutesInMilliseconds = 900000;
        var oneMinuteInMilliseconds = 60000;
        var refreshInterval = fifteenMinutesInMilliseconds;
        function refreshMap(){
            MainService.getSummary().then(function(summary){
                Stations2.model = summary;
                SardegnaClimaMap.generateMarkers();
                SardegnaClimaMap.init();
               // SardegnaClimaMap.resetPositionAndZoom();
                SardegnaClimaMap.cleanMap();
                SardegnaClimaMap.showMarkersByType(SardegnaClimaMap.settings.mode);
            });
        };
        refreshMap();
        setInterval(refreshMap, refreshInterval);
    });
