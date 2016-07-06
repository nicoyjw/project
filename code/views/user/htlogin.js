/*
* @Author: 刘玉洁
* @Date:   2016-05-18 17:06:31
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 18:24:36
*/

"use strict";
define([""], function () {
    angular.module('userHtloginModule', [])
        .controller('userHtloginCtrl', ['$scope','$request', '$ui','$data',function ($scope,$request,$ui,$data) {
            $scope.submitForm = function(){
               if($scope.name && $scope.password){
                    $request.get('api/?model=user&action=back_login&name='+$scope.name+'&password='+$scope.password,
                        function (response) {
                            if (response.data) {
                                $data.setCookie('login',response.data.name)
                                location.href= "/admin/index.html"
                            } else if (angular.isUndefined("登录失败")) {
                                $ui.error("登录失败");
                            } else {
                                $ui.error("登录失败");
                            }
                        }, function (err) {
                            $ui.error(err);
                        });
                }
            }
        }])
});