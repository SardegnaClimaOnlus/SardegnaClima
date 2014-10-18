'use strict';

/**
 * @ngdoc overview
 * @name bueleApp
 * @description
 * # bueleApp
 *
 * Main module of the application.
 */
console.log("hello from app.js file");
angular
  .module('sardegnaclima', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch'
  ])
    .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/main/:station_id', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
            resolve: {
                currentStation: function(Stations, $route){
                    if(Stations.model )
                        return _.findWhere(Stations.model, {id: parseInt($route.current.params.station_id)});
                    else
                        return null;
                }
            }
      })
        .when('/station/:id', {
            templateUrl: 'views/station_details.html',
            controller: 'StationDetailsCtrl',
            resolve: {
                station: function(Stations, $route){
                    return _.findWhere(Stations.model, {id: parseInt($route.current.params.id)});
                }
            }
        })
      .otherwise({
        redirectTo: '/main'
      });
  }])
    .run(function() {
        console.log("hello from run in app.js");
}).factory('App',function() {
        return{
            status: 'LOADING',
            configurations: {
                currentMapZoom : 8
            }
        };
    });


