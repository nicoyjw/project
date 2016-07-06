/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        var testDateCtrlModule = angular.module("testDateCtrlModule", []);

        testDateCtrlModule.controller('testDateCtrl', function ($scope) {
            $scope.setDate = function () {
                var date = new Date();
                $scope.dateFormatting = date.format('yyyy-MM-dd');
                $scope.dateFormatting1 = date.format('yyyy-MM-dd hh:mm:ss');
            }

            function Init() {
                var date = new Date();
                $scope.dateFormatting1 = date.format('yyyy-MM-dd');
                $scope.dateFormatting = date.format('yyyy-MM-dd hh:mm:ss');
            };

            Init();
        });
    }
)