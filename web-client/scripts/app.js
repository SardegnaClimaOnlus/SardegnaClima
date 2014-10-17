'use strict';

/**
 * @ngdoc overview
 * @name bueleApp
 * @description
 * # bueleApp
 *
 * Main module of the application.
 */
angular
  .module('bueleApp', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch',
        'ngMap'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
