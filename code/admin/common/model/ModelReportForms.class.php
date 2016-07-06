<?php
class ModelReportForms extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'order';
		$this->primaryKey = 'order_id';
	}

	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to)
	{
		
		$sql='SELECT count(distinct g.order_id) as order_gross,count(og.rec_id) as good_gross,paid_time FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id and paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by paid_time';
		$result['totalCount'] = $this->getCount(
		'SELECT count(distinct g.order_id) as order_gross,count(og.rec_id) as good_gross,paid_time FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id and paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by paid_time');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	
	
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function GetOrderinterzone($from,$to)
	{
		
		$sql='SELECT count(order_id) as order_count,order_amount*RATE as jine FROM '.$this->tableName.' where paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by order_amount*RATE order by paid_time';
		$result['totalCount'] = $this->getCount(
		'SELECT count(order_id) as order_count,order_amount*RATE as jine FROM '.$this->tableName.' where paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by order_amount*RATE');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function GetBuytimes($from,$to)
	{
		
		$sql='SELECT count(order_id) as order_count,userid FROM '.$this->tableName.' where paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by userid order by count(order_id) DESC';
		$result['totalCount'] = $this->getCount(
		'SELECT count(order_id) as order_count,userid FROM '.$this->tableName.' where paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by userid');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	/**
	 * @param int $from
	 * @param int $to
	 */
	function getCountryStat($from,$to,$info)
	{
		$sql='SELECT sum(distinct g.order_amount*g.RATE) as money,country FROM '.$this->tableName.' g, '.CFG_DB_PREFIX.'order_goods og WHERE g.order_id = og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY g.country order by paid_time desc';
		$result['totalCount'] = $this->getCount(
		'SELECT count(g.country) FROM '.$this->tableName.' g, '.CFG_DB_PREFIX.'order_goods og WHERE g.order_id = og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY g.country');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	/**
	 * @param int $from
	 * @param int $to
	 */
	function getGoodsTypeSale($from,$to,$info)
	{
		$sql='SELECT FROM_UNIXTIME(o.paid_time,\'%Y-%m-%d\') as addtime,sum(og.goods_price) as goods_sale,sum(og.goods_qty) as goods_price FROM myr_order_goods og left join myr_order o on(o.order_id = og.order_id) left join myr_goods g on(g.SKU=og.goods_sn) WHERE  o.paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).''.(empty($info['cat_id'])?'':' and g.cat_id='.$info['cat_id']).' GROUP BY FROM_UNIXTIME(o.paid_time,\'%Y-%m-%d\') order by o.paid_time desc';	
		$result['totalCount'] = $this->getCount(
		'SELECT FROM_UNIXTIME(o.paid_time,\'%Y-%m-%d\') as addtime,sum(og.goods_price) as goods_sale,sum(og.goods_qty) as goods_price FROM myr_order_goods og left join myr_order o on(o.order_id = og.order_id) left join myr_goods g on(g.SKU=og.goods_sn) WHERE  o.paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).''.(empty($info['cat_id'])?'':' and g.cat_id='.$info['cat_id']).' GROUP BY FROM_UNIXTIME(o.paid_time,\'%Y-%m-%d\')');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	/**
	 * @param int $from
	 * @param int $to
	 */
	function getHotShop2($from,$to,$info)
	{
		$sql='SELECT o.Sales_account_id,count(og.rec_id) as xiaoliang,count(distinct o.order_id) as order_liang,sum(og.goods_qty) as xiaoshou_e FROM myr_order_goods og left join myr_order o on(o.order_id = og.order_id) left join myr_goods g on(g.SKU=og.goods_sn) WHERE o.paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).(empty($info['Sales_account'])?'':' and o.Sales_account_id='.$info['Sales_account']).(empty($info['cat_id'])?'':' and g.cat_id='.$info['cat_id']).' GROUP BY o.Sales_account_id order by o.paid_time';	
		$result['totalCount'] = $this->getCount(
		'SELECT o.Sales_account_id,count(og.rec_id) as xiaoliang,count(distinct o.order_id) as order_liang,sum(og.goods_qty) as xiaoshou_e FROM myr_order_goods og left join myr_order o on(o.order_id = og.order_id) left join myr_goods g on(g.SKU=og.goods_sn) WHERE o.paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).(empty($info['Sales_account'])?'':' and o.Sales_account_id='.$info['Sales_account']).(empty($info['cat_id'])?'':' and g.cat_id='.$info['cat_id']).' GROUP BY o.Sales_account_id');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}		
	function getOneGoodsReport($from,$to,$info)
	{
		$sql='SELECT sum(og.goods_qty) as goods_sale,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time,og.goods_price FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).(' and og.goods_sn=\''.$info['goods_sn']).'\' and paid_time >0 and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' group by  FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') order by paid_time desc';
		$result['totalCount'] = $this->getCount(
		'SELECT sum(og.goods_qty) as goods_sale,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time,og.goods_price FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).(' and og.goods_sn=\''.$info['goods_sn']).'\' and paid_time >0 and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' group by  FROM_UNIXTIME(paid_time,\'%Y-%m-%d\')');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function GetProfitinterzone($from,$to)
	{
		
		$sql='SELECT sum(og.goods_price*og.goods_qty) as jine,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time,og.goods_sn FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id and paid_time between '.strtotime($_POST['starttime']).' and '.strtotime($_POST['endtime']).' group by FROM_UNIXTIME(paid_time,\'%Y-%m-%d\'),og.goods_sn';
		//echo $sql;exit;
		$result['totalCount'] = 100;//$this->db->getValue('select count(*) from '.$this->tableName);
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			//$rs['paid_time'] = MyDate::transform('date',$rs['paid_time']);
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}	
	function getHotGoodsSales($info)
	{
		$sql='SELECT count( og.rec_id ) as good_gross,og.goods_sn FROM '.$this->tableName.' g, '.CFG_DB_PREFIX.'order_goods og WHERE g.order_id = og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY og.goods_sn order by good_gross desc LIMIT 0 , '.(empty($info['limit'])?5:$info['limit']);
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function getHotShop($info)
	{
		$sql='SELECT count( order_id ) as good_gross,Sales_account_id FROM '.$this->tableName.' WHERE  paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY Sales_account_id order by good_gross desc LIMIT 0 , '.(empty($info['limit'])?5:$info['limit']);
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['account_name'] = ModelDd::getCaption('allaccount',$rs['Sales_account_id']);
			$list[] = $rs;
		}
		return $list;
	}
	
	function getSalesState()
	{
		$sql='SELECT count(distinct g.order_id) as order_gross,count(og.rec_id) as good_gross,Sales_account_id FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id group by Sales_account_id LIMIT 0 , 5';
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function getMonthSales($info)
	{
		$sql='SELECT sum(order_amount*RATE) as order_sale,FROM_UNIXTIME(paid_time,\'%Y-%m\') as yuefei FROM '.$this->tableName.' where paid_time>0 '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and FROM_UNIXTIME(paid_time,\'%Y-%m\') between \''.$info['starttime'].'\' and \''.$info['endtime'].'\' group by  yuefei ORDER BY paid_time DESC';
		$this->db->open($sql);
		$list = array();
		$item =array();
		while ($rs = $this->db->next()) {
			$item[$rs['yuefei']] += $rs['order_sale'];
		}
		foreach($item as $k=>$v){
			$rs1['yuefei'] = $k;
			$rs1['order_sale']= $v;
			$list[] = $rs1;
		}
		return $list;
	}
	function getDaySales($info)
	{
		$sql='SELECT sum(order_amount*RATE) as order_sale,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time FROM '.$this->tableName.' where paid_time >0  '.(($info['Sales_account']==0)?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime'].' 23:59:59').' group by  paid_time';
		$this->db->open($sql);
		$list = array();
		$item =array();
		while ($rs = $this->db->next()) {
			$item[$rs['paid_time']] += $rs['order_sale'];
		}
		foreach($item as $k=>$v){
			$rs1['paid_time'] = $k;
			$rs1['order_sale']= $v;
			$list[] = $rs1;
		}
		return $list;
	}
	function getDaySales2($from,$to,$info)
	{
		$sql='SELECT sum(distinct o.order_amount*o.RATE) as xiaoshou_e,count(og.rec_id) as xiaoliang,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time FROM '.$this->tableName.' o,'.CFG_DB_PREFIX.'order_goods og where o.order_id=og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time >0 and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' group by  paid_time order by paid_time desc';
		$this->db->open($sql,$from,$to);
		$result['totalCount'] = $this->getCount(
		'SELECT sum(distinct o.order_amount*o.RATE) as xiaoshou_e,count(og.rec_id) as xiaoliang,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time FROM '.$this->tableName.' o,'.CFG_DB_PREFIX.'order_goods og where o.order_id=og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time >0 and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' group by  paid_time ');
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		$result['topics'] = $list;
		return $result;
	}	
	function orderGoodsRate()
	{
		$sql='SELECT count(og.rec_id) as good_gross FROM '.$this->tableName.' g,'.CFG_DB_PREFIX.'order_goods og where g.order_id=og.order_id '.(empty($_GET['Sales_account'])?'':'and Sales_account_id='.$_GET['Sales_account']).' and paid_time >0 and paid_time between '.strtotime($_GET['starttime']).' and '.strtotime($_GET['endtime']).' group by g.order_id ';//LIMIT 0 , '.(empty($_GET['limit'])?5:$_GET['limit']);
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function getCount($sql) {
		$this->db->open($sql);
		$i=0;
		while ($rs = $this->db->next()) {
			$i+=1;
		}
		return $i;
	}			
}
?>