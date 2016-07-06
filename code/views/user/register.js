/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 17:34:32
*/
'use strict';

define(['angular-messages'], function(){
	angular.module('userRegisterModule', ['ngMessages'])
		.controller('userRegisterCtrl', [
			'$scope','$request','$ui','$data','$store','$http',
			function($scope,$request,$ui,$data,$store,$http){

				//init datas
				$scope.user = {};

				//验证码
				$scope.verify = './api/view/img.php';
				//更换验证码
				$scope.changeVerify = function(){
					$scope.verify = $scope.verify+'?v='+Math.random();
				}

				$scope.submitted = false;
		        $scope.interacted = function(field) {
					return $scope.submitted || field.$dirty;
		        };

                //广告列表
            	$scope.getAds = function(){
                    $http.get('api/?model=news&action=check_all&key=type&val=advertisement&tab=news')
                        .success(function(response,status,headers,config){
            				if(response.success){
            					$scope.ad = response.data[0];
            				}
            			})
            	}
            	$scope.getAds();

				//表单提交
				$scope.formSubmit = function(){

					if(!$scope.regForm.$valid){
						$scope.submitted = true;
						return false;
					}

					var data = angular.copy($scope.user);
					delete data.confirmPassword;
					data.password = $data.MD5(data.password);

					$request.post('api/?model=user&action=register',
					    data,
					    function (response) {
					        if (response.success) {
					            $ui.notify('注册成功，请登录!', '提示', function () {
					                $ui.locatePart('/user/login');
					            });
					        } else if (angular.isUndefined(response.success)) {
					            $ui.error(response);
					        } else {
					            $ui.error(response.error);
					        }
					    }, function (err) {
					        $ui.error('添加失败，' + err, '错误');
					    });
				}
			}
		])
})