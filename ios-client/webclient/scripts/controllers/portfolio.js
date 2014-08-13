'use strict';

/**
 * @ngdoc function
 * @name bueleApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the bueleApp
 */
angular.module('bueleApp')
  .controller('PortfolioCtrl', function ($scope,$location, $anchorScroll) {
  	$location.hash('topapp');
	$anchorScroll();
  $scope.projects =
  [
  	{ 
			title:" Book Explorer (Open source iOS App) ",
			type: "iOS App",
			link:"http://buele.github.io/BookExplorer/",
			responsibilities:["Define application specs","Design UX","Design Application architecture","Develop application using Objective-C", "To interface the application to Freebase Google API"]

		},
		{ 
			title:" Turbo smtp Dashboard ",
			type: "Web App Development in Team",
			link:"http://www.serversmtp.com/en/advanced-dashboard",
			responsibilities:["Develop RESTful webservices using node.js and MYSQL","Develop UI components using ember.js"]

		},
		{ 
			title:" Rating and review system ",
			type: "iOS Development",
			link:"https://itunes.apple.com/us/app/marine-lakes-usa/id377908737",
			responsibilities:["Develop rating and review system for user content in navigation application", "Inteface the component with C++ core"]

		},
		{ 
			title:"Tide prediction system (Improving)  ",
			type: "iOS Development in Team",
			link:"https://itunes.apple.com/us/app/marine-lakes-usa/id377908737",
			responsibilities:["Develop a C++ wrapper for a legacy C library", "Interface C++ Wrapper with Objective-C client"]

		},
		{ 
			title:"Gente Veneta App Server API ",
			type: "Webservices and backend for iPad newspaper reader",
			link:"https://itunes.apple.com/it/app/gente-veneta/id483114425?mt=8",
			responsibilities:["Design DB Architecture", "Develop web service using Java Servlets and MYSQL"]
		},
		{ 
			title:"Ledout ",
			type: "E-Commerce Development in Team",
			link:"http://www.ledout.it/",
			responsibilities:["Design Data model","Develop features of e-commerce using Synfony2"]
		}


	];   
});
