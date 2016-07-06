/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-26 14:39:33
*/
'use strict';

define(['angular-messages'], function(){
	angular.module('userLoginModule', ['ngMessages'])
		.controller('userLoginCtrl', [
			'$scope','$data','$request','$ui','$store',
			function($scope,$data,$request,$ui,$store){
				//获取logo等图片
				$scope.logoImages = $store.getJson('Images');

				//init datas
				$scope.user = {};

				$scope.submitted = false;
		        $scope.interacted = function(field) {
					return $scope.submitted || field.$dirty;
		        };

				//表单提交
				$scope.formSubmit = function(){

					if(!$scope.loginForm.$valid){
						$scope.submitted = true;
						return false;
					}

					var data = angular.copy($scope.user);
					data.password = $data.MD5(data.password);

					$request.post('api/?model=user&action=login',
					    data,
					    function(response) {
					        if (response.success) {
					            $scope.error = null;
					            delete response.data.checkimg;
					            $store.setUserInfo(response.data);
                            	window.location.href = '#/home/index';
                            	window.location.reload();
					        } else if (angular.isUndefined(response.success)) {
					            $scope.error = response;
					        } else {
					            $scope.error = response.error;
					        }
					    }, function (err) {
					        $ui.error('添加失败，' + err, '错误');
					    });
				}
			}
		])
})