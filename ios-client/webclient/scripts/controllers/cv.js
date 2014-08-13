'use strict';

/**
 * @ngdoc function
 * @name bueleApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the bueleApp
 */
angular.module('bueleApp')
  .controller('CVCtrl', function ($scope,$location, $anchorScroll) {
  	$location.hash('topapp');
	$anchorScroll();
  $scope.experiences =
  [
  	{ 
			title:"Freelancer Software developer",
			company: "Raffaele Bua",
			time: " February 2013 – Present (1 year 6 months) Sardinia ",
			skills:["Design and Develop Mobile and web applications","Objective-C, iOS","C/C++","Client-Server web SPA applications (Javascript, MYSQL, PHP)"]

		},
		{ 
			title:"Software developer",
			company: "DI-SIDE",
			time: "November 2012 – February 2013 (4 months) Sestu",
			skills:["Symfony 2", "SCRUM", "TDD"]
		},{

			title: "Software Developer",
			company: "modomodo",
			time: "January 2012 – October 2012 (10 months) Milan Area, Italy",
			skills: ["C#","MySQL","Objective-C, iOS", "Java"]
		},{
			title:"iOS Developer",
			company:"BlackSheepLab",
			time: "April 2011 – November 2011 (8 months) Venice Area, Italy",
			skills: ["Objective-C, iOS","Java"]
		},
		{
			title: "iOS Developer",
			company: "Handcrafted software srl",
			time: "March 2011 – April 2011 (2 months) Navacchio",
			skills: ["Objective-C", "iOS", "C"]
		},
		{
			title:"Bachelor’s degree in Computer science engineering (Final mark: 109/110)",
			company:"University of Pisa",
			time: "2004 – 2010 (6 years) Pisa"
		},
		{
			title: "Thesis - MULTITHREADED ENVIRONMENT CODE PARALLELISATION FOR ELECTRO-MAGNETIC FIELDS CALCULATION",
			company: "University of Pisa",
			skills:["C", "POSIX", "Multithreading Programming"]
		}


	];   
});
