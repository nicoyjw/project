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
 * 模板管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Template extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '模板管理';
		$this->dir = 'template';
	}
	
	/**
	 * 默认页面---Message模板
	 */
	function actionMessage() {
		parent::actionPrivilege('template_message');
		$this->name = "message";
		$this->show();
	}
	/**
	 * 默认页面---partner模板
	 */
	function actionPartner() {
		parent::actionPrivilege('template_partner');
		$this->name = "partner";
		$this->show();
	}

    /**
     * aliexpress template
     */
    function actionAlimessage() { 
        $this->dir = 'aliexpress';                 
        $this->name = "message";
        $this->show();
    }

	/**
	*获取Message josn列表
	*/
	function actionMessageList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelTemplate();
		$where = ' where cat_id = 1';
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	*获取partner josn列表
	*/
	function actionPartnerList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelTemplate();
		$where = ' where cat_id = 2';
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}	
	/**
	 * 更新Message模板
	 *
	 */
	function actionUpdate()
	{
		if(parent::actionCheck('edit_template')) {
			$object = new ModelTemplate();
			try {
					$object->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除Message模板
	 *
	 */
	function actionDel()
	{
		if(parent::actionCheck('del_template')) {
			parent::actionDelete('ModelTemplate');
		}
	}
	
	function actionGetcontent()
	{
			$object = new ModelTemplate();
			try {
                    
                    if($_GET['paypalid'] <> 0){
                        $_GET['order_id'] = $object->getOrderIdByPaypalid($_GET['paypalid']);
                        
                    }
                
					$content = $object->getContent($_GET['rec_id'],$_GET['order_id'],$_GET['mid']);
                    $content = $object->replacecontent($content,$_GET['order_id']);
					echo $content;exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo $errorMsg;exit;
	}
	/********
	***
	***订单模版文件
	***
	********/
	function actionOrder()
	{
		parent::actionPrivilege('template_order');
		$arr = ModelDd::getArray('order_field');
		$arr1 = ModelDd::getArray('orderexport');
		$this->tpl->assign('order_field',ModelDd::arrayFormat(array_diff($arr,$arr1)));
		$this->tpl->assign('orderexport',ModelDd::getComboData('orderexport'));
		$this->name = "order";
		$this->show();
	}
	/********
	***
	***编辑订单模版文件
	***
	********/
	function actionsaveorder()
	{
			$object = new ModelTemplate();
			try {
					$object->saveorder($_POST['itemselector']);
					echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:false,msg:'".$errorMsg."'}";exit;
	}
	function actionGoods()
	{
		parent::actionPrivilege('template_goods');
		$arr = ModelDd::getArray('order_field');
		$arr1 = ModelDd::getArray('orderexport');
		$this->tpl->assign('order_field',ModelDd::arrayFormat(array_diff($arr,$arr1)));
		$this->tpl->assign('orderexport',ModelDd::getComboData('orderexport'));
		$this->name = "order";
		$this->show();
	}
	function actionsavegoods()
	{
			$object = new ModelTemplate();
			try {
					$object->saveorder($_POST['itemselector']);
					echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:false,msg:'".$errorMsg."'}";exit;
	}
}
?>