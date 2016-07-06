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
 * 销售员提成
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Sales extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '销售分成';
		$this->name = 'sales';
		$this->dir = 'system';
	}
	/**
	 * 默认界面
	 */
	function actionIndex() {
		parent::actionPrivilege('list_sales');
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelSales');
	}
	/**
	 * 保存销售员
	 *
	 */
	function actionUpdate() 
	{

			$object = new ModelSales();
			try {
					$object->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		parent::actionDelete('ModelSales');
	}
	
	/**
	 * 返回销售员产品 json列表
	 *
	 */
	function actionGoodslist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSales();
		$where = $object->getGoodsWhere($_REQUEST);
		$list = $object->getGoodsList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getGoodsCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	/**
	 * 返回销售员产品更新
	 *
	 */
	function actionGoodsupdate()
	{
			$object = new ModelSales();
			try {
					$object->save_goods($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 删 除产品
	 *
	 */
	function actionGoodsdelete()
	{
		$object = new ModelSales();
		$object->delgoods($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	
	function actionchannellist()
	{
		parent::actionTableList('sales_channels_rate','ModelSales');
		
	}
	function actionchannelupdate() 
	{

			$object = new ModelSales();
			try {
					$object->savechannel($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	function actionchannelete()
	{
		$object = new ModelSales();
		$object->delchannel($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
}	
?>