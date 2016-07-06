<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 控制器基类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */

/**
 * 控制器基类
 * @package Common
 */
abstract class Controller extends Page {
	/**
	 * 是否需要身份验证
	 *
	 * @var unknown_type
	 */
	public  $useAuth = false;

	/**
	 * 构造函数
	 */
	function __construct() {
		parent::__construct();
		$this->tpl = Page::getRegistry('tpl');
		if ($this->useAuth) {
			$user = new ModelUser();
			$user->auth();//检测用户是否登录
		}
	}
	/**
	 * 默认求知动作页面
	 */
	function _noAction()
	{
		throw new Exception('你访问了未定义的页面');
	}
	
	/**
	 * 通用首页
	 */
	function actionIndex() {
		$this->show();
	}
	
	/**
	 * 通用返回json列表
	 * @param $objectName modle类名
	 */
	function actionList($objectName)
	{
		$pageLimit = getPageLimit();
		$object = new $objectName();
		$list = $object->getList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	/**
	 * 通用返回json列表
	 * @param $objectName modle类名
	 */
	function actionTableList($table,$objectName,$where=null)
	{
		$pageLimit = getPageLimit();
		$object = new $objectName();
		$list = $object->getTableList(CFG_DB_PREFIX .$table .$where ,$pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getTableCount(CFG_DB_PREFIX .$table,$where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 通用删除
	 * @param $objectName modle类名
	 *
	 */
	function actionDelete($objectName)
	{
		$object = new $objectName();
		$object->delete($_GET['ids']);
		savelog($_GET['ids'],$objectName,'信息被删除',$_SESSION['admin_id']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	/**
	 * 通用保存
	 * @param $objectName modle类名
	 */
	function actionSave($objectName)
	{
		$object = new $objectName();
		try {
			$object->save($_POST);
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}


	/**
	 * 权限检测
	 * @param $authz 权限代码
	 */
	function actionPrivilege($authz)
	{
		if(!check_authz($authz)) Page::todo('index.php?model=alert','您没有此操作的权限，请联系系统管理员');
	}	
	
	/**
	 * 权限检测
	 * @param $authz 权限检查
	 */
	function actionCheck($authz)
	{
		if(!check_authz($authz)){
			echo "{success:false,msg:'您没有此操作的权限，请联系系统管理员!'}";exit;
		}else{
			return true;
		}
	}	
}
?>
