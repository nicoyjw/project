<?php
// +--------------------------------------------------------------+
// | 这个文件是 MYOIS 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2006 - 2008 MYOIS.CN (www.myois.cn)            |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// | 或者访问 http://www.myois.cn/ 获得详细信息                      |
// +--------------------------------------------------------------+

/**
 * 公告
 *
 * @copyright Copyright (c) 2006 - 2008 MYOIS.CN
 * @author 戴志君 <dzjzmj@gmail.com>
 * @package Model
 * @version v0.1
 */

class ModelBlackList extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'blacklist';
	}

	/**
	 * 保存记录
	 *
	 * @param array $cat
	 */
	public function save($rma)
	{
		if (!$rma['id']) {
			$this->db->insert($this->tableName,$rma);
		} else {
			$this->db->update($this->tableName,$rma,'id='.intval($rma['id']));
		}
	}

	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to)
	{
		if(isset($_POST['order_sn'])){
		$whstr='WHERE order_sn=\''.substr(trim($_POST['order_sn']),strlen(CFG_ORDER_PREFIX)).'\'';
		}else
		$whstr='';
		$this->db->open('SELECT *
			FROM '.$this->tableName.' '.$whstr.' ORDER BY blacklist_id DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$result[] = $rs;
		}
		return $result;
	}
	function get_order_sn($tb_name='',$field='rma_sn')
	{
		/* 选择一个随机的方案 */
		mt_srand((double) microtime() * 1000000);
		$sn =  date('ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
		if($this->db->getValue("SELECT count(*) from ".(empty($tb_name)?$this->tableName:$tb_name)." where ".$field." = '".$sn."'")>0){
			///echo CFG_ORDER_PREFIX.$sn."重复，重新生成订单号<br>";
			$sn = $this->get_order_sn();
		}
		return $sn;
	}
	function ckordersn($val){
		if($this->db->getValue("SELECT count(*) from ".CFG_DB_PREFIX."order where order_sn = '".$val."'")>0){
		return true;
		}else{
		return false;
		}
	}
	function get_order_id($sn){
		return $this->db->getValue('select order_id from '.CFG_DB_PREFIX.'order where order_sn=\''.$sn.'\'');
	}
}
?>