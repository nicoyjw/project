<?php  
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015 (http://www.cpowersoft.com)        |
// |                                                              |
// | 要查看完整的版权信息和许可信息                               |
// | 或者访问 http://www.cpowersoft.com 获得详细信息              |
// +--------------------------------------------------------------+

/**
 * 速卖通商品
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Aliexpress extends Controller{
	/**
	 * 初始化页面信息
	 */
	function __construct(){
		parent::__construct();
		$this->dir = 'aliexpress';
	}
	/**-
	 * 速卖通产品管理页面
	 */
	function actionGoods(){
		parent::actionPrivilege('ali_goods');
		$this->tpl->assign('account',ModelDd::getComboData('aliaccount'));
		$this->dir = 'goods';
		$this->name='aligoods';
		$this->show();
	}
    /**-
     * 速卖通产品列表
     * update 2014-08-03
     */
	function actionlistingList(){
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
		$sortob = $json->decode($_REQUEST['sort']);
        
        
		$_REQUEST['property'] = $sortob[0]->property;
		$_REQUEST['direction'] = $sortob[0]->direction;
        
        
		$pageLimit = getPageLimit();
        /* 所有帐号   单个帐号    状态   所有状态 */ 
        
        $list = array();      
        
		$goods = new ModelAliexpress();
		//$where = $goods->getWhere($_REQUEST);
        
        
        
        $accounts = ModelDd::getArray('aliaccount');
        
        if(!isset($_REQUEST['account']) || $_REQUEST['account'] == 0){
            foreach($accounts as $accountId => $accountName){
                if(!isset($_REQUEST['status']))$status = 'onSelling';
                else $status = $_REQUEST['status'];
                if(!isset($_REQUEST['goods_sn']))$keyword = null;
                else $keyword = $_REQUEST['goods_sn'];
                $result = $goods->getGoodList($_REQUEST['page'],$_REQUEST['limit'],$keyword,$accountId,$status);
                break;        
            }       
        }else{
            if(!isset($_REQUEST['status']))$status = 'onSelling';
            else $status = $_REQUEST['status'];
            if(!isset($_REQUEST['goods_sn']))$keyword = null;
            else $keyword = $_REQUEST['goods_sn'];
            $result = $goods->getGoodList($_REQUEST['page'],$_REQUEST['limit'],$keyword,$_REQUEST['account'],$status);
        }
		$result['totalCount'] = $result['total'];
		$result['topics'] = $result['list'];
		echo $json->encode($result);
	}
	/**
	 * 获取速卖通分类tree
	 *
	 */
	function actiongetcattree()
	{
		$object = new ModelAliexpress();
		if($_REQUEST['node'] == 'root'){
			$trees = $object->catTree($_GET['com']);
			$result = $trees[$_REQUEST['node']];
		}else{
			$result = $object->getchildtree($_REQUEST['node']);
		}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);			
	}
	
	/**
	 * 一键刊登
	 *
	 * @param string $cat_id  Aliexpress category ID
	 * @param int $goods_id   Product ID
	 * @param int $id  user ID  
	 * @return string 
	 */
	function actiongoodupload(){
		$object = new ModelAliexpress();
		try {
            $msg = '';
            $ids = explode(',',$_REQUEST['ids']);
            foreach($ids as $id){
                $msg .= $object->postAeProduct($id);        
                $msg .= '<br>';        
            }
            echo $msg;exit();
			//echo '<pre>';
			//var_dump($msg);
			//echo '</pre>';exit();
		} catch (Exception $e) {
			$msg = $e->getMessage();
			echo $msg;exit;
		}
		//echo "{success:true,msg:'".$msg."'}";exit;
	}
	
	
	/**
	 * 速卖通账号授权
	 */
	function actionAuth(){
		$object = new ModelAliexpress();
		$url = $object -> geturl($_POST);
		echo "{success:true,msg:'".$url."'}";exit;
	}
	/**
	 * 完成授权
	 */
	function actionOverAuth(){                                    
		$object = new ModelAliexpress();
		try{
            if($_POST['account'])$_POST['alicode'] = $_POST['code'];                             
			$re = $object -> overAuth($_POST);
            
            if($_POST['account']){
                echo '完成授权 。请关闭页面，重新操作'.$re;exit();     
            }else{
                echo "{success:true,msg:'授权成功!'}";exit;
            }
		}catch (Exception $e) {
			$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'".$errorMsg."'}";exit;
	}
    /**
     * 加载速卖通订单
     */
    function actionLoadAliOrder() {
        $object = new ModelAliexpress();
        try {                                                     
            $msg = $object->loadaliorder($_GET);  
            if(isset($msg['reauth']) && !empty($msg['reauth']) && $msg['reauth'] == 'reauth'){
                $html = '<div style="text-align:center;font-size:14px;color:red">token已失效，请重新授权！点击下面链接，登录速卖通帐号，授权成功请将code复制并粘贴到以下接收框中,点击提交！<br/><br/><br/><form action="index.php?model=aliexpress&action=OverAuth" method="POST" ><input type="hidden" id="account" name="account" value="'.$_GET['id'].'" />code:<input type="text" id="code" name="code"/><input type="submit" value="提交"/> </form></div><br/><br/><br/>
                <iframe height="500px" width="100%" src="'.$msg['url'].'" id="myframe" id="myframe" frameborder="0" target="_self"></iframe>';
                echo $html;exit();        
            }  
            echo $msg;exit();
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
	/**
	 * 一键加载速卖通订单
	 */
	function actionFastLoadAliOrder() {
		$object = new ModelAliexpress();
		try {
            /* 默认30天 */
            $starttime = date('m/d/Y',time()-(360*24*30));/* 7天之前 */     
            $endtime = date('m/d/Y',time());
            $aliexpress_account = ModelDd::getArray('aliaccount');
            foreach($aliexpress_account as $id => $K){
                $_GET['id'] = $id;
                $msg = $object->loadaliorder($_GET,$starttime,$endtime,$K);
                if(isset($msg['reauth']) && !empty($msg['reauth']) && $msg['reauth'] == 'reauth'){
                    $html = '<div style="text-align:center;font-size:14px;color:red">token已失效，请重新授权！点击下面链接，登录速卖通帐号，授权成功请将code复制并粘贴到以下接收框中,点击提交！<br/><br/><br/><form action="index.php?model=aliexpress&action=OverAuth" method="POST" ><input type="hidden" id="account" name="account" value="'.$_GET['id'].'" />code:<input type="text" id="code" name="code"/><input type="submit" value="提交"/> </form></div><br/><br/><br/>
                    <iframe height="500px" width="100%" src="'.$msg['url'].'" id="myframe" id="myframe" frameborder="0" target="_self"></iframe>';
                    echo $html;
                }         
            }
            echo '<span style="font-size:13px;line-height:25px;width:25%;float:left;"><font color="blue">全部帐号同步完成<span>';exit();
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	/**
	 * 加载速卖通产品
	 */
	function actionload() {
        //echo '速卖通同步产品升级中，将暂停使用，具体开放时间另行通知。升级内容，系统间隔时段自动更新。';exit;
		parent::actionPrivilege('load_aligood');
		$this->tpl->assign('account',ModelDd::getComboData('aliaccount'));
		$this->name = 'loadaligoods';
		$this->show();
	}	
	/**
	 * 同步速卖通产品
	 */
	function actionLoadGoods(){
        //echo "{success:false,msg:'速卖通同步产品升级中，将暂停使用，具体开放时间另行通知。升级内容，系统间隔时段自动更新'}";exit;
		$object = new ModelAliexpress();
		try {
			$msg = $object->loadGoods($_GET);
			echo "{success:true,msg:'".$msg."'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}";
	}
	/**
	 * 更新产品信息
	 */
	function actionupdateListing(){
		//echo "{success:true,msg:".stripslashes($_POST['data'])."'保存成功'}";exit;
		$object = new ModelAliexpress();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$datas=$json->decode(stripslashes($_POST['data']));
		$msg = '';
		try {
			//保存更新数据
			foreach($datas as $good){
				$msg .= $object->updateListing($good,$_GET['accountid'],'save').'<br/>';
			}
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo '{success:true,msg:"'.$msg.'"}';exit;
	}
	/**
	 * 导出产品
	 */
	function actionexportaliexpressgoods(){
		set_time_limit(0);
		parent::actionPrivilege('export_goods');
         
		$object = new ModelAliexpress();
		$where = $object->getAliWhere($_REQUEST);
		$list = $object->getExportGoods(1,1500,$where);    
        
        
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
        $header = "商品id,商品货号";
        $contentfield = array();
        
        if($_REQUEST['fields']){
            require(CFG_PATH_LIB.'util/JSON.php');
            $json = new Services_JSON();
            $fieldarr = $json->decode(stripslashes($_REQUEST['fields'])); 
            foreach($fieldarr as $field){
                $field->name = addslashes_deep($field->name); 
                $header .= ",".$field->name;
                $contentfield[] = $field->field;
            } 
        }
        $header .= ",销售方式(大于1为打包销售数量)";
		//$header = '商家编码,产品价格,id,产品状态,所属账号,最小批发量,批发折扣,销售方式(大于1为打包销售数量),SKU产品数量';
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
		for($i=0;$i<count($list);$i++){
			$cf ='A';
            $order_value[] =  $list[$i]['id'];
            $order_value[] =  $list[$i]['skuCode'];    
            for( $h=0;$h<count($contentfield);$h++){
                if($contentfield[$h] == "productPrice"){$order_value[] =  $list[$i]['productPrice'];}
                if($contentfield[$h] == "bulkOrder"){$order_value[] =  $list[$i]['bulkOrder'];}
                if($contentfield[$h] == "deliveryTime"){$order_value[] =  $list[$i]['deliveryTime'];}
                if($contentfield[$h] == "bulkDiscount"){$order_value[] =  $list[$i]['bulkDiscount'];}
                if($contentfield[$h] == "grossWeight"){$order_value[] =  $list[$i]['grossWeight'];} 
                if($contentfield[$h] == "freightTemplateId"){$order_value[] =  $list[$i]['freightTemplateId'];}
                if($contentfield[$h] == "packageLength"){$order_value[] =  $list[$i]['packageLength'];}
                if($contentfield[$h] == "packageWidth"){$order_value[] =  $list[$i]['packageWidth'];}
                if($contentfield[$h] == "packageHeight"){$order_value[] =  $list[$i]['packageHeight'];}
                if($contentfield[$h] == "wsValidNum"){$order_value[] =  $list[$i]['wsValidNum'];}
                if($contentfield[$h] == "subject"){$order_value[] =  $list[$i]['goods_name'];}
                if($contentfield[$h] == "detail"){$order_value[] =  $list[$i]['detail'];} 
            }
            $order_value[] =  $list[$i]['lotNum'];
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
		$file = CFG_PATH_DATA.'ordertmp/aligoodsexport'.$_SESSION['admin_id'].'.xlsx';
		if(file_exists($file)) unlink($file);
		$objWriter->save($file);//define xls name
		$file = str_replace(CFG_PATH_ROOT, '', $file);
		echo date('H:i:s') . " Done writing files.<br>";
		page::todo($file);
		die();
	}
	/**
	 * 文件批量更新速卖通产品
	 */
	function actionfileupdategoods(){
		set_time_limit(0);
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load(mysql_real_escape_string($_FILES['file_path']['tmp_name']));
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allRow = $currentSheet->getHighestRow();
		$field_list = array();
		$object = new ModelAliexpress();
		if($currentSheet->getCell("A1")->getValue() != 'id') {echo "{success:false,msg:'文件格式错误'}";exit;}
		for($i='A';$i<=$allColumn;$i++){
			$line_list[$i] = $currentSheet->getCell($i."1")->getValue();
		}
        
        
        //echo "{success:true,msg:'".$currentSheet->getCell("A2")->getValue()."'}";exit;    
        
        try{
            
            
            
            
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        
		for($currentRow = 2;$currentRow<=$allRow;$currentRow++){
			$array = new StdClass;
			$array->id = $currentSheet->getCell("A".$currentRow)->getValue();
			$array->productPrice = $currentSheet->getCell("B".$currentRow)->getValue();
			$array->lotNum = $currentSheet->getCell("C".$currentRow)->getValue();
			$array->bulkOrder = $currentSheet->getCell("D".$currentRow)->getValue();
			$array->bulkDiscount = $currentSheet->getCell("E".$currentRow)->getValue();
			$array->SKU = $currentSheet->getCell("F".$currentRow)->getValue();
			$array->revisePrice = $currentSheet->getCell("G".$currentRow)->getValue();
			//获取产品信息
			$aliID = $object->getIdById($array->id);
			//$childList = $object->getChild($aliID);
			/**if(count($childList) > 1){
				//更新到子产品数据库
				foreach($childList as $value){
					$price = $value['skuPrice']+$array->revisePrice;
					$object->updateChildPrice($price,$value['id']);
				}
				$msg .= $object->updateListing($array,$_GET['id'],'import');
			}elseif(count($childList)==1){
				$msg .= $object->updateListing($array,$_GET['id'],'import');
			}**/
            $msg .= $object->updateListing($array,$_GET['id'],'import');  
		}
		echo "{success:true,msg:'".$msg."'}";exit;	
	}
	
	
	/**
	 * 测试接口
	 */ 
	function actionapitest(){
		$object = new ModelAliexpress();
		set_time_limit(1500000);
		include(CFG_PATH_DATA . 'ebay/ali_104.php');
		
        $code_arr = array(
            'client_id' => $APIDevUserID,
            'redirect_uri' => 'http://localhost:12508/auth_callback_url',
            'site' => 'aliexpress'
        );
        ksort($code_arr);
        foreach ($code_arr as $key=>$val){
            $sign_str .= $key . $val;
        }
        $code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, $APIPassword, true)));//$code_sign = 签名
        
        $curlPost = array(
                            'grant_type' => 'refresh_token',
                            'client_id' => $APIDevUserID,
                            'client_secret' => $APIPassword,
                            'refresh_token' => $refresh_token,
                            '_aop_signature' => $code_sign
                            );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
        curl_setopt($ch, CURLOPT_URL,'https://gw.api.alibaba.com/openapi/param2/1/system.oauth2/refreshToken/'.$APIDevUserID);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        
        var_dump($result);exit;
        
        $time = time()+3600;
        $fp = fopen(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php', 'w');
        fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$result['access_token'].'\';'.chr(10).' $refresh_token =\''.$info['refresh_token'].'\';'.chr(10).' $APIDevUserID =\''.$info['appkey'].'\';'.chr(10). ' $APIPassword =\''.$info['appSecret'].'\';'.chr(10). ' $passtime = '.(CFG_TIME+36000).';'.chr(10).' $longpasstime = '.$info['longpasstime'].';'.chr(10). '?>');
        fclose($fp);
        return $result['access_token'];
        
        
        
        
		if($_GET['function'] == 'orderlist'){
			$result = $object -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID.'?page=1&pageSize=50&orderStatus='.$_GET['value'].'&access_token='.$access_token);
		}
		if($_GET['function'] == 'getorderinfo'){
			$result = $object->RequestAli("http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderById/".$APIDevUserID."?orderId=".$_GET['value']."&access_token=".$access_token);
		}
		if($_GET['function'] == 'messagebybuyid'){
			$result = $object->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageListByBuyerId/'.$APIDevUserID.'?buyerId='.$_GET['value'].'&access_token='.$access_token);
		}
		if($_GET['function'] == 'message'){
			$result = $object->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryOrderMsgListByOrderId/'.$APIDevUserID.'?orderId='.$_GET['value'].'&access_token='.$access_token);
		}
		if($_GET['function'] == 'cateattr'){
			$result = $object->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getAttributesResultByCateId/'.$APIDevUserID.'?cateId='.$_GET['value'].'&access_token='.$access_token);
		}
		if($_GET['function'] == 'getgoodinfo'){
			$result = $object->RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$_GET['value'].'&access_token='.$access_token);
		}
		if($_GET['function'] == 'getPrintInfo'){
			$result = $object->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getPrintInfo/'.$APIDevUserID.'?internationalLogisticsId='.$_GET['value'].'&access_token='.$access_token);
			/*$get_url = $_GET['value'].'zip';
			ob_end_clean();
			//header("Content-Type: application/force-download");
			header("Content-Transfer-Encoding: binary");
			header('Content-Type:application/x-zip-compressed');
			header('Content-Disposition":"attachment;filename='.$_GET['value']);
			header('Content-Length: '.filesize($get_url));
			error_reporting(0);
			readfile($get_url);
			flush();
			ob_flush();*/
		}
		//'http://www.cpowersoft.com/erp/index.php?model=aliexpress&action=apitest&function=getPrintInfo&value=RB889292335CN';
		//'2cdfd02d0da1ec71715a1cc073e8b2fa';
		echo '<pre>';
		var_dump($result);
		echo '</pre>';
	}
	/**
	 * 更新价格
	 */
	function actionupdateitemprice(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->updatePrice($_GET);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:'".$msg."'}";exit;	
	}
	/**
	 * 更新单个产品信息
	 */
	function actionreloadgood(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->reloadgood($_GET['id'],$_GET['account_id']);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:'".$msg."'}";exit;	
	}
	function actionclearGoods(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->clearGoodsAndChild($_GET['id']);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:'".$msg."'}";exit;	
	}
	/**
	 * 提交速邮宝订单
	 */
	function actionuporder(){
		$object = new ModelAliexpress();
		try {
			$msg = $object-> getexpressbyali($_REQUEST);
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		 echo "{success:true,msg:'".$msg."'}";exit;
	}
	/**
	 * 获取更新国内发货信息
	 */
	function actiongetsubexpress(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->getsubexpress();
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		echo "{success:true,msg:'".$msg."'}";exit;
	}
	
	function actionalimsg(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->getAliOrderMsg('60504317980888',237);
			echo '<pre>';
			var_dump($msg);echo '</pre>';exit();
		} catch (Exception $e) {
			echo "{success:false,msg:'".$e->getMessage()."'}";exit;
		}
		echo "{success:true,msg:'".$msg."'}";exit;
	}
	function actiongetAlimsg(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->getAliMsg($_REQUEST['order_id']);
		} catch (Exception $e) {
			echo $e->getMessage();exit;
		}
		echo $msg;exit;
	}
	function actionaddaligoods(){
		$this->dir = 'goods';
		$this->name='ali_upload';
		$this->show();
	}
	function actionimage_bank(){
		parent::actionPrivilege('ali_goods_imgbank');
		$this->tpl->assign('account',ModelDd::arrayFormat($newaccount));
		$this->dir = 'aliexpress';
		$this->name='image_bank';
		$this->show();
	}
	function actiongetAliCate(){
		$object = new ModelAliexpress();
		$trees = $object->getAliexpressCate($_REQUEST['node'],'379');
		$result = $trees[$_REQUEST['node']];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
    function actiongetAliStatus(){  
        $trees = array();
        $trees['root'][] = array('id'=>5,'text'=>'所有状态','leaf'=>true, 'cls'=>'file');
        $trees['root'][] = array('id'=>1,'text'=>'未刊登','leaf'=>true, 'cls'=>'file');
        $trees['root'][] = array('id'=>0,'text'=>'已发布销售中','leaf'=>true, 'cls'=>'file');
        $trees['root'][] = array('id'=>2,'text'=>'已结束下架','leaf'=>true, 'cls'=>'file');
        $trees['root'][] = array('id'=>3,'text'=>'审核中','leaf'=>true, 'cls'=>'file');
        $trees['root'][] = array('id'=>4,'text'=>'审核不通过','leaf'=>true, 'cls'=>'file');
        
        $result = $trees[$_REQUEST['node']];
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
	function actionshowAttribute(){
		$object = new ModelAliexpress();
		$result = $object->getAliexpressAttribute($_REQUEST['cateId'],'379');
		/*echo '<pre>';
		var_dump($result);exit();
		  echo '</pre>';*/
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actiongetinfoattributes(){
		$object = new ModelAliexpress();
		$result = $object->getinfoattributes($_REQUEST);
		/*echo '<pre>';
		var_dump($result);
		echo '</pre>';exit();*/
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actiondownshelf(){
        if(parent::actionCheck('ali_good_downsale'))
        {
             $object = new ModelAliexpress();
             try {
                $msg = $object->downShelfGood($_REQUEST['id']);
                echo $msg;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
            $this->name = 'loading';
            $this->dir = 'system';
            $this->show();
        }
		
		
	}
	function actiononlineshelf(){
        if(parent::actionCheck('ali_good_downsale'))
        {
            $object = new ModelAliexpress();
            try {
                $msg = $object->OnlineShelfGood($_REQUEST['id']);
                echo $msg;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
            $this->name = 'loading';
            $this->dir = 'system';
            $this->show();
        }                                         
		
	}
	function actionget_image_group(){
		$object = new ModelAliexpress();
		$trees = $object->get_image_group($_REQUEST['account_id'],$_REQUEST['node']);
		$result = $trees[$_REQUEST['node']];
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actionimagejson(){
		$object = new ModelAliexpress();
		$result = $object->getimagesLib($_REQUEST['account_id'],$_REQUEST['group']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result); 
	}
	/**
	 * 上传图片到临时图库
	 */
	function actionUploadImageTem(){
		 if($_FILES['photo_path']['name'] <> ''){//上传图片
			$upload = new UploadFile();
			try{
				$filePath = CFG_PATH_UPLOAD.$upload->upload($_FILES['photo_path'],CFG_PATH_UPLOAD,1);
				chmod($filePath, 0777); 
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			echo "{success:false,msg:'请选取一张本地图片上传'}";exit;
		}
		try{
			$fh = fopen($filePath, "rb");
			$data = fread($fh, filesize($filePath));
			fclose($fh);
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
		include(CFG_PATH_DATA . 'ebay/ali_'.$_POST['id'].'.php');
		$filename = pathinfo ( $filePath ,PATHINFO_BASENAME);
		
		
		$upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadTempImage/'.$APIDevUserID.'?access_token='.$access_token.'&srcFileName='.$filename; 
		require(CFG_PATH_LIB.'util/uploadTempImage.php');
		$result = request_post($upload_image_server,$data);
		
		echo "{success:true,msg:'".$result['url']."'}";exit;
		exit();
		$object = new ModelAliexpress();
		$result = $object->uploadimg($_REQUEST['id'],'');
	}
	
	/**
	 * 上传图片到图片银行
	 */
	function actionUploadImageBank(){
		 if($_FILES['photo_path']['name'] <> ''){//上传图片
			$upload = new UploadFile();
			try{
				$filePath = CFG_PATH_UPLOAD.$upload->upload($_FILES['photo_path'],CFG_PATH_UPLOAD,1);
				chmod($filePath, 0777); 
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
		}else{
			echo "{success:false,msg:'请选取一张本地图片上传'}";exit;
		}
		try{
			$fh = fopen($filePath, "rb");
			$data = fread($fh, filesize($filePath));
			fclose($fh);
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
		include(CFG_PATH_DATA . 'ebay/ali_'.$_POST['id'].'.php');
		$filename = pathinfo ( $filePath ,PATHINFO_BASENAME);
		
		
		$upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$APIDevUserID.'?access_token='.$access_token.'&fileName='.$filename; 
		require(CFG_PATH_LIB.'util/uploadTempImage.php');
		$result = request_post($upload_image_server,$data);
		
		echo "{success:true,msg:'".$result['photobankUrl']."'}";exit;
		exit();
		$object = new ModelAliexpress();
		$result = $object->uploadimg($_REQUEST['id'],'');
	}
	/**
	 * 批量加入产品库
	 */
	function actionexportgoods(){         
		$object = new ModelAliexpress();   
		try{
			//$where = $object->getAliWhere($_REQUEST);
			$msg = $object->addgoodlib($_REQUEST['id']);
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
		echo "{success:true,msg:'".$msg."'}";exit;
	}
	function actionjoinuploadgood(){
		$object = new ModelAliexpress();
		try{
			$object->joinuploadgood($_POST);
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
		echo "{success:true,msg:'OK'}";exit;
	}
	function actionblukJoinUploadGood(){
		$object = new ModelAliexpress();
        $msg = '';
		try{
			$ids = explode(',',$_REQUEST['ids']);
			foreach($ids as $k => $id){
                $product_account = explode('-',$id);
                $product = $product_account[0];
                $account = $product_account[1];
                $msg .= $object->joinuploadgood(array('ali_goods_id'=>$product,'account_id'=>$account));
				$msg .= '<br/>';
			}
			
		}catch (Exception $e){
			$msg = $e->getMessage();
			echo "{success:false,msg:'$msg'}";exit;
		}
		echo "{success:true,msg:'".$msg."'}";exit;
	}
	function actionEdit_Ali_Attributes(){
		$object = new ModelAliexpress();
		$result = $object->getinfoattributes($_REQUEST['id']);
		echo $result;exit();
	}
	function actiongetAccount(){
		$account = ModelDd::getArray('aliaccount');
		
		$newaccount = $account;
		$tree = array();
        $tree[] = array('id'=>0,'text'=>'所有账号','leaf'=>true, 'cls'=>'file');
		foreach($newaccount as $k => $v){
			$tree[] = array('id'=>$k,'text'=>$v,'leaf'=>true, 'cls'=>'file');
		}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($tree);			
	}
	/*****************
	****获取产品图库
	
	*****************/
	function actiongetgoodsgallery()
	{
		$object = new ModelAliexpress();
		$list = $object->getimgList($_REQUEST['id']);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actiondelgallery(){
		$object = new ModelAliexpress();
		try {
			
			$afterimg = '';
			$imglist = $object->getimgList($_REQUEST['goods_id']);
			
			unset($imglist[$_REQUEST['id']-1]);	
			
			foreach($imglist as $k => $v){
				$afterimg .= $afterimg=='' ? $v['url'] : ';'.$v['url'];
			}
			$object->savegoodsimg($_REQUEST['goods_id'],$afterimg);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
			$msg = $e->getMessage();
			echo "{success:false,msg:'".$msg."'}";exit;
		}
	}
	function actiongetskuattribute(){
		$object = new ModelAliexpress();
		try {
			$msg = $object->getskuattributes($_REQUEST['id']);	
			echo $msg;exit();
		} catch (Exception $e) {
			$msg = $e->getMessage();
			echo "{success:false,msg:'".$msg."'}";exit;
		}
	}
	function actionmodify(){                               
		$object = new ModelAliexpress();
		try {
			$object->updateGoodAttributes($_POST,$_GET['id']);	
		} catch (Exception $e) {
			$msg = $e->getMessage();
			echo "{success:false,msg:'".$msg."'}";exit;
		}
		
		echo "{success:true,msg:'OK'}";exit; 
	}
    
    function actionUpdate_Ali_Price(){
        $object = new ModelAliexpress();
        $result = $object->getupdatealiprice($_REQUEST['id']);
        echo $result;exit();
    }
    function actionload_ali_message(){
        parent::actionPrivilege('load_ali_message');
        $d             = date('Y-m-d');
        $time1         = strtotime(date("Y-m-d",strtotime("$d -1 day")));
        $time2         = strtotime(date("Y-m-d",strtotime("$d -2 day")));
        $time        = date('Y-m-d',$time1);
        $time0        = date('Y-m-d',$time2);                               
        $this->tpl->assign('yesterday',$time);
        $this->tpl->assign('dday',$time0);
        $this->tpl->assign('today',$d);
        $this->tpl->assign('account',ModelDd::getComboData('aliaccount')); 
        $this->dir = 'aliexpress';
        $this->name='load_message';
        $this->show();    
    }
    /**
     * 加载站内信         
     */
    function actionloadmsg(){
        //parent::actionPrivilege('load_ali_message');  
        $object = new ModelAliexpress();
        try {
            $msg = $object->loadMSG($_GET);
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}";        
    }
    /**
     * 加载订单留言或站内信         
     */
    function actionloadmsgByOrder(){
        //parent::actionPrivilege('load_ali_message');  
        $object = new ModelAliexpress();
        try {
            $msg = $object->loadMSG($_GET);
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}";        
    }
    /**
     * 一键同步站内信         
     */
    function actionfastloadmsg(){
        //parent::actionPrivilege('load_ali_message');  
        $object = new ModelAliexpress();
        try {
            /* 默认一个月 订单与站内信一起同步 */
            $starttime = date('m/d/Y 00:00:00',time()-(360*720));/* 30天之前 */  
            $endtime = date('m/d/Y 23:59:59',time());
            $aliexpress_account = ModelDd::getArray('aliaccount');
            foreach($aliexpress_account as $id => $K){
                $_GET['id'] = $id;
                $msg .= $object->loadMSG($_GET,$starttime,$endtime,$K);         
            }
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}";        
    }
    /**
     * 速卖通站内信处理页面
     */
    function actionmessagehandle(){
        //parent::actionPrivilege('list_aliexpress_msg');
        $d             = date('Y-m-d');
        $time1         = strtotime(date("Y-m-d",strtotime("$d -1 day")));
        $time2         = strtotime(date("Y-m-d",strtotime("$d -2 day")));
        $time        = date('Y-m-d',$time1);
        $time0        = date('Y-m-d',$time2);                               
        $this->tpl->assign('yesterday',$time);
        $this->tpl->assign('dday',$time0);
        $this->tpl->assign('today',$d);
        /*$type[] = array(
            'read' => '0',
            'title' => '未读订单留言',
            'type' => 'order'
        );
        $type[] = array(
            'read' => '1',
            'title' => '所有订单留言',
            'type' => 'order'
        );
        $type[] = array(
            'read' => '0',
            'title' => '未读站内信',
            'type' => 'msg'
        );
        $type[] = array(
            'read' => '1',
            'title' => '所有站内信',
            'type' => 'msg'
        );*/
        $aliaccount = ModelDd::getArray('aliaccount');
        foreach($aliaccount as $k => $v){
            $type[] = array( 
                'read' => '1', 
                'title' => $v,
                'type' => 'account',
                'id' => $k
            );    
        }
        $object = new ModelAliexpress();
        $result = $object->getMsgTypeInfoCount($type);

        $this->tpl->assign('menu_store',$result);
        $this->tpl->assign('account',ModelDd::getComboData('aliaccount'));
        $this->tpl->assign('template',ModelDd::getComboData('message_template'));
        $this->tpl->assign('msg_type',ModelDd::getComboData('msg_type'));
        $this->name = 'msg_handle';
        $this->show();
    }
    function actiongetMessageList(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $goods = new ModelAliexpress();
        $feed = explode('&',$_REQUEST['feed']);
        $account=explode('=',$feed[0]); 
        $id=explode('=',$feed[1]);
        if($account[1]=='account'){
            $_REQUEST['account'] = $id[1];        
        }
        if(!$_REQUEST['type']){
            if($account[1]=='account'){
                $_REQUEST['type'] = 'account';
            }    
        }
        
        $where = $goods->getMessageWhere($_REQUEST);
        $list = $goods->getMessageList($pageLimit['from'],$pageLimit['to'],$where,$pageLimit['sort']);
        $result['totalCount'] = $goods->getMessageCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    function actionMarkMsgali(){
        $object = new ModelAliexpress();
        try {
            $msg = $object->MarkMsgali($_REQUEST);
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}";        
    }
    function actionSendorderMsg(){
        $object = new ModelAliexpress();
        try {
            $msg = $object->sendorcerMsg($_REQUEST);
            //$msg = '发送的内容是'.$_REQUEST['id'].'---'.$_REQUEST['orderId'].'-----'.$_REQUEST['content'];
            echo "{success:true,msg:'OK-".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}"; 
    }
    function actiongetmsgqty(){ 
        echo ModelDd::arrayFormat($result);        
    }
    function actiondel_allmsg(){
        $object = new ModelAliexpress();
        try {
            $msg = $object->del_allmsg();
            echo "{success:true,msg:'OK'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "{success:true,msg:'加载过程中发生以下错误:" . $errorMsg . "'}"; 
    }
    
    function actiongetWaitlisting(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $goods = new ModelAliexpress();
        
        $where = 'where status = 1';
        $list = $goods->getAliWaitupload($pageLimit['from'],$pageLimit['to'],$where,$pageLimit['sort']);
        $result['totalCount'] = $goods->getCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
}
?>
