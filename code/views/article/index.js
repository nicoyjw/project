/*
* @Author: 刘玉洁
* @Date:   2016-05-13 15:48:05
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 16:07:45
*/
'use strict';

define([], function(){
	angular.module('articleIndexModule', [])
		.controller('articleIndexCtrl', [ 
			'$scope','$http','$location','blockUI','$rootScope',
			function($scope,$http,$location,blockUI,$rootScope){
				//init datas
				$scope.article = {};
				//blockUI
                $scope.block = {
                    "articleBlock": blockUI.instances.get('articleBlock')
                };
                $scope.block.articleBlock.start();

				$scope.getArticle = function(id){
					$http.get('api/?model=news&action=check_by_id&tab=news&id='+id)
	            		.success(function(response,status,headers,config){
	            			$scope.block.articleBlock.stop();
	            			if(response.success){
	            				//不知道为什么用ng-bind-html报错，ngSanitize模块已经加载过了，用jquery替代
	            				$scope.article = response.data;
	            				var content = $rootScope.lang=='cn' ? response.data.content : response.data.content_english;
	            				$("#content").html("").html(content);
	            			}
	            		});
				}
				$scope.getArticle($location.search().id);
			}
		])

})