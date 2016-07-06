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
 * 订单操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */
class Rma  extends Controller {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= 'RMA单据';
		$this->name = 'rma';
		$this->dir = 'rma';
	}

	/**
	 * RMA单据列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_rma');
		$this->tpl->assign('sales_account',ModelDd::getComboData('allaccount'));
		$this->tpl->assign('reason',ModelDd::getComboData('rma_reason'));
		$this->show();
	}
	/**
	 *
	 * 返回json列表
	 */
	function actionList()
	{
		$object = new ModelRma();
		$where=$object->getWhere($_REQUEST);
		if($_REQUEST['type']=='export'){
			$list = $object->getList(null,null,$where);
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
			$header = 'RMA单据ID,订单号,重发订单号,账号,buyerID,发货日期,问题产品,数量,Reason,国家,退回方式,tracking,状态,退回时间,快递方式,追踪单号,实际重量,实际运费,订单总金额,退款金额,添加人,添加时间,备注';
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
				$order_value[] =  $list[$i]['rma_sn'];
				$order_value[] =  $list[$i]['order_sn'];
				$order_value[] =  $list[$i]['new_order_sn'];
				$order_value[] =  $list[$i]['Sales_account_id'];
				$order_value[] =  $list[$i]['userid'];
				$order_value[] =  $list[$i]['end_time'];
				$order_value[] =  $list[$i]['goods_sn'];
				$order_value[] =  $list[$i]['quantity'];
				$order_value[] =   ModelDd::getCaption('rma_reason',$list[$i]['reason']);
				$order_value[] =  $list[$i]['country'];
				$order_value[] =  $list[$i]['return_form'];
					$order_value[] =  $list[$i]['tracking'];
					$order_value[] =  $list[$i]['rma_status'];
					$order_value[] =  $list[$i]['return_time'];
					$order_value[] =  $list[$i]['track_no'];
					$order_value[] =  $list[$i]['shipping_id'];
					$order_value[] =  $list[$i]['weight'];
					$order_value[] =  $list[$i]['shipping_cost'];
					$order_value[] =  $list[$i]['order_amount'];
					$order_value[] =  $list[$i]['refund'];
					$order_value[] =  $list[$i]['admin_id'];
					$order_value[] =  $list[$i]['addtime'];
					$order_value[] =  $list[$i]['remark'];
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
			$file = 'data/ordertmp/RMA'.$_SESSION['admin_id'].'.xlsx';
			if(file_exists($file)) unlink($file);
			$objWriter->save($file);//define xls name
			echo date('H:i:s') . " Done writing files.<br>";
			page::todo($file);
			die();
		}else{
			$pageLimit = getPageLimit();
			$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getCount($where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);
	}
	}
	function actionDelete()
	{
		parent::actionDelete('ModelRma');	
	}
	
	/**
	 * 返回json列表
	 *
	 */
	function actionreturnlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelRMA();
		$list = $object ->getReturnList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getReturnCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 *换货列表 返回json
	 *
	 */
	function actionreturn()
	{
		parent::actionPrivilege('list_return');
		$this->name = 'return';
		$this->show();
	}
	/**
	 * 保存RMA单据
	 *
	 */
	function actionSave()
	{
		try {
			$object = new ModelRma();
			$object->save($_POST);
			echo "{success:true,msg:'OK'}";exit;	
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}

	}
	/**
	 * 更改RMA单据(rma_status)状态
	 *
	 */
	function actionChangeStatus()
	{
		try {
			if(isset($_GET['id'])&&intval($_GET['id'])>0){
				$info['rma_status']=$_GET['status'];
				$info['id']=$_GET['id'];
				$object = new ModelRma();
				$object->save($info);
				echo "{success:true,msg:'OK'}";exit;
			}
			echo '{success:true,msg:"ID ERROR"}';exit;
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}

	}	
	/**
	 * 取RMA单数数据
	 *
	 */
	function actionGetInfo()
	{
		$rma = new ModelRma();
		$info = $rma->getInfo($_GET['id']);
		$info['return_time']=date('y-m-d',$info['return_time']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($info);exit;
	}
	/**
	 * 添加换货单据
	 *
	 */
	function actionAddreturn()
	{
		try {
			$object = new ModelRma();
			$object->savereturn($_POST);
			echo "{success:true,msg:'OK'}";exit;	
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}
	}
	/**
	 * 检查订单号是否存存
	 */
	function actionCkordersn()
	{
		try {
			if(isset($_GET['order_sn'])&&!empty($_GET['order_sn'])):
			$object = new ModelRma();
			$order_sn=substr(trim($_GET['order_sn']),strlen(CFG_ORDER_PREFIX));
			$country = $object->ckordersn($order_sn);
			if($country){
			echo "{success:true,msg:'".$country."'}";exit;	
			}
			else{
			echo "{success:false,msg:'此订单号不存在'}";exit;
			}
			endif;	
		} catch (Exception $e) {
			echo '{success:exception,msg:"'.$e->getMessage().'"}';exit;
		}
	}
}
?>