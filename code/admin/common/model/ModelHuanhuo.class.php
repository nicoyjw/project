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

class ModelHuanhuo extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'huanhuo';
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
		$this->db->open('SELECT *
			FROM '.$this->tableName.' ORDER BY id DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['deal_time'] = MyDate::transform('date',$rs['deal_time']);
			$rs['huanhuo_sn'] = CFG_BARTER_ORDER_PREFIX.$rs['huanhuo_sn'];
			$rs['huanhuo_rma_sn'] = CFG_RMA_ORDER_PREFIX.$rs['huanhuo_rma_sn'];
			$rs['huanhuo_order_sn'] = CFG_ORDER_PREFIX.$rs['huanhuo_order_sn'];
			$result[] = $rs;
		}
		return $result;
	}
	function get_sn($tb_name='',$field='huanhuo_sn')
	{
		/* 选择一个随机的方案 */
		mt_srand((double) microtime() * 1000000);
		$sn =  date('ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
		if($this->db->getValue("SELECT count(*) from ".(empty($tb_name)?$this->tableName:$tb_name)." where ".$field." = '".$sn."'")>0){
			///echo CFG_ORDER_PREFIX.$sn."重复，重新生成订单号<br>";
			$sn = $this->get_sn();
		}
		return $sn;
	}
}
?>