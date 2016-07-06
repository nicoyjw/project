<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 采购激活
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Stockout extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '出库单';
		$this->name = 'stockout';
		$this->dir = 'Inventory';
		$action_list = explode(',',$_SESSION['action_list']);
		$goods_right[] = in_array('view_cost',$action_list)?1:0;
		$goods_right[] = in_array('edit_cost',$action_list)?1:0;
		if($_SESSION['action_list'] == 'all'){
				foreach($goods_right as $k => $v){
					$goods_right[$k] = 1;
					}
			}
		$result = array();
		foreach ($goods_right as $key => $value) {
			$result[] = '[\''.$key.'\',\''.$value.'\']';
		}
		$string = implode(',',$result);
		
		$this->tpl->assign('user_action',$string);
		$this->tpl->assign('view_cost',$goods_right[0]);
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_stockout');
		$this->show();
	}
	/**
	 * 默认页面---订单添加修改
	 */
	function actionAdd() {
		parent::actionPrivilege('add_stockout');
		$this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->tpl->assign('order_status',ModelDd::getComboData('o_status'));
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('stockout_type',ModelDd::getComboData('stockout_type'));
		$Stockout = new ModelStockout();
		if($_GET['order_id']){
			$rs = $Stockout->order_info($_GET['order_id']);
		}else{
			$rs = array(
					"order_id" => "",
					"order_sn" => "",
					"operator_id" => $_SESSION['admin_id'],
					"stocktype" => 1,
					"status" => 0
					);
			$rs['order_sn'] = $Stockout->get_order_sn();
		}
		$rs['order_sn'] = CFG_OUT_ORDER_PREFIX.$rs['order_sn'];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($rs);
		$this->tpl->assign('order',$order); 
		$this->name = 'StockoutAdd';
		$this->show();
	}
	/**
	 * 保存出库单信息
	 */
	function actionUpdate() {
		set_time_limit(0);
		if(parent::actionCheck('edit_out_order')) {
			$Stockin = new ModelStockout();
			try {
					$Stockin->update($_GET);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}

	/**
	 * 订单保存
	 */
	function actionSave(){
		set_time_limit(0);
		$Stockin = new ModelStockout();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $goods){
			$goods->goods_name = addslashes_deep($goods->goods_name);
			if($goods->goods_name == "" || $goods->goods_sn == "") {
			echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
			}
			$goods->remark = addslashes_deep($goods->remark);
		}
		$_POST['data'] = $goodsarr;
		try{
			$msg = $Stockin->save($_POST);
			echo "{success:true,msg:'$msg'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}	/**
	 * 获得出库单列表数据
	 */
	function actionList()
	{if($_REQUEST['type']=='export'){
			$object = new ModelStockout();
			$where = $object->getWhere($_REQUEST);
			$count=$object->getExportCount($where);
			if($count>1500){
				echo "导出的数据量超过1500条，请将条件范围缩小后，再进行导出，谢谢合作。";
				exit;
			}
			$list = $object->getExportList($where);
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
			$header = '出库单号,仓库,数量总计,价格总计,出库类型,出库员,状态,录单时间,出库时间,出库单备注,产品编码,产品名称,产品数量,产品价格,价格总计,关联单据,出库单产品备注';
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
				$goodsList = $object->goods_info('',$object->getgoodsCount($list[$i]['order_id']),$list[$i]['order_id']);
				for($j=0;$j<count($goodsList);$j++){
					$order_value=array();
					$order_value[]=$list[$i]['order_sn'];
					$order_value[]=$list[$i]['depot_id'];
					$order_value[]=$list[$i]['totalqty'];
					$order_value[]=$list[$i]['totalprice'];
					$order_value[]=$list[$i]['stocktype'];
					$order_value[]=$list[$i]['operator'];
					$order_value[]=$list[$i]['status'];
					$order_value[]=$list[$i]['add_time'];
					$order_value[]=$list[$i]['out_time'];
					$order_value[]=$list[$i]['comment'];
					$order_value[]=$goodsList[$j]['goods_sn'];
					$order_value[]=$goodsList[$j]['goods_name'];
					$order_value[]=$goodsList[$j]['goods_qty'];
					$order_value[]=$goodsList[$j]['goods_price'];
					$order_value[]=$goodsList[$j]['goods_qty']*$goodsList[$j]['goods_price'];
					$order_value[]=$goodsList[$j]['relate_order_sn'];
					$order_value[]=$goodsList[$j]['remark'];
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
			}
			if($showtable) echo '</tr>';
			unset($order_value);
			if($showtable) echo '</table>';
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/Stockout'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();	
		}else{
			$pageLimit = getPageLimit();
			$Stockin = new ModelStockout();
			$where = $Stockin->getWhere($_REQUEST);
			$list = $Stockin->getList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $Stockin->getCount($where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	
	/**
	 * 获得出库单产品明细
	 */
	function actionGetgoods(){
			if(!$_REQUEST['order_id']) return;
			$pageLimit = getPageLimit();
			$Stockin = new ModelStockout();
			$result['totalCount'] = $Stockin->getgoodsCount($_POST['order_id']);
			if($pageLimit['to'] == 30) $pageLimit['to'] = $result['totalCount'];
			$list = $Stockin->goods_info($pageLimit['from'],$pageLimit['to'],$_POST['order_id']);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	/**
	 * 打印入库单信息
	 */
	function actionPrint(){
		set_time_limit(0);
		$object = new ModelStockout();
		$order_ids=explode(",",$_GET['order_id']);
		if(isset($_GET['type']) && $_GET['type'] == 1){
			$count = $object->getgoodsCount($_GET['order_id']);;
			$order_info = $object->order_info($_GET['order_id']);
			$goodslist = $object->goods_info(0,$count,$_GET['order_id']);
			$goods = new ModelGoods();
			for($i=0;$i<count($goodslist);$i++){
				$goods_info = $goods->goods_info($goodslist[$i]['goods_id']);
				$goods_list['goods_sn'] = $goods_info['SKU'];
				$goods_list['stock_place'] = $goods_info['stock_place'];
				for($j=0;$j<$goodslist[$i]['goods_qty'];$j++){
					$list[] = $goods_list;
				}
			}
			$this->tpl->assign('goodslist',$list);
			$this->dir = 'goods';
			$this->name = 'label_print';
			$this->show();
			exit();
		}elseif(isset($_GET['type']) && $_GET['type'] == 2 && count($order_ids)>1) {
			$counts=0;
			foreach($order_ids as $order_id){
				$where = 'where m.order_id='.$order_id;
				$counts+=$object->getExportCount($where);
				if($counts>1500){
					echo "导出的数据量超过1500条，请将条件范围缩小后，再进行导出，谢谢合作。";
					exit;
				}
			}
			echo '<style>#listpart{ background:#000;}#listpart tr td{ background:#fff;}
				  </style>打印时间:'.date('Y-m-d H:i:s').'<table width="100%"  border="0" cellspacing="1" cellpadding="0" id="listpart">';
			echo "<tr><td>出库单号</td><td>仓库</td><td>产品编码</td><td>名称</td><td>数量</td><td>价格</td><td>关联单据</td><td>备注</td></tr>";
			foreach($order_ids as $order_id){
				$where = 'where m.order_id='.$order_id;
				$list = $object->getExportList($where);
				for($i=0;$i<count($list);$i++){
					$goodsList = $object->goods_info('',$object->getgoodsCount($list[$i]['order_id']),$list[$i]['order_id']);
					for($j=0;$j<count($goodsList);$j++){
						echo  "<tr><td>".$list[$i]['order_sn']."</td><td>".$list[$i]['depot_id']."</td><td>".$goodsList[$j]['goods_sn']."</td><td>".$goodsList[$j]['goods_name']."</td><td>".$goodsList[$j]['goods_qty']."</td><td>".$goodsList[$j]['goods_price']."</td><td>".$goodsList[$j]['relate_order_sn']."</td><td>".$goodsList[$j]['remark']."</td></tr>";
					}
				}
			}
			echo "</table>";
			die();
		}else{
			$count = $object->getgoodsCount($_GET['order_id']);
			$order_info = $object->order_info($_GET['order_id']);
			$goodslist = $object->goods_info(0,$count,$_GET['order_id']);
			$user = new ModelUser();
			$this->tpl->assign('order_sn',CFG_OUT_ORDER_PREFIX.$order_info['order_sn']); 
			$supplier = ModelDd::getArray("Sales_channels");
			$str = "<table width='100%'><tr><td>产品总数:".$order_info['total_qty']."</td><td>销售渠道:".$supplier[$order_info['supplier']]."</td><td>操作人:".$user->getName($order_info['operator_id'])."</td><td>录入时间:".MyDate::transform('date',$order_info['add_time'])."</td><td>出库时间:".MyDate::transform('date',$order_info['out_time'])."</td><td>".$order_info['comment']."</td></tr></table>";
			$this->tpl->assign('infopart',$str); 
			$action_list = explode(',',$_SESSION['action_list']);
			$goods_right[] = in_array('view_cost',$action_list)?1:0;
			$this->tpl->assign('listheader',"<tr><td>产品编码</td><td>名称</td><td>数量</td>".(($goods_right[0] == 1)?"<td>价格</td>":'')."<td>备注</td></tr>"); 
			$this->tpl->assign('listpart',$goodslist);
			$this->dir = 'system';
			$this->name = 'order_print';
			$this->show();
		}
	}
	
	/**
	 * 删除出库单产品
	 */
	function actionDelgoods(){
		$Stockin = new ModelStockout();
		try{
			$Stockin->delgoods($_GET['id']);
			echo "{success:true,msg:'操作成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	
	/*****************
	****出库数据导入
	*****************/
	function actionImport()
	{
		parent::actionPrivilege('stockout_import');
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->tpl->assign('stockout_type',ModelDd::getComboData('stockout_type'));
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->name = 'stockoutimport';
		$this->show();
	}
	function actionUpload()
	{
		set_time_limit(0);
		parent::actionPrivilege('stockout_import');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$order = new ModelStockout();
		$order_info = array();
		$order_info['order_sn'] = $order->get_order_sn();
		$order_info['supplier2'] = $_POST['supplier'];
		$order_info['stocktype'] = $_POST['stocktype'];
		$order_info['depot_id'] = $_POST['depot_id'];
		$order_info['comment'] = '导入数据';
		$order_info['status'] = 0;
		$order_info['operator_id'] = $_SESSION['admin_id'];
		$goods = new ModelGoods();
		$goodsarr = array();
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info = $goods->goods_info('',$currentSheet->getCell('A'.$currentRow)->getValue());
			$good->goods_id =$goods_info['goods_id'];
			$good->goods_qty = $currentSheet->getCell('B'.$currentRow)->getValue();
			$good->goods_price  = $goods_info['cost'];
			$good->relate_order_sn = '';
			$good->remark = 'import';
			$goodsarr[] = $good;
			unset($good);
		}
		$order_info['data'] = $goodsarr;
			try {
				$order->save($order_info);
			} catch (Exception $e) {
					echo "{success:false,msg:'".$e->getMessage()."'}";exit;
			}
		 echo "{success:true,msg:'出库单导入成功'}";exit;
	}
}
?>