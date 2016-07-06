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
 * 快递规则类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelCurrency extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'currency';
	}
	
	/**
	 * 保存汇率
	 *
	 * @param Array $info
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'currency' => $info['currency'],
				'rate' => $info['rate']
				));
		} else {
			$this->db->update($this->tableName,array(
				'currency' => $info['currency'],
				'rate' => $info['rate']
				),'id='.intval($info['id']));
		}
		ModelDd::cacheCurrency();
	}
	
	/**
	 * 自动更新汇率
	 *
	 * @param Array $info
	 */
	function ajax()
	{
		$this->db->open('select id,currency from '.$this->tableName.' order by '.$this->primaryKey.' desc');
		while ($rs = $this->db->next()) {
			$rate = $this->quote_xe_currency($rs['currency'],CFG_CURRENCY);
			$rate = $rate?$rate:1;
			$this->db->update($this->tableName,array(
				'rate' => $rate
				),'id='.intval($rs['id']));
		}
		$this->db->open('select id,currency from '.$this->tableName.' where  rate = 1 order by '.$this->primaryKey.' desc');
		while ($rs = $this->db->next()) {
			$rate = $this->quote_xe_currency($rs['currency'],CFG_CURRENCY);
			$rate = $rate?$rate:1;
			$this->db->update($this->tableName,array(
				'rate' => $rate
				),'id='.intval($rs['id']));
		}
		ModelDd::cacheCurrency();
	}
	function quote_xe_currency($from,$to)
	{
		$page = file('http://www.oanda.com/convert/fxdaily?value=1&redirected=1&exch='.$to .  '&format=CSV&dest=Get+Table&sel_list=' . $from);
		$match = array();
		preg_match('/(.+),(\w{3}),([0-9.]+),([0-9.]+)/i', implode('', $page), $match);
		if (sizeof($match) > 0) {
		  return $match[3];
		} else {
		  return false;
		}
	}
	
	function currencyformat()
	{
		require(CFG_PATH_DATA . 'dd/currency.php');
		$currency['CNY'] = 1;
		foreach ($currency as $key => $value) {
			$result[] = '[\''.$key.'\',\''.$key.'\']';
		}
		$string = implode(',',$result);
		return $string;
	}
}
?>