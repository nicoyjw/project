/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 18:23:44
*/


'use strict';

define([], function () {
    angular.module('homeIndexModule', ['hls.ui.list'])
        .controller("homeIndexCtrl", [
        	'$scope', '$ui', '$http', 'blockUI', '$store', '$rootScope',
        	function ($scope, $ui, $http, blockUI, $store, $rootScope) {
        		//init datas
        		$scope.news = {};
        		$scope.ads = {};
                $scope.logistics = {};

                //blockUI
                $scope.block = {
                    "newsListBlock": blockUI.instances.get('newsListBlock'), 
                    "adsBlock": blockUI.instances.get('adsBlock'), 
                    "categoryBlock": blockUI.instances.get('categoryBlock') 
                };
                $scope.block.newsListBlock.start();
                $scope.block.adsBlock.start();
                $scope.block.categoryBlock.start();

                //获取logo等图片
                $scope.logoImages = $store.getJson('Images');

                //获取新闻分类
                $scope.getCategory = function(){
	            	$http.get('api/?model=news&action=check_all&key=type&val=news&tab=classify')
	            		.success(function(response,status,headers,config){
                            if(response.success){
                                $scope.news.category = response.data;
                                $scope.getNews(response.data[0]._id.$id);
                            }
                        });
                }
                //获取新闻展示列表
                $scope.getNews = function(cid){
                    $http.get('api/?model=news&action=check_all&tab=news&key=pid&val='+cid)
                        .success(function(response,status,headers,config){
                            $scope.block.newsListBlock.stop();
	            			if(response.success){
	            				$scope.news.lists = response.data;
	            			}
	            		});
            	}
            	$scope.getCategory();

            	//切换新闻展示列表
            	$scope.cutNews = function(item){
                    $scope.block.newsListBlock.start();
            		$scope.getNews(item._id.$id);
            	}

            	//广告列表
            	$scope.getAds = function(){
                    $http.get('api/?model=news&action=check_all&key=type&val=advertisement&tab=news')
                        .success(function(response,status,headers,config){
                            $scope.block.adsBlock.stop();
            				if(response.success){
            					$scope.ads = response.data;
            				}
            			})
            	}
            	$scope.getAds();

            	//物流分类&物流列表
            	$scope.getLogistic = function(){
            		$http.get('api/?model=news&action=check_all&key=type&val=logistics&tab=classify')
            			.success(function(response,status,headers,config){
            				if(response.success){
                                $scope.logistics.category = response.data;
            				}
            			});
                    $http.get('api/?model=news&action=check_all&key=type&val=logistics&tab=news')
                        .success(function(response,status,headers,config){
                            $scope.block.categoryBlock.stop();
                            if(response.success){
                                $scope.logistics.lists = response.data;
                            }
                        });
            	}
            	$scope.getLogistic();


        	}
        ])
})