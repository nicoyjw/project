/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        var testTest1Module = angular.module("testDialogModule", []);

        testTest1Module.controller('testDialogCtrl', ['$scope', '$uibModalInstance', 'modalData', function ($scope, $uibModalInstance, modalData) {
            $scope.isAllChecked = false;

            $scope.prodects = [
                {'Name': '手机1', 'price': 10, 'isCheck': ''},
                {'Name': '手机2', 'price': 10, 'isCheck': ''},
                {'Name': '手机3', 'price': 10, 'isCheck': ''},
                {'Name': '手机4', 'price': 10, 'isCheck': ''},
                {'Name': '手机5', 'price': 10, 'isCheck': ''},
                {'Name': '手机6', 'price': 10, 'isCheck': ''}

            ];

            $scope.checkAllChange = function () {
                for (var i in  $scope.prodects) {
                    $scope.prodects[i].isCheck = $scope.isAllChecked;
                }
            }

            $scope.itemChackChange = function () {
                var isAllSelect = true;
                for (var i in  $scope.prodects) {
                    if (!$scope.prodects[i].isCheck) {
                        isAllSelect = false
                    }
                }
                $scope.isAllChecked = isAllSelect;
            }

            $scope.getParams = function () {
                var param = modalData;
                if (param) {
                    alert('获取参数:' + param);
                }
            }

            $scope.closedialog = function () {
                var data = {'test': '关闭后的参数'}
                $uibModalInstance.close(data)
            }

            $scope.close = function () {
                $uibModalInstance.close();
            }

        }]);
    }
)