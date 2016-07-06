<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Ebay paypal类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelEbayaccount extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'ebay_account';
		$this->paypaltableName = CFG_DB_PREFIX . 'paypal_info';
		$this->paypalroottableName = CFG_DB_PREFIX . 'paypal_account';
	}
	
	/**
	 * 保存ebay account
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'site' => $info['site'],
				'cat_id' => $info['cat_id'],
				'type' => $info['type'],
				'url' => $info['url'],
				'account_name' => $info['account_name'],
				'devID' => $info['devID'],
				'appID' => $info['appID'],
				'certID' => $info['certID'],
				'userToken' => $info['userToken'],
				'APIDevUserID' =>$info['APIDevUserID'],
				'APIPassword' =>$info['APIPassword'],
				'APISellerUserID' =>$info['APISellerUserID'],
				'ac_token' => $info['ac_token'],
				're_token' => $info['re_token']
				));
			$id = $this->db->getInsertId();
		} else {
			$this->db->update($this->tableName,array(
                'site' => $info['site'],
                'cat_id' => $info['cat_id'],
                'type' => $info['type'],
                'url' => $info['url'],
                'account_name' => $info['account_name'],
                'devID' => $info['devID'],
                'appID' => $info['appID'],
                'certID' => $info['certID'],
                'userToken' => $info['userToken'],
                'APIDevUserID' =>$info['APIDevUserID'],
                'APIPassword' =>$info['APIPassword'],
                'APISellerUserID' =>$info['APISellerUserID'],     
				'ac_token' => $info['ac_token'],
				're_token' => $info['re_token'],
                
				),'id='.intval($info['id']));
			$id = $info['id'];
		}
		ModelDd::cacheEbay($id);
	}

	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function delete($ids)
	{
		$this->db->execute('delete from '.$this->tableName
				.' where id in ('.$ids.')');
		$id = explode(",",$ids);
		for($i = 0;$i<count($id);$i++){
			@unlink(CFG_PATH_DATA . 'ebay/ebay_' . $id[$i] .'.php');
			@unlink(CFG_PATH_DATA . 'ebay/eub_' . $id[$i] .'.php');
			@unlink(CFG_PATH_DATA . 'ebay/tb_' . $id[$i] .'.php');
			@unlink(CFG_PATH_DATA . 'ebay/az_' . $id[$i] .'.php');
            @unlink(CFG_PATH_DATA . 'ebay/ali_' . $id[$i] .'.php');
			@unlink(CFG_PATH_DATA . 'ebay/dh_' . $id[$i] .'.php');
		}
		ModelDd::cacheEbayaccount();
		ModelDd::cacheTaobaoaccount();
		ModelDd::cacheAmazonaccount();
        ModelDd::cacheAliaccount();
        ModelDd::cacheDHaccount();
		ModelDd::cacheMgaccount();
		ModelDd::cacheAllaccount();
	}

	
	/**
	 * 保存Paypal
	 *
	 * @param 对象ID $id
	 * @param 模块 $p_root_id,$p_name
	 */
	function paypalsave($info)
	{
		if (empty($info['p_id'])) {
			$this->db->insert($this->paypaltableName,array(
				'p_name' => $info['p_name'],
				'p_root_id' => $info['p_root_id']
				));
			$id = $this->db->getInsertId();
		} else {
			$this->db->update($this->paypaltableName,array(
				'p_name' => $info['p_name'],
				'p_root_id' => $info['p_root_id']
				),'p_id='.intval($info['p_id']));
			$id = $info['p_id'];
		}
		ModelDd::cachePaypal($id);
	}
	
	/**
	 * 删除paypal
	 *
	 * @param 对象ID $p_id
	 *
	 */
	function delPaypal($ids)
	{
		$this->db->execute('delete from '.$this->paypaltableName
				.' where p_id in ('.$ids.')');
		$id  = explode(",",$ids);
		for($i = 0;$i<count($id);$i++){
			unlink(CFG_PATH_DATA . 'ebay/paypal_' . $id[$i] .'.php');
		}
		echo "{success:true,msg:'OK'}";exit;
	}

	/**
	 * Paypal总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getPaypalCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->paypaltableName.$where);
	}
	/**
	 * 取Paypal列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getPaypalList($from,$to)
	{
		$this->db->open('select * from '.$this->paypaltableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}

	/**
	 * 保存Paypal主账号
	 *
	 * @param 对象ID $p_root_id
	 * @param 模块 $paypal_account, $username,$password,$signature
	 */
	function paypalrootsave($info)
	{
		if (empty($info['p_root_id'])) {
			$this->db->insert($this->paypalroottableName,array(
				'paypal_account' => $info['paypal_account'],
				'username' => $info['username'],
				'password' => $info['password'],
				'signature' => $info['signature']
				));
		} else {
			$this->db->update($this->paypalroottableName,array(
				'paypal_account' => $info['paypal_account'],
				'username' => $info['username'],
				'password' => $info['password'],
				'signature' => $info['signature']
				),'p_root_id='.intval($info['p_root_id']));
		}
		ModelDd::cachePaypal();
		$fp = fopen(CFG_PATH_DATA . 'ebay/' . $info['paypal_account'] .'.php', 'w');
		fputs($fp, '<?php'. chr(10) . ' $API_USERNAME= \''.$info['username'].'\';'.chr(10).' $API_PASSWORD = \''.$info['password'].'\';'.chr(10).' $API_SIGNATURE = \''.$info['signature'].'\';'.chr(10) . '?>');
		fclose($fp);
	}
	
	/**
	 * 删除paypal
	 *
	 * @param 对象ID $id
	 * @param 模块 $action_type_name
	 */
	function delPaypalRoot($ids)
	{
		$this->db->execute('delete from '.$this->paypalroottableName
				.' where p_root_id in ('.$ids.')');
		ModelDd::cachePaypal();
		echo "{success:true,msg:'OK'}";exit;
	}

	/**
	 * Paypal总账号总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getPaypalRootCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->paypalroottableName.$where);
	}
	/**
	 * 取Paypal总账号列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getPaypalRootList($from,$to)
	{
		$this->db->open('select * from '.$this->paypalroottableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取Account树状列表
	 * 
	 * @return  array  
	 */
	function acountTree(){
		$this->db->open('select id,account_name FROM '.$this->tableName.' where devID <>""');
		$trees = array();
		while ($rs = $this->db->next()) {
			$root = 'root';
			$trees[$root][] = array('id'=>$rs['id'],'text'=>$rs['account_name'],'leaf'=>true, 'cls'=>'file');
		}
		return $trees;
	}
	
	/****************
	*创建Ebay授权账户
	*@param string  $name
	*@return string $sessionid
	****************/
	function getEbaySession($name)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$verb = 'GetSessionID';
		require(CFG_PATH_LIB . 'ebay/ebay.php');
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
			if($rsxml=XML_unserialize($responseXml)){
				$getorder = $rsxml['GetSessionIDResponse'];
				if($getorder['Errors']&&($getorder['Errors']['ErrorCode'] !="16101") ){
						$errormsg = $getorder['Errors']['ErrorCode'] ." " .	$getorder['Errors']['ShortMessage'] ." " . @$getorder['Errors']['LongMessage'];
						throw new Exception($errormsg,'900');exit();
				}
			}else{
				throw new Exception('读取数据失败1','103');exit();
			}
		if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." WHERE account_name='".$name."'")>0){
				$this->db->update($this->tableName,array(
						'devID' => $devID,
						'appID' => $appID,
						'certID' => $certID,
						'userToken' =>$getorder['SessionID']
						),'account_name="'.$name.'"');
			}else{
				$this->db->insert($this->tableName,array(
						'account_name' => $name,
						'devID' => $devID,
						'appID' => $appID,
						'certID' => $certID,
						'userToken' =>$getorder['SessionID']
						));
			}
		return $getorder['SessionID'].'|'.$Runame;
	}
	/****************
	*获取Ebay授权token
	*@param string  $name
	****************/
	function completeebay($name)
	{
		$sessionid = $this->db->getValue('SELECT userToken FROM '.$this->tableName.' WHERE account_name="'.$name.'"');
		if(!$sessionid){
			throw new Exception('SessionId不存在，需删除账号重新开始申请','910');exit();
			}
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$verb = 'FetchToken';
		require(CFG_PATH_LIB . 'ebay/ebay.php');
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
			if($rsxml=XML_unserialize($responseXml)){
				$getorder = $rsxml['FetchTokenResponse'];
				if($getorder['Errors']&&($getorder['Errors']['ErrorCode'] !="16101") ){
						$errormsg = $getorder['Errors']['ErrorCode'] ." " .	$getorder['Errors']['ShortMessage'] ." " . @$getorder['Errors']['LongMessage'];
						throw new Exception($errormsg,'900');exit();
				}
			}else{
				throw new Exception('读取数据失败1','103');exit();
			}
		$this->db->update($this->tableName,array(
				'userToken' =>$getorder['eBayAuthToken']
				),'account_name="'.$name.'"');
		$id = $this->db->getValue("SELECT id FROM ".$this->tableName." where account_name='".$name."'");
		ModelDd::cacheEbay($id);
	}
	/****************
	*创建Taobao授权账户
	*@param string  $name
	*@return string $sessionid
	****************/
	function getTaobao($name)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$verb = 'GetSessionID';
		require(CFG_PATH_LIB . 'taobao/taobao.php');
		if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." WHERE account_name='".$name."'")>0){
				$this->db->update($this->tableName,array(
						'devID' => $appKey,
						'appID' => $appSecret
						),'account_name="'.$name.'"');
			}else{
				$this->db->insert($this->tableName,array(
						'account_name' => $name,
						'devID' => $appKey,
						'appID' => $appSecret
						));
			}
		return $appKey;
	}
	/****************
	*获取Taobao授权top_session
	*@param string  $name
	****************/
	function completetb($ts)
	{
		require(CFG_PATH_LIB . 'taobao/taobao.php');
		$num = $this->db->getValue("SELECT count(*) FROM ".$this->tableName." WHERE devID ='".$appKey."' AND (certID ='' or certID is null)");
		if($num > 1){
			throw new Exception('存在多个未授权淘宝账号,请先处理','910');exit();
			}
		if($num == 0){
			throw new Exception('无未授权淘宝账号,请先清空需授权账号certID','911');exit();
			}
		$this->db->update($this->tableName,array(
				'certID' =>$ts
				)," devID ='".$appKey."' AND (certID ='' or certID is null)");
		$id = $this->db->getValue("SELECT id FROM ".$this->tableName." where devID ='".$appKey."' AND (certID ='' or certID is null)");
		ModelDd::cacheEbay($id);
	}
	
	
	function checkeub($name)
	{
		$soapclient = new soapclient("http://epacketws.pushauction.net/orderservice.asmx?wsdl");//http://epacketws.pushauction.net/orderservice.asmx 
				$params = array("Version"=>"2.0.0",
								"APIDevUserID" => 'softsilkroadecpp', 
								"APIPassword" => '32837ISOHE6L3BX87R2QNEDYT6BMATEZQ8QM7WIPK37EUCO1L45IY2012114925',
								"APISellerUserID"=>$name
								);
						$pas = array("VerifyAPACShippingUserRequest"=>$params);
						$result = $soapclient->VerifyAPACShippingUser($pas);
		if($result->VerifyAPACShippingUserResult->Ack != 'Success') return '验证失败:'.$result->VerifyAPACShippingUserResult->Message;
		else return '验证成功';
	}
	function autotype()
	{
		$this->db->open("SELECT * FROM ".$this->tableName);
		require(CFG_PATH_LIB . 'taobao/taobao.php');
		while ($rs = $this->db->next()) {
			if($rs['userToken'] <>'') $this->db->execute("update ".$this->tableName." set type = 1 where id = ".$rs['id']);
			elseif($rs['devID'] == $appKey) $this->db->execute("update ".$this->tableName." set type = 3 where id = ".$rs['id']);
			elseif($rs['devID'] == '' && $rs['appID'] <> '')  $this->db->execute("update ".$this->tableName." set type = 2 where id = ".$rs['id']);
			elseif($rs['type'] == 4 && $rs['url'] <> '')   $this->db->execute("update ".$this->tableName." set type = 4 where id = ".$rs['id']);
			else   $this->db->execute("update ".$this->tableName." set type = 0 where id = ".$rs['id']);
		}
	}
	function autoptype()
	{
		$this->db->open("SELECT * FROM ".$this->paypalroottableName);
		while ($rs = $this->db->next()) {
		$fp = fopen(CFG_PATH_DATA . 'ebay/' . $rs['paypal_account'] .'.php', 'w');
		fputs($fp, '<?php'. chr(10) . ' $API_USERNAME= \''.$rs['username'].'\';'.chr(10).' $API_PASSWORD = \''.$rs['password'].'\';'.chr(10).' $API_SIGNATURE = \''.$rs['signature'].'\';'.chr(10) . '?>');
		fclose($fp);
		}
	}
	
}
?>