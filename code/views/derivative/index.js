/*
* @Author: 刘玉洁
* @Date:   2016-05-17 18:17:34
* @Last Modified by:   Administrator
* @Last Modified time: 2016-05-20 18:23:25
*/
'use strict';

define([], function(){
	angular.module('derivativeIndexModule', [])
		.controller('derivativeIndexCtrl', [
			'$scope','$location','$http','$ui','blockUI',
			function($scope,$location,$http,$ui,blockUI){
				//最新汇率

				//blockUI
		        $scope.block = {
		            "conversionBlock": blockUI.instances.get('conversionBlock')
		        };
		        $scope.block.conversionBlock.start();

				//指向内容模板
				$scope.page = $location.search().page;
				$scope.pageUrl = 'derivative.'+$scope.page+'.tpl';
				//国家汇率
				$scope.exc_rate = {};

				//category-button
				$scope.category = [
					{
						"name": "运费试算",
						"page": "freight",
						"active": false
					},
					{
						"name": "最新汇率",
						"page": "exchangeRate",
						"active": false
					},
					{
						"name": "世界时间",
						"page": "worldTime",
						"active": false
					}
				];

				//同步左侧菜单状态
				for(var i=0; i<$scope.category.length; i++){
					$scope.category[i].active = $scope.category[i].page==$scope.page;
				}

				//cut category
				$scope.cutCategory = function(item,index){
					$scope.pageUrl = 'derivative.'+item.page+'.tpl';
					for(var i=0; i<$scope.category.length; i++){
						$scope.category[i].active = index-1==i;
					}
				}

				//获取国家代码
				$scope.getCountryCode = function(){
					$http.get('api/?model=user&action=country_code')
						.success(function(response,status,headers,config){
							if(response.reason=='查询成功'){
								$scope.exc_rate.original_country = response.result.list;
								$scope.exc_rate.target_country = angular.copy($scope.exc_rate.original_country);

								for(var i=0; i<$scope.exc_rate.original_country.length; i++){
									if($scope.exc_rate.original_country[i].code=='CNY'){
										$scope.original_code = $scope.exc_rate.original_country[i];
										break;
									}
								}
								for(var i=0; i<$scope.exc_rate.target_country.length; i++){
									if($scope.exc_rate.target_country[i].code=='USD'){
										$scope.target_code = $scope.exc_rate.target_country[i];
										break;
									}
								}

								$scope.getExchangeRate(
									$scope.original_code.code, 
									$scope.target_code.code, 
									$scope.exc_rate.original_price, 
									$scope.exc_rate.target_price);

							}else{
								$ui.error('货币国家获取失败，错误代码: '+response.error_code+', 错误原因: '+response.reason);
							}
						})
				}
				//换算汇率
				$scope.getExchangeRate = function(from,to,orig_p,tar_p,type){
					$http.get('api/?model=user&action=parities&from='+from+'&to='+to)
						.success(function(response,status,headers,config){
							$scope.block.conversionBlock.stop();
							if(response.reason=='successed'){
								if(type=='to'){
									$scope.exc_rate.target_price = tar_p || 1;
									$scope.exc_rate.original_price = response.result[1].result*$scope.exc_rate.target_price;
								}else{
									$scope.exc_rate.original_price = orig_p || 1;
									$scope.exc_rate.target_price = response.result[0].result*$scope.exc_rate.original_price;
								}
								$scope.exc_rate.updateTime = response.result[0].updateTime;
								$scope.exc_rate.error = false;
							}else{
								$ui.error('货币国家获取失败，错误代码: '+response.error_code+', 错误原因: '+response.reason);
							}
						})
				}
				$scope.getCountryCode();

				//改变国家
				$scope.changeCode = function(type, item){
					$scope.block.conversionBlock.start();
					if(type=='from')
						$scope.original_code = item;
					else
						$scope.target_code = item;


					if($scope.original_code.code==$scope.target_code.code){
						$scope.exc_rate.error = true;
						$scope.block.conversionBlock.stop();
						return;
					}

					$scope.getExchangeRate(
						$scope.original_code.code, 
						$scope.target_code.code, 
						$scope.exc_rate.original_price, 
						$scope.exc_rate.target_price);
					
				}

				//改变金额
				$scope.changePrice = function(type, item){
					$scope.block.conversionBlock.start();
					if(type=='from')
						$scope.exc_rate.original_price = item;
					else
						$scope.exc_rate.target_price = item;

					$scope.getExchangeRate(
						$scope.original_code.code, 
						$scope.target_code.code, 
						$scope.exc_rate.original_price, 
						$scope.exc_rate.target_price,
						type);
				}


				//世界时间
				$scope.timerID;

				function tzone(os, ds, cl){
				    this.ct = new Date(0);		// datetime
				    this.os = os;				// GMT offset
				    this.ds = ds;				// has daylight savings
				    this.cl = cl;				// font color
				}

				$scope.UpdateClocks = function(){
					var ct = new Array(
						new tzone(-10, 0, 'silver'),
						new tzone(-9, 1, 'silver'),
						new tzone(-8, 1, 'silver'),
						new tzone(-8, 1, 'silver'),
						new tzone(-8, 1, 'silver'),
						new tzone(-8, 1, 'silver'),
						new tzone(-7, 1, 'silver'),
						new tzone(-7, 1, 'silver'),
						new tzone(-7, 0, 'silver'),
						new tzone(-7, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-6, 0, 'silver'),
						new tzone(-6, 0, 'silver'),
						new tzone(-6, 0, 'silver'),
						new tzone(-6, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 0, 'silver'),
						new tzone(-5, 1, 'silver'),
						new tzone(-4, 1, 'silver'),
						new tzone(-4, 1, 'silver'),
						new tzone(-3.5, 1, 'silver'),
						new tzone(-3, 0, 'silver'),
						new tzone(-3, 1, 'silver'),
						new tzone(-3, 1, 'silver'),
						new tzone(-3, 1, 'silver'),
						new tzone(-3, 1, 'silver'),
						new tzone(0, 0, 'silver'),
						new tzone(0, 1, 'silver'),
						new tzone(0, 0, 'silver'),
						new tzone(0, 1, 'silver'),
						new tzone(0, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 0, 'silver'),
						new tzone(+1, 0, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+1, 1, 'silver'),
						new tzone(+2, 0, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 0, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 0, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+2, 1, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 1, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 1, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3, 0, 'silver'),
						new tzone(+3.5, 1, 'silver'),
						new tzone(+4, 0, 'silver'),
						new tzone(+4.5, 0, 'silver'),
						new tzone(+5, 0, 'silver'),
						new tzone(+5, 0, 'silver'),
						new tzone(+5, 0, 'silver'),
						new tzone(+5, 0, 'silver'),
						new tzone(+5.5, 0, 'silver'),
						new tzone(+5.5, 0, 'silver'),
						new tzone(+5.5, 0, 'silver'),
						new tzone(+5.75, 0, 'silver'),
						new tzone(+6, 0, 'silver'),
						new tzone(+6.5, 0, 'silver'),
						new tzone(+7, 0, 'silver'),
						new tzone(+7, 0, 'silver'),
						new tzone(+7, 0, 'silver'),
						new tzone(+7, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+8, 0, 'silver'),
						new tzone(+9, 0, 'silver'),
						new tzone(+9, 0, 'silver'),
						new tzone(+9.5, 0, 'silver'),
						new tzone(+10, 1, 'silver'),
						new tzone(+10, 0, 'silver'),
						new tzone(11, 1, 'silver'),
						new tzone(11, 1, 'silver'),
						new tzone(11, 1, 'silver'),
						new tzone(+9.5, 1, 'silver'),
						new tzone(+12, 1, 'silver'),
						new tzone(+12, 1, 'silver'),
						new tzone(+12, 0, 'silver'),
						new tzone(13, 1, 'silver'),
						new tzone(13.75, 1, 'silver'),
						new tzone(+14, 0, 'silver')
					);

				    var dt = new Date();		// [GMT] time according to machine clock
				    var startDST = new Date(dt.getFullYear(), 3, 1);

				    while (startDST.getDay() != 0)
				        startDST.setDate(startDST.getDate() + 1);

				    var endDST = new Date(dt.getFullYear(), 9, 31);

				    while (endDST.getDay() != 0)
				        endDST.setDate(endDST.getDate() - 1);

				    var ds_active;				// DS currently active
				    if (startDST < dt && dt < endDST)
				        ds_active = 1;
				    else
				        ds_active = 0;

				    var printstr = "";
				    var gmdt = new Date();

				    for (var n=0; n<ct.length; n++) 
				        ct[n].ct = new Date(gmdt.getTime() + ct[n].os * 3600 * 1000);

				    for(var i=0; i<ct.length; i++)
				    	$("#Clockk"+i).html("").html($scope.ClockString(ct[i].ct));

				    $scope.timerID = setTimeout($scope.UpdateClocks, 1001);

				}

				$scope.ClockString = function(dt){
				    var stemp;
				    var dt_year = dt.getUTCFullYear();
				    var dt_month = dt.getUTCMonth() + 1;
				    var dt_day = dt.getUTCDate();
				    var dt_hour = dt.getUTCHours();
				    var dt_minute = dt.getUTCMinutes();
				    var dt_second = dt.getUTCSeconds();
				    dt_year = dt_year.toString();

				    if (dt_minute < 10)
				        dt_minute = '0' + dt_minute;

				    if (dt_second < 10)
				        dt_second = '0' + dt_second;

				    stemp = dt_year + '年' + dt_month + '月' + dt_day + '日';
				    stemp = stemp + ' ' + dt_hour + ":" + dt_minute + ":" + dt_second;
				    return stemp;
				}

				setTimeout(function(){
					$scope.UpdateClocks();
				},10);

			}
		])
})