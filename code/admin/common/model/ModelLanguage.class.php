<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 快递规则类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelLanguage extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'product_language';
	}
	
	/**
	 * 保存汇率
	 *
	 * @param Array $info
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'name' => $info['name'],
				'code' => $info['code'],
				'sort_order' => $info['sort_order'],
				'is_active' => $info['is_active']
				));
		} else {
			$this->db->update($this->tableName,array(
				'name' => $info['name'],
				'code' => $info['code'],
				'sort_order' => $info['sort_order'],
				'is_active' => $info['is_active']
				),'id='.intval($info['id']));
		}
		ModelDd::cacheLanguage();
	}
	function getList($from,$to,$where=NULL){
		$this->db->open('select * from '.$this->tableName.$where.' order by sort_order asc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	function getLanguageCode($id){
		return $this->db->getValue("select code from ".$this->tableName." where id = ".$id);
	}
}
?>