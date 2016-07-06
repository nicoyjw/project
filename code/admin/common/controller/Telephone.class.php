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
 * 中介电话 
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */
class Telephone  extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '中介电话';
		$this->name = 'telephone';
		$this->dir = 'system';
	}
	
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelTelephone');
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		parent::actionDelete('ModelTelephone');
	}
	/**
	 * 保存
	 *
	 */
	function actionSave()
	{
		parent::actionSave('ModelTelephone');
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
}
?>