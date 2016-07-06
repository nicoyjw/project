<?
/**
 * 新品管理
 *
 * @author 尹阿雄<yinaxiong@qq.com>
 * @package Common
 * @version v0.1
 
		    action_type
信息列表	    0
信息审核列表	1
任务分配列表	8
图片列表	    2--
图片审核列表	3
描述列表	    4--
描述审核列表	5
终审表	    6
所有新品    	7
任务分配     8

status
0	未审核
1	审核失败
2	信息待初审
3	信息待终审
4	未审核图片
5	未审核描述
6	图片审核失败
7	描述审核失败
8	图片待终审
9	描述待终审
10	终审成功
 */
class NewProduct extends Controller  {
	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->load();
		$this->tpl->assign('action_type',0);
		$this->title = '新品管理';
		$this->name = 'product_list';
		$this->dir = 'newProduct';
	}
	/**
	 * 
	 */
	function actionIndex() {
		$this->show();
	}
	/**
	*
	*/
	function load(){
		$this->tpl->assign('goods_audit_status',ModelDd::getComboData('goods_audit_status'));
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
	}
	/**
	 * 保存产品
	 */
	function actionSave() {
		try {
			$object = new ModelNewProduct();
			$goods_id = $object->save($_REQUEST);
			echo "{success:true,msg:'$goods_id'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 保存图片
	 */
	function actionSaveImg() {
		try {
			$object = new ModelNewProduct();
			echo $object->saveImg($_REQUEST)?"{success:true,msg:'添加成功'}":"{success:false,msg:'添加失败'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 保存描述
	 */
	function actionSaveDes() {
		try {
			$object = new ModelNewProduct();
			echo $object->saveDes($_REQUEST)?"{success:true,msg:'添加成功'}":"{success:false,msg:'添加失败'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 保存产品action
	 */
	function actionAddProduct() {
		$this->load();
		if($_REQUEST['goods_id']){
			$object = new ModelNewProduct();
			$rs = $object->goods_info($_REQUEST['goods_id']);
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			$good = $json->encode($rs);
			$this->tpl->assign('good',$good); 
			//获取已选择的颜色集合
			$colors = array_flip(explode(",",substr($rs['colors'],1,strlen($rs['colors'])-1)));
			$goods_colors = ModelDd::getArray('goods_color');
			
			foreach($colors as $k=>$v){
				$scolors[$k] =  $goods_colors[$k]; 
			}
			$info['goods_color'] = (count($scolors)>1)?ModelDd::arrayFormat(array_diff($goods_colors,$scolors)):ModelDd::arrayFormat($colors);
			$info['set_goods_color'] = (count($scolors)>1)?ModelDd::arrayFormat($scolors):'';
			//获取已选择的尺码集合
			$sizes = array_flip(explode(",",substr($rs['sizes'],1,strlen($rs['sizes'])-1)));
			$goods_sizes = ModelDd::getArray('goods_size');
			foreach($sizes as $k=>$v){
				$ssizes[$k] =  $goods_sizes[$k]; 
			}
			$info['goods_size'] = (count($ssizes)>1)?ModelDd::arrayFormat(array_diff($goods_sizes,$ssizes)):ModelDd::arrayFormat($sizes);
			$info['set_goods_size'] = (count($ssizes)>1)?ModelDd::arrayFormat($ssizes):'';
			
		}else{
			$info['goods_size']=ModelDd::getComboData('goods_size');
			$info['goods_color']=ModelDd::getComboData('goods_color');
		}
		$this->tpl->assign('info', $info);
		$this->name = 'product_add';
		$this->show();
	}
	/**
	 * 产品列表
	 */
	function actionList() {
		$pageLimit = getPageLimit();
		$object = new ModelNewProduct();
		$where = $object->getWhere($_REQUEST);
		$action_type=$_REQUEST['action_type'];
		if($action_type==2) {
			$where=$where.($where?' and ':' where').' a.type= 0';
			$list = $object->getGoodsImgList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getGoodsImgListCount($where);
		}elseif($action_type==4 || $action_type==5){
			$where=$where.($where?' and ':' where').' a.type<> 0';
			if($action_type==5){
				$where=$where.($where?' and ':' where'). ' d.audit_status =5';
				//此处需要加上权限
				/**
				*languages 对象语言所对应的值进行权限区分 
				*$where=$where.($where?' and ':' where').' a.type='.1;
				*/
			}else{
				$where=$where.($where?' and ':' where'). ' a.user_id= '.$_SESSION['admin_id'].' and ((n.status =3 and (d.audit_status is null or  d.audit_status=0)) or d.audit_status=7)';
			}
			$list = $object->getGoodsDesList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getGoodsDesListCount($where);
		}else{
			$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getListCount($where);
		}
		
		for($i=0;($i<count($list));$i++){
			$goods=$list[$i];
			$dess=$object->goodsDesList(null,null,$goods['goods_id']);
			$goods['depict'].='<br />';
			if($dess){
				foreach($dess as $des){
				$goods['depict'].=('<br /><b>'.$des['des_lang_id'].'</b>:<br />'.$des['des_text'].'<br />');
				}
			}
			$goods['depict'].='<br />';
			$list[$i]=$goods;
		}
		
		$result['topics'] = $list?$list:'';
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	*删除产品信息
	*/
	function actionDelete() {
		$object = new ModelNewProduct();
		try {
			$object->delete($_REQUEST['goods_id']);
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	*删除图片信息
	*/
	function actionDeleteImg() {
		$object = new ModelNewProduct();
		try {
			$object->deleteImg($_REQUEST['goods_id']);
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	*删除描述信息
	*/
	function actionDeleteDes() {
		$object = new ModelNewProduct();
		try {
			$object->deleteDes($_REQUEST['goods_id']);
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	*产品信息审核
	*/
	function actioninfoAudit() {
		$this->load();
		$this->tpl->assign('action_type',1);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*产品图片管理
	*/
	function actionimg() {
		$this->load();
		$this->tpl->assign('action_type',2);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*产品图片审核
	*/
	function actionimgAudit() {
		$this->load();
		$this->tpl->assign('action_type',3);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*产品描述管理
	*/
	function actiondes() {
		$this->load();
		$this->tpl->assign('action_type',4);
		$this->name = 'product_list';
		$this->show();
	} 
	/**
	*产品描述审核
	*/   
	function actiondesAudit() {
		$this->load();
		$this->tpl->assign('action_type',5);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*产品终审
	*/
	function actionAudit() {
		$this->load();
		$this->tpl->assign('action_type',6);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*所有产品
	*/
	function actionAllProduct() {
		$this->load();
		$this->tpl->assign('action_type',7);
		$this->name = 'product_list';
		$this->show();
	}
	/**
	*任务分配列表
	*/
	function actionAssignProduct() {
		$this->load();
		$this->tpl->assign('tasks',"['0','image'],".ModelDd::getComboData('languages'));
		$this->tpl->assign('users',ModelDd::getComboData('user'));
		$this->tpl->assign('action_type',8);
		$this->name = 'product_list';
		$this->show();
	}
	
	/**
	*更改产品状态 针对管理列表页面下提交审核按钮及审核通过进行的
	*/
	function actionUpdateStatusList() {
		$object = new ModelNewProduct();
		try {
			if($_REQUEST['goods_id']&&$_REQUEST['goods_id']<>''){
				$goods_ids=explode(',',$_REQUEST['goods_id']);
				$types=explode(',',$_REQUEST['type']);
				for($i=0;$i<count($goods_ids);$i++){
					$goods_id=$goods_ids[$i];
					$type=$types[$i];
					if($_REQUEST['action_type']==1 ||$_REQUEST['action_type']==3 ||$_REQUEST['action_type']==5 ||$_REQUEST['action_type']==6){
						$goods=$object->goodsInfo($goods_id);
						$audit=array();
						$audit['audit_type']=0;
						$audit['goods_id']=$goods_id;
						if($_REQUEST['action_type']==1){
							$audit['audit_status']=$goods['status'];
						}elseif($_REQUEST['action_type']==3){
							$audit['audit_status']=$goods['img_status'];
						}elseif($_REQUEST['action_type']==5){
							$audit['audit_status']=$goods['des_status'];
						}elseif($_REQUEST['action_type']==6){
							$audit['audit_status']=10;
						}
						$object->saveAudit($audit);
					}
					$object->updatestatus($goods_id,$object->getstatus($_REQUEST['action_type'],0),$type);
				}
				echo "操作已成功";exit;
			}else{
				echo "未选择行，请选择需要操作的行！";exit;
			}
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo $errorMsg;exit;
	}
	/**
	*更改产品状态 针对页面提交
	*审核类型：$_REQUEST['audit_type'];[0,'审核通过'],[1,'审核信息失败'],[2,'审核图片失败'],[3,'审核描述失败']
	*/
	function actionUpdateStatus() {
		$object = new ModelNewProduct();
		try {
			$object->updatestatus($_REQUEST['goods_id'],$object->getstatus($_REQUEST['action_type']));
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	function showProduct(){
		$this->tpl->assign('action_type',$_REQUEST['action_type']);
		$this->tpl->assign('type',$_REQUEST['type']);
		$object = new ModelNewProduct();
		$rs = $object->goods_info($_REQUEST['goods_id']);
		//获取已选择的颜色集合
		$colors = array_flip(explode(",",substr($rs['colors'],1,strlen($rs['colors'])-1)));
		$goods_colors = ModelDd::getArray('goods_color');
		foreach($colors as $k=>$v){
			if($goods_colors[$k]){
				$color.=$goods_colors[$k].','; 
			}
		}
		$rs['colors']=$color;
		//获取已选择的尺码集合
		$sizes = array_flip(explode(",",substr($rs['sizes'],1,strlen($rs['sizes'])-1)));
		$goods_sizes = ModelDd::getArray('goods_size');
		foreach($sizes as $k=>$v){
			if($goods_sizes[$k]){
				$size.=$goods_sizes[$k].','; 
			}
		}
		$rs['sizes']=$size;
		if($_REQUEST['action_type'] ==4 ||$_REQUEST['action_type'] ==5 ||$_REQUEST['action_type']==6){
			//描述集合
			$dess=$object->goodsDesList(null,null,$_REQUEST['goods_id']);
			$rs['depict'].='<br />';
			foreach($dess as $des){
				if(($_REQUEST['type'] && $_REQUEST['type'] == $des['des_lang_id']) || !$_REQUEST['type']){
					if($_REQUEST['type'] && $_REQUEST['action_type'] ==4 && $_REQUEST['type'] == $des['des_lang_id']){
						$rs['des_text']=$des['des_text'];
					}
					if($_REQUEST['action_type'] !=4){
						$rs['depict'].=('<br /><b>'.$des['des_lang_id'].'</b>:<br />'.$des['des_text'].'<br />');
					}
				}
			}
			$rs['depict'].='<br />';
		}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$good = $json->encode($rs);
		$this->tpl->assign('good',$good); 
	}
	function actionShowProduct(){
		if(!$_REQUEST['goods_id']){
			echo "未选择行，请选择需要操作的行！";exit;
		}
		$this->showProduct();
		$this->name = 'product_show';
		$this->show();
	}
	function actionEditProduct(){
		$this->showProduct();
		if($_REQUEST['action_type']==2){
			$this->tpl->assign('typedata',ModelDd::getComboData('goods_img_place'));
			$this->name = 'img_edit';
			$this->show();
		}elseif($_REQUEST['action_type']=4){
			$this->tpl->assign('languages',ModelDd::getComboData('languages'));
			$this->name = 'des_edit';
			$this->show();
		}
	}
	//提交审核
	function actionAuditGoods(){		
		$object = new ModelNewProduct();
		if($_REQUEST['action_type']==4){
			$object->saveDes($_REQUEST);
		}
		try {
			if($_REQUEST['goods_id']&&$_REQUEST['goods_id']<>''){
				$goods_ids=explode(',',$_REQUEST['goods_id']);
				foreach($goods_ids as $goods_id){
					if($_REQUEST['action_type']==1 ||$_REQUEST['action_type']==3 ||$_REQUEST['action_type']==5 ||$_REQUEST['action_type']==6){
						$goods=$object->goodsInfo($goods_id);
						$audit=array();
						$audit['audit_type']=$_REQUEST['audit_status']?$_REQUEST['audit_status']:0;
						$audit['goods_id']=$goods_id;
						$audit['audit_advice']=$_REQUEST['audit_advice'];
						if($_REQUEST['action_type']==1){
							$audit['audit_status']=$goods['status'];
						}elseif($_REQUEST['action_type']==3){
							$audit['audit_status']=$goods['img_status'];
						}elseif($_REQUEST['action_type']==5){
							$audit['audit_status']=$goods['des_status'];
						}elseif($_REQUEST['action_type']==6){
							$audit['audit_status']=3;
						}
						$object->saveAudit($audit);
					}
					$object->updatestatus($goods_id,$object->getstatus($_REQUEST['action_type'],$_REQUEST['audit_status']),$_REQUEST['type']);
				}
				echo "{success:true,msg:'审核提交成功'}";exit;
			}else{
				echo "{success:false,msg:'审核提交失败'}";exit;
			}
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo $errorMsg;exit;
	}
	//获取描述集合
	function actionDesList(){
		$pageLimit = getPageLimit();
		$object = new ModelNewProduct();
		$list = $object->goodsDesList($pageLimit['from'],$pageLimit['to'],$_REQUEST['goods_id']);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list?$list:'';
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	//获取图片集合
	function actionImgList(){
		$object = new ModelNewProduct();
		$pageLimit = getPageLimit();
		$list = $object->goodsImgList($pageLimit['from'],$pageLimit['to'],$_REQUEST['goods_id']);
		$result['totalCount'] = $object->imgcount($_REQUEST['goods_id']);
		$result['topics'] = $list?$list:'';
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	*导出
	*/
	function actionexportGoods(){
		$object = new ModelNewProduct();
		$list = array();
		if($action_type==2) {
			$where=$where.($where?' and ':' where').' a.type= 0';
			$list = $object->getGoodsImgList(null,null,$where);
		}elseif($action_type==4 || $action_type==5){
			$where=$where.($where?' and ':' where').' a.type<> 0';
			if($action_type==5){
				$where=$where.($where?' and ':' where'). ' d.audit_status =5';
				//此处需要加上权限
				/**
				*languages 对象语言所对应的值进行权限区分 
				*$where=$where.($where?' and ':' where').' a.type='.1;
				*/
			}else{
				$where=$where.($where?' and ':' where'). ' a.user_id= '.$_SESSION['admin_id'].' and ((n.status =3 and (d.audit_status is null or  d.audit_status=0)) or d.audit_status=7)';
			}
			$list = $object->getGoodsDesList(null,null,$where);
		}else{
			$list = $object->getList(null,null,$where);
		}
		$ra=array();
		for($i=0;$i<count($list);$i++){
			$rs=$list[$i];
			$dess=$object->goodsDesList(null,null,$rs['goods_id']);
			if($dess){
				foreach($dess as $des){
					$rs[$des['des_lang_id']]=$des['des_text'];
				}
			}
			$imgs=$object->goodsImgList(null,null,$rs['goods_id']);
			$n=0;
			$imgm=array();
			if($imgs){
				foreach($imgs as $img){
					if($n!=0){
						if($img['img_assign']!=$imgm['img_assign']){
							$n=0;
							$rs[$img['img_assign'].'_'.$n]=$img['url'];
							$imgm=$img;
						}else{
							$rs[$img['img_assign'].'_'.$n]=$img['url'];
							$n++;
						}
					}else{
						$rs[$img['img_assign'].'_'.$n]=$img['url'];
						$n++;
					}
				}
			}
			$ra[]=$rs;
		}
		$list=$ra;
		
		$languages=ModelDd::getArray('languages');
		$img_assign=ModelDd::getArray('goods_img_place');
				
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
		$header = '产品名称,SKU,品牌,产品分类,首图,产品连接,产品标题,产品属性,产品简述,产品描述,价格,长,宽,高,净重,毛重,颜色集,尺码,基本信息审核状态,图片审核状态,描述审核状态,备注';
		//添加语言列
		$header.=','.implode(',',$languages);
		//添加图片列
		foreach($img_assign as $type){
			for($i=0;$i<5;$i++){
				$header.=(','.$type.'_'.$i);
			}
		}
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
			$order_value[] = $list[$i]['goods_name'];
			$order_value[] = $list[$i]['sku'];
			$order_value[] = $list[$i]['brand_id'];
			$order_value[] = $list[$i]['cat_id'];
			$order_value[] = $list[$i]['goods_img'];
			$order_value[] = $list[$i]['goods_url'];
			$order_value[] = $list[$i]['goods_title'];
			$order_value[] = $list[$i]['goods_attribute'];
			$order_value[] = $list[$i]['resume'];
			$order_value[] = $list[$i]['depict'];
			$order_value[] = $list[$i]['price'];
			$order_value[] = $list[$i]['l'];
			$order_value[] = $list[$i]['w'];
			$order_value[] = $list[$i]['h'];
			$order_value[] = $list[$i]['suttle'];
			$order_value[] = $list[$i]['weight'];
			$order_value[] = $list[$i]['colors'];
			$order_value[] = $list[$i]['sizes'];
			$order_value[] = $list[$i]['status'];
			$order_value[] = $list[$i]['img_status'];
			$order_value[] = $list[$i]['des_status'];
			$order_value[] = $list[$i]['comment'];
			foreach($languages as $language){
				$order_value[] = $list[$i][$language];
			}
			foreach($img_assign as $type){
				for($j=0;$j<5;$j++){
					$order_value[] = $list[$i][$type.'_'.$j];
				}
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
		$file = 'data/ordertmp/planlist'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	
	/**
	*任务分配
	*/
	function actionAssign(){
		$goods_ids=explode(',',$_REQUEST['goods_id']);
		try {
			$object = new ModelNewProduct();
			foreach($goods_ids as $goods_id){
				$info=array('goods_id'=>$goods_id,'task'=>$_REQUEST['task'],'user'=>$_REQUEST['user']);
				$object->insertAssign($info);
			}
			echo "分配成功!";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo $errorMsg;exit;
	}
	/**
	*任务重新分配
	*/
	function actionReAssign(){
		$goods_ids=explode(',',$_REQUEST['goods_id']);
		try {
			$object = new ModelNewProduct();
			foreach($goods_ids as $goods_id){
				$object->reAssign($goods_id);
			}
			echo "重新分配成功!";exit;
		} catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo $errorMsg;exit;
	}
	
	/**
	*任务分配情况
	*/
	function actionassignlist(){
		$pageLimit = getPageLimit();
		$object = new ModelNewProduct();
		$list = $object->goodsAssignList($pageLimit['from'],$pageLimit['to'],$_REQUEST['goods_id']);
		$result['totalCount'] = $object->assignListCount($_REQUEST['goods_id']);
		$result['topics'] = $list?$list:'';
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	*删除产品任务信息
	*/
	function actiondeleteAssign(){
		$object = new ModelNewProduct();
		try {
			$object->deleteAssign($_REQUEST['assign_id']);
			echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
}
?>