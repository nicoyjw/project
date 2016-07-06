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
 * 日志
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */
class Log extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		parent::actionPrivilege('list_log');
		$this->title .= '日志';
		$this->name = 'log';
		$this->dir = 'system';
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
		$fp = fopen(CFG_PATH_CONF.'t.php','w');
		fputs($fp,var_export($_REQUEST,true));
		fclose($fp);
		$pageLimit = getPageLimit();
		$log = new ModelLog();
		$list = $log->getList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $log->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
}
?>