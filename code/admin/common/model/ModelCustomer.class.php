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
 * 客户管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */

class ModelCustomer extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'customer';
		$this->logtableName = CFG_DB_PREFIX . 'customer_log';
		$this->notetableName = CFG_DB_PREFIX . 'customer_note';
	}

	/**
	 * 保存记录
	 *
	 * @param array $arr
	 */
	public function save($arr)
	{
		if (!$arr['customer_id']) {
			$this->db->insert($this->tableName,$arr);
		} else {
			$this->db->update($this->tableName,$arr,'customer_id='.intval($arr['customer_id']));
		}
	}
	/**
	 * 设黑名单
	 *
	 * @param array $arr
	 */
	public function setBlackList()
	{
		if(!(isset($_GET['email'])&&!empty($_GET['email']))) return false;
		$domain_name='www.'.substr(strrchr(trim($_GET['email']),'@'),1);
		//echo $domain_name;exit;
		if (!$this->check_domain_name($domain_name)){
			$arr['domain_name']=$domain_name;
			$arr['addtime']=CFG_TIME;
			$this->db->insert(CFG_DB_PREFIX.'blacklist',$arr);
		}
	}
	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to,$whstr)
	{
		$this->db->open('SELECT *
			FROM '.$this->tableName.' '.$whstr.' ORDER BY last_buy_time DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$rs['last_buy_time'] = MyDate::transform('date',$rs['last_buy_time']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 取条件
	 *
	 * @param int $val
	 */	
	function getListWhStr($val){
		return ' WHERE userid=\''.trim($val).'\''.' or email=\''.trim($val).'\''.' or consignee=\''.trim($val).'\'';
	}
	
	/**
	 * get CustomerOrder
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getCustomerOrderList($from,$to)
	{
		if(isset($_POST['email'])&&!empty($_POST['email'])){
		$whstr='WHERE email=\''.trim($_POST['email']).'\'';
		}else
		$whstr='';
		$flds='order_id,order_sn,order_amount,paid_time,add_time,end_time,shipping_time,RATE';
		$this->db->open('SELECT '.$flds.' FROM '.CFG_DB_PREFIX.'order '.$whstr.' ORDER BY add_time DESC',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
			$rs['paid_time'] = MyDate::transform('date',$rs['paid_time']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['end_time'] = MyDate::transform('date',$rs['end_time']);
			$rs['shipping_time'] = MyDate::transform('date',$rs['shipping_time']);
			$result[] = $rs;
		}
		return $result;
	}	
	/***********
	&
	&更新客户
	&
	************/
	function update_customer($order_id,$crawll_count)
	{
		$log=$this->db->getValue('SELECT order_id,crawll_count FROM '.$this->logtableName);
		if($log){
			$this->db->execute("DROP TABLE IF EXISTS `tmp_table`");
			$this->db->execute("CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_table`(buy_degree  mediumint(8) unsigned NOT NULL DEFAULT '0',buy_sum_money mediumint(8) unsigned NOT NULL DEFAULT '0',last_buy_time int(10) unsigned NOT NULL DEFAULT '0',`email` varchar(100) NOT NULL) TYPE = HEAP");
			$this->db->execute("INSERT INTO `tmp_table`(`buy_degree`, `buy_sum_money`, `last_buy_time`,`email`) SELECT count(order_id),sum(order_amount*RATE),paid_time,email FROM ".CFG_DB_PREFIX."order where email !='' and order_id>".$log['order_id']." and email in(select `myr_customer`.`email` from ".$this->tableName.") group by email order by paid_time desc;");
			$this->db->execute("UPDATE ".$this->tableName." as m,`tmp_table` as n SET  m.buy_degree= m.buy_degree+n.buy_degree,m.buy_sum_money= m.buy_sum_money+n.buy_sum_money,m.last_buy_time= n.last_buy_time WHERE  m.email = n.email");
			$this->db->execute("INSERT INTO ".$this->tableName." (`buy_degree`,`buy_sum_money`,`email`,`userid`,`tel`,`consignee`,`last_buy_time`) SELECT count(order_id),sum(order_amount*RATE),email,userid,tel,consignee,paid_time FROM ".CFG_DB_PREFIX."order where email !='' AND order_id>".$log['order_id']." AND email NOT IN(SELECT `email` FROM ".$this->tableName.") GROUP BY email ORDER BY paid_time DESC");
			$order_id=$this->db->getValue('select max(order_id) FROM '.CFG_DB_PREFIX.'order');
			$this->db->execute('UPDATE '.$this->logtableName.' set `order_id`='.$order_id.', `crawll_count`=`crawll_count`+1,`addtime`='.CFG_TIME);
		}else{
			$result=$this->db->execute("INSERT INTO ".$this->tableName." (`buy_degree`,`buy_sum_money`,`email`,`userid`,`tel`,`consignee`,`last_buy_time`) SELECT count(order_id),sum(order_amount*RATE),`email`,`userid`,`tel`,`consignee`,`paid_time` FROM ".CFG_DB_PREFIX."order where `email` !='' GROUP BY `email` ORDER BY `paid_time` DESC");
			if($result){
			 $order_id=$this->db->getValue('select max(order_id) FROM '.CFG_DB_PREFIX.'order');
			 $this->db->execute('INSERT INTO '.$this->logtableName.' (`order_id`, `crawll_count`,`addtime`) VALUES (\''.$order_id.'\', 1,'.CFG_TIME.')');
			}
		}
	}
	function check_domain_name($val){
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."blacklist where domain_name = '".$val."'")>0){
		return true;
		}else{
		return false;
		}
	}
	function get_order_id($sn){
		return $this->db->getValue('select order_id FROM '.CFG_DB_PREFIX.'order where order_sn=\''.$sn.'\'');
	}
	
	function addnote($info)
	{
		$info['addtime']=CFG_TIME;
		if (!$info['id']) {
			$this->db->insert($this->notetableName,$info);
		} else {
			$this->db->update($this->notetableName,$info,'id='.intval($info['id']));
		}
	}
	function getNoteList($from,$to)
	{
		if(isset($_GET['id'])){
		$whstr='WHERE customer_id=\''.trim($_GET['id']).'\'';
		}else
		return false;
		$this->db->open('SELECT * FROM '.$this->notetableName.' '.$whstr.' ORDER BY customer_note_id DESC',$from,$to);
			
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$rs['manage_user'] = 'admin';
			$result[] = $rs;
		}
		
		return $result;
	}
}
?>