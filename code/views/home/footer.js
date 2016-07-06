/*
* @Author: 刘玉洁
* @Date:   2016-05-11 14:33:03
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 17:16:20
*/
'use strict';

define([], function(){
	angular.module('homeFooterModule', [])
		.controller('homeFooterCtrl', [
			'$scope','$http','$store',
			function($scope,$http,$store){    
				//init datas
				$scope.footLinks = {};

				//获取logo等图片
                $scope.logoImages = $store.getJson('Images');

                $scope.lang = $store.get('lang');

				//获取footer内容项
				$scope.getFooter = function(){
					$http.get('api/?model=news&action=check_all&key=type&val=footlink&tab=news')
            			.success(function(response,status,headers,config){
            				if(response.success){
            					$scope.footLinks = response.data;
            					//组装数据
            					for(var i=0; i<$scope.footLinks.length; i++){
            						if($scope.footLinks[i].url==''){
            							$scope.footLinks[i].urlSelf = true;
            							$scope.footLinks[i].url = '#/article/index?id='+$scope.footLinks[i]._id.$id;
            						}
            					}
            				}
            			})
				}
				$scope.getFooter();

				$scope.forceRefresh = function(urlSelf){
					urlSelf&&window.location.reload();
				}

			}
		])
})
