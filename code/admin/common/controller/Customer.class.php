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
class Customer extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '客户管理模块';
		$this->name = 'customer';
		$this->dir = 'customer';
	}

	/**
	 * 订单客户列表
	 */
	function actionIndex() {
		$customer = new ModelCustomer();
		$customer->update_customer($result[0],$result[1]);
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelCustomer();
		if(isset($_POST['keyword'])&&!empty($_POST['keyword'])){
		$whstr=$object->getListWhStr($_POST['keyword']);
		}else
		$whstr='';
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$whstr);
		$result['totalCount'] = $object->getCount($whstr);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回跟踪记录列表
	 *
	 */
	function actionCustomerNoteList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelCustomer();
		$list = $object->getNoteList($pageLimit['from'],$pageLimit['to']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionBlackListList()
	{
		parent::actionList('ModelBlackList');
	}
	/**
	 * 返回各体客户所有订单列表
	 *
	 */
	function actionCustomerOrderList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelCustomer();
		$list = $object->getCustomerOrderList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 *域名黑名单列表
	 *
	 */
	function actionBlackList()
	{
		$this->name = 'blacklist';
		$this->show();
	}
	/**
	 * 编辑customer订单客户
	 *
	 */
	function actionEdit()
	{
		$this->name = 'edit_customer';
		$this->show();
	}
	/**
	 * 添加跟踪记录
	 *
	 */
	function actionAddCustomerNote()
	{
			try {
				$object = new ModelCustomer();
				$object->addnote($_POST);
				echo "{success:true,msg:'OK'}";exit;	
			}
			catch (Exception $e) {
				echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
			}
	}
	/**
	 * 保存customer订单客户
	 *
	 */
	function actionSave()
	{
		try {
			if(isset($_POST['return_time'])&&!empty($_POST['return_time']))
			$_POST['return_time']=strtotime($_POST['return_time']);
			if(isset($_POST['create']))
			unset($_POST['create']);
			$_POST['order_time']=time();
			$_POST['arrival_time']=time();
			$customer = new ModelCustomer();
			if(!$_POST['id'])
			$_POST['customer_sn']=$customer->get_order_sn();
			$_POST['order_sn']=substr(trim($_POST['order_sn']),strlen(CFG_ORDER_PREFIX));
			$_POST['order_id']=$customer->get_order_id(trim($_POST['order_sn']));
			$customer->save($_POST);
			echo "{success:true,msg:'OK'}";exit;	
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}

	}
	/**
	 * 更改customer订单客户 状态
	 *
	 */
	function actionChangeStatus()
	{
		try {
			if(isset($_GET['id'])&&intval($_GET['id'])>0){
			
				// v=>is_value field
				$fld=$_GET['fld']=='v'?'is_value':'is_black';
				$_POST[$fld]=$_GET['status'];
				$_POST['customer_id']=$_GET['id'];
				$customer = new ModelCustomer();
				$customer->save($_POST);
				$customer->setBlackList();
				echo "{success:true,msg:'OK'}";exit;
			}
			else
			return false;	
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}

	}	
	/**
	 * 取customer单数数据
	 *
	 */
	function actionGetInfo()
	{
		$customer = new ModelCustomer();
		$info = $customer->getInfo($_GET['id']);
		$info['return_time']=date('y-m-d',$info['return_time']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($info);exit;
	}
}
?>