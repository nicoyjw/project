<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 系统权限类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelPrivilege extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'action_code';
	}
	
	/**
	 * 保存权限
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'action_code' => $info['action_code'],
				'action_name' => $info['action_name'],
				'action_des' => $info['action_des'],
				'action_type' => $info['action_type'],
				));
		} else {
			$this->db->update($this->tableName,array(
				'action_code' => $info['action_code'],
				'action_name' => $info['action_name'],
				'action_des' => $info['action_des'],
				'action_type' => $info['action_type'],
				),'id='.intval($info['id']));
			
		}
	}
	
	function getList($from,$to,$where)
	{
		$this->db->open('select m.id,m.action_code, m.action_name, m.action_des, m.action_type,n.action_type_name from '.$this->tableName.' as m left join '.CFG_DB_PREFIX . 'action_type as n on m.action_type = n.id '.$where.' order by '.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 保存分类
	 *
	 * @param 对象ID $id
	 * @param 模块 $action_type_name
	 */
	function saveType($info)
	{
		if (empty($info->id)) {
			$this->db->insert(CFG_DB_PREFIX . 'action_type',array(
				'action_type_name' => $info->action_type_name
				));
		} else {
			$this->db->update(CFG_DB_PREFIX . 'action_type',array(
				'action_type_name' => $info->action_type_name
				),'id='.intval($info->id));
			
		}
	}
	
	/**
	 * 删除分类
	 *
	 * @param 对象ID $id
	 * @param 模块 $action_type_name
	 */
	function delType($ids)
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX . 'action_type'
				.' where id in ('.$ids.')');
		echo "{success:true,msg:'OK'}";exit;
	}

	
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getTypeCount($where=null) {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'action_type'.$where);
	}
	/**
	 * 取分类列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getTypeList($from,$to)
	{
		$this->db->open('select * from '.CFG_DB_PREFIX . 'action_type',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	*获取action_list 列表
	*@param string $list 用来获取是否选中的action_list
	*/
	function getAction($list)
	{
		$type = $this->getTypeList(0,1000);
       
		for($i=0;$i<count($type);$i++){
			$action_list = $this->db->select('select action_code,action_name from '.$this->tableName.' where action_type = '.intval($type[$i]['id']));
			for($j=0;$j<count($action_list);$j++)
			{
				$type[$i]['action_list'][$j]['code'] = $action_list[$j]['action_code'];
				$type[$i]['action_list'][$j]['name'] = $action_list[$j]['action_name'];
				$type[$i]['action_list'][$j]['cando'] = (preg_match('/\b'.$action_list[$j]['action_code'].'\b/i', $list)|| ($list == 'all'))?1:0;
			}
		}
		return $type;
	}
	/**
	*获取account_list 列表
	*@param string $list 用来获取是否选中的action_list
	*/
	function getAccount($list)
	{
        
		$action_list = $this->db->select('select id,account_name from '.CFG_DB_PREFIX.'ebay_account');
		for($j=0;$j<count($action_list);$j++)
		{
			$type[$j]['code'] = $action_list[$j]['id'];
			$type[$j]['name'] = $action_list[$j]['account_name'];
			$type[$j]['cando'] = (preg_match('/\b'.$action_list[$j]['id'].'\b/i', $list)|| ($list == 'all'))?1:0;
		}
		return $type;
	}	
	/**
	*保存权限
	*@param string $info
	*/
	function savepriv($info)
	{
		if($info['type']== 'user')
		{
			try{
				$this->db->update(CFG_DB_PREFIX.'admin_user',array(
						'action_list' => $info['actionlist'],
						'account_list' => $info['account_list']
						),'user_id='.$info['id']);
					if($_SESSION['admin_id'] == $info['id']){
						$_SESSION['action_list'] = $info['actionlist'];
						$_SESSION['account_list'] = $info['account_list'];
					}
					ModelDd::cacheUsermenu($info['id']);
					if(CFG_RUN_MODE ==1){
						try{
						$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
						$query = new DbQueryForMysql($db);
						$query->update('myr_admin_user',array(
								'action_list' => $info['actionlist'],
								'account_list' => $info['account_list']
								),'user_id='.intval($info['id']).' and company="'.$_SESSION['company'].'"');
						} catch (Exception $e) {
							throw new Exception($e->getMessage(),'521');exit();
							}
					}
			} catch (Exception $e) {
						throw new Exception('保存用户权限失败','521');exit();
			}
		}else{
			try{
				if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX.'role where role_id ='.$info['id'])>0)
				{
					$this->db->update(CFG_DB_PREFIX.'role',array(
						'action_list' => $info['actionlist'],
						'account_list' => $info['account_list']
						),'role_id='.$info['id']);
				}else{
				$this->db->insert(CFG_DB_PREFIX.'role',array(
										'action_list' => $info['actionlist'],
										'account_list' => $info['account_list'],
										'role_id' => $info['id']
										));					
				}
			} catch (Exception $e) {
						throw new Exception('保存角色权限失败','521');exit();
			}
		}
	}	
}
?>
