/**
 * Created by fengxiaofei on 2015/12/18.
 */

'use strict'
define([], function () {

    angular.module("testincludeModule", [])

        .controller('testincludeCtrl', ['$scope', function ($scope) {
            $scope.testJS = function () {
                alert("TestOK")
            }
        }]);
})