<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 产品多语言
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Language extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '语言设置';
		$this->name = 'language';
		$this->dir = 'system';
	}
	/**
	 * 默认界面
	 */
	function actionIndex() {
		parent::actionPrivilege('list_Language');
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelLanguage');
	}
	/**
	 * 保存语言
	 *
	 */
	function actionUpdate() 
	{
		if(parent::actionCheck('edit_language'))
		{
			$language = new ModelLanguage();
			try {
					$language->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
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
		parent::actionDelete('ModelLanguage');
	}
	function actionOpenwin(){
		$this->name = 'codeshow';
		$this->show();
	}
}	
?>