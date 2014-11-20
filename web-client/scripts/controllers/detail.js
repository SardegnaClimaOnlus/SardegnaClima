'use strict';

/**
 * @ngdoc function
 * @name sardegnaclima.controller:MainCtrl
 * @description
 * # MainCtrl

 */

angular.module('sardegnaclima')
.controller('StationDetailsCtrl', function ($scope, station, $location) {
        if(!station)  $location.path('/main/init');
        $scope.station = station;
        if(station.measure.dir !== null)
        	setTimeout(function(){
        		$('.wind-arrow').css({'-webkit-transform' : 'rotate('+ station.measure.dir +'deg)',
                 '-moz-transform' : 'rotate('+ station.measure.dir +'deg)',
                 '-ms-transform' : 'rotate('+ station.measure.dir +'deg)',
                 'transform' : 'rotate('+ station.measure.dir +'deg)'}); 
        	},100);
        	
        
        

  });
