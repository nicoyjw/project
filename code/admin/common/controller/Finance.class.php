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
 * 账款管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Finance extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '账款管理';
		$this->name = 'index';
		$this->dir = 'finance';
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		$this->show();
	}
	
	/**************************
	****费用单
	**************************/
	function actionFee()
	{
		$this->name = 'fee';
		$this->show();
	}
	
	function actionaddfee()
	{
		$object = new ModelFinance();
		$info=$object->getFeeInfo($_GET['id']);
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->tpl->assign('fee_type',ModelDd::getComboData('fee_type'));
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($info);
		$this->tpl->assign('order',$order); 
		$this->name = 'addfee';
		$this->show();
	}
	/**************************
	****保存费用单
	**************************/
	function actionsavefee()
	{
		if(parent::actionCheck('edit_fee')) {
			$Finance = new ModelFinance();
			try {
					$Finance->saveFee($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除费用单
	 *
	 */
	function actionDelFee()
	{
		if(parent::actionCheck('edit_fee')) {
		$Finance = new ModelFinance();
		$Finance->delFee($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**************************
	
	****费用单列表
	**************************/
	function actionCfList()
	{
		parent::actionPrivilege('list_rf');
		$Finance = new ModelFinance();
		$where=$Finance->getWhereFee($_REQUEST);
		if($_GET['type']=='export'){
			$list = $Finance->getFeeList(null,null,$where);
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
			$header = '费用单号,账号,总金额,币种,费用类型,状态,创建时间,创建人,付款时间,付款人,备注';
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
					$order_value[] =  $list[$i]['order_sn'];
					$order_value[] =  $list[$i]['account_id'];
					$order_value[] =  $list[$i]['amt'];
					$order_value[] =  $list[$i]['currency'];
					$order_value[] =  $list[$i]['fee_type_name'];
					$order_value[] =  $list[$i]['status'];
					$order_value[] =  $list[$i]['add_time'];
					$order_value[] =  $list[$i]['add_user'];
					$order_value[] =  $list[$i]['confirm_user'];
					$order_value[] =  $list[$i]['confirm_time'];
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
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/fee'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();			
		}else{
			$pageLimit = getPageLimit();
			$list = $Finance->getFeeList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $Finance->getFeeCount($Finance->tableName,$where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}	
	}
	/**************************
	****收款单
	**************************/
	function actionReceipt()
	{
		parent::actionPrivilege('list_rf');
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		$this->name = 'receipt';
		$this->show();
	}
	function actionAddreceipt()
	{
		$object = new ModelFinance();
		$info = $object->getpaypalinfo($_GET['paypalid']);
		$info['ORDERTIME']= MyDate::transform('date',$info['ORDERTIME']);
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($info);
		$this->tpl->assign('order',$order); 
		$this->name = 'addreceipt';
		$this->show();
	}
	
	function actionaddrf()
	{
		$object = new ModelFinance();
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		if($_GET['id']){
			$info=$object->getRfInfo($_GET['id']);
			$info['ORDERTIME']= MyDate::transform('date',$info['ORDERTIME']);
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			$order = $json->encode($info);
			$this->tpl->assign('order',$order);
		}
		$this->name = 'addreceipt';
		$this->show();
	}
	
	
	/**************************
	****保存收款单
	**************************/
	function actionsaveRf()
	{
		if(parent::actionCheck('edit_rf')) {
			$Finance = new ModelFinance();
			try {
					$Finance->saverf($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**************************
	
	****收款单列表
	**************************/
	function actionrfList()
	{
		$Finance = new ModelFinance();
		$where=$Finance->getWhereRf($_REQUEST);
		if($_GET['type']=='export'){
			$list = $Finance->getrfList(null,null,$where);
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
			$header = '收款单号,关联单号,收款账户,付款方式,流水号,币种,手续费,总金额,实收金额,收款时间,状态,创建人,创建时间,收款人,收款完成时间,备注';
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
					$order_value[] =  $list[$i]['order_sn'];
					$order_value[] =  $list[$i]['relate_order_sn'];
					$order_value[] =  $list[$i]['account_id'];
					$order_value[] =  $list[$i]['payment'];
					$order_value[] =  $list[$i]['paypalid'];
					$order_value[] =  $list[$i]['currency'];
					$order_value[] =  $list[$i]['feeamt'];
					$order_value[] =  $list[$i]['amt'];
					$order_value[] =  $list[$i]['paid_money'];
					$order_value[] =  $list[$i]['paid_time'];
					$order_value[] =  $list[$i]['status'];
					$order_value[] =  $list[$i]['add_user'];
					$order_value[] =  $list[$i]['add_time'];
					$order_value[] =  $list[$i]['confirm_user'];
					$order_value[] =  $list[$i]['confirm_time'];
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
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/receipt'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();			
		}else{
			$pageLimit = getPageLimit();
			$list = $Finance->getrfList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $Finance->getRfCount($Finance->rftableName,$where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	/**
	 * 删 除收款单
	 *
	 */
	function actionDelrf()
	{
		$Finance = new ModelFinance();
		$Finance->delrf($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	/**************************
	****付款单
	**************************/
	function actionPay()
	{
		parent::actionPrivilege('list_gf');
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		$this->name = 'refund';
		$this->show();
	}
	function actionAddpay()
	{
		$object = new ModelFinance();
		$info = $object->getpaypalinfo($_GET['paypalid']);
		if(isset($_GET['ordersn'])) $info['relate_order_sn'] = $_GET['ordersn'];
		$info['ORDERTIME']= MyDate::transform('date',$info['ORDERTIME']);
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($info);
		$this->tpl->assign('order',$order); 
		$this->name = 'addpay';
		$this->show();
	}
	function actionaddgf()
	{
		$object = new ModelFinance();
		$info=$object->getGfInfo($_GET['id']);
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->tpl->assign('payment',ModelDd::getComboData('payment'));
		$info['ORDERTIME']= MyDate::transform('date',$info['ORDERTIME']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$order = $json->encode($info);
		$this->tpl->assign('order',$order); 
		$this->name = 'addpay';
		$this->show();
	}
	/**************************
	****保存付款单
	**************************/
	function actionsaveGf()
	{
		if(parent::actionCheck('edit_gf')) {
			$Finance = new ModelFinance();
			try {
					$Finance->savegf($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**************************
	
	****付款单列表
	**************************/
	function actiongfList()
	{
		$Finance = new ModelFinance();
		$where=$Finance->getWhereGf($_REQUEST);
		if($_GET['type']=='export'){
			$list = $Finance->getgfList(null,null,$where);
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
			$header = '付款单号,关联单号,付款账号,付款方式,流水号,币种,总金额,付款时间,状态,创建人,创建时间,付款人,付款时间,备注';
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
				$order_value[] =  $list[$i]['order_sn'];
				$order_value[] =  $list[$i]['relate_order_sn'];
				$order_value[] =  $list[$i]['account_id'];
				$order_value[] =  $list[$i]['payment'];
				$order_value[] =  $list[$i]['paypalid'];
				$order_value[] =  $list[$i]['currency'];
				$order_value[] =  $list[$i]['amt'];
				$order_value[] =  $list[$i]['paid_time'];
				$order_value[] =  $list[$i]['status'];
				$order_value[] =  $list[$i]['add_user'];
				$order_value[] =  $list[$i]['add_time'];
				$order_value[] =  $list[$i]['confirm_user'];
				$order_value[] =  $list[$i]['confirm_time'];
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
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/refund'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();			
		}else{
			$pageLimit = getPageLimit();
			$list = $Finance->getgfList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $Finance->getGfCount($Finance->gftableName,$where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	/**************************
	
	****关联付款单
	**************************/
	function actionRelategf()
	{
		$Finance = new ModelFinance();
			try {
					$Finance->relategf($_GET);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 删 除付款单
	 *
	 */
	function actionDelgf()
	{
		$Finance = new ModelFinance();
		$Finance->delgf($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	
	//bank页面
	function actionBank()
	{
		parent::actionPrivilege('list_bank');
		$this->name = 'bank';
		$this->show();
	}
	
	//banklog页面
	function actionbanklog()
	{
		parent::actionPrivilege('list_banklog');
		$object = new ModelFinance();
		$this->tpl->assign('powerBank',$object->getPowerBank());
		$this->name = 'banklog';
		$this->show();
	}
	
	/**
	 * 添加bankaction
	 *
	 */
	function actionBankList()
	{
		$object = new ModelFinance();
		$where=$object->getWhereBank($_REQUEST);
		if($_GET['type']=='export'){
			$list = $object->getBankList(null,null,$where);
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
			$header = '账户,账户金额,应收金额,应付金额,开户人,开户时间';
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
					$order_value[] =  $list[$i]['account'];
					$order_value[] =  $list[$i]['money'];
					$order_value[] =  $list[$i]['collect_money'];
					$order_value[] =  $list[$i]['pay_money'];
					$order_value[] =  $list[$i]['add_user'];
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
			$file = 'data/ordertmp/bank'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();			
		}else{
			$pageLimit = getPageLimit();
			$list = $object->getBankList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getTableCount(CFG_DB_PREFIX.'bank',$where);
			$result['topics'] = $list?$list:"";
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	
	/**
	 * 添加bankaction
	 *
	 */
	function actionaddBank()
	{
		$object = new ModelFinance();
		$info=$object->getBankInfo($_GET['id']);
		$set_user = array_flip(explode(",",substr($info['users'],1,strlen($info['users'])-1)));
		$user = ModelDd::getArray('user');
		foreach($set_user as $k=>$v){
			$suser[$k] =  $user[$k]; //已选择用户
		}
		$info['ds'] = (count($suser)>1)?ModelDd::arrayFormat(array_diff($user,$suser)):ModelDd::arrayFormat($user);
		$info['ds1'] = (count($suser)>1)?ModelDd::arrayFormat($suser):'';
		$this->tpl->assign('info', $info);
		$this->name = 'addbank';
		$this->show();
	}
	/**
	 *保存bank
	 *
	 */
	function actionSaveBank()
	{
		try {
			$object = new ModelFinance();
			$object->saveBank($_REQUEST);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 *删除bank
	 *
	 */
	function actiondelbank()
	{
		try {
			$object = new ModelFinance();
			$object->delBank($_REQUEST['ids']);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	/**
	 *检测账户是否存在
	 *
	 */
	function actioncheckaccount(){
		try {
			$object = new ModelFinance();
			if($object->getBankInfoByAccount($_REQUEST['value'])){
				echo "{success:false,msg:'该账户已存在，请使用其他账户'}";exit;
			}else{
				echo "{success:true,msg:'OK'}";exit;
			}
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:false,msg:'" . $errorMsg . "'}";exit;
	}
	
	/**
	 *检测账户是否存在
	 *
	 */
	function actionbankLogList(){
		$object = new ModelFinance();
		$where =$object->getWhereBankLog($_REQUEST);
		if($_GET['etype']=='export'){
			$list = $object->getBankLogList(null,null,$where);
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
			$header = '账户,收/支,款项类型,单据编号,金额,余额,操作时间,创建人,确认人,备注';
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
					$order_value[] =  $list[$i]['account'];
					$order_value[] =  $list[$i]['type'];
					$order_value[] =  $list[$i]['deal_type'];
					$order_value[] =  $list[$i]['order_sn'];
					$order_value[] =  $list[$i]['money'];
					$order_value[] =  $list[$i]['balance'];
					$order_value[] =  $list[$i]['time'];
					$order_value[] =  $list[$i]['add_user'];
					$order_value[] =  $list[$i]['confirm_user'];
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
			include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
			$objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
			$file = 'data/ordertmp/banklog'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();			
		}else{
			$pageLimit = getPageLimit();
			$list = $object->getBankLogList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getBankLogCount($where);
			$result['topics'] = $list?$list:"";
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
		}
	}
	
	function actionUpdateConfirm(){
		try {
			$object = new ModelFinance();
			$object->getUpdateConfirm($_REQUEST);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
}
?>