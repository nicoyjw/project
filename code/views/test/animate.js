/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        angular.module("testAnimateModule", [])
            .controller('testAnimateCtrl', ['$scope', '$timeout', function ($scope, $timeout) {

                $scope.test = function () {
                    for (var i in $(".ani")) {
                        $($(".ani")[i]).css("left", $($(".ani")[i]).position().left + ( 100) + "px");
                    }
                }

                $scope.cancel = function () {
                    for (var i in $(".ani")) {
                        $($(".ani")[i]).css("left", $($(".ani")[i]).position().left - (100) + "px");
                    }
                }

            }]);
    }
)