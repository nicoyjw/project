<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 字典 
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Controller
 * @version v0.1
 */
class Dd  extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		parent::actionPrivilege('list_dd');
		$this->title .= '字典';
		$this->name = 'dd';
		$this->dir = 'dd';
	}

	/**
	 * 登录界面
	 */
	function actionIndex() {
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelDd');
	}
	/**
	 * 返回字典项json列表
	 */
	function actionItemList()
	{
		$dd = new ModelDd();
		$list = $dd->getItemList($_GET['id']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 编辑字典项
	 *
	 */
	function actionEditItem()
	{
		$this->name = 'ddItem';
		$this->show();
	}
	/**
	 * 保存字典项
	 *
	 */
	function actionSave()
	{
		if(parent::actionCheck('edit_dd'))
		{
			try {
				$dd = new ModelDd();
				$dd->save($_POST);
				echo "{success:true,msg:'OK'}";exit;	
			} catch (Exception $e) {
				echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
			}
		}
	}
	/**
	 * 取字典项数据
	 *
	 */
	function actionGetInfo()
	{
		$dd = new ModelDd();
		$info = $dd->getDiInfo($_GET['id']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($info);
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_dd')) parent::actionDelete('ModelDd');
	}
}
?>