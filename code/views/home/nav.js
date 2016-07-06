/*
* @Author: 刘玉洁
* @Date:   2016-05-11 14:33:03
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 18:13:06
*/
'use strict';

define([], function(){
	angular.module('homeNavModule', [])
		.controller('homeNavCtrl', [
			'$scope','$http','$data','$store','$ui',
			function($scope,$http,$data,$store,$ui){
				//获取logo等图片
				$scope.logoImages = $store.getJson('Images');

				//暂未开放
				$scope.notOpen = function(){
					var content = $store.get('lang')=='cn' ? '暂未开放, 敬请期待！' : 'to be continued';
					$ui.notify(content);
				}
			}
		])
		.directive('navActive', ['$location', function($location){
			return {
				restrict: 'EA',
				link: function(scope,element,attrs){

					scope.navActives = {
						"home": false,
						"about": false,
						"news": false
					}

					match();

					element.on('click', function(){
						match();
					});

					function match(){
						setTimeout(function(){
							var location = $location.path().split('/')[1];

							for(var i in scope.navActives)
								scope.navActives[i] = i==location;

						}, 10);
					}
					
				}
			}
		}])
})
