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
 * 中介电话
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelTelephone extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'telephone';
	}
	/**
	 * 保存记录
	 *
	 * @param array $info
	 */
	function save($info)
	{
		if (!$info['id']) {
			$this->db->insert($this->tableName,array(
				'agent_name' => $info['agent_name'],
				'tel_type' => $info['tel_type'],
				'note' => $info['note'],
				'telephone' => $info['telephone'],
				
				));
		} else {
			$this->db->update($this->tableName,array(
				'agent_name' => $info['agent_name'],
				'tel_type' => $info['tel_type'],
				'note' => $info['note'],
				'telephone' => $info['telephone'],
				),'id='.intval($info['id']));
			
		}
	}
}
?>	