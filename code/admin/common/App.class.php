<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @package Common
 * @version v0.1
 */

class App {

	/**
	 * 构造函数
	 */
	function __construct() {
		// nothing
	}

	/**
	 * 运行程序
	 *
	 */
	function run()
	{
		$cotrollerName = $_GET[CFG_CONTROLLER_NAME];
		if ($cotrollerName=='') {
			$cotrollerName = CFG_DEFAULT_CONTROLLER;
		}
		$cotrollerName = ucfirst($cotrollerName);
		$file = CFG_PATH_CONTROLLER . $cotrollerName . '.class.php';
		if (is_file($file)) {
			include($file);
			$cotroller = new $cotrollerName();
			$actionName = $_REQUEST[CFG_ACTION_NAME];
			if ($actionName=='') {
				$actionName = CFG_DEFAULT_ACTION;
			}			
			$actionName = 'action' . ucfirst($actionName);
			if (method_exists($cotroller,$actionName)) {
				$cotroller->{$actionName}();
			} else if (method_exists($cotroller,'_noAction')) {
				$cotroller->_noAction();
			} else {
				throw new Exception('no Action');
			}
		} else {
			throw new Exception('no cotroller');
		}
	}
	
	/**
	 * 生成一个URL
	 *
	 * @param string $cotroller
	 * @param string $action
	 * @param array $curl
	 * @return string
	 */
	public static function makeUrl($cotroller,$action,$curl)
	{
		$url = 'index.php?'.CFG_CONTROLLER_NAME.'='.$cotroller;
		if ($action) {
			$url .= '&'.CFG_ACTION_NAME.'='.$action;
		}
		if ($curl) {
			foreach ($curl as $key => $value) {
$url .= '&'.$key.'='.$value;
			}
		}
		return $url;
	}
}
?>