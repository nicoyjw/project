<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * DataSource 数组库连接类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package db
 * @version v0.1
 */

require_once('DbException.class.php');

/**
 * DataSource 数组库连接类
 * @package db
 */
class DataSource {
	/**
	 * 当前连接
	 * @var $connect
	 */
	var $connect		= NULL ;
	
	/**
	 * 数据库名称
	 * @var $name
	 */
	var $name			= '' ; 
	
	/**
	 * 数据库服务器登录密码
	 * @var $password
	 */
	var $password		= '' ; 
	
	/**
	 * 数据库服务器类型 [ mysql | mysqli | mssql | oracle ]
	 * @var $provider
	 */
	var $provider 		= 'mysql' ;
	
	/**
	 * 数据库服务器名称或IP
	 * @var $host 
	 */
	var $host			= 'localhost' ;
	/**
	 * 数据库服务器登录用户名
	 * @var $username
	 */
	var $username		= 'root' ;
	
	/**
	 * 构造函数
	 * @param string $host			数据库服务器名称或IP
	 * @param string $username		用户名
	 * @param string $password		用户密码
	 * @param string $name			数据库名称
	 * @param string $provider		数据提供者，即数据库类型
	 * @param bool $active			打开数据库连接
	 * @access public
	 */
	function __construct($host = NULL, $username = NULL, $password = NULL, 
			$name = NULL, $provider = NULL, $active = false) {
		$this->host		= ($host) ? $host : $this->host;
		$this->username = ($username) ? $username : $this->username ;
		$this->password = ($password) ? $password : $this->password ;
		$this->name		= ($name) ? $name : $this->name ;
		$this->provider = ($provider) ? $provider : $this->provider ;
		if ($active) {
			$this->open();
		}
	}
	
	/**
	 * 打开数据库连接
	 * @return bool
	 * @access public
	 */
	function open() {
		switch (strtolower($this->provider)) {
		case 'mysql':
			$result = $this->connect = @mysql_pconnect($this->host, $this->username, $this->password);
			if(mysql_get_server_info() > '4.1' && defined('CFG_DB_CHARACTER')) {
				mysql_query('SET character_set_connection='.CFG_DB_CHARACTER.', character_set_results='
						.CFG_DB_CHARACTER.', character_set_client=binary');
				if(mysql_get_server_info() > '5.0.1') {
					mysql_query("SET sql_mode=''");
				}
			}
			if ($result) {
				if (!@mysql_select_db($this->name)) {
					throw new DbException('数据库不存在', DbException::DB_OPEN_FAILED);
				}
			}
			include_once('DbQueryForMysql.class.php');
			break;
		default :
			$result = false ;
		}
		if (!$result) {
			$errorMessage = '连接数据库服务器<font color="#FF0000">' . $this->host . '</font></b>失败'
					. '或数据库“<b><font color="#FF0000">' . $this->name . '</font></b>”不存在！';
			throw new DbException($errorMessage, DbException::DB_OPEN_FAILED);
		}
		return ($result !== false) ;
	}
}
?>