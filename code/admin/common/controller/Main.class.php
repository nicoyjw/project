<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @package Common
 * @version v0.1
 */
class Main extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= 'ERP';
		$commName = ModelSystem::get('com_name');
		if ($commName) {
			$this->title .= ' - '.$commName;
		}
		$this->name = 'main';
	}
	/**
	 * 登录界面
	 */
	function actionIndex() {
		$object = new ModelOrder;
		$status1 = '111';//等待校对
		$news = new ModelNews();
		$this->tpl->assign('news',$news->getNewslist(5));
		$status2 = $object->getorderflow(1,2);//客服审核
		$status3 = $object->getorderflow(2,2);//库管审核
		$status4 = $object->getorderflow(3,2);//等待处理
		$status5 = $object->getorderflow(9,2);//手动标记缺货的
		$status6 = $object->getorderflow(8,2);//等待拣货
		$status7 = $object->getorderflow(17,2);//已发货 等待买家收货
		for($i=1;$i<=7;$i++){
			$where = $object->getWhere($_REQUEST,${'status'.$i});
			$this->tpl->assign('num'.$i,$object->getOrderCount($where));
		}
		$_REQUEST['end_time1'] =  date('Y-m-d');
		$shippinglist = ModelDd::getArray('shipping');
		foreach($shippinglist as $k=>$v){
			if($k !== 0){
				$_REQUEST['shipping'] = $k;
				$where = $object->getWhere($_REQUEST,$status7);
				$ship['name'] = addslashes($v);
				$ship['num'] = $object->getOrderCount($where);
				if($ship['num'] >0) $shippingnum[] = $ship;
			}
		}
		require(CFG_PATH_CONF.'tree.cfg_'.$_SESSION['admin_id'].'.php');
        
        
        $logo_img = '';
        $html = '';
        if($_SESSION['company'] == 'hkamazon'){
            $logo_img = ' height="125px" src="themes/default/images/logo_hkzmazon_1.png" style="margin:-15px 0 0 0;float:left;vertical-align:top;"';
            $html = '';
        }else{
            $logo_img = '  height="85px" src="themes/default/images/LOGO.png" style="margin:2px 0;float:left;vertical-align:top;"';
        }
        $this->tpl->assign('logo_img',$logo_img);
		$trees = $trees['root'];
		$this->tpl->assign('trees',$trees);
		$_REQUEST['shipping'] = 0;
		$where = $object->getWhere($_REQUEST,$status7);
		$ship['name'] = '总计';
		$ship['num'] = $object->getOrderCount($where);
		$shippingnum[] = $ship;
		$user = new ModelUser();
		$this->tpl->assign('kucun',!$user->getkucun() ? 0 : $user->getkucun());
		$this->tpl->assign('account',ModelDd::getComboData('allaccount'));
		$this->tpl->assign('hasshipping',ModelDd::getComboData('shipping'));
		$this->tpl->assign('last_login',date('Y-m-d H:i:s',$user->getLasttime()));
        $this->tpl->assign('shipping',ModelDd::arrayFormat($this->getShipping()));
        
       /* $track = $object->gettrackCount();
        if($track==false){
            $track['Notfound'] = 0;
            $track['Shipment'] = 0;
            $track['Arrived'] = 0;
            $track['Delivered'] = 0;
            $track['Returned'] = 0;
            $track['Overseas'] = 0;
            $track['date'] = date('Y-m-d',time());
        }*/
        $track = array();
		$this->tpl->assign('track',$track);
        $this->tpl->assign('shippingnum',$shippingnum);
		$this->show();
	}
	function getShipping(){
		return array (
		  1 => 'EMS',
		  2 => 'e邮宝',
		  4 => 'UPS',
		  0 => '未定义',
		  6 => 'FedEx',
		  8 => 'TNT',
		  9 => '香港邮政小包（挂号）',
		  10 => '香港邮政小包（平邮）',
		  3 => 'USPS',
		  5 => '线下E邮宝',
		  7 => 'DHL',
		  11 => '中国邮政小包(平邮)',
		  12 => '中国邮政小包(挂号)',
		  13 => '瑞士邮政小包（平邮）',
		  14 => '瑞士邮政小包（挂号）',
		  15 => '新加坡邮政小包(挂号)',
		  16 => '新加坡邮政小包(平邮)',
		  17 => '英国邮政小包（挂号）',
		  18 => '英国邮政小包（平邮）',
		);
	}
	/**
	 * 取子目录
	 *
	 */
	function actionTree() {
		require(CFG_PATH_CONF.'tree.cfg_'.$_SESSION['admin_id'].'.php');
		$result = $trees[$_REQUEST['node']];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 取子目录
	 *
	 */
	function actionTreeson() {
        require(CFG_PATH_CONF.'tree.cfg_'.$_SESSION['admin_id'].'.php'); 
        $tree_arr = $trees[$_REQUEST['node']];
                                               
        require(CFG_PATH_LIB.'util/JSON.php');
        
        $json = new Services_JSON();
        
        echo $json->encode($tree_arr);exit;        
	} 
	function actionTrackDetail(){
        $status = array(
            0 => '暂无信息',
            1 => '运输途中',
            2 => '到达待取',
            3 => '成功签收',
            4 => '物件退回',
            5 => '运往当地',
        ); 
        $this->dir = "system";
        $this->tpl->assign('status',ModelDd::arrayFormat($status));
        $this->name = 'trackinfo';
        $this->show();
    }
    function actiongetTrackingInfo(){         
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelMain();
        $where = '';                    
        $where = $object->getTrackWhere($_REQUEST,$pageLimit['sort']);              
        $list = $object->getTrackinfoList($pageLimit['from'],$pageLimit['to'],$where);
        $result['totalCount'] = $object->getTrackCount($where); 
        $result['topics'] = $list;
        echo $json->encode($result);
    }
}	
?>