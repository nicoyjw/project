<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 采购订单
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Purchaseorder extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '采购订单';
		$this->name = 'Purchaseorder';
		$this->dir = 'purchase';
	}
	/**
	 * 所有采购订单列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_p_order');
		$this->tpl->assign('status',ModelDd::getComboData('p_status'));
		$this->show();
	}
    /**
     * 采购建议
     */
    function actionPlan()
    {
        parent::actionPrivilege('list_p_plan');
        $this->tpl->assign('depot',ModelDd::getComboData('depot'));
        $this->name = 'plan';
        $this->show();
    }
	/**
	 * 采购缺货商品
	 */
	function actiondepotPurchase()
	{
		parent::actionPrivilege('list_p_plan');
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->name = 'depotpurchase';
		$this->show();
	}
	/**
	 * 默认页面---订单添加修改
	 */
	function actionAdd() {
		parent::actionPrivilege('add_p_order');
		$this->tpl->assign('order_status',ModelDd::getComboData('p_status'));
		$object = new ModelPurchaseorder();
		if($_GET['order_id']){
			$rs = $object->order_info($_GET['order_id']);
			$rs['pre_time'] = MyDate::transform('date',$rs['pre_time']);
		}else{
			$rs = array(
					"order_id" => "",
					"order_sn" => "",
					"supplier_id" => "",
					"supplier_name" => "",
					"operator_id" => $_SESSION['admin_id'],
					"status" => 0,
					"pre_time" => date("Y-m-d")
					);
			$rs['order_sn'] = $object->get_order_sn();
		}
		$rs['order_sn'] = CFG_P_ORDER_PREFIX.$rs['order_sn'];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($rs);
		$this->tpl->assign('order',$order); 
		$this->name = 'purchaseorderAdd';
		$this->show();
	}
	/**
	 * 保存采购定单信息
	 */
	function actionUpdate() {
		if(parent::actionCheck('edit_p_order')) {
			if($_GET['status'] == 1) parent::actionCheck('audit_p_order');
			$object = new ModelPurchaseorder();
			try {
					$object->update($_GET);
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
		$object = new ModelPurchaseorder();
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
			$msg = $object->save($_POST);
			echo "{success:true,msg:'$msg'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}	
	/**
	 * 获得采购订单列表数据
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelPurchaseorder();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
     * 获得采购计划列表数据
     */
    function actionPlanList()
    {
        set_time_limit(0);
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelPurchaseorder();
        if($_GET['sid']=='order') $list = $object->getOrderplanlist();
        else $list = $object->getplanList($pageLimit['from'],   $pageLimit['to'],($_GET['type']=='export')?1:0,$_GET['qty']?1:0,0,$_REQUEST['SKU'],$pageLimit['sort']);
        
        $result['totalCount'] = $object->getplanCount();
        $result['topics'] = $list;
        
        
        
        if($_GET['type']=='export'){
                include_once(CFG_PATH_LIB.'PHPExcel.php');
                include_once(CFG_PATH_LIB.'PHPExcel/Cell/AdvancedValueBinder.php');
                PHPExcel_Cell::setValueBinder( new PHPExcel_Cell_AdvancedValueBinder());
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
                $header = '产品编码,产品名称,SKU,库存数量,锁定库存,销售需求,报警库存,采购在途,日均销量,供应商,采购周期,建议采购,其他';
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
                include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
                $t =2;
                for($i=0;$i<count($list);$i++){
                        $order_value[] =  $list[$i]['goods_sn'];
                        $order_value[] =  $list[$i]['goods_name'];
                        $order_value[] =  $list[$i]['SKU'];
                        $order_value[] =  $list[$i]['goods_qty'];
                        $order_value[] =  $list[$i]['varstock'];
                        $order_value[] =  $list[$i]['sold_qty'];
                        $order_value[] =  $list[$i]['warn_qty'];
                        $order_value[] =  $list[$i]['Purchase_qty'];
                        $order_value[] =  $list[$i]['per_sold'];
                        $order_value[] =  $list[$i]['supplier'];
                        $order_value[] =  $list[$i]['period'];
                        $order_value[] =  $list[$i]['plan_qty'];
                        $order_value[] =  $list[$i]['comment'];
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
                $objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
                $file = CFG_PATH_DATA.'ordertmp/planlist'.$_SESSION['admin_id'].'.xlsx';
                if(file_exists($file)) unlink($file);
                $objWriter->save($file);//define xls name
                $file = str_replace(CFG_PATH_ROOT, '', $file);
                echo date('H:i:s') . " Done writing files.<br>";
                page::todo($file);
                die();            
            }
        echo $json->encode($result);
    }
    /**
	 * 获得缺货待采购列表数据
	 */
	function actionDepotPlanList()
	{
		set_time_limit(0);
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
		$pageLimit = getPageLimit();
		$object = new ModelPurchaseorder();
		if($_GET['sid']=='order') $list = $object->getOrderplanlist();
		else $list = $object->getDepotplanList($pageLimit['from'],   $pageLimit['to'],($_GET['type']=='export')?1:0,$_GET['qty']?1:0,0,$_REQUEST['SKU'],$pageLimit['sort']);
        
        $result['totalCount'] = $object->getDepotplanCount();
		$result['topics'] = $list;
        
        
        
		if($_GET['type']=='export'){
				include_once(CFG_PATH_LIB.'PHPExcel.php');
		        include_once(CFG_PATH_LIB.'PHPExcel/Cell/AdvancedValueBinder.php');
		        PHPExcel_Cell::setValueBinder( new PHPExcel_Cell_AdvancedValueBinder());
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
				$header = '产品编码,产品名称,SKU,库存数量,锁定库存,销售需求,报警库存,采购在途,日均销量,供应商,采购周期,建议采购,其他';
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
				include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
				$t =2;
				for($i=0;$i<count($list);$i++){
						$order_value[] =  $list[$i]['goods_sn'];
						$order_value[] =  $list[$i]['goods_name'];
						$order_value[] =  $list[$i]['SKU'];
						$order_value[] =  $list[$i]['goods_qty'];
						$order_value[] =  $list[$i]['varstock'];
						$order_value[] =  $list[$i]['sold_qty'];
						$order_value[] =  $list[$i]['warn_qty'];
						$order_value[] =  $list[$i]['Purchase_qty'];
						$order_value[] =  $list[$i]['per_sold'];
						$order_value[] =  $list[$i]['supplier'];
						$order_value[] =  $list[$i]['period'];
						$order_value[] =  $list[$i]['plan_qty'];
						$order_value[] =  $list[$i]['comment'];
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
				$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
				$file = CFG_PATH_DATA.'ordertmp/planlist'.$_SESSION['admin_id'].'.xlsx';
				if(file_exists($file)) unlink($file);
				$objWriter->save($file);//define xls name
				$file = str_replace(CFG_PATH_ROOT, '', $file);
				echo date('H:i:s') . " Done writing files.<br>";
				page::todo($file);
				die();			
			}
		echo $json->encode($result);
	}
	function actionInitplan()
	{
		try{
			$object = new ModelPurchaseorder();
			$object->initPlan($_GET['depot']);
			echo "{success:true,msg:'操作成功'}";exit;
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**
	 * 获得采购订单产品明细
	 */
	function actionGetgoods(){
			if(!$_POST['order_id']) {echo '';exit();}
			$pageLimit = getPageLimit();
			$object = new ModelPurchaseorder();
			$list = $object->goods_info($pageLimit['from'],$pageLimit['to'],$_POST['order_id']);
			$result['topics'] = $list;
			$result['totalCount'] = $object->getgoodsCount($_POST['order_id']);
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	
	/**
	 * 删除采购订单产品
	 */
	function actionDelgoods(){
		$object = new ModelPurchaseorder();
		try{
			$object->delgoods($_GET['id']);
			echo "{success:true,msg:'操作成功'}";exit;	
		} catch (Exception $e) {
			echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	
	/*****************
	****采购数据导入
	*****************/
	function actionImport()
	{
		parent::actionPrivilege('porder_import');
		$this->name = 'import';
		$this->show();
	}
	function actionUpload()
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
		$order = new ModelPurchaseorder();
		$order_info = array();
		$order_info['order_sn'] = $order->get_order_sn();
		$order_info['supplier_id'] = $_POST['supplier'];
		$order_info['pre_time'] = date('Y-m-d H:i:s');
		$order_info['status'] = 0;
		$order_info['operator_id'] = $_SESSION['admin_id'];
		$goods = new ModelGoods();
		$goodsarr = array();
		$msg = '';
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info = $goods->goods_info('',$currentSheet->getCell('A'.$currentRow)->getValue());
			if(!$goods_info['goods_id']) {
				$msg .= $currentSheet->getCell('A'.$currentRow)->getValue().'不存在<br>';
				continue;
			}
			$good->goods_id =$goods_info['goods_id'];
			$good->goods_qty = $currentSheet->getCell('B'.$currentRow)->getValue();
			$good->goods_price  = ($currentSheet->getCell('C'.$currentRow)->getValue() == '')?$goods_info['cost']:$currentSheet->getCell('C'.$currentRow)->getValue();
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
		 echo "{success:true,msg:".$msg."'采购订单导入成功'}";exit;
	}
	/***************
	***系统自动选择供应商生成采购单
	***************/
	
	function actionUpload1()
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
		$order = new ModelPurchaseorder();
		$order_info = array();
		$goods = new ModelGoods();
		$goodsarr = array();
		$msg = '';
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$sn = $currentSheet->getCell('A'.$currentRow)->getValue();
			$goods_info = $goods->goods_info('',$sn);
			if(!$goods_info['goods_id']) {
				$msg .= $sn.'不存在<br>';
				continue;
			}
			$supplierid = $order->getsupplierid($goods_info['goods_id']);
			if($supplierid == 0) {//没找到对应供应商
				$msg .= $sn."没有对应供应商信息<br>";
				continue;
				}
			if(!array_key_exists($supplierid,$order_info)){
			$order_info[$supplierid]['order_sn'] = $order->get_order_sn();
			$order_info[$supplierid]['supplier_id'] = $supplierid;
			$order_info[$supplierid]['pre_time'] = date('Y-m-d H:i:s');
			$order_info[$supplierid]['status'] = 0;
			$order_info[$supplierid]['operator_id'] = $_SESSION['admin_id'];
			}
			$good->goods_id =$goods_info['goods_id'];
			$good->goods_qty = $currentSheet->getCell('B'.$currentRow)->getValue();
			$good->goods_price  = ($currentSheet->getCell('B'.$currentRow)->getValue() == '')?$currentSheet->getCell('B'.$currentRow)->getValue():$goods_info['cost'];
			$good->remark = 'import';
			$goodsarr[$supplierid][] = $good;
			unset($good);
		}
			try {
				foreach($order_info as $k=>$v){
					$order_info[$k]['data'] = $goodsarr[$k];
					$order->save($order_info[$k]);
					}
			} catch (Exception $e) {
					echo "{success:false,msg:'".$e->getMessage()."'}";exit;
			}
		 echo "{success:true,msg:".$msg."'采购订单导入成功'}";exit;
	}
	
	function actionPrint()
	{
		set_time_limit(0);
		$object = new ModelPurchaseorder();
		$modelsp = new ModelSupplier();
		$ids = explode(',',$_GET['order_id']);
		if(isset($_GET['type']) && $_GET['type'] == 1){
			$list=array();
			for($i=0;$i<count($ids);$i++){
				$count = $object->getgoodsCount($ids[$i]);
				$order_goods = $object->goods_info(0,$count,$ids[$i]);
				$goods = new ModelGoods();
				for($j=0;$j<$count;$j++){
					$goods_info = $goods->goods_info($order_goods[$j]['goods_id']);
					$stockinfo = $goods->getgoodsqty($order_goods[$j]['goods_id']);
					$goods_list['goods_sn'] = $goods_info['SKU'];
					$goods_list['stock_place'] = $stockinfo['stock_place'];
					for($n=0;$n<$order_goods[$j]['goods_qty'];$n++){
						$list[] = $goods_list;
					}
				}
			}
			$this->tpl->assign('goodslist',$list);
			$this->dir = 'goods';
			$this->name = 'label_print';
			$this->show();
			exit();
		}
		$action_list = explode(',',$_SESSION['action_list']);
		$goods_right[] = in_array('view_cost',$action_list)?1:0;
		if(count($ids)>1){
			echo '<style>
#listpart{ background:#000;}
#listpart tr td{ background:#fff;}
</style>打印时间:'.date('Y-m-d H:i:s').'<table width="100%"  border="1" cellspacing="1" cellpadding="0" id="listpart">';
echo "<tr><td>采购单号</td><td>产品图片</td><td>产品编码</td><td>供应商编码</td><td>名称</td><td>数量</td>".(($goods_right[0] == 1)?"<td>价格</td>":'')."<td>备注</td><td>供应商</td></tr>";
			for($i=0;$i<count($ids);$i++){
				$order_info = $object->order_info($ids[$i]);
				$count = $object->getgoodsCount($ids[$i]);
				$order_goods = $object->goods_info(0,$count,$ids[$i]);
				for($j=0;$j<$count;$j++){
					$url = $modelsp->geturl($order_info['supplier_id'],$order_goods[$j]['goods_id']);
					echo "<tr><td>".CFG_P_ORDER_PREFIX.$order_info['order_sn']."</td><td><img src=".$order_goods[$j]['goods_img']." width= 100></td><td>".$order_goods[$j]['goods_sn']."</td><td>".$order_goods[$j]['supplier_goods_sn']."</td><td><a href='".$url."' target=_blank>".$order_goods[$j]['goods_name']."</a></td><td>".$order_goods[$j]['goods_qty']."</td>".(($goods_right[0] == 1)?"<td>".$order_goods[$j]['goods_price']."</td>":'')."<td>".$order_goods[$j]['remark']."</td><td>".$order_info['supplier_name']."</td></tr>";
				}
			}
			echo "</table>";
			die();
		}
		$count = $object->getgoodsCount($_GET['order_id']);
		$order_info = $object->order_info($_GET['order_id']);
		$this->tpl->assign('view_cost',$goods_right[0]);
		$user = new ModelUser();
		$this->tpl->assign('order_sn',CFG_P_ORDER_PREFIX.$order_info['order_sn']);
		$goods_list=$object->goods_info(0,$count,$_GET['order_id']);
		$amt=0;
		foreach($goods_list as $goods){
			$amt+=$goods['goods_qty']*$goods['goods_price'];
		}
		$str = "<table width='100%'><tr><td>操作人</td><td>".$user->getName($order_info['operator_id'])."</td><td>录入时间</td><td>".MyDate::transform('date',$order_info['add_time'])."</td><td>供应商</td><td>".$order_info['supplier_name']."(".$order_info['address'].")</td><td>总金额：</td><td>".$amt."</td></tr></table>";
		$this->tpl->assign('infopart',$str); 
		$this->tpl->assign('showimg',1); 
		$this->tpl->assign('listheader',"<tr><td>产品图片</td><td>产品编码</td><td>供应商编码</td><td>名称</td><td>数量</td>".(($goods_right[0] == 1)?"<td>价格</td>":'')."<td>备注</td></tr>"); 
		$this->tpl->assign('listpart',$goods_list);
		$this->dir = 'system';
		$this->name = 'order_print';
		$this->show();
	}
	/********
	****获取历史采购成本价格
	********/
	function actionGetHistory()
	{
		$pageLimit = getPageLimit();
		$object = new ModelPurchaseorder();
		$list = $object->gethistoryList($pageLimit['from'],$pageLimit['to'],$_POST['goods_id']);
		$result['totalCount'] = $object->gethistoryCount($_POST['goods_id']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionPlanBySupplier()
	{
		$this->name = 'planorder';
		$this->show();
	}
    
    
    
	function actionplanBySupplierList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelPurchaseorder();
		$list = $object->getplanBySupplierList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getplanBySupplierCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionSupplierPlanList()
	{
		if($_POST['supplier_id']){
			$pageLimit = getPageLimit();
			$object = new ModelPurchaseorder();
			$where=$object->getSupplierPlanWhere($_POST);
			$counts=$object->getSupplierPlanCount($where);
			if($counts==0){
				$object->delPlanTmp();
				$rs = $object->initPlanTmp($_POST['supplier_id']);
			}
			$list = $object->getSupplierPlanList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getSupplierPlanCount(' where supplier_id='.$_POST['supplier_id']);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	function actionUpdatePlanTmp()
	{
		$object = new ModelPurchaseorder();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$datas=$json->decode(stripslashes($_POST['data']));
		try {
			//保存更新数据
			foreach($datas as $good){
				$object->updatePlanTmp($good);
			}
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:".$msg."'保存成功'}";exit;
	}
	function actionSaveOrder(){
		$object = new ModelPurchaseorder();
		$_POST['older']=true;
		$where=$object->getSupplierPlanWhere($_POST);
		$counts=$object->getSupplierPlanCount($where);
		if($counts>0){
			$order_info = array();
			$order_info['order_sn'] = $object->get_order_sn();
			$order_info['supplier_id'] = $_POST['supplier_id'];
			$order_info['pre_time'] = date('Y-m-d H:i:s');
			$order_info['status'] = 0;
			$order_info['operator_id'] = $_SESSION['admin_id'];
			
			$list = $object->getSupplierPlanList(null,null,$where);
			$goodsarr = array();
			foreach($list as $goods){
				$good->goods_id =$goods['goods_id'];
				$good->goods_qty = $goods['plan_qty'];
				$good->goods_price  = $goods['supplier_goods_price'];
				$good->remark = '';
				$goodsarr[] = $good;
				unset($good);
			}
			$order_info['data'] = $goodsarr;
			try {
				$object->save($order_info);
				$object->delPlanTmp();
			} catch (Exception $e) {
					echo "{success:false,msg:'".$e->getMessage()."'}";exit;
			}
			echo "{success:true,msg:".$msg."'供应商采购订单新增成功！订单号：".CFG_P_ORDER_PREFIX.$order_info['order_sn']."'}";exit;
		}else{
			echo "{success:false,msg:".$msg."'供应商采购的产品数量为0，无法新增采购单！'}";exit;
		}
	}
    
    function actionDepotPlanByAll()
    {
        
        
        
        
        
        try{
            $object = new ModelPurchaseorder();
            $object->DepotPlanByAll();
            echo "{success:true,msg:'操作成功'}";exit;
        } catch (Exception $e) {
            echo '{success:false,msg:"'.$e->getMessage().'"}';exit;
        }
    }
}
?>