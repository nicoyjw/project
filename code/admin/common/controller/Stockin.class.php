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
class Stockin extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '入库单';
		$this->name = 'stockin';
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
		//parent::actionPrivilege('list_stockin');
		$this->show();
	}
	
	/**
	 * 默认页面---扫描生成入库单
	 */
	function actionScan()
	{
		parent::actionPrivilege('add_stockin');
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('prefix',CFG_P_ORDER_PREFIX);
		$this->name = 'scan';
		$this->show();
	}
	function actionScanhandle()
	{
		if(isset($_POST['keyword'])&&!empty($_POST['keyword'])){
			$object = new ModelStockin();
			$order_sn=trim($_POST['keyword']);
			if(substr($order_sn,0,strlen(CFG_P_ORDER_PREFIX)) == CFG_P_ORDER_PREFIX){//deal with purchase order_id
				$order_id = $object->getOnePorder(substr($order_sn,strlen(CFG_P_ORDER_PREFIX)));
				if($order_id){
				exit("{success:true,msg:'开始扫描入库".$_POST['keyword']."',porder_id:'".$order_id."'}"); 
				}else{
				exit("{success:true,msg:'".$_POST['keyword']."采购单不存在！'}"); 
				}
			}else{
				if(empty($_POST['porder_id'])) exit("{success:true,msg:'先输入采购单号！'}");
				$goods=$object->getGoodsId($order_sn);
				if(!$goods) exit("{success:true,msg:'<font color=\'red\'>".$_POST['keyword']."不能识别的产品编码!</font>'}"); 
				$record=$object->getOneGood(trim($_POST['porder_id']),$goods);
				if($record){
					foreach($record as $key=>$val){
						if(is_string ($key)) $record2[$key]=$val;
					}
					require(CFG_PATH_LIB.'util/JSON.php');
					$json = new Services_JSON();
					exit("{success:true,msg:'进行".$_POST['keyword']."扫描入库！',goods:".$json->encode($record2)."}"); 
				}else{
					exit("{success:true,msg:'采购单未找到<font color=\'red\'>".$_POST['keyword']."</font>'}"); 
				}
			}
			
		}else{
			exit("{success:true,msg:'采购单号为空！'}"); 
		}
	}
	/**************
	***
	***保存扫描入库采购单
	***
	**************/
	function actionSavescan()
	{
		set_time_limit(0);
		$object = new ModelStockin();
		$Purchaseorder = new ModelPurchaseorder();
		$info = $Purchaseorder->order_info($_POST['orderid']);
		$_POST['order_sn'] = $object->get_order_sn();
		$_POST['operator_id'] = $_SESSION['admin_id'];
		$_POST['stocktype'] = 1;
		$_POST['status'] = 0;
		$_POST['comment'] = '采购订单扫描入库';
		$_POST['supplier1'] = $info['supplier_id'];
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
     * 默认页面---订单添加修改
     */
    function actionAdd() {
        parent::actionPrivilege('add_stockin');
        $this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('order_status',ModelDd::getComboData('o_status'));
        $this->tpl->assign('depot',ModelDd::getComboData('shelf'));
        $this->tpl->assign('stockin_type',ModelDd::getComboData('stockin_type'));
        $this->tpl->assign('adminid',$_SESSION['admin_id']);
        $from = '';
        if($_GET['type']) $from = 'type='.$_GET['type'].'&order_id='.$_GET['id'];
        $this->tpl->assign('from',$from);
        $object = new ModelStockin();
        if($_GET['order_id']){
            $rs = $object->order_info($_GET['order_id']);
        }else{
            $rs = array(
                    "order_id" => "",
                    "order_sn" => "",
                    "supplier" => '',
                    "supplier_name" => '',
                    "operator_id" => $_SESSION['admin_id'],
                    "stocktype" => 1,
                    "depot_id" => 0,
                    "status" => 0
                    );
            if($_GET['type']) {
            $Purchaseorder = new ModelPurchaseorder();
            $info = $Purchaseorder->order_info($_GET['id']);
            $rs['supplier'] = $info['supplier_id'];
            $rs['supplier_name'] = $info['supplier_name'];
            }
            $rs['order_sn'] = $object->get_order_sn();
        }
        $rs['order_sn'] = CFG_IN_ORDER_PREFIX.$rs['order_sn'];
        if($_GET['type']=='cgrk' && $_GET['id']){
            $this->tpl->assign('pid',$_GET['id']);
        }
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $order = $json->encode($rs);
        $this->tpl->assign('order',$order); 
        $this->name = 'StockinAdd';
        $this->show();
    }
	/**
	 * 采购单扫描入库
	 */
	function actionaddScan() {
		parent::actionPrivilege('add_stockin');
		$this->tpl->assign('supplier',ModelDd::getComboData('supplier'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->tpl->assign('order_status',ModelDd::getComboData('o_status'));
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->tpl->assign('stockin_type',ModelDd::getComboData('stockin_type'));
		$this->tpl->assign('adminid',$_SESSION['admin_id']);
		$from = '';
		if($_GET['type']) $from = 'type='.$_GET['type'].'&order_id='.$_GET['id'];
		$this->tpl->assign('from',$from);              
       
		$object = new ModelStockin();
		if($_GET['order_id']){
			$rs = $object->order_info($_GET['order_id']);
		}else{
			$rs = array(
					"order_id" => "",
					"order_sn" => "",
					"supplier" => '',
					"supplier_name" => '',
					"operator_id" => $_SESSION['admin_id'],
					"stocktype" => 1,
					"depot_id" => 0,
					"status" => 0
					);
			if($_GET['type']) {
			$Purchaseorder = new ModelPurchaseorder();
			$info = $Purchaseorder->order_info($_GET['id']);
            $rs['p_order_sn'] = CFG_P_ORDER_PREFIX.$info['order_sn'];  
			$rs['supplier'] = $info['supplier_id'];
			$rs['supplier_name'] = $info['supplier_name'];
			}
			$rs['order_sn'] = $object->get_order_sn();
		}
		$rs['order_sn'] = CFG_IN_ORDER_PREFIX.$rs['order_sn'];
		if($_GET['type']=='cgrk' && $_GET['id']){
			$this->tpl->assign('pid',$_GET['id']);
		}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($rs);
		$this->tpl->assign('order',$order); 
		$this->name = 'ScanStockinAdd';
		$this->show();
	}
    
    
    function actionPScanhandle()
    {
        
        //echo $_POST['p_order_id'];
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        if($_POST['porder_id'] && isset($_POST['keyword'])&&!empty($_POST['keyword'])){
            $object = new ModelStockin();
            //验证采购单商品
            
            $record = $object->getPorderDetailBySku($_POST);    
            if($record){
                exit("{success:true,msg:'进行".$_POST['keyword']."扫描入库！',goods:".$json->encode($record)."}");    
            } else{
                exit("{success:false,msg:'找不到产品".$_POST['keyword'].",请重新扫描!'}");
            }
            
             
                   
        }
    }
    
    
    
    
    
	/**
	 * 打印入库单信息
	 */
	function actionPrint() {
    set_time_limit(0);
    $object = new ModelStockin();
	$order_ids=explode(",",$_GET['order_id']);
    if (isset($_GET['type']) && $_GET['type'] == 1) {
        $goods = new ModelGoods();
		$count = $object->getgoodsCount($_GET['order_id']);
		$order_info = $object->order_info($_GET['order_id']);
		$goodslist = $object->goods_info(0, $count, $_GET['order_id']);
        for ($i = 0; $i < count($goodslist); $i++) {
            $goods_info = $goods->goods_info($goodslist[$i]['goods_id']);
            $stockinfo = $goods->getgoodsqty($goodslist[$i]['goods_id']);
            $goods_list['goods_sn'] = $goods_info['SKU'];
            $goods_list['stock_place'] = $stockinfo['stock_place'];
            for ($j = 0; $j < $goodslist[$i]['goods_qty']; $j++) {
                $list[] = $goods_list;
            }
        }
        $this->tpl->assign('goodslist', $list);
        $this->dir = 'goods';
        $this->name = 'label_print';
        $this->show();
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
		echo  "<tr><td>入库单号</td><td>仓库</td><td>产品编码</td><td>名称</td><td>数量</td><td>价格</td><td>关联单据</td><td>备注</td></tr>";
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
    } else {
        $user = new ModelUser();
		$count = $object->getgoodsCount($_GET['order_id']);
		$order_info = $object->order_info($_GET['order_id']);
		$goodslist = $object->goods_info(0, $count, $_GET['order_id']);
		
        $this->tpl->assign('order_sn', CFG_IN_ORDER_PREFIX.$order_info['order_sn']);
        $str = "<table width='100%'><tr><td>产品总数:".$order_info['total_qty']."</td><td>供应商:".$order_info['supplier_name']."</td><td>操作人:".$user->getName($order_info['operator_id'])."</td><td>录入时间:".MyDate::transform('date', $order_info['add_time'])."</td><td>出库时间</td><td>".MyDate::transform('date', $order_info['out_time'])."</td><td>".$order_info['comment']."</td></tr></table>";
        $this->tpl->assign('infopart', $str);
        $action_list = explode(',', $_SESSION['action_list']);
        $goods_right[] = in_array('view_cost', $action_list) ? 1 : 0;
        $this->tpl->assign('listheader', "<tr><td>产品编码</td><td>名称</td><td>数量</td>". (($goods_right[0] == 1) ? "<td>价格</td>": '')."<td>备注</td></tr>");
        $this->tpl->assign('listpart', $goodslist);
        $this->dir = 'system';
        $this->name = 'order_print';
        $this->show();
    }
}
	/**
	 * 保存入库单信息
	 */
	function actionUpdate() {
		set_time_limit(0);
		if(parent::actionCheck('edit_in_order')) {
			$object = new ModelStockin();
			try {
					$object->update($_GET);
					$pobject = new ModelPurchaseorder();
					
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
		$object = new ModelStockin();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $goods){
			$goods->goods_name = $goods->goods_name;
			if($goods->goods_name == "" || $goods->goods_sn == "") {
			echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
			}
			$goods->remark = $goods->remark;
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
	 * 获得入库单列表数据
	 */
	function actionList()
	{
		if($_REQUEST['type']=='export'){
			$object = new ModelStockin();
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
			$objPHPExcel->getProperties()->setCreator("Vekincheng")->setLastModifiedBy("Vekincheng")->setTitle("Excle output for order tracking")->setSubject("Excle output for order tracking")->setDescription("Excle output for order tracking")->setKeywords("Order product Track")->setCategory("Test result file");
			echo date('H:i:s') . " Add some data<br>";
			$objPHPExcel->setActiveSheetIndex(0);
			$header = '入库单号,仓库,总量,总价,入库类型,入库员,状态,入库时间,入库单备注,产品编码,产品名称,产品数量,产品价格,价格总计,关联单据,入库单产品备注';
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
					$order_value[]=$list[$i]['out_time'];
					$order_value[]=$list[$i]['comment'];
					$order_value[]=$goodsList[$j]['goods_sn'];
					$order_value[]=$goodsList[$j]['goods_name'];
					$order_value[]=$goodsList[$j]['goods_qty'];
					$order_value[]=$goodsList[$j]['goods_price'];
					$order_value[]=$goodsList[$j]['goods_qty']*$goodsList[$j]['goods_price'];
					$order_value[]=$goodsList[$j]['relate_order_sn'];
					$order_value[]=$goodsList[$j]['remark'];
					//print_r($order_value);
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
			$file = 'data/ordertmp/stockin'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();	
		}else{
			$pageLimit = getPageLimit();
			$object = new ModelStockin();
			$where = $object->getWhere($_REQUEST);
			$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getCount($where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	
	/**
	 * 获得入库单产品明细
	 */
	function actionGetgoods(){
			if(!$_GET['order_id']&&!$_POST['order_id']) return;
			if($_GET['type']=='cgrk'){
			$Purchaseorder = new ModelPurchaseorder();
			$list = $Purchaseorder->goods_info('','',$_GET['order_id']);
			$info = $Purchaseorder->order_info($_GET['order_id']);
			for($i=0;$i<count($list);$i++){
					$list[$i]['goods_qty'] = $list[$i]['goods_qty'] - $list[$i]['arrival_qty'] - $list[$i]['return_qty'];
					$list[$i]['relate_order_sn'] = CFG_P_ORDER_PREFIX.$info['order_sn'];
				}
				foreach($list as $k=>$v){
					if($list[$k]['goods_qty'] <= 0 ) unset($list[$k]);
					}
			sort($list);
			$result['topics'] = $list;
			$result['totalCount'] = count($list);
				}else{
			$pageLimit = getPageLimit();
			$object = new ModelStockin();
			$result['totalCount'] = $object->getgoodsCount($_POST['order_id']);
			if($pageLimit['to'] == 30) $pageLimit['to'] = $result['totalCount'];
			$list = $object->goods_info($pageLimit['from'],$pageLimit['to'],$_POST['order_id']);
			$result['topics'] = $list;
				}
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	
	/**
	 * 删除入库单产品
	 */
	function actionDelgoods(){
		$object = new ModelStockin();
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
		parent::actionPrivilege('stockin_import');
		$this->tpl->assign('stockin_type',ModelDd::getComboData('stockin_type'));
		$this->tpl->assign('depot',ModelDd::getComboData('shelf'));
		$this->name = 'stockinimport';
		$this->show();
	}
	function actionUpload()
	{
		set_time_limit(0);
		parent::actionCheck('stockout_import');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$order = new ModelStockin();
		$order_info = array();
		$order_info['order_sn'] = $order->get_order_sn();
		$order_info['supplier1'] = $_POST['supplier'];
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
		 echo "{success:true,msg:'入库单导入成功'}";exit;
	}
	
	function actionRevocation()
	{
		parent::actionCheck('order_revocation');
		$object = new ModelStockin();
		try {
			$object->revocation($_POST['id']);
		} catch (Exception $e) {
			echo $e->getMessage();exit;
		}
		 echo "撤单入库成功";exit;
	}
}
?>