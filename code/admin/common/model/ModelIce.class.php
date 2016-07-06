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
 * 互联易逻辑类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelIce extends ModelOrder{
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
	}
	
	/***************
	***互联易订单处理
	***
	***************/
	function updateIce($info){
		$ids = $info['id'];
		$id = explode(',',$ids);
		$msg = '';
		$modelgoods = new ModelGoods();
		$shipping = ModelDd::getArray('shipping');
		for($i=0;$i<count($id);$i++){
			$order_info = $this->order_info($id[$i]);
			$goods_info = $this->order_goods_info($id[$i]);
			$channelID = $this->changeIceChannels($shipping[$order_info['shipping_id']]);
			if($channelID == 0) $msg = '该运输名称不符合互联易指定运输方式名称,';
			$track_no = $this->geticesn($channelID);
			if($track_no <> ''){
				if(CFG_RUN_MODE ==1){
					$userinfo['company'] = $_SESSION['company'];
					$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, $_SESSION['company'], CFG_DB_ADAPTER, true );
					$query = new DbQueryForMysql($db);
					$query->prefix = CFG_DB_PREFIX;
					try{
						$query->update(CFG_DB_PREFIX.'order',array('track_no' => $track_no),'order_id='.$id[$i]);
					} catch (Exception $e) {
						throw new Exception("更新异常，请联系管理员");exit;
					}
				}else{
					$this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $track_no),'order_id='.$id[$i]);
				}
			}else{
				$msg .= '订单'.CFG_ORDER_PREFIX.$order_info['order_sn'].'获取追踪单号失败<br>';
				$msg .='<br>';
			}
		}
		$msg .='获取追踪单号结束';
		return $msg;
	}
	/**
	 * 获取物流追踪单号
	 * @param string $name  
	 * @return int
	 */
	function geticesn($channels){
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, 'ice', CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		$info = $query->getValue('select * from '.CFG_DB_PREFIX.'icesn where channels = '.$channels.' and status = 0 order by id asc');
		$query->execute("update ".CFG_DB_PREFIX."icesn set status = 1 where id = ".$info['id']);
		return $info['track_sn'];
	}
	/**
	 * 根据运输名获取渠道id
	 * @param string $name  
	 * @return int
	 */
	function changeIceChannels($name){
		/**
		 * 新加坡小包 -- 1
		 * 瑞士小包   -- 2
		 * 香港小包   -- 3
		 */
		switch($name){
			case '新加坡小包挂号' :
			$result = 1;
			break;
			case '瑞士小包挂号' :
			$result = 2;
			break;
			case '香港小包挂号' :
			$result = 3;
			break;
			default :
			$result = 0;
			break;
		}
		return $result;
	}
}
?>