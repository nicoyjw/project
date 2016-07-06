<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Ebay 账号管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Ebayaccount extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= 'Ebay账号管理';
		$this->name = 'ebayaccount';
		$this->dir = 'system';
	}
	/**
	 * 所有权限列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_account');
		$this->tpl->assign('amazon_site',ModelDd::getComboData('amazon_site'));
		$this->show();
	}

	/**
	 * 保存
	 *
	 */
	 public function actionUpdate(){
	 	if(parent::actionCheck('edit_account')) parent::actionSave('ModelEbayaccount');
	 }
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_account')) parent::actionDelete('ModelEbayaccount');
	}

	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelEbayaccount();
		$where = " where type = '".$_GET['type']."'";
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	/**
	 * 返回paypal json列表
	 *
	 */
	function actionPaypalList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelEbayaccount();
		$list = $object->getPaypalList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getPaypalCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回paypal主账号json列表
	 *
	 */
	function actionPaypalRootList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelEbayaccount();
		$list = $object->getPaypalRootList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getPaypalRootCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回paypal更新
	 *
	 */
	function actionPaypalupdate()
	{
		if(parent::actionCheck('edit_account')) {
			$object = new ModelEbayaccount();
			try {
					$object->paypalsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除Paypal
	 *
	 */
	function actionPaypaldel()
	{
		if(parent::actionCheck('del_account')) {
		$object = new ModelEbayaccount();
		$object->delPaypal($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
		}
	}
	
	/**
	 * 返回paypal主账号更新
	 *
	 */
	function actionPaypalrootupdate()
	{
		if(parent::actionCheck('edit_account')) {
			$object = new ModelEbayaccount();
			try {
					$object->paypalrootsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除Paypal主账号
	 *
	 */
	function actionPaypalrootdel()
	{
		if(parent::actionCheck('del_account')) {
		$object = new ModelEbayaccount();
		$object->delPaypalroot($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
		}
	}		
	/**
	 * 获取树状列表
	 *
	 */
	function actiongetaccounttree()
	{
			$goods = new ModelEbayaccount();
			$trees = $goods->acountTree();
			$result = $trees[$_REQUEST['node']];
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	/****
	*获取ebay session并返回Ebay登录页面
	****/
	function actionCreatebay()
	{
			try {
				$object = new ModelEbayaccount();
				$sessionid = explode('|',$object->getEbaySession($_POST['name']));
				$url = 'https://signin.ebay.com/ws/eBayISAPI.dll?SignIn&RuName='.$sessionid[1].'&SessID='.$sessionid[0];
				echo "{success:true,msg:'$url'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	/*****
	*获取授权token
	*****/
	function actionCompleteEbay()
	{
			try{
				$object = new ModelEbayaccount();
				$object->completeebay($_POST['name']);
				echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/****
	*获取ebay session并返回Ebay登录页面
	****/
	function actionCreatTaobao()
	{
			try {
				$object = new ModelEbayaccount();
				$sessionid = explode('|',$object->getTaobao($_POST['name']));
				$url = 'http://container.open.taobao.com/container?appkey='.$object->getTaobao($_POST['name']).'&encode=utf-8';
				echo "{success:true,msg:'$url'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	function actionCompletetb()
	{
			try{
				$object = new ModelEbayaccount();
				$object->completetb($_GET['top_session']);
				echo "授权成功";die();
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "授权失败".$errorMsg;die();
	}
	
	function actioncheckeub()
	{
			try{
				$object = new ModelEbayaccount();
				echo "{success:true,msg:'" .$object->checkeub($_POST['name']) . "'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	/********
	*
	*自动账号分类
	*********/
	
	function actionautotype()
	{
			try{
				$object = new ModelEbayaccount();
				$object->autotype();
				echo "{success:true,msg:'ok'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/********
	*
	*自动paypal账号文件
	*********/
	
	function actionautoptype()
	{
			try{
				$object = new ModelEbayaccount();
				$object->autoptype();
				echo "{success:true,msg:'ok'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
}
?>