/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        var testNstrapModule = angular.module("testNstrapModule", []);

        testNstrapModule.controller('testNstrapCtrl', function ($scope, $ui) {
            $scope.notify = function () {
                $ui.notify('消息', '提示', function () {
                    alert('alert!');
                });
            };

            $scope.error = function () {
                $ui.error('消息内容', '错误', function () {
                    alert('alert!');
                });
            };

            $scope.confirm = function () {
                $ui.confirm('确认删除？', '确认', function () {
                    alert('alert!');
                }, function () {

                });
            };

            var url = 'views/test/testDialog.html';
            var urlCtrl = 'testDialogCtrl';
            var params = {'test': '深圳'};
            $scope.openwindowsm = function () {
                $ui.openWindowSm(url, urlCtrl, params, function (data) {
                    if (data) {
                        alert(data);
                    }
                }, function (data) {

                });
            };

            $scope.openwindow = function () {
                $ui.openWindow(url, urlCtrl, params, function (data) {
                    if (data) {
                        alert(data);
                    }
                }, function (data) {

                });
            }
        });
    }
)