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
 * Ebay Case管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class ECase extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= 'Ebay Case管理';
		$this->name = 'case';
		$this->dir = 'aftersell';
	}
	
	/**
	 * 默认页面---加载Case
	 */
	function actionIndex() {
		parent::actionPrivilege('list_case');
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('yesterday',$time);
		$this->tpl->assign('today',$d);
		$this->show();
	}


	/**
	*获取Case josn列表
	*/
	function actionList(){
		parent::actionList('ModelEcase');
	}
	
	/**
	 * Case加载页面
	 */
	function actionLoad() {
		parent::actionPrivilege('load_case');
		$d 			= date('Y-m-d');
		$time1 		= strtotime(date("Y-m-d",strtotime("$d -1 day")));
		$time		= date('Y-m-d',$time1);
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('yesterday',$time);
		$this->tpl->assign('today',$d);
		$this->name = 'loadcase';
		$this->show();
	}
	
	/**
	 * Case加载
	 */
	function actionLoadcase() {
		if(parent::actionCheck('load_case')) {
			$case = new ModelEcase();
			try {
				$msg = $case->saveEbaycase($_POST);
				echo "{success:true,msg:'$msg'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:false,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * Case保存数据库
	 */
	function actionLoadXml() {
			$case = new ModelEcase();
			try {
				$msg = explode('|',$case->loadXml($_POST));
				echo "<br>第$_POST[page]页加载完成，共有".$msg[0]."个Case被加载";
				if($msg[1]>0) echo ",".$msg[1]."个Case被更新";
				exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "<br>加载过程中发生以下错误:$errorMsg";exit;
	}
	
	/**
	 * Ebay feedback加载
	 */
	function actionLoadFB() {
			$object = new ModelEcase();
			try {
				echo '共加载了'.$object->savefb($_GET).'条Feedback';
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	
	function actionfeedback()
	{
		parent::actionPrivilege('list_feedback');
		$this->tpl->assign('template',ModelDd::getComboData('message_template'));
		$this->tpl->assign('fbtype',ModelDd::getComboData('fbtype'));
		$this->name = 'feedback';
		$this->show();
	}
	function actiongetfblist()
	{
		$pageLimit = getPageLimit();
		$goods = new ModelEcase();
		$where = $goods->getfbWhere($_REQUEST);
		$list = $goods->getfbList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $goods->getfbCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);		
	}
	function actionchangefbstatus(){
		$object = new ModelEcase();
		try {
			$object->changestatus($_POST);
			echo "{success:true,msg:'状态更改成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	function actionreplyfb()
	{
		$object = new ModelEcase();
		try {
			$object->replyanswer($_POST);
			echo "{success:true,msg:'回复成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	
}
?>