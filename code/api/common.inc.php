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
 * @package   Common
 * @version   v0.1
 */

define ('CFG_PATH_ROOT' , dirname (__FILE__) . '/');

/** 自定义日志
 *
 * 0：不开启日志
 * 1：开启fatal            (Fatal)
 * 2：开启Error    及以上  (Fatal,Error)
 * 3：开启Warn     及以上  (Fatal,Error,Warn）
 * 4：开启Debug    及以上  (Fatal,Error,Warn,Debug)
 * 5：开启Log      及以上  (Fatal,Error,Warn,Debug,Log)
 * 6：开启Trace    及以上  (Fatal,Error,Warn,Debug,Log,Trace)
 */
define ('CFG_LOG_LEVEL' , 6);

define ("CFG_REDIS_PERMISSIONS_KEY" , "user_permission_");

define ("CFG_REDIS_ENCRYPT" , "encryptKey");

require ('App.class.php');
require ('Controller.class.php');
require ('Model.class.php');

require ('lib/db/DB.Mongo.php');
require ('lib/db/DB.Redis.php');

require ('lib/util/JSON.php');
require ('lib/util/Util.log.php');
require ('lib/util/Util.inc.php');

require ('lib/util/StringUtil.class.php');

header ("Access-Control-Allow-Origin: *");
header ('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header ('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
header ('Access-Control-Allow-Credentials: true');
@header ('content-Type: text/html; charset=utf-8');

error_reporting (E_ERROR);

/**
 *  对用户传入的变量进行转义操作。
 */
if (!get_magic_quotes_gpc ()) {
    if (!empty($_GET)) {
        $_GET = addslashes_deep ($_GET);
    }
    if (!empty($_POST)) {
        $_POST = addslashes_deep ($_POST);
    }

    $_COOKIE = addslashes_deep ($_COOKIE);
    $_REQUEST = addslashes_deep ($_REQUEST);
}


//注册公共服务
$json = new Services_JSON();
App::setRegistry ('json' , $json);

?>
