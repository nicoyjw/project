/*
* @Author: 刘玉洁
* @Date:   2016-05-13 15:48:05
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-19 17:32:45
*/
'use strict';

define([], function(){
	angular.module('newsIndexModule', [])
		.controller('newsIndexCtrl', [ 
			'$scope','$http','blockUI',
			function($scope,$http,blockUI){

				//init datas 
				$scope.news = {};
            	$scope.news.active = 0;
				$scope.currentPage = 1;
				$scope.pageSize = 10;

				//blockUI
                $scope.block = {
                    "newsListBlock": blockUI.instances.get('newsListBlock')
                };
                $scope.block.newsListBlock.start();

				//获取新闻分类
            	$scope.getCategory = function(){
	            	$http.get('api/?model=news&action=check_all&key=type&val=news&tab=classify')
	            		.success(function(response,status,headers,config){
	            			if(response.success){
	            				$scope.news.category = response.data;
	            				$scope.news.cId = response.data[0]._id.$id;
	            				$scope.getNews($scope.news.cId);
	            			}
	            		});
            	}
            	//获取新闻展示列表
            	$scope.getNews = function(cid){
	            	$http.get('api/?model=news&action=check_all&tab=news&key=pid&val='+cid+'&pi='+$scope.currentPage+'&ps='+$scope.pageSize)
	            		.success(function(response,status,headers,config){
	            			$scope.block.newsListBlock.stop();
	            			if(response.success){
	            				$scope.news.lists = response.data;

	            				//pagination
								$scope.totalItems = response.count;

	            			}
	            		});
            	}

            	$scope.getCategory();

            	//翻页
				$scope.pageChange = function (currentPage) {
					$scope.block.newsListBlock.start();
					$scope.currentPage = currentPage;
				    $scope.getNews($scope.news.cId);
				}

            	//切换新闻展示列表
            	$scope.cutNews = function(item,index){
            		$scope.block.newsListBlock.start();
            		$scope.news.active = index;
            		$scope.news.cId = item._id.$id;
            		$scope.getNews(item._id.$id);
            	}
				

				
			}
		])

})