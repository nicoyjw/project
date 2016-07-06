<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 权限管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Privilege extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '权限管理';
		$this->name = 'privilege';
		$this->dir = 'system';
	}
	/**
	 * 所有权限列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_privilege');
		$this->show();
	}

	/**
	 * 保存
	 *
	 */
	 function actionUpdate(){
	 	if(parent::actionCheck('edit_privilege')) parent::actionSave('ModelPrivilege');
	 }
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_privilege')) parent::actionDelete('ModelPrivilege');
	}
	
	/**
	 * 权限分类
	 *
	 */
	function actionType()
	{
		parent::actionPrivilege('list_privilegetype');
		$this->name = 'privilegeType';
		$this->show();
	}
	/**
	 * 返回权限分类json列表
	 *
	 */
	function actionTypeList()
	{
		$pageLimit = getPageLimit();
		$privilege = new ModelPrivilege();
		$list = $privilege->getTypeList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $privilege->getTypeCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回权限分类更新
	 *
	 */
	function actionTypeupdate()
	{
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$typearr = $json->decode(stripslashes($_POST['data']));
		$privilege = new ModelPrivilege();
		foreach($typearr as $type){
			$type->action_type_name = addslashes_deep($type->action_type_name);
			$privilege->saveType($type);
		}
		echo "{success:true,msg:'更新成功'}";exit;
	}
	/**
	 * 删 除分类
	 *
	 */
	function actionTypedel()
	{
		$privilege = new ModelPrivilege();
		$privilege->delType($_POST['id']);
	}		
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		if($_POST['root']) $where = ' WHERE action_type = '.$_POST['root'];
		$pageLimit = getPageLimit();
		$privilege = new ModelPrivilege();
		$list = $privilege->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $privilege->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 编辑角色或者用户权限
	 *
	 */
	function actioneidtpriv()
	{
		$privilege = new ModelPrivilege();
		$user = new ModelUser();
		if($_REQUEST['userid']){
			$action_list = $user->getRight($_REQUEST['userid']);
			$account_list = $user->getAccount($_REQUEST['userid']);
			$id = $_REQUEST['userid'];
			$type = 'user';
		}
		if($_REQUEST['roleid']){
			$action_list = $user->getroleright($_REQUEST['roleid']);
			$account_list = $user->getaccountlist($_REQUEST['roleid']);
			$id = $_REQUEST['roleid'];
			$type = 'role';
		}
		$this->tpl->assign('id', $id);
		$this->tpl->assign('type', $type);
		$this->tpl->assign('privlist', $privilege->getAction($action_list));
		$this->tpl->assign('acclist', $privilege->getAccount($account_list));
		$this->name = 'editpriv';
		$this->show();
	}
	/**
	 * 保存角色或者用户权限
	 *
	 */
	function actionsavepriv()
	{
		try{
			$privilege = new ModelPrivilege();
			$privilege->savepriv($_POST);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'".$errorMsg."'}";exit;
	}
    function actiontestpriv(){
       $dd = new ModelDd();
       $dd->cacheUsermenu(1); 
    }
}
?>