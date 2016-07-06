/**
 * Created by fengxiaofei on 2015/12/18.
 */

'use strict'
define([], function () {
    angular.module('testIndexModule', [])
        .controller("testIndexCtrl", ['$scope', '$ui', '$data', '$state', function ($scope, $ui, $data, $state) {

            $scope.aaa='aaa';

            var path = "/test/jumpto";

            var data = {
                'param1': '参数1',
                'param2': '参数2',
                'param3': '参数3'
            }

            //url地址传参 仅限字符
            //页面获取方法 $ui.getUrlParam()
            $scope.stategoto = function () {
                $state.go('module', {
                    'module': 'test',
                    'action': 'jumpto',
                    'params': 'city=深圳&country=EN'
                });
            }

            //ui传参 参数类型 :对象
            //获取方法  $ui.getData()
            $scope.uigoto = function () {
                ////无参数跳转
                //$ui.locatePart(path);

                //带参数跳转
                $ui.locatePartWithData(path, data);
            }
            //全局设置参数， 任何页面可通过Key获取
            // $data.setData(key,value)
            // $data.getData(key)
            $scope.setparam = function () {
                $data.setData('testKey', data);
            }

        }])
})