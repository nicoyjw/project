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
 * 客户 
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */
class Client  extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '客户管理';
		$this->name = 'client';
		$this->dir = 'client';
	}
	
	/**
	 * 返回json列表
	 *
	 */
	function actionList() {
		$pageLimit = getPageLimit();
		$client = new ModelClient();
		$clients = $client->getList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $client->getCount();
		$result['topics'] = $clients;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);	
	}
	
	/**
	 * 新增编辑页面
	 */
	function actionAdd(){
		$this->name='addClient';
		$client_id = intval($_GET['client_id']);
		if ($client_id) {
			$client = new ModelClient();
			$info = $client->getInfo($client_id);
			$this->tpl->assign('CFG_TIME',date('Y-m-d',$info['create_time']));
			$this->tpl->assign('modify_time',date('Y-m-d',$info['modify_time']));
			$this->tpl->assign('info',$info);
		}
			
		$this->tpl->assign('sex',ModelDd::getComboData('sex'));
		$this->tpl->assign('is_married',ModelDd::getComboData('is_married'));
		$this->tpl->assign('education',ModelDd::getComboData('education'));
		$this->tpl->assign('works',ModelDd::getComboData('works'));
		$this->tpl->assign('is_bool',ModelDd::getComboData('is_bool'));
		$this->tpl->assign('depts',ModelDd::getComboData('depts'));
		$this->tpl->assign('create_time',date('Y-m-d',CFG_TIME));
		$this->tpl->assign('modify_time',date('Y-m-d',CFG_TIME));
		$this->show();
	}

	/**
	 * 保存
	 */
	function actionSave(){
		$client = new ModelClient();
		$client->save($_POST);
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		$client = new ModelClient();
		$client->delete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
}
?>