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
 * 客户操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelClient extends Model {
	
	function __construct($query=null){
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'client';
		$this->primaryKey = 'id';
	}
	/**
	 * 保存
	 *
	 * @param array $info
	 */
	function save($info){	
		specConvert($info,array('real_name','workplace','address','contact_note','note'));
		if (!$info['client_id']) {
			$this->db->insert($this->tableName, array(
				'real_name'     => $info['real_name'],
				'sex'  		    => $info['sex'],
				'age'  		    => $info['age'],
				'birthday'      => $info['birthday'],
				'id_card'  	    => $info['id_card'],
				'is_married'  	=> $info['is_married'],
				'workplace'  	=> $info['workplace'],
				'education'  	=> $info['education'],
				'works'  	    => $info['works'],
				'address'  	    => $info['address'],
				'telephone'  	=> $info['telephone'],
				'mobile'  	    => $info['mobile'],
				'email'  	    => $info['email'],
				'contact_note'  => $info['contact_note'],
				'month_earn'  	=> $info['month_earn'],
				'buy_ability'  	=> $info['buy_ability'],
				'min_price'  	=> $info['min_price'],
				'max_price'  	=> $info['max_price'],
				'buy_plan'  	=> $info['buy_plan'],
				'is_bool'  	=> $info['is_bool'],
				'agent_name'  	=> $info['agent_name'],
				'agent_id_card' => $info['agent_id_card'],
				'note'  		=> $info['note'],
				'follow_user_id'=> $info['follow_user_id'],
				'create_user_id'=> $info['create_user_id'],
				'create_time'   => CFG_TIME,
				'modify_time'  	=> CFG_TIME,
				'modify_user_id'=> $info['modify_user_id'],
				'dept_id'  	 	=> $info['dept_id'],
			));		
		} else {
			$this->db->update($this->tableName, array(
				'real_name'     => $info['real_name'],
				'sex'  		    => $info['sex'],
				'age'  		    => $info['age'],
				'birthday'      => $info['birthday'],
				'id_card'  	    => $info['id_card'],
				'is_married'  	=> $info['is_married'],
				'workplace'  	=> $info['workplace'],
				'education'  	=> $info['education'],
				'works'  	    => $info['works'],
				'address'  	    => $info['address'],
				'telephone'  	=> $info['telephone'],
				'mobile'  	    => $info['mobile'],
				'email'  	    => $info['email'],
				'contact_note'  => $info['contact_note'],
				'month_earn'  	=> $info['month_earn'],
				'buy_ability'  	=> $info['buy_ability'],
				'min_price'  	=> $info['min_price'],
				'max_price'  	=> $info['max_price'],
				'buy_plan'  	=> $info['buy_plan'],
				'is_bool'  	=> $info['is_bool'],
				'agent_name'  	=> $info['agent_name'],
				'agent_id_card' => $info['agent_id_card'],
				'note'  		=> $info['note'],
				'follow_user_id'=> $info['follow_user_id'],
				'create_user_id'=> $info['create_user_id'],
				'create_time'   => CFG_TIME,
				'modify_time'  	=> CFG_TIME,
				'modify_user_id'=> $info['modify_user_id'],
				'dept_id'  	 	=> $info['dept_id'],
			),'id='.intval($info['client_id']));
				
		}
	
	}
	
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 * @param string $where
	 * @return array
	 */
	function getList($from,$to,$where=null)
	{
		$this->db->open('select * from '.$this->tableName.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
		$rs['sex'] = ModelDd::getCaption('sex',$rs['sex']);
		$rs['works'] = ModelDd::getCaption('works',$rs['works']);
		$rs['is_bool'] = ModelDd::getCaption('is_bool',$rs['is_bool']);
		$rs['create_time'] = date('Y-m-d',$rs['create_time']);
		$result[] = $rs;
		}
		return $result;
	}
	
	
}

?>