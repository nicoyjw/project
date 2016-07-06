'use strict'
define([], function () {
    angular.module('testmd5Module', [])
        .controller("testmd5Ctrl", ['$scope', '$data', '$request', '$ui', function ($scope, $data, $request, $ui) {

            $scope.md5 = function () {

                var str = encodeURIComponent($scope.str);
                $scope.escapeStr = str;
                $scope.md5str = $data.MD5($scope.str);
                var data = {
                    str: $scope.str
                }
                $request.post("api/?model=config&action=get_data", data, function (response) {
                        $scope.sstr = response.p;
                        $scope.smd5str = response.md5;
                    }
                )
            }


        }])
})