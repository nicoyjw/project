<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 数据库的查询抽象类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package db
 * @version v0.1
 */
/**
 * 数据库的查询基类
 * @package db
 */
abstract class DbQuery {

	/**
	 * select方法返回的最大记录数
	 */
	const MAX_ROW_NUM = 1000;

	/**
	 * 数据查询结果集对象
	 * @var object $dataSet
	 */
	public $dataSet			= NULL ;

	/**
	 * 数据源对象
	 * @var object $ds
	 */
	public $ds				= NULL ;

	/**
	 * 查询的SQL语句
	 * @var string $sql
	 */
	public $sql				= '' ;
	
	/**
	 * 构造函数
	 * @param object $ds 数据库
	 * @param string $sql 要初始化查询的SQL语句
	 */
	function __construct($ds=NULL , $sql=NULL) {
		if (!$ds) {
			$this->error(DbException::DB_UNCONNECTED, '数据库还未连接。');
		} else {
			$this->ds = $ds;
			if ($sql) {
				$this->open($sql);
			}
		}
	}
	
	/**
	 * 错误信息处理
	 * @param string $errorId 错误ID
	 * @param string $errorMessage 错误信息
	 * @access protected
	 */
	protected function error($errorId, $errorMessage) {
		throw new DbException($errorMessage, $errorId);
	}
	
	/**
	 * 执行SQL语句，结果集保存到属性$dataSet中
	 * @param string $sql SQL语句
	 * @param int $rowFrom 启始行号，行号从1开始
	 * @param int $rowTo 结束行号，值为0表示
	 * @return object
	 * @access public
	 * @see DbQueryForMysql::execute
	 */
	public function open($sql='', $rowFrom = 0, $rowTo = self::MAX_ROW_NUM) {
		$this->dataSet = $this->execute($sql, $rowFrom, $rowTo);
		$this->sql = $sql ;
		return $this->dataSet;
	}
	
	/**
	 * 取得下一条记录。返回记录号，如果到了记录尾，则返回FALSE
	 * @return integer
	 * @access public
	 * @see getPrior()
	 */
	public function next() {
		return $this->fetchRecord();
	}
	
	/**
	 * 根据SQL语句从数据表中取数据，只取第一条记录的值，
	 * 如果记录中只有一个字段，则只返回字段值。
	 * 未找到返回 FALSE
	 *
	 * @param string $sql SQL语句
	 * @return array
	 * @access public
	 */
	public function getValue($sql) { 
		$dataSet = $this->execute($sql, 1, 1);
		if ($result = $this->fetchRecord($dataSet)) {
			$fieldCount = $this->getFieldCount($dataSet);
			$this->close($dataSet);
			return ($fieldCount<=1) ? $result[0] : $result;
		} else {
			return false ;
		}
	}


	
	/**
	 * 插入一条记录
	 * @param string $tableName 表名
	 * @param array $fieldArray 字段数组
	 * @param string $whereForUnique 唯一性条件
	 * @return int
	 * @access public
	 */
	public function insert($tableName, $fieldArray, $whereForUnique = NULL) {
		if (!$tableName || !$fieldArray || !is_array($fieldArray)) {
			throw new Exception('参数 $tableName 或 $fieldArray 的值不合法！');
		}
		if ($whereForUnique) {
			$where = ' WHERE ' . $whereForUnique;
			$isExisted = $this->getValue('SELECT COUNT(*) FROM ' . $tableName . $where);
			if ($isExisted) {
				throw new DbException('记录已经存在！', DbException::DB_RECORD_IS_EXISTED);
			}
		}
		$fieldNameList = array();
		$fieldValueList = array();
		foreach ($fieldArray as $fieldName => $fieldValue) {
			if (!is_int($fieldName)) {
				$fieldNameList[] = $fieldName;
				$fieldValueList[] = '\'' . $fieldValue . '\'';
			}
		}
		$fieldName = implode(',', $fieldNameList);
		$fieldValue = implode(',', $fieldValueList);
		$sql = 'INSERT INTO ' . $tableName . '('
					. $fieldName . ') VALUES (' . $fieldValue . ')';
		return $this->execute($sql);
	}
	
