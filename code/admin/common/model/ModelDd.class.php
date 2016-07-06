<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Dd 后台字典类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelDd extends Model {

	/**
	 * 构造函数
	 * @param Object $db 数据查询类
	 * @access public
	 * @return void
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX.'dd';
		$this->primaryKey = 'id';
	}
	
	/**
	 * 返回字典项列表
	 * @param int $dd_id 字典ID
	 * @access public
	 * @return array
	 */
	public function getItemList($dd_id) {
		return $this->db->select('select * from '.CFG_DB_PREFIX.'dd_item where 
		     dd_id=' . intval($dd_id));
	}
	
	/**
	 * 检查唯一性
	 * @param int $info 字典项信息
	 * @access public
	 * @return array
	 */
	public function checkUnique($info) {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'dd_item where (di_value=\''
				 . $info['di_value'] . '\' or di_caption=\''.$info['di_caption'] 
				 . '\') and dd_id=' . intval($info['dd_id'])
				  . ' and id!=' . intval($info['di_id']));
	}
	/**
	 * 保存字典项信息
	 * @param array $info 字典项信息
	 * @access public
	 * @return void
	 */
	public function save($info) {
		specConvert($info,array('di_caption'));
		if ($this->checkUnique($info)) {
			throw new Exception('值或名称已经存在！');
		}
		if ($info['di_id']) {
			$this->db->update(CFG_DB_PREFIX.'dd_item', array (
						'di_value' => $info['di_value'],
						'di_caption' => $info['di_caption'],
						),'id=' . intval($info['di_id'])
					);
		} else {
			$this->db->insert(CFG_DB_PREFIX.'dd_item', array(
						'dd_id' => intval($info['dd_id']),
						'di_value' => intval($info['di_value']),
						'di_caption' => $info['di_caption'],
						)
					);
			$info['di_id'] = $this->db->getInsertId();
		}
		$this->cache($info['dd_id']);
		return $info;
	} 
	
	/**
	 * 删除字典项
	 * @param mixed $users 字典项ID
	 * @access public
	 * @return bool
	 */
	public function delete($dds) {
		$where = 'id in (' . $dds . ')';
		$dd_id = $this->db->getValue('select dd_id from '.CFG_DB_PREFIX.'dd_item 
		    where ' . $where);
		$this->db->execute('delete from '.CFG_DB_PREFIX.'dd_item where ' . $where);
		$this->cache($dd_id);
	}
	
	/**
	 * 缓存字典信息
	 * @param int $dd_id 字典ID
	 * @access public
	 * @return void
	 */
	public function cache($dd_id=0,$dd_name=null) {
		$dd_id = intval($dd_id);
		if ($dd_name) {
			$dd_id = $this->db->getValue('select id from '.CFG_DB_PREFIX.'dd where dd_name=\'' . $dd_name.'\'');
			/*if (!$dd_id) {
				throw new Exception($dd_name.'不存在');
			}*/
		} else {
			$dd_name = $this->db->getValue('select dd_name from '.CFG_DB_PREFIX.'dd where id=' . $dd_id);
		}
		
		$array = $this->db->select('select di_value,di_caption from '.CFG_DB_PREFIX.'dd_item where 
				dd_id=' . $dd_id.' order by id', 'hashmap');
		if(!$array){
            $array = array();        
        }
		$fp = fopen(CFG_PATH_DATA . 'dd/' . $dd_name .'.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}

	/**
	 * 缓存Menu信息
	 * @param 
	 * @access public
	 * @return void
	 */
	public function cacheMenu() {
		$userlist = $this->db->select("SELECT user_id FROM ".CFG_DB_PREFIX."admin_user");
		for($i=0;$i<count($userlist);$i++)
		{
			ModelDd::cacheUsermenu($userlist[$i]);	
		}
	}
	
	public function cacheUsermenu($id)
	{
        
        
        /**当前用户的权限**/
        $selfQuery = ModelUser::connectSelfDb();
		$action = explode(",",$selfQuery->getValue("SELECT action_list FROM ".CFG_DB_PREFIX."admin_user WHERE user_id = ".$id));
        
        /*获取主表的菜单*/
        $query = ModelUser::connectErpDb();
        $icemenuroot = $query->select('select * FROM '.CFG_DB_PREFIX . 'menu where root = "root" order by sortnum asc');
        
        $fp = fopen(CFG_PATH_CONF . 'tree.cfg_'.$id.'.php', 'w');
        fputs($fp, '<?php'.chr(10) );
        
        for($i=0;$i<count($icemenuroot);$i++){
            $has_child = $query->getValue('select count(*) from '.CFG_DB_PREFIX . 'menu where root ='.$icemenuroot[$i]['id']);
              
            $icemenuroot[$i]['leaf'] = ($has_child == 0)?'true':'false';
            $icemenuroot[$i]['cls'] = ($has_child == 0)?'file':'folder';
            $is_show =0;
            if($has_child){         
                $list = $query->select('select * FROM '.CFG_DB_PREFIX . 'menu where root ='.$icemenuroot[$i]['id'].' order by sortnum,id');
                //return var_dump($list).'---';
                for ($j=0;$j<count($list);$j++) {
                    $son_has_child = $query->getValue('select count(*) from '.CFG_DB_PREFIX . 'menu where root ='.$list[$j]['id']);
                    if($son_has_child){ 
                        if(in_array($list[$j]['code'],$action)||$list[$j]['code'] =='') {
                            fputs($fp, '$trees[\''.$icemenuroot[$i]['id'].'\'][]=array(\'id\' =>\''. $list[$j]['id'] . '\',\'text\' =>\''. $list[$j]['text'] . '\',\'leaf\' =>false,\'cls\' =>\'folder\',\'model\' =>\''. $list[$j]['model'] . '\',\'action\' =>\''. $list[$j]['action'] . '\',\'root\' =>\''. $icemenuroot[$i]['id'] . '\');'.chr(10));
                            $is_show = 1;
                        } 
                        $son_list =  $query->select('select * FROM '.CFG_DB_PREFIX . 'menu where root ='.$list[$j]['id'].' order by sortnum,id');
                        for($s=0;$s<count($son_list);$s++){
                            fputs($fp, '$trees[\''.$list[$j]['id'].'\'][]=array(\'id\' =>\''. $son_list[$s]['id'] . '\',\'text\' =>\''. $son_list[$s]['text'] . '\',\'leaf\' =>true,\'cls\' =>\'file\',\'model\' =>\''. $son_list[$s]['model'] . '\',\'action\' =>\''. $son_list[$s]['action'] . '\',\'root\' =>\''. $list[$j]['id'] . '\');'.chr(10));
    
                        }                                            
                    }else{
                       if(in_array($list[$j]['code'],$action)||$list[$j]['code'] =='') {
                            fputs($fp, '$trees[\''.$icemenuroot[$i]['id'].'\'][]=array(\'id\' =>\''. $list[$j]['id'] . '\',\'text\' =>\''. $list[$j]['text'] . '\',\'leaf\' =>true,\'cls\' =>\'file\',\'model\' =>\''. $list[$j]['model'] . '\',\'action\' =>\''. $list[$j]['action'] . '\',\'root\' =>\''. $icemenuroot[$i]['id'] . '\');'.chr(10));
                            $is_show = 1;
                        } 
                    }
                    
                }
            }
            if($is_show) fputs($fp, '$trees[\'root\'][]=array(\'id\' =>\''. $icemenuroot[$i]['id'] . '\',\'text\' =>\''. $icemenuroot[$i]['text'] . '\',\'leaf\' =>'. $icemenuroot[$i]['leaf'] . ',\'cls\' =>\''. $icemenuroot[$i]['cls'] . '\',\'model\' =>\''. $icemenuroot[$i]['model'] . '\',\'action\' =>\''. $icemenuroot[$i]['action'] . '\',\'root\' =>\''. $icemenuroot[$i]['root'] . '\');'.chr(10));
            
        }
        fputs($fp, '?>');
        fclose($fp);
        //$this->db->open('select * FROM '.CFG_DB_PREFIX . 'menu where root = "root" order by sortnum asc');
		
		/*while ($rs = $this->db->next()) {
		    $has_child = $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'menu where root ='.$rs['id']);
		    $rs['leaf'] = ($has_child == 0)?'true':'false';
		    $rs['cls'] = ($has_child == 0)?'file':'folder';
		    $is_show =0;
		    if($has_child){
			    $list = $this->db->select('select * FROM '.CFG_DB_PREFIX . 'menu where root ='.$rs['id'].' order by sortnum,id');
				    for ($i=0;$i<count($list);$i++) {
					    if(in_array($list[$i]['code'],$action)||$list[$i]['code'] =='') {
						    fputs($fp, '$trees[\''.$rs['id'].'\'][]=array(\'id\' =>\''. $list[$i]['id'] . '\',\'text\' =>\''. $list[$i]['text'] . '\',\'leaf\' =>true,\'cls\' =>\'file\',\'model\' =>\''. $list[$i]['model'] . '\',\'action\' =>\''. $list[$i]['action'] . '\',\'root\' =>\''. $list[$i]['root'] . '\');'.chr(10));
						    $is_show = 1;
					    }
				    }
			    }
		    if($is_show) fputs($fp, '$trees[\'root\'][]=array(\'id\' =>\''. $rs['id'] . '\',\'text\' =>\''. $rs['text'] . '\',\'leaf\' =>'. $rs['leaf'] . ',\'cls\' =>\''. $rs['cls'] . '\',\'model\' =>\''. $rs['model'] . '\',\'action\' =>\''. $rs['action'] . '\',\'root\' =>\''. $rs['root'] . '\');'.chr(10));
		}*/
		
	}
	

	/**
	 * 缓存Currency信息
	 * @param 
	 * @access public
	 * @return void
	 */
	public function cacheCurrency() {
		$this->db->open('select currency,rate FROM '.CFG_DB_PREFIX . 'currency');
		$fp = fopen(CFG_PATH_DATA . 'dd/currency.php', 'w');
		fputs($fp, '<?php'.chr(10) );
		while ($rs = $this->db->next()) {
		fputs($fp, '$currency[\''.$rs['currency'].'\'] = \''. $rs['rate'] . '\';'.chr(10));
		}
		fputs($fp, '?>');
		fclose($fp);
	}

	/**
	 * 缓存sales信息
	 * @param 
	 * @access public
	 * @return void
	 */
	public function cacheSales() {
		$array = $this->db->select('select id,name from '.CFG_DB_PREFIX.'sales', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/sales.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 缓存渠道费率信息
	 * @param 
	 * @access public
	 * @return void
	 */
	public function cachechannelrate() {
		$array = $this->db->select('select sales_channels,rate from '.CFG_DB_PREFIX.'sales_channels_rate', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/channelrate.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}


	/**
	 * 缓存订单状态信息
	 * @access public
	 * @return void
	 */
	public function cacheorderStatus() {
		
		$array = $this->db->select('select id,status from '.CFG_DB_PREFIX.'order_status', 'hashmap');
		$array[0] = '无';
		$fp = fopen(CFG_PATH_DATA . 'dd/orderstatus.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}

	/**
	 * 缓存产品分类(去主类)
	 * @access public
	 * @return void
	 */
	public function cacheCat() {
		$array = $this->db->select('select cat_id,cat_name from '.CFG_DB_PREFIX.'category', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/goods_cat.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 缓存产品品牌信息
	 * @access public
	 * @return void
	 */
	public function cacheBrand() {
		
		$array = $this->db->select('select brand_id,brand_name from '.CFG_DB_PREFIX.'brand order by brand_name', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/goods_brand.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 缓存模板信息
	 * @access public
	 * @return void
	 */
	public function cacheTemplate() {
		
		$array = $this->db->select('select rec_id,temp_name from '.CFG_DB_PREFIX.'template where cat_id = 1 order by temp_sn', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/message_template.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
		$array = $this->db->select('select rec_id,temp_name from '.CFG_DB_PREFIX.'template where cat_id = 2 order by temp_sn', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/parnter_template.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}


	/**
	 * 缓存Ebay账号信息
	 * @param int $id
	 * @access public
	 * @return void
	 */
	public function cacheEbay($id) {
		require(CFG_PATH_LIB . 'taobao/taobao.php');
		$array = $this->db->getValue('select devID,appID,certID,userToken,APIDevUserID,APIPassword,APISellerUserID,site,cat_id,type,url,ac_token,re_token FROM '.CFG_DB_PREFIX . 'ebay_account where id='  . intval($id));
		if($array['userToken'] <>''){
		$fp = fopen(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php', 'w');
		fputs($fp, '<?php'. chr(10) . ' $devID =\''.$array['devID'].'\';'.chr(10).' $appID = \''.$array['appID'].'\';'.chr(10).' $certID = \''.$array['certID'].'\';'.chr(10).' $userToken = \''.$array['userToken'].'\';'. chr(10).' $cat_id = \''.$array['cat_id'].'\';'. chr(10) . '?>');
		fclose($fp);
		ModelDd::cacheEbayaccount();
		}
		if($array['devID'] == $appKey) {
			$fp = fopen(CFG_PATH_DATA . 'ebay/tb_' . $id .'.php', 'w');
			fputs($fp, '<?php'. chr(10) . ' $appKey =\''.$array['devID'].'\';'.chr(10).' $sessions = \''.$array['certID'].'\';'.chr(10).' $appSecret = \''.$array['appID'].'\';'.chr(10) . '?>');
			fclose($fp);
			ModelDd::cacheTaobaoaccount();
		}
		if($array['devID'] == '' && $array['appID'] <> '') {
			$fp = fopen(CFG_PATH_DATA . 'ebay/az_' . $id .'.php', 'w');
			fputs($fp, '<?php'. chr(10) . ' $MERCHANT_ID =\''.$array['appID'].'\';'.chr(10).' $MARKETPLACE_ID = \''.$array['certID'].'\';'.chr(10). ' $site =\''.$array['site'].'\';'.chr(10).' $serviceUrl = "'.ModelDd::switchsite($array['site']).'";'.chr(10).'?>');
			fclose($fp);
			ModelDd::cacheAmazonaccount();
		}
		if($array['type'] == 4 && $array['url'] <> '') {
			$fp = fopen(CFG_PATH_DATA . 'ebay/zc_' . $id .'.php', 'w');
			fputs($fp, '<?php'. chr(10) . ' $url = "'.$array['url'].'";'.chr(10).'?>');
			fclose($fp);
			ModelDd::cacheZcaccount();
		}
        if($array['type'] == 6) {
            if(is_file(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php')){
                include_once(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
            }else{
                 $passtime = time();
                 $longpasstime = time()+60*60*24*50;;
            }
            $fp = fopen(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php', 'w');                  
            fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$array['ac_token'].'\';'.chr(10).' $refresh_token =\''.$array['re_token'].'\';'.chr(10).' $APIDevUserID =\''.$array['APIDevUserID'].'\';'.chr(10). ' $APIPassword =\''.$array['APIPassword'].'\';'.chr(10). ' $aliId =\''.$array['appID'].'\';'.chr(10). ' $resource_owner =\''.$array['devID'].'\';'.chr(10). ' $passtime = '.$passtime.';'.chr(10). ' $longpasstime = '.$longpasstime.';'.chr(10). '?>');
            fclose($fp);                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            ModelDd::cacheAliaccount();
        }
        if($array['APIDevUserID'] <> '' && $array['APIPassword'] <> '' && $array['APISellerUserID'] <> ''){
            $fp = fopen(CFG_PATH_DATA . 'ebay/eub_' . $id .'.php', 'w');
            fputs($fp, '<?php'. chr(10) . ' $APIDevUserID =\''.$array['APIDevUserID'].'\';'.chr(10).' $APIPassword = \''.$array['APIPassword'].'\';'.chr(10).' $APISellerUserID = \''.$array['APISellerUserID'].'\';'.chr(10) . '?>');
            fclose($fp);
        }
		if($array['type'] == 7) {
            if(is_file(CFG_PATH_DATA . 'ebay/dh_' . $id .'.php')){
                include_once(CFG_PATH_DATA . 'ebay/dh_' . $id .'.php');
            }else{
                 $passtime = time();
                 $longpasstime = time()+60*60*24*20;;
            }
            $fp = fopen(CFG_PATH_DATA . 'ebay/dh_' . $id .'.php', 'w');                  
            fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$array['ac_token'].'\';'.chr(10).' $refresh_token =\''.$array['re_token'].'\';'.chr(10).' $APIDevUserID =\''.$array['APIDevUserID'].'\';'.chr(10). ' $APIPassword =\''.$array['APIPassword'].'\';'.chr(10).' $passtime = '.$passtime.';'.chr(10). ' $longpasstime = '.$longpasstime.';'.chr(10). '?>');
            fclose($fp); 
			ModelDd::cacheDHaccount();
		}
        
        if($array['type'] == 5 && $array['url'] <> '') {
            $fp = fopen(CFG_PATH_DATA . 'ebay/mg_' . $id .'.php', 'w');
            fputs($fp, '<?php'. chr(10) . ' $url = "'.$array['url'].'";'.chr(10). ' $APIDevUserID = "'.$array['APIDevUserID'].'";'.chr(10). ' $APIPassword = "'.$array['APIPassword'].'";'.chr(10).'?>');
            fclose($fp);
            ModelDd::cacheMgaccount();
        }
        
		 ModelDd::cacheAllaccount();
	}
    function cacheAliaccount()
    {
        $array = $this->db->select('select id,account_name from '.CFG_DB_PREFIX.'ebay_account where type=6', 'hashmap');
        $fp = fopen(CFG_PATH_DATA . 'dd/aliaccount.php', 'w');
        fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
        fclose($fp);
    }
	function cacheDHaccount()
	{
		$array = $this->db->select('select id,account_name from '.CFG_DB_PREFIX.'ebay_account where type=7', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/dhaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true).'; ?>');
		fclose($fp);
	}
	function cacheAllaccount()
	{
		$array = $this->db->select('select id,account_name from '.CFG_DB_PREFIX.'ebay_account ', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/allaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	function cacheTaobaoaccount()
	{
		require(CFG_PATH_LIB . 'taobao/taobao.php');
		$array = $this->db->select("select id,account_name from ".CFG_DB_PREFIX."ebay_account  where devID ='".$appKey."' AND certID <>''", 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/taobaoaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	function cacheAmazonaccount()
	{
		$array = $this->db->select("select id,account_name from ".CFG_DB_PREFIX."ebay_account  where devID ='' AND appID <>''", 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/amazonaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);		
	}
	function cacheEbayaccount()
	{
		$array = $this->db->select("select id,account_name from ".CFG_DB_PREFIX."ebay_account where userToken <> ''", 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/ebaycount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	function cacheZcaccount()
	{
		$array = $this->db->select("select id,account_name from ".CFG_DB_PREFIX."ebay_account where type = 4 and url <> ''", 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/zcaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
    function cacheMgaccount()
    {
        $array = $this->db->select("select id,account_name from ".CFG_DB_PREFIX."ebay_account where type = 5 and url <> ''", 'hashmap');
        $fp = fopen(CFG_PATH_DATA . 'dd/mgaccount.php', 'w');
        fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
        fclose($fp);
    }
	function switchsite($id)
	{
		switch($id)
		{
			case 1:
			return "https://mws.amazonservices.com/Orders/2011-01-01";
			case 2:
			return "https://mws-eu.amazonservices.com/Orders/2011-01-01";
			case 3:
			return "https://mws-eu.amazonservices.com/Orders/2011-01-01";
			case 4:
			return "https://mws-eu.amazonservices.com/Orders/2011-01-01";
			case 5:
			return "https://mws-eu.amazonservices.com/Orders/2011-01-01";
			case 6:
			return "https://mws.amazonservices.jp/Orders/2011-01-01";
			case 7:
			return "https://mws.amazonservices.com.cn/Orders/2011-01-01";
			case 8:
			return "https://mws.amazonservices.ca/Orders/2011-01-01";
			case 9:
			return "https://mws-eu.amazonservices.com/Orders/2011-01-01";
		}
	}
	function cacheLanguage()
	{
		$array = $this->db->select("select id,name from ".CFG_DB_PREFIX."product_language where is_active = 1", 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/languages.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}

	/**
	 * 缓存Paypal信息
	 * @param int $id
	 * @access public
	 * @return void
	 */
	public function cachePaypal() {

		$array = $this->db->select('select p_root_id,paypal_account from '.CFG_DB_PREFIX.'paypal_account', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/paypalaccount.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	
	/**
	 * 取字典项信息
	 * @param int $di_id 字典项ID
	 * @access public
	 * @return array
	 */
	public function getDiInfo($di_id) {
		return $this->db->getValue('select * from '.CFG_DB_PREFIX.'dd_item where 
		    	id='  . intval($di_id));
	}
	/**
	 * 缓存属性组
	 * 
	 */
	public function cacheAttributeGroup() {
		$array = $this->db->select('select attribute_group_set_id,attribute_group_name from '.CFG_DB_PREFIX.'attribute_group', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/attr_group.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 缓存属性组
	 * 
	 */
	public function cacheAttributeGroupID() {
		$array = $this->db->select('select attribute_group_set_id,attribute_group_name from '.CFG_DB_PREFIX.'attribute_group', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/attr_group.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 生成字典select框
	 * @param string $name 字典名
	 * @param int $value 字典值
	 * @param string $cur 自定义属性
	 * @access public
	 * @return bool
	 */
	public static function getSelect($name, $value=0, $cur=NULL) {
		$array = ModelDd::getArray($name);
		
		$html = '<select name="'.$name.'" id="'.$name.'" ' . $cur . '><option value="0">选择</option>';
		foreach ($array as $k => $v) {
			if ($k==$value) {
				$selected = ' selected="selected"';
			} else {
				$selected = '';
			}
			$html .= '<option value="' . $k . '"' . $selected . '>' . $v . '</option>';
		}
		$html .= '</select>';
		return $html;
	}
	
	/**
	 * 生成字典radio框
	 * @param string $name 字典名
	 * @param int $value 字典值
	 * @param string $cur 自定义属性
	 * @access public
	 * @return bool
	 */
	public static function getRadio($name, $value=0, $cur=NULL) {
		$array = ModelDd::getArray($name);
		$falg = true;
		foreach ($array as $k => $v) {
			if ($value==$k) {
				$checked = ' checked="checked"';
			} else {
				$checked = '';
			}
			if (!$falg) {
				$cur = '';
			}
			$html.='<input'.$checked.' type="radio" name="' 
				. $name . '" value="'.$k.'" ' . $cur . ' />' . $v;
			$falg = false;
		}
		
		return $html;
	}	
	/**
	 * 生成字典checked框
	 * @param string $name 字典名
	 * @param int $value 字典值
	 * @param string $cur 自定义属性
	 * @access public
	 * @return bool
	 */
	public static function getChecked($name, $value=0, $cur=NULL) {
		$array = ModelDd::getArray($name);
		if ($value) {
			$cruValue = explode(',', $value);
		} else {
			$cruValue = array();
		}
		$falg = true;
		foreach ($array as $k => $v) {
			if (in_array($k, $cruValue)) {
				$checked = ' checked="checked"';
			} else {
				$checked = '';
			}
			if (!$falg) {
				$cur = '';
			}
			$html.='<input'.$checked.' type="checkbox" name="' . $name . '[]" value="'.$k.'" ' . $cur . ' />' . $v;
			$falg = false;
		}
		
		return $html;
	}
	
	/**
	 * 取字典项数组
	 * @param string $name 字典名
	 * @access public
	 * @return array
	 */
	public static function getArray($name) {
		$file = CFG_PATH_DATA . 'dd/' . $name . '.php';
		if (!file_exists($file)) {
            $fp = fopen(CFG_PATH_DATA . 'dd/'.$name.'.php', 'w');
            fputs($fp, '<?php return array(); ?>');
            fclose($fp);
            sleep(1);
			$dd = new ModelDd();
			$dd->cache($dd_id,$name);
		}
		$result = require($file);
		return $result;
	}
	
	/**
	 * 取字典项名称
	 * @param string $name 字典名
	 * @param string $value 值
	 * @access public
	 * @return array
	 */
	public static function getCaption($name, $value) {
		$array = ModelDd::getArray($name);
		if (strpos($value,',')===false) { 
			return $array[$value];
		} else {
			$values = explode(',',$value);
			$result = '';
			foreach ($values as $v) {
				if ($v) {
					$result .= $array[$v] . ' ';
				}
			}
		}
		return $result;
	}
	/**
	 * 取combo控件使用的字典项数据
	 *
	 * @param string $name
	 * @return string
	 */
	public static function getComboData($name) {
		$array = ModelDd::getArray($name);
		return ModelDd::arrayFormat($array);
	}
	
	
	public static function arrayFormat($arr){
		$result = array();
		foreach ((array)$arr as $key => $value) {
			$result[] = '[\''.$key.'\',\''.addslashes($value).'\']';
		}
		$string = implode(',',$result);
		return $string;	
	}
}
?>