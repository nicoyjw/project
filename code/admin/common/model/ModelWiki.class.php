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
 * 知识库管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */

class ModelWiki extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'wiki';
	}

	/**
	 * 保存记录
	 *
	 * @param array $arr
	 */
	public function save($info)
	{
		if (!$info['id']) {
			unset($info['id']);
			$info['add_user'] = $_SESSION['admin_id'];
			$info['addtime'] =CFG_TIME;
			$this->db->insert($this->tableName,$info);
		} else {
			$info['modified_user'] = $_SESSION['admin_id'];
			$info['modified_time'] =CFG_TIME;
			$this->db->update($this->tableName,$info,'id='.intval($info['id']));
		}
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to,$where)
	{
		$this->db->open('SELECT *
			FROM '.$this->tableName.' '.$where.' ORDER BY id DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$rs['modified_time'] = MyDate::transform('date',$rs['modified_time']);
			$rs['add_user'] = ModelDd::getCaption('user',$rs['add_user']);
			$rs['modified_user'] = ModelDd::getCaption('user',$rs['modified_user']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 取条件
	 *
	 * @param int $val
	 */	
	function getwhere($info){
		$wheres = array();
		if ($info['keyword']) $wheres[] = '(title like \'%'.$info['keyword'].'%\' or sku like \'%'.$info['keyword'].'%\')';
		if($info['type']) $wheres[] = ' type ='.$info['type'];
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	function getdetail($id)
	{
		return $this->db->getValue("SELECT description,attachment FROM ".$this->tableName." where id ='".$id."'");
	}
	
	function delete($ids)
	{
		$attachments = $this->db->select("SELECT attachment FROM ".$this->tableName." where ".$this->primaryKey.' in ('.$ids.')');
		for($i=0;$i<count($attachments);$i++){
			@unlink($attachments[$i]);
		}
		return $this->db->execute('delete from '.$this->tableName
.' where '.$this->primaryKey.' in ('.$ids.')');
	}
}
?>