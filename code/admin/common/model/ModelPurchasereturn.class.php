<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 采购订单
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelPurchasereturn extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'p_return';
		$this->infotableName = CFG_DB_PREFIX . 'p_return_goods';
		$this->primaryKey = 'order_id';
	}

	/**
	 * 取列表
	 *
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getList($from,$to,$where=null)
	{
		$this->db->open('select m.order_id,m.order_sn,m.status,m.relate_order_sn,n.name as supplier,p.user_name as operator from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'supplier as n on m.supplier_id = n.id left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id ' .$where. ' order by m.'.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_P_ORDER_PREFIX.$rs['order_sn'];
			$rs1 = $this->db->getValue('select sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice from '.$this->infotableName.' where order_id = '.$rs['order_id']);
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalamt'] = $rs1['totalprice'];
			$rs['realstatus'] =$rs['status'];
			$rs['status'] = ModelDd::getCaption('o_status',$rs['status']);
			$rs['totalamt'] = is_null($rs['totalamt'])?0:$rs['totalamt'];
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 采购退货单查询条件
	 *
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('keyword','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = " m.relate_order_sn LIKE '%" . substr(mysql_like_quote($info['keyword']),strlen(CFG_P_ORDER_PREFIX)) . "%' or m.order_sn LIKE '%" . substr(mysql_like_quote($info['keyword']),strlen(CFG_P_RETURN_PREFIX)) . "%' or n.name LIKE '%" . mysql_like_quote($info['keyword']) . "%'";
		}
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'm.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'm.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'm.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}	
	
	/**
	 * 更新采购订单状态
	 *
	 * @param array $info
	 */
	function update($info)
	{
		try{
			if($info['status'] == 0){
				$this->db->execute("DELETE FROM ".$this->tableName." WHERE order_id =".intval($info['order_id']));
				$this->db->execute("DELETE FROM ".$this->infotableName." WHERE order_id =".intval($info['order_id']));
				return;
				}
			if( $info['status'] == 1) $this->updategoods($info['order_id']);
			$this->db->update($this->tableName,array(
					'status' => $info['status']
					),'order_id='.intval($info['order_id']));
		} catch (Exception $e) {
			throw new Exception('更新采购订单状态失败');
		}
	}
	
	/**
	 * 更新产品成本价格
	 *
	 * @param array $info
	 */
	function updategoods($id)
	 {
	 	$this->db->open('select m.rec_id,m.goods_id,m.goods_qty,p.relate_order_sn from '.$this->infotableName.' as m left join '.$this->tableName.' as p on m.order_id = p.order_id  where m.order_id = '.intval($id));
		while ($rs = $this->db->next()) {
			$p_id = $this->db->getValue("SELECT order_id from ".CFG_DB_PREFIX."p_order where order_sn='".substr($rs['relate_order_sn'],strlen(CFG_P_ORDER_PREFIX))."'");
			$rec_id = $this->db->getValue("SELECT rec_id FROM ".CFG_DB_PREFIX."p_order_goods WHERE order_id =".$p_id." AND goods_id =".$rs['goods_id']." AND goods_qty>(arrival_qty+return_qty)");
			if($rec_id) $this->db->execute('update '.CFG_DB_PREFIX.'p_order_goods set return_qty = return_qty+'.$rs['goods_qty'].' where rec_id = '.$rec_id);
					$this->db->update($this->infotableName, array(
									'is_ok' => 1
									),'rec_id='.intval($rs['rec_id']));
		}
							$qtys = $this->db->getValue("SELECT sum(arrival_qty+return_qty) as qty1,sum(goods_qty) as qty2 from ".CFG_DB_PREFIX.'p_order_goods where order_id = '.$p_id);
							if($qtys['qty1'] >= $qtys['qty2']){
								$status = 3;
								}elseif($qtys['qty1'] > 0){
								$status = 2;	
								}else{
								$status = 1;
								}
							$this->db->update(CFG_DB_PREFIX."p_order",array(
								"status" => $status
							),'order_id='.intval($p_id));
	 }
	/**
	 * 获取采购退货单
	 *
	 * @param array $info
	 */
	function order_info($id)
	{
		return $this->db->getValue('select m.*,n.name as supplier_name,n.address from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'supplier as n on m.supplier_id = n.id where order_id = '.$id);
	}
	/**
	 * 保存采购订单
	 *
	 * @param array $info
	 */
	function save($info)
	{
		if($info['order_id'] ==""){
			try {
			$this->db->insert($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'supplier_id' => $info['supplier_id'],
						'relate_order_sn' => $info['relate_order_sn'],
						'add_time' => CFG_TIME,
						'operator_id' => $info['operator_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status']
						));
					$order_id = $this->db->getInsertId();
						} catch (Exception $e) {
					throw new Exception('保存采购订单失败,订单号为'.CFG_P_ORDER_PREFIX.$info['order_sn'],'999');exit();
				}
			foreach($info['data'] as $goods){
					try{
					$this->db->insert($this->infotableName, array(
								'order_id' => $order_id,
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'remark' => $goods->remark
								));
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_P_ORDER_PREFIX.$order_id,'999');exit();
						}		
			}
			return $order_id;
		}else{
			try {
			$this->db->update($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'supplier_id' => $info['supplier_id'],
						'relate_order_sn' => $info['relate_order_sn'],
						'operator_id' => $info['operator_id'],
						'status' => $info['status']
						),'order_id='.intval($info['order_id']));
						} catch (Exception $e) {
					throw new Exception('保存订单失败,订单号为'.CFG_P_ORDER_PREFIX.$info['order_sn'],'999');exit();
				}
			foreach($info['data'] as $goods){
				if($goods->rec_id == 0){
					try{
					$this->db->insert($this->infotableName, array(
								'order_id' => $info['order_id'],
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'remark' => $goods->remark
								));
								$this->savesuppliergoods($goods,$info['supplier_id']);
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_P_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}
				}else{
					try{
					$this->db->update($this->infotableName, array(
								'order_id' => $info['order_id'],
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'remark' => $goods->remark
								),'rec_id='.intval($goods->rec_id));
								$this->savesuppliergoods($goods,$info['supplier_id']);
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_P_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}				
				}		
			}
			return $info['order_id'];
		}
	}

	function getCount($where)
	{
		return $this->db->getValue('select count(*) from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'supplier as n on m.supplier_id = n.id left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id ' .$where);
	}
	/**
	 * 采购订单明细
	 *
	 * @param int $id 订单ID
	 */
	function goods_info($from=0,$to=0,$id)
	{
		if($to ==0) $to = $this->getgoodsCount($id);
		$this->db->open("select m.rec_id,m.goods_id,m.goods_qty,m.goods_price,n.goods_sn,n.goods_name,m.remark from ".$this->infotableName." as m left join ".CFG_DB_PREFIX ."goods  as n on m.goods_id = n.goods_id where m.order_id ='$id'",$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取退货单产品种类数
	 *
	 * @param int $id 订单ID
	 */
	function getgoodsCount($id)
	{
		return $this->db->getValue('select count(*) from '.$this->infotableName.' where order_id='.$id);
	}
	/**
	 * 删除采购订单产品
	 *
	 * @param int $id 订单明细ID
	 */
	function delgoods($id)
	{
		try{
				$this->db->execute('delete from '.$this->infotableName
								.' where rec_id = '.$id);
			} catch (Exception $e) {
					throw new Exception('删除采购订单产品失败');
			}
	}
	/**
	 * 得到新订单号
	 * @return  string
	 */
	function get_order_sn()
	{
		/* 选择一个随机的方案 */
		mt_srand((double) microtime() * 1000000);
	
		return date('ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
	}
}
?>