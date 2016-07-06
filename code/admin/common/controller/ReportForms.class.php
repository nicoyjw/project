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
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */

class ReportForms extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '报表';
		$this->name = 'reportforms';
		$this->dir = 'reportforms';
		
	}	
	/**
	 * 
	 */
	function actionReportui()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name = 'Reportui';
		$this->show();
	}
	/**
	 * 
	 */
	function actionOrderinterzone()
	{
		$this->name = 'Orderinterzone';
		$this->show();
	}
	/**
	 * 
	 */
	function actionBuytimes()
	{
		$this->name = 'Buytimes';
		$this->show();
	}
	/**
	 * 
	 */
	function actionCountrystat()
	{
		$this->name = 'countrystat';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}	
	/**
	 */
	function actionGetOneGoodsReport()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getOneGoodsReport($pageLimit['from'],$pageLimit['to'],$_POST);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 
	 */
	function actionOneGoodsReport()
	{
		$this->name = 'onegoodsreport';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}	
	/**
	 * 
	 */
	function actionGoodsTypeSale()
	{
		$this->name = 'goodstypesale';
		$this->tpl->assign('goodscatalog',$this->getGoodsCatalog());				
		$this->show();
	}
	function actionGetGoodsTypeSale()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getGoodsTypeSale($pageLimit['from'],$pageLimit['to'],$_POST);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}			
	/**
	 * 
	 */
	function actionProfitinterzone()
	{
		$this->name = 'profitinterzone';
		$this->show();
	}		
	/**
	 * 
	 */
	function actionReportchartui()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='reportchartui';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));				
		$this->show();
	}
	/**
	 * 
	 */
	function actionReportchartui2()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='reportchartui2';
		$this->show();
	}
	/**
	 * 
	 */
	function actionReportchartui3()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='reportchartui3';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('ebaycount'));		
		$this->show();
	}

	/**
	 * 
	 */
	function actionReportchartui4()
	{
		parent::actionPrivilege('sales_statistics');
		$this->name ='reportchartui4';
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();
	}
	/**
	 * 
	 */
	function actionReportchartui5()
	{
		$this->name ='reportchartui5';
		$this->tpl->assign('cfg_url',CFG_URL.'index.php?model=reportforms&action=OrderGoodsRate');
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();
	}
	/**
	 * return number rule list
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getList($pageLimit['from'],$pageLimit['to']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * return number rule list
	 */
	function actionGetOrderinterzone()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->GetOrderinterzone($pageLimit['from'],$pageLimit['to']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * return number rule list
	 */
	function actionGetCountryStat()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getCountryStat($pageLimit['from'],$pageLimit['to'],$_POST);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * return number rule list
	 */
	function actionGetBuytimes()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->GetBuytimes($pageLimit['from'],$pageLimit['to']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * return number rule list
	 */
	function actionGetProfitinterzone()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->GetProfitinterzone($pageLimit['from'],$pageLimit['to']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 */
	function actionGetHotGoodsSales()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		$title = new OFC_Elements_Title( '热门商品前'.$_GET['limit'].'名销售量报表['.$_GET['starttime'].'-'.$_GET['endtime'].']' );
		$bar = new OFC_Charts_Bar();
		$tag = new OFC_Charts_Tag();
		$object = new ModelReportForms();
		$result = $object->getHotGoodsSales($_GET);
		foreach($result as $val){
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
	/**
	 */
	function actionGetHotShop()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		$title = new OFC_Elements_Title( '热门店铺前'.(empty($_GET['limit'])?5:$_GET['limit']).'排名报表['.$_GET['starttime'].'-'.$_GET['endtime'].']' );
		$bar = new OFC_Charts_Bar();
		$tag = new OFC_Charts_Tag();
		$object = new ModelReportForms();
		$result = $object->getHotShop($_GET);
		foreach($result as $val){
			$val_arr[]=intval($val['good_gross']);
			$x_label_arr[]=$val['account_name'];
		}
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
	function actionHotShop2()
	{
		$this->name = 'hotshop2';
		$this->tpl->assign('goodscatalog',$this->getGoodsCatalog());
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();	
	}	
	/**
	 */
	function actionGetHotShop2()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getHotShop2($pageLimit['from'],$pageLimit['to'],$_POST);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}	
	/**
	 */
	function actionGetSalesState()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		
		$title = new OFC_Elements_Title( '热门店铺排名报表['.(empty($_GET['limit'])?5:$_GET['limit']).'-'.$_GET['endtime'].']' );
		
		$bar = new OFC_Charts_Bar();
		$bar2 = new OFC_Charts_Bar();
		$object = new ModelReportForms();
		$result = $object->getSalesState();
		//print_r($result);exit;
		foreach($result as $val){
			$val_arr1[]=intval($val['good_gross']);
			$val_arr2[]=$val['order_gross'];
			$x_label_arr[]=$val['Sales_account_id'];
		}
		$bar->set_values($val_arr1);
		$bar->colour='#9933CC';
		$bar2->set_values($val_arr2);
		$bar2->colour='#CC9933';
		
		$chart = new OFC_Chart();
		$chart->set_title( $title );
		
		$chart->add_element( $bar );
		$chart->add_element( $bar2 );
		
		//$x_axis
		$chart->x_axis->labels->labels=$x_label_arr;//array('产品销量','订单量');
		//$y_axis
		$chart->y_axis->min=0;
		$chart->y_axis->max=(max(max($val_arr1),max($val_arr1)))+10000;
		$chart->y_axis->steps=10000;
		
		echo $chart->toPrettyString();
	}
	/**
	 */
	function actionGetMonthSales()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		$title = new OFC_Elements_Title( ($_GET['Sales_account']?ModelDd::getCaption('allaccount',$_GET['Sales_account']):'').'月销售报表['.$_GET['starttime'].'-'.$_GET['endtime'].'](RMB)' );
		$bar = new OFC_Charts_Bar();
		$tag = new OFC_Charts_Tag();
		$object = new ModelReportForms();
		$result = $object->getMonthSales($_GET);
		$monthArea=$this->getArea($_GET['starttime'],$_GET['endtime']);
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
	/**
	 */
	function actionGetDaySales()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		$title = new OFC_Elements_Title( ($_GET['Sales_account']?ModelDd::getCaption('allaccount',$_GET['Sales_account']):'').'日销售报表['.$_GET['starttime'].'-'.$_GET['endtime'].'](RMB)' );
		$tag = new OFC_Charts_Tag();
		$bar = new OFC_Charts_Bar();
		$bar2 = new OFC_Charts_Bar();
		$object = new ModelReportForms();
		$result = $object->getDaySales($_GET);
		foreach($result as $val){
			$val_arr1[$val['paid_time']]=intval($val['order_sale']?$val['order_sale']:0);
			$x_label_arr[] = $val['paid_time'];
		}
		$dayArea=$this->getArea($_GET['starttime'],$_GET['endtime']);
		foreach($dayArea as $k=>$val){
			if($x_label_arr && in_array($val,$x_label_arr)){
				$val_arr2[]=$val_arr1[$val];
			}else
				$val_arr2[]=0;
			$dayArea[$k] = substr($val,8);
		}
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
	function actionDaySales2()
	{
		$this->name = 'daysales2';
		$this->tpl->assign('goodscatalog',$this->getGoodsCatalog());
		$this->tpl->assign('Sales_account',ModelDd::getComboData('allaccount'));		
		$this->show();	
	}
	/**
	 */
	function actionGetDaySales2()
	{
		$pageLimit = getPageLimit();
		$object = new ModelReportForms();
		$result = $object->getDaySales2($pageLimit['from'],$pageLimit['to'],$_POST);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}	
	/**
	 */
	function actionOrderGoodsRate()
	{
		require_once(CFG_PATH_LIB.'flashchart-php5-ofc-library/OFC/OFC_Chart.php');
		
		$title = new OFC_Elements_Title( '订单个数比列' );
		
		$pie = new OFC_Charts_Pie();
		
		$object = new ModelReportForms();
		$result = $object->orderGoodsRate();
		foreach($result as $val){
			$val_arr1[]=intval($val['good_gross']);
		}
		//print_r($result);exit;
		$pie->values=NULL;
		$pie->tip= "#label#<br>$#val# (#percent#)";
		if(!empty($val_arr1)){
			$val_arr1=array_count_values($val_arr1);
			$i=0;
			foreach($val_arr1 as $key =>$val){
			$i++;
			if($i==9)
			break;
			$pie->values[]=array('value'=>$val,'label'=>'含有'.$key.'个产品订单个数为'.$val.'个',"font-size"=>12);
			}
			if(count($val_arr1)>9)
			$pie->values[]=array('value'=>count(array_slice($val_arr1,9)),'label'=>'含有其他个产品订单个数为'.(count(array_slice($val_arr1,9))).'个',"font-size"=>12);
		}
		$pie->set_start_angle( 35 );
		$pie->set_animate( true );
		
		$chart = new OFC_Chart();
		$chart->set_title( $title );
		$chart->add_element( $pie );
		
		$chart->x_axis = null;
		echo $chart->toPrettyString();
	}			
				
	/**
	 * add/mod number rule
	 *
	 */
	function actionSave()
	{
		$object = new ModelReportForms();
		try {
			if($object->save()){
				echo "{success:true,msg:'OK'}";
				exit;
			}else{
				echo "{success:false,msg:'failure'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}
	/**
	 * delete record
	 */
	function actionDel()
	{
		parent::actionDelete('ModelReportForms');
	}	
	function codeForRule($number){
		$object = new ModelReportForms();
		return $object->getNumberRule($number);
	}
	function getAccount(){
		$temp_arr=ModelDd::getArray('account');
		$temp_arr['0']='所有帐户';
		foreach($temp_arr as $key=>$val){
		$result.=!isset($result)?'{\'id\':\''.$key.'\',\'name\':\''.$val.'\'}':',{\'id\':\''.$key.'\',\'name\':\''.$val.'\'}';
		}
		return '['.$result.']'; 
	}
	function getGoodsCatalog(){
		$temp_arr=ModelDd::getArray('catalog');
		$temp_arr['0']='所有目录';
		foreach($temp_arr as $key=>$val){
		$result.=!isset($result)?'{\'id\':\''.$key.'\',\'name\':\''.$val.'\'}':',{\'id\':\''.$key.'\',\'name\':\''.$val.'\'}';
		}
		return '['.$result.']'; 
	}
	/**
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
}
?>