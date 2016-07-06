<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 用户管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class User extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '用户管理';
		$this->name = 'user';
		$this->dir = 'user';
	}
	/**
	 * 所有人列表
	 */
	function actionIndex() {
		$this->tpl->assign('role',ModelDd::getComboData('role'));
		$this->show();
	}
	
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$user = new ModelUser();
		$action_list = explode(',',$_SESSION['action_list']);
		$where = (in_array('edit_user',$action_list))?'':' where user_id='.$_SESSION['admin_id'];
		$list = $user->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $user->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	function actionUserList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelUser();
		$list = $object->getUserList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 保 存
	 */
	function actionSave()
	{
			$user = new ModelUser();
			try{
			$users = $user->save($_POST);
			echo "{success:true,msg:'保存成功'}";exit;
			} catch (Exception $e) {
				echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
			}
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_user'))
		{
			$user = new ModelUser();
			$user->delete($_GET['ids']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**
	 * 权限页面
	 *
	 */
	function actionRight()
	{
		$this->name = 'right';
		$rights = require(CFG_PATH_DATA.'right.php');
		require(CFG_PATH_CONF.'tree.cfg.php');
		foreach ($trees as $key => $value) {
			foreach ($value as $k => $v) {
				if ($rights[$v['id']]) {
					$trees[$key][$k]['right'] = 'true';
				} else {
					$trees[$key][$k]['right'] = 'false';
				}
			}
		}
		$this->tpl->assign('trees',$trees);
		$this->tpl->assign('tree',$trees['root']);
		$this->show();
	}
	
	
	function actionCheckname()
	{
		$object = new ModelUser();
			try{
				 $object->checkname($_POST['value']);
				echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
				echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
			}
	}
    function actiontesttest(){
        $dd = new ModelDd();
        $dd->cacheUsermenu(1);
    }
}
?>