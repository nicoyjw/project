<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Mysql 数据库的DbQueryForMysql类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package db
 * @version v0.1
 */
require('DbQuery.class.php');
/**
 * Mysql 数据库的DbQueryForMysql类
 * @package db
 */
class DbQueryForMysql extends DbQuery {
	
	/**
	 * 释放所占用的内存
	 * @param object $dataSet 需要释放资源的结果集
	 * @access public
	 */
	public function close($dataSet=NULL) {
		if ($dataSet) {
			@mysql_free_result($dataSet);
		} else {
			@mysql_free_result($this->dataSet);
			$this->eof = false ;
			$this->recordCount = 0 ;
			$this->recNo = -1 ;
		}
	}
	
	/**
	 * 对$pass进行数据库加密,返回加密之后的值
	 * @param string $pass 要加密的字符串
	 * @return string
	 * @access public
	 */
	public function encodePassword($pass) {
		return $this->getValue("SELECT password('$pass') AS pass");
	}
	
	/**
	 * 得到错误信息和错误代号
	 * @param integer $queryResult 查询结果
	 * @return array
	 * @access protected
	 */
	protected function errorInfo($queryResult = NULL) {
		$result['message'] = @mysql_error($this->ds->connect);
		$result['code'] = @mysql_errno($this->ds->connect);
		return $result;
	}
	
	/**
	 * 执行SQL语句
	 * @param string $sql SQL语句
	 * @return object
	 * @param int $rowFrom 启始行号，行号从1开始
	 * @param int $rowTo 结束行号，值为0表示
	 * @param bool $error 是否输出错误
	 * @access public
	 * @see DbQueryForMysql::open
	 */
	public function execute($sql = '', $rowFrom = 0, $rowTo = self::MAX_ROW_NUM, $error = true) {
		if ($rowTo != self::MAX_ROW_NUM || $rowFrom!=0) {
			$nrows = $rowTo - $rowFrom + 1; 
			$start = $rowFrom - 1;
			$start = ($start>=0) ? ((integer)$start) . ',' : '';
			$sql .= ' limit ' . $start  . $nrows;
		}
		$dataSet = @mysql_query($sql,  $this->ds->connect);
		
		if (!$dataSet && $error) {
			$sqlError = $this->errorInfo();
			$errorMessage = '执行[<b><font color="#FF0000">' . $sql 
					. '</font></b>]出错！<br> <font color=#FF0000> ['
					. $sqlError['code'] . ']: '
					. $sqlError['message'] . '</font>' ;
			$this->error(DbException::DB_QUERY_ERROR, $errorMessage);
		}
	
		return $dataSet;
	}

	/**
	 * 将一行的各字段值拆分到一个数组中
	 * @param object $dataSet 结果集
	 * @param integer $resultType 返回类型，OCI_ASSOC、OCI_NUM 或 OCI_BOTH
	 * @return array
	 */
	public function fetchRecord($dataSet=NULL, $resultType=MYSQL_BOTH) {
		$result = @mysql_fetch_array(($dataSet) ? $dataSet : $this->dataSet, $resultType);
		return $result;
	}

	/**
	 * 取得字段数量
	 * @param object $dataSet 结果集
	 * @return integer
	 */
	public function getFieldCount($dataSet = NULL) {
		return mysql_num_fields(($dataSet) ? $dataSet : $this->dataSet);
	}
	
	/**
	 * 得到当前数据库时间，格式为：yyyy-mm-dd hh:mm:ss
	 * @return string
	 * @access public
	 */
	public function getNow() {
		return $this->getValue('SELECT NOW() AS dateOfNow');
	}
	
	/**
	 * 取自增ID
	 *
	 * @return int
	 */
	public function getInsertId() {
		return $this->getValue('SELECT LAST_INSERT_ID()');
	}
	
	/**
	 * 表是否存在，返回true
	 * @param string $tableName 要查询的表名
	 * @return bool
	 * @access public
	 */
	public function tableIsExists($tableName) {
		$result = @mysql_query('SELECT * FROM ' . $tableName . ' LIMIT 0,1', $this->db->connect);
		return $result!==false;
	}
}
?>
