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
 * 库存管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Inventory extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '当前库存';
		$this->name = 'index';
		$this->dir = 'Inventory';
	}
	/**
	 * 产品库存列表
	 */
	function actionStock() {
		parent::actionPrivilege('list_stock');
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->show();
	}
	/**
	 * 获取产品当前库存列表
	 */
	function actiongoodslist()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelInventory();
		$where = $obejct->getWhere($_REQUEST);
		$list = $obejct->getGoodsList($pageLimit['from'],$pageLimit['to'],$where,0,$pageLimit['sort'],$_REQUEST['depot'],$_REQUEST['is_warn']);
		$result['totalCount'] = $obejct->getGoodsCount($where,$_REQUEST['is_warn']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionexportgoods() {
		set_time_limit(0);
		$object = new ModelInventory();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getGoodsList('','',$where,1,'',$_REQUEST['depot'],$_REQUEST['is_warn']);
				include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
				echo date('H:i:s') . " Create new PHPExcel object\n";
				$objPHPExcel = new PHPExcel();
				echo date('H:i:s') . " Set properties<br>";
				$objPHPExcel->getProperties()->setCreator("Vekincheng");
				echo date('H:i:s') . " Add some data<br>";
				$currentSheet =$objPHPExcel->getSheet(0);
				$header = '产品编码,产品名称,SKU,可用库存,库存数量,锁定库存,报警库存,采购在途,调拨锁定,调拨在途,';
				$depotlist = ModelDd::getArray('shelf');
				$header .= implode(",",$depotlist);
				$content = explode(",",$header);
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
					$cf ='A';
						$order_value[] =  $list[$i]['goods_sn'];
						$order_value[] =  $list[$i]['goods_name'];
						$order_value[] =  $list[$i]['SKU'];
						$order_value[] =  $list[$i]['goods_qty']-$list[$i]['varstock'];
						$order_value[] =  $list[$i]['goods_qty'];
						$order_value[] =  $list[$i]['varstock'];
						$order_value[] =  $list[$i]['warn_qty'];
						$order_value[] =  $list[$i]['Purchase_qty'];
						$order_value[] =  $list[$i]['db_pre_qty'];
						$order_value[] =  $list[$i]['db_qty'];
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
				$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
				$file = CFG_PATH_DATA.'ordertmp/Stocklist'.$_SESSION['admin_id'].'.xlsx';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				$file = str_replace(CFG_PATH_ROOT, '', $file);
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();	
	}
	
	/**
	 * 产品盘点单
	 */
	function actionCheck() {
		parent::actionPrivilege('stock_check');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->name = 'Check';
		$this->show();
	}
	/**
	 * 产品盘点单列表
	 */
	function actionChecklist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelInventory();
		$list = $object->getcheckList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getcheckCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 生成盘点
	 */
	function actionaddcheckorder()
	{
		$Inventory = new ModelInventory();
		try{
			$Inventory->savecheckorder($_POST);
			echo "{success:true,msg:'盘点单生成成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/*****
	*操作盘点
	*****/
	function actionStartcheck()
	{
		$this->tpl->assign('order_id',$_GET['id']);
		$this->name = 'startcheck';
		$this->show();
	}
	
	function actionchecklistdetail()
	{
		$pageLimit = getPageLimit();
		$object = new ModelInventory();
		$where = $object->getcheckdetailWhere($_REQUEST);
		$list = $object->getcheckdetailList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getcheckdetailCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionSavecheck()
	{
		$Inventory = new ModelInventory();
		try{
			$Inventory->savecheck($_REQUEST);
			echo "{success:true,msg:'盘点成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	function actionUpdatecheck()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$field_list = array();
		$Inventory = new ModelInventory();
		$info['order_id'] = $_REQUEST['order_id'];
		$err = 0;
		$msg ='';
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			try {
				$info['sku'] = trim($currentSheet->getCell("A".$currentRow)->getValue());
				$info['qty'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
				$Inventory->savecheck($info);
			} catch (Exception $e) {
					$err = 1;
					$msg .= $info['sku'].'盘点数据保存失败<br>';
			}
		}
		if($err == 1){
			 echo "{success:false,msg:'$msg'}";exit;
		}
		 echo "{success:true,msg:'盘点数据更新成功'}";exit;		
	}
	function actionexportcheck()
	{
		$Inventory = new ModelInventory();
		$info['order_id'] = $_GET['order_id'];
		$where = $Inventory->getcheckdetailWhere($info);
		$list = $Inventory->getcheckdetailList(0,1000,$where,1);
		include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
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
		$header = '产品编码,产品名称,SKU,账面库存,盘点库存,是否盘点';
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
		$currentSheet =$objPHPExcel->getSheet(0);
		echo date('H:i:s') . " Write to Excel5 format<br>";
		$t =2;
		for($i=0;$i<count($list);$i++){
				$order_value[] =  $list[$i]['goods_sn'];
				$order_value[] =  $list[$i]['goods_name'];
				$order_value[] =  $list[$i]['SKU'];
				$order_value[] =  $list[$i]['stock_qty'];
				$order_value[] =  $list[$i]['check_qty'];
				$order_value[] =  $list[$i]['is_ok'];
				if($showtable) echo '<tr>';
						$currentSheet->setCellValueExplicitByColumnAndRow(0,$t, $order_value[0]);
						for($m =1;$m<count($order_value);$m++){
							$currentSheet->setCellValueByColumnAndRow($m,$t, $order_value[$m]);
							if($showtable) echo '<td>'.$order_value[$m].'</td>';
						}
				if($showtable) echo '</tr>';
				unset($order_value);
				$t++;
		}
		if($showtable) echo '</table>';
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$file = CFG_PATH_DATA.'ordertmp/checklist'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) @unlink($file);
		$objWriter->save($file);//define xls name
		$file = str_replace(CFG_PATH_ROOT, '', $file);
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	
	function actionCompletecheck()
	{
		$Inventory = new ModelInventory();
		try{
			$Inventory->comcheck($_REQUEST);
			echo "{success:true,msg:'操作已成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	
	function actionFinishcheck()
	{
		set_time_limit(0);
		$Inventory = new ModelInventory();
		$Inventory->finishcheck($_REQUEST);
	}
	
	
	/**************
	***库存调换
	*************/
	function actionStockchange()
	{
		parent::actionPrivilege('change_stock');
		$this->tpl->assign('shelf',ModelDd::getComboData('shelf'));
		$this->name = 'stockchange';
		$this->show();
	}
	
	/************
	***产品调换处理
	************/
	function actionSavestockchange()
	{
		set_time_limit(0);
		$Inventory = new ModelInventory();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $goods){
			$goods->sku1 = addslashes_deep($goods->sku1);
			$goods->sku2 = addslashes_deep($goods->sku2);
			if($goods->sku1 == "" || $goods->sku2 == "") {
			echo "{success:false,msg:'调整产品编码不能为空'}";exit;
			}
		}
		$_POST['data'] = $goodsarr;
		try{
			$msg = $Inventory->savestockchange($_POST);
			echo "{success:true,msg:'$msg'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**************
	**仓库货架
	**************/
	function actionShelf()
	{
		parent::actionPrivilege('list_shelf');
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->name = 'shelf';
		$this->show();
	}
	
    function actionShelflist()
    {
        $pageLimit = getPageLimit();
        $object = new ModelInventory();
        $list = $object->getshelfList($pageLimit['from'],$pageLimit['to']);
        $result['totalCount'] = $object->getshelfCount();
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
	function actionDepotlist()
	{
		$dd = new ModelDd();
        $list = $dd->getItemList(17);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
	}
	
	function actionshelfsave()
	{
			$object = new ModelInventory();
			try {
					$object->shelfsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
    function actiondepotsave()
    {
        try {
            $dd = new ModelDd();
            $_POST['dd_id'] = 17;
            $dd->save($_POST);
            echo "{success:true,msg:'OK'}";exit;    
        } catch (Exception $e) {
            echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
        }
    }
    function actionshelfdelete()
    {
        $object = new ModelInventory();
        try {
                $object->shelfdel($_GET['ids']);
                echo "{success:true,msg:'操作已成功'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:false,msg:'" . $errorMsg . "'}";exit;
    }
	function actiondepotdelete()
	{
		parent::actionDelete('ModelDd');
	}
	/**************
	**调拨单
	**************/
	function actionAllocation()
	{
		//parent::actionPrivilege('goods_allocation');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('db_status',ModelDd::getComboData('db_status'));
		$this->tpl->assign('first_shipping',ModelDd::getComboData('first_shipping'));
		$this->tpl->assign('db_shipping',ModelDd::getComboData('db_shipping'));
		$this->name = 'allocation';
		$this->show();
	}
	/**************
	***调拨单列表
	**************/
	function  actionAllocationlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelInventory();
		$where = $object->getallocationWhere($_REQUEST);
		$list = $object->getallocationList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getallocationCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**************
	***导出调拨单列表
	**************/
	function actionexportAllocation()
	{
		$object = new ModelInventory();
		$info['order_id'] = $_GET['order_id'];
		$where = $object->getallocationWhere($_REQUEST);
		$list = $object->getallocationList($pageLimit['from'],$pageLimit['to'],$where,1);
		include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
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
		$header = '调拨单号,总数,箱数,重量,头程渠道,物流方式,追踪单号,发货仓,到货仓,操作员,状态,在途天数,完成时间,备注';
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
		$currentSheet =$objPHPExcel->getSheet(0);
		echo date('H:i:s') . " Write to Excel5 format<br>";
		$t =2;
		for($i=0;$i<count($list);$i++){
				$order_value[] =  $list[$i]['order_sn'];
				$order_value[] =  $list[$i]['totalamt'];
				$order_value[] =  $list[$i]['count'];
				$order_value[] =  $list[$i]['weight'];
				$order_value[] =  $list[$i]['first_shipping'];
				$order_value[] =  $list[$i]['db_shipping'];
				$order_value[] =  $list[$i]['track_no'];
				$order_value[] =  $list[$i]['depot_id_from'];
				$order_value[] =  $list[$i]['depot_id_to'];
				$order_value[] =  $list[$i]['add_user'];
				$order_value[] =  $list[$i]['status'];
				$order_value[] =  $list[$i]['delay_time'];
				$order_value[] =  $list[$i]['out_time'];
				$order_value[] =  $list[$i]['comment'];
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
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$file = CFG_PATH_DATA.'ordertmp/allocatio'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) @unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	
	
	/**************
	***调拨单导入
	**************/
	function actionImport()
	{
		parent::actionPrivilege('allocation_import');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('db_shipping',ModelDd::getComboData('db_shipping'));
		$this->tpl->assign('first_shipping',ModelDd::getComboData('first_shipping'));
		$this->name = 'allocationimport';
		$this->show();
	}
	function actionUpload()
	{
		set_time_limit(0);
		parent::actionPrivilege('allocation_import');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$order = new ModelInventory();
		$order_info = array();
		$order_info['order_sn'] = $order->get_order_sn();
		$order_info['depot_id_to'] = $_POST['depot_id_to'];
		$order_info['depot_id_from'] = $_POST['depot_id_from'];
		$order_info['track_no'] = $_POST['track_no'];
		$order_info['comment'] = '导入数据';
		$order_info['status'] = 0;
		$order_info['operator_id'] = $_SESSION['admin_id'];
		$goods = new ModelGoods();
		$goodsarr = array();
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$good->goods_id =$goods->getidBySKU($currentSheet->getCell('A'.$currentRow)->getValue());
			$good->goods_qty = $currentSheet->getCell('B'.$currentRow)->getValue();
			$good->no = $currentSheet->getCell('C'.$currentRow)->getValue();
			$goodsarr[] = $good;
			unset($good);
		}
		$order_info['data'] = $goodsarr;
			try {
				$order->saveallocation($order_info);
			} catch (Exception $e) {
					echo "{success:false,msg:'".$e->getMessage()."'}";exit;
			}
		 echo "{success:true,msg:'调拨单导入成功'}";exit;
	}
	function actionAddallocation()
	{
		//parent::actionPrivilege('allocation_import');
		$this->tpl->assign('order_status',ModelDd::getComboData('db_status'));
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('db_shipping',ModelDd::getComboData('db_shipping'));
		$this->tpl->assign('first_shipping',ModelDd::getComboData('first_shipping'));
		$object = new ModelInventory();
		if($_GET['order_id']){
			$rs = $object->allocation_order_info($_GET['order_id']);
		}else{
			$rs = array(
					"order_id" => "",
					"order_sn" => "",
					"operator_id" => $_SESSION['admin_id'],
					"depot_id_from" => 0,
					"depot_id_to" => 0,
					"status" => 0,
					"db_shipping"=>0,
					"first_shipping"=>1
					);
			$rs['order_sn'] = $object->get_order_sn();
		}
		$rs['order_sn'] = CFG_DB_ORDER_PREFIX.$rs['order_sn'];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($rs);
		$this->tpl->assign('order',$order); 
		$this->name = 'allocationAdd';
		$this->show();
	}
	/*************
	*保存调拨单
	*************/
	function actionSaveallocation()
	{
		set_time_limit(0);
		$object = new ModelInventory();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $goods){
			$goods->goods_name = addslashes_deep($goods->goods_name);
			if($goods->goods_name == "" || $goods->goods_sn == "") {
			echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
			}
		}
		$_POST['data'] = $goodsarr;
		try{
			$msg = $object->saveallocation($_POST);
			echo "{success:true,msg:'$msg'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	function actiongetallocationgoods()
	{
			if(!$_GET['order_id']&&!$_POST['order_id']) return;
			$pageLimit = getPageLimit();
			$object = new ModelInventory();
			$result['totalCount'] = $object->getallocationgoodsCount($_POST['order_id']);
			if($pageLimit['to'] == 30) $pageLimit['to'] = $result['totalCount'];
			$list = $object->allocation_goods_info($pageLimit['from'],$pageLimit['to'],$_POST['order_id']);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	
	function actiondelallocationgoods()
	{
		$object = new ModelInventory();
		try{
			$object->delallocationgoods($_GET['id']);
			echo "{success:true,msg:'操作成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**
	 * 更新调拨单状态
	 */
	function actionUpdateallocation() {
		set_time_limit(0);
		//if(parent::actionCheck('edit_db_order')) {
			$object = new ModelInventory();
			try {
					$object->updateallocation($_GET);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		//}
	}
	function actionupdateallocationgoods()
	{
		$object = new ModelInventory();
		try{
			echo $object->updateallocationgoods($_POST['id']);exit;	
		} catch (Exception $e) {
			echo $e->getMessage();exit;
		}
	}
	/**
	 * 打印入库单信息
	 */
	function actionprintallocation(){
		set_time_limit(0);
		$object = new ModelInventory();
		$count = $object->getallocationgoodsCount($_GET['order_id']);
		$order_info = $object->allocation_order_info($_GET['order_id']);
		$user = new ModelUser();
		$this->tpl->assign('order_sn',CFG_DB_ORDER_PREFIX.$order_info['order_sn']);
		$str = "<table width='100%'><tr><td>产品总数:".$order_info['total_qty']."</td><td>调出仓:".ModelDd::getCaption('shelf',$order_info['depot_id_from'])."</td><td>调入仓:".ModelDd::getCaption('shelf',$order_info['depot_id_to'])."</td><td>操作人:".$user->getName($order_info['operator_id'])."</td><td>录入时间:".MyDate::transform('date',$order_info['add_time'])."</td><td>出库时间</td><td>".MyDate::transform('date',$order_info['out_time'])."</td><td>备注:".$order_info['comment']."</td></tr></table>";
		$this->tpl->assign('infopart',$str); 
		$action_list = explode(',',$_SESSION['action_list']);
		$goods_right[] = 0;
		$this->tpl->assign('listheader',"<tr><td>产品编码</td><td>名称</td><td>数量</td><td>备注</td></tr>"); 
		$this->tpl->assign('listpart',$object->allocation_goods_info(0,$count,$_GET['order_id']));
		$this->dir = 'system';
		$this->name = 'order_print';
		$this->show();
	}
	
}
?>