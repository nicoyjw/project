<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2010 - 2015  |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// |                     |
// +--------------------------------------------------------------+

/**
 * 系统警告
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Alert extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '系统错误';
		$this->name = 'sysmsg';
		$this->tpl->assign('alertmsg','access');
		$this->dir = 'system';
	}
	/**
	 * 所有人列表
	 */
	function actionIndex() {
		$this->show();
	}
	
}
?>