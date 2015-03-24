'use strict';

/**
 * @ngdoc function
 * @name sardegnaclima.controller:MainCtrl
 * @description
 * # MainCtrl

 */


angular.module('sardegnaclima')
    .controller('MainCtrl', function ($scope, $rootScope, $location, $anchorScroll, MainService, MapUtilities, Stations2, currentStation, App,SardegnaClimaMap) {
        function init(){
            SardegnaClimaMap.resetPositionAndZoom();
            SardegnaClimaMap.cleanMap();
            SardegnaClimaMap.showMarkersByType(SardegnaClimaMap.settings.mode);
        }
        $scope.go = function ( path ) {
          $location.path( path );
        };

        init();

        $rootScope.setMapMode = function(mode){
            SardegnaClimaMap.settings.mode  = mode;
            $rootScope.mapMode = mode;
            SardegnaClimaMap.cleanMap();
            SardegnaClimaMap.showMarkersByType(mode);
            $location.path('/main/init');

        };
        $rootScope.lastRefresh = "xxx";
        $rootScope.test = function(){
             SardegnaClimaMap.refresh().then(function(){
                // set here the time;   
                 $rootScope.lastRefresh = moment().format('MMMM Do YYYY, h:mm:ss a');
             
             }) 
        };
        
    });
