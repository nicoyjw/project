<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 采购建议
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Purchaseofs extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '采购订单';
		$this->name = 'advice';
		$this->dir = 'purchase';
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_p_advice');
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
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
		set_time_limit(0);
		$pageLimit = getPageLimit();
		$object = new ModelPurchaseorder();
		$list = $object->getadvicelist($pageLimit['from'],$pageLimit['to'],($_GET['type']=='export')?1:0);
		$result['totalCount'] = $object->getplanCount();
		$result['topics'] = $list;
		if($_GET['type']=='export'){
				include_once(CFG_PATH_LIB.'PHPExcel.php');
				include_once(CFG_PATH_LIB.'PHPExcel/Cell/AdvancedValueBinder.php');
				PHPExcel_Cell::setValueBinder( new PHPExcel_Cell_AdvancedValueBinder() );
				echo date('H:i:s') . " Create new PHPExcel object\n";
				$objPHPExcel = new PHPExcel();
				echo date('H:i:s') . " Set properties<br>";
				$objPHPExcel->getProperties()->setCreator("Vekincheng")
											 ->setLastModifiedBy("Vekincheng")
											 ->setTitle("Excle output for order tracking")
											 ->setSubject("Excle output for order tracking")
											 ->setDescription("Excle output for order tracking")
											 ->setKeywords("Order product Track")
											 ->setCategory("Test result file");
				echo date('H:i:s') . " Add some data<br>";
				$objPHPExcel->setActiveSheetIndex(0);
				$header = '产品编码,产品名称,SKU,库存数量,锁定库存,预警天数,日均销量,销售预期,补货天数,本地库存,供应商,调拨数量1,头程渠道1,在途时间1,调拨数量2,头程渠道2,在途时间2,调拨数量3,头程渠道3,在途时间3';
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
						$order_value[] =  $list[$i]['goods_sn'];
						$order_value[] =  $list[$i]['goods_name'];
						$order_value[] =  $list[$i]['SKU'];
						$order_value[] =  $list[$i]['goods_qty'];
						$order_value[] =  $list[$i]['varstock'];
						$order_value[] =  $list[$i]['plan_day'];
						$order_value[] =  $list[$i]['per_sold'];
						$order_value[] =  $list[$i]['expected'];
						$order_value[] =  $list[$i]['period'];
						$order_value[] =  $list[$i]['stock_qty'];
						$order_value[] =  $list[$i]['supplier'];
						for($j=0;$j<count($list[$i]['dbarr']);$j++){
							$order_value[] =  $list[$i]['dbarr'][$j];
							}
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
				$file = 'data/ordertmp/advicelist'.$_SESSION['admin_id'].'.xlsx';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();			
			}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
}
?>