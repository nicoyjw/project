<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 产品管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Goods extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '产品管理';
		$this->name = 'index';
		$this->dir = 'goods';
		$action_list = explode(',',$_SESSION['action_list']);
		$goods_right[] = in_array('view_price',$action_list)?1:0;
		$goods_right[] = in_array('list_cn',$action_list)?1:0;
		$goods_right[] = in_array('list_us',$action_list)?1:0;
		$goods_right[] = in_array('list_au',$action_list)?1:0;
		$goods_right[] = in_array('list_uk',$action_list)?1:0;
		$goods_right[] = in_array('list_de',$action_list)?1:0;
		$goods_right[] = in_array('list_fr',$action_list)?1:0;
		$goods_right[] = in_array('list_sp',$action_list)?1:0;
		$goods_right[] = in_array('view_cost',$action_list)?1:0;
		$goods_right[] = in_array('edit_cost',$action_list)?1:0;
		$goods_right[] = in_array('view_price1',$action_list)?1:0;
		$goods_right[] = in_array('edit_price1',$action_list)?1:0;
		$goods_right[] = in_array('view_price2',$action_list)?1:0;
		$goods_right[] = in_array('edit_price2',$action_list)?1:0;
		$goods_right[] = in_array('view_price3',$action_list)?1:0;
		$goods_right[] = in_array('edit_price3',$action_list)?1:0;
		$goods_right[] = in_array('edit_stock',$action_list)?1:0;//16
		$goods_right[] = in_array('view_supplier',$action_list)?1:0;
		$goods_right[] = in_array('ali_goods',$action_list)?1:0;
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
	}
	/**
	 * 所有产品列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_goods');
        
        
        //var_dump(ModelDd::getComboData('goods_status'));exit;
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->tpl->assign('goods_color',ModelDd::getComboData('goods_color'));
		$this->tpl->assign('goods_size',ModelDd::getComboData('goods_size'));
		$this->tpl->assign('languages',ModelDd::getComboData('languages'));
		$this->tpl->assign('aliaccount',ModelDd::getComboData('aliaccount'));
		$this->tpl->assign('allaccount',ModelDd::getComboData('user'));
		$this->show();
	}
	
	/**
	 * 默认页面---加载ebay产品
	 */
	function actionLoad() {                  
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->name = 'loadgoods';
		$this->show();
	}	
	/**
	 * 产品加载
	 */
	function actionLoadgoods() {
			$object = new ModelGoods();
			try {
				$msg = explode('|',$object->saveEbayGoods($_GET));
				echo '<br>共有'.$msg[0].'页共'.$msg[1].'条记录';
			} catch (Exception $e) {
					echo "<br>" . $e->getMessage();
			}
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	
	function actionLoadbestmatch()
	{
			$object = new ModelGoods();
			try {
				require(CFG_PATH_DATA . 'ebay/ebay_' . $_GET['id'] .'.php');
				if($cat_id == ''){ echo '请先添加该账号对应的Ebay产品分类id，多分类以,连接';exit();}
				$catId = explode(",",$cat_id);
				for($j=0;$j<count($catId);$j++){
					$msg = explode('|',$object->saveEbaybestmatch($_GET,$catId[$j]));
					echo '<br>共有'.$msg[1].'页共'.$msg[2].'条记录';
					if($msg[1] == 0) die('<br>加载完成');
					for($i=1;$i<=$msg[1];$i++){
						$info['id'] = $_GET['id'];
						$info['page'] = $i;
						$msg1 = $object->loadbestmatchXml($info,$catId[$j]);
						echo "<br>第".$i."页加载完成，共有".$msg1."条bestmatch数据被加载";
					}
				}
			} catch (Exception $e) {
					echo "<br>" . $e->getMessage();
			}
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	
	function actionLoadcategory()
	{
			$object = new ModelGoods();
			try {
				$object->loadcategory($_GET['id']);
				echo "加载成功";
			} catch (Exception $e) {
					echo "<br>" . $e->getMessage();
			}
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	
	/*****
	*本地listing加载后使用
	*****/
	function actionchecklisting(){                 
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->name = 'checklisting';
		$this->show();
	}
	/*****
	*Amazonlisting加载后使用
	*****/
	function actionAmzlisting(){
		parent::actionPrivilege('check_listing');
		$this->tpl->assign('account',ModelDd::getComboData('amazonaccount'));
		$this->name = 'amazonlisting';
		$this->show();
	}
	
	
	/**
	 * 导入产品
	 */
	function actionImport() {
		parent::actionPrivilege('import_goods');
		$this->name = 'import';
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->show();
	}
	/**
	 * 产品批量查询库存/固定价
	 */
	function actionAdvsearch() {
		parent::actionPrivilege('goods_advsearch');
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->name = 'advsearch';
		$this->show();
	}
	/**
	 * 产品信息批量更新
	 */
	function actionUpdate()
	{
		parent::actionPrivilege('goods_update');
		$this->tpl->assign('shelf',ModelDd::getComboData('shelf'));
		$this->tpl->assign('account',ModelDd::getComboData('allaccount'));
		$this->name = 'goods_update';
		$this->show();
	}
	/**
	 * 品牌和分类
	 */
	function actionCategory() {
		parent::actionPrivilege('list_category');
		$object = new ModelAttribute();
		$this->tpl->assign('allaccount',ModelDd::getComboData('user'));
		$this->tpl->assign('group',ModelDd::getComboData('attr_group'));
		$this->tpl->assign('value',ModelDd::getComboData('attr_group_id'));
		$this->name = 'category';
		$this->show();
	}
	/**
	 * 返回category json列表
	 *
	 */
	function actionCatList()
	{
		$pageLimit = getPageLimit();
		$goods = new ModelGoods();
		$list = $goods->getCatList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $goods->getCatCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 新增产品
	 */
	function actionAdd() {
		parent::actionPrivilege('add_goods');
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('allaccount',ModelDd::getComboData('user'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->tpl->assign('goods_color',ModelDd::getComboData('goods_color'));
		$this->tpl->assign('goods_size',ModelDd::getComboData('goods_size'));
		$this->tpl->assign('languages',ModelDd::getComboData('languages'));
		$this->name = 'goods';
		$this->show();
	}
	function actionAddcombine() {
		parent::actionPrivilege('add_goods');
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->name = 'combinegoods';
		$this->show();
	}

	/****
	*编辑产品
	****/
	function actionEdit(){
		parent::actionPrivilege('edit_goods');
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('allaccount',ModelDd::getComboData('user'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->tpl->assign('goods_color',ModelDd::getComboData('goods_color'));
		$this->tpl->assign('goods_size',ModelDd::getComboData('goods_size'));
		$object = new ModelGoods();
		$rs = $object->goods_info($_GET['goods_id']);
		$rs['keeptime'] = MyDate::transform('date',$rs['keeptime']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$good = $json->encode($rs);
		$this->tpl->assign('good',$good); 
		$this->name = 'editgoods';
		$this->show();
	}
	function actionEditcombine(){
		parent::actionPrivilege('edit_goods');
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$object = new ModelGoods();
		$rs = $object->goods_info($_GET['goods_id']);
		$rs['keeptime'] = MyDate::transform('date',$rs['keeptime']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$good = $json->encode($rs);
		$this->tpl->assign('good',$good); 
		$this->name = 'editcombinegoods';
		$this->show();
	}
	/**
	 * 保存goods
	 *
	 */
	 function actionSave(){
		$object = new ModelGoods();
		
		if($_POST['goods_sn']) {
			if($object->checkSN($_POST['goods_sn'])) {
				echo "{success:false,msg:'产品编码已存在'}";exit;
			}else{
				if(CFG_AUTOCREAT_SN){
					$_POST['goods_sn'] = $object->generate_goods_sn($_POST['cat_id']);
				}
			}
			if($_POST['SKU']){
				$_POST['SKU'] = $_POST['SKU'];
			}else{
				$_POST['SKU'] = $_POST['goods_sn'];
			}
		}
		if($_FILES['photo_path']['name']){//上传图片
			require(CFG_PATH_LIB.'util/UploadFile.class.php');
			$upload = new UploadFile();
			try{
				
				$_POST['goods_img'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['photo_path'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['goods_img'] = 'erp_client/'.$_SESSION['company'].'/data/upload/no_picture.gif';
		}
		$_POST['is_group'] = ($_POST['is_group'])?1:0;
		$_POST['sn_control'] = ($_POST['sn_control'])?1:0;
		$_POST['is_control'] = ($_POST['is_control'])?1:0;
		$_POST['has_child'] = ($_POST['has_child'])?1:0;
		if($_POST['is_group'] == 1){
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			$goodsarr = $json->decode(stripslashes($_POST['data']));
			foreach($goodsarr as $good){
				$good->goods_name = addslashes_deep($good->goods_name);
				if($good->goods_name == "" || $good->goods_sn == "") {
					echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
				}
			}
			$_POST['data'] = $goodsarr;
			
		}
		//属性序列化处理
		/*if($_POST['attrdata']){
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			$attrarr = $json->decode(stripslashes($_POST['attrdata']));
			$attob = new ModelAttribute();
			$result = array();
			foreach($attrarr as $attr){
				$attr->value_id = addslashes_deep($attr->value_id);
				$result[] = $attob->getInfoByValueID($attr->value_id,$_POST['cat_id']);
			}
			$info = serialize($result);
			$_POST['attrdata'] = $info;
		}*/
		if($_POST['has_child'] == 1){
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				$goodsarr = $json->decode(stripslashes($_POST['childdata']));
				foreach($goodsarr as $good){
					$good->child_sn = addslashes_deep($good->child_sn);
					echo "{success:true,msg:'".$good->child_sn."'}";exit;
					if($good->child_sn == "") {
					echo "{success:false,msg:'子产品编码不能为空'}";exit;
					}
				}
				$_POST['childdata'] = $goodsarr;
			}
		$goods_id = $object->save($_POST);
		$object->importstock();
		echo "{success:true,msg:'$goods_id'}";exit;
	 }
	/**
	 * 删 除goods
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('del_goods'))
			{
				$object = new ModelGoods();
				try {
						$object->delete($_REQUEST['id']);
						echo "{success:true,msg:'操作已成功'}";exit;
				} catch (Exception $e) {
						$errorMsg = $e->getMessage();
				}
				echo "{success:true,msg:'" . $errorMsg . "'}";exit;
			}
	}

	/**
	 * 返回产品json列表
	 *
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelGoods();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionlistinglist()
	{
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
		$sortob = $json->decode($_REQUEST['sort']);
		$_REQUEST['property'] = $sortob[0]->property;
		$_REQUEST['direction'] = $sortob[0]->direction;
		$pageLimit = getPageLimit();
		$goods = new ModelGoods();
		$where = $goods->getListingWhere($_REQUEST);
		echo $where;
		$list = $goods->getListingList($pageLimit['from'],$pageLimit['to'],$where,'',$pageLimit['sort']);
		$result['totalCount'] = $goods->getListingCount($where);
		$result['topics'] = $list;
		echo $json->encode($result);
	}
	/*********
	@@amazon在线listing列表
	*
	*********/
	function actionamzlistinglist()
	{
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		//$_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
		//$sortob = $json->decode($_REQUEST['sort']);
		//$_REQUEST['property'] = $sortob[0]->property;
		//$_REQUEST['direction'] = $sortob[0]->direction;
		$pageLimit = getPageLimit();
		$goods = new ModelGoods();
		$where = $goods->getAmzListingWhere($_REQUEST);
		$list = $goods->getAmzListingList($pageLimit['from'],$pageLimit['to'],$where,'');
		$result['totalCount'] = $goods->getAmzListingCount($where);
		$result['topics'] = $list;
		echo $json->encode($result);
	}
	
	
	/**
	 * 返回paypal主账号json列表
	 *
	 */
	function actionBrandList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelGoods();
		$list = $object->getBrandList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getBrandCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回category更新
	 *
	 */
	function actionCatupdate()
	{
		if(parent::actionCheck('edit_category')) {
			$goods = new ModelGoods();
			try {
					$attstr = '';
					for($i = 0; $i < count($_POST);$i++){
						if(isset($_POST['att_group_'.$i]) && !empty($_POST['att_group_'.$i])){
							$attstr .= empty($attstr) ? $_POST['att_group_'.$i] : ','.$_POST['att_group_'.$i];
						}
					}
					$_REQUEST['attribute_group_id'] = $attstr;
					$goods->catsave($_REQUEST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除category
	 *
	 */
	function actionCatdel()
	{
		$goods = new ModelGoods();
		$goods->delCat($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	/**
	 * 返回brand更新
	 *
	 */
	function actionbrandupdate()
	{
		if(parent::actionCheck('edit_category')) {
			$goods = new ModelGoods();
			try {
					$goods->brandsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删 除brand
	 *
	 */
	function actionBranddel()
	{
		$goods = new ModelGoods();
		$goods->delBrand($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}		
	/**
	 * 获取组合产品的信息
	 *
	 */
	function actiongetcomgoods()
	{
			$goods = new ModelGoods();
			$list = $goods->combine_goods_info($_POST['comb_goods_id']);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	/**
	 * 获取子产品的信息
	 *
	 */
	function actiongetchildgoods()
	{
			$goods = new ModelGoods();
			$list = $goods->child_goods_info($_POST['goods_id']);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}
	/**
	 * 删除组合产品子产品信息
	 *
	 */
	function actiondelComgoods()
	{
		$goods = new ModelGoods();
		$goods->deletecomgoods($_GET['id']);
		echo "{success:true,msg:'删除成功'}";exit;
	}

	/**
	 * 删除子产品信息
	 *
	 */
	function actiondelChildgoods()
	{
		$goods = new ModelGoods();
		$goods->deletechildgoods($_GET['id']);
		echo "{success:true,msg:'删除成功'}";exit;
	}
	
	/**
	 * 获取树状列表
	 *
	 */
	function actiongetcattree()
	{
			$goods = new ModelGoods();
			$trees = $goods->catTree($_GET['com']);
			$result = $trees[$_REQUEST['node']];
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
	}		

	/**
	 * 获取产品列表
	 *
	 */
	function actiongetgoodslist()
	{
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
		$sortob = $json->decode($_REQUEST['sort']);
		$_REQUEST['property'] = $sortob[0]->property;
		$_REQUEST['direction'] = $sortob[0]->direction;
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$where = $obejct->getWhere($_REQUEST);
		$list = $obejct->getGoodsList($pageLimit['from'],$pageLimit['to'],$where,'',$pageLimit['sort']);
		$result['totalCount'] = $obejct->getGoodsCount($where);
		$result['topics'] = $list;
		echo $json->encode($result);
	}		
	/**
	 * 导出搜索产品
	 */
	function actionexportgoods() {
		set_time_limit(0);
		parent::actionPrivilege('export_goods');
		$object = new ModelGoods();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getGoodsList('','',$where,1);
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
		$header = 'goods_id,goods_sn,SKU,goods_name,cat_id,goods_url,dec_name,goods_img,stock_place,goods_qty,weight,warn_qty,price1,price2,price3,des_en,products_developers,Declared_value,add_time';
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
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
		$t =2;	
		$users = ModelDd::getArray('user');
		for($i=0;$i<count($list);$i++){
				$cf ='A';
				$order_value[] =  $list[$i]['goods_id'];
				$order_value[] =  $list[$i]['goods_sn'];
				$order_value[] =  $list[$i]['SKU'];
				$order_value[] =  $list[$i]['goods_name'];
				$order_value[] =  $list[$i]['cat_id'];
				$order_value[] =  $list[$i]['goods_url'];
				$order_value[] =  $list[$i]['dec_name'];
				$order_value[] =  $list[$i]['goods_img'];
				$order_value[] =  $list[$i]['stock_place'];
				$order_value[] =  $list[$i]['goods_qty'];
				$order_value[] =  $list[$i]['weight'];
				$order_value[] =  $list[$i]['warn_qty'];
				$order_value[] =  $list[$i]['price1'];
				$order_value[] =  $list[$i]['price2'];
				$order_value[] =  $list[$i]['price3'];
				$order_value[] =  $list[$i]['des_en'];
				$order_value[] =  $list[$i]['products_developers'];
				$order_value[] =  $list[$i]['Declared_value'];
                $order_value[] =  $list[$i]['add_time'];
				if($showtable) echo '<tr>';
				for($m=0;$m<count($order_value);$m++){
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
		$file = CFG_PATH_DATA.'ordertmp/goods_list'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		$file = str_replace(CFG_PATH_ROOT, '', $file);
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	/*******
	&产品固定价
	*******/
	function actionexportgoodsfix()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/IOFactory.php');
		echo date('H:i:s') . " Create new PHPExcel object\n";
		$objPHPExcel = new PHPExcel();
		echo date('H:i:s') . " Set properties<br>";
		$objPHPExcel->getProperties()->setCreator("Vekincheng");
		echo date('H:i:s') . " Add some data<br>";
		$currentSheet =$objPHPExcel->getSheet(0);
		require_once(CFG_PATH_DATA . 'dd/currency.php');
		$header = '产品编码,产品名称,SKU';
		foreach($currency as $k=>$v){
			$header .=',fixprice_'.$k;
			}
		$action_list = explode(',',$_SESSION['action_list']);
		if(in_array('view_cost',$action_list)) $header .= ',cost';
		if(in_array('view_price1',$action_list)) $header .= ',price1';
		if(in_array('view_price2',$action_list)) $header .= ',price2';
		if(in_array('view_price3',$action_list)) $header .= ',price3';
		$content = explode(",",$header);
		$object = new ModelGoods();
		$where = $object->getWhere($_REQUEST);
		$list = $object->getGoodsList('','',$where,1);
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
						$order_value[] =  $list[$i]['SKU'];
						foreach($currency as $k=>$v){
							$order_value[] =  $list[$i]['fixprice'][$k];
							}
						if(in_array('view_cost',$action_list)) $order_value[] =  $list[$i]['cost'];
						if(in_array('view_price1',$action_list)) $order_value[] =  $list[$i]['price1'];
						if(in_array('view_price2',$action_list)) $order_value[] =  $list[$i]['price1'];
						if(in_array('view_price3',$action_list)) $order_value[] =  $list[$i]['price1'];
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
	 * 导出搜索listing
	 */
	function actionexportlisting() {
		set_time_limit(0);
		parent::actionPrivilege('export_listing');
		include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
		$zip = new PHPZip;
		$content = '"account","ItemID","ViewItemURL","ListingDuration","ListingType","Quantity","Buyitnowprice","currency","ShippingServiceCost","starttime","endtime","Title","SKU","GalleryURL","startprice","bidcount"'. "\n";
		$object = new ModelGoods();
		$where = $object->getListingWhere($_REQUEST);
		$list = $object->getListingList('','',$where,1);
		for($i=0;$i<count($list);$i++){
			$goods_value['account'] = '"' . $list[$i]['account_id'] . '"';
			$goods_value['ItemID'] = $list[$i]['ItemID'];
			$goods_value['ViewItemURL'] = '"' . $list[$i]['ViewItemURL'] . '"';
			$goods_value['ListingDuration'] = '"' . $list[$i]['ListingDuration'] . '"';
			$goods_value['ListingType'] = '"' . $list[$i]['ListingType'] . '"';
			$goods_value['Quantity'] = $list[$i]['Quantity'];
			$goods_value['buyitnowprice'] = $list[$i]['buyitnowprice'];
			$goods_value['currency'] = '"' . $list[$i]['currency'] . '"';
			$goods_value['ShippingServiceCost'] = $list[$i]['ShippingServiceCost'];
			$goods_value['starttime'] = '"' . $list[$i]['starttime'] . '"';
			$goods_value['endtime'] = '"' . $list[$i]['endtime'] . '"';
			$goods_value['Title'] = '"' . replace_special_char($list[$i]['Title'],false) . '"';
			$goods_value['SKU'] = '"' . $list[$i]['SKU'] . '"';
			$goods_value['GalleryURL'] = '"' . $list[$i]['GalleryURL'] . '"';
			$goods_value['startprice'] = $list[$i]['startprice'];
			$goods_value['bidcount'] = $list[$i]['bidcount'];
			$content .= implode(",", $goods_value) . "\n";	
		}
		//$zip->add_file(file_get_contents(ROOT_PATH . $row['goods_img']), $row['goods_img']);
		$zip->add_file(ecs_iconv('utf-8', 'GBK', $content), 'goods_list.csv');
		header("Content-Disposition: attachment; filename=goods_list.zip");
		header("Content-Type: application/unknown");
		die($zip->file());
	}
	
	/**
	 * 导出未刊登产品
	 */
	function actionexportunlisting() {
		set_time_limit(0);
		$object = new ModelGoods();
		$list = $object->getunlist($_GET['account']);
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
				$currentSheet =$objPHPExcel->getSheet(0);
				$header = '产品编码,产品名称,SKU,库存数量,锁定库存,产品备注';
				$content = explode(",",$header);
				$showtable = 0;
				if($showtable) echo '<table border="1"><tr>';
				for($i=0;$i<count($content);$i++){
						$currentSheet->setCellValueByColumnAndRow($i,1, $content[$i]);
						if($showtable)  echo '<td>'.$content[$i].'</td>';
					}
				if($showtable) echo '</tr>';
				$objPHPExcel->getActiveSheet()->setTitle('sheet1');
				echo date('H:i:s') . " Write to Excel5 format<br>";
				$t =2;
				for($i=0;$i<count($list);$i++){
						$order_value[] =  $list[$i]['goods_sn'];
						$order_value[] =  $list[$i]['goods_name'];
						$order_value[] =  $list[$i]['SKU'];
						$order_value[] =  $list[$i]['goods_qty'];
						$order_value[] =  $list[$i]['varstock'];
						$order_value[] =  $list[$i]['comment'];
						$cf ='A';
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
	 * 导出批量搜索
	 */
	function actionAdvresult() {
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
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();				
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_sn_list .=  ',"'.trim($currentSheet->getCell('A'.$currentRow)->getValue()).'"';
		}
		$info['sn_list'] = substr($goods_sn_list,1);
		$info['advsearch'] = 1;
		$object = new ModelGoods();
		$where = $object->getWhere($info);
		$list = $object->getGoodsList('','',$where,1);
		$objPHPExcel->setActiveSheetIndex(0);
		$currentSheet =$objPHPExcel->getSheet(0);
		$header = '产品编码,产品名称,SKU,库存数量,锁定库存,可用库存';
		foreach($currency as $k=>$v){
			$header .=',fixprice_'.$k;
			}
		$header .=',库存位置';
		$content = explode(",",$header);
		$showtable = 0;
		if($showtable) echo '<table border="1"><tr>';
		for($i=0;$i<count($content);$i++){
				$currentSheet->setCellValueByColumnAndRow($i,1, $content[$i]);
				if($showtable)  echo '<td>'.$content[$i].'</td>';
			}
		if($showtable) echo '</tr>';
		$objPHPExcel->getActiveSheet()->setTitle('sheet1');
		echo date('H:i:s') . " Write to Excel5 format<br>";
		$t =2;
		for($i=0;$i<count($list);$i++){
				$order_value[] =  $list[$i]['goods_sn'];
				$order_value[] =  $list[$i]['goods_name'];
				$order_value[] =  $list[$i]['SKU'];
				$getgoodsqty = $object->getgoodsqty($list[$i]['goods_id'],$_POST['depot_id']);
				$order_value[] =  $list[$i]['goods_qty'];
				$order_value[] =  $list[$i]['varstock'];
				$order_value[] =  $getgoodsqty['goods_qty']-$getgoodsqty['varstock'];
				foreach($currency as $k=>$v){
					$order_value[] =  $list[$i]['fixprice'][$k];
					}
				$order_value[] =  $list[$i]['stock_place'];
				$cf ='A';
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
		$file = CFG_PATH_DATA.'ordertmp/goods_list'.$_SESSION['admin_id'].'.xls';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		$file = str_replace(CFG_PATH_ROOT, '', $file);
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();		
	}
	
	/**
	 * 批量生成SKU
	 */
	function actiongeneratesku() {
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
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();				
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_sn_list[] =  trim($currentSheet->getCell('A'.$currentRow)->getValue());
		}
		$object = new ModelGoods();
		$objPHPExcel->setActiveSheetIndex(0);
		$currentSheet =$objPHPExcel->getSheet(0);
		$showtable = 0;
		if($showtable) echo '<table border="1">';
		$objPHPExcel->getActiveSheet()->setTitle('sheet1');
		echo date('H:i:s') . " Write to Excel5 format<br>";
		include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel5.php');
		$t =1;
		for($i=1;$i<count($goods_sn_list)+1;$i++){
				$sku =  $object->generatesku($goods_sn_list[$i-1]);
				$objPHPExcel->getActiveSheet()->setCellValue('A'.$i, $goods_sn_list[$i-1]);
				if($showtable)  echo '<td>'.$goods_sn_list[$i-1].'</td>';
				$objPHPExcel->getActiveSheet()->setCellValue('B'.$i, $sku);
				if($showtable)  echo '<td>'.$sku.'</td>';
		}
		if($showtable) echo '</table>';
		$objWriter = new PHPExcel_Writer_Excel5($objPHPExcel);
		$file = CFG_PATH_DATA.'ordertmp/goods_sku'.$_SESSION['admin_id'].'.xls';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();			
	}
	/**
	 * 批量更新产品信息
	 */
	function actionUpdategoods() {
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$field_list = array();
		$object = new ModelGoods();
		$msg = '';
		if($currentSheet->getCell("A1")->getValue() != 'goods_sn') {echo "{success:false,msg:'文件格式错误'}";exit;}
		for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){ //第一行取更新字段
			$field_list[] = trim($currentSheet->getCell($currentColumn."1")->getValue());
		}
		$err = 0;
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info = array();
			$filed_value = array();
			for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){
				$address = $currentColumn.$currentRow;
				$filed_value[] = trim($currentSheet->getCell($address)->getValue());
			}
			for($i=0;$i<count($field_list);$i++){
				$goods_info[$field_list[$i]] = $filed_value[$i];
				}
			try {
				$object->updategoods($goods_info,trim($currentSheet->getCell("A".$currentRow)->getValue()));
			} catch (Exception $e) {
					$err =1;
					$msg .= $currentSheet->getCell("A".$currentRow)->getValue().'产品数据保存失败<br>';
			}
		}
		if($err == 1) {echo "{success:false,msg:'$msg'}";exit;}
		savelog($_SESSION['admin_id'],'goods','批量更新产品信息',$_SESSION['admin_id']);
		echo "{success:true,msg:'产品更新成功'}";exit;
	}
	
	/***************
	**更新产品货架库存
	***************/
	function actionUpdatestock()
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
		$object = new ModelGoods();
		$msg = '';
		if($currentSheet->getCell("A1")->getValue() != 'goods_sn') {echo "{success:false,msg:'文件格式错误'}";exit;}
		for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){ //第一行取更新字段
			$field_list[] = trim($currentSheet->getCell($currentColumn."1")->getValue());
		}
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info = array();
			$filed_value = array();
			for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){
				$address = $currentColumn.$currentRow;
				$filed_value[] = trim($currentSheet->getCell($address)->getValue());
			}
			for($i=0;$i<count($field_list);$i++){
				$goods_info[$field_list[$i]] = $filed_value[$i];
				}
		
			$goods_info['goods_id']=$object->getidBySKU(trim($currentSheet->getCell('A'.$currentRow)->getValue()));
			$goods_info['shelf_id'] = $_POST['shelf_id'];
			try {
				$object->updatestock($goods_info);
			} catch (Exception $e) {
					$err =1;
					$msg .= $currentSheet->getCell("A".$currentRow)->getValue().'产品库存保存失败<br>';
			}
		}
		if($err == 1) {echo "{success:false,msg:'$msg'}";exit;}
		savelog($_SESSION['admin_id'],'goods','批量更新产品库存',$_SESSION['admin_id']);
		echo "{success:true,msg:'产品更新成功'}";exit;
	}
	
	/**
	 * 上传产品
	 */
	function actionUpload() {
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allRow = $currentSheet->getHighestRow();
		$allColumn = $currentSheet->getHighestColumn();
		if(trim($currentSheet->getCell('A1')->getValue())!== 'goods_sn' )					{
			echo "{success:false,msg:'xls格式错误'}";exit;
		}
		
		for($i='A';$i<=$allColumn;$i++){
			$line_list[$i] = trim($currentSheet->getCell($i."1")->getValue());
		}
		//echo "{success:true,msg:'".$currentSheet->getCell("A2")->getValue()."'}";exit;
		$field_num = count($line_list);
		$object = new ModelGoods();
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){
			$com = array();
			$sku = $currentSheet->getCellByColumnAndRow(0, $currentRow)->getValue();
			if($sku == '') continue;
			$arr['cat_id'] = $_POST['cat_id'];
			$arr['brand_id'] = $_POST['brand_id'];
			$arr['is_group'] = $_POST['type'];
			for($i='A';$i<=$allColumn;$i++){
				$arr[$line_list[$i]] = trim($currentSheet->getCell($i.$currentRow)->getValue());
			}
			if($_POST['type']){//导入组合产品
				if($object->checkSN(@$arr['child_sn'])){
					$goods->goods_id = $object->getidBySKU($arr['child_sn']);unset($arr['child_sn']);
					$goods->goods_qty = $arr['child_qty'];unset($arr['child_qty']);
					$goods->rec_id = 0;
					$com['data'][] = $goods;
					}else{
					$msg .= @$arr['goods_sn'].'组合明细SKU不能为空<br>';	
					}
				}
		if($object->checkSN($sku)){
					$arr['goods_id'] = $object->getidBySKU($sku);
					try{
							if($_POST['type'])  {
								$com['goods_id'] = $arr['goods_id'];
								$object->savecom($com);
							}else{
								$object->update(addslashes_deep($arr));
							}
						} catch (Exception $e) {
							$msg .= $errorMsg = $e->getMessage();
					}
			}else{
					if(!array_key_exists('keeptime',$arr) || (array_key_exists('keeptime',$arr)&&$arr['keeptime'] == '')) $arr['keeptime'] = '2037-12-31';
					if(!array_key_exists('status',$arr) || (array_key_exists('status',$arr)&&$arr['status'] == '')) $arr['status'] = 1;
					if(!array_key_exists('price_au',$arr) || (array_key_exists('price_au',$arr)&&$arr['price_au'] == '')) $arr['price_au'] = 0;
					if(!array_key_exists('price_cn',$arr) || (array_key_exists('price_cn',$arr)&&$arr['price_cn'] == '')) $arr['price_cn'] = 0;
					if(!array_key_exists('price_de',$arr) || (array_key_exists('price_de',$arr)&&$arr['price_de'] == '')) $arr['price_de'] = 0;
					if(!array_key_exists('price_fr',$arr) || (array_key_exists('price_fr',$arr)&&$arr['price_fr'] == '')) $arr['price_fr'] = 0;
					if(!array_key_exists('price_sp',$arr) || (array_key_exists('price_sp',$arr)&&$arr['price_sp'] == '')) $arr['price_sp'] = 0;
					if(!array_key_exists('price_uk',$arr) || (array_key_exists('price_uk',$arr)&&$arr['price_uk'] == '')) $arr['price_uk'] = 0;
					if(!array_key_exists('cost',$arr) || (array_key_exists('cost',$arr)&&$arr['cost'] == '')) $arr['cost'] = 0;
					if(!array_key_exists('price1',$arr) || (array_key_exists('price1',$arr)&&$arr['price1'] == '')) $arr['price1'] = 0;
					if(!array_key_exists('price2',$arr) || (array_key_exists('price2',$arr)&&$arr['price2'] == '')) $arr['price2'] = 0;
					if(!array_key_exists('price3',$arr) || (array_key_exists('price3',$arr)&&$arr['price3'] == '')) $arr['price3'] = 0;
					if(!array_key_exists('status',$arr) || (array_key_exists('status',$arr)&&$arr['status'] == '')) $arr['status'] = 1;
					if(!array_key_exists('is_control',$arr) || (array_key_exists('is_control',$arr)&&$arr['is_control'] == '')) $arr['is_control'] = 1;
					if(!array_key_exists('goods_img',$arr) || (array_key_exists('goods_img',$arr)&&$arr['goods_img'] == '')){
						$arr['goods_img'] = ((CFG_RUN_MODE == 1)?$_SESSION['company'].'/':'').'data/upload/no_picture.gif';
					}
					$arr['goods_id'] = $object->save(addslashes_deep($arr));
					if($arr['goods_id']){
							if($_POST['type'])  {
								$com['goods_id'] = $arr['goods_id'];
								$object->savecom($com);
							}
						}else{
						$msg .= $arr['goods_sn'].'保存失败<br>';
					}
			}
		}
		$object->importstock();			
		if($msg <> '') {echo "{success:false,msg:'".$msg."'}";exit;}
		echo "{success:true,msg:'OK'}";exit;
	}
	/**
	 * 上传产品序列号
	 */
	function actionUploadSN() {
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path1']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allRow = $currentSheet->getHighestRow();
		$allColumn = $currentSheet->getHighestColumn();
		$object = new ModelGoods();
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){
			$sku = $currentSheet->getCell('A'.$currentRow)->getValue();
			if($sku == '') continue;
					$arr['sku'] = trim($sku);
					if(!$arr['goods_id']) $msg .= $sku."未在系统内找到<br>";
					$arr['sn'] = trim($currentSheet->getCell('B'.$currentRow)->getValue());
					$arr['order_sn'] = trim($currentSheet->getCell('C'.$currentRow)->getValue());
					$arr['in_sn'] = trim($currentSheet->getCell('D'.$currentRow)->getValue());
					$arr['out_sn'] = trim($currentSheet->getCell('E'.$currentRow)->getValue());
					$arr['id'] = $object->getSnid($arr['goods_id'],$arr['sn']);
					try{
						$object->savegoodsSN(addslashes_deep($arr));
						} catch (Exception $e) {
							$msg .= $errorMsg = $e->getMessage();
					}
		}
		if($msg <> '') {echo "{success:false,msg:'".$msg."'}";exit;}
		echo "{success:true,msg:'OK'}";exit;
	}
	
	/*****
	*产品修改记录
	*****/
	function actionModify()
	{
		if($_POST['field'] == 'varstock'){
				if(!check_authz('clear_varstock')){
					echo "{success:false,msg:'您没有此操作的权限，请联系系统管理员!'}";exit;
				}
			}
		$object = new ModelGoods();
			try {
					$object->modify($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	function actionSavechild(){//保存子产品
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $good){
			$good->child_sn = addslashes_deep($good->child_sn);
			if($good->child_sn == "") {
			echo "{success:false,msg:'子产品编码不能为空'}";exit;
			}
		}
		$_POST['data'] = $goodsarr;
		$object = new ModelGoods();
		try {
				$object->savechild($_POST);
				echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	function actionSavecom(){//保存组合产品
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$goodsarr = $json->decode(stripslashes($_POST['data']));
		foreach($goodsarr as $good){
			$good->goods_name = addslashes_deep($good->goods_name);
			if($good->goods_name == "" || $good->goods_sn == "") {
			echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
			}
		}
		$_POST['data'] = $goodsarr;
		$object = new ModelGoods();
		try {
				$object->savecom($_POST);
				echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/*****************
	****获取单个产品信息
	*****************/
	function actionGetgoods()
	{
		$object = new ModelGoods();
		echo $object->getNameBySKU($_POST['sku']);
	}
	/*****************
	****获取产品日志信息
	*****************/
	function actionGetlog()
	{
		$object = new ModelGoods();
		$info['id'] = $_REQUEST['goods_id'];
		$info['field'] = 0;
		$where = $object->getlogwhere($info);
		$result = $object->getlog(0,100,$where);
		$str ='<div style="font-size:13px;">';
		for($i=0;$i<count($result);$i++){
			$str .= '<font color="#FF0000">'.$result[$i]['admin_id'].'</font>于<font color="#3366FF">'.$result[$i]['addtime'].'</font>进行了'.$result[$i]['action'].',<font color="#FF0000">'.$result[$i]['field'].'</font>'.$result[$i]['content']."<br>";
		}
		echo $str."</div>";
	}
	function actionGoodslog()
	{
		parent::actionPrivilege('list_goods_log');
		$this->tpl->assign('goods_field',ModelDd::getComboData('goods_field'));
		$this->name='goodslog';
		$this->show();		
	}
	function actiongetgoodslog()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$info['id'] = $obejct->getidBySKU($_REQUEST['keyword']);
		$info['field'] = $_REQUEST['field'];
		$where = $obejct->getlogwhere($info);
		$list = $obejct->getlog($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $obejct->getgoodslogCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/*****************
	****删除账号加载的listing记录
	*****************/
	function actiondellisting()
	{
		$object = new ModelGoods();
			try {
					$object->dellisting($_POST['id']);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/*****************
	***获取生成分类code
	*****************/
	function actionGetcatcode()
	{
		$object = new ModelGoods();
			try {
					$code = (CFG_AUTOCREAT_SN)?$object->getcatcode($_POST['cat_id']):'';
					echo "{success:true,msg:'$code'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	function actionGetgoodscode()
	{
		$object = new ModelGoods();
			try {
					$code = (CFG_AUTOCREAT_SN)?$object->generate_goods_sn($_POST['cat_id']):'';
					echo "{success:true,msg:'$code'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/*****************
	****获取产品图库
	
	*****************/
	function actiongetgoodsgallery()
	{
		$object = new ModelGoods();
		$list = $object->getgalleryList($_REQUEST['goods_id']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/*****************
	****上传产品图片至图库
	
	*****************/
	function actionUploadgoodsimg()
	{
		$object = new ModelGoods();
		require(CFG_PATH_LIB.'util/UploadFile.class.php');
		$upload = new UploadFile();
		try{
			if($_FILES['file_path']['name']){
				$_POST['url'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['file_path'],CFG_PATH_UPLOAD,0);
			}elseif(!$_POST['url']){
				echo "{success:false,msg:'无上传文件和图片链接'}";exit;
			}
			$object->Uploadgoodsimg($_POST);
			echo "{success:true,msg:'图片上传成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	echo "{success:true,msg:'未知错误'}";exit;
	}
	
	function actionUpdategallery()
	{
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelGoods();
		$msg = '';
		if($currentSheet->getCell("A1")->getValue() != 'goods_sn') {echo "{success:false,msg:'文件格式错误'}";exit;}
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$goods_info['goods_id']=$object->getidBySKU(trim($currentSheet->getCell('A'.$currentRow)->getValue()));
			if(!$goods_info['goods_id']) {
				$msg .= $currentSheet->getCell('A'.$currentRow)->getValue()."找不到对应的SKU产品<br>";continue;
				}
			$goods_info['url'] = trim($currentSheet->getCell('B'.$currentRow)->getValue());
			try {
				$object->Uploadgoodsimg($goods_info);
			} catch (Exception $e) {
					$err =1;
					$msg .= $currentSheet->getCell("A".$currentRow)->getValue().'产品库存保存失败<br>';
			}
		}
		if($err == 1) {echo "{success:false,msg:'$msg'}";exit;}
		savelog($_SESSION['admin_id'],'goods','批量更新产品图片',$_SESSION['admin_id']);
		echo "{success:true,msg:'产品更新成功'}";exit;
	}
	
	
	function actionUpgallery()
	{
		try{
			$object = new ModelSystem();
			$object->matchRemoteimg($_POST);
			savelog($_SESSION['admin_id'],'goods','批量更新产品外链图库',$_SESSION['admin_id']);
			echo "{success:true,msg:'更新产品外链图库成功'}";exit;
			}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	
	/*****************
	****外部SKU管理
	
	*****************/
	function actionSKU(){
		parent::actionPrivilege('list_sku');
		$this->name='sku';
		$this->show();		
	}
	
	function actionSKUupdate(){
		$object = new ModelGoods();
		try{
			$object->savesku($_POST);
			echo "{success:true,msg:'SKU保存成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	function actionimportsku()
	{
		set_time_limit(0);
		parent::actionPrivilege('stockout_import');
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelGoods();
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
			$info['sku'] = trim($currentSheet->getCell('A'.$currentRow)->getValue());
			$info['out_sku'] = trim($currentSheet->getCell('B'.$currentRow)->getValue());
			try {
				$object->savesku(addslashes_deep($info));
			} catch (Exception $e) {
					$err =1;
					$msg .= $currentSheet->getCell("A".$currentRow)->getValue().'产品数据保存失败<br>';
			}
		}
		if($err == 1) {echo "{success:false,msg:'$msg'}";exit;}
		 echo "{success:true,msg:'外部SKU导入成功'}";exit;
	}
	function actionSKUlist()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$where = $obejct->getSKUWhere($_REQUEST);
		$list = $obejct->getSKUList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $obejct->getSKUCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionSKUdel()
	{
		$object = new ModelGoods();
		try{
			$object->skudel($_REQUEST['ids'],$_REQUEST['type']);
			echo "{success:true,msg:'SKU删除成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	/*************
	** @获取产品库存情况
	*************/
	function actiongetstock()
	{
		$str = "<div style='margin-left:10px;width:500px;'><B>仓库:</B><table border=1 style='font-size:12px;'><tr><td>仓库</td><td width=100px>库存</td><td width=100px>锁定库存</td></tr>";
		$dopotlist = ModelDd::getArray('depot');
		$object = new ModelGoods();
		foreach($dopotlist as $k=>$v){
			$goods_qty = $object->getgoodsqty($_POST['goods_id'],$k);
			$str .= '<tr><td>'.$v.'</td><td align=center>'.$goods_qty['goods_qty'].'</td><td align=center>'.$goods_qty['varstock'].'</td></tr>';
			}
		$str .= "</table><hr><B>货架明细:</B><br/><table border=1 style='font-size:12px;'><tr><td>货架</td><td width=100px>库存</td><td width=100px>锁定库存</td><td width=100px>货架位置</td></tr>";
		$shelflist = ModelDd::getArray('shelf');
		foreach($shelflist as $k=>$v){
			$goods_qty = $object->getgoodsqty($_POST['goods_id'],'',$k);
			$str .= '<tr><td>'.$v.'</td><td align=center>'.$goods_qty['goods_qty'].'</td><td align=center>'.$goods_qty['varstock'].'</td><td align=center>'.$goods_qty['stock_place'].'</td></tr>';
			}
		echo $str."</table></div>";
	}
	/********************
	**修改产品库存相关
	*
	********************/
	function actionmodifystock()
	{
		parent::actionPrivilege('edit_stock');
		$object= new ModelGoods();
		$shelflist = ModelDd::getArray('shelf');
		foreach($shelflist as $k => $v){
			$shelf['shelf_id'] = $k;
			$shelf['name'] = $v;
			$shelf['goods_id'] = $_GET['goods_id'];
			$goods_qty = $object->getgoodsqty($_GET['goods_id'],'',$k);
			$shelf['value'] = $goods_qty['goods_qty'];
			$shelf['warn_qty'] = $goods_qty['warn_qty'];
			$shelf['stock_place'] = $goods_qty['stock_place'];
			$shelf['is_main']=$object->checkshelf($k);
			$shelf_list[]=$shelf;
			}
		$this->tpl->assign('shelflist',$shelf_list);
		$this->name = 'modifystock';
		$this->show();
		
	}
	
	function actionchangeshelfstock()
	{
		try{
			$object = new ModelGoods();
			$object->changeshelfstock($_POST);
			echo "{success:true,msg:'库存更新成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	function actionclearvar()
	{
		try{
			$object = new ModelGoods();
			$object->clearvar($_POST);
			echo "{success:true,msg:'清空锁定库存成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	/*************
	** @删除产品图片
	*************/
	function actionDelgallery()
	{
		try{
			$object = new ModelGoods();
			$object->delgallery($_POST['id']);
			echo "{success:true,msg:'图片删除成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	/***********
	** @Ebay listing辅助功能
	
	**********/
	function actionlistingsupport()
	{
		//parent::actionPrivilege('listing_support');
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->name = 'listingsupport';
		$this->show();
	}
	
	function actionlistingsupportList()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$where = $obejct->getsupportWhere($_REQUEST);
		$list = $obejct->getsupportList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $obejct->getsupportCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	function actionupdateListing()
	{
		$object = new ModelGoods();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$datas=$json->decode(stripslashes($_POST['data']));
		try {
			//保存更新数据
			foreach($datas as $good){
				$object->updateListing($good);
			}
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:".$msg."'保存成功'}";exit;
	}
	function actioneditListing()
	{
		$object = new ModelGoods();
		try {
				$object->editListing($_GET['accountid']);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:".$msg."'保存成功'}";exit;
	}
	function actionupdateitem()
	{
		parent::actionPrivilege('updateitem');
		$object = new ModelGoods();
		try {
				$msg = $object->updateitem($_GET['id']);
				echo "{success:true,msg:'".$msg."保存成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		
	}
	
	/***********
	** 产品分级
	**********/
	function actionGrade()
	{
		parent::actionPrivilege('list_grade');
		$array = require(CFG_PATH_DATA.'dd/goods.conf.php');
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$info = $json->encode($array);
		$this->tpl->assign('info',$info);
		$this->name = 'grade';
		$this->show();
	}
	
	function actionsavegrade()
	{
		try{
			$object = new ModelGoods();
			$object->savegrade($_POST);
			echo "{success:true,msg:'产品分级完成'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	/*******
	*序列号管理
	*******/
	
	function actioncontrolSN()
	{
		parent::actionPrivilege('list_sn');
		$this->name = 'sn';
		$this->show();
	}
	function actionSnupdate(){
		$object = new ModelGoods();
		try{
			$object->savegoodsSN($_POST);
			echo "{success:true,msg:'SKU保存成功'}";exit;
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
	}
	
	function actionSnlist()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$where = $obejct->getSnWhere($_REQUEST);
		$list = $obejct->getSnList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $obejct->getSnCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionSndel()
	{
		$object = new ModelGoods();
		try{
			$object->skudel($_REQUEST['ids']);
			echo "{success:true,msg:'SKU保存成功'}";exit;
			}catch (Exception $e){
					$msg = $e->getMessage();
					echo "{success:false,msg:'$msg'}";exit;
			}
	}
	function actionsavexml()
	{
		$object = new ModelGoods();
		try {
			$object->savexml($_REQUEST['accountid']);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		echo "{success:true,msg:'保存生成！'}";exit;
	}
	/*******
	*获取分类的操作人员
	*******/
	function actiongetCatActionUser(){
		$object = new ModelGoods();
		try{
				$result= $object->getUser($_REQUEST['cat_id']);
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				echo "{success:true,msg:".$json->encode($result)."}";exit;
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
	}
	function actionsaveCatAttr(){
		$object = new ModelGoods();
		try{
				$object->saveCatAttr($_REQUEST);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		echo "{success:true,msg:'保存成功'}";exit;
	}
	/*************
	** @等待上传产品
	*************/
	function actionwaitupload(){
		$this->name = 'waitupload';
		$this->show();
	}  
	/*************
	** @ebay定时刊登队列
	*************/
	function actiongoodshour(){
		$this->name = 'goodshour';
		$this->show();
	}
	/*************
	** @ebay结束产品
	*************/
	function actionendlisting(){
		$this->name = 'ebay_endlisting';
		$this->show();
	}
	function actiongetwaitaccount(){
		echo '﻿﻿[{"id":"28","text":"EBay待上传","leaf":true,"cls":"file"},{"id":"0","text":"Aliexpress待上传","leaf":true,"cls":"file"}]';
	}
	/*************
	** @验证ebay上传  类型chinese
	*************/
	function actionVerifyAddItem(){
		$object = new ModelEbayGoods();
			try {
				$msg = $object->VerifyAddItem($_REQUEST['id']);
				
			} catch (Exception $e) {
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		echo "{success:true,msg:'".$msg."'}";exit;
	}
	/*************
	** @获取ebay活动的产品
	*************/
	function actionGetActivelisting()
	{
		$pageLimit = getPageLimit();
		$obejct = new ModelGoods();
		$where = $obejct->getActiveListingWhere($_REQUEST);
		$list = $obejct->getActiveListingList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $obejct->getActiveListingCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
		
	}
	/**
	 * 新增eBay产品
	 */
	function actionAddeBayGoods() {
		$object = new ModelUser(); 
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('DispatchTimeMax',ModelDd::getComboData('DispatchTimeMax'));
		$this->tpl->assign('ListingDuration',ModelDd::getComboData('ListingDuration'));
		$this->tpl->assign('ListingType',ModelDd::getComboData('ListingType'));
		$this->tpl->assign('condition',ModelDd::getComboData('condition'));
		$this->name = 'goods_ebay';
		$this->show();
	}
	/**
	 * 保存goods
	 *
	 */
	 function actionsaveebay(){
		$object = new ModelGoods();
		
		require(CFG_PATH_LIB.'util/UploadFile.class.php');
		
		
		if($_FILES['ViewItemURL']['name']){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['ViewItemURL'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['ViewItemURL'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['ViewItemURL'] = 'data/upload/no_picture.gif';
		}
		if($_FILES['PictureURL01']['name']){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['PictureURL01'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['PictureURL01'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['PictureURL01'] = '';
		}
		if($_FILES['PictureURL02']['name']){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['PictureURL02'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['PictureURL02'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['PictureURL02'] = '';
		}
		if($_FILES['PictureURL03']['name']){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['PictureURL03'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['PictureURL03'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['PictureURL03'] = '';
		}
		if($_FILES['PictureURL04']['name']){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['PictureURL04'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['PictureURL04'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			$_POST['PictureURL04'] = '';
		}
		$goods_id = $object->saveebay($_POST);
		echo "{success:true,msg:'$goods_id'}";exit;
		//
	 }
	 /****
	*编辑产品
	****/
	function actionEditBayGoods(){
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('DispatchTimeMax',ModelDd::getComboData('DispatchTimeMax'));
		$this->tpl->assign('ListingDuration',ModelDd::getComboData('ListingDuration'));
		$this->tpl->assign('ListingType',ModelDd::getComboData('ListingType'));
		$this->tpl->assign('condition',ModelDd::getComboData('condition'));
		
		$object = new ModelGoods();
		$user = new ModelUser();
		$rs = $object->ebay_goods_info($_GET['id']);
		$this->tpl->assign('role_id',$user->getRoleId($_SESSION['admin_id']));
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$good = $json->encode($rs);
		$this->tpl->assign('good',$good); 
		$this->name = 'editebay_goods';
		$this->show();
	}
	 /**
	 * 新增ALI产品
	 */
	function actionAddALIGoods() {
		$object = new ModelUser(); 
		$this->tpl->assign('account',ModelDd::getComboData('aliaccount'));
		$this->tpl->assign('aligoodsunit',ModelDd::getComboData('aligoodsunit'));
		$this->name = 'goods_aliexpress';
		$this->show();
	}
	 /****
	*编辑ALI产品
	****/
	function actionEditALIGoods(){
		
		$this->tpl->assign('account',ModelDd::getComboData('aliaccount'));
		$this->tpl->assign('aligoodsunit',ModelDd::getComboData('aligoodsunit'));
		
		$object = new ModelAliexpress();
		$user = new ModelUser();
		$rs = $object->getAligoodsinfo($_GET['id']);
		require(CFG_PATH_LIB.'util/JSON.php');
		
		$json = new Services_JSON();
		$good = $json->encode($rs);
		$this->tpl->assign('good',$good); 
		//var_dump($good);exit();
		$this->name = 'editaliexpress_goods';
		$this->show();
	}
	/*************
	** @Ali等待上传产品
	*************/
	function actionAliwaitupload(){
		$account = ModelDd::getArray('aliaccount');
		$ex_list = explode(",",$_SESSION['account_list']);
		$newaccount = array();
		foreach($ex_list as $accountkey => $accountid){
			foreach($account as $keyid => $value){
				if($accountid == $keyid) {
					$newaccount[$accountid] =  $account[$keyid];
				}
			}
		}
		$this->tpl->assign('account',ModelDd::arrayFormat($newaccount));
		$this->name = 'waitupload_aliexpress';
		$this->show();
	}  
	/*************
	** @Ali定时刊登队列
	*************/
	function actionAligoodshour(){
		$this->name = 'goodshour_ali';
		$this->show();
	}
	/*************
	** @Ali结束产品
	*************/
	function actionAliendlisting(){
		$account = ModelDd::getArray('aliaccount');
		$ex_list = explode(",",$_SESSION['account_list']);
		$newaccount = array();
		foreach($ex_list as $accountkey => $accountid){
			foreach($account as $keyid => $value){
				if($accountid == $keyid) {
					$newaccount[$accountid] =  $account[$keyid];
				}
			}
		}
		$this->tpl->assign('account',ModelDd::arrayFormat($newaccount));
		$this->name = 'aliexpress_endlisting';
		$this->show();
	}
	/**
	 * 保存Aliexpress goods
	 *
	 */
	 function actionsavealigoods(){
		//echo "{success:true,msg:'".var_dump($_FILES['photo_path'])."'}";exit;
		$object = new ModelGoods();
		 if($_FILES['photo_path']['name'] <> ''){//上传图片
			$upload = new UploadFile();
			try{
				$_POST['goods_img'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).$upload->upload($_FILES['photo_path'],CFG_PATH_UPLOAD,1);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}
		$goods_id = $object->saveAligoods($_POST);
		echo "{success:true,msg:'$goods_id'}";exit;
		//
	 }
	function actiondeletealigoods(){
		$object = new ModelGoods();
		try{
			$object->deletealigood($_REQUEST['ids']);
			echo "{success:true,msg:'OK'}";exit;
		}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
		} 
	}
	function actiongetdes(){
		$object = new ModelGoods();
		try{
			$msg = $object->getgoodsDes($_REQUEST['goods_id']);
			echo $msg;
		}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
		}
	}
    function actiongetaligoodsupload(){
        $object = new ModelGoods();
        try{
            $msg = $object->getAligoodUpload($_REQUEST['goods_id']);
            echo $msg;
        }catch (Exception $e){
                $msg = $e->getMessage();
                echo "{success:false,msg:'$msg'}";exit;
        }
    }
	function actiongetebayonline(){
		$object = new ModelGoods(); 
        $_REQUEST['id'] = 79;
		try{
			$msg = $object->GetEbayOnlineGoods($_REQUEST);
			var_dump( $msg);
		}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
		}
	}
}
?>