/**
 * Created by fengxiaofei on 2015/12/18.
 */

'use strict'
define([], function () {
    angular.module('testJumptoModule', [])
        .controller("testJumptoCtrl", ['$scope', '$ui', '$data', '$state', function ($scope, $ui, $data, $state) {



            //获取参数
            $scope.getparam = function () {
                var stateParam = $ui.getUrlParam();
                var uiParam = $ui.getData();
                var dataParam = $data.getData('testKey');

                var t = 0;
                console.log(stateParam);
            }

        }])
})