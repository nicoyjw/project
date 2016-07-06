<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 产品属性类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

	class ModelProductSync extends Model {
		/**
		 * 构造函数
		 * @param object $query
		 */
		function __construct($query = NULL) {
			parent::__construct($query);
			$this->tableName = CFG_DB_PREFIX . 'product_sync_list';
			$this->primaryKey = 'product_sync_list_id';
			$this->fields = array('product_id' => 'int', 'product_sku' => 'string', 'website_id' => 'int',
				'website_name' => 'string', 'language_id' => 'int', 'language_code' => 'string', 'product_category' => 'text',
				'product_title' => 'string', 'product_description' => 'text', 'product_attribute' => 'text', 'product_meta_title' => 'string',
				'product_meta_keyword' => 'string', 'product_meta_description' => 'string', 'product_purchase_price' => 'float', 'product_price' => 'float',
				'product_weight' => 'float', 'product_length' => 'float', 'product_width' => 'float', 'product_height' => 'float',
				'product_stock' => 'int', 'product_status' => 'int', 'sync_status' => 'int', 'sync_status_remark' => 'string', 'sync_response_remark' => 'string'
			);
		}
		
		/**
		 * 同步列表过滤
		 * @param array $data 过滤数组
		 * 
		 */
		public function getListWhere($data) {
			//specConvert($data, array('product_sku', 'product_title'));
			$this->validateData($data);
			$where = '';
			foreach ($data as $field => $value) {
				$where .= "`" . $field . "` = '" . $value . "' and ";
			}
			$where = " where " . $where . "1";
			
		}
		
		/**
	 	* 查询总数
	 	*
	 	* @param string $where
	 	*/
		function getCount($where=NULL){
			return $this->db->getValue('select count(*) from '.$this->tableName.$where);
		}		
		
		/**
		 * 查询列表
		 * @param string $from
		 * @param string $to
		 * @param string $where
		 */
		
		public function getList($from, $to, $where =NULL) {	
			$return = array();
			$this->db->open("select * from " . $this->tableName . $where, $from, $to);
			while ($rs = $this->db->next()) {
				$return[] = array(
					'product_sync_list_id' => $rs['product_sync_list_id'],
					'product_id' => $rs['product_id'],
					'product_sku' => $rs['product_sku'],
					'website_id' => $rs['website_id'],
					'website_name' => $rs['website_name'],
					'language_id' => $rs['language_id'],
					'language_code' => $rs['language_code'],
					'product_title' => $rs['product_title'],
					'sync_status' => $rs['sync_status'],
					'sync_status_remark' => $rs['sync_status_remark'],
					'sync_response_remark' => $rs['sync_response_remark'],
					'add_data' => date('Y-m-d', $rs['add_date'])
				);
			}
			return $return;
		}
		
		/**
		 * 更新函数
		 * @param array $data
		 * return boolean
		 */
		public function update($data) {
			if (!array_key_exists($this->primaryKey, $data)) return false;
			$id = (int)$data[$this->primaryKey];
			$data = $this->validateData($data);
			return $this->db->update($this->tableName, $data, "`" . $this->primaryKey . "` = " . $id);
		}
		
		/**
		 * 添加函数
		 * @param array $data
		 * return boolean
		 */
		public function insert($data) {
			$data = $this->validateData($data);
			$this->db->insert($this->tableName, $data);
			return $this->db->getInsertId();
		}
		
		public function getSyncProduct($data){
				
			
		}
		
		/**
		 * 验证数据
		 * @param array $data 数据库列数据
		 * return array $fieldArray
		 */
		public function validateData($data) {
			$fieldArray = array();
			foreach ($data as $field => $value){
				if (!array_key_exists($field, $this->fields)) contine;
				$type = $this->fields[$field];
				switch ($type) {
					case 'int' : $fieldArray[$field] = intval($value); break;
					case 'string' : $fieldArray[$field] = addslashes(striptags($value)); break;
					case 'float': $fieldArray[$field] = floatval($value);break;
					case 'text' : $fieldArray[$field] = addslashes(htmlspecialchar($value)); break;
					default : ;
				}
			}
			return $fieldArray;
		}
	}
?>