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
 * 系统日志类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelLog extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'log';
	}
	
	/**
	 * 保存日志
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function save($id,$model,$content,$user_id=0)
	{
		if (!$user_id) {
			$user = new ModelUser();
			$user_id = $user->getAuthInfo('user_id');
		}
		
		$this->db->insert($this->tableName,array(
				'user_id' =>$user_id,
				'log_time' => time(),
				'module_name' => $model,
				'log_object' => $id,
				'log_ip' => Ip::get(),
				'content' => $content,
				));
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to)
	{
		$this->db->open('select * from '.$this->tableName.' order by '.$this->primaryKey.' desc',$from,$to);
		$result = array();
		$userlist = ModelDd::getArray("user");
		while ($rs = $this->db->next()) {
			$rs['user_id'] = $userlist[$rs['user_id']];
			$rs['log_time'] = MyDate::transform('standard',$rs['log_time']);
			$result[] = $rs;
		}
		return $result;
	}
}
?>