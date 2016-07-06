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
 * 统计类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelStatistics extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'Statistics';
		$this->primaryKey = 'id';
	}
	

//=============================================================================================

	function getWhere($info) {
		specConvert($info,array('account','channels','starttime','endtime'));
		$wheres = array();
		if ($info['account'] && is_numeric($info['account'])) {
			$wheres[] = 'Sales_account_id =\''.$info['account'].'\'';
		}
		if ($info['channels'] && is_numeric($info['channels'])) {
			$wheres[] = 'Sales_channels =\''.$info['channels'].'\'';
		}
		$fieldname = ($info['timetype'] == 1)?'end_time':'paid_time';
			if ($info['starttime']) {
				$starttime = $info['starttime'].' 00:00:00';
				$wheres[] = strtotime($starttime).'<= '.$fieldname;
			}else{
				$starttime = date('Y-m-d').' 00:00:00';
				$wheres[] = strtotime($starttime).'<= '.$fieldname;
			}
			if ($info['endtime']){
				$endtime = $info['endtime'].' 23:59:59';
				$wheres[] = $fieldname.' <='.strtotime($endtime);
			}else{
				$endtime = date('Y-m-d').' 23:59:59';
				$wheres[] = $fieldname.' <='.strtotime($endtime);
			}

		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
//=============================================================================================

	/*
	* 返回 当天缺货订单数
	*/
	function out_order($where){
		return $this->db->getValue("select count(order_id) as count from ".CFG_DB_PREFIX."order ".$where." and order_status = 131");
	}
	
	
	/*
	* 返回 当天订单数总数量
	*/
	function order_count($where){
		return $this->db->getValue("select count(order_id) as count from ".CFG_DB_PREFIX."order ".$where);
	}
	
	
	/*
	* 返回 当天订单总金额
	*/
	function order_amount($where){
		return $this->db->getValue("select sum(order_amount*RATE) as sum from ".CFG_DB_PREFIX."order ".$where);
	}
	
	
	/*
	* 返回 当天产品总金额
	*/
	function goods_amount($where){
		return $this->db->getValue("select sum(m.goods_price * m.goods_qty*t.RATE) as sum from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as t on m.order_id = t.order_id where m.order_id in(select order_id from ".CFG_DB_PREFIX."order ".$where.")");
	}
	
	
	/*
	*返回 当天总利润
	*/
	function total_porfit($where){
		return $this->db->getValue("select sum((m.goods_price*t.RATE - n.cost)*m.goods_qty) as sum from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."goods as n  on m.goods_sn = n.SKU left join ".CFG_DB_PREFIX."order as t on m.order_id = t.order_id  where m.order_id in (select order_id from ".CFG_DB_PREFIX."order ".$where.")");
	}
	
	
	/*
	* 生成 查询数据(默认为当天)
	*/
	function orderlist($where){	
		//$arr["total"]=3;
		$arr["results"][]=array("title"=>"订单总金额","value"=>round($this->order_amount($where)));
		$arr["results"][]=array("title"=>"产品总金额","value"=>round($this->goods_amount($where)));
		$arr["results"][]=array("title"=>"产品总利润","value"=>round($this->total_porfit($where)));
		$arr["total"]=count($arr["results"]);
		//$arr["results"][]=array("title"=>"订单总数","value"=>$this->order_count($where);
		//$arr["results"][]=array("title"=>"缺货订单数","value"=>$this->out_order($where);
		return $arr;
	}
	
	/*
	* 获取 本周 查询时间
	*
	* @return array
	*/
	function weekTime(){
		for($i=2;$i<=(date('N')+1);$i++){
			$arr[$i] = array('startTime'=>strtotime(date('Y-m-d').' 00:00:00')-((date('N')-$i+1)*24*60*60),'endTime'=>strtotime(date('Y-m-d').' 23:59:59')-((date('N')-$i+1)*24*60*60));
		}
		return $arr;
	}
	
	

	/*
	* 生成 本周 统计数据
	*
	* @return array
	*/
	function week_total($info){
		$arr_time = $this->weekTime();
		$where = $this->getSelectWhere($info);
		$arr = array('星期一','星期二','星期三','星期四','星期五','星期六','星期日');
		$count = count($arr_time);
		$array['total'] = $count;
			for($i=2;$i<2+$count;$i++){
			$array["result"][]=array("order_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,3)),"goods_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,2)),"total_porfit"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info)),"week"=>$arr[$i-2]);
			}
		return $array;
	}
	/*
	* 获取 今年 查询时间
	*
	* @return array
	*/
	function YearTime(){
		$mon_arr1 = array(1,3,5,7,8,10,12);
		$mon_arr2= array(4,6,9,11);
		for($i=1;$i<=date('m');$i++){
			if(in_array($i,$mon_arr1)){
				$arr[$i] = array('startTime'=>strtotime(date('Y').'-'.$i.'-01 00:00:00'),'endTime'=>strtotime(date('Y').'-'.$i.'-31 23:59:59'));
			}elseif(in_array($i,$mon_arr2)){
				$arr[$i] = array('startTime'=>strtotime(date('Y').'-'.$i.'-01 00:00:00'),'endTime'=>strtotime(date('Y').'-'.$i.'-30 23:59:59'));
			}elseif($i == 2 && date('L') == 1){
				$arr[$i] = array('startTime'=>strtotime(date('Y').'-'.$i.'-01 00:00:00'),'endTime'=>strtotime(date('Y').'-'.$i.'-29 23:59:59'));
			}elseif($i == 2 && date('L') == 0){
				$arr[$i] = array('startTime'=>strtotime(date('Y').'-'.$i.'-01 00:00:00'),'endTime'=>strtotime(date('Y').'-'.$i.'-28 23:59:59'));
			}
		}
		return $arr;
	}
	/*
	* 生成 年统计 数据
	* @$arr  array
	* @return array
	*/
	function year_total($info){
		$arr_time = $this->YearTime();
		$where = $this->getSelectWhere($info);
		$array['total'] = count($arr_time);
		$arr = array('1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月');
		for($i=1;$i<1+$array['total'];$i++){
			$array["result"][]=array("year_order_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,3)),"year_goods_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,2)),"year_total_porfit"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info)),"mon"=>$arr[$i-1]);
		}
		return $array;
	}
	/*
	* 获取 本月 查询时间
	*
	* @return array
	*/
	function MonTime(){
		for($i=1;$i<=date('d');$i++){
			$arr[$i] = array('startTime'=>strtotime(date('Y-m').'-'.$i.' 00:00:00'),'endTime'=>strtotime(date('Y-m').'-'.$i.' 23:59:59'));
		}		
		return $arr;
	}
	

	/*
	* 生成 本月统计数据
	* @$info  array
	* @return array
	*/
	function mon_total($info){
		$arr_time = $this->MonTime();
		$where = $this->getSelectWhere($info);
		$array['total'] = count($arr_time);
		for($i=1;$i<1+$array['total'];$i++){
			$array["result"][]=array("mon_order_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,3)),"mon_goods_amount"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,2)),"mon_total_porfit"=>round($this->creat_total_porfit($arr_time[$i]['startTime'],$arr_time[$i]['endTime'],$where,$info,1)),"day"=>$i);
		}
		return $array;
	}	
	
	/*
	* 生成 总利润
	* @$from  string
	* @$to    string
	* @$where  string
	* @$info  array
	* @$type  1 表示总利润 2表示产品总金额 3订单总金额
	* @return array
	*/

//=============================================================================================

	function creat_total_porfit($from,$to,$where,$info,$type=1){		
		$count = $this->db->getValue("select count(*) from ".CFG_DB_PREFIX."statistics_log as t where t.start = ".$from." and t.end = ".$to." and t.type = ".$type .$where." and t.timetype = ".$info['timetype']." and t.is_before = 0 ");
		if($count == 0){
			$fieldname = ($info['timetype'] == 1)?'end_time':'paid_time';
				$timetype = " <= t.".$fieldname." and t.".$fieldname." <= ";
			$total_porfit = 0;
			if($type == 1) $total_porfit = $this->db->getValue("select sum((m.goods_price*t.RATE - n.cost)*m.goods_qty) as sum from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."goods as n  on m.goods_sn = n.SKU left join ".CFG_DB_PREFIX."order as t on m.order_id = t.order_id  where ".$from.$timetype.$to.$where);
			if($type == 2) $total_porfit = $this->db->getValue("select sum(m.goods_price * m.goods_qty * t.RATE) as sum from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order  as t on m.order_id = t.order_id where ".$from.$timetype.$to.$where);
			if($type == 3) $total_porfit = $this->db->getValue("select sum(t.order_amount*t.RATE) as sum from ".CFG_DB_PREFIX."order as t where ".$from.$timetype.$to.$where."");
			$before = (CFG_TIME > $to)?0:1;
			$arr = array('start'=>$from,'end'=>$to,'type'=>$type,'timetype'=>$info['timetype'],'`value`'=>$total_porfit,'Sales_account_id'=>$info['account'],'Sales_channels'=>$info['channels'],'is_before' =>$before);
			$this->db->insert(CFG_DB_PREFIX."statistics_log",$arr);	
		}
		return $this->db->getValue("select t.value from ".CFG_DB_PREFIX."statistics_log as t where t.start = ".$from." and t.end = ".$to." and t.type = ".$type.$where." and t.timetype = ".$info['timetype']." order by t.id desc");
	}
//=============================================================================================	


	/*
	* 数据 加载 条件
	*/
	function getSelectWhere($info) {
		specConvert($info,array('account','channels'));
		$wheres = array();
		if ($info['account'] != 0) {
			$wheres[] = 't.Sales_account_id =\''.$info['account'].'\'';
		}
		if ($info['channels'] != 0) {
			$wheres[] = 't.Sales_channels =\''.$info['channels'].'\'';
		}
		$where = '';
		if ($wheres) {
			$where = ' and ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	
	/**
	 * 生成发货方式查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getShippingWhere($info) {
		specConvert($info,array('starttime','account','totime'));
		$wheres = array();
			if ($info['account'] != 0) {
				$wheres[] = 'Sales_account_id=\''.$info['account'].'\'';
			}
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'end_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'end_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'end_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = implode(' and ', $wheres).' and ';
		}
		return $where;
	}
	
	/**
	*获取发货统计列表
	*
	*
	**/
	function getShippingList($where=null){
		$shipping = ModelDd::getArray('shipping');
		$result = array();
		foreach($shipping as $k=>$v){
			if($k == 0) continue;
			$rs['shipping'] = $v;
			$rs['counts'] = $this->db->getValue("SELECT count(*) from ". CFG_DB_PREFIX . "order where ".$where." shipping_id = '".$k."'");
			$rs['weights'] = $this->db->getValue("SELECT sum(weight) from ". CFG_DB_PREFIX . "order where ".$where." shipping_id = '".$k."'");
			$rs['costs'] = $this->db->getValue("SELECT sum(shipping_cost) from ". CFG_DB_PREFIX . "order where ".$where."  shipping_id = '".$k."'");
			$rs['weights']=$rs['weights']?$rs['weights']:0;
			$rs['costs']=$rs['costs']?$rs['costs']:0;
			$result[] = $rs;
			reset($rs);	
		}
		return $result;
	}
	/**
	 * 生成出入库统计查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getStockWhere($info) {
		specConvert($info,array('starttime','totime','goods_sn'));
		$wheres = array();
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'n.out_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'n.out_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'n.out_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		if($info['depot'] <>"") $wheres[] = "n.DEPOT_ID = '".$info['depot']."'";
		if($info['goods_sn']) $wheres[] = '(p.goods_sn = "'.$info['goods_sn'].'" or p.goods_name  = "'.$info['goods_sn'].'")';
		$supplier = ($_POST['type'] == 1)?$_POST['supplier2']:$_POST['supplier1'];
		if($supplier <>0) $wheres[] = 'n.supplier = "'.$supplier.'"';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where.' group by goods_id'.(($info['num'] && $info['num']>0)?' having num>'.$info['num']:'');
	}
	/**
	 * 生成查出入库流水询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getStocktransWhere($info) {
		specConvert($info,array('starttime','totime','goods_sn'));
		$wheres = array();
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'n.out_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'n.out_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'n.out_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		if($info['goods_sn']) $wheres[] = '(p.goods_sn = "'.$info['goods_sn'].'" or p.sku  = "'.$info['goods_sn'].'")';
		if($info['depot'] <>"") $wheres[] = "n.DEPOT_ID = '".$info['depot']."'";
		$supplier = ($_POST['type'] == 1)?$_POST['supplier2']:$_POST['supplier1'];
		if($supplier <>0) $wheres[] = 'n.supplier = "'.$supplier.'"';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/*************
	*获取出入库的统计数量
	************/
	function getStockCount($where,$type)
	{
			$table = ($type == 1)?"stockout":"Stockin";
		return $this->db->getValue('SELECT count(*) From (SELECT m.goods_id,sum(m.goods_qty) as num from '.CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where.") as a");
	}
	/*************
	*获取出入库的流水数量
	************/
	function getStocktransCount($where,$type)
	{
			$table = ($type == 1)?"stockout":"Stockin";
		return $this->db->getValue('SELECT count(*) From '.CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where);
	}
	/*************
	*获取出入库的统计列表
	************/
	function getStockList($from,$to,$where,$type,$export=null)
	{
		$table = ($type == 1)?"stockout":"Stockin";
		if($export){
		$this->db->open("SELECT sum(m.goods_qty) as num,p.goods_sn,p.goods_name,p.goods_id from ".CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where.' order by num desc');
		}else{
		$this->db->open("SELECT sum(m.goods_qty) as num,p.goods_sn,p.goods_name,p.goods_id from ".CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where.' order by num desc',$from,$to);
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/*************
	*获取出入库的流水列表
	************/
	function getStocktransList($from,$to,$where,$type,$export=null)
	{
		$table = ($type == 1)?"stockout":"Stockin";
		if($type == 1){
			$table = "stockout";
			$supplier = ModelDd::getArray('Sales_channels');
			$PREFIX = CFG_OUT_ORDER_PREFIX;
			}else{
			$table = "Stockin";
			$supplier = ModelDd::getArray('supplier');
			$PREFIX = CFG_IN_ORDER_PREFIX;
		}
		if($export){
		$this->db->open("SELECT m.goods_qty,p.goods_sn,p.goods_name,p.SKU,p.goods_id,n.order_sn,n.out_time,n.supplier from ".CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where.' order by goods_sn desc');
		}else{
		$this->db->open("SELECT m.goods_qty,p.goods_sn,p.goods_name,p.SKU,p.goods_id,n.order_sn,n.out_time,n.supplier from ".CFG_DB_PREFIX.$table.'_detail as m left join '.CFG_DB_PREFIX.'goods as p on m.goods_id = p.goods_id left join '.CFG_DB_PREFIX.$table.' as n on m.order_id = n.order_id'.$where.' order by goods_sn desc',$from,$to);
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['out_time'] =  MyDate::transform('date',$rs['out_time']);
			$rs['supplier'] =  $supplier[$rs['supplier']];
			$rs['order_sn'] = $PREFIX.$rs['order_sn'];
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getOrderWhere($info) {
		specConvert($info,array('starttime','totime','goods_sn','account'));
		$wheres = array();
		if($info['goods_sn']) $wheres[] = 'goods_sn = "'.$info['goods_sn'].'"';
		$wheres[] = 'admin_id = "'.$_SESSION['admin_id'].'"';
		if($info['num']) $wheres[] = 'total_qty > "'.$info['num'].'"'; 
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	/*************
	*获取销售的统计数量
	************/
	function getOrderCount($where)
	{
		return $this->db->getValue('SELECT count(*) From '.CFG_DB_PREFIX.'statistics_order_goods  '.$where);
	}
	/*************
	*获取销售的统计列表
	************/
	function getOrderList($from,$to,$where,$export=null,$cy='CNY')
	{
		require(CFG_PATH_DATA . 'dd/currency.php');
		$rate = (array_key_exists($cy,$currency))?$currency[$cy]:1;
		if($export){
		$this->db->open("SELECT * FROM ".CFG_DB_PREFIX."statistics_order_goods ".$where." order by total_qty desc");
		}else{
		$this->db->open("SELECT * FROM ".CFG_DB_PREFIX."statistics_order_goods ".$where." order by total_qty desc",$from,$to);
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['cost'] = round($rs['cost']/$rate,2);
			$rs['shipping_fee'] = round($rs['shipping_fee']/$rate,2);
			$rs['package_fee'] = round($rs['package_fee']/$rate,2);
			$rs['avrprice'] = round($rs['avrprice']/$rate,2);
			$rs['amount'] = round($rs['amount']/$rate,2);
			$rs['shippingcost'] = round($rs['shippingcost']/$rate,2);
			$result[] = $rs;
		}
		return $result;
	}
	
	function initorderlist($info)
	{
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."statistics_order_goods_log where starttime='".$info['starttime']."' AND totime ='".$info['totime']."' AND Sales_account_id ='".$info['account']."' AND timetype = '".$info['timetype']."' AND admin_id =".$_SESSION['admin_id'])==1) return;
		$timefiled = ($info['timetype'] == 2)?'end_time':'paid_time';
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'n.'.$timefiled.' between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'n.'.$timefiled.' < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'n.'.$timefiled.' > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		if($info['account'] != 0) $wheres[] = 'n.Sales_account_id = "'.$info['account'].'"';
		$wheres[] = "n.order_status in (SELECT id FROM ".CFG_DB_PREFIX."order_status where pay_status = 1)";
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		$goods_status = ModelDd::getArray('goods_status');
		require(CFG_PATH_DATA . 'dd/currency.php');
		$goods= new ModelGoods();
		$object = new ModelOrder();
		$this->db->execute("delete FROM ".CFG_DB_PREFIX.'statistics_order_goods where admin_id ='.$_SESSION['admin_id']);
		$this->db->open("SELECT m.goods_sn,sum(m.goods_qty) as total_qty,sum(m.goods_qty*m.goods_price*n.rate) as amount,m.goods_sn from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id ".$where." group by goods_sn");
		$result = array();
		while ($rs = $this->db->next()) {
			$goodsqty = $goods->getgoodsqty($rs['goods_id']);
			$orderlist = $this->db->select("SELECT m.order_id,m.goods_qty,n.currency FROM  ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id ".$where." and m.goods_sn ='".$rs['goods_sn']."' group by order_id");
			$rs['shippingcost'] =0;
			for($i=0;$i<count($orderlist);$i++){
				$rs['shippingcost'] += $currency[$orderlist[$i]['currency']]*$orderlist[$i]['goods_qty']*($object->getavrshipping($orderlist[$i]['order_id']));
			}
			$rs1 = $this->db->getValue("SELECT p.goods_name,p.grade,p.cost,p.goods_id,p.cat_id,p.status,q.shipping_fee,q.package_fee FROM ".CFG_DB_PREFIX."goods as p  left join ".CFG_DB_PREFIX."category as q on p.cat_id = q.cat_id where p.sku = '".$rs['goods_sn']."' or p.goods_sn ='".$rs['goods_sn']."'");
			$this->db->insert(CFG_DB_PREFIX.'statistics_order_goods',array(
						'goods_sn'=>$rs['goods_sn'],
						'total_qty'=>$rs['total_qty'],
						'amount'=>$rs['amount'],
						'shippingcost' => $rs['shippingcost'],
						'goods_name'=>$rs1['goods_name'],
						'cost'=>$rs1['cost'],
						'shipping_fee'=>$rs1['shipping_fee'],
						'package_fee'=>$rs1['package_fee'],
						'grade' =>$rs1['grade'],
						'status'=>$goods_status[$rs1['status']],
						'fix_price'=>$goods->getfixprice($rs1['goods_id']),
						'valid_qty'=>$goodsqty['goods_qty']- $goodsqty['varstock'],
						'interest'=>@floor(($rs['amount']+$rs['shippingcost']-$rs['total_qty']*($rs1['cost']+$rs1['shipping_fee']+$rs1['package_fee']))*100/($rs['total_qty']*($rs1['cost']+$rs1['shipping_fee']+$rs1['package_fee']))),
						'avrprice'=>@($rs['amount']*$rate/$rs['total_qty']),
						'onarrive_qty'=>$this->db->getValue("SELECT sum(goods_qty-arrival_qty-return_qty) FROM ".CFG_DB_PREFIX."p_order_goods where goods_id ='".$rs1['goods_id']."' AND order_id in (select order_id FROM ".CFG_DB_PREFIX."p_order where status <> 3)"),
						'want_qty'=>$goodsqty['want_qty'],
						'admin_id'=>$_SESSION['admin_id']
						));
		}
		$this->db->execute("DELETE FROM ".CFG_DB_PREFIX.'statistics_order_goods_log where admin_id ='.$_SESSION['admin_id']);
		$this->db->insert(CFG_DB_PREFIX.'statistics_order_goods_log',array('admin_id'=>$_SESSION['admin_id'],'starttime'=>$info['starttime'],'totime'=>$info['totime'],'Sales_account_id'=>$info['account'],'timetype'=>$info['timetype']));
	}
	
	/******
	*@获取销售员产品数量
	******/
	function getcommissionCount($id)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."sales_goods where id =".$id);		
	}
	
	
	function getcommissionList($from,$to,$info)
	{
		$channelrate = ModelDd::getArray('channelrate');
		$this->db->open("SELECT m.sku,m.cost,n.start_time,n.name,n.rate,n.code FROM ".CFG_DB_PREFIX."sales_goods as m left join ".CFG_DB_PREFIX."sales as n on m.id = n.id where n.id='".$info['sales']."'");
		$stime = MyDate::transform('timestamp',$info['starttime']);
		$etime = MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59');
		$result = array();
		while ($rs = $this->db->next()) {
			$stime =($rs['start_time']>$stime)?$rs['start_time']:$stime;
			$list = $this->db->select("SELECT m.goods_price,m.goods_qty,n.rate,n.order_amount,n.Sales_channels FROM ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id where n.paid_time >= ".$stime." and n.paid_time <= ".$etime." and n.order_status = 131 and (m.goods_sn = '".$rs['sku']."' or sn_prefix = '".$rs['code'].")'");
			$total = 0;
			$totalnum = 0;
			for($i=0;$i<count($list);$i++){
				$rate = ($channelrate[$list[$i]['Sales_channels']])?$channelrate[$list[$i]['Sales_channels']]:0;
				$total += $list[$i]['order_amount']*$list[$i]['rate']*(100-$rate)/100;
				$totalnum += $list[$i]['goods_qty'];
			}
			$rs['start_time'] = MyDate::transform('date',$rs['start_time']);
			$rs['commission'] = round(($total-$totalnum*$rs['cost'])*$rs['rate']/100,2);
			$rs['num'] = $totalnum;
			$result[] = $rs;
		}
		return $result;
	}
	
	function getcurrent($info)
	{
		$result = array();
		$depot = ModelDd::getArray("depot");
		foreach($depot as $k=>$v){
			$rs['depot'] = $v;
			$rs['total'] = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$k.")");
			$rs['hasstock'] = $this->db->getvalue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_qty >0 and shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$k.")");
			$rs['instatus'] = $this->db->getvalue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock as m left join ".CFG_DB_PREFIX."goods as n on m.goods_id = n.goods_id where m.goods_qty >0 and  n.status in(".CFG_GOODS_STATUS.") and m.shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$k.")");
			$rs['totalcost'] = $this->db->getvalue("SELECT sum(m.goods_qty*n.cost) FROM ".CFG_DB_PREFIX."depot_stock as m left join ".CFG_DB_PREFIX."goods as n on m.goods_id = n.goods_id where m.goods_qty >0 and m.shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$k.")");
			$rs['varcost'] = $this->db->getvalue("SELECT sum(m.varstock*n.cost) FROM ".CFG_DB_PREFIX."depot_stock as m left join ".CFG_DB_PREFIX."goods as n on m.goods_id = n.goods_id where m.goods_qty >0 and m.shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = ".$k.")");
			$result[] = $rs;
			}
			return $result;
	}
	
	
	function getBestmatchWhere($info)
	{
		specConvert($info,array('goods_sn','account'));
		$wheres = array();
		if($info['goods_sn']) $wheres[] = 'n.SKU = "'.$info['goods_sn'].'"';
		if($info['account'] != 0) $wheres[] = 'm.account_id = "'.$info['account'].'"';
		$wheres[] = " m.addtime = ".$this->db->getValue("SELECT addtime FROM ".CFG_DB_PREFIX."ebay_bestmatch ".(($info['account'] != 0)?" where account_id=".$info['account']:'')." order by addtime desc");
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	function getBestmatchCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."ebay_bestmatch as m left join ".CFG_DB_PREFIX."ebayselling as n on m.itemid = n.itemid".$where);		
	}
	
	function getbestmatchList($from,$to,$where,$export=null,$sort=null)
	{
		if($export){
		$this->db->open("SELECT sum(m.goods_qty) as num,m.goods_sn,p.goods_name,p.goods_id from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id left join ".CFG_DB_PREFIX."goods as p on m.goods_sn = p.sku".$where.' order by num desc');
		}else{
		$this->db->open("SELECT m.*,n.ViewItemURL,n.ListingDuration,n.ListingType,n.SKU,n.Title FROM ".CFG_DB_PREFIX."ebay_bestmatch as m left join ".CFG_DB_PREFIX."ebayselling as n on m.itemid = n.ItemID".$where.' order by '.$sort.' itemid desc',$from,$to);
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['viewItemPerImpression'] = number_format($rs['viewItemPerImpression'], 4, '.', '');
			$rs['salesPerImpression'] = number_format($rs['salesPerImpression'], 4, '.', '');
			$rs['salesPerViewItem'] = number_format($rs['salesPerViewItem'], 4, '.', '');
			$result[] = $rs;
		}
		return $result;
	}
	
	function getprofitWhere($info)
	{
		$wheres = array();
		$timefiled = ($info['timetype'] == 2)?'end_time':'paid_time';
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = $timefiled.' between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = $timefiled.' < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = $timefiled.' > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		if($info['account'] != 0) $wheres[] = 'Sales_account_id = "'.$info['account'].'"';
		$wheres[] = "order_status in (SELECT id FROM ".CFG_DB_PREFIX."order_status where pay_status = 1)";
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	function getprofitCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."order".$where);		
	}
	
	function getprofitList($from,$to,$where,$export=null,$sort=null)
	{
		if($export){
		$this->db->open("SELECT order_id,country,Sales_channels,shipping_id,order_sn,shipping_fee,order_amount,rate,Sales_account_id,shipping_cost,weight from ".CFG_DB_PREFIX."order".$where.' order by order_id desc');
		}else{
		$this->db->open("SELECT order_id,country,Sales_channels,shipping_id,order_sn,shipping_fee,order_amount,rate,Sales_account_id,shipping_cost,weight from ".CFG_DB_PREFIX."order".$where.' order by order_id desc',$from,$to);
		}
		$shipping = ModelDd::getArray('shipping');
		$object = new ModelOrder();
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
			if($rs['rate'] == 0) $rs['rate']=1;
			$rs['shipping_id'] = $shipping[$rs['shipping_id']];
			$rs['shipping_fee'] = round($rs['shipping_fee']*$rs['rate'],2);
			$rs['order_amount'] = round($rs['order_amount']*$rs['rate'],2);
			$goodsinfo = $object->order_goods_info($rs['order_id']);
			$goodsprice =0;
			$rs['goods_shipping'] = 0;
			$rs['goods_package'] = 0;
			$rs['goods_price'] =0;
			$rs['channelfee'] =ModelSales::getchannelfee($rs['order_amount'],$rs['Sales_channels']);
			for($i=0;$i<count($goodsinfo);$i++){
					$goodsprice +=	$goodsinfo[$i]['goods_price'];
					$cat = $this->db->getValue("SELECT m.cost,n.shipping_fee,n.package_fee FROM ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."category as n on m.cat_id = n.cat_id where m.goods_id = '".$goodsinfo[$i]['goods_id']."'");
					$rs['goods_shipping'] +=  $cat['shipping_fee'];
					$rs['goods_package'] +=  $cat['package_fee'];
					$rs['goods_price'] += $cat['cost'];
			}
			$rs['goods_total'] = round($goodsprice*$rs['rate'],2);
			$rs['per'] = $rs['order_amount']-$rs['goods_shipping']-$rs['goods_package']-$rs['goods_price']-$rs['shipping_cost']-$rs['channelfee'];
			$rs['interest'] = ($rs['order_amount'] == 0)?0:number_format($rs['per']/$rs['order_amount'], 2, '.', '');
			$result[] = $rs;
		}
		return $result;
	}
	
	/************
	********获取新品上架数量
	************/
	function getNewWhere($info)
	{
		$wheres = array();
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'm.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'm.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'm.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getNewCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods as m".$where);	
	}
	function getNewList($from,$to,$where,$export=null,$cy='CNY',$info)
	{
		require(CFG_PATH_DATA . 'dd/currency.php');
		$rate = (array_key_exists($cy,$currency))?$currency[$cy]:1;
		if($info['totime'] <> "" && $info['starttime'] <> ""){
			 $where1 = ' (n.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\')';
			 $where2 = ' where (n.paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\')';
		}
		if($info['totime'] <> "" && $info['starttime'] == "") {
			$where1 = ' n.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			$where2 = ' where n.paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		}
		if($info['totime'] == "" && $info['starttime'] <> "") {
			$where1 = ' n.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
			$where2 = ' where n.paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		}
		require(CFG_PATH_DATA . 'dd/currency.php');
		if($export){
		$this->db->open("SELECT m.goods_id,m.add_time,m.goods_sn,m.goods_name,m.SKU,m.cost,m.grade,n.shipping_fee,n.package_fee from ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."category as n on m.cat_id = n.cat_id ".$where.' order by m.goods_id desc');
		}else{
		$this->db->open("SELECT m.goods_id,m.add_time,m.goods_sn,m.goods_name,m.SKU,m.cost,m.grade,n.shipping_fee,n.package_fee from ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."category as n on m.cat_id = n.cat_id ".$where.' order by m.goods_id desc',$from,$to);
		}
		$goods = new ModelGoods();
		$object = new ModelOrder();
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['cost'] = round($rs['cost']/$rate,2);
			$rs['shipping_fee'] = round($rs['shipping_fee']/$rate,2);
			$rs['package_fee'] = round($rs['package_fee']/$rate,2);
			$rs['purchase_qty'] = $this->db->getValue("SELECT sum(m.goods_qty) FROM ".CFG_DB_PREFIX."p_order_goods as m left join ".CFG_DB_PREFIX."p_order as n on m.order_id = n.order_id where m.goods_id ='".$rs['goods_id']."' AND ".$where1);
			$rs['add_time'] = MyDate::transform('date',$info['starttime']);
			$rs['fix_price'] = $goods->getfixprice($rs['goods_id']);
			$goodsqty = $goods->getgoodsqty($rs['goods_id']);
			$rs['valid_qty'] = $goodsqty['goods_qty']- $goodsqty['varstock'];
			$rs['onarrive_qty'] = $this->db->getValue("SELECT sum(goods_qty-arrival_qty-return_qty) FROM ".CFG_DB_PREFIX."p_order_goods where goods_id ='".$rs['goods_id']."' AND order_id in (select order_id FROM ".CFG_DB_PREFIX."p_order where status <> 3)");
			$rs['want_qty'] = $goodsqty['want_qty'];
			$orderinfo = $this->db->getValue("SELECT sum(m.goods_qty) as total_qty,sum(m.goods_qty*m.goods_price*n.rate) as amount from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id".$where2." AND m.goods_sn ='".$rs['SKU']."'");
			$rs['total_qty'] = $orderinfo['total_qty'];
			$rs['amount'] = floor($orderinfo['amount']);
			$orderlist = $this->db->select("SELECT m.order_id,m.goods_qty,n.currency FROM  ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id ".$where2." and m.goods_sn ='".$rs['SKU']."' group by order_id");
			$rs['shippingcost'] =0;
			for($i=0;$i<count($orderlist);$i++){
				$rs['shippingcost'] += $currency[$orderlist[$i]['currency']]*$orderlist[$i]['goods_qty']*($object->getavrshipping($orderlist[$i]['order_id']));
			}	
			$rs['avrprice'] =@($rs['amount']/$rs['total_qty']);
			$rs['interest'] =@floor(($rs['amount']+$rs['shippingcost']-$rs['total_qty']*($rs['cost']+$rs['shipping_fee']+$rs['package_fee']))*100/($rs['total_qty']*($rs['cost']+$rs['shipping_fee']+$rs['package_fee'])));
			$rs['avrprice'] = round($rs['avrprice']/$rate,2);
			$rs['amount'] = round($rs['amount']/$rate,2);
			$rs['shippingcost'] = round($rs['shippingcost']/$rate,2);
			$result[] = $rs;
			unset($rs);
		}
		return $result;
	}
	function getOldCount()
	{
		return $this->db->getValue("SELECT count(*) FROM (select count(distinct m.goods_id),sum(n.goods_qty) as num FROM ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."depot_stock as n on m.goods_id = n.goods_id group by m.goods_id having num >0) as c");
	}
	
	function getoldWhere($info)
	{
		
	}
	/******
	*****呆货列表
	******/
	function  getOldList($from,$to,$where,$export=null)
	{
		require(CFG_PATH_DATA . 'dd/currency.php');
		$rate = (array_key_exists($cy,$currency))?$currency[$cy]:1;
		if($info['totime'] <> "" && $info['starttime'] <> ""){
			 $where1 = ' (n.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\')';
			 $where2 = ' where (n.paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\')';
		}
		if($info['totime'] <> "" && $info['starttime'] == "") {
			$where1 = ' n.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
			$where2 = ' where n.paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
		}
		if($info['totime'] == "" && $info['starttime'] <> "") {
			$where1 = ' n.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
			$where2 = ' where n.paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		}
		require(CFG_PATH_DATA . 'dd/currency.php');
		if($export){
		$this->db->open("SELECT m.goods_id,m.add_time,m.goods_sn,m.goods_name,m.SKU,m.cost,m.grade,n.shipping_fee,n.package_fee from ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."category as n on m.cat_id = n.cat_id ".$where.' order by m.goods_id desc');
		}else{
		$this->db->open("SELECT m.goods_id,m.add_time,m.goods_sn,m.goods_name,m.SKU,m.cost,m.grade,n.shipping_fee,n.package_fee from ".CFG_DB_PREFIX."goods as m left join ".CFG_DB_PREFIX."category as n on m.cat_id = n.cat_id ".$where.' order by m.goods_id desc',$from,$to);
		}
		$goods = new ModelGoods();
		$object = new ModelOrder();
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['cost'] = round($rs['cost']/$rate,2);
			$rs['shipping_fee'] = round($rs['shipping_fee']/$rate,2);
			$rs['package_fee'] = round($rs['package_fee']/$rate,2);
			$rs['purchase_qty'] = $this->db->getValue("SELECT sum(m.goods_qty) FROM ".CFG_DB_PREFIX."p_order_goods as m left join ".CFG_DB_PREFIX."p_order as n on m.order_id = n.order_id where m.goods_id ='".$rs['goods_id']."'".($where1?(" AND ".$where1):''));
			$rs['add_time'] = MyDate::transform('date',$info['starttime']);
			$rs['fix_price'] = $goods->getfixprice($rs['goods_id']);
			$goodsqty = $goods->getgoodsqty($rs['goods_id']);
			$rs['valid_qty'] = $goodsqty['goods_qty']- $goodsqty['varstock'];
			$rs['onarrive_qty'] = $this->db->getValue("SELECT sum(goods_qty-arrival_qty-return_qty) FROM ".CFG_DB_PREFIX."p_order_goods where goods_id ='".$rs['goods_id']."' AND order_id in (select order_id FROM ".CFG_DB_PREFIX."p_order where status <> 3)");
			$rs['want_qty'] = $goodsqty['want_qty'];
			$orderinfo = $this->db->getValue("SELECT sum(m.goods_qty) as total_qty,sum(m.goods_qty*m.goods_price*n.rate) as amount from ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id".$where2." AND m.goods_sn ='".$rs['SKU']."'");
			$rs['total_qty'] = $orderinfo['total_qty'];
			$rs['amount'] = floor($orderinfo['amount']);
			$orderlist = $this->db->select("SELECT m.order_id,m.goods_qty,n.currency FROM  ".CFG_DB_PREFIX."order_goods as m left join ".CFG_DB_PREFIX."order as n on m.order_id = n.order_id ".$where2." and m.goods_sn ='".$rs['SKU']."' group by order_id");
			$rs['shippingcost'] =0;
			for($i=0;$i<count($orderlist);$i++){
				$rs['shippingcost'] += $currency[$orderlist[$i]['currency']]*$orderlist[$i]['goods_qty']*($object->getavrshipping($orderlist[$i]['order_id']));
			}	
			$rs['avrprice'] =@($rs['amount']/$rs['total_qty']);
			$rs['interest'] =@floor(($rs['amount']+$rs['shippingcost']-$rs['total_qty']*($rs['cost']+$rs['shipping_fee']+$rs['package_fee']))*100/($rs['total_qty']*($rs['cost']+$rs['shipping_fee']+$rs['package_fee'])));
			$rs['avrprice'] = round($rs['avrprice']/$rate,2);
			$rs['amount'] = round($rs['amount']/$rate,2);
			$rs['shippingcost'] = round($rs['shippingcost']/$rate,2);
			$result[] = $rs;
			unset($rs);
		}
		return $result;
	}
	/**
	*获取RMA月统计列表
	*
	**/
	function getMonthRmaList($info){
		$rma_reason = ModelDd::getArray('rma_reason');
		$this->db->open("SELECT FROM_UNIXTIME(o.shipping_time,'%Y-%m') as month,reason,count(reason) as counts FROM myr_order o,myr_rma r where o.order_id=r.order_id and FROM_UNIXTIME(o.shipping_time,'%Y-%m') between '".$info['starttime']."' and '".$info['totime']."' group by  FROM_UNIXTIME(o.shipping_time,'%Y-%m'),r.reason ORDER BY o.shipping_time,r.reason");
		$re = array();
		while ($rs = $this->db->next()) {
			if($rma_reason[$rs['reason']])
				$rs['error'] =$rma_reason[$rs['reason']].' '.$rs['counts'].'次';
			$re[] = $rs;
		}
		$result = array();
		for($i=0;$i<count($re);$i++){
			if($i!=0 && $re[$i-1]['month'] == $re[$i]['month']){
				$result[count($result)-1]['error']=$result[count($result)-1]['error'].'<br/>'.$re[$i]['error'];
				continue;
			}
			$result[]=$re[$i];
		}
		return $result;
	}
	
	/**
	*获取问题产品RMA统计列表
	**/
	function getRmaList($info){
		$rma_reason = ModelDd::getArray('rma_reason');
		$this->db->open("select og.goods_sn,sum(og.goods_qty) as total FROM myr_order o, myr_order_goods og,myr_rma r where o.order_id=og.order_id and r.goods_sn=og.goods_sn and FROM_UNIXTIME(o.shipping_time,'%Y-%m') ='".$info['starttime']."' group by  FROM_UNIXTIME(o.shipping_time,'%Y-%m'),og.goods_sn");
		while ($rs = $this->db->next()) {
			$total[] = $rs;
		}
		$this->db->open("select r.order_id,r.goods_sn,og.goods_name,r.reason,count(r.reason) as counts,sum(goods_qty) as qty from myr_order o,myr_order_goods og,myr_rma r where o.order_id=og.order_id and r.order_id=og.order_id and r.goods_sn=og.goods_sn and FROM_UNIXTIME(o.shipping_time,'%Y-%m') ='".$info['starttime']."' group by FROM_UNIXTIME(o.shipping_time,'%Y-%m'),og.goods_sn,r.reason");
		while ($rs = $this->db->next()) {
			for($j=0;$j<count($total);$j++){
				if($total[$j]['goods_sn']==$rs['goods_sn']){
					if($rma_reason[$rs['reason']]){
						$rs['error'] =$rma_reason[$rs['reason']].' '.(sprintf("%01.2f",($rs['qty']/$total[$j]['total']))).'%';
					}
				}
			}
			$qty[] = $rs;
		}
		$result = array();
		for($i=0;$i<count($qty);$i++){
			if($i!=0 && $qty[$i-1]['goods_sn'] == $qty[$i]['goods_sn']){
				$result[count($result)-1]['error']=$result[count($result)-1]['error'].'<br/>'.$qty[$i]['error'];
				continue;
			}
			$result[]=$qty[$i];
		}
		return $result;
	}
	
	/**
	*拼接采购统计where
	*/
	function getPickWhere($info)
	{
		$wheres = array();
		$len = 30;
		if($info['totime']){
			$year=intval(substr($info['totime'],0,4));
			switch(intval(substr($info['totime'],5,2))) {
			 case 1: case 3: case 5: case 7: case 8: case 10: case 12:
				$len = 31; 
				break;
			 case 2:  
				if($year%400==0 || ($year%4==0 && $year%100==0 ))
					$len = 29;
				else
					$len = 28;
				break;
			 default:
				break;
			}
		}
		$len =str_pad($len, 2, "0", STR_PAD_LEFT);
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'po.add_time between \''.MyDate::transform('timestamp',$info['starttime'].'-01 00:00:00').'\' and  \''.MyDate::transform('timestamp',$info['totime'].'-'.$len.' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'po.add_time <= \''.MyDate::transform('timestamp',$info['totime'].'-'.$len.' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'po.add_time >= \''.MyDate::transform('timestamp',$info['starttime'].'-01 00:00:00').'\'';
		
		if($info['operator'] <> "" && $info['operator'] <>"0") $wheres[] = 'po.operator_id = \''.$info['operator'].'\'';
		if($info['sku'] <> "") $wheres[] = 'g.SKU= \''.$info['sku'].'\'';
		
		return $wheres?(' and ' . implode(' and ', $wheres)):'';
	}
	
	/**
	*查询时间段采购统计
	*/
	function getPickList($where){
		$this->db->open("select po.supplier_id,s.name as supplier_name,sum(pog.goods_qty) as total_qty,sum(pog.goods_price) as total_price,count(po.order_id)  as counts,sum(pog.arrival_qty) as arrival_qty,sum(pog.return_qty) as return_qty from  myr_p_order po,myr_supplier s,myr_p_order_goods pog,myr_goods g where po.supplier_id=s.id and pog.order_id=po.order_id and g.goods_id=pog.goods_id ".$where." group by po.supplier_id ORDER BY total_qty  DESC");
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	
	
	/**
	*拼接分仓调拨统计where
	*/
	function getAllocationWhere($info)
	{
		$wheres = array();
		if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'a.add_time between \''.MyDate::transform('timestamp',$info['starttime'].' 00:00:00').'\' and  \''.MyDate::transform('timestamp',$info['totime'].' 23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'a.add_time <= \''.MyDate::transform('timestamp',$info['totime'].' 23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'a.add_time >= \''.MyDate::transform('timestamp',$info['starttime'].' 00:00:00').'\'';
		
		if($info['first_shipping'] <> "" && $info['first_shipping'] <>"-1") $wheres[] = ' a.first_shipping=\''.$info['first_shipping'].'\'';
		if($info['db_shipping'] <> "" && $info['db_shipping'] <>"-1") $wheres[] = ' a.db_shipping=\''.$info['db_shipping'].'\'';
		if($info['depot_id_from'] <> "" && $info['depot_id_from'] <>"-1") $wheres[] = ' a.depot_id_from=\''.$info['depot_id_from'].'\'';
		if($info['depot_id_to'] <> "" && $info['depot_id_to'] <>"-1") $wheres[] = ' a.depot_id_to=\''.$info['depot_id_to'].'\'';
		
		return $wheres?(' and ' . implode(' and ', $wheres)):'';
	}
	
	
	/**
	*查询时间段分仓调拨统计
	*/
	function getAllocationList($where){
		$this->db->open("select sum(y.total_qty) as total_qty,sum(y.weight)  as total_weight,sum(y.count)   as total_count,count(y.order_id) as counts from (select sum(ad.goods_qty) as total_qty,a.weight,a.count,a.order_id from myr_allocation a,myr_allocation_detail ad where a.order_id=ad.order_id ".$where." group by a.order_id) y");
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	*热销产品
	*/
	function getHotGoodsSales($info)
	{
		$sql='SELECT count( og.rec_id ) as good_gross,og.goods_sn FROM '.CFG_DB_PREFIX . 'order g, '.CFG_DB_PREFIX.'order_goods og WHERE g.order_id = og.order_id '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY og.goods_sn order by good_gross desc LIMIT 0 , '.(empty($info['limit'])?5:$info['limit']);
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	/**
	*热销账户
	*/
	function getHotShop($info)
	{
		$sql='SELECT count( order_id ) as good_gross,Sales_account_id FROM '.CFG_DB_PREFIX . 'order WHERE  paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime']).' GROUP BY Sales_account_id order by good_gross desc LIMIT 0 , '.(empty($info['limit'])?5:$info['limit']);
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['account_name'] = ModelDd::getCaption('allaccount',$rs['Sales_account_id']);
			$list[] = $rs;
		}
		return $list;
	}
	/**
	*月销售额
	*/
	function getMonthSales($info)
	{
		$sql='SELECT sum(order_amount*RATE) as order_sale,FROM_UNIXTIME(paid_time,\'%Y-%m\') as yuefei FROM '.CFG_DB_PREFIX . 'order where paid_time>0 '.(empty($info['Sales_account'])?'':'and Sales_account_id='.$info['Sales_account']).' and FROM_UNIXTIME(paid_time,\'%Y-%m\') between \''.$info['starttime'].'\' and \''.$info['endtime'].'\' group by  yuefei ORDER BY paid_time DESC';
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
	/**
	*日销售额
	*/		
	function getDaySales($info)
	{
		$sql='SELECT sum(order_amount*RATE) as order_sale,FROM_UNIXTIME(paid_time,\'%Y-%m-%d\') as paid_time FROM '.CFG_DB_PREFIX . 'order where paid_time >0  '.(($info['Sales_account']==0)?'':'and Sales_account_id='.$info['Sales_account']).' and paid_time between '.strtotime($info['starttime']).' and '.strtotime($info['endtime'].' 23:59:59').' group by  paid_time';
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
	/**
	*订单个数比
	*/	
	function orderGoodsRate($from,$to,$where=null)
	{
		$sql='select qty,count(qty) counts from (select count(og.rec_id) qty FROM '.CFG_DB_PREFIX.'order_goods og left join '.CFG_DB_PREFIX . 'order o on og.order_id =o.order_id '.$where.' GROUP BY og.order_id ) y GROUP BY qty order by counts desc';
		if($to){
			$this->db->open($sql,$from,$to);
		}else{
			$this->db->open($sql);
		}
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	/**
	*订单个数比where
	*/	
	function orderGoodsRateWhere($info){
		$wheres = array();
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getTableCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.$where);
	}
	
	/**
	 *销售国家list
	 */
	function getCountryStat($from,$to,$where)
	{
		$sql='SELECT sum(distinct order_amount*RATE) as money,country FROM '.CFG_DB_PREFIX.'order'.$where.' GROUP BY country order by money desc';
		if($from && $to)
			$this->db->open($sql,$from,$to);
		else
			$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['money']=round($rs['money'],2);
			$list[] = $rs;
		}
		return $list;
	}
	/**
	 *销售国家count
	 */
	function getCountryStatCount($where)
	{
		return $this->db->getValue("select count(*) from (SELECT count(country) FROM ".CFG_DB_PREFIX.'order'.$where.' GROUP BY country ) y');	
	}
	/**
	 *销售国家where
	 */
	function CountryStatWhere($info){
		$wheres = array();
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['endtime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['endtime'] <> '' && $info['starttime'] == '') $wheres[] = 'paid_time < \''.MyDate::transform('timestamp',substr($info['endtime'],0,11).'23:59:59').'\'';
		if($info['endtime'] == "" && $info['starttime'] <> '') $wheres[] = 'paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}	
	/**
	 * 订单情况统计
	 *
	 */
		
	function getOrderCircs($where){
		$sql="select paid_times,count(order_id) counts,sum(qty) qtys from (select og.order_id, FROM_UNIXTIME(o.paid_time,'%Y-%m-%d') as paid_times,count(og.rec_id) qty FROM  ".CFG_DB_PREFIX."order o LEFT JOIN ".CFG_DB_PREFIX."order_goods og on og.order_id =o.order_id ".$where." GROUP BY og.order_id) y GROUP BY paid_times order by paid_times desc";
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function OrderCircsWhere($info){
		$wheres = array();
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	/**
	 * 订单区间查询
	 *
	 */
	function GetOrderinterzone($interzones,$where=null)
	{
		$list=array();
		foreach($interzones as $key=>$val)
		{
			$interzone=0;
			$having=' having money';
			if($key==0){
				$interzone='0-'.$val;
				$having.='<='.$val;
			}elseif($key==count($interzones)-1){
				$interzone=($val-1).'以上';
				$having.='>='.$val;
			}else{
				$interzone=$interzones[$key-1].'-'.$val;
				$having.='>'.$interzones[$key-1].' and money<='.$val;
			}
			$list[]=array('interzone'=>$interzone,'counts'=>$this->db->getValue('select count(*) from (SELECT order_amount*RATE as money FROM '.CFG_DB_PREFIX.'order'.$where.$having.' order by money ) y'));
		}
		return $list;
	}
	function OrderinterzoneWhere($info){
		$wheres = array();
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	/**
	 * 客户购买排名
	 * @param int $from
	 * @param int $to
	 */
	function getBuytimes($from,$to,$where=null)
	{
		
		$sql='SELECT count(order_id) as order_count,userid FROM '.CFG_DB_PREFIX.'order'.$where.' group by userid order by order_count DESC';
		if($from && $to)
			$this->db->open($sql,$from,$to);
		else
			$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function getBuytimesWhere($info){
		$wheres = array();
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getBuytimesCount($where){
		return $this->db->getValue('SELECT count(*) from (SELECT count(*) FROM '.CFG_DB_PREFIX.'order'.$where.' group by userid) t');
	}
	
	/**
	*单商品报表
	*/		
	function getOneGoodsReport($from,$to,$where=null)
	{
		$sql='SELECT sum(og.goods_qty) as goods_sale,FROM_UNIXTIME(add_time,\'%Y-%m-%d\') as add_time,og.goods_price*g.RATE  goods_price FROM '.CFG_DB_PREFIX.'order'.' g,'.CFG_DB_PREFIX.'order_goods og'.$where.' group by  FROM_UNIXTIME(add_time,\'%Y-%m-%d\') order by add_time desc';
		if($from && $to)
			$this->db->open($sql,$from,$to);
		else
			$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['goods_price']=round($rs['goods_price'],2);
			$list[] = $rs;
		}
		return $list;
	}
	function getOneGoodsReportWhere($info){
		$wheres = array();
		if ($info['goods_sn'] && $info['goods_sn']<> '')	$wheres[] = 'og.goods_sn=\''.$info['goods_sn'].'\'';		
		if ($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') $wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';	
	}
	function getOneGoodsReportCount($where){
		return $this->db->getValue('SELECT count(*) from(SELECT count(*) FROM '.CFG_DB_PREFIX.'order'.' g,'.CFG_DB_PREFIX.'order_goods og '.$where.' group by  FROM_UNIXTIME(add_time,\'%Y-%m-%d\')) t');
	}
	
	
	/**
	 * 利润率区间
	 * @param int $from
	 * @param int $to
	 */
	function getProfitinterzone($from,$to,$where=null)
	{
		$sql='SELECT sum(og.goods_price*og.goods_qty*o.RATE) as money,sum(og.goods_qty) as counts,FROM_UNIXTIME(o.add_time,\'%Y-%m-%d\') as times,og.goods_sn,g.cost*og.goods_qty as cost,sum(og.goods_price*o.RATE-cost)*og.goods_qty as profit FROM '.CFG_DB_PREFIX.'order_goods og left join '.CFG_DB_PREFIX.'order o  on o.order_id=og.order_id  left join '.CFG_DB_PREFIX.'goods g on g.goods_sn=og.goods_sn '.$where.' group by og.goods_sn,times order by times desc,counts desc';
		if($from && $to)
			$this->db->open($sql,$from,$to);
		else
			$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['money']=round($rs['money'],2);
			$rs['profit']=round($rs['profit'],2);
			$list[] = $rs;
		}
		return $list;
	}
	function getProfitinterzoneWhere($info){
		if($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'o.Sales_account_id=\''.$info['Sales_account'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '')
			$wheres[] = 'o.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'o.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'o.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		elseif(($info['totime'] || $info['totime'] == '') && ($info['starttime'] || $info['starttime'] ==''))
			$wheres[] = 'o.add_time between \''.MyDate::transform('timestamp',date("Y-m-d H:i:s",CFG_TIME)).'\' and  \''.MyDate::transform('timestamp',date("Y-m-d",CFG_TIME).'23:59:59').'\'';
			
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getProfitinterzoneCount($where){
		return $this->db->getValue('SELECT count(*) from (SELECT FROM_UNIXTIME(o.add_time,\'%Y-%m-%d\') as times,count(*) as counts FROM '.CFG_DB_PREFIX.'order_goods og left join '.CFG_DB_PREFIX.'order o  on o.order_id=og.order_id  left join '.CFG_DB_PREFIX.'goods g on g.goods_sn=og.goods_sn '.$where.' group by og.goods_sn,times) y');
	}	
	
	
	/**
	 * 商品分类销售
	 * @param int $from
	 * @param int $to
	 */
	function getGoodsTypeSale($from,$to,$where)
	{
		$sql='SELECT FROM_UNIXTIME(o.add_time,\'%Y-%m-%d\') as times,sum(og.goods_qty) as goods_sale,sum(og.goods_price*o.RATE) as goods_price,sum(g.cost) as costs,sum(og.goods_price*o.RATE-g.cost) as profit FROM myr_order_goods og left join myr_order o on o.order_id = og.order_id left join myr_goods g on g.goods_sn=og.goods_sn '.$where.' GROUP BY times order by times desc,goods_sale desc';	
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['goods_price']=round($rs['goods_price'],2);
			$rs['profit']=round($rs['profit'],2);
			$list[] = $rs;
		}
		return $list;
	}
	function getGoodsTypeSaleWhere($info){
		$wheres = array();
		if($info['Sales_account'] != 0 && $info['Sales_account']<> '') $wheres[] = 'o.Sales_account_id=\''.$info['Sales_account'].'\'';
		if ($info['goods_sn'] && $info['goods_sn']<> '') $wheres[] = 'og.goods_sn=\''.$info['goods_sn'].'\'';
		if ($info['cat_id'] && $info['cat_id']<> '') $wheres[] = 'g.cat_id=\''.$info['cat_id'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '')
			$wheres[] = 'o.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'o.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'o.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getGoodsTypeSaleCount($where){
		return $this->db->getValue('select count(*) from(SELECT count(*) FROM myr_order_goods og left join myr_order o on(o.order_id = og.order_id) left join myr_goods g on(g.SKU=og.goods_sn) '.$where.' GROUP BY FROM_UNIXTIME(o.add_time,\'%Y-%m-%d\')) t');
	}
	/**
	*销售账户排行榜
	**/
	function getSalesByAccountWhere($info){
		$wheres = array();
		if($info['totime'] <> '' && $info['starttime'] <> '')
			$wheres[] = 'paid_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'paid_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		elseif($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'paid_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getSalesByAccount($where){
		$sql='SELECT Sales_account_id,sum(order_amount*RATE) as order_sale FROM '.CFG_DB_PREFIX.'order '.$where.' group by Sales_account_id ORDER BY order_sale DESC';	
		$this->db->open($sql);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['order_sale'] = round($rs['order_sale'],2);
			$rs['account_name'] = ModelDd::getCaption('allaccount',$rs['Sales_account_id']);
			$list[] = $rs;
		}
		$allaccount=ModelDd::getArray('allaccount');
		foreach($allaccount as $k=>$v){
			$boo=true;
			for($j=0;$j<count($list);$j++){
				if($k==$list[$j]['Sales_account_id']){
					$boo=false;
				}
			}
			if($boo){
				$list[$j]=array('Sales_account_id'=>$k,'account_name'=>$v,'order_sale'=>0);
			}
		}
		return $list;
	}
	
}
?>