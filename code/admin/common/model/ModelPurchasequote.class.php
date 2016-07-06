<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 供应商
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelPurchasequote extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'p_quote';	}

	/**
	 * 取列表
	 *
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getList($from,$to,$where=null)
	{
		$this->db->open('select * from '.$this->tableName .$where.' order by '.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['add_time'] = date('Y-m-d',$rs['add_time']);
			$result[] = $rs;
		}
		return $result;
	}

	/**
	 * 保存供应商
	 *
	 * @param array $info
	 */
	public function save($info)
	{
		specConvert($info,array('supplier', 'contact','phone','product','price','remark','operator'));
		if (!$info['id']) {
			$this->db->insert($this->tableName,array(
				'supplier' => $info['supplier'],
				'contact' => $info['contact'],
				'phone' => $info['phone'],
				'add_time' => CFG_TIME,
				'product' => $info['product'],
				'price' => $info['price'],
				'phone' => $info['phone'],
				'remark' => $info['remark'],
				'operator' => $info['operator'],
				'add_user' => $_SESSION['admin_id']
			));
		} else {
			$this->db->update($this->tableName,array(
				'supplier' => $info['supplier'],
				'contact' => $info['contact'],
				'phone' => $info['phone'],
				'product' => $info['product'],
				'price' => $info['price'],
				'phone' => $info['phone'],
				'remark' => $info['remark'],
				'operator' => $info['operator']
			),'id='.intval($info['id']));
		}
	}

	/**
	 * 供应商产品查询条件
	 *
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('keyword','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = "supplier LIKE '%" . mysql_like_quote($info['keyword']) . "%' or product LIKE '%" . mysql_like_quote($info['keyword']) . "%'";
		}
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	/**
	 * 取列表
	 *
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getExportList($where=null)
	{
		$this->db->open('select * from '.$this->tableName .$where.' order by '.$this->primaryKey.' desc');
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['add_time'] = date('Y-m-d',$rs['add_time']);
			$result[] = $rs;
		}
		return $result;
	}	
}
?>