<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 主配置文件
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */

/** 
 * 数据库
 */
define('CFG_DB_HOST','localhost');   // 主机地址
define('CFG_DB_USER','root');        // 用户名	
define('CFG_DB_PASSWORD','');  // 密码
define('CFG_DB_ADAPTER','mysql');    // 数据库类型
define('CFG_DB_NAME','sale');       // 数据库名
define('CFG_DB_PREFIX','myr_');      // 表前缀
define('CFG_DB_CHARACTER','utf8');	 // 数据库编码
/* 
 * 站点信息
 */
define('CFG_CHARSET','utf-8');                    // 字符集
define('CFG_STYLE','default');                    // 主题样式
define('CFG_URL','http://qmx.cpowersoft.com/'); // 项目URL地址
define('CFG_DOMAIN','localhost');            // 有效域
define('CFG_DEBUG',true);                         // 调试状态 运行时改为flase
define('CFG_COOKIE_PREFIX','MYOIS_');			// cookie前缀
define('CFG_HASH_KEY','mu^*&*f(d&s');             // 加密HASH值
define('CFG_RUN_MODE',0);                         // 0 单用户模式
define('CFG_ADMIN_ID',1);	                      // 超管ID

define('CFG_DEFAULT_PASSWD','123456');			  // 用户默认密码
?>
