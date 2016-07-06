<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2010 - 2015  |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// |                       |
// +--------------------------------------------------------------+

/*
 * 库存管理类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelInventory extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'goods';
		$this->primaryKey = 'goods_id';
	}
	

	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhere($info) {
		specConvert($info,array('keyword'));
		$wheres = array();
		if ($info['keyword']) $wheres[] = '(m.goods_sn like \'%'.$info['keyword'].'%\' or m.SKU like \'%'.$info['keyword'].'%\'  or m.goods_name like \'%'.$info['keyword'].'%\')';
		if ($info['depot'] <>'' ) $wheres[] = "n.shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = '".$info['depot']."')";
		if($info['status_id'] <>'' && $info['status_id'] <>0 ) $wheres[] = 'm.status='.$info['status_id'];
		if($info['cat_id'] <>'' && $info['cat_id'] <>0 ) $wheres[] = 'm.cat_id='.$info['cat_id'];
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	*获取产品列表
	*
	*
	**/
	function getGoodsList($from,$to,$where=null,$export = 0,$sort=null,$depot=0,$is_warn=0){
		if($is_warn == 1) $having = " having goods_qty <= warn_qty";else $having ='';
		if($export==1){
		$this->db->open('select m.goods_id,m.goods_sn,m.goods_name,m.SKU,sum(n.goods_qty) as goods_qty,sum(n.varstock) as varstock,sum(n.warn_qty) as warn_qty from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as n on m.goods_id = n.goods_id'.$where.' group by m.goods_id'.$having.' order by '.$sort.' m.'.$this->primaryKey.' desc');
			}else{
		$this->db->open('select m.goods_id,m.goods_sn,m.goods_name,m.SKU,sum(n.goods_qty) as goods_qty,sum(n.varstock) as varstock,sum(n.warn_qty) as warn_qty from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as n on m.goods_id = n.goods_id'.$where.' group by m.goods_id'.$having.' order by '.$sort.' m.'.$this->primaryKey.' desc',$from,$to);
			}
		$result = array();
		$depotlist = ModelDd::getArray('shelf');
		if($depot == '') $depot = 0;
		while ($rs = $this->db->next()) {
			$rs['Purchase_qty'] = $this->db->getValue('SELECT sum(m.goods_qty-m.arrival_qty-m.return_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$rs['goods_id'].' and m.goods_qty >= (m.arrival_qty+m.return_qty) and n.status in (0,1,2)');
			$rs['db_qty'] = $this->db->getValue("SELECT sum(m.goods_qty) FROM ".CFG_DB_PREFIX."allocation_detail as m left join ".CFG_DB_PREFIX."allocation as n on m.order_id = n.order_id where m.goods_id = ".$rs['goods_id']." AND n.status = 3 AND n.depot_id_to in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = '".$depot."')");
			$rs['db_pre_qty'] = $this->db->getValue("SELECT sum(m.goods_qty) FROM ".CFG_DB_PREFIX."allocation_detail as m left join ".CFG_DB_PREFIX."allocation as n on m.order_id = n.order_id where m.goods_id = ".$rs['goods_id']." AND n.status = 0 AND n.depot_id_from in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = '".$depot."')");
			$depot_stock = $this->db->select("SELECT shelf_id,goods_qty FROM ".CFG_DB_PREFIX ."depot_stock WHERE goods_id = ".$rs['goods_id']);
			$rs['depot_qty'] = '';
			for($i=0;$i<count($depot_stock);$i++){
				$rs['depot'][$depot_stock[$i]['shelf_id']] = $depot_stock[$i]['goods_qty'];
				$rs['depot_qty'] .= $depotlist[$depot_stock[$i]['shelf_id']].' & '.$depot_stock[$i]['goods_qty'].(($export==1)?' #':'<br>');
			}
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getGoodsCount($where=null,$is_warn=0) {
		if($is_warn == 1) $having = " having goods_qty <= warn_qty";else $having ='';
		return $this->db->getValue('select count(*) from (select sum(n.goods_qty) as goods_qty,sum(n.varstock) as varstock,sum(n.warn_qty) as warn_qty from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as n on m.goods_id = n.goods_id'.$where.' group by m.goods_id'.$having.') as p');
	}
	function savecheckorder($info)
	{
		if($info['checktypeid'] == 1){
			$where = ' where (m.sku="'.$info['sku'].'" or m.goods_sn = "'.$info['sku'].'")';
			}elseif($info['checktypeid'] == 2){
			$where = ' where m.cat_id = '.$info['cat_id'];
			}else{
				$where = ' where m.cat_id != 99';
			}
			$where .= " and (m.status in(".CFG_GOODS_STATUS.") or n.goods_qty > 0)";
		$this->db->insert(CFG_DB_PREFIX.'inventory',array(
							'order_sn' => $this->get_order_sn(),
							'admin_id' => $_SESSION['admin_id'],
							'depot_id' => $info['depot_id'],
							'add_time' => CFG_TIME
							));
		$order_id = $this->db->getInsertId();
			$query = "SELECT ".$order_id.",m.goods_id,n.goods_qty FROM ".$this->tableName." as m right join ".CFG_DB_PREFIX."depot_stock as n on m.goods_id = n.goods_id " .$where." AND n.shelf_id =".$info['depot_id'];
		if(!$this->db->execute("insert into ".CFG_DB_PREFIX."inventory_detail(order_id,goods_id,stock_qty) (".$query.")")){
			$this->db->execute("DELECT FROM ".CFG_DB_PREFIX."inventory WHERE order_id=".$order_id);
			$this->db->execute("DELECT FROM ".CFG_DB_PREFIX."inventory_detail WHERE order_id=".$order_id);
			}
	}
	
	function getcheckList($from,$to)
	{
		$this->db->open('select * from '.CFG_DB_PREFIX.'inventory order by add_time desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_CHECK_ORDER_PREFIX.$rs['order_sn'];
			$user = ModelDd::getArray('user');
			$status = ModelDd::getArray('o_status');
			$rs['admin_id'] = $user[$rs['admin_id']];
			$rs['status'] = $status[$rs['status']];
			$rs['depot_id'] = ModelDd::getCaption('shelf',$rs['depot_id']);
			$rs['is_in'] = ($rs['is_in']>0)?'<font color="#FF0000">是</font>':'否';
			$rs['is_out'] = ($rs['is_out']>0)?'<font color="#FF0000">是</font>':'否';
			$rs['has_un'] = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."inventory_detail where is_ok = 0 and order_id=".$rs['order_id']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['end_time'] = MyDate::transform('date',$rs['end_time']);
			$result[] = $rs;
		}
		return $result;
	}
	function getcheckCount() {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'inventory');
	}
	
	function getcheckdetailList($from,$to,$where=null,$export=0)
	{	
		if($export == 0){
		$this->db->open('select m.rec_id,m.stock_qty,m.check_qty,m.is_ok,n.goods_sn,n.goods_name,n.SKU from '.CFG_DB_PREFIX.'inventory_detail as m left join '.$this->tableName.' as n on m.goods_id = n.goods_id '.$where,$from,$to);
		}else{
		$this->db->open('select m.rec_id,m.stock_qty,m.check_qty,m.is_ok,n.goods_sn,n.goods_name,n.SKU from '.CFG_DB_PREFIX.'inventory_detail as m left join '.$this->tableName.' as n on m.goods_id = n.goods_id '.$where);
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['is_ok'] = ($rs['is_ok']>0)?'是':'否';
			if($export == 0 && $rs['is_ok']== '是') $rs['is_ok'] = '<font color=red>'.$rs['is_ok'].'</font>';
			$result[] = $rs;
		}
		return $result;
	}
	function getcheckdetailCount($where) {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'inventory_detail as m left join '.$this->tableName.' as n on m.goods_id = n.goods_id '.$where);
	}
	function getcheckdetailWhere($info)
	{
		specConvert($info,array('order_id','sku'));
		$wheres = array();
		if ($info['order_id']) {
			$wheres[] = 'order_id=\''.$info['order_id'].'\'';
		}
		if($info['sku']){
			$wheres[] = 'n.SKU = \''.$info['sku'].'\'';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
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
	/*****
	处理盘点操作数据
	*****/
	function savecheck($info)
	{
		//$info['sku'] = transSKU($info['sku']);
		$this->db->update(CFG_DB_PREFIX.'inventory_detail',array(
				'is_ok' => 1,
				'check_qty' => $info['qty']
			),"order_id = ".$info['order_id']." and goods_id =".$this->db->getValue("SELECT goods_id FROM ".$this->tableName." WHERE SKU='".$info['sku']."' or goods_sn ='".$info['sku']."'"));
	}
	
	function comcheck($info)
	{
		$this->db->execute("UPDATE ".CFG_DB_PREFIX."inventory set status = 1 where order_id=".$info['id']);
	}
	
	function finishcheck($info)
	{
		echo '开始盘点库存出入库开单<br>....<br>....<br>....<br>';
		$inventry = $this->db->getValue("SELECT order_sn,depot_id FROM ".CFG_DB_PREFIX."inventory WHERE order_id=".$info['id']);
		if($info['type'] == 1){//开始盘盈入库
			$stockin = new ModelStockin();
			$order_sn = $stockin->get_order_sn();
				 $this->db->insert(CFG_DB_PREFIX . 'stockin', array(
						'order_sn' => $order_sn,
						'add_time' => CFG_TIME,
						'operator_id' => $_SESSION['admin_id'],
						'stockin_type' => 3,
						'depot_id' => $inventry['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => 0
						));
					$order_id = $this->db->getInsertId();
					if($inventry['depot_id'] == 0){
					$query = 'SELECT m.rec_id,m.check_qty,m.stock_qty,m.goods_id,n.SKU,n.cost,n.goods_qty FROM '.CFG_DB_PREFIX.'inventory_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id WHERE m.check_qty>m.stock_qty and m.is_ok = 1 and m.order_id ='.$info['id'];
					}else{
					$query = 'SELECT m.rec_id,m.check_qty,m.stock_qty,m.goods_id,n.SKU,n.cost,t.goods_qty FROM '.CFG_DB_PREFIX.'inventory_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id left join '.CFG_DB_PREFIX.'depot_stock as t on m.goods_id = t.goods_id WHERE m.check_qty>m.stock_qty and m.is_ok = 1 and t.shelf_id = '.$inventry['depot_id'].' and m.order_id ='.$info['id'];
					}
					$this->db->open($query);
					while ($rs = $this->db->next()) {
							$restock =$rs['check_qty']- $rs['stock_qty'];
							echo $rs['SKU'].'  账面库存'.$rs['stock_qty'].'盘点库存'.$rs['check_qty'].',盈余库存'.$restock.'添加到'.CFG_IN_ORDER_PREFIX.$order_sn;
							if($this->db->insert(CFG_DB_PREFIX.'stockin_detail', array(
								'order_id' => $order_id,
								'goods_id' => $rs['goods_id'],
								'goods_qty' => $restock,
								'goods_price' => $rs['cost'],
								'relate_order_sn' => CFG_CHECK_ORDER_PREFIX.$checksn,
								'remark' => '当前库存'.$rs['goods_qty'].'账面库存'.$rs['stock_qty'].'盘点库存'.$rs['check_qty']
								))){
									echo '成功<br>';
									$this->db->execute("update ".CFG_DB_PREFIX."inventory_detail set is_ok =2 where rec_id=".$rs['rec_id']);
								}else{
									echo '<font color="#FF0000">失败</font><br>';
									}
					}
					echo '盘盈入库结束';
			}else{//开始盘亏出库
			$stockout = new ModelStockout();	
			$order_sn = $stockout->get_order_sn();	
				 $this->db->insert(CFG_DB_PREFIX . 'stockout', array(
						'order_sn' => $order_sn,
						'add_time' => CFG_TIME,
						'operator_id' => $_SESSION['admin_id'],
						'stockout_type' => 2,
						'depot_id' => $inventry['depot_id'],
						'add_user' => $_SESSION['admin_id'],
						'status' => 0
						));
					$order_id = $this->db->getInsertId();
					if($inventry['depot_id'] == 0){
					$query = 'SELECT m.rec_id,m.check_qty,m.stock_qty,m.goods_id,n.SKU,n.cost,n.goods_qty FROM '.CFG_DB_PREFIX.'inventory_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id WHERE m.stock_qty>m.check_qty and m.is_ok = 1 and m.order_id ='.$info['id'];
					}else{
					$query = 'SELECT m.rec_id,m.check_qty,m.stock_qty,m.goods_id,n.SKU,n.cost,t.goods_qty FROM '.CFG_DB_PREFIX.'inventory_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id left join '.CFG_DB_PREFIX.'depot_stock as t on m.goods_id = t.goods_id WHERE m.stock_qty>m.check_qty and m.is_ok = 1 and t.shelf_id = '.$inventry['depot_id'].' and m.order_id ='.$info['id'];
					}
					$this->db->open($query);
					while ($rs = $this->db->next()) {
							$restock = $rs['stock_qty']-$rs['check_qty'];
							echo $rs['SKU'].'  账面库存'.$rs['stock_qty'].'盘点库存'.$rs['check_qty'].',亏损库存'.$restock.'添加到'.CFG_OUT_ORDER_PREFIX.$order_sn;
							if($this->db->insert(CFG_DB_PREFIX.'stockout_detail', array(
								'order_id' => $order_id,
								'goods_id' => $rs['goods_id'],
								'goods_qty' => $restock,
								'goods_price' => $rs['cost'],
								'relate_order_sn' => CFG_CHECK_ORDER_PREFIX.$checksn,
								'remark' => '当前库存'.$rs['goods_qty'].'账面库存'.$rs['stock_qty'].'盘点库存'.$rs['check_qty']
								))){
									echo '成功<br>';
									$this->db->execute("update ".CFG_DB_PREFIX."inventory_detail set is_ok =2 where rec_id=".$rs['rec_id']);
								}else{
									echo '<font color="#FF0000">失败</font><br>';
									}
					}
					echo '盘亏出库结束';
		}
		
	}
	
	/**********************
	********库存调换
	*****param object $info
	*****string
	**********************/
	function savestockchange($info)
	{
		$str = '开始调整开单<br>....<br>....<br>....<br>';
			$stockin = new ModelStockin();
			$goods = new ModelGoods();
			$order_sn = $stockin->get_order_sn();
				 $this->db->insert(CFG_DB_PREFIX . 'stockin', array(
						'order_sn' => $order_sn,
						'add_time' => CFG_TIME,
						'operator_id' => $_SESSION['admin_id'],
						'stockin_type' => 4,
						'add_user' => $_SESSION['admin_id'],
						'status' => 0
						));
					$order_id = $this->db->getInsertId();
			$str .= '入库开单成功,单号'.CFG_IN_ORDER_PREFIX.$order_sn.'<br>....<br>....<br>....<br>';
			$stockout = new ModelStockout();	
			$order_sn = $stockout->get_order_sn();	
				 $this->db->insert(CFG_DB_PREFIX . 'stockout', array(
						'order_sn' => $order_sn,
						'add_time' => CFG_TIME,
						'operator_id' => $_SESSION['admin_id'],
						'stockout_type' => 4,
						'add_user' => $_SESSION['admin_id'],
						'status' => 0
						));
					$order_id1 = $this->db->getInsertId();
			$str .= '出库开单成功,单号'.CFG_OUT_ORDER_PREFIX.$order_sn.'<br>....<br>....<br>....<br>';		
			foreach($info['data'] as $good){
				$goodsinfo  = $goods->goods_info('',$good->sku1);
				$goodsinfo1  = $goods->goods_info('',$good->sku2);
					try{
					$this->db->insert(CFG_DB_PREFIX.'stockin_detail', array(
								'order_id' => $order_id,
								'goods_id' => $goodsinfo['goods_id'],
								'goods_qty' => $good->goods_qty,
								'goods_price' => $goodsinfo['cost'],
								'remark' => '产品调换'.$good->sku1.'调换为'.$good->sku2.'调换库存'.$good->goods_qty
								));
					$this->db->insert(CFG_DB_PREFIX.'stockout_detail', array(
								'order_id' => $order_id1,
								'goods_id' => $goodsinfo1['goods_id'],
								'goods_qty' => $good->goods_qty,
								'goods_price' => $goodsinfo1['cost'],
								'remark' =>'产品调换'.$good->sku1.'调换为'.$good->sku2.'调换库存'.$good->goods_qty
								));
					$str .= $good->sku1.'出入库单明细表添加成功<br>';
				} catch (Exception $e) {
					$str .= '<font color="#FF0000">'.$good->sku1.'出入库单明细表添加失败</font><br>';
				}
			}
			$str .= '......<br>......<br>......<br>库存调换完成';
			return $str;
	}

	/******************
	*
	* 仓库货架数量
	*
	******************/
	function getshelfCount()
	{
		return 	$this->db->getValue("SELECT count(*) from ".CFG_DB_PREFIX."depot");
	}
	
	function getshelfList($from,$to,$where=null)
	{
		$depot = ModelDd::getArray('depot');
		$this->db->open('select * from '.CFG_DB_PREFIX .'depot',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['depot'] =$depot[$rs['depot_id']];
			$rs['is_main'] = ($rs['is_main'] == 1)?'是':'否';
			$result[] = $rs;
		}
		return $result;
	}
	function shelfsave($info)
	{
		if ($info['shelf_id']=="") {
			$this->db->insert(CFG_DB_PREFIX.'depot',array(
				'name' => $info['name'],
				'depot_id' => $info['depot_id']
				));
			$have_shelf = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot where is_main = 1 and depot_id =".$info['depot_id']);
			$id = $this->db->getInsertId();
		} else {
			$this->db->update(CFG_DB_PREFIX.'depot',array(
				'name' => $info['name'],
				'depot_id' => $info['depot_id']
				),'shelf_id='.intval($info['shelf_id']));
			$have_shelf = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot where is_main = 1 and shelf_id <> ".intval($info['shelf_id'])." and depot_id =".$info['depot_id']);
			$id = $info['shelf_id'];
		}
		$is_main = $have_shelf?0:1;
		$this->db->execute("update ".CFG_DB_PREFIX."depot set is_main =".$is_main." where shelf_id =".$id);
		$this->cacheShelf();
	}
	function shelfdel($ids)
	{
		$idarray = explode(",",$ids);
		for($i=0;$i<count($idarray);$i++){
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot where shelf_id = ".$idarray[$i]." and is_main = 1")>0){
			throw new Exception('不能删除作为发货的货架','999');
			continue;
			}
		$this->db->execute('delete from '.CFG_DB_PREFIX."depot where shelf_id = ".$idarray[$i]);
		}
		$this->cacheShelf();
	}
	function cacheShelf()
	{
		$depot = ModelDd::getArray('depot');
		$arr = $this->db->select('select shelf_id,name,depot_id FROM '.CFG_DB_PREFIX.'depot order by depot_id');
		for($i=0;$i<count($arr);$i++){
			$shelf[$arr[$i]['shelf_id']] = $depot[$arr[$i]['depot_id']].'|'.$arr[$i]['name'];
			}
		$fp = fopen(CFG_PATH_DATA . 'dd/shelf.php', 'w');
		fputs($fp, '<?php return '.var_export($shelf, true) . '; ?>');
		fclose($fp);
	}
	
	/***************
	****保存调拨单列表
	
	***************/
	function saveallocation($info)
	{
		if(substr($info['order_sn'],0,strlen(CFG_DB_ORDER_PREFIX)) == CFG_DB_ORDER_PREFIX) $info['order_sn'] = substr($info['order_sn'],strlen(CFG_DB_ORDER_PREFIX));
		if($info['order_id'] ==""){
			try {
				 $this->db->insert(CFG_DB_PREFIX .'allocation', array(
						'order_sn' => $info['order_sn'],
						'add_time' => CFG_TIME,
						'operator_id' => $info['operator_id'],
						'depot_id_to' => $info['depot_id_to'],
						'depot_id_from' => $info['depot_id_from'],
						'count' => $info['count'],
						'weight' => $info['weight'],
						'first_shipping' => $info['first_shipping'],
						'db_shipping' => $info['db_shipping'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'track_no' => $info['track_no'],
						'comment' => $info['comment']
						));
					$order_id = $this->db->getInsertId();
						} catch (Exception $e) {
					throw new Exception('保存调拨单失败,订单号为'.CFG_DB_ORDER_PREFIX.$info['order_sn'],'999');exit();
				}
			foreach($info['data'] as $goods){
					try{
					$this->db->insert(CFG_DB_PREFIX.'allocation_detail', array(
								'order_id' => $order_id,
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'no' => $goods->no
								));
								} catch (Exception $e) {
							throw new Exception('保存调拨明细失败,订单号'.CFG_DB_ORDER_PREFIX.$info['order_sn'],'999');exit();
						}		
			}
			return $order_id;
		}else{
			try {
			$this->db->update(CFG_DB_PREFIX .'allocation', array(
						'order_sn' => $info['order_sn'],
						'operator_id' => $info['operator_id'],
						'depot_id_to' => $info['depot_id_to'],
						'depot_id_from' => $info['depot_id_from'],
						'count' => $info['count'],
						'weight' => $info['weight'],
						'first_shipping' => $info['first_shipping'],
						'db_shipping' => $info['db_shipping'],
						'add_user' => $_SESSION['admin_id'],
						'status' => $info['status'],
						'track_no' => $info['track_no'],
						'comment' => $info['comment']
						),'order_id='.intval($info['order_id']));
						} catch (Exception $e) {
					throw new Exception('保存调拨单失败,订单号为'.$info['order_sn'],'999');exit();
				}
			foreach($info['data'] as $goods){
				if($goods->rec_id == 0){
					try{
					$this->db->insert(CFG_DB_PREFIX.'allocation_detail', array(
								'order_id' => $info['order_id'],
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'no' => $goods->no
								));
								} catch (Exception $e) {
							throw new Exception('保存调拨明细失败,订单号'.$info['order_sn'],'999');exit();
						}
				}else{
					try{
					$this->db->update(CFG_DB_PREFIX.'allocation_detail', array(
								'goods_id' => $goods->goods_id,
								'goods_qty' => $goods->goods_qty,
								'no' => $goods->no
								),'rec_id='.intval($goods->rec_id));
								} catch (Exception $e) {
							throw new Exception('保存调拨明细失败,订单号'.$info['order_sn'],'999');exit();
						}				
				}		
			}
			return $info['order_id'];
		}		
	}
	/***************
	****生成调拨单查询条件
	
	***************/
	function getallocationWhere($info)
	{
		specConvert($info,array('keyword','starttime','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = " m.order_sn = '" . substr(mysql_like_quote($info['keyword']),strlen(CFG_OUT_ORDER_PREFIX)) . "' or m.comment like '%".$info['keyword']."%' or n.goods_sn= '".$info['keyword']."' or n.goods_name = '".$info['keyword']."'";
		}else{
			if ($info['key']) $wheres[] = " m.order_sn = '" . substr(mysql_like_quote($info['key']),strlen(CFG_OUT_ORDER_PREFIX)) . "' or m.comment like '%".$info['key']."%' or n.goods_sn= '".$info['key']."' or n.goods_name = '".$info['key']."'";
			if($info['db_status'] <> 99 && $info['db_status'] <> '') $wheres[] = " m.status = ".$info['db_status'];
			if($info['first_shipping'] <> 99 && $info['first_shipping'] <> '') $wheres[] = " m.first_shipping = ".$info['first_shipping'];
			if($info['db_shipping'] <> 99 && $info['db_shipping'] <> '') $wheres[] = " m.db_shipping = ".$info['db_status'];
			if($info['depot_id_from'] <> 99 && $info['depot_id_from'] <> '') $wheres[] = " m.depot_id_from = ".$info['depot_id_from'];
			if($info['depot_id_to'] <> 99 && $info['depot_id_to'] <> '') $wheres[] = " m.depot_id_to = ".$info['depot_id_to'];
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
	/***************
	****生成调拨单列表
	
	***************/
	function getallocationList($from,$to,$where=null,$export=0)
	{	
		if($export == 0){
		$this->db->open('select m.order_id,m.order_sn,m.comment,m.count,m.track_no,m.db_shipping,m.first_shipping,m.weight,m.out_time,m.add_time,m.status,m.depot_id_from,m.depot_id_to,m.operator_id from '.CFG_DB_PREFIX .'allocation as m left join '.CFG_DB_PREFIX.'allocation_detail  as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.order_id desc',$from,$to);
		}else{
		$this->db->open('select m.order_id,m.order_sn,m.comment,m.count,m.track_no,m.db_shipping,m.first_shipping,m.weight,m.out_time,m.add_time,m.status,m.depot_id_from,m.depot_id_to,m.operator_id from '.CFG_DB_PREFIX .'allocation as m left join '.CFG_DB_PREFIX.'allocation_detail  as q on m.order_id = q.order_id left join '.CFG_DB_PREFIX .'goods  as n on q.goods_id = n.goods_id  ' .$where. ' group by order_id order by m.order_id desc');
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'];
			$rs['out_time'] = MyDate::transform('date',$rs['out_time']);
			$rs['totalamt'] = $this->db->getValue('select sum(goods_qty) from '.CFG_DB_PREFIX.'allocation_detail where order_id = '.$rs['order_id']);
			$rs['realstatus'] = $rs['status'];
			$rs['first_shipping'] = ModelDd::getCaption('first_shipping',$rs['first_shipping']);
			$rs['db_shipping'] = ModelDd::getCaption('db_shipping',$rs['db_shipping']);
			if($rs['status'] <> 1) $rs['delay_time'] = floor(Mydate::compare(CFG_TIME,$rs['add_time'],'dd'));
			$rs['status'] = ModelDd::getCaption('db_status',$rs['status']);
			$rs['add_user'] = ModelDd::getCaption('user',$rs['operator_id']);
			$rs['depot_id_from'] = ModelDd::getCaption('shelf',$rs['depot_id_from']);
			$rs['depot_id_to'] = ModelDd::getCaption('shelf',$rs['depot_id_to']);
			$rs['totalamt'] = is_null($rs['totalamt'])?0:$rs['totalamt'];
			$result[] = $rs;
		}
		return $result;
	}
	function getallocationCount($where)
	{
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'allocation');
	}
	function allocation_order_info($id)
	{
		return $this->db->getValue('select m.add_time,m.out_time,m.depot_id_from,m.count,m.track_no,m.weight,m.db_shipping,m.first_shipping,m.depot_id_to,m.operator_id,m.order_id,m.order_sn,m.comment,m.status,sum(p.goods_qty) as total_qty from '.CFG_DB_PREFIX.'allocation as m left join '.CFG_DB_PREFIX.'allocation_detail as p on m.order_id = p.order_id where m.order_id = '.$id);
	}

	/**
	 * 获取调拨单产品种类数
	 *
	 * @param int $id 订单ID
	 */
	function getallocationgoodsCount($id)
	{
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'allocation_detail where order_id='.$id);
	}
	
	/**
	 * 调拨单明细
	 *
	 * @param int $id 订单ID
	 */
	function allocation_goods_info($from,$to,$id)
	{
		$this->db->open("select m.rec_id,m.goods_id,m.goods_qty,m.no,m.is_ok, n.goods_sn,n.goods_name from ".CFG_DB_PREFIX."allocation_detail as m left join ".CFG_DB_PREFIX ."goods  as n on m.goods_id = n.goods_id where m.order_id =" .$id,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	function delallocationgoods($id)
	{
		try{
				$this->db->execute('delete from '.CFG_DB_PREFIX."allocation_detail"
								.' where rec_id = '.$id);
			} catch (Exception $e) {
					throw new Exception('删除调拨单产品失败');
			}
	}
	/**
	 * 更新调拨单状态
	 *
	 * @param array $info
	 */
	function updateallocation($info)
	{
		try{
			if($info['status'] == 2){//删除调拨单
				$this->db->execute('delete from '.CFG_DB_PREFIX.'allocation where order_id='.intval($info['order_id']));
				$this->db->execute('delete from '.CFG_DB_PREFIX.'allocation_detail where order_id='.intval($info['order_id']));
			}elseif($info['status'] == 5){//强制完成
				$this->db->execute("update ".CFG_DB_PREFIX.'allocation_detail set is_ok = 2 where is_ok=0 AND order_id='.intval($info['order_id']));
				$this->db->execute("update ".CFG_DB_PREFIX.'allocation set status = 1 where  order_id='.intval($info['order_id']));
			}else{
				$msg = '';
				$msg = $this->updategoods($info['order_id'],$info['status']);
				if($msg == ''){
					$this->db->update(CFG_DB_PREFIX.'allocation',array(
						'status' => $info['status'],
						'out_time' => CFG_TIME
						),'order_id='.intval($info['order_id']));
					savelog($info['order_id'],'allocation','调拨单状态被更改',$_SESSION['admin_id']);
					}else{
						throw new Exception($msg);	
					}
			}
		} catch (Exception $e) {
			throw new Exception('更新调拨单状态失败<br>'.$msg);
		}
	}
	/******
	*调拨部分到货
	*****/
	function updateallocationgoods($ids)
	{
		//选取产品
		$depotlist = ModelDd::getArray('shelf');
		$this->db->open("SELECT m.rec_id,m.order_id,m.goods_id,m.goods_qty,p.depot_id_to,p.depot_id_to,p.order_sn,p.status FROM ".CFG_DB_PREFIX."allocation_detail as m left join ".CFG_DB_PREFIX."allocation as p on m.order_id = p.order_id  where m.rec_id in (".$ids.") AND m.is_ok = 0");
		while ($rs = $this->db->next()) {
			if( $rs['status'] != 3 && $rs['status'] != 4) return "此操作需要调拨在途后操作".$rs['status'];
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to'])>0){//分库已存在该产品
					$old_value1 = $this->db->getValue("SELECT goods_qty FROM ".CFG_DB_PREFIX ."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to']);
					$this->db->execute("UPDATE ".CFG_DB_PREFIX."depot_stock set goods_qty = goods_qty +".$rs['goods_qty']." where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to']);
					}else{
					$old_value1 =0;
					$this->db->insert(CFG_DB_PREFIX ."depot_stock",array("goods_id"=>$rs['goods_id'],"shelf_id"=>$rs['depot_id_to'],"goods_qty"=>$rs['goods_qty']));	
					}
					$order_id = $rs['order_id'];
					$this->db->execute("update ".CFG_DB_PREFIX."allocation_detail set is_ok  = 1 where rec_id=".intval($rs['rec_id']));
					$log['goods_id'] = $rs['goods_id'];
					$log['action'] = '产品调拨';
					$log['field'] = 'goods_qty';
					$log['content'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'].'调拨,从'.$depotlist[$rs['depot_id_from']].'调拨'.$rs['goods_qty'].'到'.$depotlist[$rs['depot_id_to']].",".$depotlist[$rs['depot_id_to']]."库存从".$old_value1.'变成'.($old_value1+$rs['goods_qty']);
					$log['admin_id'] = $_SESSION['admin_id'];
					$log['addtime'] = CFG_TIME;
					ModelGoods::goods_log($log);
		}
		if($order_id){
			$status = 4;
			if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."allocation_detail where is_ok = 0 and order_id = ".$order_id) == 0 ) $status = 1;
			$this->db->execute("update ".CFG_DB_PREFIX."allocation set status = ".$status." where order_id =".$order_id);
		}
		return '处理完成';
	}
	
	/*************
	*调拨单产品库存处理
	
	************/
	 private function updategoods($id,$status)
	 {
	 	$this->db->open('select m.goods_id,n.goods_sn,m.goods_qty,p.depot_id_from,p.status from '.CFG_DB_PREFIX.'allocation_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id left join '.CFG_DB_PREFIX.'allocation as p on m.order_id = p.order_id  where m.is_ok=0 and m.order_id = '.intval($id));
		$depotlist = ModelDd::getArray('shelf');
		$msg = '';
		while ($rs = $this->db->next()) {
			if(!($rs['status'] == 3 && $status == 1)){//除了调拨在途确认完成的操作之外都检查库存是否满足调拨需求
				if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_from']." AND goods_qty >=".$rs['goods_qty'])==0){
				return '存在产品'.$rs['goods_sn'].'库存不足,调拨失败<br>';
				}			
			}
		}
	 	$this->db->open('select m.rec_id,m.goods_id,n.goods_sn,m.goods_qty,p.depot_id_from,p.depot_id_to,p.order_sn,p.status from '.CFG_DB_PREFIX.'allocation_detail as m left join '.CFG_DB_PREFIX.'goods as n on m.goods_id = n.goods_id left join '.CFG_DB_PREFIX.'allocation as p on m.order_id = p.order_id  where m.is_ok=0 and m.order_id = '.intval($id));
		while ($rs = $this->db->next()) {
			if($status == 3 && $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to'])== 0) $this->db->insert(CFG_DB_PREFIX ."depot_stock",array("goods_id"=>$rs['goods_id'],"shelf_id"=>$rs['depot_id_to'],"goods_qty"=>0));	//调拨在途没原仓库没货的,增加产品	
				if(!($rs['status'] == 3 && $status == 1)){//非调拨在途确认到货
					$old_value = $this->db->getValue("SELECT goods_qty FROM ".CFG_DB_PREFIX ."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_from']);
					$this->db->execute("UPDATE ".CFG_DB_PREFIX."depot_stock set goods_qty = goods_qty -".$rs['goods_qty']." where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_from']);//出库库存扣除
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to']) == 0) $this->db->insert(CFG_DB_PREFIX ."depot_stock",array("goods_id"=>$rs['goods_id'],"shelf_id"=>$rs['depot_id_to'],"goods_qty"=>0));;
				}
				if($status != 3){//非调拨在途进行入库操作
					$old_value1 = $this->db->getValue("SELECT goods_qty FROM ".CFG_DB_PREFIX ."depot_stock where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to']);
					$this->db->execute("UPDATE ".CFG_DB_PREFIX."depot_stock set goods_qty = goods_qty +".$rs['goods_qty']." where goods_id = ".$rs['goods_id']." AND shelf_id = ".$rs['depot_id_to']);
					$this->db->execute("update ".CFG_DB_PREFIX.'allocation_detail set is_ok = 1 where rec_id = '.intval($rs['rec_id']));
				}
					$log['goods_id'] = $rs['goods_id'];
					$log['action'] = '产品调拨';
					$log['field'] = 'goods_qty';
					if($status == 3){//调拨在途
						$log['content'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'].'调拨,从'.$depotlist[$rs['depot_id_from']].'调拨'.$rs['goods_qty'].'到'.$depotlist[$rs['depot_id_to']].",".$depotlist[$rs['depot_id_from']]."库存从".$old_value.'变成'.($old_value-$rs['goods_qty']);
					}elseif($status == 1 && $rs['status'] == 0){//直接确认完成
						$log['content'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'].'调拨,从'.$depotlist[$rs['depot_id_from']].'调拨'.$rs['goods_qty'].'到'.$depotlist[$rs['depot_id_to']].",".$depotlist[$rs['depot_id_from']]."库存从".$old_value.'变成'.($old_value-$rs['goods_qty']).','.$depotlist[$rs['depot_id_to']]."库存从".$old_value1.'变成'.($old_value1+$rs['goods_qty']);
					}else{//正常确认完成
						$log['content'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'].'调拨,从'.$depotlist[$rs['depot_id_from']].'调拨'.$rs['goods_qty'].'到'.$depotlist[$rs['depot_id_to']].",".$depotlist[$rs['depot_id_to']]."库存从".$old_value1.'变成'.($old_value1+$rs['goods_qty']);
					}
					$log['admin_id'] = $_SESSION['admin_id'];
					$log['addtime'] = CFG_TIME;
					ModelGoods::goods_log($log);	
		}
			return $msg;
		}
}

?>