<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 互联易控制类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Ice extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '互联易';
		$this->dir = 'order';
	}
	
	/**
	 * 默认页面---加载订单
	 */
	function actionIndex() {
		$this->name = 'snimport';
		$this->show();
	}
	/**
	 * 导入条码页面
	 */
	function actionImportSn()
	{
		$this->show();
	}
	/**
	 * 导入条码
	 */
	function actionsnimporthandle(){
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allColumnIndex = PHPExcel_Cell::columnIndexFromString($allColumn);
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelSystem();
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){
			$info = array('sn' => trim($currentSheet->getCell('A'.$currentRow)->getValue()),'type'=>$_POST['channels']);
			$object->insertsn($info);
		}
		echo "{success:true,msg:'OK'}";exit;
	}
	/**
	 *
	 * 获取互联易运单条码
	 * $_POST['ids']  订单号
	 */
	function actiongetIceTrackNo(){
		//echo $_POST['id'];exit;
		$object = new ModelIce();
		try {
			$msg = $object->updateIce($_POST);
			echo $msg;exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "<br><font color=red>$errorMsg</font>";exit;
	}
}
?>
