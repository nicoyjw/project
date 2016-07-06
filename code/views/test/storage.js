/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        var testTest1Module = angular.module("testStorageModule", []);

        testTest1Module.controller('testStorageCtrl', ['$scope', '$store', function ($scope, $store) {
            $scope.key = "testStorage";

            $scope.get = function () {
                alert($store.get($scope.key));
            }

            $scope.set = function () {
                $store.set($scope.key, $scope.value)
            }

            $scope.del = function () {
                $store.remove($scope.key)
            }

            $scope.clean = function () {
                $store.clean()
            }

            $scope.setJson = function () {
                var obj = {};
                obj.key = angular.copy($scope.key);
                obj.value = angular.copy($scope.value);
                $store.setJson($scope.key, obj);
            }

            $scope.getJson = function () {
                var data = $store.getJson($scope.key);
                alert(typeof(data));
            }

        }]);
    }
)