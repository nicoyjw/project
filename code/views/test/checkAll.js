/**
 * Created by Administrator on 2015/12/10.
 */
'use strict'
define([], function () {
        angular.module("testCheckAllModule", [])
            .controller('testCheckAllCtrl', ['$scope', function ($scope) {
                $scope.isAllChecked = false;
                $scope.prodects = [
                    {'Name': '手机1', 'price': 10, 'isCheck': false},
                    {'Name': '手机2', 'price': 10, 'isCheck': false},
                    {'Name': '手机3', 'price': 10, 'isCheck': false},
                    {'Name': '手机4', 'price': 10, 'isCheck': false},
                    {'Name': '手机5', 'price': 10, 'isCheck': false},
                    {'Name': '手机6', 'price': 10, 'isCheck': false}
                ];


                $scope.checkAllChange = function () {
                    for (var i in  $scope.prodects) {
                        $scope.prodects[i].isCheck = $scope.isAllChecked;
                    }
                }

                $scope.itemChackChange = function () {
                    var isAllSelect = true;
                    for (var i = 0; i < $scope.prodects.length; i++) {
                        if (!$scope.prodects[i].isCheck) {
                            isAllSelect = false
                        }
                    }
                    $scope.isAllChecked = isAllSelect;
                }


            }]);
    }
)