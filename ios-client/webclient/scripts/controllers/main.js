'use strict';

/**
 * @ngdoc function
 * @name bueleApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the bueleApp
 */
angular.module('bueleApp')
  .controller('MainCtrl', function ($scope, $location, $anchorScroll) {
  	$location.hash('topapp');
	$anchorScroll();
  });
