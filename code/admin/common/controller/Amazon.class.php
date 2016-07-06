<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2010 - 2015  |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// |                       |
// +--------------------------------------------------------------+

/**
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */

class Amazon extends Controller  {

	/**
	 * 初始化页面信息
	 */
	public function __construct()
	{
		parent::__construct();
		$this->title .= 'Amazon';
		$this->dir = 'system';
	}

	/**
	 * amazon配置页面列表
	 */
	public function actionIndex()
	{
		parent::actionPrivilege('amazon_config');
		$this->tpl->assign('scheduletime',ModelDd::getComboData('amazon_schedule'));
		$this->tpl->assign('scheduletype',ModelDd::getComboData('amazon_report'));
		$this->tpl->assign('requesttype',ModelDd::getComboData('amazon_type'));
		$this->tpl->assign('amazonaccount',ModelDd::getComboData('amazonaccount'));
		$this->name = 'amazonconfig';
		$this->show();
	}

	/**
	 * 获得schdule列表数据
	 */
	public function actionList()
	{
		parent::actionTableList('amazon_schedule','ModelUser');
	}

	/**
	 * 保存schdule
	 */
	public function actionUpdate()
	{
		try{
			$object = new ModelChannel();
			$object->amazonshedule($_POST);
			echo '{success:true,msg:"新增成功,半小时内生效"}';exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
	}
	
	function actionreportRequest()
	{
		try{
			$object = new ModelChannel();
			$msg = $object->RequestReport($_POST);
			echo '{success:true,msg:"'.$msg.'"}';exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
	}
	
	/*******
	**订单report处理
	*******/
	function actionreport()
	{
		parent::actionPrivilege('load_amzorder');
		$this->tpl->assign('allaccount',ModelDd::getComboData('amazonaccount'));
		$this->dir = 'order';
		$this->name = 'amazonreport';
		$this->show();
	}
	/*******
	**产品report处理
	*******/
	function actionlisting()
	{
		parent::actionPrivilege('load_amzlisting');
		$this->tpl->assign('allaccount',ModelDd::getComboData('amazonaccount'));
		$this->dir = 'goods';
		$this->name = 'amazonreport';
		$this->show();
	}
	
	/******
	**request report
	******/
	function actionrequestreport()
	{
		try{
			$object = new ModelChannel();
			$object->amazonReportList($_POST['id']);
			echo '{success:true,msg:"加载完成"}';exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
	}
	function actiongetreportlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelMain();
		$where = $object->getreportwhere($_REQUEST);
		$list = $object->getreportList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getreportCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionloadreport()
	{
		try{
			$object = new ModelChannel();
			$object->loadamzreport($_GET['id']);
			echo '{success:true,msg:"加载完成"}';exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
	}
	
	function actiondownloadreport()
	{
			$object = new ModelChannel();
			$file = $object->getReportname($_GET['id']);
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
	}
	function actiontestamazon(){
		
		$query = 'Action=GetMyPriceForSKU&AWSAccessKeyId=AKIAJJJBHFKG5OUKBCSA&Timestamp=2014-03-13T21%3A31%3A58.000Z&Version=2011-10-01&SignatureVersion=2&SignatureMethod=HmacSHA256&Signature=8LVBzv0Kdvqy%2BKtRSVqKJVBmxX4W0sLto8QnCCNYTMk%3D';
        //$url = parse_url ('http://mws.amazonservices.com/Products/2011-10-01');
       
		$scheme = 'http://';
		$port = 80;
       

        
        $allHeaders['Content-Type'] = "text/xml"; 
		$allHeaders['Host'] = "mws.amazonservices.de";
		$allHeaders['AmazonJavascriptScratchpad/1.0 (Language=Javascript)'] = "application/x-www-form-urlencoded; charset=utf-8";
        $allHeadersStr = array();
        foreach($allHeaders as $name => $val) {
            $str = $name . ": ";
            if(isset($val)) {
                $str = $str . $val;
            }
            $allHeadersStr[] = $str;
        }
		
		$signatureVersion = '2';
        $algorithm = "HmacSHA1";
        $stringToSign = null;
        if (2 === $signatureVersion) {
            $algorithm = 'HmacSHA256';
            $parameters['SignatureMethod'] = $algorithm;
			
			
			
            $stringToSign = $this->_calculateStringToSignV2($parameters);
        } else {
            throw new Exception("Invalid Signature Version specified");
        }
        return $this->_sign($stringToSign, $key, $algorithm);
		
		
		
		$curlPost = array(
			'AWSAccessKeyId' => 'AKIAJJJBHFKG5OUKBCSA',
			'Action' => 'GetMyPriceForSKU',
			'SellerId' => 'A89A189AYQS12',
			'SignatureVersion' => '2',
			'Timestamp' => gmdate("Y-m-d\TH:i:s.\\0\\0\\0\\Z", time()),
			'Version' => '2011-10-01',
			
			'Signature' => 'rDj1MdRZktb%2BTdukKS%2B5PaJAcf%2BxSgSer6ah2FC17dA%3D',
			
			'SignatureMethod' => 'HmacSHA256',
			'MarketplaceId' => 'A1PA6795UKMFR9',
			'SellerSKUList.SellerSKU.1' => 'YDE-NAA14-02-009',
			
			);
		
		$this->_getParametersAsString($curlPost);
		
		
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'http://mws.amazonservices.de/Products/2011-10-01');
        curl_setopt($ch, CURLOPT_PORT,80);
       // $this->setSSLCurlOptions($ch);
        curl_setopt($ch, CURLOPT_USERAGENT, 'MarketplaceWebServiceProducts PHP5 Library');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $query);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $allHeadersStr);
        curl_setopt($ch, CURLOPT_HEADER, true); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
       
        $response = curl_exec($ch);
        if($response === false) {
            require_once ('Exception.php');
            $exProps["Message"] = curl_error($ch);
            $exProps["ErrorType"] = "HTTP";
            throw new MarketplaceWebServiceProducts_Exception($exProps);
        }

        curl_close($ch);
		
		
		
		
		
		
		
		
		
		
		/*var_dump( http_build_query($curlPost)) ;exit();
		'AWSAccessKeyId=AKIAJJJBHFKG5OUKBCSA&Action=GetMyPriceForSKU&MarketplaceId=A1PA6795UKMFR9&SellerId=A89A189AYQS12&SellerSKUList.SellerSKU.1=YDE-NAA14-02-009&SellerSKUList.SellerSKU.2=YDE-NAA14-02-111&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2014-03-13T19%3A21%3A14Z&Version=2011-10-01';*/
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
		curl_setopt($ch, CURLOPT_URL,'https://mws.amazonservices.de/Products/2011-10-01');
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
		$re=curl_exec($ch);
		
		var_dump($re);exit();
		curl_close($ch);
		
		$result=json_decode($re,true);
		
	}
	
    
    /**
     * Add authentication related and version parameters
     */
    function _addRequiredParameters(array $parameters)
    {
        $parameters['AWSAccessKeyId'] = $this->_awsAccessKeyId;
        $parameters['Timestamp'] = $this->_getFormattedTimestamp();
        $parameters['Version'] = self::SERVICE_VERSION;
        $parameters['SignatureVersion'] = $this->_config['SignatureVersion'];
        if ($parameters['SignatureVersion'] > 1) {
            $parameters['SignatureMethod'] = $this->_config['SignatureMethod'];
        }
        $parameters['Signature'] = $this->_signParameters($parameters, $this->_awsSecretAccessKey);

        return $parameters;
    }

    /**
     * Convert paremeters to Url encoded query string
     */
    function _getParametersAsString(array $parameters)
    {
        $queryParameters = array();
        foreach ($parameters as $key => $value) {
            $queryParameters[] = $key . '=' . $this->_urlencode($value);
        }
        return implode('&', $queryParameters);
    }


    /**
     * Computes RFC 2104-compliant HMAC signature for request parameters
     * Implements AWS Signature, as per following spec:
     *
     * If Signature Version is 0, it signs concatenated Action and Timestamp
     *
     * If Signature Version is 1, it performs the following:
     *
     * Sorts all  parameters (including SignatureVersion and excluding Signature,
     * the value of which is being created), ignoring case.
     *
     * Iterate over the sorted list and append the parameter name (in original case)
     * and then its value. It will not URL-encode the parameter values before
     * constructing this string. There are no separators.
     *
     * If Signature Version is 2, string to sign is based on following:
     *
     *    1. The HTTP Request Method followed by an ASCII newline (%0A)
     *    2. The HTTP Host header in the form of lowercase host, followed by an ASCII newline.
     *    3. The URL encoded HTTP absolute path component of the URI
     *       (up to but not including the query string parameters);
     *       if this is empty use a forward '/'. This parameter is followed by an ASCII newline.
     *    4. The concatenation of all query string components (names and values)
     *       as UTF-8 characters which are URL encoded as per RFC 3986
     *       (hex characters MUST be uppercase), sorted using lexicographic byte ordering.
     *       Parameter names are separated from their values by the '=' character
     *       (ASCII character 61), even if the value is empty.
     *       Pairs of parameter and values are separated by the '&' character (ASCII code 38).
     *
     */
    function _signParameters(array $parameters, $key) {
        $signatureVersion = $parameters['SignatureVersion'];
        $algorithm = "HmacSHA1";
        $stringToSign = null;
        if (2 === $signatureVersion) {
            $algorithm = $this->_config['SignatureMethod'];
            $parameters['SignatureMethod'] = $algorithm;
            $stringToSign = $this->_calculateStringToSignV2($parameters);
        } else {
            throw new Exception("Invalid Signature Version specified");
        }
        return $this->_sign($stringToSign, $key, $algorithm);
    }

    /**
     * Calculate String to Sign for SignatureVersion 2
     * @param array $parameters request parameters
     * @return String to Sign
     */
   function _calculateStringToSignV2(array $parameters) {
        $data = 'POST';
        $data .= "\n";
        $endpoint = parse_url ($this->_config['ServiceURL']);
        $data .= $endpoint['host'];
        $data .= "\n";
        $uri = array_key_exists('path', $endpoint) ? $endpoint['path'] : null;
        if (!isset ($uri)) {
            $uri = "/";
        }
        $uriencoded = implode("/", array_map(array($this, "_urlencode"), explode("/", $uri)));
        $data .= $uriencoded;
        $data .= "\n";
        uksort($parameters, 'strcmp');
        $data .= $this->_getParametersAsString($parameters);
        return $data;
    }

    function _urlencode($value) {
        return str_replace('%7E', '~', rawurlencode($value));
    }


    /**
     * Computes RFC 2104-compliant HMAC signature.
     */
    function _sign($data, $key, $algorithm)
    {
        if ($algorithm === 'HmacSHA1') {
            $hash = 'sha1';
        } else if ($algorithm === 'HmacSHA256') {
            $hash = 'sha256';
        } else {
            throw new Exception ("Non-supported signing method specified");
        }
        return base64_encode(
            hash_hmac($hash, $data, $key, true)
        );
    }


    /**
     * Formats date as ISO 8601 timestamp
     */
    function _getFormattedTimestamp()
    {
        return gmdate("Y-m-d\TH:i:s.\\0\\0\\0\\Z", time());
    }

    /**
     * Formats date as ISO 8601 timestamp
     */
    function getFormattedTimestamp($dateTime)
    {
        return $dateTime->format(DATE_ISO8601);
    }
}
?>