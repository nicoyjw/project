/**
 * Created by fengxiaofei on 2015/12/15.
 */
'use strict'

define([], function () {
    var testMyFormValidateModule = angular.module('testMyFormValidateModule', []);

    testMyFormValidateModule.controller('testMyFormValidateCtrl', ['$scope', '$request', '$q', function ($scope, $request, $q) {

        $scope.user = {};

        $scope.mypattern = /^a[0-9|a-z|A-Z]*b$/;

        $scope.checkKeyValid = function (input) {
            var deferred = $q.defer();
            var url = 'http://192.168.111.250:8009/api/Security/User/CheckUserAccountValid';
            //$request.getWithNoBlock(
            //    {account: input},
            //    url,
            //    function (result) {
            //        deferred.resolve(result);
            //    }, function (result) {
            //        deferred.reject(result);
            //    });

            deferred.resolve(false);
            return deferred.promise;
        }

        $scope.cancel = function () {
            console.log($scope.testValidateForm.$error)
            console.log($scope.testValidateForm.$invalid)
            console.log($scope.testValidateForm.$valid)
        }

        $scope.save = function () {

            if ($scope.testValidateForm.$invalid) {
                alert("All Checked")
            }
            else {
                alert("Has Error");
            }
        }
    }]);
});