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
 * 订单操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelRma extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'rma';
	}

	/**
	 * 保存记录
	 *
	 * @param array $info
	 */
	public function save($info)
	{
		$info['admin_id'] = $_SESSION['admin_id'];
		if(isset($info['create'])) unset($info['create']);
			if(substr($info['order_sn'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX) $info['order_sn'] = substr($info['order_sn'],strlen(CFG_ORDER_PREFIX));
			$info['order_id']=$this->get_order_id(trim($info['order_sn']));
			$info['return_time'] = MyDate::transform('timestamp',$info['return_time']);
		if (empty($info['id'])) {
			$info['rma_sn']=$this->get_order_sn();
			$info['addtime'] = CFG_TIME;
			$this->db->insert($this->tableName,$info);
		} else {
			$this->db->update($this->tableName,$info,'id='.intval($info['id']));
		}
	}

	function savereturn($info)
	{
		if(substr($info['order_sn'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX) $info['order_sn'] = substr($info['order_sn'],strlen(CFG_ORDER_PREFIX));
		if(substr($info['new_order_sn'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX) $info['new_order_sn'] = substr($info['new_order_sn'],strlen(CFG_ORDER_PREFIX));
		$info['return_sn']=$this->get_order_sn();
		$info['addtime'] = CFG_TIME;
		$this->db->insert(CFG_DB_PREFIX.'return',$info);
	}

	function getList($from,$to,$where='')
	{
		if($to){
			$this->db->open('SELECT r.*,o.Sales_account_id,o.userid,o.shipping_time,o.end_time,o.track_no,o.shipping_id,o.weight,o.shipping_cost,o.order_amount*o.RATE as order_amount FROM '.$this->tableName.' r left join '.CFG_DB_PREFIX.'order o on r.order_id = o.order_id  '.$where.' order by r.addtime desc', $from,$to);
		}else{
			$this->db->open('SELECT r.*,o.Sales_account_id,o.userid,o.shipping_time,o.end_time,o.track_no,o.shipping_id,o.weight,o.shipping_cost,o.order_amount*o.RATE as order_amount FROM '.$this->tableName.' r left join '.CFG_DB_PREFIX.'order o on r.order_id = o.order_id  '.$where.' order by r.addtime desc');
		}
		$result = array();
		require(CFG_PATH_DATA.'dd/currency.php');
		while ($rs = $this->db->next()) {
			$gf=$this->db->getValue('select amt,currency from '.CFG_DB_PREFIX.'gf_order where relate_order_sn="'.$rs['order_sn'].'"');
			$rs['refund'] = floor($gf['amt']*floatval($currency[$gf['currency']])*100)/100;
			$rs['order_amount'] =floor($rs['order_amount']*100)/100;
			$rs['shipping_id'] = ModelDd::getCaption('shipping',$rs['shipping_id']);
			$rs['return_time'] = MyDate::transform('date',$rs['return_time']);
			$rs['Sales_account_id'] = ModelDd::getCaption('allaccount',$rs['Sales_account_id']);
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$rs['shipping_time'] = MyDate::transform('date',$rs['shipping_time']);
			$rs['end_time'] = MyDate::transform('date',$rs['end_time']);
			$rs['rma_sn'] = CFG_RMA_ORDER_PREFIX.$rs['rma_sn'];
			$rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
			$rs['new_order_sn'] = $rs['new_order_sn']?CFG_ORDER_PREFIX.$rs['new_order_sn']:'';
			$rs['admin_id'] = ModelDd::getCaption('user',$rs['admin_id']);
			$rs['realstatus'] = $rs['rma_status'];
			$temp_arr=ModelDd::getArray('rma_status');
			$rs['rma_status'] = $temp_arr[$rs['rma_status']];
			$result[] = $rs;
		}
		return $result;
	}
	function getWhere($info)
	{
		$wheres = array();
		if ($info['accountid']) $wheres[] = 'o.Sales_account_id='.$info['accountid'];
		if ($info['reasonid']&&$info['reasonid']>-1) $wheres[] = 'r.reason='.$info['reasonid'];
		if ($info['goods_sn']) $wheres[] = 'r.goods_sn=\''.$info['goods_sn'].'\'';
		if ($info['order_sn']) $wheres[] = 'o.order_sn=\''.substr(trim($info['order_sn']),strlen(CFG_ORDER_PREFIX)).'\'';
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'addtime between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'addtime < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'addtime > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getCount($where)
	{
		return $this->db->getValue('select count(*) from '.$this->tableName.' r left join '.CFG_DB_PREFIX.'order o on(r.order_id = o.order_id) '.$where);
	}
	function getReturnList($from,$to,$where=null)
	{
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX.'return ORDER BY id DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['return_sn'] = 	CFG_RETURN_ORDER_PREFIX.$rs['return_sn'];
			$rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
			$rs['new_order_sn'] = ($rs['new_order_sn'])?CFG_ORDER_PREFIX.$rs['new_order_sn']:'';
			$result[] = $rs;
		}
		return $result;
	}
	function getReturnCount($where=null)
	{
		return $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX.'return ORDER BY id DESC');
	}
	function get_order_sn($tb_name='',$field='rma_sn')
	{
		/* 选择一个随机的方案 */
		mt_srand((double) microtime() * 1000000);
		$sn =  date('ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
		if($this->db->getValue("SELECT count(*) from ".(empty($tb_name)?$this->tableName:$tb_name)." where ".$field." = '".$sn."'")>0){
			$sn = $this->get_order_sn();
		}
		return $sn;
	}
	function ckordersn($str){
		return $this->db->getValue("SELECT country from ".CFG_DB_PREFIX."order where order_sn = '".$str."'");
	}
	function get_order_id($sn){
		return $this->db->getValue('select order_id from '.CFG_DB_PREFIX.'order where order_sn=\''.$sn.'\'');
	}
}
?>