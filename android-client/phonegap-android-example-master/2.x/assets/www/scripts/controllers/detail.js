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
        var correctDir = station.measure.dir;
        if(correctDir !== null)
        	setTimeout(function(){
        		$('.wind-arrow').css({'-webkit-transform' : 'rotate('+ correctDir +'deg)',
                 '-moz-transform' : 'rotate('+ correctDir +'deg)',
                 '-ms-transform' : 'rotate('+ correctDir +'deg)',
                 'transform' : 'rotate('+ correctDir +'deg)'}); 
        	},100);
        	

  });
