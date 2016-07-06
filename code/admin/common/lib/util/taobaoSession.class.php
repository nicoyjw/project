<?php
	/********************************************************************************
	  * AUTHOR: Vekincheng - ECPP SYSTEM (www.EPRSOFT.cn) *
	  *******************************************************************************/
set_time_limit(50000);

class taobaoSession
{
	private $appKey;
	private $sessions;
	private $appSecret;
	private $serverUrl = 'http://gw.api.taobao.com/router/rest?';
	public function __construct($appKey, $sessions, $appSecret)
	{
		$this->appKey = $appKey;
		$this->sessions = $sessions;
		$this->appSecret = $appSecret;
	}
	
	//签名函数 
	function createSign ($paramArr,$appSecret) { 
	    $sign = $appSecret; 
	    ksort($paramArr); 
	    foreach ($paramArr as $key => $val) { 
	       if ($key !='' && $val !='') { 
	           $sign .= $key.$val; 
	       } 
	    } 
	    $sign = strtoupper(md5($sign.$appSecret));
	    return $sign; 
	}

	//组参函数 
	function createStrParam ($paramArr) { 
	    $strParam = ''; 
	    foreach ($paramArr as $key => $val) { 
	       if ($key != '' && $val !='') { 
	           $strParam .= $key.'='.urlencode($val).'&'; 
	       } 
	    } 
	    return $strParam; 
	} 
	//获取数据兼容file_get_contents与curl
	function vita_get_url_content($url) {
		if(function_exists('file_get_contents')) {
			$file_contents = file_get_contents($url);
		} else {
		$ch = curl_init();
		$timeout = 5; 
		curl_setopt ($ch, CURLOPT_URL, $url);
		curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
		curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
		$file_contents = curl_exec($ch);
		curl_close($ch);
		}
	return $file_contents;
	}
	
	
	/**	sendHttpRequest
		Sends a HTTP request to the server for this session
		Input:	$requestBody
		Output:	The HTTP Response as a String
	*/
	public function sendHttpRequest($requestArr,$verb)
	{
		$sysArr = array(
			/* API系统级输入参数 Start */
				'method' => $verb,  //API名称
			   'session' => $this->sessions, //session
			 'timestamp' => date('Y-m-d H:i:s'),			
				'format' => 'xml',  //返回格式,本demo仅支持xml
			   'app_key' => $this->appKey,  //Appkey			
					 'v' => '2.0',   //API版本号		   
			'sign_method'=> 'md5' //签名方式			
		);
		$paramArr = array_merge($sysArr,$requestArr);
		$paramArr['session'] = $this->sessions;
		$sign = $this->createSign($paramArr,$this->appSecret);
		$strParam = $this->createStrParam($paramArr);
		$strParam .= 'sign='.$sign;
		$urls = $this->serverUrl.$strParam;
		while($cnt < 3 && ($result=$this->vita_get_url_content($urls))===FALSE) $cnt++;
		return $result;
	}
}
?>