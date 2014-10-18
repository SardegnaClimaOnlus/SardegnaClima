'use strict';

/**
 * @ngdoc function
 * @name sardegnaclima.controller:MainCtrl
 * @description
 * # MainCtrl

 */

angular.module('sardegnaclima')
.controller('StationDetailsCtrl', function ($scope, station) {
        $scope.station = station;

  });
