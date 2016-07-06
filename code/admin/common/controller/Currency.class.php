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
 * 币种汇率
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Currency extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '币种汇率';
		$this->name = 'currency';
		$this->dir = 'system';
	}
	/**
	 * 默认界面
	 */
	function actionIndex() {
		parent::actionPrivilege('list_currency');
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelCurrency');
	}
	/**
	 * 保存汇率
	 *
	 */
	function actionUpdate() 
	{
		if(parent::actionCheck('edit_currency'))
		{
			$currency = new ModelCurrency();
			try {
					$currency->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	function actionAjax() 
	{
		if(parent::actionCheck('edit_currency'))
		{
			$currency = new ModelCurrency();
			try {
					$currency->ajax();
					echo "{success:true,msg:'更新汇率成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		parent::actionDelete('ModelCurrency');
	}
}	
?>