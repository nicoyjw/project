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
 * 公告分类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelCategory extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	public function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'news_catalog';
	}
	/**
	 * 保存记录
	 *
	 * @param array $cat
	 */
	public function save($cat)
	{
		specConvert($info,array('nc_caption','note'));
		if (!$cat['id']) {
			$this->db->insert($this->tableName,array(
				'nc_caption' => $cat['nc_caption'],
				'note' => $cat['note'],
				'parent_id' => $cat['parent']
				));
		} else {
			$this->db->update($this->tableName,array(
				'nc_caption' => $cat['nc_caption'],
				'note' => $cat['note'],
				'parent_id' => $cat['parent']
				),'id=' . intval($cat['id']));
		}
		$this->cache();
	}

	/**
	 * 分类列表
	 *
	 * @return string
	 */
	public function getCatData()
	{
		$data = include(CFG_PATH_DATA.'tmp/cache/cat.php');
		if ($data) {
			$result = array();
			foreach ($data as $c) {
				$result[] = '[' . $c['id'] . ',\'' . $c['nc_caption'] . '\'' . ']';
			}
			$string = implode(',', $result);
		}
		return $string!='' ? $string : false;
	}
	
	function cache() {
		$data = $this->db->select('SELECT `id`,`nc_caption` FROM ' . $this->tableName);
		$fp = fopen(CFG_PATH_DATA.'tmp/cache/cat.php','w');
		fputs($fp,'<?php return '.var_export($data,true).'; ?>');
		fclose($fp);
	}

}
?>