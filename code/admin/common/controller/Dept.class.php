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
 * 组织结构管理 
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */
class Dept  extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '组织结构管理';
		$this->name = 'dept';
		$this->dir = 'user';
	}
	
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelDept');
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		parent::actionDelete('ModelDept');
	}
	/**
	 * 删 除
	 *
	 */
	function actionSave()
	{
		parent::actionSave('ModelDept');
	}
	
	/**
	 * 添加/编辑
	 *
	 */
	function actionAdd()
	{
		$this->name = 'telephoneAdd';
		
		if ($_GET['id']) {
			$tel = new ModelTelephone();
			$info = $tel->getInfo($_GET['id']);
		}
		if (!$info['tel_type']) {
			$info['tel_type'] = 2;
		}
		$this->tpl->assign('info',$info);
		$this->tpl->assign('tel_type',ModelDd::getComboData('tel_type'));
		$this->show();
	}
	/**
	 * 取子树列表
	 *
	 */
	function actionTree() {
		require(CFG_PATH_CONF.'tree.cfg.php');
		$dept = new ModelDept();
		$result = $dept->getSub($_REQUEST['node']);
		
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 修改父级
	 *
	 */
	function actionChangeParent()
	{
		$dept = new ModelDept();
		$dept->chinageParent($_GET['id'],$_GET['parent_id']);
	}
}
?>