<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 系统页面类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelMenu extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'menu';
	}
	
	/**
	 * 保存日志
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'text' => $info['text'],
				'sortnum' => $info['sortnum'],
				'model' => $info['model'],
				'action' => $info['act'],
				'code' => $info['code'],
				'root' => $info['root'],
				));
		} else {
			$this->db->update($this->tableName,array(
				'text' => $info['text'],
				'model' => $info['model'],
				'sortnum' => $info['sortnum'],
				'action' => $info['act'],
				'code' => $info['code'],
				'root' => $info['root'],
				),'id='.intval($info['id']));
			
		}
		ModelDd::cacheMenu();
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to,$where)
	{
		$this->db->open('select * from '.$this->tableName.$where.' order by sortnum asc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 取Menu根列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getRoot()
	{
		$this->db->open('select id,text from '.$this->tableName.' where root ="root"');
		$result = array();
		while ($rs = $this->db->next()) {
			$result[$rs['id']] = $rs['text'];
		}
		$result['root'] = 'root';
		return ModelDd::arrayFormat($result);
	}
}
?>