<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 入库单
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelStockin extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'stockin';
		$this->infotableName = CFG_DB_PREFIX . 'stockin_detail';
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
		$this->db->open('select m.order_id,m.order_sn,m.stockin_type,m.depot_id,m.out_time,m.supplier,m.comment,m.status,p.user_name as operator from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.'.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_IN_ORDER_PREFIX.$rs['order_sn'];
			$rs['out_time'] = MyDate::transform('date',$rs['out_time']);
			$rs['realstatus'] = $rs['status'];
			$rs1 = $this->db->getValue("SELECT sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice FROM ".$this->infotableName." where order_id = ".$rs['order_id']);
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalprice'] = $rs1['totalprice'];
			$rs['status'] = ModelDd::getCaption('o_status',$rs['status']);
			$rs['depot_id'] = ModelDd::getCaption('shelf',$rs['depot_id']);
			$rs['stocktype'] = ModelDd::getCaption('stockin_type',$rs['stockin_type']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 更新入库单状态
	 *
	 * @param array $info
	 */
	function update($info)
	{
		try{
			if($info['status'] == 3){
				$this->db->execute('delete from '.$this->tableName.' where order_id='.intval($info['order_id']));
				$this->db->execute('delete from '.$this->infotableName.' where order_id='.intval($info['order_id']));
				savelog($info['order_id'],'stockin','入库单被删除',$_SESSION['admin_id']);
			}else{
				$this->db->update($this->tableName,array(
					'status' => $info['status'],
					'out_time' => CFG_TIME
					),'order_id='.intval($info['order_id']));
			}
			savelog($info['order_id'],'stockin','入库单状态被更改',$_SESSION['admin_id']);
			if(CFG_GOODS_UPDATEQTY && ($info['status'] == 1)) $this->updategoods($info['order_id']);
		} catch (Exception $e) {
			throw new Exception('更新入库单状态失败');
		}
	}
	
	/**
	 * 更新产品库存
	 *
	 * @param array $info
	 */
	 function updategoods($id)
	 {
		$order_info = $this->order_info($id);
		$object = new ModelPurchaseorder();
	 	$this->db->open('select m.rec_id,m.goods_id,m.goods_qty,m.goods_price,p.depot_id,m.relate_order_sn from '.$this->infotableName.' as m left join '.$this->tableName.' as p on m.order_id = p.order_id  where m.is_ok = 0 and m.order_id = '.intval($id));
		$depotlist = ModelDd::getArray('shelf');
		while ($rs = $this->db->next()) {
				if($this->db->getValue("SELECT count(*) FROM ". CFG_DB_PREFIX ."depot_stock where goods_id =".intval($rs['goods_id'])." and shelf_id =".$rs['depot_id'])>0){
				$old_value = $this->db->getValue("SELECT goods_qty FROM ". CFG_DB_PREFIX ."depot_stock where goods_id =".intval($rs['goods_id'])." and shelf_id =".$rs['depot_id']);
					}else{
				$this->db->insert(CFG_DB_PREFIX ."depot_stock",array("goods_id"=>$rs['goods_id'],"shelf_id"=>$rs['depot_id']));	
				$old_value = 0;	
				}
				if(!$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set goods_qty = '".($rs['goods_qty']+$old_value)."' where goods_id=".intval($rs['goods_id'])." and shelf_id = ".intval($rs['depot_id']))) exit();
					$log['goods_id'] = $rs['goods_id'];
					$log['action'] = '产品入库';
					$log['field'] = 'goods_qty';
					$log['content'] = CFG_IN_ORDER_PREFIX.$order_info['order_sn'].'入库,'.$depotlist[$rs['depot_id']].'库存由'.$old_value.'更新为'.($rs['goods_qty']+$old_value);
					if(CFG_GOODS_UPDATECOST == 1 ){//更新成本价
				$cost = $this->db->getValue("SELECT cost from ".CFG_DB_PREFIX."goods where goods_id = '".$rs['goods_id']."'");
				$totalqty = $this->db->getValue("SELECT sum(goods_qty) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = '".$rs['goods_id']."'");
				$newcost = round((($totalqty-$rs['goods_qty'])*$cost+$rs['goods_qty']*$rs['goods_price'])/$totalqty,2);
				$this->db->execute("update ".CFG_DB_PREFIX."goods set cost ='".$newcost."' where goods_id = '".$rs['goods_id']."'");
				$log['content'] .= ",原成本价由".$cost."更新为".$newcost;
						}
					$log['admin_id'] = $_SESSION['admin_id'];
					$log['addtime'] = CFG_TIME;
					ModelGoods::goods_log($log);									
					$this->db->update($this->infotableName, array(
									'is_ok' => 1
									),'rec_id='.intval($rs['rec_id']));
					if(substr($rs['relate_order_sn'],0,strlen(CFG_P_ORDER_PREFIX)) == CFG_P_ORDER_PREFIX){//采购入库
							$pinfo['order_id'] = $this->db->getValue("SELECT order_id from ".CFG_DB_PREFIX."p_order where order_sn='".substr($rs['relate_order_sn'],strlen(CFG_P_ORDER_PREFIX))."'");
			$rec_id = $this->db->getValue("SELECT rec_id FROM ".CFG_DB_PREFIX."p_order_goods WHERE order_id =".$pinfo['order_id']." AND goods_id =".$rs['goods_id']." AND goods_qty>(arrival_qty+return_qty)");
			if($rec_id) $this->db->execute('update '.CFG_DB_PREFIX.'p_order_goods set arrival_qty = arrival_qty+'.$rs['goods_qty'].' where rec_id = '.$rec_id);
						}			
			}
							$qtys = $this->db->getValue("SELECT sum(arrival_qty+return_qty) as qty1,sum(goods_qty) as qty2 from ".CFG_DB_PREFIX.'p_order_goods where order_id = "'.$pinfo['order_id'].'"');
							if($qtys['qty1'] >= $qtys['qty2']){
								$pinfo['status'] = 3;
								}elseif($qtys['qty1'] > 0){
								$pinfo['status'] = 2;	
								}else{
								$pinfo['status'] = 1;
								}
							if($pinfo['order_id']) $object->update($pinfo);
	 }
	/**
	 * 获取入库单信息
	 *
	 * @param array $info
	 */
	function order_info($id)
	{
		return $this->db->getValue('select m.add_time,m.out_time,m.depot_id,m.operator_id,m.order_id,m.order_sn,m.supplier,m.comment,m.status,m.stockin_type as stocktype,n.name as supplier_name,sum(p.goods_qty) as total_qty from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'supplier as n on m.supplier = n.id left join '.$this->infotableName.' as p on m.order_id = p.order_id where m.order_id = '.$id.' GROUP BY p.order_id');
	}
	/**
	 * 保存入库单
	 *
	 * @param array $info
	 */
	function save($info)
	{
		if(substr($info['order_sn'],0,strlen(CFG_IN_ORDER_PREFIX)) == CFG_IN_ORDER_PREFIX) $info['order_sn'] = substr($info['order_sn'],strlen(CFG_IN_ORDER_PREFIX));
		if($info['order_id'] ==""){
			try {
				 $this->db->insert($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'add_time' => CFG_TIME,
						'operator_id' => $info['operator_id'],
						'stockin_type' => $info['stocktype'],
						'depot_id' => $info['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'comment' => $info['comment'],
						'supplier' => $info['supplier1']
						));
					$order_id = $this->db->getInsertId();
					$statusarr = ModelDd::getArray('p_status');
					if($statusarr[5]){
						$this->db->execute("update myr_p_order set status = 5 where order_id=".intval($info['p_order_id']));
					}
						} catch (Exception $e) {
					throw new Exception('保存入库单失败,订单号为'.CFG_IN_ORDER_PREFIX.$info['order_sn'],'999');exit();
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
							throw new Exception('保存入库明细失败,订单号'.CFG_IN_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}		
			}
			return $order_id;
		}else{
			try {
			$this->db->update($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'operator_id' => $info['operator_id'],
						'stockin_type' => $info['stocktype'],
						'depot_id' => $info['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'comment' => $info['comment'],
						'supplier' => $info['supplier1']
						),'order_id='.intval($info['order_id']));
						} catch (Exception $e) {
					throw new Exception('保存入库单失败,订单号为'.CFG_IN_ORDER_PREFIX.$info['order_sn'],'999');exit();
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
							throw new Exception('保存订单明细失败,订单号'.CFG_IN_ORDER_PREFIX.$info['order_sn'],'999');exit();
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
							throw new Exception('保存订单明细失败,订单号'.CFG_IN_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}				
				}		
			}
			return $info['order_id'];
		}
	}

	/**
	 * 入库单查询条件
	 *
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('keyword','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = " m.order_sn = '" . substr(mysql_like_quote($info['keyword']),strlen(CFG_OUT_ORDER_PREFIX)) . "' or n.goods_sn= '".$info['keyword']."' or n.goods_name = '".$info['keyword']."' or q.relate_order_sn = '".$info['keyword']."'";
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
	 * 入库单明细
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
	 * 获取入库单产品种类数
	 *
	 * @param int $id 订单ID
	 */
	function getgoodsCount($id)
	{
		return $this->db->getValue('select count(*) from '.$this->infotableName.' where order_id='.$id);
	}
	/**
	 * 删除入库单产品
	 *
	 * @param int $id 订单明细ID
	 */
	function delgoods($id)
	{
		try{
				$this->db->execute('delete from '.$this->infotableName
								.' where rec_id = '.$id);
			} catch (Exception $e) {
					throw new Exception('删除入库单产品失败');
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
	function revocation($id)
	{
		$orders = $this->db->getValue("SELECT order_sn,Sales_account_id,depot_id,is_lock from ".CFG_DB_PREFIX."order WHERE order_id = '".$id."'");
		if($orders['is_lock'] != 2){throw new Exception('订单未进行出库操作无法撤单入库','999');exit();}
		$account = ModelDd::getCaption('allaccount',$orders['Sales_account_id']);
		$info['order_id'] ="";
		$info['order_sn'] = $this->get_order_sn();
		$info['depot_id'] = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot WHERE depot_id = ".$orders['depot_id']." and is_main = 1");
		$info['operator_id'] = $_SESSION['admin_id'];
		$info['add_user'] = $_SESSION['admin_id'];
		$info['stockin_type'] = 6;
		$info['status'] = 1;
		$info['comment'] = $account.'账号'.date('Y-m-d').'撤单入库';
		$info['out_time'] = CFG_TIME;
		$info['supplier'] = 0;
			$object = new ModelOrder();
			$goods = $object->order_goods_info($id);
			for($i=0;$i<count($goods);$i++){
				$good = '';
				$good->goods_qty = $goods[$i]['goods_qty'];
				$good->relate_order_sn = CFG_ORDER_PREFIX.$orders['order_sn'];
				$modelgoods = new ModelGoods();
				$goodinfo = $modelgoods->goods_info('',$goods[$i]['goods_sn']);
				$good->goods_id = $goodinfo['goods_id'];
				$good->goods_price = $goodinfo['cost'];
				$good->remark = '';
				$info['data'][] = $good;
			}
	  	try {
				  $order_id = $this->save($info);
				  $this->updategoods($order_id);
				  $this->db->execute("update ".CFG_DB_PREFIX."order set is_lock = 0,is_mark=0,order_status = 113 WHERE order_id = '".$id."'");
						} catch (Exception $e) {
					throw new Exception('撤单入库失败,订单号为'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
				}
	}
	
	function getOnePorder($order_sn)
	{
		return $this->db->getValue('SELECT order_id FROM '.CFG_DB_PREFIX . 'p_order WHERE `order_sn`=\''.$order_sn.'\'');
			
	}
	function getOneGood($order_id,$goods_id)
	{	
		$rs = $this->db->getValue('SELECT p.order_id,sum(p.goods_qty-p.arrival_qty-p.return_qty) as goods_qty,p.goods_price,p.remark,g.goods_sn,g.goods_name,g.goods_id FROM `myr_p_order_goods` as p left outer join `myr_goods` as g  on(p.goods_id=g.goods_id) WHERE p.`order_id`=\''.$order_id.'\' AND p.`goods_id`=\''.$goods_id.'\'');
		$Purchaseorder = new ModelPurchaseorder();
		$info = $Purchaseorder->order_info($order_id);
		$rs['relate_order_sn'] = CFG_P_ORDER_PREFIX.$info['order_sn'];
		return $rs;
	}
	function getGoodsId($goods_sn)
	{	
		return $this->db->getValue('SELECT goods_id FROM '.CFG_DB_PREFIX.'goods WHERE `goods_sn`=\''.$goods_sn.'\'');
	}
	/**
	 * 导出入库单明细
	 *
	 * @param int $from 开始行
	 * @param int $to   结束行
	 * @param string $where 条件
	 * @return array
	 */
	function getExportList($where=null)
	{
		$this->db->open('select m.order_id,m.order_sn,m.stockin_type,m.depot_id,m.out_time,m.supplier,m.comment,m.status,p.user_name as operator,q.rec_id,q.goods_id,q.goods_qty,q.goods_price,q.relate_order_sn,n.goods_sn,n.goods_name,q.remark from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.'.$this->primaryKey.' desc');
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_IN_ORDER_PREFIX.$rs['order_sn'];
			$rs['out_time'] = MyDate::transform('date',$rs['out_time']);
			$rs['realstatus'] = $rs['status'];
			$rs1 = $this->db->getValue("SELECT sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice FROM ".$this->infotableName." where order_id = ".$rs['order_id']);
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalprice'] = $rs1['totalprice'];
			$rs['status'] = ModelDd::getCaption('o_status',$rs['status']);
			$rs['depot_id'] = ModelDd::getCaption('shelf',$rs['depot_id']);
			$rs['stocktype'] = ModelDd::getCaption('stockin_type',$rs['stockin_type']);
			$result[] = $rs;
		}
		return $result;
	}
    /**
    *需要导出的数据量
    */
    function getExportCount($where=null)
    {
        return $this->db->getValue('select count(q.rec_id) from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'admin_user as p on m.operator_id = p.user_id left join '.$this->infotableName.' as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id '.$where);
    }
	/**
	*根据SKU判断采购单商品
	*/
	function getPorderDetailBySku($info)
	{
		
        $result = $this->db->getValue("select g.goods_name,g.goods_sn,p.goods_price,p.goods_qty,p.rec_id,p.remark,p.goods_id from myr_p_order_goods as p left join myr_goods as g on p.goods_id = g.goods_id where p.order_id = ".$info['porder_id']." and g.goods_sn = '".$info['keyword']."'");
        
        if($result){
            $result['relate_order_sn'] = CFG_P_ORDER_PREFIX.$this->db->getValue("select order_sn from myr_p_order where order_id = ".$info['porder_id']);
        }
        
        return $result;
	}
}
?>