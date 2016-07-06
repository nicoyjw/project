<?php
/**
 * 在线订单操作工具类，负责核心的wsdl操作请求
 * @package
 * @license
 * @author seaqi
 * @contact 980522557@qq.com / xiayouqiao2008@163.com
 * @version $Id: class.orderonlinetool.php 2011-07-20 15:56:00
 */
class OrderOnlineTools {
	private static $soapClient;
	 

	public function __construct() {
		$fileName = 'Configuration.php';
		isset($GLOBALS[$fileName]) or (($GLOBALS[$fileName] = 1) and require $fileName);//替代require_once
		
		$fileName = 'Struct.php';
		isset($GLOBALS[$fileName]) or (($GLOBALS[$fileName] = 1) and require $fileName);

		if(is_null(self::$soapClient) || !is_object(self::$soapClient)) {//多次操作有明显效果
			try {
				self::$soapClient = new SoapClient(Configuration::ORDERS_TOOLS_URLS,array(true));//这里的联网时间长达99.99%【应按需请求】
			} catch (Exception $e) {
				if(Configuration::DEBUG) {
					printf("网络连接故障<br />Message = %s",$e->__toString());
				}
				exit();
			}
		}
	}
	
	private static function common($inputStructMethodName,$customerParameter) {
		try {
			$params = call_user_func_array(array('Struct',$inputStructMethodName),$customerParameter);
			
			$result = self::$soapClient->__soapCall($inputStructMethodName,array($params));

			$arr = Struct::outputStruct($result);
			
			if(is_array($arr) && !empty($arr)) {
				return $arr;
			} else {
				return false;
			}
			
		} catch (Exception $e) {
			if(Configuration::DEBUG) {
				printf("方法执行错误<br />Message = %s",$e->__toString());
			}
			exit();
		}
	}
	
	public function __call($inputStructMethodName,$customerParameter) {//依赖接口开发的原则【有没有？接口说得算】
		try {
			$tmp = self::$soapClient->__getFunctions();
			if(is_array($tmp)) {
				foreach($tmp as $theValue) {
					$pos = strpos(strtolower($theValue), strtolower($inputStructMethodName));
					if($pos === false) {
						continue;
					} else {
						return self::common($inputStructMethodName, $customerParameter);
					}
				}
				
				//以上没有正常return,说明没有找到指定方法
				throw new Exception('当前没有此服务方法，请检查方法名是否有误');
			} else {
				$pos = strpos($tmp, (string)$inputStructMethodName);
				if($pos === false)
					throw new Exception('当前没有此服务方法，请检查方法名是否有误');
				else
					return self::common($inputStructMethodName,$customerParameter);
			}
		} catch (Exception $e) {
			if(Configuration::DEBUG) {
				printf("检查方法时出错：<br />Message = %s",$e->__toString());
			}
			exit();
		}
	}
}








