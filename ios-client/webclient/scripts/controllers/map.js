'use strict';

/**
 * @ngdoc function
 * @name bueleApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the bueleApp
 */
angular.module('bueleApp')
  .controller('MapCtrl', function ($scope, $location, $anchorScroll) {
  	alert("hello from controller");
  	$scope.stations = [
  	"fonni", "gavoi", "lodine"
  	];
  });
