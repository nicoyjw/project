<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                     |
// +--------------------------------------------------------------+
// | Copyright (c) 2010 - 2015 EPRSOFT.CN (www.eprsoft.cn)        |
// |                                                              |
// | 或者访问 http://www.eprsoft.cn/ 获得详细信息                    |
// +--------------------------------------------------------------+
/**
 * 首页
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Controller
 * @version v0.1
 */
 //echo phpinfo();
//header('Content-type: text/html; charset=utf8');
//echo '<center>服务器进行升级...升级时间延后</center>';
//header('location:http://www.cpowersoft.com/blog/?page_id=1605');
//if($_SERVER['REMOTE_ADDR'] !== '116.76.99.202'){header('location:http://www.cpowersoft.com/blog/index.html');}      


//$db = mysql_connect('localhost','root','');


require('common.inc.php');
$app = new App();
$app->run();
?>
