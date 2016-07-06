<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 出库单
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelStockout extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'stockout';
		$this->infotableName = CFG_DB_PREFIX . 'stockout_detail';
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
		$this->db->open('select m.order_id,m.order_sn,m.stockout_type,m.depot_id,m.add_time,m.supplier,m.comment,m.out_time,m.status,p.user_name as operator from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.'.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_OUT_ORDER_PREFIX.$rs['order_sn'];
			$rs['out_time'] = MyDate::transform('date',$rs['out_time']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['realstatus'] = $rs['status'];
			$rs1 = $this->db->getValue("SELECT sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice FROM ".$this->infotableName." where order_id = ".$rs['order_id']);
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalprice'] = $rs1['totalprice'];
			$rs['status'] = ModelDd::getCaption('o_status',$rs['status']);
			$rs['depot_id'] = ModelDd::getCaption('shelf',$rs['depot_id']);
			$rs['stocktype'] = ModelDd::getCaption('stockout_type',$rs['stockout_type']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 更新出库单状态
	 *
	 * @param array $info
	 */
	function update($info)
	{
		try{
			if($info['status'] == 3){
				$this->db->execute('delete from '.$this->tableName.' where order_id='.intval($info['order_id']));
				$this->db->execute('delete from '.$this->infotableName.' where order_id='.intval($info['order_id']));
				savelog($info['order_id'],'stockin','出库单被删除',$_SESSION['admin_id']);
			}else{
			if($info['status'] == 1){
				if(CFG_GOODS_UPDATEQTY == 1) $this->updategoods($info['order_id']);
				$this->db->update($this->tableName,array(
						'out_time' => CFG_TIME
						),'order_id='.intval($info['order_id']));
				}
			$this->db->update($this->tableName,array(
					'status' => $info['status']
					),'order_id='.intval($info['order_id']));
			}
			savelog($info['order_id'],'stockout','出库单状态被更改',$_SESSION['admin_id']);
		} catch (Exception $e) {
			throw new Exception('更新出库单状态失败');
		}
	}
	
	/**
	 * 更新产品库存
	 *
	 * @param array $info
	 */
	 private function updategoods($id)
	 {
		$order_info = $this->order_info($id);
	 	$this->db->open('select m.rec_id,m.goods_id,m.goods_qty,p.depot_id from '.$this->infotableName.' as m left join '.$this->tableName.' as p on m.order_id = p.order_id  where m.is_ok = 0 and m.order_id = '.intval($id));
		$depotlist = ModelDd::getArray('shelf');
		while ($rs = $this->db->next()) {
				if($rs['goods_id'] == 0 || $rs['goods_qty'] == 0){
					$this->db->update($this->infotableName, array(
									'is_ok' => 1
									),'rec_id='.intval($rs['rec_id']));
					continue;
				}
				if($this->db->getValue("SELECT count(*) FROM ". CFG_DB_PREFIX ."depot_stock where goods_id =".intval($rs['goods_id'])." and shelf_id =".$rs['depot_id'])>0){
				$old_value = $this->db->getValue("SELECT goods_qty FROM ". CFG_DB_PREFIX ."depot_stock where goods_id =".intval($rs['goods_id'])." and shelf_id =".$rs['depot_id']);
					}else{
				$this->db->insert(CFG_DB_PREFIX ."depot_stock",array("goods_id"=>$rs['goods_id'],"shelf_id"=>$rs['depot_id']));	
				$old_value = 0;
				throw new Exception('警告:单据需出库产品该仓库不存在');
				}
				if(!$this->db->update(CFG_DB_PREFIX .'depot_stock', array(
								'goods_qty' => $old_value-$rs['goods_qty']
								),'goods_id='.intval($rs['goods_id']).' and shelf_id = '.intval($rs['depot_id']))) exit();
					$log['goods_id'] = $rs['goods_id'];
					$log['action'] = '产品出库';
					$log['field'] = 'goods_qty';
					$log['content'] = CFG_OUT_ORDER_PREFIX.$order_info['order_sn'].'出库,'.$depotlist[$rs['depot_id']].'库存由'.$old_value.'更新为'.($old_value-$rs['goods_qty']);
					$log['admin_id'] = $_SESSION['admin_id'];
					$log['addtime'] = CFG_TIME;
					ModelGoods::goods_log($log);									
					$this->db->update($this->infotableName, array(
									'is_ok' => 1
									),'rec_id='.intval($rs['rec_id']));
		}
	 }
	/**
	 * 获取出库单信息
	 *
	 * @param array $info
	 */
	function order_info($id)
	{
		return $this->db->getValue('select m.out_time,m.operator_id,m.depot_id,m.order_id,m.comment,m.supplier,m.order_sn,m.add_time,m.status,m.stockout_type as stocktype,sum(goods_qty) as total_qty from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id where m.order_id = '.$id.' GROUP BY p.order_id');
	}
	/**
	 * 保存出库单
	 *
	 * @param array $info
	 */
	function save($info)
	{
		if(substr($info['order_sn'],0,strlen(CFG_OUT_ORDER_PREFIX)) == CFG_OUT_ORDER_PREFIX) $info['order_sn'] = substr($info['order_sn'],strlen(CFG_OUT_ORDER_PREFIX));
		if($info['order_id'] ==""){
			try {
				 $this->db->insert($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'add_time' => CFG_TIME,
						'out_time' => $info['out_time'],
						'operator_id' => $info['operator_id'],
						'stockout_type' => $info['stocktype'],
						'depot_id' => $info['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'comment' => $info['comment'],
						'supplier' => $info['supplier2']
						));
					$order_id = $this->db->getInsertId();
						} catch (Exception $e) {
					throw new Exception('保存出库单失败,订单号为'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'554');exit();
				}
			foreach($info['data'] as $goods){
					try{
					$this->db->insert($this->infotableName, array(
								'order_id' => $order_id,
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'relate_order_sn' => $goods->relate_order_sn,
								'remark' => $goods->remark
								));
								} catch (Exception $e) {
							throw new Exception('保存入库明细失败,订单号'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'553');exit();
						}		
			}
			return $order_id;
		}else{
			try {
			$this->db->update($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'add_time' => CFG_TIME,
						'operator_id' => $info['operator_id'],
						'stockout_type' => $info['stocktype'],
						'depot_id' => $info['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'comment' => $info['comment'],
						'supplier' => $info['supplier2']
						),'order_id='.intval($info['order_id']));
						} catch (Exception $e) {
					throw new Exception('保存订单失败,订单号为'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
				}
			foreach($info['data'] as $goods){
				if($goods->rec_id == 0){
					try{
					$this->db->insert($this->infotableName, array(
								'order_id' => $info['order_id'],
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'relate_order_sn' => $goods->relate_order_sn,
								'remark' => $goods->remark
								));
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}
				}else{
					try{
					$this->db->update($this->infotableName, array(
								'order_id' => $info['order_id'],
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'goods_price' => $goods->goods_price,
								'relate_order_sn' => $goods->relate_order_sn,
								'remark' => $goods->remark
								),'rec_id='.intval($goods->rec_id));
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}				
				}		
			}
			return $info['order_id'];
		}
	}

	/**
	 * 出库单查询条件
	 *
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('keyword','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = " m.order_sn = '" . substr(mysql_like_quote($info['keyword']),strlen(CFG_OUT_ORDER_PREFIX)) . "' or n.goods_sn= '".$info['keyword']."' or n.goods_name = '".$info['keyword']."'";
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
	
	function getCount($where)
	{
		return $this->db->getValue('select count(a.order_id) from '.$this->tableName .' as a where a.order_id in( select distinct m.order_id from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where.')');
	}
	/**
	 * 出库单明细
	 *
	 * @param int $id 订单ID
	 */
	function goods_info($from,$to,$id)
	{
		$this->db->open("select m.rec_id,m.goods_id,m.goods_qty,m.goods_price,m.relate_order_sn,n.goods_sn,n.goods_name,m.remark from ".$this->infotableName." as m left join ".CFG_DB_PREFIX ."goods  as n on m.goods_id = n.goods_id where m.order_id =" .$id,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取出库单产品种类数
	 *
	 * @param int $id 订单ID
	 */
	function getgoodsCount($id)
	{
		return $this->db->getValue('select count(*) from '.$this->infotableName.' where order_id='.$id);
	}
	/**
	 * 删除出库单产品
	 *
	 * @param int $id 订单明细ID
	 */
	function delgoods($id)
	{
		try{
				$this->db->execute('delete from '.$this->infotableName
								.' where rec_id = '.$id);
			} catch (Exception $e) {
					throw new Exception('删除出库单产品失败');
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

	/**
	 * 导出出库单明细
	 *
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getExportList($where=null)
	{
		$this->db->open('select m.order_id,m.order_sn,m.stockout_type,m.depot_id,m.add_time,m.supplier,m.comment,m.out_time,m.status,p.user_name as operator,q.rec_id,q.goods_id,q.goods_qty,q.goods_price,q.relate_order_sn,n.goods_sn,n.goods_name,q.remark from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.'.$this->primaryKey.' desc');
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_OUT_ORDER_PREFIX.$rs['order_sn'];
			$rs['out_time'] = MyDate::transform('date',$rs['out_time']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['realstatus'] = $rs['status'];
			$rs1 = $this->db->getValue("SELECT sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice FROM ".$this->infotableName." where order_id = ".$rs['order_id']);
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalprice'] = $rs1['totalprice'];
			$rs['status'] = ModelDd::getCaption('o_status',$rs['status']);
			$rs['depot_id'] = ModelDd::getCaption('shelf',$rs['depot_id']);
			$rs['stocktype'] = ModelDd::getCaption('stockout_type',$rs['stockout_type']);
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	*需要导出的数据量
	*/
	function getExportCount($where=null)
	{
		return $this->db->getValue('select count(q.rec_id) from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where);
	}
}
?>