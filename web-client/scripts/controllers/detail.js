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

        $scope.getWindDirectionChar = function(dir){
            return "↖";
        }

  });
