'use strict';

/**
 *  ngdoc function
 *  name bueleApp.controller:MainCtrl
 *  description
 * # MainCtrl
 * Controller of the bueleApp
 */

angular.module('sardegnaclima')
    .factory('MainService', function ($http, App) {
        return {
            summaryUrl: App.baseUrl + "server/public_html/index.php/v1/summary",
            getSummary: function(){
                var self = this;
                return $http({
                    method : "GET",
                    url : self.summaryUrl
                }).then(function(result) {
                    return result.data;
                });
            }
        };

    }).factory('MapUtilities', function(){
        return {
            colorByTemperature: {
                "-10": " #0000FF",
                "-9": "#001FFF",
                "-8": " #003EFF",
                "-7": " #005DFF",
                "-6": "#007CFF ",
                "-5": "#009BFF ",
                "-4": "#00B9FF ",
                "-3": "#00D8FF ",
                "-2": "#00F8FF ",
                "-1": "#01F9E9 ",
                "0": "#02EFCC ",
                "1": "#03E6AF ",
                "2": "#04DC92 ",
                "3": "#05D16E ",
                "4": "#06C850 ",
                "5": "#06BF33 ",
                "6": "#07B516 ",
                "7": "#1EBA0E ",
                "8": "#3BC30C ",
                "9": "#58CC09 ",
                "10": "#75D507 ",
                "11": "#92DD06 ",
                "12": "#AFE605 ",
                "13": "#CCEF03 ",
                "14": "#E9F901 ",
                "15": "#FFFC00 ",
                "16": "#FFF100 ",
                "17": "#FFE600 ",
                "18": "#FFBB00 ",
                "19": "#FFB000 ",
                "20": "#FFA500 ",
                "21": "#FF9100 ",
                "22": "#FF7D00 ",
                "23": "#FF6900 ",
                "24": "#FF5000 ",
                "25": "#FF3C00 ",
                "26": "#FF2800 ",
                "27": "#FF1300 ",
                "28": "#FF0000 ",
                "29": "#EC0010 ",
                "30": "#D60021 ",
                "31": "#C20031 ",
                "32": "#AE0042 ",
                "33": "#990052 ",
                "34": "#850063 ",
                "35": "#700073 ",
                "36": "#5C0084 "
            }
        };
    }).factory('Stations', function(){
        return {
            model: null,
            map: null
        };
    });
