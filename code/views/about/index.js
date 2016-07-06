/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-26 14:32:44
*/
'use strict';

define([], function(){
	angular.module('aboutIndexModule', [])
		.controller('aboutIndexCtrl', [
			'$scope','$http','blockUI','$rootScope','$store',
			function($scope,$http,blockUI,$rootScope,$store){
				//获取logo等图片
				$scope.logoImages = $store.getJson('Images');

				//init datas 
				$scope.about = {};
            	$scope.about.active = 0;
            	//blockUI
                $scope.block = {
                    "contentBlock": blockUI.instances.get('contentBlock')
                };
                $scope.block.contentBlock.start();

            	//获取关于我们数据
            	$scope.getAbout = function(){
	            	$http.get('api/?model=news&action=check_all&key=type&val=aboutus&tab=news')
	            		.success(function(response,status,headers,config){
	            			$scope.block.contentBlock.stop();
	            			if(response.success){
	            				$scope.about.list = response.data;
	            				//不知道为什么用ng-bind-html报错，ngSanitize模块已经加载过了，用jquery替代
	            				var content = $rootScope.lang=='cn' ? response.data[0].content : response.data[0].content_english;
	            				$("#article").html("").html(content);
	            			}
	            		});  
            	}
            	$scope.getAbout();

            	//切换关于我们内容
            	$scope.cutAbout = function(item,index){
            		$scope.about.active = index;

            		var content = $rootScope.lang=='cn' ? $scope.about.list[index].content : $scope.about.list[index].content_english;
    				$("#article").html("").html(content);
            	}
			}
		])
})