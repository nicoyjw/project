/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        var testTest1Module = angular.module("testTest1Module", []);

        testTest1Module.controller('testTest1Ctrl', function ($scope) {
            $scope.totalItems = 175;
            $scope.currentPage = 1;

            $scope.pageChange = function () {
                $scope.changedPage = $scope.currentPage;
            }
        });
    }
)