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
 * 采购激活
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Purchaseplan extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '采购询价';
		$this->name = 'Purchasequote';
		$this->dir = 'purchase';
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		die('此功能暂未开放');
		$this->show();
	}

	/**
	 * 保存供应商信息
	 */
	function actionUpdate() {
		if(parent::actionCheck('edit_p_quote')) {
			$Purchasequote = new ModelPurchasequote();
			try {
					$Purchasequote->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}

	/**
	 * 删 除供应商
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_p_quote')) parent::actionDelete('ModelPurchasequote');
	}

	/**
	 * 获得分类列表数据
	 */
	public function actionList()
	{
		$pageLimit = getPageLimit();
		$Purchasequote = new ModelPurchasequote();
		$where = $Purchasequote->getWhere($_REQUEST);
		$list = $Purchasequote->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $Purchasequote->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
}
?>