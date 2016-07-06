<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 公共包含文件
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */


ini_set("magic_quotes_runtime",0);
//date_default_timezone_set('Asia/Hong_Kong');
define('CFG_TIME', time());
$GLOBALS['_start_time_'] = array_sum(explode(' ', microtime()));
session_start();
/** 
 * 路径
 */
define('CFG_PATH_ROOT', dirname(__FILE__) . '/');
require(CFG_PATH_ROOT . 'config.cfg.php');
if(CFG_RUN_MODE ==1){
	if(@$_SESSION['company'] == '' || !@$_SESSION['company']){
		$dbname = CFG_DB_NAME;
	}else{
		define('CFG_PATH_CLIENERP',CFG_PATH_ROOT.'erp_client/erp/');
		define('CFG_PATH_CLIEN',CFG_PATH_ROOT.'erp_client/');
		define('CFG_PATH_CONF', CFG_PATH_CLIEN . $_SESSION['company'] . '/conf/');
		define('CFG_PATH_DATA', CFG_PATH_CLIEN . $_SESSION['company'] . '/data/');
		define('CFG_PATH_UPLOAD', CFG_PATH_DATA . 'upload/');
		define('CFG_PATH_TMP', CFG_PATH_DATA . 'tmp/');
		require(CFG_PATH_CONF . 'conf.php');//加载自定义项
		require(CFG_PATH_CONF . 'version.cfg.php');
		$dbname = $_SESSION['company'];
	}
}else{
	$dbname = CFG_DB_NAME;
	define('CFG_PATH_CONF', CFG_PATH_ROOT . 'conf/');
	define('CFG_PATH_DATA', CFG_PATH_ROOT . 'data/');
	define('CFG_PATH_UPLOAD', CFG_PATH_DATA . 'upload/');
	define('CFG_PATH_TMP', CFG_PATH_DATA . 'tmp/');
	require(CFG_PATH_CONF . 'conf.php');//加载自定义项
	require(CFG_PATH_CONF . 'version.cfg.php');
	}
define('CFG_PATH_COMMON', CFG_PATH_ROOT . 'common/');
define('CFG_PATH_LIB', CFG_PATH_COMMON . 'lib/');
define('CFG_PATH_MODEL', CFG_PATH_COMMON . 'model/');
define('CFG_PATH_CONTROLLER', CFG_PATH_COMMON . 'controller/');
define('CFG_PATH_THEMES', CFG_PATH_ROOT . 'themes/' . CFG_STYLE . '/');
define('CFG_PATH_TEMPLATE', CFG_PATH_THEMES . 'template/');
define('CFG_THEMES_URL', CFG_URL .  'themes/' . CFG_STYLE . '/');
define('CFG_PATH_IMAGES', CFG_THEMES_URL . 'images/');
define('CFG_PATH_CSS', CFG_THEMES_URL . 'css/');
define('CFG_PATH_JS', CFG_URL . 'common/js/');

define('CFG_CONTROLLER_NAME','model');
define('CFG_ACTION_NAME','action');
define('CFG_DEFAULT_CONTROLLER','login');
define('CFG_DEFAULT_ACTION','index');
require(CFG_PATH_LIB . 'util/Util.inc.php');
require(CFG_PATH_LIB . 'util/Html.class.php');
require(CFG_PATH_COMMON . 'Page.class.php');
require(CFG_PATH_COMMON . 'App.class.php');
require(CFG_PATH_COMMON . 'Controller.class.php');
require(CFG_PATH_COMMON . 'Model.class.php');
@header('content-Type: text/html; charset=' . CFG_CHARSET);
if (!CFG_DEBUG) {
	error_reporting(0);
	@ob_start('ob_gzhandler');
} else {
	error_reporting(E_ALL & ~E_NOTICE & ~E_NOTICE);
}
/**
 *  对用户传入的变量进行转义操作。
 */
if (!get_magic_quotes_gpc()) {
    if (!empty($_GET)) {
        $_GET  = addslashes_deep($_GET);
    }
    if (!empty($_POST)) {
        $_POST = addslashes_deep($_POST);
    }

    $_COOKIE   = addslashes_deep($_COOKIE);
    $_REQUEST  = addslashes_deep($_REQUEST);
}


/** 
 * 数据库连接
 */
require(CFG_PATH_LIB . 'db/DataSource.class.php');
try {
	$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, 
			$dbname, CFG_DB_ADAPTER, true );
	$query = new DbQueryForMysql($db);
	$query->prefix = CFG_DB_PREFIX;
	Page::setRegistry('db',$query);
} catch (DbException $e) {
	// 数据库出错处理处
	echo '数据库连接出错!请检查配置文件config.cfg.php,或数据库服务器。';
	exit;
}

require(CFG_PATH_LIB  . 'smarty/libs/Smarty.class.php');

/**
 * 模版引擎(smarty)
 */
$tpl = new Smarty();
$tpl->template_dir 		= CFG_PATH_TEMPLATE;
$tpl->compile_dir  		= CFG_PATH_ROOT . 'themes/template_c/';

$tpl->compile_check  	= CFG_DEBUG;
$tpl->debugging 	    = false;
$tpl->caching 	    	= 0;
$tpl->cache_lifetime 	= 6000;

$tpl->left_delimiter 	= '<!--{';
$tpl->right_delimiter 	= '}-->';
Page::setRegistry('tpl',$tpl);

/**
 * 自动载入model,util下的类
 *
 * @param string $name
 * @todo 以后放弃这个函数
 * @return bool
 */
function __autoload($name) {
	$path = CFG_PATH_MODEL . $name . '.class.php';
	if (!file_exists($path)) {
		$path = CFG_PATH_LIB .'util/' . $name . '.class.php';
		if (file_exists($path)) {
			require_once($path);
			return true;
		} else {
			echo 'Missing'.$name;die();
			return false;
		}
	}
	require_once($path);
	return true;
}
/**
 * 保存操作日志
 *
 * @param int $id
 * @param string $model
 * @param string $content
 * @param int $user_id
 */
function savelog($id,$model,$content,$user_id=0)
{
	$log = new ModelLog();
	$log->save($id,$model,$content,$user_id);
}
//判断是否已经登录
$page = new Page();
if((!isset($_SESSION['admin_id']) || $_SESSION['admin_id'] =='') && ($_GET['model'] != 'login') &&  ($_GET['model'] != '')) {
	$page->todo('index.php?model=login','请先登录');
	}
if(isset($_SESSION['admin_id']) && $_SESSION['admin_id'] <>'' && ($_GET['model'] == '') && ($_GET['action'] != 'logout')){
    
	$page->todo('index.php?model=main');
}

?>
