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
 * 采购询价
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Purchasequote extends Controller  {

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
		parent::actionPrivilege('list_p_quote');
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
		if(parent::actionCheck('edit_p_quote')) parent::actionDelete('ModelPurchasequote');
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
	/**
	 * 获得分类列表数据
	 */
	public function actionExport()
	{
		$Purchasequote = new ModelPurchasequote();
		$where = $Purchasequote->getWhere($_REQUEST);
		$list = $Purchasequote->getExportList($where);
		include_once(CFG_PATH_LIB.'PHPExcel.php');
		include_once(CFG_PATH_LIB.'PHPExcel/Cell/AdvancedValueBinder.php');
		PHPExcel_Cell::setValueBinder( new PHPExcel_Cell_AdvancedValueBinder() );
		echo date('H:i:s') . " Create new PHPExcel object<br>";
		$objPHPExcel = new PHPExcel();
		echo date('H:i:s') . " Set properties<br>";
		$objPHPExcel->getProperties()->setCreator("Vekincheng");
		echo date('H:i:s') . " Add some data<br>";
		$objPHPExcel->setActiveSheetIndex(0);
		$header = '序号,销售商,联系人,电话,产品,价格,备注,询价人,询价时间';
		$content = explode(",",$header);
		$sf = 'A';
		$showtable = 0;
		if($showtable) echo '<table border="1"><tr>';
		for($i=0;$i<count($content);$i++){
				$objPHPExcel->getActiveSheet()->setCellValue($sf.'1', $content[$i]);
				if($showtable)  echo '<td>'.$content[$i].'</td>';
				$sf++;
			}
		if($showtable) echo '</tr>';
		$objPHPExcel->getActiveSheet()->setTitle('sheet1');
		echo date('H:i:s') . " Write to Excel5 format<br>";
		$t =2;
		for($i=0;$i<count($list);$i++){
				$order_value[] =  $list[$i]['id'];
				$order_value[] =  $list[$i]['supplier'];
				$order_value[] =  $list[$i]['contact'];
				$order_value[] =  $list[$i]['phone'];
				$order_value[] =  $list[$i]['product'];
				$order_value[] =  $list[$i]['price'];
				$order_value[] =  $list[$i]['remark'];
				$order_value[] =  $list[$i]['operator'];
				$order_value[] =  $list[$i]['add_time'];
				$cf ='A';
				if($showtable) echo '<tr>';
				for($m =0;$m<count($order_value);$m++){
					if((substr($order_value[$m],0,1) == '0' && $order_value[$m] <> '0' ) || !is_numeric($order_value[$m])) $objPHPExcel->getActiveSheet()->setCellValueExplicit($cf.$t, $order_value[$m],PHPExcel_Cell_DataType::TYPE_STRING);
					else $objPHPExcel->getActiveSheet()->setCellValue($cf.$t, $order_value[$m]);
					if($showtable) echo '<td>'.$order_value[$m].'</td>';
					$cf++;
				}
				if($showtable) echo '</tr>';
				unset($order_value);
				$t++;
		}
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/planlist'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	/***************
	***导入采购询价
	***************/
	
	public function actionUpload()
	{
		set_time_limit(0);
		parent::actionPrivilege('porder_import');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		
		$Purchasequote = new ModelPurchasequote();
		try {
			for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
				$quote['supplier']=$currentSheet->getCell('A'.$currentRow)->getValue();
				$quote['contact']=$currentSheet->getCell('B'.$currentRow)->getValue();
				$quote['phone']=$currentSheet->getCell('C'.$currentRow)->getValue();
				$quote['product']=$currentSheet->getCell('D'.$currentRow)->getValue();
				$quote['price']=$currentSheet->getCell('E'.$currentRow)->getValue();
				$quote['remark']=$currentSheet->getCell('F'.$currentRow)->getValue();
				$quote['operator']=$currentSheet->getCell('G'.$currentRow)->getValue();
				$Purchasequote->save($quote);
			}
		} catch (Exception $e) {
				echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:".$msg."'采购询价导入成功'}";exit;
	}
}
?>