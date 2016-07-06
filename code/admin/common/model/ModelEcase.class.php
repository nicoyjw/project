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
 * case操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelEcase extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'case';
		$this->FBtableName = CFG_DB_PREFIX . 'ebay_feedback';
	}
	
	/**
	 * 检查保存ebay订单文件
	 *
	 * @param string $name
	 * @param string $value
	 * @return bool
	 */
	function saveEbaycase($info)
	{
		require(CFG_PATH_LIB . 'util/xmlhandle.php');
		$data['start'] = $info["start"].'T00:00:00.000Z';
		$data['end'] = $info["end"].'T24:00:00.000Z';
		$verb = 'getUserCases';
		$page = 1;
		$hasmore = false;
		try {
				$this->saveEbayxml($info[id],$verb,1,$data);
		} catch (Exception $e) {
					throw new Exception('保存ebay case失败','499');exit();
		}
			$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info[id] .'_'.$page.'.xml');
			if($data=XML_unserialize($xml)){
				$getcase = $data['getUserCasesResponse'];
				if($getcase['errorMessage']){
						$errormsg = 'Ebay返回错误:'.$getcase['errorMessage']['error']['errorId'] ." " .	$getcase['errorMessage']['error']['message'];
						throw new Exception($errormsg,'400');exit();
				}
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
			$totalcount = ceil($getcase['paginationOutput']['totalEntries']/200);
		for($page = 2;$page <= $totalcount; $page++ ){
			try {
					$this->saveEbayxml($info[id],$verb,$page,$data);
			} catch (Exception $e) {
						throw new Exception('保存Page'.$page.'失败','999');exit();
			}
		}
		return $info[id].'|'.$totalcount.'|'.$getcase['paginationOutput']['totalEntries'];
		//return '1|0|0';
	}

	/**
	 * 保存ebay case文件XML文件
	 *
	 * @param string $id  ebay_account_id
	 * @param string $verb  ebay api type
	 * @param $page load page
	 * @param $data include what used to send
	 */
	static function saveEbayxml($id,$verb,$page,$data){
		require(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php');
		require(CFG_PATH_LIB . 'ebay/eBayresolutionSession.php');
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml';
		$session = new eBayresolutionSession($userToken, $serverUrl, $siteID, $verb);
		$responseXml = $session->sendHttpRequest($requestXmlBody);
		if(stristr($responseXml, 'HTTP 404') || $responseXml == '') {
			throw new Exception('发送请求失败','400');
			}
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
	}	

	/**
	 * 加载ebay Case XML文件
	 *
	 * @param string $info
	 * @return $counter 加载的数量
	 */
	function loadXml($info){
		require(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/getUserCases_'. $info['id'] .'_'.$info[page].'.xml');
			if($data=XML_unserialize($xml)){
				$getcase = $data['getUserCasesResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$counter = 0;
		$counter1 = 0;
		$Trans = (array_key_exists('caseId', $getcase['cases']['caseSummary']))?@$getcase['cases']:@$getcase['cases']['caseSummary'];
		foreach($Trans as $Transaction){
			$CreatedDate = MyDate::transform('timestamp',$Transaction['creationDate']);   //交易创建时间
			$caseid = $Transaction['caseId']['id'];
			$casetype = $Transaction['caseId']['type'];
			$UserID = @addslashes($Transaction['otherParty']['userId']);        //userid
			$lastmodifieddate = MyDate::transform('timestamp',$Transaction['lastModifiedDate']);
			if($casetype == 'CANCEL_TRANSACTION') $status = $Transaction['status']['cancelTransactionStatus'];
			if($casetype == 'EBP_INR') $status = $Transaction['status']['EBPINRStatus'];
			if($casetype == 'EBP_SNAD') $status = $Transaction['status']['EBPSNADStatus'];
			if($casetype == 'INR') $status = $Transaction['status']['INRStatus'];
			if($casetype == 'PAYPAL_INR') $status = $Transaction['status']['PaypalINRStatus'];
			if($casetype == 'PAYPAL_SNAD') $status = $Transaction['status']['PaypalSNADStatus>'];
			if($casetype == 'RETURN') $status = $Transaction['status']['returnStatus'];
			if($casetype == 'SNAD') $status = $Transaction['status']['SNADStatus'];
			$exsit = $this->db->getValue('SELECT lastmodifieddate FROM ' . $this->tableName.' where Sales_account_id = \''.$info['id'].'\' AND caseid = \''.$caseid.'\'');
			if($exsit) {
				if($lastmodifieddate>$exsit) {
					$this->db->update($this->tableName,array(
													'lastmodifieddate' => $lastmodifieddate,
													'status' => $status
													),'Sales_account_id = \''.$info['id'].'\' AND caseid = \''.$caseid.'\'');
				//if($casetype == 'EBP_INR'|| $casetype =='EBP_SNAD') $this->saveNote($caseid,$casetype,$info['id']);
				$counter1++;
				}
				continue;//已存在case
			}
			$itemId = $Transaction['item']['itemId'];
			$itemTitle = @addslashes($Transaction['item']['itemTitle']);
			$transactionId = $Transaction['item']['transactionId'];			
			$order_sn = $this->db->getValue('select n.order_sn from '.CFG_DB_PREFIX . 'order_goods as m left join '.CFG_DB_PREFIX.'order as n on m.order_id = n.order_id where m.TransactionID = \''.$transactionId.'\' AND n.userid = \''.$UserID.'\''); //获取关联订单号
				try {
				$this->db->insert($this->tableName, array(
							'order_sn' => $order_sn,
							'userId' => $UserID,
							'caseid' => $caseid,
							'casetype' => $casetype,
							'creatdate' => $CreatedDate,
							'lastmodifieddate' => $lastmodifieddate,
							'Sales_account_id' => $info['id'],
							'status' => $status,
							'itemId' => $itemId,
							'itemTitle' => $itemTitle,
							'transactionId' => $transactionId
							));
							} catch (Exception $e) {
						$msg = $e->getMessage();
						throw new Exception($msg.'保存订单失败,buyerid为'.$UserID,'999');
					}
				//if($casetype == 'EBP_INR'|| $casetype =='EBP_SNAD') $this->saveNote($caseid,$casetype,$info['id']);
				$counter++;
		}
		return $counter.'|'.$counter1;
	}
	/**
	*保存ebay dispute的内容
	*param string $caseid
	*param string $casetype
	*param int $accountid
	*/
	function saveNote($caseid,$casetype,$accountid)
	{
		$verb = 'getEBPCaseDetail';
		require(CFG_PATH_DATA . 'ebay/ebay_' . $accountid .'.php');
		require_once(CFG_PATH_LIB . 'ebay/eBayresolutionSession.php');
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$session = new eBayresolutionSession($userToken, $serverUrl, $siteID, $verb);
		$responseXml = $session->sendHttpRequest($requestXmlBody);
		$file = CFG_PATH_DATA . 'ebay/'.$caseid.'.xml';
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
	}

	function savefb($info)
	{
		set_time_limit(0);
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$verb = 'GetFeedback';
		$page = 1;
		$hasmore = false;
		try {
				$this->savexml($info['id'],$verb,$page);
		} catch (Exception $e) {
					throw new Exception('保存feedback订单文件失败','999');exit();
		}
		try{
				return $this->loadfbxml($info['id']);
		} catch (Exception $e) {
					throw new Exception($e->getMessage(),'999');exit();
		}
	}

	function loadfbxml($id)
	{
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/GetFeedback_'. $id .'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request['GetFeedbackResponse'];
				if($getorder['Errors']){
						$errormsg = $getorder['Errors']['ErrorCode'] ." " .	$getorder['Errors']['ShortMessage'] ." " . @$getorder['Errors']['LongMessage'];
						throw new Exception($errormsg,'900');exit();
				}
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$Trans = (@array_key_exists('FeedbackID', $getorder['FeedbackDetailArray']['FeedbackDetail']))?@$getorder['FeedbackDetailArray']:@$getorder['FeedbackDetailArray']['FeedbackDetail'];
		$i=0;
		foreach((array)$Trans as $Transaction){
			$info['FeedbackID'] =  $Transaction['FeedbackID'];
			if($this->db->getValue("SELECT count(*) FROM ".$this->FBtableName." WHERE Sales_account_id='".$id."' AND FeedbackID= '".$info['FeedbackID']."'")>0) return $i;
			$info['CommentingUser'] =  $Transaction['CommentingUser'];
			$info['CommentText'] =  $Transaction['CommentText'];
			$info['CommentType'] =  $Transaction['CommentType'];
			$info['CommentTime'] =  MyDate::transform('timestamp',$Transaction['CommentTime']);
			$info['FeedbackResponse'] =  @$Transaction['FeedbackResponse'];
			if($info['FeedbackResponse'] <>'') $info['answerstatus'] = 1;
			$info['ItemID'] =  $Transaction['ItemID'];
			$info['TransactionID'] =  @$Transaction['TransactionID'];
			if($info['TransactionID'] == '') $info['TransactionID']=0;
			$info['OrderLineItemID'] =  $Transaction['ItemID'].'-'.$Transaction['TransactionID'];
			$info['ItemTitle'] =  $Transaction['ItemTitle'];
			$info['ItemPrice'] =  @$Transaction['ItemPrice'];
			$info['addtime'] = CFG_TIME;
			$info['order_id'] = $this->db->getValue("SELECT m.order_id FROM ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id where m.OrderLineItemID ='".$info['OrderLineItemID']."' and n.Sales_account_id = '".$id."'");
			if(!$info['order_id']) $info['order_id']=0;
			$info['Sales_account_id'] = $id;
			$this->db->insert($this->FBtableName,addslashes_deep($info));
			$i++;
		}
		return $i;
	}

	/**
	 * 保存ebay订单文件XML文件
	 *
	 * @param string $id  ebay_account_id
	 * @param string $verb  ebay api type
	 * @param $page load page
	 * @param $data include what used to send
	 */
	static function savexml($id,$verb,$page=1){
		require(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php');
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id.'.xml';
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		$responseXml = $session->sendHttpRequest($requestXmlBody);
		if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400');
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
	}	


	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getfbWhere($info) {
		specConvert($info,array('keyword','answerstatus','accountid','key','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = 'CommentingUser=\''.$info['keyword'].'\'';
		}else{
			if ($info['answerstatus'] != 2 && $info['answerstatus'] !='') {
				$wheres[] = 'answerstatus=\''.$info['answerstatus'].'\'';
			}
			if ($info['accountid'] != 0 && $info['accountid'] != '') {
				$wheres[] = 'Sales_account_id=\''.$info['accountid'].'\'';
			}
			if ($info['fbtype'] != 0 && $info['fbtype'] != '') {
				$wheres[] = 'CommentType=\''.$info['fbtype'].'\'';
			}
			if ($info['order_id'] != 0 && $info['order_id'] != '') {
				$wheres[] = 'order_id=\''.$info['order_id'].'\'';
			}
			if ($info['key'] != '') {
				$wheres[] = 'CommentingUser=\''.$info['key'].'\' or CommentText like \'%'.$info['key'].'%\'';
			}
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'CommentTime between \''.date('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'CommentTime < \''.date('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'CommentTime > \''.date('timestamp',$info['starttime']).'\'';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	*获取message列表
	*
	*
	**/
	function getfbList($from,$to,$where=null){
		$this->db->open('select * from '.$this->FBtableName.$where.' order by CommentTime desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['CommentTime'] = date('Y-m-d',$rs['CommentTime']);
			$rs['endtime'] = date('Y-m-d',$rs['endtime']);
			$order_sn = $this->db->getValue("SELECT order_sn FROM ".CFG_DB_PREFIX."order where order_id ='".$rs['order_id']."'");
			if($order_sn) $rs['order_sn'] = CFG_ORDER_PREFIX.$order_sn;
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getfbCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->FBtableName.$where);
	}

	function changestatus($info)
	{
		$info['value'] = ($info['value'] == 1)?0:1;
		$this->db->update($this->FBtableName,array('answerstatus' => $info['value']),'id='.$info['id']);
	}
	function replyanswer($info)
	{
		$this->db->update($this->FBtableName,array('FeedbackResponse' => $info['value']),'id='.$info['id']);
		$data = $this->db->getValue('SELECT CommentingUser,FeedbackID,Sales_account_id,ItemID,FeedbackResponse,TransactionID,answerstatus FROM '.$this->FBtableName . ' where id ='.$info['id']);
		$verb = 'RespondToFeedback';
		$data['ResponseType'] = ($data['answerstatus'] == 0)?'Reply':'FollowUp';
		require_once(CFG_PATH_DATA . 'ebay/ebay_' . $data['Sales_account_id'] .'.php');
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		require_once(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
    	if(stristr($responseXml, 'HTTP 404') || $responseXml == ''){
			 throw new Exception('Error sending request','900');exit();
		}
		$responseDoc = new DomDocument();
		$responseDoc->loadXML($responseXml);
		$ack = $responseDoc->getElementsByTagName('Ack');
		$reack = $ack->item(0)->nodeValue;
		if($reack == 'Success'){
			$this->db->update($this->FBtableName,array('answerstatus' => 1),'id='.$info['id']);
		}else{
			$errors = $responseDoc->getElementsByTagName('Errors');
			$shortMsg = $errors->item(0)->getElementsByTagName('ShortMessage');
			$longMsg = $errors->item(0)->getElementsByTagName('LongMessage');
			throw new Exception('Feedback回复失败'.str_replace(">", "&gt;", str_replace("<", "&lt;", $longMsg->item(0)->nodeValue)),'905');exit();
		}
	}
	
	
	
}
?>