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
 * 供应商管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Supplier extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '供应商管理';
		$this->name = 'supplier';
		$this->dir = 'purchase';
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_supplier');     
		$this->show();
	}

	/**
	 * 保存供应商信息
	 */
	function actionUpdate() {
		if(parent::actionCheck('edit_supplier')) {
			$object = new ModelSupplier();
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
	 * 删 除供应商
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('edit_supplier')) {
			$object = new ModelSupplier();
			$object->delsupplier($_GET['ids']);
			parent::actionDelete('ModelSupplier');
		}
	}

	/**
	 * 获得分类列表数据
	 */
	public function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSupplier();
		$where = $object->getlistwhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
		
		
	}

	function actionUserList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSupplier();
		$where = $object->getlistwhere($_REQUEST['key']);
		$list = $object->getUserList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getlistCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	/**
	 * 返回供应商产品 json列表
	 *
	 */
	function actionGoodslist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSupplier();
		$where = $object->getGoodsWhere($_REQUEST);
		$list = $object->getGoodsList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getGoodsCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/******
	**清空供应商产品
	**
	******/
	function actiongoodsclear()
	{
		if(parent::actionCheck('edit_supplier_goods')) {
			$object = new ModelSupplier();
			try {
					$object->goodsclear($_POST['id']);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	function actionexportGoods()
	{
		$object = new ModelSupplier();
		$where = $object->getGoodsWhere($_REQUEST);
		$list = $object->getGoodsList(0,$object->getGoodsCount($where),$where);
				include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
				echo date('H:i:s') . " Create new PHPExcel object\n";
				$objPHPExcel = new PHPExcel();
				echo date('H:i:s') . " Set properties<br>";
				$objPHPExcel->getProperties()->setCreator("Vekincheng");
				echo date('H:i:s') . " Add some data<br>";
				$currentSheet =$objPHPExcel->getSheet(0);
		echo date('H:i:s') . " Add some data<br>";
		$objPHPExcel->setActiveSheetIndex(0);
		$header ='产品编码,供应商编码,供应商名称,供应商价格,备注,采购链接';
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
				$order_value[] =  $list[$i]['supplier_goods_sn'];
				$order_value[] =  $list[$i]['supplier_goods_name'];
				$order_value[] =  $list[$i]['supplier_goods_price'];
				$order_value[] =  $list[$i]['supplier_goods_remark'];
				$order_value[] =  $list[$i]['url'];
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
				$file = CFG_PATH_DATA.'ordertmp/planlist'.$_SESSION['admin_id'].'.xls';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				$file = str_replace(CFG_PATH_ROOT, '', $file);
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();		
	}
	
	/**
	 * 返回供应商产品 json列表-----查找产品供应商
	 *
	 */
	function actionSearchgoods()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSupplier();
		$where = $object->getSearchWhere($_REQUEST);
		$list = $object->getsearchGoods($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getSearchCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	
	/**
	 * 返回供应商产品更新
	 *
	 */
	function actionGoodsupdate()
	{
		if(parent::actionCheck('edit_supplier_goods')) {
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				$goodsarr = $json->decode(stripslashes($_POST['data']));
				foreach($goodsarr as $good){
					$good->supplier_goods_name = addslashes_deep($good->supplier_goods_name);
					$good->supplier_goods_remark = addslashes_deep($good->supplier_goods_remark);
					$good->supplier_goods_sn = addslashes_deep($good->supplier_goods_sn);
					if($good->supplier_goods_sn == "" || $good->supplier_goods_name == "") {
					echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
					}
				}
				$_POST['data'] = $goodsarr;
			$object = new ModelSupplier();
			try {
					$object->save_goods($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除产品
	 *
	 */
	function actionGoodsdelete()
	{
		$object = new ModelSupplier();
		$object->delsuppliergoods($_GET['id']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	/**
	 * 导入产品
	 */
	function actionImport() {
		parent::actionPrivilege('import_supplier_goods');
		$this->name = 'importsuppliergoods';
		$this->show();
	}
	/**
	 * 导入供应商产品处理
	 */
	function actionimportsuppiler()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path1']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelSupplier();
		$goods = new ModelGoods();
		$err = 0;
		$msg ='';
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
				$info['name']=$currentSheet->getCell('A'.$currentRow)->getValue();
				$info['sn']=$currentSheet->getCell('B'.$currentRow)->getValue();
				$info['contact']=$currentSheet->getCell('C'.$currentRow)->getValue();
				$info['address']=$currentSheet->getCell('D'.$currentRow)->getValue();
				$info['tel']=$currentSheet->getCell('E'.$currentRow)->getValue();
				$info['zip']=$currentSheet->getCell('F'.$currentRow)->getValue();
				$info['Email']=$currentSheet->getCell('G'.$currentRow)->getValue();
				$info['skype']=$currentSheet->getCell('H'.$currentRow)->getValue();
				$info['qq']=$currentSheet->getCell('I'.$currentRow)->getValue();
				$info['period']=$currentSheet->getCell('J'.$currentRow)->getValue();
				$info['comment']=$currentSheet->getCell('K'.$currentRow)->getValue();
				$info['id'] = $object->getsupplierid($info['sn']);
			try {
				$object->save($info);
			} catch (Exception $e) {
					$err = 1;
					$msg .= $info['name'].'数据保存失败<br>';
			}
		}
		if($err == 1){
			 echo "{success:false,msg:'$msg'}";exit;
		}
		 echo "{success:true,msg:'供应商导入成功'}";exit;
	}
	/**
	 * 导入供应商产品处理
	 */
	function actionUpload()
	{
		set_time_limit(0);
		parent::actionPrivilege('import_supplier_goods');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelSupplier();
		$goods = new ModelGoods();
		$err = 0;
		$msg ='';
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info = $goods->goods_info('',$currentSheet->getCell('A'.$currentRow)->getValue());
			$info['goods_id'] =$goods_info['goods_id'];
			$info['supplier_goods_sn'] = $currentSheet->getCell('B'.$currentRow)->getValue();
			$info['supplier_goods_name'] = $currentSheet->getCell('C'.$currentRow)->getValue();
			$info['supplier_goods_price'] = $currentSheet->getCell('D'.$currentRow)->getValue();
			$info['supplier_goods_remark'] = $currentSheet->getCell('E'.$currentRow)->getValue();
			$info['url'] = $currentSheet->getCell('F'.$currentRow)->getValue();
			$info['supplier_id'] = $_POST['supplier'];
			try {
				$object->import($info);
			} catch (Exception $e) {
					$err = 1;
					$msg .= $info['supplier_goods_sn'].'数据保存失败<br>';
			}
		}
		if($err == 1){
			 echo "{success:false,msg:'$msg'}";exit;
		}
		 echo "{success:true,msg:'供应商产品导入成功'}";exit;
	}
	/**
	 * 导出所有供应商的产品
	 */
	function actionSupplierGoods(){
		$object = new ModelSupplier();
		$where=$object->getSupplierGoodsWhere($_REQUEST);
		$list = $object->getSupplierGoods($where);
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
			$header = '供应商ID,供应商名称,产品编码,供应商编码,供应商名称,供应商价格,采购链接,备注';
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
					$order_value[] =  $list[$i]['supplier_id'];
					$order_value[] =  $list[$i]['supplier_name'];
					$order_value[] =  $list[$i]['goods_sn'];
					$order_value[] =  $list[$i]['supplier_goods_sn'];
					$order_value[] =  $list[$i]['supplier_goods_name'];
                    $order_value[] =  $list[$i]['supplier_goods_price'];
					$order_value[] =  $list[$i]['url'];
					$order_value[] =  $list[$i]['supplier_goods_remark'];
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
			$file = CFG_PATH_DATA.'ordertmp/planlist'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			$file = str_replace(CFG_PATH_ROOT, '', $file);
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
}
?>