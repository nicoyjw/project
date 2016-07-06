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
 * 采购订单
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelPurchaseorder extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'p_order';
		$this->infotableName = CFG_DB_PREFIX . 'p_order_goods';
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
		$this->db->open('select m.order_id,m.order_sn,m.comment,m.pre_time,m.status,n.name as supplier,m.operator_id,m.add_user,m.arrive_time,m.shipping_fee from '.$this->tableName .' as m left join ' . CFG_DB_PREFIX . 'supplier as n on m.supplier_id = n.id ' .$where. ' order by m.'.$this->primaryKey.' desc',$from,$to);
		$userlist = ModelDd::getArray("user");
        
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_P_ORDER_PREFIX.$rs['order_sn'];
			$rs['overtime'] = ($rs['pre_time'] <= CFG_TIME && $rs['arrive_time'] =='')?1:0;
			$rs['pre_time'] = MyDate::transform('date',$rs['pre_time']);
			$rs['arrive_time'] = MyDate::transform('date',$rs['arrive_time']);
			$rs1 = $this->db->getValue('select sum(goods_qty) as totalqty,sum(goods_qty*goods_price) as totalprice from '.$this->infotableName.' where order_id = '.$rs['order_id']);
			$rs['operator'] = $userlist[$rs['operator_id']];
			$rs['add_user'] = $userlist[$rs['add_user']];
			$rs['totalqty'] = $rs1['totalqty'];
			$rs['totalamt'] = $rs1['totalprice'];
			
			$rs['goods'] = $this->db->select('select p.*,g.goods_sn from myr_p_order_goods as p left join myr_goods as g on p.goods_id = g.goods_id where p.order_id = '.$rs['order_id']);
			$sn = '';
			for($i=0;$i<count($rs['goods']);$i++){
				$sn .= $rs['goods'][$i]['goods_sn'].'*'.$rs['goods'][$i]['goods_qty'].'<br/>';
			}
			$rs['goods'] = $sn;
			$rs['realstatus'] =$rs['status'];
			$rs['status'] = ModelDd::getCaption('p_status',$rs['status']);
			$rs['totalamt'] = is_null($rs['totalamt'])?0:$rs['totalamt'];
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 采购订单查询条件
	 *
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('goods_sn','keyword','starttime','totime'));
		$wheres = array();
		if($info['goods_sn']){
			$wheres[] = " m.order_id = (select p.order_id from myr_p_order_goods as p left join myr_goods as mg on p.goods_id = mg.goods_id where mg.goods_sn LIKE '%".$info['goods_sn']."%' order by mg.goods_id LIMIT 0 , 1 )";
		}
		if ($info['keyword']) {
			$wheres[] = " m.order_sn LIKE '%" . substr(mysql_like_quote($info['keyword']),strlen(CFG_P_ORDER_PREFIX)) . "%' or n.name LIKE '%" . mysql_like_quote($info['keyword']) . "%'";
		}else{
			if ($info['key']) $wheres[] = " m.order_sn LIKE '%" . substr(mysql_like_quote($info['key']),strlen(CFG_P_ORDER_PREFIX)) . "%' or n.name LIKE '%" . mysql_like_quote($info['key']) . "%'";
			if($info['operatorid']) $wheres[] = " operator_id='".$info['operatorid']."'";
			if($info['supplierid']) $wheres[] = " supplier_id='".$info['supplierid']."'";
			if($info['status'] <> 99 && $info['status'] <> "") $wheres[] = "m.status = ".$info['status'];
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'm.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'm.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'm.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		}
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
			$this->db->execute("update ".$this->tableName." set status = ".$info['status']." where order_id=".intval($info['order_id']));
			if( $info['status'] == 3) $this->db->execute("update ".$this->tableName." set arrive_time = ".CFG_TIME." where order_id=".intval($info['order_id']));
			//if( $info['status'] == 3 && CFG_GOODS_UPDATECOST == 1) $this->updategoods($info['order_id']);
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
	 	$this->db->open('select m.goods_id,m.goods_price as price1,m.arrival_qty as qty1,n.cost as price2,sum(p.goods_qty) as qty2 from '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX .'goods as n on m.goods_id = n.goods_id left join '.CFG_DB_PREFIX .'depot_stock as p on m.goods_id = p.goods_id  where m.order_id = '.intval($id).' group by goods_id');
		while ($rs = $this->db->next()) {
			$cost = $this->db->getValue("SELECT cost from ".CFG_DB_PREFIX."goods where goods_id = '".$rs['goods_id']."'");
			$oldqty = $this->db->getValue("SELECT sum(goods_qty) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = '".$rs['goods_id']."'");
			$qty = $rs['qty2']-$rs['qty1'];
			if($qty == 0) $price = $rs['price1'];
				else $price = round(($rs['qty1']*$rs['price1']+$qty*$rs['price2'])/$rs['qty2'],2);
					$this->db->execute("update " .CFG_DB_PREFIX ."goods set cost = ".$price." where goods_id = '".intval($rs['goods_id'])."'");
					$log['goods_id'] = $rs['goods_id'];
					$log['action'] = '完成采购';
					$log['field'] = 'cost';
					$log['content'] = '采购价格:'.$rs['price1'].',采购数量:'.$rs['qty1'].',当前库存:'.$qty.',当前成本:'.$rs['price2'].',平均后成本:'.$price;
					$log['admin_id'] = $_SESSION['admin_id'];
					$log['addtime'] = CFG_TIME;
					ModelGoods::goods_log($log);									
		}
	 }
	/**
	 * 获取采购订单
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
		$starttime = CFG_TIME;
		$info['paid_time'] = MyDate::transform('timestamp',$info['paid_time']);
		if($info['order_id'] ==""){
			try {
			$this->db->insert($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'comment' => $info['comment'],
						'supplier_id' => $info['supplier_id'],
						'pre_time' => MyDate::transform('timestamp',$info['pre_time']),
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
								$this->savesuppliergoods($goods,$info['supplier_id']);
								} catch (Exception $e) {
							throw new Exception('保存订单明细失败,订单号'.CFG_P_ORDER_PREFIX.$order_id,'999');exit();
						}		
			}
			return $order_id;
		}else{
			try {
			$this->db->update($this->tableName, array(
						'order_sn' => $info['order_sn'],
						'comment' => $info['comment'],
						'supplier_id' => $info['supplier_id'],
						'pre_time' => MyDate::transform('timestamp',$info['pre_time']),
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
            $this->delPlanTmp();
			return $info['order_id'];
		}
	}
	/**************
	
	*保存供应商产品
	*
	* @param object $goods  int $s_id
	
	
	
	**************/

	function savesuppliergoods($goods,$s_id)
	{
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX . "supplier_goods WHERE goods_id =".$goods->goods_id." AND supplier_id =".$s_id)>0) return;
		else{
					$this->db->insert(CFG_DB_PREFIX . "supplier_goods", array(
							'supplier_goods_sn' => $goods->goods_sn,
							'supplier_goods_name' => $goods->goods_name,
							'supplier_goods_price' => $goods->goods_price,
							'supplier_goods_remark' => '',
							'goods_id' => $goods->goods_id,
							'supplier_id' => $s_id
							));
			}
	}
    /****
    **
    ***$type 为仅导出需要采购的产品
    ****/
    function getplanList($from,$to,$export = 0,$qty = 0,$supplier=null,$sku,$sort)
    {
        
        if(!$sort){
            $sort = 'plan_qty DESC';
        }
        $result = array();
        
        
        $where  = $qty  ?   ' where plan_qty > 0'  :    '';
        
        
        if($supplier){
            $where  = $where.($where?' and ':' where ').' plan_qty >0 and supplier="'.$supplier.'"';
        }
        if($sku){
            $where  = $where.($where?' and ':' where ').' goods_sn = "'.$sku.'"';
        }
        $sort = str_replace(',','',$sort);
        $this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods '.$where.' order by '.$sort);
        if($export){
        }else{
        $this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods '.$where.' order by '.$sort,$from,$to);
        }
        while ($rs = $this->db->next()) {
            $result[] = $rs;
        }
        return $result;
    }
    
    
    
    
    
    function getplanCount()
    {
        return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX . 'plan_goods');    
    }
    
    
    
	/****
	**
	***$type 为仅导出需要采购的产品
	****/
	function getDepotplanList($from,$to,$export = 0,$qty = 0,$supplier=null,$sku,$sort)
	{
        
        if(!$sort){
            $sort = 'plan_qty DESC';
        }
		$result = array();
        
        
		$where  = $qty  ?   ' where plan_qty > 0'  :    '';
        
        
		if($supplier){
			$where  = $where.($where?' and ':' where ').' plan_qty >0 and supplier="'.$supplier.'"';
		}
		if($sku){
			$where  = $where.($where?' and ':' where ').' goods_sn = "'.$sku.'"';
		}
        $sort = str_replace(',','',$sort);
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods_depot '.$where.' order by '.$sort);
		if($export){
		}else{
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods_depot '.$where.' order by '.$sort,$from,$to);
		}
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
    
    
    
    
    
	function getDepotplanCount()
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX . 'plan_goods_depot');	
	}
    
    
    
    
    
    
	/**************
	***初始化采购计划
	**************/
	function initPlan($depot_id)
	{
		set_time_limit(0);
		$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."plan_goods");
		//抽选出属于持续采购的产品
		$where= $where1 ="";
		
        
        
        
        if($depot_id <> '999'){
			 $where =" where m.shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$depot_id.")";
			 $where1 = " AND m.depot_id = ".$depot_id;
		}
		
        $this->db->execute("insert into ".CFG_DB_PREFIX."plan_goods (goods_id,goods_sn,goods_name,SKU,goods_qty,warn_qty,varstock,depot_id)
                
                SELECT m.goods_id,n.goods_sn,n.goods_name,n.SKU,sum(m.goods_qty),sum(m.warn_qty),sum(m.varstock),'".$depot_id."' FROM ".CFG_DB_PREFIX . "depot_stock as m left join ".CFG_DB_PREFIX."goods as n on m.goods_id = n.goods_id ".$where." group by m.goods_id");
		
        $order = new ModelOrder();
			//更新订单缺货情况sold_qty
			$order_list = $this->db->select('SELECT order_id FROM '.CFG_DB_PREFIX.'order where order_status in (117,123,134)');
			for($j=0;$j<count($order_list);$j++){
				$goodlist = $order->order_goods_info($order_list[$j]);
				for($k=0;$k<count($goodlist);$k++){
					$this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set sold_qty = sold_qty + ".$goodlist[$k]['goods_qty']." where SKU = '".$goodlist[$k]['goods_sn']."'");
				}
			}
		$goods = $this->db->select("SELECT goods_id,goods_sn,SKU,goods_qty,warn_qty,varstock,Purchase_qty,sold_qty FROM ".CFG_DB_PREFIX."plan_goods");
		$CFG_SALES_CIRCLE = ModelSystem::get('CFG_SALES_CIRCLE');
		$CFG_WHOLE_SALE = ModelSystem::get('CFG_WHOLE_SALE');
		$circle = ($CFG_SALES_CIRCLE == '')?30:$CFG_SALES_CIRCLE;
		$time = CFG_TIME - $circle*24*60*60;
		$qty = ($CFG_WHOLE_SALE=='')?1000:$CFG_WHOLE_SALE;		
		for($i=0;$i<count($goods);$i++){
			//更新采购在途数量Purchase_qty
			$Purchase_qty = $this->db->getValue('SELECT sum(m.goods_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$goods[$i]['goods_id'].' and n.status in(0,1,5,6)');		
			if($Purchase_qty) $this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set Purchase_qty = ".$Purchase_qty." where goods_id = ".$goods[$i]['goods_id']);
			$num = ($goods[$i]['sold_qty']+$goods[$i]['warn_qty']+$goods[$i]['varstock']-$goods[$i]['goods_qty']-$Purchase_qty);
			if($goods[$i]['sold_qty']) $this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set plan_qty = ".$num." where goods_id = ".$goods[$i]['goods_id']);
			$this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set comment = '建议采购".$num."' where goods_id = ".$goods[$i]['goods_id']);
		/*$supplier = $this->db->getValue("SELECT p.id,p.name,p.period FROM ".CFG_DB_PREFIX."supplier as p left join ".CFG_DB_PREFIX."p_order as m on p.id = m.supplier_id left join ".CFG_DB_PREFIX."p_order_goods as n on m.order_id = n.order_id where n.goods_id = ".$goods[$i]['goods_id']);*/
		$supplier = $this->db->getValue('select s.name from myr_supplier_goods as sg left join myr_supplier as s on sg.supplier_id = s.id where sg.goods_id = '.$goods[$i]['goods_id']);
		 if($supplier){
		 $plan_qty = $num;
		 $this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set plan_qty = ".$plan_qty.",supplier = '".$supplier."' where goods_id = ".$goods[$i]['goods_id']);
		 }
		//建议采购数=销售需求+报警库存+锁定库存-采购在途-当前库存  
		/*$lasttime = $this->db->getValue("SELECT m.paid_time FROM ".CFG_DB_PREFIX."order_goods as n left join ".CFG_DB_PREFIX."order as m on n.order_id = m.order_id where m.order_status not in(120,124,127) ".$where1." and n.goods_qty <= ".$qty." and (n.goods_sn = '".$goods[$i]['SKU']."' or n.goods_sn = '".$goods[$i]['goods_sn']."' ) order by m.paid_time ASC");
		if(!$lasttime) $per_sold = 0;else{
		if($lasttime > $time) $perday = ceil((CFG_TIME - $lasttime)/(24*60*60));else $perday = $circle;
		$totalsold = $this->db->getValue("SELECT sum(n.goods_qty)  FROM ".CFG_DB_PREFIX."order_goods as n left join ".CFG_DB_PREFIX."order as m on n.order_id = m.order_id where m.paid_time > ".$time." and m.order_status not in(120,124,127)".$where1."  and n.goods_qty <= ".$qty."  and (n.goods_sn = '".$goods[$i]['SKU']."' or n.goods_sn = '".$goods[$i]['goods_sn']."')");
		$per_sold = number_format($totalsold/$perday,2,'.','');
		}
		if($per_sold > 0 ) $plan_day = floor($goods[$i]['goods_qty']/$per_sold);
		else{if(($goods[$i]['goods_qty'] - $goods[$i]['varstock'])>0) $plan_day = 8388607;
		else $plan_day = 0;
		}
		$this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set per_sold = '".$per_sold."',plan_day = '".$plan_day."' where goods_id = ".$goods[$i]['goods_id']);*/
		 /*//获取上次采购供应商
		 $supplier = $this->db->getValue("SELECT p.id,p.name,p.period FROM ".CFG_DB_PREFIX."supplier as p left join ".CFG_DB_PREFIX."p_order as m on p.id = m.supplier_id left join ".CFG_DB_PREFIX."p_order_goods as n on m.order_id = n.order_id where n.goods_id = ".$goods[$i]['goods_id']);
		 if($supplier){
		 $plan_qty = (($perday>0)?ceil($supplier['period']*$totalsold/$perday):0)+ $goods[$i]['warn_qty']+$goods[$i]['varstock']-$goods[$i]['goods_qty']-$goods[$i]['Purchase_qty'];
		 $this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set plan_qty = ".$plan_qty.",supplier = '".$supplier['name']."',period=".$supplier['period']." where goods_id = ".$goods[$i]['goods_id']);
		 }
		//获取不同供货商
		 $supplier1 = $this->db->select("SELECT p.name,p.period FROM ".CFG_DB_PREFIX."supplier as p left join ".CFG_DB_PREFIX."supplier_goods as q on p.id = q.supplier_id where q.goods_id = ".$goods[$i]['goods_id']);
		 if(!$supplier1) {
			 $this->db->execute("UPDATE ".CFG_DB_PREFIX."plan_goods set comment = '建议采购".($goods[$i]['warn_qty']+$goods[$i]['varstock']-$goods[$i]['goods_qty']-$goods[$i]['Purchase_qty'])."' where goods_id = ".$goods[$i]['goods_id']);
			 continue;
		 }
		 $content = "";
		 for($t =0;$t<count($supplier1);$t++){
		 		$plan_qty1 = ($perday>0)?ceil($supplier1['period']*$totalsold/$perday):0+ $goods[$i]['warn_qty']+$goods[$i]['varstock']-$goods[$i]['goods_qty']-$goods[$i]['Purchase_qty'];
				$content .=$supplier1['name']."*".$plan_qty1."<br>";
			 }
		//计算日均销售量per_sold 暂不计算组合产品
		 */
		/* 
		 */
		
		}
	}
	
	/*****************
	***
	***采购建议
	***
	*****************/
	function getadvicelist($from,$to,$export = 0)
	{
		$result = array();
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods order by plan_day');
		if($export){
		}else{
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'plan_goods order by plan_day',$from,$to);
		}
		while ($rs = $this->db->next()) {
			$rs['expected'] = '';
			$rs['db'] = '';
			if($rs['plan_day'] == 8388607) $rs['plan_day'] = '滞销';
			$dblist = $this->db->select("SELECT m.goods_qty,n.first_shipping,n.add_time FROM ".CFG_DB_PREFIX."allocation_detail as m left join ".CFG_DB_PREFIX."allocation as n on m.order_id =n.order_id where m.is_ok = 0 and m.goods_id = '".$rs['goods_id']."' and n.status in(3,4) and n.depot_id_to in ( select shelf_id  FROM ".CFG_DB_PREFIX."depot where depot_id = '".$rs['depot_id']."')");
			$rs['dbarr']= array();
			for($i=0;$i<count($dblist);$i++){
				if($i >0) $rs['db'] .= '<br>';
				$rs['db'] .= $dblist[$i]['goods_qty'];
				$rs['dbarr'][] =$dblist[$i]['goods_qty'];
				$rs['db'] .= '|'.ModelDd::getCaption('first_shipping',$dblist[$i]['first_shipping']);
				$rs['dbarr'][] =ModelDd::getCaption('first_shipping',$dblist[$i]['first_shipping']);
				$rs['db'] .= '|'.floor(Mydate::compare(CFG_TIME,$dblist[$i]['add_time'],'dd'));
				$rs['dbarr'][] = floor(Mydate::compare(CFG_TIME,$dblist[$i]['add_time'],'dd'));
				}
			$goods_qty = ModelGoods::getgoodsqty($rs['goods_id']);
			$rs['stock_qty'] = $goods_qty[0];
			$result[] = $rs;
		}
		return $result;
	}
	/****************
	***订单缺货产品列表
	****************/	
	function getOrderplanlist()
	{
		$result = array();
		$ids  = array();
		$goods = new ModelGoods();
		$order_list = $this->db->select('SELECT order_id FROM '.CFG_DB_PREFIX.'order where order_status in (117,123,134,135)');
		$order = new ModelOrder();
		for($j=0;$j<count($order_list);$j++) {
			$goodlist = $order->order_goods_info($order_list[$j]);
			for($i=0;$i<count($goodlist);$i++){
				$info = $this->db->getValue('SELECT goods_id,warn_qty,goods_sn,goods_name,SKU FROM '.CFG_DB_PREFIX.'goods WHERE (SKU = "'.$goodlist[$i]['goods_sn'].'" or goods_sn = "'.$goodlist[$i]['goods_sn'].'")');
				if(!$info) continue;
				if(!in_array($info['goods_id'],$ids)){
							$goodsqty = $goods->getgoodsqty($info['goods_id']);
							$rs1['goods_id'] = $info['goods_id'];
							$rs1['sold_qty'] = $goodlist[$i]['goods_qty'];
							$rs1['goods_sn'] = $info['goods_sn'];
							$rs1['goods_name'] = $info['goods_name'];
							$rs1['SKU'] = $info['SKU'];
							$rs1['goods_qty'] = $goodsqty['goods_qty'];
							$rs1['warn_qty'] = $info['warn_qty'];
							$rs1['varstock'] = $goodsqty['varstock'];
							$rs1['Purchase_qty'] = ($rs1['goods_id']=='')?0:$this->db->getValue('SELECT sum(m.goods_qty-m.arrival_qty-m.return_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$info['goods_id'].' and (n.status=0 or n.status = 2)');
							if($rs1['goods_qty']-$rs1['varstock']<$rs1['sold_qty']){
							$result[] = $rs1;
							$ids[] = $rs1['goods_id'];
							}
					}else{
						foreach($result as $k=>$v){
									if($v['goods_id'] == $info['goods_id']){
										$result[$k]['sold_qty'] += $goodlist[$i]['goods_qty'];;
										break;								
										}
								}
					}
				}
		}
		return $result;		
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
		$this->db->open("select m.rec_id,m.goods_id,m.goods_qty,m.arrival_qty,m.return_qty,m.goods_price,n.goods_sn,n.goods_img,n.goods_name,m.remark from ".$this->infotableName." as m left join ".CFG_DB_PREFIX ."goods  as n on m.goods_id = n.goods_id where m.order_id ='$id'",$from,$to);
		$result = array();
		$supplier_id = $this->db->getValue("SELECT supplier_id FROM ".$this->tableName ." where order_id = ".$id);
		while ($rs = $this->db->next()) {
			$rs['supplier_goods_sn'] = $this->db->getValue('select supplier_goods_sn from ' . CFG_DB_PREFIX . 'supplier_goods where goods_id='.$rs['goods_id'].' and supplier_id='.$supplier_id);
			$rs['url'] = '<a href="'.ModelSupplier::geturl($supplier_id,$rs['goods_id']).'" target="_blank">'/*.ModelSupplier::geturl($supplier_id,$rs['goods_id'])*/.''.ModelSupplier::geturl($supplier_id,$rs['goods_id']).'</a>';
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取采购订单产品种类数
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
	/***************
	***获取供应商ID
	
	***************/
	function getsupplierid($id)
	{
		//获取最近一次采购供应商
		//$supplier = $this->db->getValue("SELECT n.supplier_id FROM ".$this->infotableName." as m left join ".$this->tableName." as n  on m.order_id = n.order_id where m.goods_id = '".$id."' order by m.rec_id desc");
		//if(!$supplier){//取价格最低的供应商
			$supplier = $this->db->getValue("SELECT supplier_id FROM ".CFG_DB_PREFIX."supplier_goods where goods_id = '".$id."' order by supplier_goods_price,rec_id desc");
		//}
		return ($supplier)?$supplier:0;
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
	/*************
	****历史采购次数
	***  $id  产品id
	***
	*************/
	function gethistoryCount($id)
	{
		return $this->db->getValue("SELECT count(*) FROM ".$this->infotableName." where goods_id = '".$id."'");
	}
	function gethistoryList($from,$to,$id)
	{
		$this->db->open('SELECT m.rec_id,m.goods_qty,m.goods_price,m.arrival_qty,n.status,n.order_sn,p.name as supplier_id FROM '.$this->infotableName.' as m left join '.$this->tableName.' as n on m.order_id = n.order_id left join '.CFG_DB_PREFIX . 'supplier as p on n.supplier_id = p.id where m.goods_id = '.$id.' order by rec_id desc',$from,$to);
		$userlist = ModelDd::getArray("user");
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_P_ORDER_PREFIX.$rs['order_sn'];
			$rs['status'] = ModelDd::getCaption('p_status',$rs['status']);
			$result[] = $rs;
		}
		return $result;
	}
	//得到所有需要采购的供应商
	function getplanBySupplierList($from,$to){
		$supplier=array_flip(ModelDd::getArray('supplier'));
		$this->db->open('select supplier as name from '.CFG_DB_PREFIX.'plan_goods where supplier <> "" and supplier is not null and plan_qty > 0 group by supplier',$from,$to);
		while ($rs = $this->db->next()) {
			$rs['id'] = $supplier[$rs['name']];
			$result[] = $rs;
		}
		//查找手动标记缺货订单
		$this->db->open('select order_id from myr_order where order_status = 134',0,1000);
		while ($rs1 = $this->db->next()) {
			$goodslist = $this->db->select('select order_id,goods_sn from myr_order_goods where order_id = '.$rs1['order_id']);
			foreach($goodslist as $goodvalue){
				$name = $this->db->getValue('select supplier as name from myr_plan_goods where goods_sn ='."'".$goodvalue['goods_sn']."'");
				$rs['id'] = $supplier[$name];
				$rs['name'] = $name;
				$result[] = $rs;
			}
		}
		return $result;
	}
	
	function getplanBySupplierCount(){
		return $this->db->getValue('select count(*) from (select supplier as name from '.CFG_DB_PREFIX.'plan_goods where supplier<>"" and supplier is not null group by supplier) y');
	}
	
	/**
	 * 采购订单查询条件
	 *
	 * @param array $info
	 */
	function getSupplierPlanWhere($info){
		$wheres = array();
		
		$wheres[]=' supplier_id='.$info['supplier_id'].' and plan_qty>0 ';
		//if($info['older'])	$wheres[]='plan_qty>0';
		
		$where = $wheres?(' where ' . implode(' and ', $wheres)):'';
		if($info['sort']){
			$where.= ' ORDER BY '.$info['sort'].' '.($info['dir']?$info['dir']:'desc');
		}else{
			$where.= ' ORDER BY plan_qty desc';
		}
		return $where;
	}
	
	
	//查询供应商所有产品的采购计划信息列表
	function getSupplierPlanList($from,$to,$where=null){
		if($from && $to){
			$this->db->open('select * from '.CFG_DB_PREFIX.'plan_goods_tmp '.$where,$from,$to);
		}else{
			$this->db->open('select * from '.CFG_DB_PREFIX.'plan_goods_tmp '.$where);
		}
		while ($rs = $this->db->next()) {
			$goods=$this->db->getValue('select goods_sn,goods_name,SKU,goods_img from '.CFG_DB_PREFIX.'goods where  goods_id='.$rs['goods_id']);
			$rs['goods_name']=$goods['goods_name'];
			$rs['goods_sn']=$goods['goods_sn'];
			$rs['SKU']=$goods['SKU'];
			$rs['goods_img']=$goods['goods_img'];
			$result[]=$rs;
		}
		return $result;
	}
	
	function getSupplierPlanCount($where){
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'plan_goods_tmp '.$where);
	}
	//初始化临时表数据
	function initPlanTmp($supplier_id){
		
		//新增供应商所有产品的采购计划
		$this->db->execute('insert into '.CFG_DB_PREFIX.'plan_goods_tmp (supplier_id,goods_id,supplier_goods_price,goods_qty,warn_qty,varstock,Purchase_qty,sold_qty,per_sold,period,plan_qty,comment,plan_day,depot_id) select s.supplier_id,s.goods_id,s.supplier_goods_price,p.goods_qty,p.warn_qty,p.varstock,p.Purchase_qty,p.sold_qty,p.per_sold,p.period,p.plan_qty,p.comment,p.plan_day,p.depot_id from '.CFG_DB_PREFIX.'supplier_goods s LEFT JOIN '.CFG_DB_PREFIX.'plan_goods p on s.goods_id =p.goods_id where s.supplier_id='.$supplier_id.' and p.plan_qty > 0 ORDER BY p.plan_qty desc');
		
		
		$this->db->open('select order_id from myr_order where order_status = 134',0,1000);
		while ($rs1 = $this->db->next()) {
			$goodslist = $this->db->select('select og.goods_qty,og.order_id,og.goods_sn,pg.goods_id from myr_order_goods as og left join myr_plan_goods as pg on og.goods_sn = pg.goods_sn left join myr_supplier_goods as s on pg.goods_id = s.goods_id where og.order_id = '.$rs1['order_id'].' and s.supplier_id = '.$supplier_id);	
			foreach($goodslist as $goodvalue){
				$goods_id = $this->db->getValue('select goods_id from myr_goods where goods_sn = '."'".$goodvalue['goods_sn']."'");
				$goodinfo = $this->db->getValue('select pg.*,sg.supplier_goods_price from myr_plan_goods as pg left join myr_supplier_goods as sg on pg.goods_id=sg.goods_id where pg.goods_id='.$goods_id);
				if($this->db->getValue('select goods_id from myr_plan_goods_tmp where goods_id='.$goods_id)){
					$this->db->execute('delete from '.CFG_DB_PREFIX.'plan_goods_tmp where goods_id ='.$goods_id );
				}
				$this->db->execute('insert into '.CFG_DB_PREFIX.'plan_goods_tmp (supplier_id,goods_id,supplier_goods_price,goods_qty,warn_qty,varstock,Purchase_qty,sold_qty,per_sold,period,plan_qty,comment,plan_day,depot_id,is_no_auto) VALUES ('.$supplier_id.','.$goods_id.','.$goodinfo['supplier_goods_price'].','.$goodinfo['goods_qty'].','.$goodinfo['warn_qty'].','.$goodinfo['varstock'].','.$goodinfo['Purchase_qty'].','.$goodinfo['sold_qty'].','.$goodinfo['per_sold'].','.$goodinfo['period'].','.$goodvalue['goods_qty'].',"采购建议'.$goodvalue['goods_qty'].'",'.$goodinfo['plan_day'].','.$goodinfo['depot_id'].',1)');
			}
		}
		$this->db->execute('update '.CFG_DB_PREFIX.'plan_goods_tmp as t left join '.CFG_DB_PREFIX.'goods as g on t.goods_id=g.goods_id set t.goods_name=g.goods_name,t.goods_sn=g.goods_sn,t.SKU=g.SKU,t.goods_img=g.goods_img');
		$supplier_goods = $this->db->select('select * from '.CFG_DB_PREFIX.'plan_goods_tmp');
		foreach($supplier_goods as $value){
			$plan_qty = $this->db->getValue('select plan_qty from myr_plan_goods where goods_id = '.$value['goods_id']);
			$isauto = $this->db->getValue('select is_no_auto from myr_plan_goods_tmp where goods_id ='.$value['goods_id']);
			if(!$isauto==1){
				$this->db->update(CFG_DB_PREFIX.'plan_goods_tmp',array('plan_qty' => $plan_qty),'goods_id = '.$value['goods_id']);
			}
		}
	}
	//保存修改 但是要注意的是一个产品被修改保存了两次 第二次需要把第一次的数据在临时表中更新掉
	function updatePlanTmp($info){
		$this->db->update(CFG_DB_PREFIX .'plan_goods_tmp',array(
			'plan_qty' => $info->plan_qty
			),'goods_id='.$info->goods_id);
	}
	
	//清空临时表
	function delPlanTmp(){
		$this->db->execute('delete from '.CFG_DB_PREFIX .'plan_goods_tmp');
	}
    
    
    
    function DepotPlanByAll(){
        
        
        
        $depotPurchaseList = $this->db->select("select goods_plan_id,goods_id,goods_sn,goods_name,goods_qty,plan_qty,depot_id from myr_plan_goods_depot");
        
        if(count($depotPurchaseList)){
            
            $starttime = CFG_TIME;
            
            $info = array();
            $info['order_sn'] = $this->get_order_sn();
           
            $info['pre_time'] = date('Y-m-d H:i:s');
            $info['status'] = 0;
            $info['operator_id'] = $_SESSION['admin_id'];
            $info['paid_time'] = MyDate::transform('timestamp',$info['paid_time']);      
            
            try {
                $this->db->insert($this->tableName, array(
                    'order_sn' => $info['order_sn'],
                    'comment' => $info['comment'],
                    'supplier_id' => 0,
                    'pre_time' => MyDate::transform('timestamp',$info['pre_time']),
                    'add_time' => CFG_TIME,
                    'operator_id' => $info['operator_id'],
                    'add_user' => $_SESSION['admin_id'],
                    'status' => $info['status']
                    ));
                $order_id = $this->db->getInsertId();
            } catch (Exception $e) {
                throw new Exception('保存采购订单失败,订单号为'.CFG_P_ORDER_PREFIX.$info['order_sn'],'999');exit();
            }
            
            for($i=0;$i<count($depotPurchaseList);$i++){
                try{
                    $this->db->insert($this->infotableName, array(
                        'order_id' => $order_id,
                        'goods_id' => $depotPurchaseList[$i]['goods_id'],
                        'goods_qty' => $depotPurchaseList[$i]['plan_qty'],
                        'goods_price' => 0,
                        'remark' => ''
                    ));
                    $this->db->execute("DELETE FROM myr_plan_goods_depot WHERE goods_plan_id =".intval($depotPurchaseList[$i]['goods_plan_id']));
                    
                                                                         
                } catch (Exception $e) {
                    throw new Exception('保存订单明细失败,订单号'.CFG_P_ORDER_PREFIX.$order_id,'999');exit();
                }                
                
                
            }   
        }               
    }
    
    
    
    
    
    
}
?>