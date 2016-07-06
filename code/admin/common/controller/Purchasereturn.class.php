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
 * 采购退货
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Purchasereturn extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '采购退货';
		$this->name = 'Purchasereturn';
		$this->dir = 'purchase';
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_p_return');
		$this->show();
	}

	/************
	&&&&&新增采购退货
	
	************/

	function actionAdd() {
		$this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
		$this->tpl->assign('order_status',ModelDd::getComboData('o_status'));
		$from = '';
		if($_GET['type']) $from = 'type='.$_GET['type'].'&order_id='.$_GET['id'];
		$this->tpl->assign('from',$from);
		$object = new ModelPurchasereturn();
		if($_GET['order_id']){
			$rs = $object->order_info($_GET['order_id']);
		}else{
			$rs = array(
					"order_id" => "",
					"order_sn" => "",
					"supplier" => '',
					"supplier_name" => '',
					"operator_id" => $_SESSION['admin_id'],
					"status" => 0
					);
			$Purchaseorder = new ModelPurchaseorder();
			$info = $Purchaseorder->order_info($_GET['id']);
			$rs['relate_order_sn'] = CFG_P_ORDER_PREFIX.$info['order_sn'];
			$rs['supplier_id'] = $info['supplier_id'];
			$rs['supplier_name'] = $info['supplier_name'];
			$rs['order_sn'] = $object->get_order_sn();
		}
		$rs['order_sn'] = CFG_P_RETURN_PREFIX.$rs['order_sn'];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($rs);
		$this->tpl->assign('order',$order); 
		$this->name = 'returnAdd';
		$this->show();
	}
	
	/**
	 * 退货单保存
	 */
	function actionSave(){
		set_time_limit(0);
		$object = new ModelPurchasereturn();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $goods){
			$goods->goods_name = addslashes_deep($goods->goods_name);
			if($goods->goods_name == "" || $goods->goods_sn == "") {
			echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
			}
			$goods->remark = addslashes_deep($goods->remark);
		}
		$_POST['data'] = $goodsarr;
		try{
			$msg = $object->save($_POST);
			echo "{success:true,msg:'$msg'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**
	 * 获得退货单产品明细
	 */
	function actionGetgoods(){
			if(!$_GET['order_id']&&!$_POST['order_id']) return;
			if($_GET['type']=='cgth'){
			$Purchaseorder = new ModelPurchaseorder();
			$list = $Purchaseorder->goods_info('','',$_GET['order_id']);
			$info = $Purchaseorder->order_info($_GET['order_id']);
			for($i=0;$i<count($list);$i++){
					$list[$i]['goods_qty'] = $list[$i]['goods_qty'] - $list[$i]['arrival_qty'] - $list[$i]['return_qty'];
					if($list[$i]['goods_qty'] <= 0 ) unset($list[$i]);
				}
			$result['topics'] = $list;
			$result['totalCount'] = $Purchaseorder->getgoodsCount($_GET['order_id']);
				}else{
			$pageLimit = getPageLimit();
			$object = new ModelPurchasereturn();
			$result['totalCount'] = $object->getgoodsCount($_POST['order_id']);
			if($pageLimit['to'] == 30) $pageLimit['to'] = $result['totalCount'];
			$list = $object->goods_info($pageLimit['from'],$pageLimit['to'],$_POST['order_id']);
			$result['topics'] = $list;
				}
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	
	/**
	 * 删除退货单产品
	 */
	function actionDelgoods(){
		$object = new ModelPurchasereturn();
		try{
			$Stockin->object($_GET['id']);
			echo "{success:true,msg:'操作成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**
	 * 更改退货单状态
	 */
	function actionUpdate() {
			$object = new ModelPurchasereturn();
			try {
					$object->update($_GET);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}

	/**
	 * 获得分类列表数据
	 */
	public function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelPurchasereturn();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 打印退货单信息
	 */
	function actionPrint(){
		set_time_limit(0);
		$object = new ModelPurchasereturn();
		$count = $object->getgoodsCount($_GET['order_id']);
		$order_info = $object->order_info($_GET['order_id']);
		$user = new ModelUser();
		$this->tpl->assign('order_sn',CFG_P_RETURN_PREFIX.$order_info['order_sn']);
		$str = "<table width='100%'><tr><td>操作人</td><td>".$user->getName($order_info['operator_id'])."</td><td>录入时间</td><td>".MyDate::transform('date',$order_info['add_time'])."</td><td>供应商</td><td>".$order_info['supplier_name']."(".$order_info['address'].")</td></tr></table>";
		$this->tpl->assign('infopart',$str); 
		$action_list = explode(',',$_SESSION['action_list']);
		$goods_right[] = in_array('view_cost',$action_list)?1:0;
		$this->tpl->assign('listheader',"<tr><td>产品编码</td><td>名称</td><td>数量</td><td>备注</td></tr>"); 
		$this->tpl->assign('listpart',$object->goods_info(0,$count,$_GET['order_id']));
		$this->dir = 'system';
		$this->name = 'order_print';
		$this->show();
	}	
	
	/**
	 * 默认页面---订单添加修改
	 */
	function actionAddPurchase() {
		parent::actionPrivilege('add_p_order');
		$object = new ModelPurchasereturn();
		$counts=$object->getgoodsCount($_REQUEST['order_id']);
		if($counts>0){
			$orders = $object->order_info($_REQUEST['order_id']);
			$order_info = array();
			$order_info['order_sn'] = $object->get_order_sn();
			$order_info['supplier_id'] = $orders['SUPPLIER_ID'];
			$order_info['pre_time'] = date('Y-m-d H:i:s');
			$order_info['status'] = 0;
			$order_info['operator_id'] = $_SESSION['admin_id'];
			$order_info['comment']= "采购退货单：".CFG_P_RETURN_PREFIX.$orders['order_sn']."的新增采购单";
			$list = $object->goods_info(0,0,$_REQUEST['order_id']);
			$goodsarr = array();
			foreach($list as $goods){
				$good->goods_id =$goods['goods_id'];
				$good->goods_qty = $goods['goods_qty'];
				$good->goods_price  = $goods['goods_price'];
				$good->remark = $goods['remark'];
				$goodsarr[] = $good;
				unset($good);
			}
			$order_info['data'] = $goodsarr;
			try {
				$purchaseorder=new ModelPurchaseorder();
				$purchaseorder->save($order_info);
			} catch (Exception $e) {
				echo "{success:false,msg:'".$e->getMessage()."'}";exit;
			}
			echo "{success:true,msg:".$msg."'采购订单新增成功！订单号：".CFG_P_ORDER_PREFIX.$order_info['order_sn']."'}";exit;
		}else{
			echo "{success:false,msg:".$msg."'采购的产品数量为0，无法新增采购单！'}";exit;
		}
	}	
}
?>