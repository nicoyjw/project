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
 * 统计类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */

class Statistics extends Controller  {

	/**
	 * 初始化页面信息
	 */
	public function __construct()
	{
		parent::__construct();
		$this->title .= '系统统计';
		$this->name = 'sell_list';
		$this->dir = 'statistics';
	}

	/**
	 * 列表
	 */
	public function actionIndex()
	{
		parent::actionPrivilege('sales_statistics');
		$account = ModelDd::getArray('allaccount');
		$this->tpl->assign('account',ModelDd::getComboData('allaccount'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->show();
	}
	
	function actionorderlist()
	{
		$object = new ModelStatistics();
		$where = $object->getWhere($_REQUEST);	
		$list = $object->orderlist($where);
		if($_REQUEST['type']=='export'){
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
			$header = '订单总金额,产品总金额,产品总利润';
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
			$order_value[] =  $list['results'][0]['value'];
			$order_value[] =  $list['results'][1]['value'];
			$order_value[] =  $list['results'][2]['value'];
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
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/orderlist'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($list);
		}
	}
	function actionweeklist()
	{	
		$object = new ModelStatistics();
		$list = $object->week_total($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '日期,订单总金额,产品总金额,产品总利润';
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
			for($i=0;$i<count($list['result']);$i++){
					$order_value[] =  $list['result'][$i]['week'];
					$order_value[] =  $list['result'][$i]['order_amount'];
					$order_value[] =  $list['result'][$i]['goods_amount'];
					$order_value[] =  $list['result'][$i]['total_porfit'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/weeklist'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($list);
		}
	}
	
	function actionmonlist()
	{
		$object = new ModelStatistics();
		$list = $object->mon_total($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '日期,订单总金额,产品总金额,产品总利润';
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
			for($i=0;$i<count($list['result']);$i++){
					$order_value[] =  $list['result'][$i]['day'];
					$order_value[] =  $list['result'][$i]['mon_order_amount'];
					$order_value[] =  $list['result'][$i]['mon_goods_amount'];
					$order_value[] =  $list['result'][$i]['mon_total_porfit'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/monlist'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($list);
		}
	}
	
	function actionYearList(){
		$object = new ModelStatistics();
		$list = $object->year_total($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '月份,订单总金额,产品总金额,产品总利润';
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
			for($i=0;$i<count($list['result']);$i++){
					$order_value[] =  $list['result'][$i]['mon'];
					$order_value[] =  $list['result'][$i]['year_order_amount'];
					$order_value[] =  $list['result'][$i]['year_goods_amount'];
					$order_value[] =  $list['result'][$i]['year_total_porfit'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/yearList'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($list);
		}
	}
	/**
	 * 发货统计
	 */
	public function actionShipping()
	{
		parent::actionPrivilege('shipping_statistics');
		$this->tpl->assign('account',ModelDd::getComboData('allaccount'));
		$this->name = 'shipping';
		$this->show();
	}
	public function actionShippinglist()
	{
		$object = new ModelStatistics();
		$where = $object->getShippingWhere($_REQUEST);
		$list = $object->getShippingList($where);
		if($_REQUEST['type']=='export'){
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
			$header = '快递方式,数量,总重,实际运费';
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
					$order_value[] =  $list[$i]['shipping'];
					$order_value[] =  $list[$i]['counts'];
					$order_value[] =  $list[$i]['weights'];
					$order_value[] =  $list[$i]['costs'];
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
			$file = 'data/ordertmp/shipping'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			$result['totalCount'] = 0;
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	/**
	 *销售国家统计action 
	 */
	function actionCountrystat()
	{
		parent::actionPrivilege('country_statistics');
		$this->name = 'countrystat';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}	
	
	/**
	 *销售国家统计
	 */
	function actionGetCountryStat()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where=$object->CountryStatWhere($_REQUEST);
		$result['totalCount'] = $object->getCountryStatCount($where);
		$result['topics'] = $object->getCountryStat($pageLimit['from'],$pageLimit['to'],$where);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/****************
	******出入库统计
	****************/
	public function actionStock()
	{
		parent::actionPrivilege('stock_statistics');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->name = 'stock';
		$this->show();
	}
	/****************
	******出入库流水统计
	****************/
	public function actionStocktrans()
	{
		parent::actionPrivilege('stocktrans_statistics');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->name = 'stocktrans';
		$this->show();
	}
	/*****************
	****出入库统计列表
	*****************/
	function actionStocklist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getStockWhere($_POST);
		$list = $object->getStockList($pageLimit['from'],$pageLimit['to'],$where,$_POST['type']);
		$result['totalCount'] = $object->getStockCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/*****************
	****出入库流水列表
	*****************/
	function actionStocktranslist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getStocktransWhere($_REQUEST);
		$list = $object->getStocktransList($pageLimit['from'],$pageLimit['to'],$where,$_POST['type']);
		$result['totalCount'] = $object->getStocktransCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}	
	/******************
	*******出入库统计导出
	******************/
	function actionexportstock()
	{
		$object = new ModelStatistics();
		$where = $object->getStockWhere($_GET);
		$list = $object->getStockList('','',$where,$_GET['type'],1);
		include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
		$zip = new PHPZip;
		$content = '"产品编码","产品名称","出(入)库数量"'. "\n";
		for($i=0;$i<count($list);$i++){
			$goods_value['goods_sn'] = '"' . $list[$i]['goods_sn'] . '"';
			$goods_value['goods_name'] = '"' . replace_special_char($list[$i]['goods_name'],false) . '"';
			$goods_value['num'] = $list[$i]['num'];				
			$content .= implode(",", $goods_value) . "\n";	
		}
		$zip->add_file(ecs_iconv('utf-8', 'GBK', $content), 'stock_list.csv');
		header("Content-Disposition: attachment; filename=stock_list.zip");
		header("Content-Type: application/unknown");
		die($zip->file());		
		
	}
	/******************
	*******出入库流水导出
	******************/
	function actionexportstocktrans()
	{
		$object = new ModelStatistics();
		$where = $object->getStocktransWhere($_GET);
		$list = $object->getStocktransList('','',$where,$_GET['type'],1);
		include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
		$zip = new PHPZip;
		$content = '"产品编码","产品名称","SKU","出(入)库数量","单号","供应商/渠道","完成时间"'. "\n";
		for($i=0;$i<count($list);$i++){
			$goods_value['goods_sn'] = '"' . $list[$i]['goods_sn'] . '"';
			$goods_value['goods_name'] = '"' . replace_special_char($list[$i]['goods_name'],false) . '"';
			$goods_value['SKU'] = '"' . $list[$i]['SKU'] . '"';	
			$goods_value['goods_qty'] = '"' . $list[$i]['goods_qty'] . '"';
			$goods_value['order_sn'] = '"' . $list[$i]['order_sn'] . '"';
			$goods_value['supplier'] = '"' . $list[$i]['supplier'] . '"';
			$goods_value['out_time'] = $list[$i]['out_time'];	
			$content .= implode(",", $goods_value) . "\n";	
		}
		$zip->add_file(ecs_iconv('utf-8', 'GBK', $content), 'stock_trans_list.csv');
		header("Content-Disposition: attachment; filename=stock_trans_list.zip");
		header("Content-Type: application/unknown");
		die($zip->file());		
		
	}
	/****************
	
	******订单产品统计
	****************/
	public function actionOrdergoods()
	{
		parent::actionPrivilege('ordergoods_statistics');
		$account = ModelDd::getArray('allaccount');
		if($_SESSION['account_list'] != 'all') {
			$ex_list = explode(",",$_SESSION['account_list']);
			for($i=0;$i<count($ex_list);$i++){
				if(!array_key_exists($ex_list[$i],$account)) unset($account[$ex_list[$i]]);
				}
		}
		$this->tpl->assign('currency',ModelCurrency::currencyformat());
		$this->tpl->assign('allaccount',ModelDd::arrayFormat($account));
		$this->name = 'ordergoods';
		$this->show();
	}
	/*****************
	****订单产品统计列表
	*****************/
	function actionOrderGoodslist()
	{
		set_time_limit(0);
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$object->initorderlist($_POST);
		$where = $object->getOrderWhere($_POST);
		$list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',$_POST['currency']);
		$result['totalCount'] = $object->getOrderCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionexportordergoods()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
				echo date('H:i:s') . " Create new PHPExcel object\n";
				$objPHPExcel = new PHPExcel();
				echo date('H:i:s') . " Set properties<br>";
				$objPHPExcel->getProperties()->setCreator("Vekincheng");
				echo date('H:i:s') . " Add some data<br>";
				$currentSheet =$objPHPExcel->getSheet(0);
				$header = '产品编码,产品名称,成本,运费,包装费,固定价($),均价,销售数量,销售额,总均摊运费,利润率%,类别,可用库存,采购在途,报警库存';
		$content = explode(",",$header);		
		$object = new ModelStatistics();
		$where = $object->getOrderWhere($_GET);
		$list = $object->getOrderList('','',$where,1,$_GET['currency']);
				$showtable = 0;
				if($showtable) echo '<table border="1"><tr>';
				for($i=0;$i<count($content);$i++){
						$currentSheet->setCellValueByColumnAndRow($i,1, $content[$i]);
						if($showtable)  echo '<td>'.$content[$i].'</td>';
					}
				if($showtable) echo '</tr>';
				$currentSheet->setTitle('sheet1');
				echo date('H:i:s') . " Write to Excel5 format<br>";
				$t =2;
				for($i=0;$i<count($list);$i++){
					$order_value[] =  $list[$i]['goods_sn'];
					$order_value[] =  $list[$i]['goods_name'];
					$order_value[] =  $list[$i]['cost'];
					$order_value[] =  $list[$i]['shipping_fee'];
					$order_value[] =  $list[$i]['package_fee'];
					$order_value[] =  $list[$i]['fix_price'];
					$order_value[] =  $list[$i]['avrprice'];
					$order_value[] =  $list[$i]['total_qty'];
					$order_value[] =  $list[$i]['amount'];
					$order_value[] =  $list[$i]['shippingcost'];
					$order_value[] =  $list[$i]['interest'];
					$order_value[] =  $list[$i]['status'];
					$order_value[] =  $list[$i]['valid_qty'];
					$order_value[] =  $list[$i]['onarrive_qty'];
					$order_value[] =  $list[$i]['want_qty'];
						if($showtable) echo '<tr>';
						$currentSheet->setCellValueExplicitByColumnAndRow(0,$t, $order_value[0]);
						for($m =0;$m<count($order_value);$m++){
							$currentSheet->setCellValueByColumnAndRow($m,$t, $order_value[$m]);
							if($showtable) echo '<td>'.$order_value[$m].'</td>';
						}
						if($showtable) echo '</tr>';
						unset($order_value);
						$t++;
				}
				if($showtable) echo '</table>';
				$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
				$file = 'data/ordertmp/order_goods_staistics_'.$_SESSION['admin_id'].'.xls';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();		
	}
	
	/*****************
	****销售提成统计列表
	*****************/
	function actioncommission(){
		parent::actionPrivilege('view_commission');
		$this->tpl->assign('sales',ModelDd::getComboData('sales'));
		$this->name = 'commission';
		$this->show();
	}
	
	function actioncommissionlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$list = $object->getcommissionList($pageLimit['from'],$pageLimit['to'],$_POST);
		$result['totalCount'] = $object->getcommissionCount($_POST['sales']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/*****************
	****当前库存情况统计列表
	*****************/
	function actioncurrentstock()
	{
		$this->tpl->assign('depot',ModelDd::getComboData("depot"));
		$this->name = 'currentstock';
		$this->show();
	}
	/*****************
	****当前库存情况统计列表
	*****************/
	function actioncurrentstocklist()
	{
		parent::actionPrivilege('list_current');
		$object = new ModelStatistics();
		$list = $object->getcurrent($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '仓库,SKU总数,有库存SKU总数,持续采购SKU总数,库存总成本,已锁定库存总成本';
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
					$order_value[] =  $list[$i]['depot'];
					$order_value[] =  $list[$i]['total'];
					$order_value[] =  $list[$i]['hasstock'];
					$order_value[] =  $list[$i]['instatus'];
					$order_value[] =  $list[$i]['totalcost'];
					$order_value[] =  $list[$i]['varcost'];
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
			$file = 'data/ordertmp/currentstock'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			$results['totalCount'] =0;
			$results['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($results);
		}
	}
	
	
	function actionBestmatch()
	{
		parent::actionPrivilege('list_bestmatch');
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->name = 'bestmatch';
		$this->show();
	}
	
	
	function actionBestmatchlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getBestmatchWhere($_POST);
		$list = $object->getbestmatchList($pageLimit['from'],$pageLimit['to'],$where,'',$pageLimit['sort']);
		$result['totalCount'] = $object->getBestmatchCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**************
	*****订单利润统计
	***************/
	function actionProfit()
	{
		parent::actionPrivilege('view_profit');
		$this->tpl->assign('allaccount',ModelDd::getComboData('allaccount'));
		$this->name = 'profit';
		$this->show();
	}
	function actionprofitlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getprofitWhere($_POST);
		$list = $object->getprofitList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getprofitCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionexportprofit()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
				echo date('H:i:s') . " Create new PHPExcel object\n";
				$objPHPExcel = new PHPExcel();
				echo date('H:i:s') . " Set properties<br>";
				$objPHPExcel->getProperties()->setCreator("Vekincheng");
				echo date('H:i:s') . " Add some data<br>";
				$currentSheet =$objPHPExcel->getSheet(0);
				$header = '订单号,国家,发货方式,收取运费,产品总价,订单总价,渠道费用,产品总成本,总产品运费,总包装成本,重量,总运费,利润,利润率';
		$content = explode(",",$header);		
		$object = new ModelStatistics();
		$where = $object->getprofitWhere($_GET);
		$list = $object->getprofitList('','',$where,1);
				$showtable = 0;
				if($showtable) echo '<table border="1"><tr>';
				for($i=0;$i<count($content);$i++){
						$currentSheet->setCellValueByColumnAndRow($i,1, $content[$i]);
						if($showtable)  echo '<td>'.$content[$i].'</td>';
					}
				if($showtable) echo '</tr>';
				$currentSheet->setTitle('sheet1');
				echo date('H:i:s') . " Write to Excel5 format<br>";
				$t =2;
				for($i=0;$i<count($list);$i++){
					$order_value[] =  $list[$i]['order_sn'];
					$order_value[] =  $list[$i]['country'];
					$order_value[] =  $list[$i]['shipping_id'];
					$order_value[] =  $list[$i]['shipping_fee'];
					$order_value[] =  $list[$i]['goods_total'];
					$order_value[] =  $list[$i]['order_amount'];
					$order_value[] =  $list[$i]['channelfee'];
					$order_value[] =  $list[$i]['goods_price'];
					$order_value[] =  $list[$i]['goods_shipping'];
					$order_value[] =  $list[$i]['goods_package'];
					$order_value[] =  $list[$i]['weight'];
					$order_value[] =  $list[$i]['shipping_cost'];
					$order_value[] =  $list[$i]['per'];
					$order_value[] =  $list[$i]['interest'];
						if($showtable) echo '<tr>';
						$currentSheet->setCellValueExplicitByColumnAndRow(0,$t, $order_value[0]);
						for($m =0;$m<count($order_value);$m++){
							$currentSheet->setCellValueByColumnAndRow($m,$t, $order_value[$m]);
							if($showtable) echo '<td>'.$order_value[$m].'</td>';
						}
						if($showtable) echo '</tr>';
						unset($order_value);
						$t++;
				}
				if($showtable) echo '</table>';
				$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
				$file = 'data/ordertmp/order_goods_staistics_'.$_SESSION['admin_id'].'.xls';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();		
	}
	/************
	*****新品与呆货
	*************/
	function actionNew()
	{
		parent::actionPrivilege('view_new');
		$this->tpl->assign('currency',ModelCurrency::currencyformat());
		$this->name = 'new';
		$this->show();
	}
	
	function actionnewGoodslist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getNewWhere($_POST);
		$list = $object->getNewList($pageLimit['from'],$pageLimit['to'],$where,'',$_POST['currency'],$_POST);
		$result['totalCount'] = $object->getNewCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionOldGoodsList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getoldWhere($_POST);
		$list = $object->getOldList($pageLimit['from'],$pageLimit['to'],$where,'',$_POST);
		$result['totalCount'] = $object->getOldCount($where,$_POST['type']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	
	/**
	*调拨统计axtion
	*/
	function actionAllocation()
	{
		parent::actionPrivilege('allocation_statistics');
		$this->tpl->assign('first_shipping',ModelDd::getComboData('first_shipping'));
		$this->tpl->assign('db_shipping',ModelDd::getComboData('db_shipping'));
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->name = 'allocation';
		$this->show();
	}
	/**
	*查询时间段调拨统计
	*/
	function actionAllocationList()
	{
		$object = new ModelStatistics();
		$where = $object->getAllocationWhere($_POST);
		$results['totalCount'] =0;
		$results['topics'] = $object->getAllocationList($where);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($results);
	}
	
	/**
	*采购统计
	*/
	function actionPick()
	{
		parent::actionPrivilege('purchase_statistics');
		$this->tpl->assign('operator',ModelDd::getComboData('user'));
		$this->name = 'pick';
		$this->show();
	}
	/**
	*查询时间段采购统计
	*/
	function actionPickList()
	{
		$object = new ModelStatistics();
		$where = $object->getPickWhere($_REQUEST);
		$list=$object->getPickList($where);
		if($_REQUEST['type']=='export'){
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
			$header = '供应商,总数量,总金额,总单数,到货数量,退货数量';
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
					$order_value[] =  $list[$i]['supplier_name'];
					$order_value[] =  $list[$i]['total_qty'];
					$order_value[] =  $list[$i]['total_price'];
					$order_value[] =  $list[$i]['counts'];
					$order_value[] =  $list[$i]['arrival_qty'];
					$order_value[] =  $list[$i]['return_qty'];
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
			$file = 'data/ordertmp/shipping'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			$results['totalCount'] =0;
			$results['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($results);
		}
	}
	
	function actionMonthRma()
	{
		parent::actionPrivilege('rma_statistics');
		$this->name = 'monthRma';
		$this->show();
	}
	
	/**
	*查询时间段每月问题产品个数、及各问题的产品个数
	*/
	function actionMonthRmaList(){
		$object = new ModelStatistics();
		$datas = $object->getMonthRmaList($_REQUEST);
		$monthArea=$this->getArea($_REQUEST['starttime'],$_REQUEST['totime']);
		$result = array();
		foreach($monthArea as $val){
			$bool=true;
			for($i=0;$i<count($datas);$i++){
				if($val && $val==$datas[$i]['month']){
					$bool=false;
					$list[]=$datas[$i];
					break;
				}
			}
			if($bool){
				$list[]=array('month'=>$val,'reason'=>'','counts'=>0,'error'=>'');
			}
		}
		if($_REQUEST['type']=='export'){
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
			$header = '月份,问题及问题产品数量';
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
					$order_value[] =  $list[$i]['month'];
					$order_value[] =  $list[$i]['error'];
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
			$file = 'data/ordertmp/monthRma'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			$results['totalCount'] =0;
			$results['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($results);
		}
	}
	/**
	*查询时间段当月问题产品的不良率
	*/
	function actionRmaList(){
		$object = new ModelStatistics();
		$list = $object->getRmaList($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '产品编码,产品名称,问题及问题产品不良率';
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
					$order_value[] =  $list[$i]['error'];
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
			$file = 'data/ordertmp/rmaList'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			$result['totalCount'] =0;
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
		
	/**
	 * 热销产品统计
	 */
	function actionhotgoodssales()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='hotgoodssales';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}
	/**
	 * 热销账户销量统计
	 */
	function actionhotshop()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='hotshop';
		$this->show();
	}
	/**
	 * 月销量统计
	 */
	function actionmonthSales()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='monthSales';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();
	}

	/**
	 *日销量统计 
	 */
	function actiondaysales()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='daysales';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();
	}
	/**
	*订单个数比
	*/
	function actionOrderGoodsRate()
	{
		parent::actionPrivilege('orderGoodsRate_statistics');
		$this->name ='orderGoodsRate';
		$this->tpl->assign('cfg_url','index.php?model=statistics&action=OrderGoodsRateList');
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();
	}
	/**
	*热销产品
	*/
	function actionGetHotGoodsSales()
	{
		
		$object = new ModelStatistics();
		$list = $object->getHotGoodsSales($_REQUEST);
		if($_REQUEST['type']=='export'){
			set_time_limit(0);
            include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
            require_once(CFG_PATH_DATA . 'dd/currency.php');
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
            include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
            $objReader = new PHPExcel_Reader_Excel5();
			echo date('H:i:s') . " Add some data<br>";
			$objPHPExcel->setActiveSheetIndex(0);
			$header = '产品编码,订单量';
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
					$order_value[] =  $list[$i]['good_gross'];
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
			/*include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/hotgoodssales '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();*/
            
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $file = CFG_PATH_DATA.'/ordertmp/hotgoodssales '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xls';
            $file = CFG_PATH_DATA.'ordertmp/goods_list'.$_SESSION['admin_id'].'.xls';
            if(file_exists($file)) unlink($file);
            $objWriter->save($file);//define xls name
            $file = str_replace(CFG_PATH_ROOT, '', $file);
            echo date('H:i:s') . " Done writing files.<br>";
            page::todo($file);
            die();
            
            
		}else{
			require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
			$title = new OFC_Elements_Title( '热销产品前'.$_GET['limit'].'名销售量报表['.$_GET['starttime'].'-'.$_GET['endtime'].']' );
			$bar = new OFC_Charts_Bar();
			$tag = new OFC_Charts_Tag();
			foreach($list as $val){
				$val_arr[]=intval($val['good_gross']);
				$x_label_arr[]= $val['goods_sn'];
			}
			$bar->set_values($val_arr);
			$tag->set_values($val_arr);
			$chart = new OFC_Chart();
			$chart->set_title( $title );
			$chart->add_element( $bar );
			$chart->add_element( $tag );
			$chart->x_axis->labels->labels=$x_label_arr;
			$x_legend = new OFC_Elements_Legend_X('热销产品');
			$x_legend->set_style('{font-size:12px;color:#C11B01;}');
			$chart->set_x_legend( $x_legend );
			$y_legend = new OFC_Elements_Legend_Y('SOLD QUANTITY');
			$y_legend->set_style('{font-size:12px;color:#C11B01;}');
			$chart->set_y_legend( $y_legend );
			$chart->y_axis->min=0;
			$chart->y_axis->max=(empty($val_arr)?0:max($val_arr))*1.5;
			$chart->y_axis->steps=100;
			echo $chart->toPrettyString();
		}
	}	
	/**
	*热销账户
	*/
	function actionGetHotShop()
	{
		
		$object = new ModelStatistics();
		$list = $object->getHotShop($_REQUEST);
		if($_REQUEST['type']=='export'){
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
			$header = '账户,订单量';
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
					$order_value[] =  $list[$i]['account_name'];
					$order_value[] =  $list[$i]['good_gross'];
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
			$file = 'data/ordertmp/hotShop '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			foreach($list as $val){
			$val_arr[]=intval($val['good_gross']);
			$x_label_arr[]=$val['account_name'];
			}
			require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
			$title = new OFC_Elements_Title( '热销账户前'.(empty($_GET['limit'])?5:$_GET['limit']).'排名报表['.$_GET['starttime'].'-'.$_GET['endtime'].']' );
			$bar = new OFC_Charts_Bar();
			$tag = new OFC_Charts_Tag();
			$chart = new OFC_Chart();
			$chart->set_title( $title );
			$chart->x_axis->labels->labels=$x_label_arr;
			$bar->set_values($val_arr);
			$tag->set_values($val_arr);
			$chart->add_element( $bar );
			$chart->add_element( $tag );
			$x_legend = new OFC_Elements_Legend_X('ACCOUNT');
			$x_legend->set_style('{font-size:12px;color:#C11B01;}');
			$chart->set_x_legend( $x_legend );
			$y_legend = new OFC_Elements_Legend_Y('ORDER QUANTITY');
			$y_legend->set_style('{font-size:12px;color:#C11B01;}');
			$chart->set_y_legend( $y_legend );
			$chart->y_axis->min=0;
			$chart->y_axis->max=(!empty($val_arr)?max($val_arr):0)*1.5;
			echo $chart->toPrettyString();
		}
	}
	/**
	*月销售额
	*/
	function actionGetMonthSales()
	{
		$object = new ModelStatistics();
		$result = $object->getMonthSales($_REQUEST);
		$monthArea=$this->getArea($_REQUEST['starttime'],$_REQUEST['endtime']);
		foreach($result as $val){
			$tempYM=$val['yuefei'];
			$val_arr1[$tempYM]=intval($val['order_sale']?$val['order_sale']:0);			
			$x_label_arr[]=$tempYM;
		}
		foreach($monthArea as $val){
			if($x_label_arr && in_array($val,$x_label_arr)){
			$val_arr2[]=$val_arr1[$val];
			}else{
			$val_arr2[]=0;
			}
		}
		if($_REQUEST['type']=='export'){
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
			$header = '月份,销售额';
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
			for($i=0;$i<count($monthArea);$i++){
					$order_value[] =  $monthArea[$i];
					$order_value[] =  $val_arr2[$i];
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
			$file = 'data/ordertmp/monthSales '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
			$title = new OFC_Elements_Title( ($_GET['Sales_account']?ModelDd::getCaption('allaccount',$_GET['Sales_account']):'').'月销售报表['.$_GET['starttime'].'-'.$_GET['endtime'].'](RMB)' );
			$bar = new OFC_Charts_Bar();
			$tag = new OFC_Charts_Tag();
			$val_arr1=$val_arr2;
			$x_label_arr=$monthArea;
			$bar->set_values($val_arr1);
			$bar->colour='#9933CC';
			$chart = new OFC_Chart();
			$chart->set_title( $title );
			$tag->set_values($val_arr1);
			$chart->add_element( $bar );
			$chart->add_element( $tag );
			$chart->x_axis->labels->labels=$x_label_arr;
			$chart->y_axis->min=0;
			$chart->y_axis->max=(empty($val_arr1)?0:max($val_arr1))*1.5;
			if(array_sum($val_arr1)==0) $chart->y_axis->steps=100;
			echo $chart->toPrettyString();
		}
	}
	/**
	*日销售额
	*/	
	function actionGetDaySales()
	{
		
		$object = new ModelStatistics();
		$result = $object->getDaySales($_REQUEST);
		foreach($result as $val){
			$val_arr1[$val['paid_time']]=intval($val['order_sale']?$val['order_sale']:0);
			$x_label_arr[] = $val['paid_time'];
		}
		$dayArea=$this->getArea($_REQUEST['starttime'],$_REQUEST['endtime']);
		foreach($dayArea as $k=>$val){
			if($x_label_arr && in_array($val,$x_label_arr)){
				$val_arr2[]=$val_arr1[$val];
			}else
				$val_arr2[]=0;
		}
		if($_REQUEST['type']=='export'){
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
			$header = '日期,销售额';
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
			for($i=0;$i<count($dayArea);$i++){
					$order_value[] =  $dayArea[$i];
					$order_value[] =  $val_arr2[$i];
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
			$file = 'data/ordertmp/daySales '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
			$title = new OFC_Elements_Title( ($_GET['Sales_account']?ModelDd::getCaption('allaccount',$_GET['Sales_account']):'').'日销售报表['.$_GET['starttime'].'-'.$_GET['endtime'].'](RMB)' );
			$tag = new OFC_Charts_Tag();
			$bar = new OFC_Charts_Bar();
			$bar2 = new OFC_Charts_Bar();
			$val_arr1=$val_arr2;
			$x_label_arr=$dayArea;
			$bar->set_values($val_arr1);
			$bar->colour='#9933CC';
			$chart = new OFC_Chart();
			$chart->set_title( $title );
			$tag->set_values($val_arr1);
			$chart->add_element( $bar );
			$chart->add_element( $tag );
			$chart->x_axis->labels->labels=$x_label_arr;
			$chart->y_axis->min=0;
			$chart->y_axis->max=(empty($val_arr1)?0:max($val_arr1))*1.5;
			if(array_sum($val_arr1)==0) $chart->y_axis->steps=100;
			echo $chart->toPrettyString();
		}
	}
	/**
	*订单个数比
	*/	
	function actionOrderGoodsRateList()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		$title = new OFC_Elements_Title( '订单个数比列' );
		$pie = new OFC_Charts_Pie();
		
		$object = new ModelStatistics();
		$where=$object->orderGoodsRateWhere($_REQUEST);
		$result = $object->orderGoodsRate(0,$_REQUEST['limit']?$_REQUEST['limit']-2:3,$where);
		$counts=$object->getTableCount(CFG_DB_PREFIX.'order',$where);
		$pie->values=NULL;
		$pie->tip= "#label#<br>#val# (#percent#)";
		foreach($result as $re){
			$pie->values[]=array('value'=>(int)$re['counts'],'label'=>'含有'.$re['qty'].'个产品订单个数为'.$re['counts'].'个',"font-size"=>12);
			$qty+=(int)$re['counts'];
		}
		$leavings=$counts-$qty;
		$pie->values[]=array('value'=>$leavings,'label'=>'含有其他个产品订单个数为'.$leavings.'个',"font-size"=>12);
		$pie->set_start_angle( 35 );
		$pie->set_animate( true );
		$chart = new OFC_Chart();
		$chart->set_title( $title );
		$chart->add_element( $pie );
		$chart->x_axis = null;
		echo $chart->toPrettyString();
	}	
	/**
	*订单个数比导出
	*/	
	function actionExportOrderGoodsRate()
	{
		$object = new ModelStatistics();
		$where=$object->orderGoodsRateWhere($_REQUEST);
		//$list = $object->orderGoodsRate(0,$_REQUEST['limit']?$_REQUEST['limit']-2:3,$where);
		$list = $object->orderGoodsRate(null,null,$where);
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
		$header = '产品数,订单量';
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
				$order_value[] =  $list[$i]['qty'];
				$order_value[] =  $list[$i]['counts'];
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
		$file = 'data/ordertmp/ordergoodsrate '.$_REQUEST['starttime'].'-'.$_REQUEST['endtime'].' '.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	/**
	*销售账户排行榜
	**/
	function actionSalesByAccount(){
		$this->name = 'salesByAccount';
		$this->show();
	}
	function actionSalesByAccountList(){
		$object = new ModelStatistics();
		$list = $object->getSalesByAccount($object->getSalesByAccountWhere($_REQUEST));
		if($_REQUEST['type']=='export'){
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
			$header = '销售账户,销售额';
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
					$order_value[] =  $list[$i]['account_name'];
					$order_value[] =  $list[$i]['order_sale'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/salesByAccount'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			$result['totalCount'] = 0;
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	
	/**
	*时间分组 处理查询时间段无数据时使用。
	*使用日分组格式为YYYY-MM-DD
	*月份分组格式为YYYY-MM
	*年份分组格式为YYYY
	*$start,如为2005-02
	*$end,如为2006-02
	*/
	function getArea($start,$end){
		$result=array();
		if(strlen($start)==strlen($end) && strlen($start)>=4){ 
			 $startY=intval(substr($start,0,4));
			 $endY=intval(substr($end,0,4));
			 if($startY<=$endY){
				 if(strlen($start)>=7){
					$startM=intval(substr($start,5,2));
					$endM=intval(substr($end,5,2));
					 if($startY!=$endY){
						 for($i=$startM;$i<=12;$i++){
							 if(strlen($start)==10){
							 	 $startD=intval(substr($start,8,2));
								 $endD=intval(substr($end,8,2));
								 $len=0;
								 switch($i) {
									 case 1: case 3: case 5: case 7: case 8: case 10: case 12:
										$len = 31; 
										break; 
									 case 4: case 6: case 9: case 11: 
										$len = 30; 
										break; 
									 case 2:  
										if($startY%400==0 || ($startY%4==0 && $startY%100==0 ))
											$len = 29;
										else
											$len = 28;
										break;
									 default:
										return;
								 }
								 for($a=($i==$startM?$startD:1);$a<=$len;$a++){
									 $result[]=$startY.'-'.str_pad($i, 2, "0", STR_PAD_LEFT).'-'.str_pad($a, 2, "0", STR_PAD_LEFT);
								 }
							 }else if (strlen($start)==7){ 
								 $result[]=$startY.'-'.str_pad($i, 2, "0", STR_PAD_LEFT);
							 }else{
								 return;
							 }
						 }
						 for($j=1;$j<$endY-$startY;$j++){
							 for($i=1;$i<=12;$i++){
								 if(strlen($start)==10){
								 	$startD=intval(substr($start,8,2));
								  $endD=intval(substr($end,8,2));
									 $len=0;
									 switch($i) {
										 case 1: case 3: case 5: case 7: case 8: case 10: case 12:
											$len = 31; 
											break; 
										 case 4: case 6: case 9: case 11: 
											$len = 30; 
											break; 
										 case 2:  
											if(($startY+$j)%400==0 || (($startY+$j)%4==0 && ($startY+$j)%100==0 ))
												$len = 29;
											else
												$len = 28;
											break;
										 default:
											return;
									 }
									 for($a=1;$a<=$len;$a++){
										 $result[]=$startY+$j.'-'.str_pad($i, 2, "0", STR_PAD_LEFT).'-'.str_pad($a, 2, "0", STR_PAD_LEFT);
									 }
								 }else if (strlen($start)==7){ 
									 $result[]=($startY+$j).'-'.str_pad($i, 2, "0", STR_PAD_LEFT);
								 }else{
									 return;
								 }
							 }
						 }
					 }
					 for($i=($startY==$endY?$startM:1);$i<=$endM;$i++){
						 if(strlen($start)==10){
						 	 $startD=intval(substr($start,8,2));
							 $endD=intval(substr($end,8,2));
							 $len=0;
							 switch($i) {
								 case 1: case 3: case 5: case 7: case 8: case 10: case 12:
									$len = 31; 
									break; 
								 case 4: case 6: case 9: case 11: 
									$len = 30; 
									break; 
								 case 2:  
									if($endY%400==0 || ($endY%4==0 && $endY%100==0 ))
										$len = 29;
									else
										$len = 28;
									break;
								 default:
									return;
							 }
							 for($a=($i==$startM?$startD:1);$a<=($i==$endM?$endD:$len);$a++){
								 $result[]=$endY.'-'.str_pad($i, 2, "0", STR_PAD_LEFT).'-'.str_pad($a, 2, "0", STR_PAD_LEFT);
							 }
						 }else if (strlen($start)==7){ 
							 $result[]=$endY.'-'.str_pad($i, 2, "0", STR_PAD_LEFT);
						 }else{
							 return;
						 }
					 }
				 }else if (strlen($start)==4){ 
					 for($n=$startY;$n<=$endY;$n++){
				 		$result[]=$n;
					 }
				 }else{
					 return;
				 }
			  }
		 }
		 return $result;
	}
	/**
	 *销售国家统计export
	 */
	function actionexportCountryStat()
	{
		$object = new ModelStatistics();
		$where=$object->CountryStatWhere($_REQUEST);
		$list=$object->getCountryStat(null,null,$where);
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
		$header = '国家,金额';
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
			$order_value[] =  $list[$i]['country'];
			$order_value[] =  $list[$i]['money'];
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
		if($showtable) echo '</tr>';
		unset($order_value);
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/yearList'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	/**
	*订单情况表
	*/
	function actionordercircs(){
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->name ='ordercircs';
		$this->show();
	}
	function actionordercircsList()
	{
		if($_REQUEST['totime'] <> '' && $_REQUEST['starttime'] <> ''){
			$object = new ModelStatistics();
			$datas=$object->getOrderCircs($object->OrderCircsWhere($_REQUEST));
			$dayArea=$this->getArea($_REQUEST['starttime'],$_REQUEST['totime']);
			for($j=count($dayArea)-1;$j>=0;$j--){
				$val=$dayArea[$j];
				$bool=true;
				for($i=0;$i<count($datas);$i++){
					if($val && $val==$datas[$i]['paid_times']){
						$bool=false;
						$list[]=$datas[$i];
						break;
					}
				}
				if($bool){
					$list[]=array('paid_times'=>$val,'counts'=>0,'qtys'=>0);
				}
			}
		}
		if($_REQUEST['type']=='export'){
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
			$header = '时间,订单量,销售量';
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
				$order_value[] =  $list[$i]['paid_times'];
				$order_value[] =  $list[$i]['counts'];
				$order_value[] =  $list[$i]['qtys'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/ordercircsList'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			$result['totalCount'] = 0;
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	/**
	 * 订单区间action
	 */
	function actionOrderinterzone()
	{
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->name ='Orderinterzone';
		$this->show();
	}
	/**
	 * 订单区间
	 */
	function actionGetOrderinterzone()
	{
		$object = new ModelStatistics();
		$interzones=array(5,10,50,100,200,500,1000,2000,5000,5001);
		$list = $object->GetOrderinterzone($interzones,$object->OrderinterzoneWhere($_REQUEST));
		if($_REQUEST['type']=='export'){
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
			$header = '所属金额区间,订单个数';
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
					$order_value[] =  $list[$i]['interzone'];
					$order_value[] =  $list[$i]['counts'];
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
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/Orderinterzone'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();		
		}else{
			$result['totalCount'] = 0;
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	/**
	 * 客户购买排名action
	 */
	function actionBuytimes()
	{
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->name = 'buytimes';
		$this->show();
	}
	/**
	 * 客户购买排名
	 */
	function actionGetBuytimes()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getBuytimesWhere($_REQUEST);
		$list = $object->getBuytimes($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getBuytimesCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);	
		
	}
	/**
	 * 客户购买排名导出
	 */
	function actionExportBuytimes()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$list = $object->getBuytimes(null,null,$object->getBuytimesWhere($_REQUEST));
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
		$header = '客户姓名号,购买次数';
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
			$order_value[] =  $list[$i]['userid'];
			$order_value[] =  $list[$i]['order_count'];
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
		if($showtable) echo '</tr>';
		unset($order_value);
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/Buytimes'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();		
	}
	/**
	 * 单商品报表action
	 */
	function actionOneGoodsReport()
	{
		die("暂时关闭此统计");
		$this->name = 'onegoodsreport';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}
	/**
	 *单商品报表
	 */
	function actionGetOneGoodsReport()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getOneGoodsReportWhere($_REQUEST);
		$list = $object->getOneGoodsReport($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getOneGoodsReportCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);		
	}
	
	/**
	 *单商品报表导出
	 */
	function actionExportOneGoodsReport()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getOneGoodsReportWhere($_REQUEST);
		$list = $object->getOneGoodsReport(null,null,$where);
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
		$header = '日期,销售量,售价';
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
			$order_value[] =  $list[$i]['add_time'];
			$order_value[] =  $list[$i]['goods_sale'];
			$order_value[] =  $list[$i]['goods_price'];
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
		if($showtable) echo '</tr>';
		unset($order_value);
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/OneGoodsReport'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();			
	}
	/**
	 * 利润率区间 action
	 */
	function actionProfitinterzone()
	{
		$this->name = 'profitinterzone';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));			
		$this->show();
	}	
	/**
	 * 利润率区间
	 */
	function actionGetProfitinterzone()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getProfitinterzoneWhere($_REQUEST);
		$list = $object->getProfitinterzone($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getProfitinterzoneCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);	
	}
	/**
	 * 利润率区间
	 */
	function actionexportProfitinterzone()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getProfitinterzoneWhere($_REQUEST);
		$list = $object->getProfitinterzone(null,null,$where);
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
		$header = '日期,商品编号,销售额,销量,成本价,利润';
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
			$order_value[] =  $list[$i]['times'];
			$order_value[] =  $list[$i]['goods_sn'];
			$order_value[] =  $list[$i]['money'];
			$order_value[] =  $list[$i]['counts'];
			$order_value[] =  $list[$i]['cost'];
			$order_value[] =  $list[$i]['profit'];
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
		if($showtable) echo '</tr>';
		unset($order_value);
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/Profitinterzone'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();	
	}
	/**
	 * 商品分类销售
	 */
	function actionGoodsTypeSale()
	{
		$this->name = 'goodstypesale';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));	
		$this->show();
	}
	/**
	*商品分类销售
	*/
	function actionGetGoodsTypeSale()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getGoodsTypeSaleWhere($_REQUEST);
		$list = $object->getGoodsTypeSale($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getGoodsTypeSaleCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);	
	}
	/**
	*商品分类销售导出
	*/
	function actionexportGoodsTypeSale()
	{
		$pageLimit = getPageLimit();
		$object = new ModelStatistics();
		$where = $object->getGoodsTypeSaleWhere($_REQUEST);
		$list = $object->getGoodsTypeSale(null,null,$where);
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
		$header = '日期,销售量,销售额,成本价,利润';
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
			$order_value[] =  $list[$i]['times'];
			$order_value[] =  $list[$i]['goods_sale'];
			$order_value[] =  $list[$i]['goods_price'];
			$order_value[] =  $list[$i]['costs'];
			$order_value[] =  $list[$i]['profit'];
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
		if($showtable) echo '</tr>';
		unset($order_value);
		if($showtable) echo '</table>';
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
		$file = 'data/ordertmp/GoodsTypeSale'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();	
	}
	
	
}
?>