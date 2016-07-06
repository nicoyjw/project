'use strict';

define([], function () {
    angular.module('homeTopModule', [])
        .controller("homeTopCtrl", ['$scope', '$timeout', '$ui', '$data', '$state', '$store', '$rootScope', '$request', '$http', '$translate'
            , function ($scope, $timeout, $ui, $data, $state, $store, $rootScope, $request, $http, $translate) {

                function setLogined(logined) {
                    $scope.logined = logined;
                    $rootScope.logined = logined;
                }

                $scope.logout = function () {
                    $ui.confirm("确定退出登录?", "确认提示", function () {
                        $scope.userInfo = null;
                        $store.removeUserInfo();
                        setLogined(false);
                        $scope.loginPage = 'noLogin.html';
                    })
                }

                $scope.init = function () {

                    $rootScope.logined = false;
                    $scope.logined = false;

                    $scope.userInfo = $store.getUserInfo();

                    if ($scope.userInfo) {
                        setLogined(true);
                        $scope.loginPage = 'isLogin.html';
                    }else{
                        $scope.loginPage = 'noLogin.html';
                    }

                }

                //切换语言
                $scope.switchLang = function(lang){
                    $translate.use(lang);
                    window.localStorage.lang = lang;
                    window.location.reload();
                }

                $scope.init();


            }])
})