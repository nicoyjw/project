<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 逻辑层基类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

abstract class Model {
	
	/**
	 * 表名
	 * @var string
	 */
	public $tableName = null;
	
	/**
	 * 关键字
	 * @var string
	 */
	public $primaryKey = 'id';
	
	/**
	 * 构造函数
	 * @param object $query 查询对像
	 */
	function __construct($query=null) {
		if ($query) {
			$this->db = $query;
		} else {
			$this->db = Page::getRegistry('db');
		}
	}
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
		$this->db->open('select * from '.$this->tableName.$where.' order by '.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 取某表列表
	 *
	 * @param int $table m某表
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getTableList($table,$from,$to,$where=null)
	{
		$this->db->open('select * from '.$table.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 取记录
	 *
	 * @param int $id ID
	 * @return array
	 */
	function getInfo($id)
	{
		return $this->db->getValue('select * from '.$this->tableName
.' where '.$this->primaryKey.'='.$id);
	}
	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function delete($ids)
	{
		return $this->db->execute('delete from '.$this->tableName
.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->tableName.$where);
	}
	
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getTableCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.$where);
	}
    
}
?>