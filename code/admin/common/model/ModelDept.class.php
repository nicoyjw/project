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
 * 部门
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelDept extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'dept';
	}
	/**
	 * 取子部门
	 *
	 * @param int $parentId
	 * @return array
	 */
	function getSub($parentId)
	{
		$this->db->open('select * from '.$this->tableName.' where parent_id='.intval($parentId));
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['text'] = $rs['dept_caption'];
			$rs['note'] = $rs['note'];
			$rs['parent_id'] = $rs['parent_id'];
			$rs['leaf'] = false;
			$rs['cls'] = 'folder';
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 保存
	 *
	 * @param array $info
	 */
	function save($info)
	{
		specConvert($info,array('dept_caption','note'));
		$info['id'] = intval($info['id']);
		if ($info['id']) {
			$this->db->update($this->tableName,array(
					'dept_caption' => $info['dept_caption'],
					'note' => $info['note'],
					),'id='.$info['id']);
			
		} else {
			$this->db->insert($this->tableName,array(
					'dept_caption' => $info['dept_caption'],
					'parent_id' => $info['parent_id'],
					'note' => $info['note'],
					));
		}
		$this->cache();
	}
	/**
	 * 改变父节点ID
	 *
	 * @param int $id
	 * @param int $parentId
	 */
	function chinageParent($id,$parentId)
	{
		$this->db->update($this->tableName,array(
					'parent_id' => intval($parentId),
					),'id='.intval($id));
	}
	/**
	 * 生成缓存
	 */
	function cache()
	{
		$array = $this->db->select('select id,dept_caption from '.$this->tableName
				.' order by id', 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/depts.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 删除
	 *
	 * @param int $id
	 */
	function delete($id)
	{
		parent::delete($id);
		$this->cache();
	}
}
?>	