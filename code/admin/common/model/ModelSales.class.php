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

class ModelSales extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'sales';
		$this->infotableName = CFG_DB_PREFIX . 'sales_goods';
	}
	
	/**
	 * 保存销售员
	 *
	 * @param Array $info
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'name' => $info['name'],
				'rate' => $info['rate'],
				'code' => $info['code'],
				'start_time' => MyDate::transform('timestamp',$info['start_time'])
				));
		} else {
			$this->db->update($this->tableName,array(
				'name' => $info['name'],
				'rate' => $info['rate'],
				'code' => $info['code'],
				'start_time' => MyDate::transform('timestamp',$info['start_time'])
				),'id='.intval($info['id']));
		}
		MOdelDd::cachesales();
	}
	
	/**
	 * 销售员产品查询条件
	 *
	 * @param array $info
	 */
	function getGoodsWhere($info){
		return ;
	}
	/**
	 * 销售员产品数量
	 *
	 * @param array $info
	 */
	function getGoodsCount($where){
		return $this->db->getValue('select count(*) from '.$this->infotableName.$where);
	}
	/**
	 * 销售员产品列表
	 *
	 * @param array $info
	 */
	function getGoodsList($from,$to,$where=null,$checkcombine=null){
		$this->db->open('select * from '.$this->infotableName.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	function delgoods($ids)
	{
		$this->db->execute('delete from '.$this->infotableName
.' where rec_id in ('.$ids.')');
		savelog($ids,'sales','销售员所有产品已被删除',$_SESSION['admin_id']);
	}
	/**
	 * 保存销售员产品
	 *
	 * @param array $info
	 */
	public function save_goods($info)
	{
			if($info['rec_id'] == 0 || $info['rec_id'] ==''){
				try{
					$this->db->insert($this->infotableName, array(
							'sku' => $info['sku'],
							'cost' => $info['cost'],
							'id' => $info['id']
							));
				} catch (Exception $e) {
					throw new Exception('保存销售员产品明细失败','604');exit();
				}	
			}else{
				try{
					$this->db->update($this->infotableName, array(
							'cost' => $info['cost'],
							'sku' => $info['sku']
							),'rec_id='.intval($info['rec_id']));
					savelog($info['rec_id'],'sales','销售员产品信息编辑',$_SESSION['admin_id']);
				} catch (Exception $e) {
					throw new Exception('保存销售员明细失败','605');exit();
				}				
			}
	}
	
	/**
	 * 保存渠道费率
	 *
	 * @param Array $info
	 */
	function savechannel($info)
	{
		if (empty($info['id'])) {
			$this->db->insert(CFG_DB_PREFIX.'sales_channels_rate',array(
				'sales_channels' => $info['sales_channels'],
				'rate' => $info['rate'],
				'fix' => $info['fix']
				));
		} else {
			$this->db->update(CFG_DB_PREFIX.'sales_channels_rate',array(
				'sales_channels' => $info['sales_channels'],
				'rate' => $info['rate'],
				'fix' => $info['fix']
				),'id='.intval($info['id']));
		}
		MOdelDd::cachechannelrate();
	}
	
	function delchannel($ids)
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX.'sales_channels_rate'
.' where id in ('.$ids.')');
	}
	/**************
	****获取渠道费用
	***int $id
	***string $result
	*****************/
	function getchannelfee($total,$cid)
	{
		$rate = $this->db->getValue("SELECT rate,fix FROM ".CFG_DB_PREFIX."sales_channels_rate where sales_channels = '".$cid."'");
		return number_format($total*$rate['rate']/100, 2, '.', '')+$rate['fix'];
	}
}
?>