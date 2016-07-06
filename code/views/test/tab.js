/**
 * Created by fengxiaofei on 2015/12/10.
 */
'use strict'
define([], function () {
        var testSummernoteModule = angular.module("testTabModule", []);

        testSummernoteModule.controller('testTabCtrl', ['$scope', '$store', '$request', function ($scope, $store, $request) {
            $scope.isSelect = true;

        }]);
    }
)