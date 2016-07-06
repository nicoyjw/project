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
 * 公告
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelMain extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'menu';
	}


	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList()
	{
		$this->db->open('select * FROM '.$this->tableName);
		$trees = array();
		while ($rs = $this->db->next()) {
			$trees[$rs['root']][] = array('id'=>$rs['id'],'text'=>$rs['text'],'leaf'=>(($rs['leaf']==1)?true:false), 'cls'=>$rs['cls'],'model'=>$rs['model'],'action'=>$rs['action']);
		}
		return $trees;
	}
	function getreportwhere($info)
	{
		$wheres = array();
		if($info['type'] == 1) $wheres[] = "ReportType in ('_GET_FLAT_FILE_ORDERS_DATA_','_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_','_GET_FLAT_FILE_ACTIONABLE_ORDER_DATA_')";
		if($info['type'] == 2) $wheres[] = "ReportType in ('_GET_MERCHANT_LISTINGS_DATA_','_GET_MERCHANT_LISTINGS_DATA_LITE_')";
		if($info['account']) $wheres[] = "account_id=".$info['account'];
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	function getreportList($from,$to,$where)
	{
		$this->db->open("SELECT * FROM ".CFG_DB_PREFIX."amazon_report".$where." order by AvailableDate desc",$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$rs['account_id'] = ModelDd::getCaption('amazonaccount',$rs['account_id']);
			$rs['ReportType'] = ModelDd::getCaption('amazon_type',$rs['ReportType']);
			$rs['AvailableDate'] = MyDate::transform('standard',$rs['AvailableDate']);
			$list[] = $rs;
		}
		return $list;
	}
	function getreportCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."amazon_report".$where);
	}
	function delshipping(){
		$this->db->execute('delete from '.CFG_DB_PREFIX .'dd_item where dd_id = 1');
	}
	function delorderprint(){
		$this->db->execute('delete from '.CFG_DB_PREFIX .'dd_item where dd_id = 18');
	} 
    function getTrackinfoList($from,$to,$where='')
    {
        $allaccount = ModelDd::getArray('allaccount');
        $shipping = ModelDd::getArray('shipping');
        $this->db->open("SELECT t.*,o.order_sn,o.track_no,o.end_time,o.paypalid,o.consignee,o.Sales_account_id,o.userid,o.shipping_id,o.Sales_channels,o.email,o.street1,o.street2,o.city,o.state,o.country,o.zipcode,o.tel,o.ShippingService FROM ".CFG_DB_PREFIX."trackinfo as t left join ".CFG_DB_PREFIX."order as o on t.order_id = o.order_id".$where,$from,$to);
        $list = array();
        while ($rs = $this->db->next()) {
            $rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
            $rs['end_time'] = date('Y-m-d',$rs['end_time']);
            $rs['Sales_account_id'] = $allaccount[$rs['Sales_account_id']];
            $rs['shipping_id'] = $shipping[$rs['shipping_id']];
            $list[] = $rs;
        }
        return $list;
    }
    /**
     * 总数
     * @param string $where 条件
     * @return int
     */
    function getTrackCount($where=null) {
        return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."trackinfo as t left join ".CFG_DB_PREFIX."order as o on t.order_id = o.order_id".$where);
    }


    /**
     * 生成查询条件
     * @param array $info
     * @return string
     */
    function getTrackWhere($info,$status=null,$sort=null) {
        specConvert($info,array('keyword'));
        $wheres = array();
        $status = array(
            0 => '暂无信息',
            1 => '运输途中',
            2 => '到达待取',
            3 => '成功签收',
            4 => '物件退回',
            5 => '运往当地',
        );
        if ($info['keyword']) {
             $wheres[] = '(o.order_sn=\''.substr($info['keyword'],strlen(CFG_ORDER_PREFIX)).'\' or o.country=\''.$info['keyword'].'\' or o.userid like \'%'.$info['keyword'].'%\'  or o.paypalid=\''.$info['keyword'].'\' or o.track_no=\''.$info['keyword'].'\' or o.sellsrecord=\''.$info['keyword'].'\')';
        }else{
            if (isset($info['account']) &&  $info['account'] !== 0) {
                $wheres[] = 'o.Sales_account_id=\''.$info['account'].'\'';
            }
            if(isset($info['status']) &&  $info['status'] !== 'all'){
                $wheres[] = 't.status = \''.$status[$info['status']].'\'';        
            }
        }    
        $where = '';
        if ($wheres) {
            $where = ' where ' . implode(' and ', $wheres);
        }
        return $where;    
    }
}
?>