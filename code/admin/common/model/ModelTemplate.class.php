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
 * 模板类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelTemplate extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'template';
		$this->primaryKey = 'rec_id';
	}
	

	/**
	 * 保存brand
	 *
	 * @param 对象ID $id
	 * @param 模块 $p_root_id,$p_name
	 */
	function save($info)
	{
		if (empty($info['rec_id'])) {
			try{
			$this->db->insert($this->tableName,array(
				'cat_id' => $info['cat_id'],
				'temp_name' => $info['temp_name'],
				'temp_sn' => $info['temp_sn'],
				'temp_content' => $info['temp_content']
				));
			} catch (Exception $e) {
						throw new Exception('新增模板失败','601');exit();
			}
		} else {
			try{
			$this->db->update($this->tableName,array(
				'temp_name' => $info['temp_name'],
				'temp_sn' => $info['temp_sn'],
				'temp_content' => $info['temp_content']
				),'rec_id='.intval($info['rec_id']));
			} catch (Exception $e) {
						throw new Exception('编辑模板失败','602');exit();
			}
		}
		ModelDd::cacheTemplate();
	}	
	function getList($from,$to,$where=null){
		$this->db->open("SELECT * FROM ".$this->tableName.$where.' order by temp_sn',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	function getContent($id,$order_id=0,$mid=0)
	{
		$content = $this->db->getValue("SELECT temp_content FROM ".$this->tableName." WHERE ".$this->primaryKey."=".$id);
		if($mid > 0 && $order_id == 0){
		$data = $this->db->getValue('SELECT messageid,accountid,SenderID,itemid,answer FROM '.CFG_DB_PREFIX . 'ebaymessage where id ='.$mid);
		$order_id = $this->db->getValue("SELECT m.order_id FROM ".CFG_DB_PREFIX."order as m left join ".CFG_DB_PREFIX."order_goods as n on m.order_id = n.order_id where m.Sales_account_id = '".$data['accountid']."' and n.item_no = '".$data['itemid']."' and m.userid = '".$data['SenderID']."' order by m.order_id desc");
		}
		$content = $this->replacecontent($content,$order_id);
		return $content;
	}
	function getOrderIdByPaypalid($paypalid){
        return $this->db->getValue("SELECT order_id FROM ".CFG_DB_PREFIX."order WHERE paypalid =".$paypalid);    
    }
	function replacecontent($content,$order_id=0)
	{
		if($order_id != 0){
			$order = new ModelOrder();
			$order_info = $order->order_info($order_id);
			$content = str_replace('{BuyerName}',$order_info['consignee'],$content);
			$content = str_replace('{BUYERID}',$order_info['userid'],$content);
			$content = str_replace('{SELLERID}',$order_info['sellerID'],$content);
			$content = str_replace('{admin_user}',$_SESSION['admin_name'],$content);
			$content = str_replace('{Shippingaddress}',$order_info['street1'].' '.$order_info['street2'].','.$order_info['state'].','.$order_info['city'].','.$order_info['country'],$content);
			$content = str_replace('{PaidDate}',MyDate::transform('standard',$order_info['paid_time']),$content);
			$content = str_replace('{ShipDate}',MyDate::transform('standard',$order_info['shipping_time']),$content);
			$content = str_replace('{Amount}',$order_info['currency'].$order_info['order_amount'],$content);
			$content = str_replace('{Track_no}',$order_info['track_no'],$content);
			$goods = $order->order_goods_info($order_id,0);
			$modelgoods = new ModelGoods();
			$goods_info ='';
			$goods_info1 ='';
			$no_info = '';
			for($i = 0;$i<count($goods);$i++){
				$info = '';
				if($i != 0 ) {
					$goods_info .= ' , ';
				}
					$info .= $goods[$i]['item_no'];
					$info .= '/';
					$info .= $goods[$i]['goods_sn'];	
					$info .= '/';
					$info .= $goods[$i]['goods_name'];	
					$info .= '/';
					$info .= $goods[$i]['goods_price'];	
					$info .= '/';
					$info .= $goods[$i]['goods_qty'];
				$goods_info .= $info;
			}
			$content = str_replace('{ITEMNOLIST}',$no_info,$content);
			}
		return $content;
	}
	/*********
	*保存订单导出模版字段
	*********/
	function saveorder($column)
	{
		$fileds = explode(",",$column);
		$order_field = ModelDd::getArray('order_field');
		for($i=0;$i<count($fileds);$i++){
			$array[$fileds[$i]] = $order_field[$fileds[$i]];
		}
		$fp = fopen(CFG_PATH_DATA . 'dd/orderexport.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
}

?>