	/**
	 * 更新一条记录
	 * @param string $tableName 表名
	 * @param array $fieldArray 字段数组
	 * @param string $whereForUpdate 查询条件
	 * @param string $whereForUnique 唯一性条件
	 * @return int
	 * @access public
	 */
	public function update($tableName, $fieldArray, $whereForUpdate=NULL, $whereForUnique=NULL) {
		if (!$tableName || !$fieldArray || !is_array($fieldArray)) {
			throw new Exception('参数 $tableName 或 $fieldArray 的值不合法！');
		}
		if ($whereForUnique) {
			$where = ' WHERE ' . $whereForUnique;
			$isExisted = $this->getValue('SELECT COUNT(*) FROM ' . $tableName . $where);
			if ($isExisted) {
				throw new DbException('记录已经存在！', DbException::DB_RECORD_IS_EXISTED);
			}
		}
		$fieldNameValueList = array();
		foreach ($fieldArray as $fieldName => $fieldValue) {
			if (!is_int($fieldName)) {
				$fieldNameValueList[] = $fieldName . '=\'' . $fieldValue . '\'';
			}
		}
		$fieldNameValue = implode(',', $fieldNameValueList);
		if ($whereForUpdate) {
			$whereForUpdate = ' WHERE ' . $whereForUpdate;
		}
		$sql = 'UPDATE ' . $tableName 
				. ' SET ' . $fieldNameValue . $whereForUpdate;
		return $this->execute($sql);
	}
	
	/**
	 * 选择一条记录
	 * @param string $sql sql语句
	 * @param string $dataFormat 返回数据格式, 值有"array","hashmap","hashmap_str","dataset"
	 * @param int $rowFrom 启始行号，行号从1开始
	 * @param int $rowTo 结束行号，值为0表示
	 * @result array
	 * @access public
	 */
	public function select($sql, $dataFormat = 'array', $rowFrom = 0, $rowTo = self::MAX_ROW_NUM) {
		$dataSet = $this->execute($sql, $rowFrom, $rowTo);
		switch ($dataFormat) {
		case 'array': //数组
			$result = array();
			$isMultiField = ($this->getFieldCount($dataSet) > 1);
			$i = 0;
			while ($data = $this->fetchRecord($dataSet)) {
				$result[$i] = ($isMultiField) ? $data : $data[0];
				$i++;
			}
			$this->close($dataSet);
			break;

		case 'hashmap': //散列表
			$result = array();
			while ($data = $this->fetchRecord($dataSet)) {
				$result[ $data[0] ] = $data[1];
			}
			$this->close($dataSet);
			break;

		case 'hashmap_str': //散列表字符串
			$result = array();
			while ($data = $this->fetchRecord($dataSet, OCI_NUM)) {
				$result[] = $data[0] . '=' . $data[1];
			}
			$result = implode('|', $result);
			$this->close($dataSet);
			break;

		default: //dataset 数据集，当返回数据格式为数据集时，select方法的功能与execute方法相同
			$result = $dataSet;
		}
		return $result;
	}
	
	/**
	 * 返回最大值
	 * @param string $tableName 表名
	 * @param string $idField 字段名
	 * @param string $where 查询条件
	 * @return int
	 * @access public
	 */
	public function getMax($tableName, $idField, $where = NULL) {
		$where = ($where) ? (' WHERE ' . $where) : '';
		return $this->getValue('SELECT MAX(' . $idField . ') FROM ' . $tableName . $where);
	}
	
	/**
	 * 释放所占用的内存
	 * @param object $dataSet 需要释放资源的结果集
	 * @access public
	 */
	abstract public function close($dataSet=NULL);
	
	/**
	 * 对$pass进行数据库加密,返回加密之后的值
	 * @param string $pass 要加密的字符串
	 * @return string
	 * @access public
	 */
	public function encodePassword($pass) {
		return md5($pass);
	}
	
	/**
	 * 得到错误信息和错误代号
	 * @param integer $queryResult 查询结果
	 * @return array
	 * @access protected
	 */
	abstract protected function errorInfo($queryResult = NULL);
	
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
	abstract public function execute($sql = '', $rowFrom = 0, $rowTo = self::MAX_ROW_NUM, $error = true);

	/**
	 * 将一行的各字段值拆分到一个数组中
	 * @param object $dataSet 结果集
	 * @param integer $resultType 返回类型，OCI_ASSOC、OCI_NUM 或 OCI_BOTH
	 * @return array
	 */
	abstract public function fetchRecord($dataSet=NULL, $resultType=null);

	/**
	 * 取得字段数量
	 * @param object $dataSet 结果集
	 * @return integer
	 */
	abstract public function getFieldCount($dataSet = NULL);
	
	/**
	 * 得到当前数据库时间，格式为：yyyy-mm-dd hh:mm:ss
	 * @return string
	 * @access public
	 */
	abstract public function getNow();
	
	/**
	 * 取自增ID
	 *
	 * @return int
	 */
	abstract public function getInsertId();
	
	/**
	 * 表是否存在，返回true
	 * @param string $tableName 要查询的表名
	 * @return bool
	 * @access public
	 */
	abstract public function tableIsExists($tableName);
}
?>