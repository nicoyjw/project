<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 系统设置类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelSystem extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
	}
	
	/**
	 * 保存
	 *
	 * @param array $info
	 */
	function save($info)
	{
		$fp = fopen(CFG_PATH_CONF.'system/system.conf.php','w');
		fputs($fp,'<?php return '.var_export($info,true).';?>');
		fclose($fp);
		$fp = fopen(CFG_PATH_CONF . 'conf.php', 'w');
		fputs($fp, '<?php'.chr(10) );
		fputs($fp, 'define(\'CFG_ORDER_PREFIX\',\''.$info['CFG_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_P_ORDER_PREFIX\',\''.$info['CFG_P_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_P_RETURN_PREFIX\',\''.$info['CFG_P_RETURN_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_IN_ORDER_PREFIX\',\''.$info['CFG_IN_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_OUT_ORDER_PREFIX\',\''.$info['CFG_OUT_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CHECK_ORDER_PREFIX\',\''.$info['CFG_CHECK_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_RMA_ORDER_PREFIX\',\''.$info['CFG_RMA_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_RETURN_ORDER_PREFIX\',\''.$info['CFG_RETURN_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_GF_ORDER_PREFIX\',\''.$info['CFG_GF_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_RF_ORDER_PREFIX\',\''.$info['CFG_RF_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CF_ORDER_PREFIX\',\''.$info['CFG_CF_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DB_ORDER_PREFIX\',\''.$info['CFG_DB_ORDER_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_UPDATECOST\','.$info['CFG_GOODS_UPDATECOST'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODSSN_AUTOLENGTH\','.$info['CFG_GOODSSN_AUTOLENGTH'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_AUTO_FBA\','.$info['CFG_AUTO_FBA'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_COMBSPLIT\','.$info['CFG_GOODS_COMBSPLIT'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_CONCAT\',\''.$info['CFG_GOODS_CONCAT'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_QTYSIGN\',\''.$info['CFG_GOODS_QTYSIGN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_UPDATE_ORDER\','.$info['CFG_UPDATE_ORDER'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_REDUCE_QTY\','.$info['CFG_REDUCE_QTY'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_IGONRE_ORDER\','.$info['CFG_IGONRE_ORDER'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_CHECK_PAYPAL\','.$info['CFG_CHECK_PAYPAL'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_CHECK_SIS\','.$info['CFG_CHECK_SIS'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_COLLATION\','.$info['CFG_GOODS_COLLATION'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_UPDATEQTY\','.$info['CFG_GOODS_UPDATEQTY'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_OTHER_SKU\','.$info['CFG_OTHER_SKU'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_REPLACE_ADD\','.$info['CFG_REPLACE_ADD'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_STATUS\',\''.$info['CFG_GOODS_STATUS'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CAL_PRICE\',\''.$info['CFG_CAL_PRICE'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_SPLIT\','.$info['CFG_GOODS_SPLIT'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_EUB_MARK\','.$info['CFG_EUB_MARK'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_AUTOCREAT_SN\','.$info['CFG_AUTOCREAT_SN'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODS_CHECK\','.$info['CFG_GOODS_CHECK'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_EXPRESS_RULE\','.$info['CFG_EXPRESS_RULE'].');'.chr(10) );
        
		fputs($fp, 'define(\'CFG_ALI_KEYWORDTODEC\','.$info['CFG_ALI_KEYWORDTODEC'].');'.chr(10) );
        
		fputs($fp, 'define(\'CFG_GOODSSN_LENGTH\','.$info['CFG_GOODSSN_LENGTH'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODSSN_SPLIT\',\''.$info['CFG_GOODSSN_SPLIT'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CURRENCY\',\''.$info['CFG_CURRENCY'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_GOODSSN_PREFIX\',\''.$info['CFG_GOODSSN_PREFIX'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_PREFIX_GOODSSN\',\''.$info['CFG_PREFIX_GOODSSN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DEC_NAME\',\''.$info['CFG_DEC_NAME'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DEC_NAME_CN\',\''.$info['CFG_DEC_NAME_CN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DECLARED_VALUE\',\''.$info['CFG_DECLARED_VALUE'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DECLARED_WEIGHT\',\''.$info['CFG_DECLARED_WEIGHT'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_DECLARED_MAX\',\''.$info['CFG_DECLARED_MAX'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_4PX\','.$info['CFG_ENABLE_4PX'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_RETURN_4PX\','.$info['CFG_RETURN_4PX'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_EUB\','.$info['CFG_ENABLE_EUB'].');'.chr(10) );    
        fputs($fp, 'define(\'CFG_ENABLE_SFC\','.$info['CFG_ENABLE_SFC'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_CK1\','.$info['CFG_ENABLE_CK1'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_ICE\','.$info['CFG_ENABLE_ICE'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_EST\','.$info['CFG_ENABLE_EST'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_ZHY\','.$info['CFG_ENABLE_ZHY'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ENABLE_PYB\','.$info['CFG_ENABLE_PYB'].');'.chr(10) ); 
        fputs($fp, 'define(\'CFG_ENABLE_YW\','.$info['CFG_ENABLE_YW'].');'.chr(10) ); 
        fputs($fp, 'define(\'CFG_ENABLE_SY\','.$info['CFG_ENABLE_SY'].');'.chr(10) ); 
        fputs($fp, 'define(\'CFG_MORE_SHIPPINGS\','.$info['CFG_MORE_SHIPPINGS'].');'.chr(10) ); 
        fputs($fp, 'define(\'CFG_4PX_TOKEN\',\''.$info['CFG_4PX_TOKEN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_4PX_TOKEN2\',\''.$info['CFG_4PX_TOKEN2'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_SFC_ID\',\''.$info['CFG_SFC_ID'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_SFC_KEY\',\''.$info['CFG_SFC_KEY'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_SFC_TOKEN\',\''.$info['CFG_SFC_TOKEN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CK1_KEY\',\''.$info['CFG_CK1_KEY'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_CK1_TOKEN\',\''.$info['CFG_CK1_TOKEN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_EUB_TOKEN\',\''.$info['CFG_EUB_TOKEN'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_ALI_APPKEY\',\''.$info['CFG_ALI_APPKEY'].'\');'.chr(10) );
		fputs($fp, 'define(\'CFG_ALI_APPSECRET\',\''.$info['CFG_ALI_APPSECRET'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_IMPORT_CUSTOMS\','.$info['CFG_IMPORT_CUSTOMS'].');'.chr(10) );
		fputs($fp, 'define(\'CFG_DECLARED_ORDER_QTY_1\','.$info['CFG_DECLARED_ORDER_QTY_1'].');'.chr(10) );  
        fputs($fp, 'define(\'CFG_ALI_SPLITGOODS\','.$info['CFG_ALI_SPLITGOODS'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_EUB1_A4LABEL\','.$info['CFG_EUB1_A4LABEL'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_CK1_A4LABEL\','.$info['CFG_CK1_A4LABEL'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_CK1_LABELDEC\','.$info['CFG_CK1_LABELDEC'].');'.chr(10) ); 
        fputs($fp, 'define(\'CFG_TOKEN_EST\',\''.$info['CFG_EST_TOKEN'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_TOKEN_ICE\',\''.$info['CFG_TOKEN_ICE'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_TOKEN_ICE2\',\''.$info['CFG_TOKEN_ICE2'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_TOKEN_ZHY\',\''.$info['CFG_TOKEN_ZHY'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_ZHY_A4LABEL\','.$info['CFG_ZHY_A4LABEL'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_ZHY_LABELDEC\','.$info['CFG_ZHY_LABELDEC'].');'.chr(10) );
        fputs($fp, 'define(\'CFG_PYB_TOKEN\',\''.$info['CFG_PYB_TOKEN'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_PYB_TOKEN2\',\''.$info['CFG_PYB_TOKEN2'].'\');'.chr(10) );
        fputs($fp, 'define(\'CFG_YW_TOKEN\',\''.$info['CFG_YW_TOKEN'].'\');'.chr(10));
        fputs($fp, 'define(\'CFG_YW_TOKEN2\',\''.$info['CFG_YW_TOKEN2'].'\');'.chr(10));
        fputs($fp, 'define(\'CFG_YW_KEY\',\''.$info['CFG_YW_KEY'].'\');'.chr(10));                
        fputs($fp, 'define(\'CFG_YW_KEY2\',\''.$info['CFG_YW_KEY2'].'\');'.chr(10));                      
        fputs($fp, 'define(\'CFG_TOKEN_SY\',\''.$info['CFG_TOKEN_SY'].'\');'.chr(10));                
		fputs($fp, '?>');
		fclose($fp);
		$fp = fopen(CFG_PATH_DATA . 'ebay/eub_address.php', 'w');
		$arr1 = array(
			'Email' => $info['EUB_Email'],
			'Company' => $info['EUB_Company'],
			'Country' => $info['EUB_Country'],
			'Province' => $info['EUB_Province'],
			'City' => $info['EUB_City'],
			'District' => $info['EUB_District'],
			'Street' => $info['EUB_Street'],
			'Postcode' => $info['EUB_Postcode'],  
			'Contact' => $info['EUB_Contact'],  
			'Mobile' => $info['EUB_Mobile'],  
			'Phone' => $info['EUB_Phone']
		);
		$arr2 = array(
			'Email' => $info['EUB_EN_Email'],
			'Company' => $info['EUB_EN_Company'],
			'Country' => $info['EUB_EN_Country'],
			'Province' => $info['EUB_EN_Province'],
			'City' => $info['EUB_EN_City'],
			'District' => $info['EUB_EN_District'],
			'Street' => $info['EUB_EN_Street'],
			'Postcode' => $info['EUB_EN_Postcode'],  
			'Contact' => $info['EUB_EN_Contact'],  
			'Mobile' => $info['EUB_EN_Mobile'],  
			'Phone' => $info['EUB_EN_Phone']
		);
		$arr4 = array(
			'Email' => $info['EUB_CN_Email'],
			'Company' => $info['EUB_CN_Company'],
			'Country' => $info['EUB_CN_Country'],
			'Province' => $info['EUB_CN_Province'],
			'City' => $info['EUB_CN_City'],
			'District' => $info['EUB_CN_District'],
			'Street' => $info['EUB_CN_Street'],
			'Postcode' => $info['EUB_CN_Postcode'],  
			'Contact' => $info['EUB_CN_Contact'],  
			'Mobile' => $info['EUB_CN_Mobile'],  
			'Phone' => $info['EUB_CN_Phone']
		);
		fputs($fp, '<?php'.chr(10) );
		fputs($fp, '$params1 = '.var_export($arr1, true).';' .chr(10));
		fputs($fp, '$params2 = '.var_export($arr2, true).';' .chr(10));
		fputs($fp, '$params4 = '.var_export($arr4, true) .chr(10));
		fputs($fp, '?>');
	}
	/**
	 * 取设置
	 * @return array
	 */
	static function get($field=null)
	{
		$file = CFG_PATH_CONF.'system/system.conf.php';
		if(is_file($file)){
			$array = require(CFG_PATH_CONF.'system/system.conf.php');
			if ($field) {
				return $array[$field];
			}
			return $array;
		}else{
			header('location:index.php?model=login');
		}	
	}
	/**
	 * 取设置
	 * @return array
	 */
	static function getorderlumn()
	{
		$array = require(CFG_PATH_CONF.'ordercolumn.php');
		return $array;
	}
	
	
	function SendMail($add,$subject,$content)
	{
		$mailsetting = ModelDd::getArray("email_setting");
		$mail = new PHPMailer();
		$mail->IsMail();
		$mail->Host = $mailsetting['host'];
		$mail->Port = $mailsetting['port'];
		$mail->SMTPSecure = "ssl";
		$mail->CharSet 		= "utf-8";
		$mail->IsSMTP();
		$mail->SMTPAuth 	= true;				
		$mail->Username = $mailsetting['user'];  		                   
		$mail->Password = $mailsetting['pass'];	   		
		$mail->From 		= $mailsetting['reply'];     
		$mail->FromName 	= $mailsetting['from'];
		$mail->AddAddress($add);
		$mail->AddReplyTo($mailsetting['reply']);
		$mail->IsHTML(true);                                 
		$mail->WordWrap = 50;
		$mail->Subject = $subject;	
		$mail->Body    = $content;
		if($mail->Send()){
			return 'Success';	
			}else{
			return $mail->ErrorInfo;
		}
	}
	
	
	function getprintlogList($from,$to,$where=null)
	{
		$this->db->open('select * from '.CFG_DB_PREFIX.'order_print_log  order by addtime desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['admin_id'] = ModelDd::getCaption('user',$rs['admin_id']);
			$rs['addtime'] = MyDate::transform('standard',$rs['addtime']);
			$result[] = $rs;
		}
		return $result;
	}
	function getprintlogCount($where)
	{
		return  $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'order_print_log'); 
	}
	/*****************
	*清空订单相关表
	*
	****************/	
	function delorders()
	{
		try {
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order_collation');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order_combined');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order_goods');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order_log');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'order_print_log');
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*****************
	*清空paypal流水相关表
	*
	****************/	
	function delpaypals()
	{
		try {
		$this->db->execute("truncate ".CFG_DB_PREFIX.'paypal_order');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'paypal_order_goods');
		$this->db->execute("truncate ".CFG_DB_PREFIX.'paypal_transaction');
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*************
	***重新锁定订单库存
	
	*************/
	function clearlock($depot)
	{
		if($depot==0){
			$depotwhere = " AND shipping_id not in ( SELECT shipping_id FROM ".CFG_DB_PREFIX."shipping_depot where depot_id != 0)";
			}else{
			$depotwhere = " AND shipping_id in ( SELECT shipping_id FROM ".CFG_DB_PREFIX."shipping_depot where depot_id = '".$depot."')";
		}
		$order = new ModelOrder();
		$goods = new ModelGoods();
		try {
			$shelf_id = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main = 1 and depot_id=".$depot);
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock  set varstock = 0 where shelf_id =".$shelf_id);
			$orders = $this->db->select("SELECT order_id FROM ".CFG_DB_PREFIX."order where is_lock = 1 ".$depotwhere);
			for ($i=0;$i<count($orders);$i++) {
				$goodslist = $order->order_goods_info($orders[$i]);
				$orderinfo = $order->order_info($orders[$i]);
					for($j=0;$j<count($goodslist);$j++){//进行库存判断
						$no_control = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE SKU = \''.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH)
										.'\' AND is_control = 0');//无需管理库存
						if($no_control) continue;
							$goods_id = $goods->getidBySKU($goodslist[$j]['goods_sn']);
							$shelf_id = $goods->getshelfid($orderinfo['depot_id']);
							$goodsqty = $goods->getgoodsqty($goods_id,$orderinfo['depot_id'],$shelf_id);
							$goods->updatevarqty($goods_id,$orderinfo['depot_id'],$goodslist[$j]['goods_qty'],1);
					}			
			}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*************
	***删除订单记录
	
	*************/
	function delorderlog($time)
	{
		try {
			if($time == '') $this->db->execute("truncate ".CFG_DB_PREFIX."order_log");
			else {
					$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."order_log WHERE addtime <".MyDate::transform('timestamp',$time));
				}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*************
	***删除指定订单
	
	*************/
	function delorder($where)
	{
		try{
			$order_id = $this->db->SELECT("SELECT order_id FROM ".CFG_DB_PREFIX."order as m ".$where);
				if(count($order_id)>0){
					$ids = implode(",",$order_id);
					$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."order_goods WHERE order_id in( ".$ids.")");
					$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."order_log WHERE order_id in( ".$ids.")");
					$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."order WHERE order_id in( ".$ids.")");
				}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
		
	}
	/*************
	***清空产品锁定
	
	*************/
	function unlock($depot_id)
	{
		try {
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set varstock = 0 where shelf_id in(SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$depot_id.")");
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	
	function clearcat()
	{
		try {
			$this->db->execute("truncate ".CFG_DB_PREFIX."category");
			ModelDd::cacheCat();
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	function clearbrand()
	{
		try {
			$this->db->execute("truncate ".CFG_DB_PREFIX."brand");
			ModelDd::cacheBrand();
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*************
	***删除产品记录
	
	*************/
	function delgoodslog($time)
	{
		try {
			if($time == '') $this->db->execute("truncate ".CFG_DB_PREFIX."goods_log");
			else {
					$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods_log WHERE addtime <".MyDate::transform('timestamp',$time));
				}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errorMsg,'559');exit();
			}
	}
	/*************
	***删除产品
	
	*************/
	function delgoods($where)
	{
		if($where ==' where p.shelf_id = 0'){
			$this->db->execute("truncate ".CFG_DB_PREFIX.'goods');
			$this->db->execute("truncate ".CFG_DB_PREFIX.'goods_child');			
			$this->db->execute("truncate ".CFG_DB_PREFIX.'goods_combsplit');
			$this->db->execute("truncate ".CFG_DB_PREFIX.'goods_log');
			}else{
			$goods_id = $this->db->SELECT('select m.goods_id from '.CFG_DB_PREFIX.'goods as m left join '.CFG_DB_PREFIX.'depot_stock as p on m.goods_id = p.goods_id '.$where);
			$ids = implode(",",$goods_id);
			$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods_child WHERE goods_id in( ".$ids.")");
			$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods_combsplit WHERE goods_id in( ".$ids.")");
			$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods_log WHERE goods_id in( ".$ids.")");
			$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods WHERE goods_id in( ".$ids.")");
			$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."depot_stock WHERE goods_id in( ".$ids.")");
		}
	}
	/*************
	***自动匹配产品图片
	
	*************/
	function matchimg($info)
	{
		//$img_src = str_replace();
		$where = "";
		if($info['SKU']) $where = " WHERE SKU like '".$info['SKU']."%' or goods_sn like '".$info['SKU']."%'";
		$this->db->open("SELECT goods_id,sku,goods_img FROM ".CFG_DB_PREFIX."goods".$where);
		while ($rs = $this->db->next()) {
			$need_first =0;
			if(substr($rs['goods_img'],-14,14) == 'no_picture.gif' ||  $rs['goods_img']=='') $need_first = 1;
			$skuarr = explode("#",$rs['sku']);
			$img_src = str_replace('{SKU}',$skuarr[0],$info['img_src']);
			$i = 1;
			$t = 'A';
			$p = 'a';
			$img_src_num = str_replace('{num}',$i,$img_src);//数字1开始
			$img_src_abc = str_replace('{num}',$t,$img_src);//字母开始
			$img_src_abc1 = str_replace('{num}',$t,$img_src);//字母开始
			if(is_file(CFG_PATH_ROOT.$img_src_num)&&file_exists(CFG_PATH_ROOT.$img_src_num)){
				$img = $img_src_num;
				$m = $i;
			}elseif(is_file(CFG_PATH_ROOT.$img_src_abc)&&file_exists(CFG_PATH_ROOT.$img_src_abc)){
				$img =$img_src_abc;
				$m = $t;
			}elseif(is_file(CFG_PATH_ROOT.$img_src_abc)&&file_exists(CFG_PATH_ROOT.$img_src_abc)){
				$img =$img_src_abc1;
				$m = $p;
			}else{
				continue;	
			}
			if($need_first == 1 || $info['is_replace']){//更新主图片
				$this->db->update(CFG_DB_PREFIX."goods",array('goods_img'=>$img),'goods_id='.$rs['goods_id']);
				}
				while(is_file(CFG_PATH_ROOT.$img)&&file_exists(CFG_PATH_ROOT.$img)){
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_gallery WHERE goods_id =".$rs['goods_id']." AND url = '".$img."'")>0){
						$m++;
						$img = str_replace('{num}',$m,$img_src);
						 continue;
					}
					$this->db->insert(CFG_DB_PREFIX."goods_gallery",array('goods_id'=>$rs['goods_id'],'url'=>$img));
					$m++;
					$img = str_replace('{num}',$m,$img_src);
					}				
		}
		
	}
	
	function matchRemoteimg($info)
	{
		$where = "";
		if($info['SKU']) $where = " WHERE SKU like '".$info['SKU']."%' or goods_sn like '".$info['SKU']."%'";
		$this->db->open("SELECT goods_id,sku,goods_img FROM ".CFG_DB_PREFIX."goods".$where);
		while ($rs = $this->db->next()) {
			$need_first =0;
			if(substr($rs['goods_img'],-14,14) == 'no_picture.gif' ||  $rs['goods_img']=='') $need_first = 1;
			$img_src = str_replace('{SKU}',substr($rs['sku'],0,CFG_GOODSSN_LENGTH),$info['img_src']);
			if($info['num_e'] == '' && $info['num_s'] == ''){//为空直接替换
			$img = str_replace('{num}','',$img_src);
				if($need_first == 1 || $info['is_replace']) $this->db->update(CFG_DB_PREFIX."goods",array('goods_img'=>$img),'goods_id='.$rs['goods_id']);
				if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_gallery WHERE goods_id =".$rs['goods_id']." AND url = '".$img."'")>0) continue;
				$this->db->insert(CFG_DB_PREFIX."goods_gallery",array('goods_id'=>$rs['goods_id'],'url'=>$img));
				continue;
			}
			if(!($info['num_e'] >= $info['num_s'])) {throw new Exception('起始结束序号不对','559');exit();}
			if(is_numeric($info['num_s']) && is_numeric($info['num_e'])){//判断为整数
				for($i=$info['num_s'];$i<=$info['num_e'];$i++){
					$img = str_replace('{num}',$i,$img_src);
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_gallery WHERE goods_id =".$rs['goods_id']." AND url = '".$img."'")>0) continue;
					$this->db->insert(CFG_DB_PREFIX."goods_gallery",array('goods_id'=>$rs['goods_id'],'url'=>$img));
					}
				if($need_first == 1 || $info['is_replace']) $this->db->update(CFG_DB_PREFIX."goods",array('goods_img'=>str_replace('{num}',$info['num_s'],$img_src)),'goods_id='.$rs['goods_id']);
			}else{
				$sn = ord($info['num_s']);
				$en = ord($info['num_e']);
				if((($sn>64 && $sn <91) && ($en>64 && $en <91)) || (($sn>96 && $sn <123) && ($en>96 && $en <123))){ //大小写字母
				for($i=$info['num_s'];$i<=$info['num_e'];$i++){
					$img = str_replace('{num}',$i,$img_src);
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_gallery WHERE goods_id =".$rs['goods_id']." AND url = '".$img."'")>0) continue;
					$this->db->insert(CFG_DB_PREFIX."goods_gallery",array('goods_id'=>$rs['goods_id'],'url'=>$img));
					}
				if($need_first == 1 || $info['is_replace']) $this->db->update(CFG_DB_PREFIX."goods",array('goods_img'=>str_replace('{num}',$info['num_s'],$img_src)),'goods_id='.$rs['goods_id']);
				}else{
					throw new Exception('起始序号不是数字或字母','559');exit();
				}
			}
		}
	}
	
	function savecolumn($info){
		foreach($info as $k=>$v){
			$result =preg_split("/[_]+\d{1,2}/", $k);
			if($v==1) $str[substr($k,strlen($result[0])+1)] .= ",'".$result[0]."'";
		}
		foreach($str as $k=>$v)
		{
			$str[$k] = substr($v,1);
		}
		$fp = fopen(CFG_PATH_DATA.'dd/ordercolumn.php','w');
		fputs($fp,'<?php return '.var_export($str,true).';?>');
		fclose($fp);
		$fp = fopen(CFG_PATH_CONF.'ordercolumn.php','w');
		fputs($fp,'<?php return '.var_export($info,true).';?>');
		fclose($fp);
	}
	
	function exchageAMZtime($str)
	{
		$add = substr($str,-6,1);
		if($add == '+') $str = MyDate::transform('timestamp',$str)-(substr($str,-5,2)*3600);
		if($add == '-') $str = MyDate::transform('timestamp',$str)+(substr($str,-5,2)*3600);
		return $str;
	}
	function getClientList($from,$to,$where=null)
	{
		$this->db->open('select * from '.CFG_DB_PREFIX.'admin_user  order by user_id asc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			if($rs['company'] == 'test' || $rs['company'] == 'erp001' || $rs['company'] == 'erp002' || $rs['company'] == 'test1'){
				$rs['countorder'] = 0;
			}else{
				$rs['countorder'] = $this->getCountOrders(strtolower($rs['company']));
			}
			$rs['add_time'] = MyDate::transform('standard',$rs['add_time']);
			$rs['last_login'] = MyDate::transform('standard',$rs['last_login']);
			$result[] = $rs;
		}
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		return $result;
	}
	function getCountOrders($company){
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, $company, CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		return $query->getValue("select count(order_id) from ".CFG_DB_PREFIX."order");
	}
	function getClientCount($where)
	{
		
		return  $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'admin_user'); 
	}
	function saveclient($info){
		if(!$info['user_id']){
			set_time_limit(0);
			$action_list = '';
			//选择版本
			$action_list = 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,listing_support,list_goods_log,load_amzlisting,updateitem,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_all,order_stockout,order_unlcok,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,order_complete,load_amzorder,eub1_order_handle,edit_comorder,list_icehkpost,order_shippinged,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,import_supplier_goods,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog';
				
			$user = strtolower(addslashes(trim($info['company'])));
			$pass = md5((isset($info['pass']))?$info['pass']:'123456');
			$rs = $this->db->getValue("select user_name from ".CFG_DB_PREFIX."admin_user where user_name = '".$user."'");
            
            $datestr = date('Y',time());
            
            $eff_year = date('Y',time())+1 ;
            
            $effDate = $eff_year.date('-m-d H:i:s',time());
            
			if(!$rs){
				$inrs = $this->db->insert(CFG_DB_PREFIX."admin_user",array(
					'user_name' => $user,
					'email' => '',
					'password' => $pass,
					'add_time' => CFG_TIME,
					'last_login' => CFG_TIME,
					'last_ip' => 0,
					'action_list' =>$action_list,
					'role_id' => 1,
					'account_list' => 1,
					'company' => $user,
					'name' => addslashes(trim($info['name'])),
					'qq' => addslashes(trim($info['qq'])),
					'tel' => addslashes(trim($info['tel'])),
					'qqname' => addslashes(trim($info['qqname'])),
                    'versions' => 2,
					'eff_time' => $effDate
				));
				if($inrs){
						echo "用户创建成功<br>";
					}
				}else{
					exit("该用户已注册<br>");
				}
				if (!is_dir(CFG_PATH_CLIEN.$user)) {			
					if(mkdir(CFG_PATH_CLIEN.$user,0777)){
						echo "文件夹新建成功！<br>";
					}
				}
				if($this->xCopy('createfile/1',CFG_PATH_CLIEN.$user,1)) echo '导入文件成功<br>';
		copy("themes/default/template/order/orderprint.tpl","themes/default/template/order/orderprint_".$user.".tpl");
		chmod("themes/default/template/order/orderprint_".$user.".tpl",0777);
		$db_sql = "CREATE DATABASE  `".$user."` DEFAULT CHARACTER SET utf8";
		$db_creat = mysql_query($db_sql);
		if($db_creat){
			echo '数据库创建成功<br>';
			$this->mysql_import('createfile/1'.'/perp.sql',$user,CFG_PATH_ROOT);
			mysql_query("INSERT INTO `".CFG_DB_PREFIX."admin_user` ( `user_id`, `user_name`, `email`, `password`, `add_time`, `last_login`, `last_ip`, `action_list`, `role_id`, `account_list`,`company`) VALUES
( 1, '".$user."','admin@163.com', '".$pass."', 1284446489, 0, '', '".$action_list."', 1, 1,'".$user."')");
			echo '数据插入成功！';
				}
			}
		$arr = array (
		  0 => '1',
		  'user_id' => '1',
		  1 => $user,
		  'user_name' => $user,
		  2 => '',
		  'email' => '',
		  3 => 'e10adc3949ba59abbe56e057f20f883e',
		  'password' => 'e10adc3949ba59abbe56e057f20f883e',
		  4 => '1284446489',
		  'add_time' => '1284446489',
		  5 => '0',
		  'last_login' => '0',
		  6 => '',
		  'last_ip' => '',
		  7 => $action_list,
		  'action_list' => $action_list,
		  8 => '1',
		  'role_id' => '1',
		  9 => '1',
		  'account_list' => '1',
		  10 => $user,
		  'company' => $user,
		);
		$fp = fopen(CFG_PATH_CLIEN.$user.'/data/tmp/cache/user/1.php','w');
		chmod(CFG_PATH_CLIEN.$user.'/data/tmp/cache/user/1.php',0777);
		fputs($fp,'<?php return '.var_export($arr,true).';?>');
		fclose($fp);
		$fp = fopen(CFG_PATH_CLIEN.$user. '/data/dd/user.php', 'w');
		chmod(CFG_PATH_CLIEN.$user. '/data/dd/user.php',0777);
		fputs($fp, '<?php return '.var_export(array(1 => $user), true) . '; ?>');
		fclose($fp);
		
	}
	function mysql_import($file_name,$data_base,$file_dir){
		mysql_select_db($data_base);
		mysql_query("set names utf8");
		$get_sql_data = file_get_contents($file_name,$file_dir);
		$explode = explode(";",$get_sql_data);
		$cnt = count($explode);
		for($i=0;$i<$cnt;$i++){
			$sql = $explode[$i];
			$result = mysql_query($sql);	
			if($result){
				echo "-------OK<br>";
			}
		}
		return $query;
	}
	function xCopy($source, $destination, $child,$cover=0){   
	//用法：   
	// xCopy("feiy","feiy2",1):拷贝feiy下的文件到 feiy2,包括子目录   
	// xCopy("feiy","feiy2",0):拷贝feiy下的文件到 feiy2,不包括子目录   
	//参数说明：   
	// $source:源目录名   
	// $destination:目的目录名   
	// $child:复制时，是不是包含的子目录
		if(!is_dir($source)){   
			echo("Error:the $source is not a direction!");   
			return 0;   
		}   
		if(!is_dir($destination)){   
			@mkdir($destination,0777);   
		}   
	 
		$handle=dir($source);   
		while($entry=$handle->read()) {   
			if(($entry!=".")&&($entry!="..")){   
				if(is_dir($source."/".$entry)){   
				if($child)   
					$this->xCopy($source."/".$entry,$destination."/".$entry,$child,$cover);   
				}   
				else{
					if(!file_exists($destination."/".$entry) || $cover == 1) 
						{
							copy($source."/".$entry,$destination."/".$entry);
							//echo '文件复制成功<br>';
						}
				}   
			}   
		}   
		return 1;   
	} 
	function deleteclient($id){
		if($_SESSION['admin_name'] <> 'admin') throw new Exception('你没有此操作权限','559');exit();
		try {
			include(CFG_PATH_LIB.'util/FileSystem.class.php');
			$company = $this->db->getValue('SELECT company FROM '.CFG_PATH_ROOT.'admin_user WHERE user_id = '.$id);
			FileSystem::rm(array(CFG_PATH_ROOT."erp_client/".$company));
			$db_sql = "drop database ".$_SESSION['company'];
			$db_creat = mysql_query($db_sql);
			$this->db->execute('delete from '.CFG_DB_PREFIX .'admin_user where company = '.$company);
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
				throw new Exception($errorMsg,'559');exit();
		}
	}
	function insertsn($code){
		mysql_select_db('erp');
		mysql_query("set names utf8");
		$sql = "insert into myr_icesn (track_sn) values ('".$code."')";
		$rs = mysql_query($sql);
		if(!$rs){
			throw new Exception('写入失败','559');exit();
		}
	}
	function delaligoods($account){
		$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."aligoods WHERE account_id =".$account);
		$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."aliand_aligoods WHERE account_id =".$account);
	}
}
?>	