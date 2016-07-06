<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 页面管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Menu extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		parent::actionPrivilege('list_menu');
		$this->title .= '模块管理';
		$this->name = 'menu';
		$this->dir = 'system';
		$this->tpl->assign('root_type',$this->actionRoot());
	}
	/**
	 * 所有人列表
	 */
	function actionIndex() {
		$this->show();
	}

	/**
	 * 顶级目录列表
	 */
	function actionRoot() {
		$menu = new ModelMenu();
		$list = $menu->getRoot();
		return $list;
	}
	
	/**
	 * 保存
	 *
	 */
	 function actionUpdate(){
	 	if(parent::actionCheck('edit_menu')) parent::actionSave('ModelMenu');
	 }
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_menu')) parent::actionDelete('ModelMenu');
	}	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		if($_POST['id']) $where = ' WHERE root = '.$_POST['id'];
		$pageLimit = getPageLimit();
		$menu = new ModelMenu();
		$list = $menu->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $menu->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
}
?>