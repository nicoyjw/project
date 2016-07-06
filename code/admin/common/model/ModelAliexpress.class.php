<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                  |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015 (http://www.cpowersoft.com)        |
// |                                                              |
// | 要查看完整的版权信息和许可信息                               |
// | 或者访问 http://www.cpowersoft.com 获得详细信息              |
// +--------------------------------------------------------------+

/**
 * 速卖通
 *
 * @copyright Copyright (c) 2012 - 2015 
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
 class ModelAliexpress extends ModelOrder
 {
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'order';
		$this->infotableName = CFG_DB_PREFIX . 'order_goods';
		$this->logtableName = CFG_DB_PREFIX . 'order_log';
		$this->statustableName = CFG_DB_PREFIX . 'order_status';
		$this->primaryKey = 'order_id';
	}
	/****
	批量标记速卖通产品
	****/
	function updategoodsali($arr,$goods_sn)
	{
			try {
				$this->db->update(CFG_DB_PREFIX.'goods ',$arr,"goods_sn = '".$goods_sn."'");
			} catch (Exception $e) {
				throw new Exception('更新产品信息失败,编码'.$goods_sn,'603');exit();
			}
	}
	/**
	 * 获取商品属性
	 *
	 * @param int $id  
	 * @param string  cat_id
	 *
	 * @return array attribute
	 */
	function getAttributesResultByCateId($id,$cat_id){
		include(CFG_PATH_DATA . 'ebay/ali_'.$id.'.php');
		$url = "http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.getAttributesResultByCateId/".$appkey."?cateId=".$cat_id."&access_token=".$access_token;
		return $this->RequestAli($url);
	}
	/**
	 * refresh_token换取access_token
	 *
	 * @param array $info  array('appkey','appSecret','refresh_token','id')
	 * @return string  (access_token)
	 */
	function refreshChangeAccess($info){
		
		$code_arr = array(
			'client_id' => $info['appkey'],
			'redirect_uri' => 'http://localhost:12508/auth_callback_url',
			'site' => 'aliexpress'
		);
		ksort($code_arr);
		foreach ($code_arr as $key=>$val){
			$sign_str .= $key . $val;
		}
		$code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, $info['appSecret'], true)));//$code_sign = 签名
		
		$curlPost = array(
				'grant_type' => 'refresh_token',
				'client_id' => $info['appkey'],
				'client_secret' => $info['appSecret'],
				'refresh_token' => $info['refresh_token'],
				'_aop_signature' => $code_sign
				);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
		curl_setopt($ch, CURLOPT_URL,'https://gw.api.alibaba.com/openapi/param2/1/system.oauth2/refreshToken/'.$info['appkey']);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
		$re=curl_exec($ch);
		curl_close($ch);
		$result=json_decode($re,true);
		$time = time()+3600;
		$fp = fopen(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php', 'w');
		fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$result['access_token'].'\';'.chr(10).' $refresh_token =\''.$info['refresh_token'].'\';'.chr(10).' $APIDevUserID =\''.$info['appkey'].'\';'.chr(10). ' $APIPassword =\''.$info['appSecret'].'\';'.chr(10). ' $aliId =\''.$result['aliId'].'\';'.chr(10). ' $resource_owner =\''.$result['resource_owner'].'\';'.chr(10). ' $passtime = '.(CFG_TIME+36000).';'.chr(10).' $longpasstime = '.$info['longpasstime'].';'.chr(10). '?>');
		fclose($fp);
		return $result['access_token'];
	}
    
    
    
	/**
     * 上传图片到速卖通
     *
     * @param int $id
     * @param file $data
     * @return string  (access_token)
     */
    function uploadimg($id,$url){
        include(CFG_PATH_DATA . 'ebay/ali_'.$id.'.php');
        /*$fh = fopen($url, "rb");
        $img = fread($fh, filesize($url));
        fclose($fh);
        $Name = pathinfo ( $url ,PATHINFO_BASENAME);*/
        
        
        $filePath="/var/www/html/ice/themes/default/images/add.gif";
        $fh = fopen($filePath, "rb");
        $data = fread($fh, filesize($filePath));
        fclose($fh);
        
        $upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadTempImage/'.$APIDevUserID.'?access_token='.$access_token.'&srcFileName=d.jpg'; 
        
        
        /*$upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$APIDevUserID.'?access_token='.$access_token.'&fileName='.trim($Name); */
        $data = $this->request_post($upload_image_server,$img);
        $result = json_decode($data,true);
        return $result;
        if($result['success']){
            return $result['photobankUrl'];
        }else{
            throw new Exception('上传图片失败');exit();
        }
        /*return $img;
        
        
        if($url == '') $url = 'data/upload/no_picture.gif';
        
        $filename = pathinfo ( $url ,PATHINFO_BASENAME);
        $this->get_file($url,CFG_PATH_TMP,$filename);
        $fh = fopen(CFG_PATH_TMP.$filename, "rb");
        $img = fread($fh, filesize(CFG_PATH_TMP.$filename));
        fclose($fh);
        $Name = $filename;
        $upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$appkey.'?access_token='.$access_token.'&fileName='.trim($Name); 
        $data = $this->request_post($upload_image_server,$img);
        $result = json_decode($data,true);
        if($result['success']){
            return $result['photobankUrl'];
        }else{
            throw new Exception('上传图片失败');exit();
        }*/
    }
	// post数据到url的函数
	function request_post($remote_server,$content){ 
	   set_time_limit(0);
	   $http_entity_type = 'application/x-www-from-urlencoded'; //发送的格式
		$context = array( 
			'http'=>array( 
				'method'=>'POST', 
			 // 这里可以增加其他header..
				'header'=>"Content-type: " .$http_entity_type ."\r\n". 
						  'Content-length: '.strlen($content), 
				'content'=>$content) 
			 ); 
		$stream_context = stream_context_create($context); 
		$data = @file_get_contents($remote_server,FALSE,$stream_context); 
		return $data; 
	}
	/**
	 * 添加产品库产品到速卖通产品管理
	 *
	 * @param array $info  array('id','goods_id','cat_id')
	 * @return string
	 */
	function AddProductToLib($info){
		$goods = new ModelGoods();
		$good_info = $goods->goods_info($info['goods_id']);
		//产品图片
		$imgarr = $this->db->select('select * from myr_goods_gallery where goods_id = '.$good_info['goods_id']);
		$imgstr = '';
		if(count($imgarr > 1)){
			foreach($imgarr as $key => $val){
				$imgstr .= (empty($imgstr)) ? $val['url'] : ';'.$val['url'];
			}
		}else{
			$imgstr = $good_info['goods_img'];
		}
		$SkuSTRING  = '[';
		$SkuSTRING .= '{"skuPrice":"'.$good_info['price1'].'",';
		$SkuSTRING .= '"skuStock":true,';
		$SkuSTRING .= '"aeopSKUProperty":[],';
		$SkuSTRING .= '"skuCode":"'.$good_info['goods_sn'].'"}';
		$SkuSTRING .= ']';
		//添加到速卖通产品
		try {
				$this->db->insert(CFG_DB_PREFIX.'aligoods',array(
					'goods_id' => $info['goods_id'], 
					'detail' => addslashes($good_info['des_en']),
					'last_update_time' => CFG_TIME,
					'deliveryTime' => 5,
					'categoryId' => $info['cat_id'],
					'skuCode' => $good_info['goods_sn'],
					'ali_good_id' => $good_info['goods_id'],
					'goods_name' => addslashes($good_info['goods_name']),
					'keyword' => '',
					'aeopAeProductSKUs' => json_encode($SkuSTRING),
					'freightTemplateId' => $good_info['freightTemplateId'],
					'productPrice' => $good_info['price1'],
					'productUnit' => 100000015,
					'packageLength' => floor($good_info['l']),
					'packageWidth' => floor($good_info['w']),
					'packageHeight' => floor($good_info['h']),
					'grossWeight' => $good_info['grossweight'],
					'groupId' => 0,
					'isImageDynamic' => count($imgarr)>1 ? 'true':'false',
					'aeopAeProductPropertys' => 'null',
					'imageURLs' => $imgstr,
					'packageType' => 'false',
					'lotNum' => 1
				));
				return 'OK';	
			} catch (Exception $e) {
					throw new Exception('添加失败','999');exit();
			}
		
	}
	/**
     * 上传商品到速卖通
     *
     * @param array $info  array('id','goods_id','cat_id')
     * @return string
     */
    function postAeProduct($id){
        $good_info = $this->db->getValue('select * from myr_aligoods where id = '.$id);
        //if($good_info['goods_img'] == '')return '至少指定一张图片';
        if($good_info['account_id'] == '')return '请指定刊登的Aliexpress账号';
        
        //return $good_info['account_id'];
        include(CFG_PATH_DATA . 'ebay/ali_'.$good_info['account_id'].'.php');
        if(time() > $longpasstime) 
        {
            throw new Exception("token已失效，请重新授权！",'610');exit();
        }
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$good_info['account_id'],
                'longpasstime'=>$longpasstime
            ));
        }
        $goods = new ModelGoods();
        set_time_limit(50000);
        require(CFG_PATH_LIB.'util/uploadTempImage.php');
        
        $newimg = array();
        
        if(strpos($good_info['detail'],'<img alt="aeProduct.getSubject()" src="')) {
            
            
            $imgs = explode('alt="aeProduct.getSubject()"',$good_info['detail']);
            $detailString = '';
            //替换详细描述里的图片，上传到图片银行并替换。防止出现盗用图片操作。
            foreach($imgs as $img_url_str){
                                              
                if(strpos($img_url_str,'src="')) {
                    preg_match('/.+src=\"?(.+\.jpg|gif|bmp|bnp|png)\"?.+/i',$img_url_str,$match);
                    $value = trim($match[1]);
                    
                    $get_file = @file_get_contents($value);
                    $filename = pathinfo ( $value,PATHINFO_BASENAME);
                    
                    $upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$APIDevUserID.'?access_token='.$access_token.'&fileName='.$filename; 
                    
                    $result = request_post($upload_image_server,$get_file);
                    $newimg[] = $result['photobankUrl'];
                    
                    $detailString .= preg_replace('/(http.+\.jpg|gif|bmp|bnp|png)/i', $result['url'], $img_url_str);
                }else{
                    $detailString .= $img_url_str;
                }
            }    
        }else{
            $detailString = $good_info['detail'];
        }
        
        if(count($newimg) > 1){
            
            $str = '';
            for($i=0;$i<5;$i++){
                if( isset($newimg[$i])){
                    $str .= $str == '' ? $newimg[$i] : ';'.$newimg[$i];
                }
            }
            $good_info['imageURLs'] = $str; 
        }
        
        
        $productsku = json_decode($good_info['aeopAeProductSKUs'],true);
        
        
        
        /*替换SKU属性图片*/
        if(count($productsku) >= 1){
            foreach($productsku as $k => $v){
                $skuimg = $v['aeopSKUProperty'][0]['skuImage'];
                $get_file = @file_get_contents($skuimg);
                $filename = pathinfo ( $skuimg,PATHINFO_BASENAME);
                //$upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$APIDevUserID.'?access_token='.$access_token.'&fileName='.$filename;
                //$upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadTempImage/'.$APIDevUserID.'?access_token='.$access_token.'&srcFileName='.$filename;
                //$result = request_post($upload_image_server,$get_file);
                $productsku[$k]['aeopSKUProperty'][0]['skuImage'] = '';
            }    
            
        }
        
        
        //上传产品图片到自己店铺
        /*foreach($urls as $img_url){
            $get_file = @file_get_contents($img_url);
            $filename = pathinfo ($img_url,PATHINFO_BASENAME);
            $upload_image_server = 'http://gw.api.alibaba.com/fileapi/param2/1/aliexpress.open/api.uploadImage/'.$APIDevUserID.'?access_token='.$access_token.'&fileName='.$filename; 
            $result = request_post($upload_image_server,$get_file);
            $imagesString .= $imagesString == '' ? $result['photobankUrl'] : ';'.$imagesString;
        }*/
        
                                                                   
        $good_info['aeopAeProductSKUs'] = json_encode($productsku);
        $curlPost = array(
            'productId' => $good_info['ali_good_id'], 
            'detail' => /*$detailString*/ ' ',
            'deliveryTime' => $good_info['deliveryTime'],
            'categoryId' => $good_info['categoryId'],
            'subject' => $good_info['goods_name'],
            'keyword' => $good_info['keyword'],
            'aeopAeProductSKUs' => str_replace('"',"'",$good_info['aeopAeProductSKUs']) ,
            'freightTemplateId' => $good_info['freightTemplateId'] == '' ? '1000' : $good_info['freightTemplateId'],
            'productPrice' => $good_info['productPrice'],
            'productUnit' => $good_info['productUnit'],
            'packageLength' => floor($good_info['packageLength']),
            'packageWidth' => floor($good_info['packageWidth']),
            'packageHeight' => floor($good_info['packageHeight']),
            'grossWeight' => $good_info['grossWeight'],
            'wsValidNum' => $good_info['wsValidNum'],
            'groupId' => /*$good_info['groupId']*/'0',
            'isImageDynamic' => count(explode(';',$good_info['imageURLs']))>1    ? 'true' : 'false',
            'aeopAeProductPropertys' => $good_info['aeopAeProductPropertys'],
            'imageURLs' => $good_info['imageURLs']/*'http://hz01.i.aliimg.com/img/pb/935/032/001/1001032935_371.jpg'*/,
            'isImageWatermark' => 'false',
            'isPackSell' => 'false',
            'packageType' => $good_info['packageType'] > 1 ? 'true' : 'false',
            'lotNum' => $good_info['lotNum'],
            'access_token' => $access_token
        );
        if($info->bulkOrder>1){
            $curlPost['bulkOrder'] = $good_info['bulkOrder'];
            $curlPost['bulkDiscount'] = $good_info['bulkDiscount'];
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
        curl_setopt($ch, CURLOPT_URL,'http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.postAeProduct/'.$APIDevUserID);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        return var_dump($result);
        if($result['success']){
            //更新aliexpressid 和 状态。上线销售状态为0
            $this->db->update(CFG_DB_PREFIX.'aligoods',array('ali_good_id'=>$result['productId'],'status'=>0),'id='.$id);
            return '产品'.$good_info['skuCode'].'刊登成功!';
        }else{
            return "错误信息:".$this->updateerrorcode2notice(intval($result['error_code'])); 
            
        }
    }
	/**
	 * 获取授权的地址
	 */
	function geturl($info){
		$redirect_uri = 'http://www.cpowersoft.com/blog/?page_id=2130';
		$code_arr = array(
			'client_id' => '9223302',
			'redirect_uri' => $redirect_uri,
			'site' => 'aliexpress'
		);
		ksort($code_arr);
		foreach ($code_arr as $key=>$val){
			$sign_str .= $key . $val;
		}
		$code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, 'IyW9Jy8MermW', true)));//$code_sign -- 签名
		$get_code_url = "http://gw.api.alibaba.com/auth/authorize.htm?client_id=9223302&redirect_uri={$redirect_uri}&site=aliexpress&_aop_signature={$code_sign}";
		return $get_code_url;
	}
         
	/*
	 * 完成授权
	 */
	function overAuth($info){
		$curlPost = array(
			'grant_type' => 'authorization_code',
			'need_refresh_token' => 'true',
			'client_secret' => 'IyW9Jy8MermW',
			'redirect_uri' => 'http://localhost:12508/auth_callback_url',
			'client_id' => '9223302',
			'code' => $info['alicode']);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
		curl_setopt($ch, CURLOPT_URL,'https://gw.api.alibaba.com/openapi/http/1/system.oauth2/getToken/9223302');
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
		$re=curl_exec($ch);
		curl_close($ch);
		$result=json_decode($re,true);
		$object = new ModelEbayaccount();
                                                          
        
        if($result['access_token'] <> '' && $result['refresh_token'] <> ''){
            if($info['account']){
                  $longtime = time()+60*60*24*180;
                $fp = fopen(CFG_PATH_DATA . 'ebay/ali_' . $info['account'] .'.php', 'w');
                fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$result['access_token'].'\';'.chr(10).' $refresh_token =\''.$result['refresh_token'].'\';'.chr(10).' $APIDevUserID =\'9223302\';'.chr(10). ' $APIPassword =\'IyW9Jy8MermW\';'.chr(10). ' $aliId =\''.$result['aliId'].'\';'.chr(10). ' $resource_owner =\''.$result['resource_owner'].'\';'.chr(10). ' $passtime = '.(CFG_TIME+36000).';'.chr(10).' $longpasstime = '.$longtime.';'.chr(10). '?>');
                fclose($fp);
                return;  
            }                                    
            $uid = $object->save(array('account_name' => $info['account_name'],'ac_token'=>$result['access_token'],'re_token'=>$result['refresh_token'],'APIDevUserID'=>'9223302','APIPassword'=>'IyW9Jy8MermW','devID' => $result['resource_owner'],  'appID' => $result['aliId'] ,  'type' => 6));
            
            $longtime = time()+60*60*24*180;
            $fp = fopen(CFG_PATH_DATA . 'ebay/ali_' . $uid .'.php', 'w');
            fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$result['access_token'].'\';'.chr(10).' $refresh_token =\''.$result['refresh_token'].'\';'.chr(10).' $APIDevUserID =\'9223302\';'.chr(10). ' $APIPassword =\'IyW9Jy8MermW\';'.chr(10). ' $aliId =\''.$result['aliId'].'\';'.chr(10). ' $resource_owner =\''.$result['resource_owner'].'\';'.chr(10). ' $passtime = '.(CFG_TIME+36000).';'.chr(10).' $longpasstime = '.$longtime.';'.chr(10). '?>');
            fclose($fp);   
        }else{
            throw new Exception('服务提供商出错，请重试或检查您的授权信息','610');exit();
        }  
	}
	/**
	 * 获取所有类目
	 */
	function getChildrenPostCategoryById($appkey,$access_token,$cateId){
		$curlPost = array(
			'access_token=' => $access_token,
			'cateId' => $cateId
		);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
		curl_setopt($ch, CURLOPT_URL,"http://gw.api.alibaba.com".$this->common_port."/openapi/param2/1/aliexpress.open/api.getChildrenPostCategoryById/".$appkey);
		curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
		$re=curl_exec($ch);
		curl_close($ch);
		$result=json_decode($re,true);
		return $result;
	}
	
	/**
	 * 获取运费模版
	 */
	function getFreight($appkey){
		$curlPost = array(
			'access_token' => $this -> getaccess_token($appkey)
		);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
		curl_setopt($ch, CURLOPT_URL,"http://gw.api.alibaba.com".$this->common_port."/openapi/param2/1/aliexpress.open/listFreightTemplate/".$appkey);
		curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($curlPost));
		$re=curl_exec($ch);
		curl_close($ch);
		$result=json_decode($re,true);
		if($result['aeopFreightTemplateDTOList']){
			foreach($result['aeopFreightTemplateDTOList'] as $k => $v){
				$freight[$v['templateId']] = $v['templateName'];
			}
			return $freight;
		}else{
			throw new Exception('服务提供商出错','610');exit();
		}
	}
	/**
	 * 获取category树状列表 
	 */
	function catTree($com=1){
		$this->db->open('select * FROM myr_alicategory where parent_id = 0');
		$trees = array();
		while ($rs = $this->db->next()) {
			if($rs['parent_id'] == 0){
				$has_child = $this->db->getValue('select count(*) from myr_alicategory where parent_id ='.$rs['cat_id']);
				$trees['root'][] = array('id'=>$rs['cat_id'],'text'=>$rs['name_en'].'('.$rs['cat_name'].')','leaf'=>(($has_child > 0)?false:true), 'cls'=>(($has_child>0)?'folder':'file'));
			}
		}
		return $trees;
	}
	/*************
	循环tree列表
	*************/
	function getchildtree($id)
	{
		$list = $this->db->select('select * FROM myr_alicategory where parent_id ='.$id.' order by cat_name');
		for ($i=0;$i<count($list);$i++) {
			$has_child = $this->db->getValue('select count(*) from myr_alicategory where parent_id ='.$list[$i]['cat_id']);
			$trees[] = array('id'=>$list[$i]['cat_id'],'text'=>$list[$i]['name_en'].'('.$list[$i]['cat_name'].')','leaf'=>(($has_child > 0)?false:true), 'cls'=>(($has_child>0)?'folder':'file'));
		}
		return $trees;
	}
	function checkIspass($account_id){
		require_once(CFG_PATH_DATA . 'ebay/ali_' . $account_id .'.php');
		/*if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}*/
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$account_id,
				'longpasstime'=>$longpasstime
			));
		}
		return $access_token;
	}
	/**
	 * 加载aliexpress订单
	 *
	 * @param array $info
	 * @return string
	 */
	function loadaliorder($info,$starttime=null,$endstart=null,$account_name=null)
	{
     
		set_time_limit(300);
        
        if(!is_file(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php')){
            ob_flush();
            flush();
            echo '<span style="font-size:13px;line-height:35px;width:31%;float:left;"><font color="#FF0000">帐号不存在，可能已被删除。。..</font></span>';exit;    
        }    
		
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php');
		if(time() > $longpasstime) 
		{  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
		}    
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$info['id'],
				'longpasstime'=>$longpasstime
			));
		}
		//状态
		
        if($starttime==null && $endstart==null){
            
            $loadarr = array();
            if($info['PLACE_ORDER_SUCCESS'] == 'true') $loadarr[] = 'PLACE_ORDER_SUCCESS';
            if($info['IN_CANCEL'] == 'true') $loadarr[] = 'IN_CANCEL';
            if($info['WAIT_SELLER_SEND_GOODS'] == 'true') $loadarr[] = 'WAIT_SELLER_SEND_GOODS';
            if($info['SELLER_PART_SEND_GOODS'] == 'true') $loadarr[] = 'SELLER_PART_SEND_GOODS';
            if($info['WAIT_BUYER_ACCEPT_GOODS'] == 'true') $loadarr[] = 'WAIT_BUYER_ACCEPT_GOODS';
            if($info['FUND_PROCESSING'] == 'true') $loadarr[] = 'FUND_PROCESSING';
            if($info['FINISH'] == 'true') $loadarr[] = 'FINISH';
            if($info['IN_ISSUE'] == 'true') $loadarr[] = 'IN_ISSUE';
            if($info['IN_FROZEN'] == 'true') $loadarr[] = 'IN_FROZEN';
            if($info['WAIT_SELLER_EXAMINE_MONEY'] == 'true') $loadarr[] = 'WAIT_SELLER_EXAMINE_MONEY';
            if($info['RISK_CONTROL'] == 'true') $loadarr[] = 'RISK_CONTROL';
            $start = explode('-',$info['start']);
            $info['start'] = $start[1].'/'.$start[2].'/'.$start[0];
            $end = explode('-',$info['end']);
            $info['end'] = $end[1].'/'.$end[2].'/'.$end[0];
            for($i = 0; $i<count($loadarr); $i++){
                $page = 1;
                
                $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID.'?page='.$page.'&pageSize=50&createDateStart='.$info['start'].'&createDateEnd='.$info['end'].'&orderStatus='.$loadarr[$i].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID,array(
                    'page' => $page,
                    'pageSize' => '50',
                    'createDateStart' => $info['start'],
                    'createDateEnd' => $info['end'],
                    'orderStatus' => $loadarr[$i],
                    'access_token' => $access_token
                )));//更新后重新请求
                //return var_dump($result);
                $str .= $this->savealiorder($result['orderList'],$info['id']);
                if($result['totalItem'] > '50'){  //总记录大于50
                    if($page == 3) return '亲。还有订单没同步完喔~';
                    for($page = 2; $page <= ceil($result['totalItem']/50);$page++){
                        
                        $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID.'?page='.$page.'&pageSize=50&createDateStart='.$info['start'].'&createDateEnd='.$info['end'].'&orderStatus='.$loadarr[$i].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID,array(
                    'page' => $page,
                    'pageSize' => '50',
                    'createDateStart' => $info['start'],
                    'createDateEnd' => $info['end'],
                    'orderStatus' => $loadarr[$i],
                    'access_token' => $access_token
                )));//更新后重新请求
                        
                        try {
                                $str .= $this->savealiorder($result['orderList'],$info['id']);
                        } catch (Exception $e) {
                                throw new Exception('保存订单失败1','999');exit();
                        }
                    }
                }
            }
            return '同步结束';    
            
        }else{
            ob_flush();
            flush();
            echo '<span style="font-size:13px;line-height:35px;width:31%;float:left;"><font color="#FF0000">'.$account_name.'..开始</font></span>';    
            $loadarr = array();
            $loadarr[] = 'WAIT_SELLER_SEND_GOODS';
            $info['start'] = $starttime;
            $info['end'] = $endstart;
            
            for($i = 0; $i<count($loadarr); $i++){
                $page = 1;
                 
                $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID.'?page='.$page.'&pageSize=50&createDateStart='.$info['start'].'&createDateEnd='.$info['end'].'&orderStatus='.$loadarr[$i].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID,array(
                    'page' => $page,
                    'pageSize' => '50',
                    'createDateStart' => $info['start'],
                    'createDateEnd' => $info['end'],
                    'orderStatus' => $loadarr[$i],
                    'access_token' => $access_token
                )));//更新后重新请求
                $str .= $this->savealiorder($result['orderList'],$info['id']);
                if($result['totalItem'] > 50){  //总记录大于50
                    if($page == 3) return '亲。'.$account_name.'还有订单没同步完喔~';
                    for($page = 2; $page <= ceil($result['totalItem']/50);$page++){
                        
                        $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID.'?page='.$page.'&pageSize=50&createDateStart='.$info['start'].'&createDateEnd='.$info['end'].'&orderStatus='.$loadarr[$i].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findOrderListQuery/'.$APIDevUserID,array(
                    'page' => $page,
                    'pageSize' => '50',
                    'createDateStart' => $info['start'],
                    'createDateEnd' => $info['end'],
                    'orderStatus' => $loadarr[$i],
                    'access_token' => $access_token
                )));//更新后重新请求
                        
                      try {
                                $str .= $this->savealiorder($result['orderList'],$info['id']);
                        } catch (Exception $e) {
                                throw new Exception('保存订单失败1','999');exit();
                        }
                    }
                }
            }
        }
	}
	 /**
	 * 保存速卖通订单
	 * @param string $status
	 *
	 */
	function ChangeAliStatus($status){
		switch($status)
		{
			case 'PLACE_ORDER_SUCCESS':
			return '等待买家付款';
			case 'IN_CANCEL':
			return '买家申请取消';
			case 'WAIT_SELLER_SEND_GOODS':
			return '等待您发货';
			case 'SELLER_PART_SEND_GOODS':
			return '部分发货';
			case 'WAIT_BUYER_ACCEPT_GOODS':
			return '等待买家收货';
			case 'FUND_PROCESSING':
			return '买家确认收货后';
			case 'FINISH':
			return '已结束的订单';
			case 'IN_ISSUE':
			return '含纠纷的订单';
			case 'IN_FROZEN':
			return '冻结中的订单';
			case 'WAIT_SELLER_EXAMINE_MONEY':
			return '等待您确认金额';
			case 'RISK_CONTROL':
			return '资金未到账';
			case 'onSelling':
			return '上架销售中';
			case 'offline':
			return '已下架';
			case 'auditing':
			return '审核中';
			case 'editingRequired':
			return '审核不通过';
			case 'expire_offline':
			return '到期下架';
			case 'user_offline':
			return '手动下架';
            case 'waitUpload':
            return '待发布';
			case 'allStatus':
			return '所有状态';
			default:
			return NULL;
		}
	}           
	function _aop_signature($apiInfo,$code_arr){
        $url = 'http://gw.api.alibaba.com/openapi';//1688开放平台使用gw.open.1688.com域名
        $appKey = '9223302';;
        $appSecret ='IyW9Jy8MermW';
        
        ksort($code_arr);
        foreach ($code_arr as $key=>$val)
            $sign_str .= $key . $val;
        $sign_str = $apiInfo . $sign_str;
        $code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, $appSecret, true)));    
        return $code_sign;
        
    }
	/**
	 * 保存速卖通订单
	 * @param array $orders
	 * @param int $id
	 * @param bool $isload
	 *
	 */
	function savealiorder($orders,$id,$country=NULL){
		set_time_limit(30);
		require(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
		require(CFG_PATH_DATA . 'dd/currency.php');
		$goodob = new ModelGoods();
		try { 
			$orderObj = new ModelOrder();
			$sc = 35; //滚动条高度
			for($i = 0;$i < count($orders);$i++){
                
				$string = '';
				$orderid = $this->db->getValue("SELECT order_id,ali_status,order_status  FROM ".$this->tableName." WHERE Sales_account_id =".$id." and paypalid='".$orders[$i]['orderId']."'");
				if($orderid < 1){
                    
                    $ch = curl_init("http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findOrderById/".$APIDevUserID."?orderId=".$orders[$i]['orderId']."&access_token=".$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.findOrderById/".$APIDevUserID,array(
                        'orderId' => $orders[$i]['orderId'],
                        'access_token' => $access_token
                    ))); 
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true) ;  
                    $re=curl_exec($ch);
                    curl_close($ch);
                    $info = json_decode($re,true);
                   
                    if($country <> NULL){
                        if($info['receiptAddress']['country'] <> $country) continue;
                    }     
                    $telnumber = $info['receiptAddress']['phoneCountry'].$info['receiptAddress']['phoneArea'].$info['receiptAddress']['phoneNumber'];
					
                     
                    if($info['receiptAddress']['mobileNo'] <> ''){
                        $telnumber = $info['receiptAddress']['mobileNo']; 
                    }
                    
                    
                    $content = '';
					$string .= '同步订单'.$orders[$i]['orderId'];
					$string .= '('.$this->ChangeAliStatus($info['orderStatus']).')';
					$paittime = substr($orders[$i]['gmtPayTime'],0,4).'-'.substr($orders[$i]['gmtPayTime'],4,2).'-'.substr($orders[$i]['gmtPayTime'],6,2);
					$order_sn = $this->get_order_sn();
					$alistatus = $info['orderStatus'];
					if($alistatus == 'WAIT_BUYER_ACCEPT_GOODS'){
						$orderstatus = 139; //已发货订单
					}else if($alistatus == 'FUND_PROCESSING' or $alistatus == 'FINISH'){
						$orderstatus = 131; //已完成订单
					}else if($alistatus == 'RISK_CONTROL'){
						$orderstatus = 116; //资金未到账 默认客服审核失败
					}else{
						$orderstatus = 112; //默认待客服审核订单
					}
                    /* start  2014-06-22  修复速卖通加载回来 英国 UK => GB    塞尔维亚  SR => RS */
                    $countrycode = $info['receiptAddress']['country'];
                    
                    if($countrycode == 'UK'){
                        $countrycode = 'GB';        
                    }
                    if($countrycode == 'SR'){
                        $countrycode = 'RS';    
                    }
                     
                    /* end  2014-06-22  修复速卖通加载回来 英国 UK => GB    塞尔维亚  SR => RS */

					$this->db->insert(CFG_DB_PREFIX.'order', array(
						'order_sn' => $order_sn,
						'userid' => addslashes_deep($info['receiptAddress']['contactPerson']),
						'order_amount' => $orders[$i]['payAmount']['amount'],
						'currency' => $orders[$i]['payAmount']['currencyCode'],
						'rate' =>$currency[$orders[$i]['payAmount']['currencyCode']],
						'shipping_fee' => $info['logisticsAmount']['amount'],
						'ShippingService' => addslashes_deep($orders[$i]['productList'][0]['logisticsServiceName']),
						'Sales_account_id' => $id,
						'Sales_channels' => 4,
						'paypalid' => $orders[$i]['orderId'],
						'consignee' => addslashes_deep($info['receiptAddress']['contactPerson']),
						'email' => addslashes_deep($info['buyerInfo']['email']),
						'street1' => addslashes_deep($info['receiptAddress']['detailAddress']),
						'street2' => addslashes_deep($info['receiptAddress']['address2']),
						'city' => addslashes_deep($info['receiptAddress']['city']),
						'state' => addslashes_deep($info['receiptAddress']['province']),
						'order_status' => $orderstatus,
						'country' => addslashes_deep($orderObj->getCountry($countrycode)),
						'CountryCode' => $countrycode,
						'ali_status' => $alistatus,
						'zipcode' => addslashes_deep($info['receiptAddress']['zip']),
						'tel' => $telnumber,
						'pay_note' => addslashes_deep( $orders[$i]['productList'][0]['memo']),
                        'paid_time' => strtotime($paittime),
						'add_time' => CFG_TIME
					));	
					$order_id = $this->db->getInsertId();
                    
                    $pay_note = '';
                    
                    $ishave = array();
                       
                    for($j=0;$j<count($orders[$i]['productList']);$j++){
                        
                        
                        $str = $orders[$i]['productList'][$j]['productSnapUrl'];
                        $arr = explode('/',$str);
                        $item_no = explode('.',$arr[4]);
                        
                        if(count($info['childOrderList']) >= 1){
                               
                            foreach(@$info['childOrderList'] as $key => $prods){
                                            
                                $ali_qty = '';
                                if($prods['productId'] == $orders[$i]['productList'][$j]['productId'] && $prods['skuCode'] == $orders[$i]['productList'][$j]['skuCode']){
                                    
                                    if(in_array($key,$ishave)){
                                        
                                        continue;            
                                    }
                                    $ishave[] = $key;
                                    
                                    $orders[$i]['productList'][$j]['Attribute_note'] = $prods['productAttributes'];
                                          
                                    if(CFG_ALI_SPLITGOODS && $prods['lotNum'] > 1){
                                        $lotqty = $prods['productCount'] * $prods['lotNum'];     
                                        $orders[$i]['productList'][$j]['productCount'] = $lotqty; 
                                             
                                    }
                                    if($prods['lotNum'] > 1){
                                        $ali_qty = $prods['productCount'].' '.$orders[$i]['productList'][$j]['productUnit'].'('. $prods['lotNum'] .'/ '.$orders[$i]['productList'][$j]['productUnit'].')';  
                                        $orders[$i]['productList'][$j]['ali_qty'] = $ali_qty;    
                                    }else{
                                        $ali_qty = $prods['productCount'].' '.$orders[$i]['productList'][$j]['productUnit'];
                                        $orders[$i]['productList'][$j]['ali_qty'] = $ali_qty;  
                                    }
                                     
                                    break;  
                                }    
                            }    
                        }
                        $this->db->insert(CFG_DB_PREFIX.'order_goods', array(
                            'order_id' => $order_id,
                            'goods_sn' => addslashes_deep($this->getRealSKU($orders[$i]['productList'][$j]['skuCode'])),
                            'sn_prefix' => $sn_prefix,
                            'item_no' => addslashes_deep($item_no[0]),
                            'goods_name' => addslashes_deep($orders[$i]['productList'][$j]['productName']),
                            'Attribute_note' => $orders[$i]['productList'][$j]['Attribute_note'],
                            'goods_qty' => $orders[$i]['productList'][$j]['productCount'],
                            'goods_price' => $orders[$i]['productList'][$j]['productUnitPrice']['amount'],  
                            'good_line_img' => addslashes_deep( $orders[$i]['productList'][$j]['productImgUrl']),
                            'ali_qty' => $ali_qty ,
                            'ali_logistic' => addslashes_deep($orders[$i]['productList'][$j]['logisticsServiceName']),
                            'ali_note' => addslashes_deep( $orders[$i]['productList'][$j]['memo']),
                        ));
                        if($j==0){
                            $pay_note .= 'SKU:'.addslashes_deep($this->getRealSKU($orders[$i]['productList'][$j]['skuCode'])).',   数量: '.$orders[$i]['productList'][$j]['productCount'].' '.$orders[$i]['productList'][$j]['productUnit'].'   ,备注:'.addslashes_deep( $orders[$i]['productList'][$j]['memo']);
                        }else{
                            $pay_note .= '
SKU:'.addslashes_deep($this->getRealSKU($orders[$i]['productList'][$j]['skuCode'])).'  ,数量:  '.$orders[$i]['productList'][$j]['productCount'].' '.$orders[$i]['productList'][$j]['productUnit'].'  ,备注:'.addslashes_deep( $orders[$i]['productList'][$j]['memo']);
                        }
                        $n--;                
                    }
                    if(count($orders[$i]['productList'])>1){$this->db->update( CFG_DB_PREFIX.'order',
                        array(
                            'pay_note' => $pay_note
                        ),'order_id = '.$order_id        
                    );}
                    ob_flush();            
                    flush();
                    echo '<span style="font-size:12px;line-height:35px;width:31%;float:left;">'.$string.'</span>';
				}else{
					//已加载订单是否为资金未到账,然后对比当前状态是否已经是等待您发货。则更新！
					//$lastinfo = $this->db->getValue('select order_id,ali_status,order_status from '.CFG_DB_PREFIX.'order where paypalid='.$orders[$i]['orderId']);
					if($orderid['ali_status'] == 'RISK_CONTROL' && $orderid['order_status'] == 116){
						if($orders[$i]['orderStatus'] == 'WAIT_SELLER_SEND_GOODS'){
							$this->db->update(CFG_DB_PREFIX.'order',array(
								'ali_status'=>'WAIT_SELLER_SEND_GOODS',
								'order_status'=>112
								),'paypalid='.$orders[$i]['orderId']);
							$string = '更新订单'.$orders[$i]['orderId'].',';
							$string .= '<font color="#FF0000">等待您发货</font>!<br>';
							$this->save_order_log($orderid['order_id'],'同步订单','订单状态被更改为112');
						}else if($info['orderStatus'] == 'RISK_CONTROL'){
							//还是资金未到账 暂时不做处理
						}else{
							$string = '更新订单'.$orders[$i]['orderId'].',';
							$string .= '(<font color="#FF0000">'.$this->ChangeAliStatus($orders[$i]['orderStatus']).')</font>';
						}
                        ob_flush();
                        flush();
                        echo '<span style="font-size:12px;line-height:35px;width:31%;float:left;">'.$string.'</span>';
					}
					//订单已经存在 检查产品
                    
				}
			}
		}
		catch(Exception $e) 
		{			
			throw new Exception($e->getMessage(),'002');exit();
		}
		return $string;
	}
	/**
	 * 获取订单站内信
	 * @param string $url
	 *
	 */
	function getAliOrderMsg($order_id,$info){
		//订单站内信  
        
        
		$result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageList/'.$info['APIDevUserID'].'?orderId='.$order_id.'&access_token='.$info['access_token']);
		if(count($result) > 0 ){
			for($i=0;$i<count($result);$i++){
                
                $is_set = $this->db->getValue("select count(*) from myr_aliorder_msg where id =".$result[$i]['id']); 
                if(!$is_set){
                   $createtime = substr($result[$i]['gmtCreate'],0,4).'-'.substr($result[$i]['gmtCreate'],4,2).'-'.substr($result[$i]['gmtCreate'],6,2);
                    $this->db->insert('myr_aliorder_msg',array(
                        'id' => $result[$i]['id'],
                        'order_id' => $info['order_id'],
                        'msg_content' => addslashes_deep($result[$i]['content']),
                        'aliorderid' => $order_id,
                        'haveFile' => $result[$i]['haveFile'],
                        'receiverLoginId' => $result[$i]['receiverLoginId'],
                        'create_time' => $createtime,
                        'add_time' => CFG_TIME,
                        'messageType' => $result[$i]['messageType'],
                        'receiverEmail' => $result[$i]['receiverEmail'],
                        'receiverName' => $result[$i]['receiverName'],
                        //'msg_type' => $result[$i]['messageType']
                    )); 
                }
				
			}	
		}
          
		return count($result);
	}
	
	
	/**
     * 获取订单站内信
     * @param string $url
     *
     */
    function getAliOrderMsgBybuyerid($buyer_id,$info){
        //订单站内信 
         
        $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageListByBuyerId/'.$info['APIDevUserID'].'?buyerId='.$buyer_id.'&access_token='.$info['access_token']);
        if(count($result) > 0 ){
            for($i=0;$i<count($result);$i++){
                
                $is_set = $this->db->getValue("select count(*) from myr_aliorder_msg where id ".$result[$i]['id']); 
                if(!$is_set){
                    if($result[$i]['messageType'] == 'productList'){
                        foreach($info['productList'] as $key => $goodsval){
                            
                        }      
                    }
                    $createtime = substr($result[$i]['gmtCreate'],0,4).'-'.substr($result[$i]['gmtCreate'],4,2).'-'.substr($result[$i]['gmtCreate'],6,2);
                    $this->db->insert('myr_aliorder_msg',array(
                        'id' => $result[$i]['id'],
                        'order_id' => 0,
                        'msg_content' => addslashes_deep($result[$i]['content']),
                        'aliorderid' => '',
                        'haveFile' => $result[$i]['haveFile'],
                        'receiverLoginId' => $result[$i]['receiverLoginId'],
                        'create_time' => $createtime,
                        'add_time' => CFG_TIME,
                        'messageType' => $result[$i]['messageType'],
                        'receiverEmail' => $result[$i]['receiverEmail'],
                        'receiverName' => $result[$i]['receiverName'],
                        'msg_type' => $result[$i]['messageType'],
                        'product_id' => $result[$i]['typeId']
                    )); 
                }
                
            }    
        }
        
        
        
        return count($result);
    }
	
	/**
	 * 
	 * @param string $url
	 *
	 */
	function RequestAli($url)
	{
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true) ; 
		curl_setopt($ch, CURLOPT_BINARYTRANSFER, true) ;
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
		$re=curl_exec($ch);
		curl_close($ch);
		return json_decode($re,true);
	}
	/**
	 * 清楚某产品的SKU子产品
	 * @param string $url
	 *
	 */
	function DelSKUProperty($id)
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX.'aligood_child where account_id='.$id);
	}
	/**
     * 同步产品
     * @param array $info
     *
     */
    function loadGoods($info){
        set_time_limit(60);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php');
        if(time() > $longpasstime) 
        {
            throw new Exception("token已失效，请重新授权！",'610');exit();
        }
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        $this->DelSKUProperty($info['id']);
        $loadarr = array();
        if($info['onSelling'] == 'true') $loadarr[] = 'onSelling';
        if($info['offline'] == 'true') $loadarr[] = 'offline';
        if($info['auditing'] == 'true') $loadarr[] = 'auditing';
        if($info['editingRequired'] == 'true') $loadarr[] = 'editingRequired';
        $isload = 0; 
        $countnum = 0;
        $pages = 50;
        $print = '';
        try {
            for($i = 0; $i<count($loadarr); $i++){
                $this->db->execute('delete from '.CFG_DB_PREFIX.'aligoods where account_id='.$info['id'].' and goods_status='."'".$loadarr[$i]."'");
                $insert = 0; 
                $update = 0;
                $page = 1;
                //始终加载一页
                $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findProductInfoListQuery/'.$APIDevUserID.'?productStatusType='.$loadarr[$i].'&pageSize='.$pages.'&currentPage='.$page.'&access_token='.$access_token);
                if(!empty($result['aeopAEProductDisplayDTOList'])){
                    foreach($result['aeopAEProductDisplayDTOList'] as $goods_value){
                        $modtime = substr($goods_value['gmtModified'],0,4).'-'.substr($goods_value['gmtModified'],4,2).'-'.substr($goods_value['gmtModified'],6,2);
                        $this->savealigood($goods_value['productId'],$info['id'],$modtime,$isload);
                    }
                    //是否有多页
                    if($result['productCount'] > $pages){
                        for($page = 2; $page <= ceil($result['productCount']/$pages);/*$page <= $result['totalPage'];*/$page++){
                            //if($page==4)return $result['productCount'];
                            $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findProductInfoListQuery/'.$APIDevUserID.'?productStatusType='.$loadarr[$i].'&pageSize='.$pages.'&currentPage='.$page.'&access_token='.$access_token);
                            try {
                                foreach($result['aeopAEProductDisplayDTOList'] as $goods_value){
                                    $modtime = substr($goods_value['gmtModified'],0,4).'-'.substr($goods_value['gmtModified'],4,2).'-'.substr($goods_value['gmtModified'],6,2);
                                    $this->savealigood($goods_value['productId'],$info['id'],$modtime,$isload);
                                }
                            } catch (Exception $e) {
                                throw new Exception($e->getMessage(),'999');exit();
                            }
                        }    
                    }
                    $print .= $this->ChangeAliStatus($loadarr[$i]).'('.$result['productCount'].')<br>';
                }else{
                    $print .= $this->ChangeAliStatus($loadarr[$i]).'(0)<br>';
                }
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage(),'999');exit();
        }
        return $print;
    }
    /**
     * 保存同步的产品
     * @param string $productID
     * @param int $id
     * @param int $updatetime
     */
    function savealigood($productID,$id,$updatetime=0,$isload){
        set_time_limit(30);
        include(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
        $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$productID.'&access_token='.$access_token);
        $is_child = count($result['aeopAeProductSKUs']);
        //子产品暂时忽略
        /*for($i=0; $i<$is_child; $i++){
            $this->db->insert(CFG_DB_PREFIX."aligood_child",array(
                'ali_good_id'=>$productID,
                'aeopSKUProperty'=>addslashes(json_encode($result['aeopAeProductSKUs'][$i]['aeopSKUProperty'])),
                'skuPrice'=>$result['aeopAeProductSKUs'][$i]['skuPrice'],
                'skuStock'=>$result['aeopAeProductSKUs'][$i]['skuStock'],
                'skuCode'=>$result['aeopAeProductSKUs'][$i]['skuCode'],
                'account_id' => $id
            ));
        }*/
        
         //不同步到产品库
         if($result['productStatusType'] == 'onSelling'){
            $goods_status = 0;
        }elseif($result['productStatusType'] == 'offline'){
            $goods_status = 2;
        }elseif($result['productStatusType'] == 'auditing'){
            $goods_status = 0;
        }elseif($result['productStatusType'] == 'editingRequired'){
            $goods_status = 1;
        }
        $isgood = $this->db->getValue('select count(id) from myr_aligoods where account_id ='.$id.' and ali_good_id='."'".$productID."'");
        $imgarr = explode(';',$result['imageURLs']);
        if(!$isgood){
            $this->db->insert(CFG_DB_PREFIX.'aligoods',array(
                //'goods_id' => $goods_id,
                'last_update_time' => strtotime($updatetime),
                'deliveryTime' => $result['deliveryTime'],
                'categoryId' => $result['categoryId'],
                'aeopAeProductSKUs' => json_encode($result['aeopAeProductSKUs']),
                'skuCode' => $result['aeopAeProductSKUs'][0]['skuCode'],
                'keyword' => addslashes($result['keyword']),
                'productMoreKeywords1' => addslashes($result['productMoreKeywords1']),
                'productMoreKeywords2' => addslashes($result['productMoreKeywords2']),
                'productPrice' => $result['aeopAeProductSKUs'][0]['skuPrice'],
                'productUnit' => $result['productUnit'],
                'freightTemplateId' => $result['freightTemplateId'],
                'isImageDynamic' => $result['isImageDynamic'],
                'is_upload' => 0,
                'lotNum' => $result['lotNum'],
                'packageType' => ($result['packageType']==false)?0:1,
                'ali_good_id' => $result['productId'],
                'aeopAeProductPropertys' => addslashes(json_encode($result['aeopAeProductPropertys'])),
                'goods_status' => $result['productStatusType'],
                'ownerMemberId' => $result['ownerMemberId'],
                'wsOfflineDate' => $result['wsOfflineDate'],
                'wsDisplay' => $result['wsDisplay'],
                'wsValidNum' => $result['wsValidNum'],
                'goods_name' => addslashes($result['subject']),
                'groupId' => $result['groupId'],
                'bulkOrder' => $result['bulkOrder'],
                'bulkDiscount' => $result['bulkDiscount'],
                'goods_img' => $result['isImageDynamic'] == 0 ? $result['imageURLs'] : $imgarr[0],
                'imageURLs' =>  $result['imageURLs'],
                'packageLength' => $result['packageLength'],
                'packageWidth' => $result['packageWidth'],
                'packageHeight' =>  $result['packageHeight'],
                'grossWeight' =>  $result['grossWeight'],
                'detail' =>  addslashes($result['detail']),                                                          
                'account_id' => $id,
                'status' => $goods_status
            ));
        }
    }
	/**
	 * 标记发货物流方式
	 * @param string $
	 */
	function exserveice(){
		$arr(
			'EMS_SH_ZX_US',
			'EMS',
			'SEP',
			'FEDEX',
			'UPSE',
			'FEDEX_IE',
			'RUSTON',
			'HKPAP',
			'CPAM',
			'SF',
			'HKPAM',
			'HKPAM',
			'ZTORU',
			'ARAMEX',
			'CPAP',
			'TNT',
			'ECONOMIC139',
			'DHL',
			'UPS',
			'SGP'
		);	
	}
	/**
	 * 速卖通上传文件处理
	 * @param string $url
	 * @param string $folder
	 * @param string $pic_name
	 */
	function get_file($url,$folder,$pic_name){ 
		set_time_limit(24*60*60); //限制最大的执行时间
		$destination_folder=$folder?$folder.'/':''; //文件下载保存目录
		$newfname=$destination_folder.$pic_name;//文件PATH
		$file=fopen($url,'rb');
		if($file){         
			$newf=fopen($newfname,'wb');
			if($newf){             
				while(!feof($file)){                   
					fwrite($newf,fread($file,1024*8),1024*8);
				}
			}
			if($file){             
				fclose($file);
			}
			if($newf){             
				fclose($newf);
			}
		}      
	} 
	/**
     * Aliexpress标记发货
     * @param int $order_id
     */
    function orderMark($order_id,$id = NULL){
        set_time_limit(10);
        if(empty($id)) $id = $this->getSaleaccIdByOid($order_id);
        include(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
        if(time() > $longpasstime) 
        {
            throw new Exception("token已失效，请重新授权！",'610');exit();
        }
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$id,
                'longpasstime'=>$longpasstime
            ));
        }
        $orderinfo = $this->db->getValue('select paypalid,track_no,order_sn,shipping_id,ShippingService,order_status from myr_order where order_id = '.$order_id);
        
                                                                                 
        //return '订单'.CFG_ORDER_PREFIX.$orderinfo['order_sn'].'标记成功!<br/><br/><br/>';               
        $shipname  = $this->db->getValue('SELECT value,name,url from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$orderinfo['shipping_id']);
        $shiptype ='';
        
        $markUrl = $shipname['url'];
        
        if($shipname['name'] !== ''){
            $ServiceName = $shipname['name'];    
        }else{
            if($orderinfo['ShippingService'] <> ''){
                $ServiceName = $orderinfo['ShippingService'];
                if($ServiceName == 'China Post Registered Air Mail') $ServiceName = 'CPRAM';
                if($ServiceName == 'Singapore Post') $ServiceName = 'SGP';
                if($ServiceName == 'Sweden Post') $ServiceName = 'SEP';
                if($ServiceName == 'HongKong Post Air Mail') $ServiceName = 'HKPAP';
                if($ServiceName == 'Swiss Post') $ServiceName = 'CHP';
            }else{
                $arr  = $this->db->getValue('SELECT value,name,url from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$orderinfo['shipping_id']);
                if($arr['name'] == ''){
                    if($arr['value'] == 'EUB' || $shiptype == 'EUB-1') $ServiceName = 'CPAM';
                }else{
                    $ship = ModelDd::getArray('shipping');
                    $Name = $ship[$orderinfo['shipping_id']];
                    $ServiceName = 'CPAM';
                }
                $ServiceName = 'CPAM';
            }
        }
        
        if($ServiceName == 'Other'){
            if(empty($orderinfo['track_no']) ){
                 $orderinfo['track_no'] = CFG_ORDER_PREFIX.$orderinfo['order_sn'];
            }
        }
        
        $trackweb = '';
        
        if($ServiceName == 'Other'){                              
            if($markUrl == '' || $markUrl == NULL || empty($markUrl)){     
                $trackweb = 'http://www.17track.net';
            }else{   
                $trackweb = $markUrl;
            }        
        }                         
        
        $curlPost = array(
            'serviceName' => $ServiceName, 
            'logisticsNo' => $orderinfo['track_no'],
            'sendType' => 'all',
            'outRef' => $orderinfo['paypalid'],
            'trackingWebsite' => $trackweb,
            'access_token' => $access_token,
            '_aop_signature' => $this->_aop_signature('param2/1/aliexpress.open/api.sellerShipment/'.$APIDevUserID,array(
                'serviceName' => $ServiceName, 
                'logisticsNo' => $orderinfo['track_no'],
                'sendType' => 'all',
                'outRef' => $orderinfo['paypalid'],
                'trackingWebsite' => $trackweb,
                'access_token' => $access_token,
            ))
        );
                                    
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
        curl_setopt($ch, CURLOPT_URL,'http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.sellerShipment/'.$APIDevUserID);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);                                                      
        if(isset($result['error_message']) && !empty($result['error_message'])){ 
            return '订单'.CFG_ORDER_PREFIX.$orderinfo['order_sn'].'标记失败!'.'<br/>错误码:'.$result['error_code'].','.str_replace("'","",$result['error_message']).'<br/><br/><br/>';
        }
        if($result['success']){         
            $this->db->execute('update myr_order set is_mark = 1 where order_id ='.$order_id);                                                     
            return '订单'.CFG_ORDER_PREFIX.$orderinfo['order_sn'].'标记成功!<br/><br/><br/>'; 
        }                                                                                 
    }
	/**
     * 批量Aliexpress标记发货
     * @param int $order_id
     */
    function orderMarks($account_id,$status,$where=NULL){
        
        set_time_limit(360);
        
         
        $status = $this->getorderflow(6,2);
        $query = 'select order_id,userid,Sales_account_id,track_no,shipping_id from '.$this->tableName. ' where order_status in( '.$status.' )';
        $account = ModelDd::getArray('aliaccount');
        $acountlist = implode(",",array_keys($account));
        $query .= ' and Sales_account_id in ('.$account_id.') and is_mark = 0 '.$where;
        $this->db->open($query);
        $result = '';
        $i = 0;
        while ($rs = $this->db->next()) {   
        
            //修复合并订单不能标记问题    
            $combinedOrderId = $this->db->getValue("select root_id from myr_order_combined where order_id = ".$rs['order_id']);
            
            if($combinedOrderId){
                $orderinfo = $this->db->getValue('select track_no,shipping_id,ShippingService from myr_order where order_id = '.$combinedOrderId);
                $this->db->update('myr_order',array(
                    'track_no' => $orderinfo['track_no'],
                    'ShippingService' => addslashes($orderinfo['ShippingService']),
                    'shipping_id' => $orderinfo['shipping_id']
                ),'order_id = '.$rs['order_id']); 
            }                           
            $result .= $this->orderMark($rs['order_id'],$account_id);
            $i++;
        }
        return $result;
    }
	/**
	 * 获取产品列表
	 * 
	 */
	function getGoodList($page,$limit,$find_title,$id,$status){
        set_time_limit(20);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
        if(time() > $longpasstime) 
        {
            throw new Exception("token已失效，请重新授权！",'610');exit();
        }
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$id,
                'longpasstime'=>$longpasstime
            ));
        }
        $accounts = ModelDd::getArray('aliaccount');
        $countnum = 0;
        $print = '';
        $rs = array();
        $where = '';
        $code_arr = array(
            'productStatusType' => $status,
            'pageSize' => $limit,
            'currentPage' => $page,
            'access_token' => $access_token
        );
        if($find_title !== null){
            $where = '&subject='.urlencode($find_title);
            //gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.findProductInfoListQuery?productStatusType=onSelling&_aop_signature=D191163A1207DF0CEE81BDD203D58004495C67E1    
            $code_arr['subject'] = urlencode($find_title);
        }
        $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findProductInfoListQuery/'.$APIDevUserID.'?productStatusType='.$status.'&pageSize='.$limit.'&currentPage='.$page.$where.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findProductInfoListQuery/'.$APIDevUserID,$code_arr));
                
        //return var_dump($result);        
        if(!empty($result['aeopAEProductDisplayDTOList'])){
            foreach($result['aeopAEProductDisplayDTOList'] as $goods_value){
                $modtime = substr($goods_value['gmtModified'],0,4).'-'.substr($goods_value['gmtModified'],4,2).'-'.substr($goods_value['gmtModified'],6,2);
                $imgarr = explode(';',$goods_value['imageURLs']);
                $productinfo = $this->getProductInfo($goods_value['productId'],$APIDevUserID,$APIPassword,$access_token);
                
                $rs['list'][] = array(
                    'id' => $goods_value['productId'],
                    'productPrice' => $goods_value['productMinPrice'], 
                    'packageLength' => $productinfo['packageLength'],
                    'packageWidth' => $productinfo['packageWidth'],
                    'packageHeight' => $productinfo['packageHeight'],
                    'grossWeight' => $productinfo['grossWeight'],
                    
                    'goods_img' => $imgarr[0],
                    'goods_name' => addslashes($goods_value['subject']),
                    'account_name' => $accounts[$id],
                    'account_id' => $id,
                    'skuCode' => $productinfo['skuCode'],
                    'goods_status' => $this->ChangeAliStatus($status),
                    'bulkOrder' => $productinfo['bulkOrder'],
                    'bulkDiscount' => $productinfo['bulkDiscount'],
                    'Propertys_qty' => $productinfo['Propertys_qty'],
                    'SKUs_qty' => $productinfo['SKUs_qty'], 
                    'ProductViewed' => $productinfo['ProductViewed'], 
                    'SalesInfo' => $productinfo['SalesInfo']
                );     
            }
            $rs['total'] = $result['productCount'];
            return $rs;
        } 
	}
    /**
     * 获取单个产品信息
     * @param int $product_id
     */
    function getProductInfo($product_id,$APIDevUserID,$APIPassword,$access_token){
        $newgoodinfo = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$product_id.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID,array(
                    'productId' => $product_id,
                    'access_token' => $access_token
                )));
        //return var_dump($this->getProductViewed($product_id,$APIDevUserID,$APIPassword,$access_token));
        return array( 
        'skuCode' =>  $newgoodinfo['aeopAeProductSKUs'][0]['skuCode'], 
        'packageType' => $newgoodinfo['lotNum']>1?1:0,
        'lotNum' => $newgoodinfo['lotNum'],
        'wsValidNum' => $newgoodinfo['wsValidNum'],
        'packageLength' => $newgoodinfo['packageLength'],
        'packageWidth' => $newgoodinfo['packageWidth'],
        'packageHeight' =>  $newgoodinfo['packageHeight'],
        'grossWeight' =>  $newgoodinfo['grossWeight'],
        'productUnit' => $newgoodinfo['productUnit'],
        'freightTemplateId' => $newgoodinfo['freightTemplateId'],
        'isImageDynamic' => $newgoodinfo['isImageDynamic'],
        'bulkOrder' => $newgoodinfo['bulkOrder'],
        'bulkDiscount' => $newgoodinfo['bulkDiscount'],
        'Propertys_qty' => count($newgoodinfo['aeopAeProductPropertys']),
        'SKUs_qty' => count($newgoodinfo['aeopAeProductSKUs']), 
        'ProductViewed' => /*$this->getProductViewed($product_id,$APIDevUserID,$APIPassword,$access_token)*/0, 
        'SalesInfo' => /*$this->getProductSaleed($product_id,$APIDevUserID,$APIPassword,$access_token)*/0
        ); 
    }
    
    /**
     * 获取产品销量
     * @param string $where
     */
    function getProductSaleed($product_id,$APIDevUserID,$APIPassword,$access_token,$startdate=null,$enddate=null,$page=1,$size=50){
       
        /* 默认一个月 */
        if($startdate==null){
            $startdate = date("Y-m-d",mktime(0,0,0,date("m")-1,date("d"),date("Y")));   
        }
        if($enddate==null){
            $enddate = date("Y-m-d",time());
        }
        $code_arr = array(
            'productId' => $product_id,
            'startDate' => $startdate,
            'endDate' => $enddate,
            'currentPage' => $page,
            'pageSize' => $limit,
            'access_token' => $access_token
        );
        ksort($code_arr);
        foreach ($code_arr as $key=>$val){
            $sign_str .= $key . $val;
        }
        $code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, $APIPassword, true)));//$code_sign = 签名
        
        $sign_str = 'param2/1/aliexpress.open/api.queryProductSalesInfoEverydayById/'.$APIDevUserID.$sign_str;
        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryProductSalesInfoEverydayById/'.$APIDevUserID.'?productId='.$product_id.'&pageSize='.$limit.'&startDate='.$startdate.'&endDate='.$enddate.'&currentPage='.$page.'&access_token='.$access_token.'&_aop_signature='.$code_sign);
        $sum = 0;
        if($result['success']){
            for($i = 0; $i < count($result['itemList']); $i++) {
                $sum = $sum+intval($result['itemList'][$i]['count']);
            }    
        }
        return $sum;                
    }
    /**
     * 获取产品浏览量
     * @param string $where
     */
    function getProductViewed($product_id,$APIDevUserID,$APIPassword,$access_token,$startdate=null,$enddate=null,$page=1,$limit=50){
        
        /* 默认一个月 */
        if($startdate==null){
            $startdate = date("Y-m-d",mktime(0,0,0,date("m")-1,date("d"),date("Y")));   
        }
        if($enddate==null){
            $enddate = date("Y-m-d",time());
        }
        $code_arr = array(
            'productId' => $product_id,
            'startDate' => $startdate,
            'endDate' => $enddate,
            'currentPage' => $page,
            'pageSize' => $limit,
            'access_token' => $access_token
        );
        ksort($code_arr);
        foreach ($code_arr as $key=>$val){
            $sign_str .= $key . $val;
        }
        $sign_str = 'param2/1/aliexpress.open/api.queryProductViewedInfoEverydayById/'.$APIDevUserID.$sign_str;
        $code_sign = strtoupper(bin2hex(hash_hmac("sha1", $sign_str, $APIPassword, true)));//$code_sign = 签名
        
        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryProductViewedInfoEverydayById/'.$APIDevUserID.'?productId='.$product_id.'&pageSize='.$limit.'&startDate='.$startdate.'&endDate='.$enddate.'&currentPage='.$page.'&access_token='.$access_token.'&_aop_signature='.$code_sign);
        $sum = 0;
        $result = json_decode($result);
        if($result->success){
            foreach($result->itemList as $v){
                $sum += $v->count;    
            } 
        }
        return $sum;        
    }
    
    
	/**
	 * 获取产品条数
	 * @param string $where
	 */
	function getCount($where=NULL){
		return $this->db->getValue('select count(id) from '.CFG_DB_PREFIX.'aligoods '.$where);
	}
	/**
	 * 生成查询条件
	 * @param array $info
	 */
	function getWhere($info){
		specConvert($info,array('status','account','goods_sn'));
		$wheres = array();
        if($info['status'] <> 5){
           $wheres[] = 'status='.$info['status'];  
        }
		
		if($info['account'] != 0){
			$wheres[] = 'account_id=\''.$info['account'].'\'';
		}
		if($info['cat_id']){
			$wheres[] = 'categoryId=\''.$info['cat_id'].'\'';
		}
		if($info['goods_sn']){
            $wherearr = explode(' ',$info['goods_sn']);
            if(count($wherearr) >1 ){
                $wheres[] = '(skuCode like \'%'.$wherearr[0].'%\' and skuCode like \'%'.$wherearr[1].'%\' or goods_name like \'%'.$wherearr[0].'%\' and goods_name like \'%'.$wherearr[1].'%\' or keyword like \'%'.$wherearr[0].'%\' and keyword like \'%'.$wherearr[1].'%\')';
            
            }else{
                $wheres[] = '(skuCode like \'%'.$info['goods_sn'].'%\' or goods_name like \'%'.$info['goods_sn'].'%\' or keyword like \'%'.$info['goods_sn'].'%\')';
            }
            
            
		}
		
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	 * 根据订单id获取销售帐号id
	 * @param int $id
	 *
	 */
	function getSaleaccIdByOid($id){
		return $this->db->getValue('select Sales_account_id from '.CFG_DB_PREFIX.'order where order_id = '.$id);
	}
	/**
	 * 更新listing
	 * @param array $info
	 * @param int $id
	 *
	 */
	function updateListing($info,$id,$type){
		set_time_limit(60);
		include(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$id,
				'longpasstime'=>$longpasstime
			));
		}
		$good_info = $this->db->getValue('select * from '.CFG_DB_PREFIX.'aligoods where id = '.$info->id);
		$childList = $this->db->select('select * from myr_aligood_child where ali_good_id='.$good_info['ali_good_id']);
		if(count($childList) > 1){
			$SkuSTRING  = '[';
				for($i = 0; $i < count($childList); $i++){
					if($i <> count($childList) && $i <> 0) $SkuSTRING .= ',';
					if($childList[$i]['skuStock']==1) $stock = 'true'; else $stock = 'false';
					$SkuSTRING .= '{"skuPrice":"'.sprintf("%01.2f",$childList[$i]['skuPrice']).'",';
					$SkuSTRING .= '"skuStock":'.$stock.',';
					$SkuSTRING .= '"aeopSKUProperty":'.$childList[$i]['aeopSKUProperty'].',';
					$SkuSTRING .= '"skuCode":"'.$childList[$i]['skuCode'].'"}';
				}
				$SkuSTRING .= ']';
		}elseif(count($childList) == 1){
			if($type=='import'){
				$price = sprintf("%01.2f",$info->productPrice + $info->revisePrice);
				if($childList[0]['skuStock']==1) $stock = 'true'; else $stock = 'false';
				$SkuSTRING  = '[';
				$SkuSTRING .= '{"skuPrice":"'.$price.'",';
				$SkuSTRING .= '"skuStock":'.$stock.',';
				$SkuSTRING .= '"aeopSKUProperty":'.$childList[0]['aeopSKUProperty'].',';
				$SkuSTRING .= '"skuCode":"'.$childList[0]['skuCode'].'"}';
				$SkuSTRING .= ']';
			}
			if($type=='save'){
				$SkuSTRING = $good_info['aeopAeProductSKUs'];
			}
			if($type=='update'){
				$price = sprintf("%01.2f",$info->productPrice);
				if($childList[0]['skuStock']==1) $stock = 'true'; else $stock = 'false';
				$SkuSTRING  = '[';
				$SkuSTRING .= '{"skuPrice":"'.$price.'",';
				$SkuSTRING .= '"skuStock":'.$stock.',';
				$SkuSTRING .= '"aeopSKUProperty":'.$childList[0]['aeopSKUProperty'].',';
				$SkuSTRING .= '"skuCode":"'.$childList[0]['skuCode'].'"}';
				$SkuSTRING .= ']';
			}
		}else{
			return '子产品为空';
		}
		//sku为空的状态
		$curlPost = array(
			'productId' => $good_info['ali_good_id'], 
			'detail' => $good_info['detail'],
			'deliveryTime' => $good_info['deliveryTime'],
			'categoryId' => $good_info['categoryId'],
			'subject' => $good_info['goods_name'],
			'keyword' => $good_info['keyword'],
			'aeopAeProductSKUs' => str_replace('"',"'",$SkuSTRING),
			'freightTemplateId' => $good_info['freightTemplateId'],
			'productPrice' => $good_info['productPrice'],
			'productUnit' => $good_info['productUnit'],
			'packageLength' => floor($good_info['packageLength']),
			'packageWidth' => floor($good_info['packageWidth']),
			'packageHeight' => floor($good_info['packageHeight']),
			'grossWeight' => $good_info['grossWeight'],
			'wsValidNum' => $good_info['wsValidNum'],
			'groupId' => $good_info['groupId'],
			'isImageDynamic' => $good_info['isImageDynamic']==1 ? 'true':'false',
			'aeopAeProductPropertys' => str_replace('"',"'",$good_info['aeopAeProductPropertys']),
			'imageURLs' => $good_info['imageURLs'],
			'isImageWatermark' => 'false',
			'isPackSell' => 'false',
			'packageType' => $info->lotNum > 1 ? 'true' : 'false',
			'lotNum' => $info->lotNum,
			'access_token' => $access_token
		);
		if($info->bulkOrder>1){
			$curlPost['bulkOrder'] = $info->bulkOrder;
			$curlPost['bulkDiscount'] = $info->bulkDiscount;
		}
		try {
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
			curl_setopt($ch, CURLOPT_URL,'http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.editAeProduct/'.$APIDevUserID);
			curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
			$re=curl_exec($ch);
			curl_close($ch);
			$result=json_decode($re,true);
		} catch (Exception $e) {
				return $e->getMessage(); exit;
		}
		//return var_dump($result);
		if(isset($result['error_message']) && !empty($result['error_message'])){
			return '更新'.$good_info['skuCode'].'出错!'.$this->updateerrorcode2notice($result['error_code'],$result).'<br/>';
		}
		if($result['success']){
			$newgoodinfo = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$result['productId'].'&access_token='.$access_token);
			$this->db->execute('delete from '.CFG_DB_PREFIX.'aligood_child where ali_good_id='.$newgoodinfo['productId']);
			$imgarr = explode(';',$newgoodinfo['imageURLs']);
			$this->db->update(CFG_DB_PREFIX.'aligoods',array(
					'last_update_time' => CFG_TIME,
					'deliveryTime' => $newgoodinfo['deliveryTime'],
					'categoryId' => $newgoodinfo['categoryId'],
					'aeopAeProductSKUs' => json_encode($newgoodinfo['aeopAeProductSKUs']),
					'skuCode' => $newgoodinfo['aeopAeProductSKUs'][0]['skuCode'],
					'keyword' => addslashes($newgoodinfo['keyword']),
					'productMoreKeywords1' => addslashes($newgoodinfo['productMoreKeywords1']),
					'productMoreKeywords2' => addslashes($newgoodinfo['productMoreKeywords2']),
					'productPrice' => $newgoodinfo['aeopAeProductSKUs'][0]['skuPrice'],
					'productUnit' => $newgoodinfo['productUnit'],
					'freightTemplateId' => $newgoodinfo['freightTemplateId'],
					'isImageDynamic' => $newgoodinfo['isImageDynamic'],
					'is_upload' => 0,
					'packageType' => $newgoodinfo['lotNum']>1?1:0,
					'lotNum' => $newgoodinfo['lotNum'],
					'ali_good_id' => $newgoodinfo['productId'],
					'aeopAeProductPropertys' => addslashes(json_encode($newgoodinfo['aeopAeProductPropertys'])),
					'goods_status' => $newgoodinfo['productStatusType'],
					'ownerMemberId' => $newgoodinfo['ownerMemberId'],
					'wsOfflineDate' => $newgoodinfo['wsOfflineDate'],
					'wsDisplay' => $newgoodinfo['wsDisplay'],
					'wsValidNum' => $newgoodinfo['wsValidNum'],
					'goods_name' => addslashes($newgoodinfo['subject']),
					'groupId' => $newgoodinfo['groupId'],
					'bulkOrder' => $newgoodinfo['bulkOrder'],
					'bulkDiscount' => $newgoodinfo['bulkDiscount'],
					'goods_img' => $newgoodinfo['isImageDynamic'] == 0 ? $newgoodinfo['imageURLs'] : $imgarr[0],
					'imageURLs' =>  $newgoodinfo['imageURLs'],
					'packageLength' => $newgoodinfo['packageLength'],
					'packageWidth' => $newgoodinfo['packageWidth'],
					'packageHeight' =>  $newgoodinfo['packageHeight'],
					'grossWeight' =>  $newgoodinfo['grossWeight'],
					'detail' =>  addslashes($newgoodinfo['detail']),
					'account_id' => $id,
				),'ali_good_id = '.$result['productId']);
			$is_child = count($newgoodinfo['aeopAeProductSKUs']);
			for($j=0; $j < $is_child; $j++){
				$this->db->insert(CFG_DB_PREFIX."aligood_child",array(
					'ali_good_id'=>$newgoodinfo['productId'],
					'aeopSKUProperty'=>json_encode($newgoodinfo['aeopAeProductSKUs'][$j]['aeopSKUProperty']),
					'skuPrice'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuPrice'],
					'skuStock'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuStock'],
					'skuCode'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuCode'],
					'account_id' => $id,
				));
			}
			$rs = $good_info['skuCode'].'更新上传成功;<br>';
		}
		return $rs;
	}
	function updatePrice($info){
		if(!$info['account_id']) return '请选择要更改的账号!';
		try {
			$childlist = $this->db->select('select ac.id,ac.skuPrice,ac.ali_good_id,ac.aeopSKUProperty,ac.skuStock,ac.skuCode from '.CFG_DB_PREFIX.'aligood_child as ac left join myr_aligoods as a on ac.ali_good_id = a.ali_good_id where a.id='.$info['id']);
			$good_info = $this->db->getValue('select productPrice,aeopAeProductSKUs,lotNum,bulkOrder,bulkDiscount from '.CFG_DB_PREFIX.'aligoods where id = '.$info['id']);
			if(count($childlist)>1){
				//有多个子产品的
				foreach($childlist as $value){
					$price = $value['skuPrice']+$info['price'];
					$this->db->execute('UPDATE myr_aligood_child SET skuPrice= '.$price.' WHERE id = '.$value['id']);
				}
				$updateinfo = new StdClass;
				$updateinfo->id = $info['id'];
				$updateinfo->lotNum = $good_info['lotNum'];
				$updateinfo->bulkOrder = $good_info['bulkOrder'];
				$updateinfo->bulkDiscount = $good_info['bulkDiscount'];
				try {
						$msg = $this->updateListing($updateinfo,$info['account_id'],'update');
						return $msg;
					} catch (Exception $e) {
							echo "{success:false,msg:'".$e->getMessage()."'}";exit;
					}	
			}else{
				$updateinfo   = new StdClass;
				$updateinfo->id = $info['id'];
				$updateinfo->lotNum = $good_info['lotNum'];
				$updateinfo->bulkOrder = $good_info['bulkOrder'];
				$updateinfo->bulkDiscount = $good_info['bulkDiscount'];
				$price = $childlist[0]['skuPrice']+$info['price'];
				$updateinfo->productPrice = $price;
				try {
						$msg = $this->updateListing($updateinfo,$info['account_id'],'update');
						return $msg;
					} catch (Exception $e) {
							echo "{success:false,msg:'".$e->getMessage()."'}";exit;
					}	
			}
		} catch (Exception $e) {
			throw new Exception($e->getMessage(),'999');exit();
		}
	}
	function getAliWhere($info){
		specConvert($info,array('status','account','goods_sn'));
		$wheres = array();
		if($info['status'] != 0){
			if($info['status'] == 1) $wheres[] = 'goods_status=\'onSelling\'';
			if($info['status'] == 2) $wheres[] = 'goods_status=\'offline\'';
			if($info['status'] == 3) $wheres[] = 'goods_status=\'auditing\'';
			if($info['status'] == 4) $wheres[] = 'goods_status=\'editingRequired\'';
		}
		if($info['account'] != 0){
			$wheres[] = 'account_id=\''.$info['account'].'\'';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	 * 获取导出产品列表
	 */
	function getExportGoods($from,$to,$where=NULL,$sort=NULL){
		if($sort){
			$sort = str_replace(","," ",$sort);
		}else{
			$sort = 'id asc';
		}
		$this->db->open('select * from '.CFG_DB_PREFIX.'aligoods  '.$where.' order by '.$sort,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			/*$childs = $this->db->getValue('select count(ali_good_id) from '.CFG_DB_PREFIX.'aligood_child where ali_good_id='.$rs['ali_good_id']);
			if($childs > 1){
				$rs['is_child'] = $childs;
			}else{
				$rs['is_child'] = 0;
			}*/
			$rs['goods_status'] = $this->ChangeAliStatus($rs['goods_status']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
     * 错误编码转换
     *
     * @param int $code
     * @param array $info
     * @return string
     */
    function updateerrorcode2notice($code){
        switch(intval($code))
        {
            case 13001029:
            return '该商品不能编辑，可能处于审核中';
            case 13002005:
            return 'SKU属性顺序错误     sku属性是有顺序的，请按类目sku属性的顺序放置。';
            case 13001032:
            return '没有加入假一赔三服务，不能发布该类目';
            case 13001007:
            return '类目不是叶子类目';
            case 13001008:
            return '类目不存在';
            case 13200061:
            return '商品标题含有中文字符';
            case 13200062:
            return '商品标题含有非ascii码字符';
            case 13200063:
            return '商品标题为空';
            case 13200064:
            return '商品标题长度不在1-128之间';
            case 13200071:
            return '搜索关键词为空';
            case 13200072:
            return '搜索关键词含有中文字符';
            case 13200073:
            return '搜索关键词含有非ascii码字符';
            case 13200074:
            return '搜索关键词长度不在0-50之间';
            case 13001004:
            return '搜索关键词以及多关键词含有分号或者逗号';
            case 13001005:
            return 'keyword+productMoreKeywords1 +productMoreKeywords2总长度超过255';
            case 13200081:
            return 'productMoreKeywords1含有中文字符';
            case 13200082:
            return 'productMoreKeywords1含有非ascii码字符';
            case 13200083:
            return 'productMoreKeywords1长度不在0-50之间';
            case 13200091:
            return 'productMoreKeywords2含有中文字符';
            case 13200092:
            return 'productMoreKeywords2含有中文字符';
            case 13200093:
            return 'productMoreKeywords2长度不在0-50之间';
            case 13200111:
            return '简要描述含有中文字符';
            case 13200112:
            return '简要描述含有非ascii码字符';
            case 13200113:
            return '简要描述含有email或者http网址';
            case 13200114:
            return '简要描述长度不在0-128之间';
            case 13001022:
            return '一口价为空，或者取值范围不在0-100000美元';
            case 13001013:
            return '取值范围不在1-60天';
            case 13200051:
            return '运费模版ID为空';
            case 13001002:     
            return '对应的运费模板不存在; 包装毛重grossWeight>2';     
            case 13001003:     
            return '如果包装毛重grossWeight>2,但运费模板中不含有除CPAM,GELS,HKPAM,EMS_SH_ZX_US以外任何物流公司';     
            case 13001021:     
            return 'bulkOrder和bulkDiscount须同时有值或无值';     
            case 13001015:     
            return '批发最小数量取值范围不在2-100000区间';     
            case 13001014:     
            return '批发折扣不在1-99区间';     
            case 13001016:     
            return '产品组id该公司下不存在';     
            case 13201011:     
            return '商品类目属性为空';     
            case 13004013:     
            return 'aeProductPropertys.attrNameId被判定为失效的属性ID,';     
            case 13004007:     
            return 'aeProductPropertys.attrNameId无效属性';     
            case 13201021:     
            return 'aeProductPropertys.attrName含有中文字符;';     
            case 13201022:     
            return 'aeProductPropertys.attrName含有非ascii码字符';     
            case 13201023:     
            return 'aeProductPropertys.attrName长度不在0-128之间';     
            case 13201031:     
            return 'aeProductPropertys.attrValue含有中文字符';     
            case 13201032:     
            return 'aeProductPropertys.attrValue含有非ascii码字符';     
            case 13201033:     
            return 'aeProductPropertys.attrValue长度不在0-128之间'; 
            case 13004014:         
            return '无效用户自定义属性';     
            case 13201001:         
            return 'detail内容为空';     
            case 13201002:         
            return 'detail含有中文字符';     
            case 13201003:         
            return '含有email信息、或者图片img src非alibaba.com或者aliimg.com';     
            case 13003001:         
            return '含有站内非本公司图片URL(即认为盗图)';
            case 13001011:        
            return '多图产品主图url size不能小于2且大于6，单图产品主图url size必须是1';     
            case 13001017:         
            return '主图url不符合要求';
            case 13001018:        
            return 'url地址图片不存在（图片必须是自己公司的本网站图片）';
            case 13001019:         
            return 'url地址图片不存在（图片必须是自己公司的本网站图片）';     
            case 13202001:         
            return '商品单位为空';
            case 13004011:         
            return '商品单位编号不正确';     
            case 13004001:         
            return 'lotNum为空。 打包销售，lotNum<=1,非打包销售,lotNum!=1';     
            case 13004003:         
            return 'packageLength为空；不在取值范围:1-270';     
            case 13004005:         
            return '产品包装尺寸的最大值+2×（第二大值+第三大值）不能超过419厘米.';     
            case 13004004:         
            return 'packageWidth不在取值范围:1-270';     
            case 13004002:         
            return 'packageHeight为空；不在取值范围:1-270';    
            case 13202021:         
            return 'grossWeight为空';    
            case 13004006:         
            return 'grossWeight不在取值范围:0.001-70.000 ';    
            case 13004009:         
            return 'sPackSell为true,baseUnit为空;baseUnit不在值范围1-1000';     
            case 13004008:         
            return 'sPackSell为true,addUnit为空;addUnit不在值范围1-1000';     
            case 13004009:         
            return 'sPackSell为true,addWeight为空;addWeight不在值范围0.001-70.000 ';    
            case 13205001:         
            return 'wsValidNum为空';     
            case 13205002:         
            return 'wsValidNum不在取值范围:1-30';     
            case 13002006:         
            return 'aeopAeProductSKUs不能为空，且不能大于3';     
            case 13002014:         
            return 'aeopAeProductSKUs对象未按照类目定义顺序。';     
            case 13002017:         
            return 'aeopAeProductSKUs.size不符合sku属性要求。';     
            case 13002022:         
            return 'skuPrice为空，不在1～10000000美分之间 ';    
            case 13002015:         
            return '所有的sku数据Stock都无库存';     
            case 13002013:         
            return '商家编码格式不符合要求。';     
            case 13002007:         
            return 'skuPropertyId为null ';    
            case 13002003:         
            return 'skuPropertyId为不属于该类目的属性。';     
            case 13002008:         
            return 'propertyValueId为null';     
            case 13002004:         
            return 'propertyValueId不属于对应属性下的属性值 ';    
            case 13002009:         
            return 'propertyValueDefinitionName不为空，但类目属性不允许自定义名称';     
            case 13002011:         
            return 'propertyValueDefinitionName不为空，类目属性允许自定义名称，但自定义名称不符合规则 ';    
            case 13002010:         
            return 'skuImage不为空，但类目属性不允许自定义图片';     
            case 13002012:         
            return 'skuImage不为空，类目属性允许自定义图片，但自定义图片不符合规则';     
            case 13001024:         
            return '产品不存在。';     
            case 13001025:         
            return '没有权限操作该产品。';     
            case 13001028:         
            return '产品图片不存在。';     
            case 13001028:         
            return '该产品不能编辑。';     
            case 13001030:         
            return '该产品在活动中，不能操作。';     
            case 13005001:         
            return '用户没有进行实名认证。';     
            case 13005002:         
            return '用户没有设置收款帐号。';     
            case 13005003:         
            return '用户被网规，限制操作产品。';     
            case 13005004:         
            return '超过动态图片产品最大发布限制数据。';     
            case 13004017:         
            return '系统属性过长。适当减少系统属性。';
            case 13004018:         
            return '自定义属性过长。适当减少自定义属性。';
            case 13001028:         
            return '主图不存在。';     
            case 13003003:         
            return 'detail内容为空，或者包含危险标签代码。';     
            case 13004016:         
            return '必填系统属性未填写。';     
            case 13004015:         
            return '存在空类目属性或重复类目属性。';
            case 10029999:         
            return '系统错误（也可能非法、不错在的产品id）。';     
            case 10024000:         
            return '所查询的产品不存在。';     
            case 10020996:         
            return '输入参数不正确。';     
            case 10020011:         
            return '产品不存在。';
            case '07201003':         
            return '详细描述，您填写的内容包含电子邮件地址或网站的信息。。';
            case '07003001':         
            return '含有站内非本公司图片URL(即认为盗图)';
            case '07004016':         
            return '有必填系统属性未填写。';
            case '07004015':         
            return '存在空类目属性或重复类目属性';
            case '07004013':         
            return 'aeProductPropertys.attrNameId被判定为失效的属性ID';
            case '07200061':         
            return '商品标题含有中文字符';
            case '07200072':         
            return '搜索关键词含有中文字符; ';
            case '07002002':         
            return '必填sku属性未填 ';
            case '07200021':         
            return '备货期deliveryTime不能为空 ';
            case '07002005':         
            return 'SKU记录属性顺序错误     sku属性是有顺序的，请按类目sku属性的顺序放置。 ';
            case '07001032':         
            return '没有加入假一赔三服务，不能发布该类目';
            case '07200101':         
            return '类目ID为空 ';
            case '07001007':         
            return '类目不是叶子类目 ';
            case '07001008':         
            return '类目不存在 ';
            case '07200061':         
            return '商品标题含有中文字符 ';
            case '07200062':         
            return '商品标题含有非ascii码字符 ';
            case '07200063':         
            return '商品标题为空 ';
            case '07200064':         
            return '商品标题长度不在1-128之间 ';
            case '07200071':         
            return '搜索关键词为空 ';
            case '07200072':         
            return '搜索关键词含有中文字符 ';
            case '07200073':         
            return '搜索关键词含有非ascii码字符 ';
            case '07200074':         
            return '搜索关键词长度不在0-50之间 ';
            case '07001004':         
            return '搜索关键词以及多关键词含有分号或者逗号 ';
            case '07001005':         
            return 'keyword+productMoreKeywords1 +productMoreKeywords2总长度超过255 ';
            case '07200081':         
            return 'productMoreKeywords1含有中文字符 ';
            case '07200082':         
            return 'productMoreKeywords1含有非ascii码字符 ';
            case '07200083':         
            return 'productMoreKeywords1长度不在0-50之间 ';
            case '07200091':         
            return 'productMoreKeywords2含有中文字符 ';
            case '07200092':         
            return 'productMoreKeywords2含有中文字符 ';
            case '07200093':         
            return 'productMoreKeywords2长度不在0-50之间 ';
            case '07200111':         
            return '简要描述含有中文字符 ';
            case '07200112':         
            return '简要描述含有非ascii码字符 ';
            case '07200113':         
            return '简要描述含有email或者http网址 ';
            case '07200114':         
            return '简要描述长度不在0-128之间 ';
            case '07001022':         
            return '一口价为空，或者取值范围不在0-100000美元 ';
            case '07001013':         
            return '取值范围不在1-60天 ';
            case '07200051':         
            return '运费模版ID为空 ';
            case '07001002':         
            return '对应的运费模板不存在; 包装毛重grossWeight>2 ';
            case '07001003':         
            return '如果包装毛重grossWeight>2,但运费模板中不含有除CPAM,GELS,HKPAM,EMS_SH_ZX_US以外任何物流公司 ';
            case '07001021':         
            return 'bulkOrder和bulkDiscount须同时有值或无值 ';
            case '07001015':         
            return '批发最小数量取值范围不在2-100000区间 ';
            case '7001014':         
            return '批发折扣不在1-99区间';
            case '7001016':         
            return '产品组id该公司下不存在';
            case '07201011':         
            return '商品类目属性为空';
            case '07004013':         
            return 'aeProductPropertys.attrNameId被判定为失效的属性ID, ';
            case '07004007':         
            return 'aeProductPropertys.attrNameId无效属性';
            case '07201021':         
            return 'aeProductPropertys.attrName含有中文字符;';
            case '07201022':         
            return 'aeProductPropertys.attrName含有非ascii码字符 ';
            case '07201023':         
            return 'aeProductPropertys.attrName长度不在0-128之间';
            case '07201031':         
            return 'aeProductPropertys.attrValue含有中文字符 ';
            case '07201032':         
            return 'aeProductPropertys.attrValue含有非ascii码字符 ';
            case '07201033':         
            return 'aeProductPropertys.attrValue长度不在0-128之间';
            case '07004014':         
            return '无效用户自定义属性';
            case '07201001/07200001':         
            return 'detail内容为空';
            case '07201002':         
            return 'detail含有中文字符 ';
            case '07201003':         
            return '含有email信息、或者图片img src非alibaba.com或者aliimg.com';
            case '07003001':         
            return '含有站内非本公司图片URL(即认为盗图) ';
            case '07001011':         
            return '多图产品主图url size不能小于2且大于6，单图产品主图url必须时1';
            case '07001017':         
            return '主图url不符合要求。';
            case '07001018/07001019':         
            return 'url地址图片不存在（图片必须是自己公司的本网站图片）';
            case '07202001':         
            return '商品单位为空';
            case '07004011':         
            return '商品单位编号不正确';
            case '07004001':         
            return 'lotNum为空。 打包销售，lotNum<=1,非打包销售,lotNum!=1 ';
            case '07004003':         
            return 'packageLength为空；不在取值范围:1-270 ';
            case '07004005':         
            return '产品包装尺寸的最大值+2×（第二大值+第三大值）不能超过419厘米. ';
            case '07004004':         
            return 'packageWidth不在取值范围:1-270';
            case '07004002':         
            return 'packageHeight为空；不在取值范围:1-270  ';
            case '07202021':         
            return 'grossWeight为空；';
            case '07004006':         
            return 'grossWeight不在取值范围:0.001-70.000 ';
            case '07004009':         
            return 'sPackSell为true,baseUnit为空;baseUnit不在值范围1-1000 ';
            case '07004008':         
            return 'sPackSell为true,addUnit为空;addUnit不在值范围1-1000';
            case '07004009':         
            return 'sPackSell为true,addWeight为空;addWeight不在值范围0.001-70.000';
            case '07205001':         
            return 'wsValidNum为空';
            case '07205002':         
            return 'wsValidNum不在取值范围:1-30';
            case '07002006':         
            return 'aeopAeProductSKUs不能为空，且不能大于3';
            case '07002014':         
            return 'aeopAeProductSKUs对象未按照类目定义顺序。';
            case '07002017':         
            return 'aeopAeProductSKUs.size不符合sku属性要求。';
            case '07002001':         
            return 'skuPrice为空，不在1～10000000美分之间';
            case '07002015':         
            return '所有的sku数据Stock都无库存';
            case '07002013':         
            return '商家编码格式不符合要求 ';
            case '07002007':         
            return 'skuPropertyId为null';
            case '07002003':         
            return 'skuPropertyId为不属于该类目的属性。 ';
            case '07002008':         
            return 'propertyValueId为null ';
            case '07002004':         
            return 'propertyValueId不属于对应属性下的属性值';
            case '07002009':         
            return 'propertyValueDefinitionName不为空，但类目属性不允许自定义名称';
            case '07002011':         
            return 'propertyValueDefinitionName不为空，类目属性允许自定义名称，但自定义名称不符合规则';
            case '07002010':         
            return 'skuImage不为空，但类目属性不允许自定义图片  ';
            case '07002012':         
            return 'skuImage不为空，类目属性允许自定义图片，但自定义图片不符合规则 ';
            case '07005001':         
            return '用户没有进行实名认证。';
            case '07005002':         
            return '用户没有设置收款帐号。';
            case '07005003':         
            return '用户被网规，限制操作产品。';
            case '07005004':         
            return '超过动态图片产品最大发布限制数据。';
            case '07004017':         
            return '系统属性过长。     适当减少系统属性。';
            case '07004018':         
            return '自定义属性过长。     适当减少自定义属性。 ';
            case '07001028':         
            return '主图不存在。';
            case '07003003':         
            return 'detail内容为空，或者包含危险标签代码。';
            case '07004016':         
            return '有必填系统属性未填写。';
            case '07004015':         
            return '存在空类目属性或重复类目属性。';
            case 9001:         
            return '参数错误。';
            case 9002:         
            return '卖家主账号值校验不成功。';
            case 9005:         
            return '发送者ID校验不成功。';
            case 9006:         
            return '接收者ID校验不成功';
            case 9012:         
            return '内容校验不成功。';
            case 9013:         
            return '内容不能含有html。';
            case 9014:         
            return '内容超出长度大小限制。';
            case 9015:         
            return '内容不能包含中文(但可以包含中文标点)。';
            case 9017:         
            return '不能给自已发站内信。';
            case 9018:         
            return '发送者不存在。';
            case 9019:         
            return '接收者不存在。';
            case 9021:         
            return '查询产品信息时无此产品。';
            case 9027:         
            return '参数不匹配。';
            case 9028:         
            return '搜索关键字不符合规范要求!';
            case '9029':         
            return '搜索引擎异常。';
            case '9029':         
            return '搜索引擎异常。';
            case '9030':         
            return '当前登录者账号不存在!';
            case '9031':         
            return '你没有权限对此订单进行留言!';
            case '9032':         
            return '该订单不存在!';
            case '9033':         
            return '买家账号不存在!';
            case '9034':         
            return '发送量过于频繁！';
            case '9035':         
            return '你没有权限对此用户发送站内信！';
            default:
            return '错误码:'.$code;
        }
    }
	function getIdById($id){
		$re = $this->db->getValue('select ali_good_id from '.CFG_DB_PREFIX.'aligoods where id = '.$id);
        
        if(!$re){
            return '无法匹配';
        }
        
	}
	function getChild($id){
		return $this->db->select('select * from myr_aligood_child where ali_good_id='.$id);
	}
	function updateChildPrice($price,$id){
		$this->db->execute('UPDATE myr_aligood_child SET skuPrice= '.$price.' WHERE id = '.$id);
	}
	function reloadgood($id,$accountid){
		if(!$accountid) return '请选择要更改的账号!';
		set_time_limit(300);
		include(CFG_PATH_DATA . 'ebay/ali_' . $accountid .'.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$good_info = $this->db->getValue('select ali_good_id from '.CFG_DB_PREFIX.'aligoods where id = '.$id);
		//return $good_info;
		$childList = $this->db->select('select * from myr_aligood_child where ali_good_id='.$good_info);
		$newgoodinfo = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$good_info.'&access_token='.$access_token);
		$this->db->execute('delete from '.CFG_DB_PREFIX.'aligood_child where ali_good_id='.$newgoodinfo['productId']);
		$imgarr = explode(';',$newgoodinfo['imageURLs']);
		$this->db->update(CFG_DB_PREFIX.'aligoods',array(
				'last_update_time' => CFG_TIME,
				'deliveryTime' => $newgoodinfo['deliveryTime'],
				'categoryId' => $newgoodinfo['categoryId'],
				'aeopAeProductSKUs' => json_encode($newgoodinfo['aeopAeProductSKUs']),
				'skuCode' => $newgoodinfo['aeopAeProductSKUs'][0]['skuCode'],
				'keyword' => addslashes($newgoodinfo['keyword']),
				'productMoreKeywords1' => addslashes($newgoodinfo['productMoreKeywords1']),
				'productMoreKeywords2' => addslashes($newgoodinfo['productMoreKeywords2']),
				'productPrice' => $newgoodinfo['aeopAeProductSKUs'][0]['skuPrice'],
				'productUnit' => $newgoodinfo['productUnit'],
				'freightTemplateId' => $newgoodinfo['freightTemplateId'],
				'isImageDynamic' => $newgoodinfo['isImageDynamic'],
				'is_upload' => 0,
				'packageType' => $newgoodinfo['lotNum']>1?1:0,
				'lotNum' => $newgoodinfo['lotNum'],
				'ali_good_id' => $newgoodinfo['productId'],
				'aeopAeProductPropertys' => addslashes(json_encode($newgoodinfo['aeopAeProductPropertys'])),
				'goods_status' => $newgoodinfo['productStatusType'],
				'ownerMemberId' => $newgoodinfo['ownerMemberId'],
				'wsOfflineDate' => $newgoodinfo['wsOfflineDate'],
				'wsDisplay' => $newgoodinfo['wsDisplay'],
				'wsValidNum' => $newgoodinfo['wsValidNum'],
				'goods_name' => addslashes($newgoodinfo['subject']),
				'groupId' => $newgoodinfo['groupId'],
				'bulkOrder' => $newgoodinfo['bulkOrder'],
				'bulkDiscount' => $newgoodinfo['bulkDiscount'],
				'goods_img' => $newgoodinfo['isImageDynamic'] == 0 ? $newgoodinfo['imageURLs'] : $imgarr[0],
				'imageURLs' =>  $newgoodinfo['imageURLs'],
				'packageLength' => $newgoodinfo['packageLength'],
				'packageWidth' => $newgoodinfo['packageWidth'],
				'packageHeight' =>  $newgoodinfo['packageHeight'],
				'grossWeight' =>  $newgoodinfo['grossWeight'],
				'detail' =>  addslashes($newgoodinfo['detail']),
				'account_id' => $accountid,
			),'ali_good_id = '.$good_info);
		$is_child = count($newgoodinfo['aeopAeProductSKUs']);
		for($j=0; $j < $is_child; $j++){
			$this->db->insert(CFG_DB_PREFIX."aligood_child",array(
				'ali_good_id'=>$newgoodinfo['productId'],
				'aeopSKUProperty'=>json_encode($newgoodinfo['aeopAeProductSKUs'][$j]['aeopSKUProperty']),
				'skuPrice'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuPrice'],
				'skuStock'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuStock'],
				'skuCode'=>$newgoodinfo['aeopAeProductSKUs'][$j]['skuCode'],
				'account_id' => $accountid,
			));
		}
		$rs = '重新同步成功;<br>';
		return $rs;
	}
	function clearGoodsAndChild($accountId){
		$this->db->execute('delete from '.CFG_DB_PREFIX.'aligoods');
		$this->db->execute('delete from '.CFG_DB_PREFIX.'aligood_child');
		return '删除成功';
	}
	/**
     * 提交速邮宝订单
     *
     * @param array $info
     * @return array
     */
    function getexpressbyali($info){
      
        set_time_limit(600);
        $msg = '';
         $onlineArr = array(
             '中国邮政平常小包+'=>'YANWENJYT_WLB_CPAMSZ',
             '芬兰经济小包'=>'ITELLA_WLB_YANWENSZ_ITELLA_PY' ,  
        );
        
        $orders = $this->db->select("select order_id,order_sn,paypalid,Sales_account_id,track_no,CountryCode,tel,city,email,consignee,zipcode,state,street1,street2,shipping_id from myr_order where order_id in (".$info['id'].")");
       
        $shippingsNames = ModelDd::getArray('shipping');
        
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();                        
        for($j = 0; $j < count($orders); $j++){    
                
                //$orderinfo = $orders[$j];
                if($orders[$j]['track_no'] <> '') continue;
                   $goods_info = $this->order_goods_info($orders[$j]['order_id']);
                    $qty = 0;
                    $goods_sns = '';
                    $price = 0;
                    foreach($goods_info as $key => $goodsvalue){  
                       $price = $goodsvalue['goods_price'];
                       $qty += $goodsvalue['goods_qty'];    
                       $goods_sns .= $goodsvalue['goods_sn']==''?$goodsvalue['goods_sn']:','.$goodsvalue['goods_sn'];
                    }
                    $dec_name = CFG_DEC_NAME;     
                    $Declared_weight = CFG_DECLARED_WEIGHT;
                    $Declared_value = CFG_DECLARED_VALUE;
                $goodsstr = "[";              
                foreach($goods_info as $key => $goodsvalue){
                    if(CFG_IMPORT_CUSTOMS){
                        //多个产品    
                        //优先使用导入产品信息
                        $goods_name = $goodsvalue['goods_name'];
                        if($goodsvalue['goods_qty'] > 1) $goods_name .= '*'.$goodsvalue['goods_qty'];                                                                                                                                                                                                                                                                                                                                                                                                            
                        $item_no = $goodsvalue['item_no'];
                        $item_sn = $goodsvalue['goods_sn'];
                        $goods_price = $goodsvalue['goods_price'];
                        $total_qty = $goodsvalue['goods_qty'];
                        $dec_name = ($goods_name <> '') ? $goods_name : CFG_DEC_NAME;
                        $Declared_weight = 1000*($goodsvalue['goods_weigth'] <> 0) ? $goodsvalue['goods_weigth']*$total_qty : CFG_DECLARED_WEIGHT;
                        $Declared_value = ($goods_price <> 0) ? $goods_price : CFG_DECLARED_VALUE;
                        $post_data .= '<Quantity>'.$total_qty.'</Quantity><GoodsName><Userid>'.$userid.'</Userid><NameCh>'.CFG_DEC_NAME_CN.'</NameCh><NameEn>'.$dec_name.'</NameEn><Weight>'.$Declared_weight.'</Weight><DeclaredValue>'.$Declared_value*$total_qty.'</DeclaredValue><DeclaredCurrency>'.$order_info['currency'].'</DeclaredCurrency><MoreGoodsName>'.CFG_DEC_NAME_CN.'</MoreGoodsName></GoodsName>';
                    }else{
                        //不优先使用导入产品信息的
                        //先查看产品库
                        $getgoods = $modelgoods->goods_info('',$goodsvalue['goods_sn']);
                        //有产品库的订单产品
                        if($getgoods){
                            $CustomsTitleEN = $getgoods['dec_name'];
                            $goods_name_cn = $getgoods['dec_name_cn'];
                            $item_no = $goodsvalue['item_no'];
                            $item_sn = $goodsvalue['goods_sn'];
                            $Declared_weight = $getgoods['Declared_weight'];
                            $Declared_value = $getgoods['Declared_value'];
                        }else{
                            $CustomsTitleEN =  CFG_DEC_NAME .'  '.$goodsvalue['goods_sn'].'*'.$goodsvalue['goods_qty'];
                            $goods_name_cn = CFG_DEC_NAME_CN;
                            $Declared_weight = CFG_DECLARED_WEIGHT;
                            $Declared_value = CFG_DECLARED_VALUE;
                        }
                        
                        $dec_value = $Declared_value*$goodsvalue['goods_qty'];
                        if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                            if($dec_value > CFG_DECLARED_MAX){
                               $dec_value = CFG_DECLARED_MAX; 
                            }
                        }
                                                                                   
                        if($goods_name_cn == '') $goods_name_cn = CFG_DEC_NAME_CN;
                        
                        if($key == 0){
                            $goodsstr .= "{\"categoryCnDesc\":\" $goods_name_cn  \",\"categoryEnDesc\":\" ". $this->replaceStartFilter($CustomsTitleEN,0,15)  ."\",\"isContainsBattery\":0,\"productDeclareAmount\":$dec_value,\"productId\":0,\"productNum\": ".$goodsvalue['goods_qty'].",\"productWeight\":".$Declared_weight."}";    
                        }else{
                            $goodsstr .= ",{\"categoryCnDesc\":\"$goods_name_cn  \",\"categoryEnDesc\":\"". $this->replaceStartFilter($CustomsTitleEN,0,15)  ."\",\"isContainsBattery\":0,\"productDeclareAmount\":$dec_value,\"productId\":0,\"productNum\": ".$goodsvalue['goods_qty'].",\"productWeight\":".$Declared_weight."}"; 
                        }  
                    }
                }
                $goodsstr .= "]";
                                                                                                                
            require(CFG_PATH_DATA . 'ebay/ali_' . $orders[$j]['Sales_account_id'] .'.php');
            
            $city = $orders[$j]['city'];
            $countrycode = $orders[$j]['CountryCode'];
            $email = addslashes($orders[$j]['email']);
            $tel = addslashes($orders[$j]['tel']);  
            $consignee = addslashes($orders[$j]['consignee']);
            $zipcode = $orders[$j]['zipcode'];
            $state = $orders[$j]['state'];
            $street1 = addslashes(  str_replace("'","",$orders[$j]['street1'].$orders[$j]['street2']) );
            
            $sendname = addslashes($params2['Contact']);
            $sendPostcode = addslashes($params1['Postcode']);
            $sendphone = addslashes($params1['Phone']);
            $sendcity = $params1['City'];
            $sendstreet = addslashes($params2['Street']);
            $sendDistrict = $params1['District'];
            $sendProvince = $params1['Province'];
            
            if($tel == '') $tel = '23 3423';
            
            $addressinfo = "{\"receiver\":{\"adminMemberSeq\":1007825241,\"city\":\"$city\",\"country\":\"$countrycode\",\"email\":\"$email\",\"fax\":\"23 3423 324\",\"memberSeq\":1007825241,\"memberType\":\"receiver\",\"name\":\"$consignee\",\"phone\":\"$tel\",\"postcode\":\"$zipcode\",\"province\":\"$state\",\"streetAddress\":\" ". $street1  ." \",\"trademanageId\":\"db1007825240\"},\"sender\":{\"adminMemberSeq\":1006722645,\"city\":\"$sendcity\",\"country\":\"CN\",\"county\":\"$sendDistrict\",\"email\":\"hjy_seller@aliqatest.com\",\"memberSeq\":1006722645,\"memberType\":\"sender\",\"name\":\"$sendname\",\"phone\":\"$sendphone\",\"postcode\":\"$sendPostcode\",\"province\":\"$sendProvince\",\"streetAddress\":\"$sendstreet\",\"trademanageId\":\"hjy_seller\"}}}";
            
            
            /**
            * 2015-07-10 
            * 
            * @var mixed
            * warehouseCarrierService 更新 nic
            * $onlineArr[$shippingsNames[$orderinfo['shipping_id']]]
            * 
            */
           
            $curlPost = array(
                'tradeOrderId' => $orders[$j]['paypalid'], 
                'tradeOrderFrom' => 'ESCROW',
                'warehouseCarrierService' => $onlineArr[$shippingsNames[$orders[$j]['shipping_id']]],
                'domesticLogisticsCompanyId' => '-1',
                'domesticLogisticsCompany' => '21000051003',    
                'domesticTrackingNo' => 'NONE',
                'declareProductDTOs' => $goodsstr,
                'addressDTOs' => $addressinfo,
                'remark' => '',
                'access_token' => $access_token,
                '_aop_signature' => $this->_aop_signature('param2/1/aliexpress.open/api.createWarehouseOrder/'.$APIDevUserID,array(
                    'tradeOrderId' => $orders[$j]['paypalid'], 
                    'tradeOrderFrom' => 'ESCROW',
                    'warehouseCarrierService' => $onlineArr[$shippingsNames[$orders[$j]['shipping_id']]],
                    'domesticLogisticsCompanyId' => '-1',
                    'domesticLogisticsCompany' => '21000051003',    
                    'domesticTrackingNo' => 'NONE',
                    'declareProductDTOs' => $goodsstr,
                    'addressDTOs' => $addressinfo,
                    'remark' => '',
                    'access_token' => $access_token 
                ))
            );
                                                                
            
            //var_dump($curlPost);exit; 
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
            curl_setopt($ch, CURLOPT_URL,'http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.createWarehouseOrder/'.$APIDevUserID);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
            $re=curl_exec($ch);
            curl_close($ch);
            $result=json_decode($re,true);
                                     
            if($result['success']){       
               $msg .= '订单'.$orders[$j]['paypalid'].'，创建成功<br>';
                $this->db->update('myr_order',array('track_no'=>$result['result']['warehouseOrderId']),'order_id = '.$orders[$j]['order_id']);
            }else{
                $msg .= '订单'.$orders[$j]['paypalid'].',失败。'.$result['message'];
            }
            
        }
        return $msg;     
    }
    
    
    
    
    function replaceStartFilter($string, $start = 0, $end = 0) {
        $count = mb_strlen($string, 'UTF-8'); //此处传入编码，建议使用utf-8。此处编码要与下面mb_substr()所使用的一致
        if (!$count) {
            return $string;
        }
        if ($end == 0) {
            $end = $count;
        }

        $i = 0;
        $returnString = '';
        while ($i < $count) {
            $tmpString = mb_substr($string, $i, 1, 'UTF-8'); // 与mb_strlen编码一致
            if ($start <= $i && $i < $end) {
                $returnString .= $string[$i];
            } else {
                $returnString .= $tmpString;
            }
            $i ++;
        }
        return $returnString;
    }

//echo replaceStartFilter('王军123网', 0, 2); //王*12网
    
    
    function getgetOnlineLogisticsInfo($ids){
      
        $ids = explode(',',$ids);
        //if(!$accountid) return '请选择要更改的账号!';
        set_time_limit(600);

        $msg = ''; 
        for($j = 0; $j < count($ids); $j++){
            
            
            $order_id = $ids[$j]; 

            $orderinfo = $this->db->getValue('select * from '.CFG_DB_PREFIX.'order where order_id = '.$order_id);  
            include(CFG_PATH_DATA . 'ebay/ali_'.$orderinfo['Sales_account_id'].'.php');
            if(time() > $longpasstime){
                throw new Exception("token已失效，请重新授权！",'610');exit();
            }
            //验证actoken是否过期,过期则更换重写缓存文件
            if(time() > $passtime) 
            {
                $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$accountid,
                'longpasstime'=>$longpasstime
                ));
            }
         
              
            $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getOnlineLogisticsInfo/'.$APIDevUserID.'?access_token='.$access_token.'&orderId='.$orderinfo['paypalid']."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.getOnlineLogisticsInfo/'.$APIDevUserID,array(
                    'orderId' => $orderinfo['paypalid'],
                    'access_token' => $access_token
                )));

            
            if($result['success']){
                $this->db->update('myr_order',array('track_no' => $result['result'][0]['internationallogisticsId']),'order_id = '.$order_id);
                $msg .= '订单'.$orderinfo['paypalid'].'，获取成功,'.$result['result'][0]['internationallogisticsId'].'<br/>';

            }
        
        }
        return $msg;
        

    } 

    
    
    
	/**
	 * 获取线上支持的国内物流方式
	 */
	function getsubexpress(){
		set_time_limit(60);
		include(CFG_PATH_DATA . 'ebay/ali_202.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.qureyWlbDomesticLogisticsCompany/'.$APIDevUserID.'?access_token='.$access_token);
		if($result['success']){
			foreach($result['result'] as $key => $value){
				if($value['companyId'] == '-1') $value['companyId'] = 0;
				$express[$value['companyId']] = $value['name'];
			}
			$fp = fopen(CFG_PATH_DATA . 'dd/aliexpress.php', 'w');
			fputs($fp, '<?php return '.var_export($express, true) . '; ?>');
			fclose($fp);
		}else{
			throw new Exception("更新失败",'610');exit();
		}
	}
	
	/**
	 * 获取分类信息
	 *
	 * @param int $productid
	 * @param int $account_id
	 * @return array
	 */
	function getKeyWord($productid,$account_id){
		include(CFG_PATH_DATA . 'ebay/ali_' . $account_id .'.php');
		$result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$productid.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID,array(
                    'productId' => $productid,
                    'access_token' => $access_token
                )));
		$return = array();
		if($result['success']){
			$cat_id = $result['categoryId'];
			$cateresult = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getPostCategoryById/'.$APIDevUserID.'?cateId='.$cat_id.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.getPostCategoryById/'.$APIDevUserID,array(
                    'cateId' => $cat_id,
                    'access_token' => $access_token
                )));
			
			$return['cat_name_cn'] = $cateresult['aeopPostCategoryList'][0]['names']['zh'];
			$return['cat_name_en'] = $cateresult['aeopPostCategoryList'][0]['names']['en'];
			return $return;
		}else{
			$return['cat_name_cn'] = CFG_DEC_NAME_CN;
			$return['cat_name_en'] = CFG_DEC_NAME;
			return $return;
		}
	}
	/**
	 * 获取订单站内信
	 *
	 * @param int $id
	 * @return string
	 */
	function getAliMsg($id){
		$msgs = $this->db->select('select * from myr_aliorder_msg where aliorderid ='.$id);
		$str = '<ul style="font-size:12px; list-style:none;padding:0;margin:0;line-height:35px">';
		for($i=0;$i<count($msgs);$i++){
			$str .= '<li>'.date('Y-m-d',$msgs[$i]['add_time']).'&nbsp;&nbsp;'.$msgs[$i]['msg_content'].'</li>';
		}
		return $str.'</ul>';
	}
	/**
	 * 获取产品分类
	 * @param int $node  子分类ID root为获取最顶级分类
	 * @param int $accountid
	 * @return array
	 */
	function getAliexpressCate($node,$accountid){
		if(!$accountid) return '请选择要更改的账号!';
		set_time_limit(60);
		include('erp_client/mybsale/data/ebay/ali_105.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$cateid = $node == 'root' ? 0 : $node;
		$result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getChildrenPostCategoryById/'.$APIDevUserID.'?cateId='.$cateid.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.getChildrenPostCategoryById/'.$APIDevUserID,array(
                    'cateId' => $cateid,
                    'access_token' => $access_token
                )));
		if($node == 'root'){
            $trees[$node][] = array('id'=>0,'text'=>'所有分类','leaf'=>true, 'cls'=>'file');
        }
		foreach($result['aeopPostCategoryList'] as $key => $value){
			$trees[$node][] = array('id'=>$value['id'],'text'=>$value['names']['zh'].'('.$value['names']['en'].')','leaf'=>$value['isleaf'], 'cls'=>'folder');
		}
				
		return $trees;
	}
	/**
	 * 获取产品分类下详细属性
	 * @param int $id  分类ID 必须为节点分类
	 * @param int $accountid
	 * @return array
	 */
	function getAliexpressAttribute($id,$accountid){
		if(!$accountid) return '请选择要更改的账号!';
		set_time_limit(60);
		include('../ice/data/ebay/ali_' . $accountid .'.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.getAttributesResultByCateId/'.$APIDevUserID.'?cateId='.$id.'&access_token='.$access_token);
		
		$attrs = array();
		
		foreach($result['attributes'] as $key => $value){
			$notice = '';
			if($value['required'] == true) $notice .= '<font style="color:red">*</font>';
			if($value['keyAttribute'] == true && $value['required'] == false) $notice .= '<font style="color:green">!</font>';
			
			if($value['sku'] <> true){
				
				$attrs[] = array('id'=>$value['id'],'keyAttribute'=>$value['keyAttribute'],'sku'=>$value['sku'], 'name'=> $notice.$value['names']['zh'],'show_type' => $this->changeshowtype($value['attributeShowTypeValue']),'values'=>$value['values']);
			}
			
		}
		return $attrs;
	}
	/**
	 * 转换属性显示类型
	 * @param string $type
	 * @return string
	 */
	function changeshowtype($type){
		switch($type)
		{
			case 'list_box':
			return 'combo';
			
			case 'input':
			return 'textfield';
			
			case 'check_box':
			return 'checkboxgroup';
			
			case 'interval':
			return 'numberfield';
			
		}	
	}
	/**
	 * 获取aliexpress本地产品详细
	 * @param string $id 自增id
	 * @return array
	 */
	function getAligoodsinfo($id){
		$info = $this->db->getValue('select * from '.CFG_DB_PREFIX.'aligoods where id = '.$id);
		$cateinfo = $this->db->getValue('select cat_name,name_en from '.CFG_DB_PREFIX.'alicategory'.' where cat_id = '.$info['categoryId']);
		$info['cat_name'] = $cateinfo['cat_name'].'('.$cateinfo['name_en'].')';
		
		return  $info;
	}
	/**
	 * 更新产品属性
	 * @param string $id 自增id
	 * @return array
	 */
	function updateGoodAttributes($info,$id){
		
		
		$attrs = $this->db->getValue('select categoryId,aeopAeProductPropertys from myr_aligoods where id  = '.$id);

		$old_attr = json_decode($attrs['aeopAeProductPropertys'],true);
		$new_attr = array();
		foreach($info as $name => $value){
			$spliename = explode('__',$name); // $spliename[1] = show type
			
			if($spliename[1] == 'list_box'){
				$new_attr[] = array('attrNameId'=>$spliename[0],'attrValueId'=>$value);
				/*foreach ($old_attr as $k=> &$v ) {
					if(in_array($spliename[0],$v)){
						$new_attr[] = array('attrNameId'=>$spliename[0],'attrValueId'=>$value);
						unset($old_attr[$k]);
					}
				}	*/
			}
			if($spliename[1] == 'check_box'){
				$new_attr[] = array('attrNameId'=>$spliename[0],'attrValueId'=>$value);
				/*foreach ($old_attr as $k=> &$v ) {
					if(in_array($spliename[0],$v) && in_array($value,$v)){
						$new_attr[] = array('attrNameId'=>$spliename[0],'attrValueId'=>$value);
						unset($old_attr[$k]);
					}
					
				}	*/
			}
			if($spliename[1] == 'input'){
				$new_attr[] = array('attrNameId'=>$spliename[0],'attrValue'=>$value);	
			}
			if($spliename[1] == 'option'){
				$new_attr[] = array('attrName'=>$spliename[0],'attrValue'=>$value);
				//return $spliename[0];
			}
			//return $spliename[1];
		}
		
		$this->db->update(CFG_DB_PREFIX.'aligoods',array('aeopAeProductPropertys'=>json_encode($new_attr)),'id='.$id);
	}
	/**
	 * 获取aliexpress本地产品属性
	 * @param string $id 自增id
	 * @return array
	 */
	function getinfoattributes($info){
        
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['account_id'] .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['account_id'],
                'longpasstime'=>$longpasstime
            ));
        }
        
		$newgoodinfo = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$info['id'].'&access_token='.$access_token);
        
        /*return array( 
        'skuCode' =>  $newgoodinfo['aeopAeProductSKUs'][0]['skuCode'], 
        'packageType' => $newgoodinfo['lotNum']>1?1:0,
        'lotNum' => $newgoodinfo['lotNum'],
        'wsValidNum' => $newgoodinfo['wsValidNum'],
        'packageLength' => $newgoodinfo['packageLength'],
        'packageWidth' => $newgoodinfo['packageWidth'],
        'packageHeight' =>  $newgoodinfo['packageHeight'],
        'grossWeight' =>  $newgoodinfo['grossWeight'],
        'productUnit' => $newgoodinfo['productUnit'],
        'freightTemplateId' => $newgoodinfo['freightTemplateId'],
        'isImageDynamic' => $newgoodinfo['isImageDynamic'],
        'bulkOrder' => $newgoodinfo['bulkOrder'],
        'bulkDiscount' => $newgoodinfo['bulkDiscount'],
        'Propertys_qty' => count($newgoodinfo['aeopAeProductPropertys']),
        'SKUs_qty' => count($newgoodinfo['aeopAeProductSKUs']), 
        'ProductViewed' => $this->getProductViewed($product_id,$APIDevUserID,$APIPassword,$access_token)0, 
        'SalesInfo' => $this->getProductSaleed($product_id,$APIDevUserID,$APIPassword,$access_token)0
        );*/
		$result = array();
		$attr_object = json_decode($newgoodinfo['aeopAeProductPropertys'],true);
		$option = array();
		$vs = array();
		$html = '
<link rel="stylesheet" type="text/css" href="common/lib/ext-4/resources/css/ext-all-neptune.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javaScript" src="common/lib/ext-4/ext-all.js" ></script>
<script type="text/javaScript" src="common/lib/ext-4/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="common/js/common.js"></script>


<script type="text/javascript">
Ext.onReady(function(){
	
Ext.create("Ext.Button", {
    renderTo: Ext.get("saveattr"),
  	text: "保存(本地)",
	handler: function () {
		saveattribute();
	} 
});
	
});

function saveattribute(type){
	
	var id = document.getElementById("goods_id").value;
	Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
	Ext.Ajax.request({
	loadMask:true,
	form:"attrform",
	method:"POST",
	url: "index.php?model=aliexpress&action=modify&id="+id,
	success:function(response,opts){
		Ext.getBody().unmask();
		var res = Ext.decode(response.responseText);
		
		if(res.success){
			Ext.example.msg("MSG",res.msg);
			window.location.reload();
		}else{
			Ext.Msg.alert("ERROR",res.msg);
		}						
	}
	});
}
</script>
<div style="font-size:12px;color:#666;padding:15px 5px;">提示：<font style="color:red">&nbsp;*&nbsp;</font>&nbsp;为必填属性&nbsp;&nbsp;&nbsp;<font style="color:green">&nbsp;!&nbsp;</font>为关键属性&nbsp;&nbsp;&nbsp;<font style="color:blue">&nbsp;%&nbsp;</font>&nbsp;为自定义属性(请到速卖通后台添加)</div>
<div id="saveattr" style="width:100%;text-align:center;position:fixed;top:170px;">
</div>
<input type="hidden" id="goods_id" value="'.$info['id'].'"/>
<form action="index.php?model=aliexpress&action=saveattribute&id={$id}" name="attrform" id="attrform">

<table style="font-size:12px;color:#3E3A39;border:1px solid #CCC;border-radius:8px 5px 5px 5px;" width="100%" cellpadding="5" border="0" cellspacing="2">
	<tr style=" background-color:#157FCC;background-image:none;color:#FFF;font-weight:bold;" height="25px">
	<td width="125px">&nbsp;属性名称</td>
	<td>&nbsp;属性值</td>
	</tr>';
		//筛选复选框多个属性
		if($attr_object){
			foreach ($attr_object as $k=> &$v ) {
				if($v['attrNameId'] && $v['attrValueId']){
					if (isset($vs[$v['attrNameId']])){
						array_push($vs[$v['attrNameId']]['values'],$attr_object[$k]['attrValueId']);
						unset($attr_object[$k]);
					}else{
						
						$attrinfo = $this->db->getValue('select * from myr_ali_attributes where cat_id = '.$attrs['categoryId'].' and attributeId = '.$v['attrNameId'].' and sku <> 1');
						
						$vs[$v['attrNameId']]['values'] = array($attr_object[$k]['attrValueId']);
						$vs[$v['attrNameId']]['showtype'] = $attrinfo['ShowType'];
						$vs[$v['attrNameId']]['required'] = $attrinfo['required'];
						$vs[$v['attrNameId']]['keyAttribute'] = $attrinfo['keyAttribute'];
						$vs[$v['attrNameId']]['name'] = $attrinfo['attr_name'];
					}
				}elseif($v['attrNameId'] && $v['attrValue']){
					
					$attrinfo = $this->db->getValue('select * from myr_ali_attributes where cat_id = '.$attrs['categoryId'].' and attributeId = '.$v['attrNameId'].' and sku <> 1');
						
					$vs[$v['attrNameId']]['values'] = $v['attrValue'];
					$vs[$v['attrNameId']]['showtype'] = $attrinfo['ShowType'];
					$vs[$v['attrNameId']]['required'] = $attrinfo['required'];
					$vs[$v['attrNameId']]['keyAttribute'] = $attrinfo['keyAttribute'];
					$vs[$v['attrNameId']]['name'] = $attrinfo['attr_name'];
				}elseif($v['attrName'] && $v['attrValue']){
					
					$name = /*str_replace(' ','_',*/$v['attrName']/*)*/;
					
					$vs[$name]['values'] = $v['attrValue'];
					$vs[$name]['showtype'] = 'option';
					$vs[$name]['required'] = 0;
					$vs[$name]['keyAttribute'] = 0;
					$vs[$name]['name'] = $v['attrName'];
				}
				
			}
			
			foreach($vs as $NameID => $AttrINFO){ //key = name_id    val = val info (array)
				
				if($AttrINFO['showtype'] == 'check_box'){
					//复选框
					
					$attrinfo_values = $this->db->select('select * from myr_ali_attributes_option_values where cat_id = '.$attrs['categoryId'].' and attrNameId = '.$NameID);
					$notice = '';
					if($AttrINFO['required'] == true) $notice .= '<font style="color:red">&nbsp;*&nbsp;</font>';
					if($AttrINFO['keyAttribute'] == true && $AttrINFO['required'] == false) $notice .= '<font style="color:green">&nbsp;!&nbsp;</font>';
					if($notice == '') $notice = '&nbsp;&nbsp;&nbsp;';
					$html .= '<tr height="35px"><td width="125px">'.$notice.$AttrINFO['name'].':</td><td>';
					$val_length = count($attrinfo_values);
					$values = array();
					$checkboxhtml = '';
					for($j=0;$j<$val_length;$j++){
						$vindex = $j+1;
						$html .= '<span style="width:125px;"><input type="checkbox" name="'.$NameID.'__check_box" value="'.$attrinfo_values[$j]['attrValueId'].'" ';
						$html .= in_array($attrinfo_values[$j]['attrValueId'],$AttrINFO['values']) ? 'checked="checked" />&nbsp;'.$attrinfo_values[$j]['attrValueName'] : ' /></span>&nbsp;'.$attrinfo_values[$j]['attrValueName'].'&nbsp;&nbsp;';
						
					}
					$html .= '</td></tr>';
					
					
				}
				if($AttrINFO['showtype'] == 'list_box'){
					//下拉框
					$attrinfo_values = $this->db->select('select * from myr_ali_attributes_option_values where cat_id = '.$attrs['categoryId'].' and attrNameId = '.$NameID);
					$notice = '';
					if($AttrINFO['required'] == true) $notice .= '<font style="color:red">&nbsp;*&nbsp;</font>';
					if($AttrINFO['keyAttribute'] == true && $AttrINFO['required'] == false) $notice .= '<font style="color:green">&nbsp;!&nbsp;</font>';
					if($notice == '') $notice = '&nbsp;&nbsp;&nbsp;';
					$html .= '<tr height="35px"><td width="125px">'.$notice.$AttrINFO['name'].':</td><td><select name="'.$NameID.'__list_box">';
					$val_length = count($attrinfo_values);
					$values = array();
					for($j=0;$j<$val_length;$j++){
						$vindex = $j+1;
						$html .= '<option name="'.$NameID.'__list_box" value="'.$attrinfo_values[$j]['attrValueId'].'" '; 
						$html .= $attrinfo_values[$j]['attrValueId'] == $AttrINFO['values'][0] ? ' selected="selected">'.$attrinfo_values[$j]['attrValueName'].'</option>' : ' >'.$attrinfo_values[$j]['attrValueName'].'</option>';
						
					}
					$html .= '</td></tr>';
				}
				if($AttrINFO['showtype'] == 'input'){
					$notice = '';
					
					if($AttrINFO['required'] == true) $notice .= '<font style="color:red">&nbsp;*&nbsp;</font>';
					if($AttrINFO['keyAttribute'] == true && $AttrINFO['required'] == false) $notice .= '<font style="color:green">&nbsp;!&nbsp;</font>';
					if($notice == '') $notice = '&nbsp;&nbsp;&nbsp;';
					$html .= '<tr height="35px"><td width="125px">'.$notice.$AttrINFO['name'].':</td><td><input type="text" name="'.$NameID.'__input" value="'.$AttrINFO['values'].'" /></td></tr>';
				}	
				/*
					自定义值
				**/
				if($AttrINFO['showtype'] == 'option'){
					$notice = '';
					$notice .= '<font style="color:blue">&nbsp;%&nbsp;</font>';
					if($notice == '') $notice = '&nbsp;&nbsp;&nbsp;';
					$html .= '<tr height="35px"><td width="125px">'.$notice.$AttrINFO['name'].':</td><td><input type="text" name="'.$NameID.'__option" value="'.$AttrINFO['values'].'" /></td></tr>';
				}		
			}
			return $html.'</table>';
		}else{
			return '<div style="font-size:12px;color:#666">提示:还没有设置属性喔&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="选择分类" /><br/><br/></div><table style="font-size:12px;color:#3E3A39;border:1px solid #CCC;border-radius:8px 5px 5px 5px;" width="100%" cellpadding="5" border="0" cellspacing="2"></table></form></div>';
		}
	}
	/**
	 * 获取产品sku属性
	 * @param string $id 自增id
	 * @return array
	 */
	function getskuattributes($id){
		$attrs = $this->db->getValue('select categoryId,aeopAeProductSKUs from myr_aligoods where id  = '.$id);
		
		$result = array();
		$attr_object = json_decode($attrs['aeopAeProductSKUs'],true);
		
		
		$head = '<div style="font-size:12px;color:#666">提示<br/><br/></div><table style="font-size:12px;color:#3E3A39;border:1px solid #CCC;border-radius:8px 5px 5px 5px;" width="750px" cellpadding="5" border="0" cellspacing="2">';
	
		$one = ''; //表格排序的列头 第一列
		$two = ''; //表格排序的列头 第二列
		$body = '';
		
		for($i=0;$i<count($attr_object);$i++){
			
			if($attr_object[$i]['skuStock']){
				$stock = '<select ><option selected="selected">有</option><option >否</option></select>';
			}else{
				$stock = '<select ><option>有</option><option selected="selected">否</option></select>';
			}
			
			
			
			for($j=0;$j<count($attr_object[$i]['aeopSKUProperty']);$j++){
				
				//属性信息
				$attrinfo = $this->db->getValue('select * from myr_ali_attributes where cat_id = '.$attrs['categoryId'].' and attributeId = '.$attr_object[$i]['aeopSKUProperty'][$j]['skuPropertyId'].' and sku = 1');
				//属性值信息			
				$attrinfo_values = $this->db->getValue('select * from myr_ali_attributes_option_values where cat_id = '.$attrs['categoryId'].' and attrNameId = '.$attr_object[$i]['aeopSKUProperty'][$j]['skuPropertyId'].' and attrValueId = '.$attr_object[$i]['aeopSKUProperty'][$j]['propertyValueId']);
				
			
				if($attrinfo['spec'] == 1){
					$one = $attrinfo['attr_name'];
					$onevalue = $attrinfo_values['attrValueName'];
				}
				if($attrinfo['spec'] == 2){
					$two = $attrinfo['attr_name'];
					$twovalue = $attrinfo_values['attrValueName'];
				}
				
				if($attr_object[$i]['aeopSKUProperty'][$j]['skuImage']){
					//return var_dump($attr_object[$i]['aeopSKUProperty']['skuImage']);
					$onebody = '<img height="50px;" width="50px" src="'.$attr_object[$i]['aeopSKUProperty'][$j]['skuImage'].'" />';
					//可以自定义图片
					
				}else{
					if($attrinfo['spec'] == 1){
						$one = $attrinfo['attr_name'];
						$onebody = $attrinfo_values['attrValueName'];
					}
					if($attrinfo['spec'] == 2){
						$two = $attrinfo['attr_name'];
						$twobody = $attrinfo_values['attrValueName'];
					}
				}
				
			}
			$body .= '<tr height="100px" valign="top"><td>'.$onevalue.'</td><td>'.$twovalue.'</td><td><input type="text" value="'.$attr_object[$i]['skuPrice'].'"/></td><td>'.$stock.'</td><td valign="top" ><input type="text" value="'.$attr_object[$i]['skuCode'].'"/>&nbsp;&nbsp;'.$onebody.'</td></tr>';
		}
		
		
		$tablehead = '<tr height="35px"><td>'.$one.'</td><td>'.$two.'</td><td>零售价</td><td>库存</td><td>商品编码</td></tr>';
		
		return $head.$tablehead.$body.'</table>';
	}
	/**
	 * 下架一个产品
	 * @param string $id id
	 * @return string
	 */
	function downShelfGood($id){
		set_time_limit(30);
		$ids = explode(',',$id);
		for($i=0;$i<count($ids);$i++){
			$good_info = $this->db->getValue('select goods_name,ali_good_id,account_id from '.CFG_DB_PREFIX.'aligoods where id = '.$ids[$i]);
			include_once(CFG_PATH_DATA . 'ebay/ali_' . $good_info['account_id'] .'.php');
			if(time() > $longpasstime) 
			{
				throw new Exception("token已失效，请重新授权！",'610');exit();
			}
			//验证actoken是否过期,过期则更换重写缓存文件
			if(time() > $passtime) 
			{
				$access_token = $this->refreshChangeAccess(array(
					'appkey'=>$APIDevUserID,
					'appSecret'=>$APIPassword,
					'refresh_token'=>$refresh_token,
					'id'=>$good_info['account_id'],
					'longpasstime'=>$longpasstime
				));
			}
			$result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.offlineAeProduct/'.$APIDevUserID.'?productIds='.$good_info['ali_good_id'].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.offlineAeProduct/'.$APIDevUserID,array(
                    'productIds' => $good_info['ali_good_id'],
                    'access_token' => $access_token
                )));
			$num = $i+1;
			if($result['success']){
				$this->db->update(CFG_DB_PREFIX.'aligoods',array('status'=> 2,'goods_status'=>'offline','wsDisplay'=>'user_offline'),'ali_good_id ='.$good_info['ali_good_id']);
				
				ob_flush();
				flush();
				echo '<div style="padding:10px;color:#535353;font-size:12px;line-height:25px;margin-top:15px;" id="load'.$good_info['ali_good_id'].'">'.$num.'.&nbsp;'.$good_info['goods_name'].'<br/> 下架成功'.'</div>';
			}else{
				ob_flush();
				flush();
				echo '<div style="color:#535353;font-size:12px;line-height:25px;margin-top:15px;" id="load'.$good_info['ali_good_id'].'">'.$num.'.&nbsp;'.$good_info['goods_name'].'<br/>下架失败,&nbsp;发生<b>'.$result['error_message'].'</b>错误</div>';
			}		
		}	
	}
	/**
	 * 上架一个产品
	 * @param string $id  id
	 * @return string
	 */
	function onlineShelfGood($id){
		set_time_limit(30);
		$ids = explode(',',$id);
		for($i=0;$i<count($ids);$i++){
			$good_info = $this->db->getValue('select goods_name,ali_good_id,account_id from '.CFG_DB_PREFIX.'aligoods where id = '.$ids[$i]);
			include_once(CFG_PATH_DATA . 'ebay/ali_' . $good_info['account_id'] .'.php');
			if(time() > $longpasstime) 
			{
				throw new Exception("token已失效，请重新授权！",'610');exit();
			}
			//验证actoken是否过期,过期则更换重写缓存文件
			if(time() > $passtime) 
			{
				$access_token = $this->refreshChangeAccess(array(
					'appkey'=>$APIDevUserID,
					'appSecret'=>$APIPassword,
					'refresh_token'=>$refresh_token,
					'id'=>$good_info['account_id'],
					'longpasstime'=>$longpasstime
				));
			}
			
			$result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.onlineAeProduct/'.$APIDevUserID.'?productIds='.$good_info['ali_good_id'].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.onlineAeProduct/'.$APIDevUserID,array(
                    'productIds' => $good_info['ali_good_id'],
                    'access_token' => $access_token
                )));
			$num = $i+1;
			if($result['success']){
				$this->db->update(CFG_DB_PREFIX.'aligoods',array('status'=> 0,'goods_status'=>'onSelling'),'ali_good_id ='.$good_info['ali_good_id']);
				ob_flush();
				flush();
				echo '<div style="padding:10px;color:#535353;font-size:12px;line-height:25px;margin-top:15px;" id="load'.$good_info['ali_good_id'].'">'.$num.'.&nbsp;'.$good_info['goods_name'].'<br/> 上架成功'.'</div>';
			}else{
				ob_flush();
				flush();
				echo '<div style="color:#535353;font-size:12px;line-height:25px;margin-top:15px;" id="load'.$good_info['ali_good_id'].'">'.$num.'.&nbsp;'.$good_info['goods_name'].'<br/>上架失败,&nbsp;发生<b>'.$result['error_message'].'</b>错误</div>';
			}		
		}
	}
	
	
	/**
	 * 获取图片银行分组tree
	 * @param string $accountid 帐号id
	 * @param string $group 分组id 不传表示最顶级组
	 * @return string
	 */
	function get_image_group($accountid,$group){
		if(!$accountid) return '请选择账号!';
		set_time_limit(30);
		include(CFG_PATH_DATA . 'ebay/ali_' . $accountid .'.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$url = 'http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.listGroup/'.$APIDevUserID.'?access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.listGroup/'.$APIDevUserID,array(
                    'access_token' => $access_token
                ));
		if( $group <> 'root' ){
			$url .= '&groupId='.$group;
		}
		$grouplist = $this -> RequestAli($url);
		if($grouplist['success']){
			foreach($grouplist['photoBankImageGroupList'] as $key => $value){
				$trees[$group][] = array('id'=>$value['groupId'],'text'=>$value['groupName'],'leaf'=>$value['isleaf'], 'cls'=>'folder');
			}
				$trees[$group][] = 	array('id'=>'root','text'=>'未分组','leaf'=>true, 'cls'=>'folder');
		}else{
			return $grouplist['error_message'];
		}
		
		return $trees;
	}
	/**
	 * 获取图片银行图片
	 * @param string $accountid 帐号id
	 * @param string $group 分组id 不传表示获取为分组的图片  unGroup
	 * @return string
	 */
	function getimagesLib($accountid,$group){
		if(!$accountid) return '请选择账号!';
		set_time_limit(30);
		include(CFG_PATH_DATA . 'ebay/ali_' . $accountid .'.php');
		if(time() > $longpasstime) 
		{
			throw new Exception("token已失效，请重新授权！",'610');exit();
		}
		//验证actoken是否过期,过期则更换重写缓存文件
		if(time() > $passtime) 
		{
			$access_token = $this->refreshChangeAccess(array(
				'appkey'=>$APIDevUserID,
				'appSecret'=>$APIPassword,
				'refresh_token'=>$refresh_token,
				'id'=>$accountid,
				'longpasstime'=>$longpasstime
			));
		}
		$url = 'http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.listImagePagination/'.$APIDevUserID.'?access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.listImagePagination/'.$APIDevUserID,array(
                    'access_token' => $access_token
                ));
		if($group == 'root'){
			$url .= '&locationType=unGroup';
		}else{
			$url .= '&locationType=subGroup&groupId='.$group;
		}
		
		$list = $this -> RequestAli($url);
		$result = array();
		if($list['success']){
			foreach($list['images'] as $val){
				$result[] = array('name' => $val['displayName'],'thumb' => $val['url'],'type' => $val['iid'],'url'=>'');
			}
			
		}else{
			return $list['error_message'];
		}
		return $result;
	}
	
	/**
	 * 加入本地产品库
     * @param   array  $info  
     * 2014/04/09 多属性不同属性产品各为一个产品，根据SKU判断是否不同属性。
     * 
	 */
	function addgoodlib($id){
        set_time_limit(300);
		$msg = '';
		$goodOB = new ModelGoods();
		$result = array();                     
		try {
		    $ids = explode(',',$id);
        
            for($i=0;$i<count($ids);$i++){
                
                $arr = explode('-',$ids[$i]);
                
                $productId = $arr[0];
                
                $accountId = $arr[1];
                                   
                require_once(CFG_PATH_DATA . 'ebay/ali_' . $accountId .'.php');
                    
                if(time() > $longpasstime) 
                {  
                    $url = $this->geturl(array()); 
                    return array('reauth' => 'reauth' , 'url'=>$url);
                }                                            
                if(time() > $passtime){
                    $access_token = $this->refreshChangeAccess(array(
                        'appkey'=>$APIDevUserID,
                        'appSecret'=>$APIPassword,
                        'refresh_token'=>$refresh_token,
                        'id'=>$accountId,
                        'longpasstime'=>$longpasstime
                    ));
                    //sleep(2);  /* 停止两秒过期的写文件 */ 
                }
                
                $info = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$productId.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID,array(
                    'productId' => $productId,
                    'access_token' => $access_token
                )));
               
                $attr_object = $info['aeopAeProductSKUs'];
                $imgarr = explode(';',$info['imageURLs']);
                
                for($j=0;$j<count($attr_object);$j++){
                    $good = $this->db->getValue("select count(*) from ".CFG_DB_PREFIX."goods where goods_sn = '".$attr_object[$j]['skuCode']."' or SKU = '".$attr_object[$j]['skuCode']."'"); 
                    if(!$good or !$attr_object[$j]['skuCode']){  
                        $this->db->insert(CFG_DB_PREFIX.'goods',array(
                            "price1" => $attr_object[$j]['skuPrice'],
                            "l" => $info['packageLength'],
                            "w" => $info['packageWidth'],
                            'cat_id' => 0,
                            "h" => $info['packageHeight'],
                            "weight" => $info['grossWeight'],
                            "goods_name" => addslashes($info['subject']),
                            'goods_img' => $imgarr[0],
                            'SKU' => $attr_object[$j]['skuCode'],
                            'des_en' =>  addslashes($info['detail']),
                            "dec_name" => addslashes($info['keyword']),
                            "Declared_weight" => $info['grossWeight'],
                            "Declared_value" => $attr_object[$j]['skuPrice'] * 0.6,
                            "grossweight" => $info['grossWeight'],
                            "goods_url" => '',
                            "goods_sn" => $attr_object[$j]['skuCode'],  
                            "add_time" => CFG_TIME
                        ));
                        $goodsid =  $this->db->getInsertId();

                        $imgs = explode(';',$info['imageURLs']);
                        foreach($imgs as $key => $url ){
                            $this->db->insert(CFG_DB_PREFIX .'goods_gallery', array(
                                'goods_id' => $goodsid,
                                'url' => $url));
                        }
                        $this->db->insert(CFG_DB_PREFIX .'aliand_aligoods', array(
                            'goods_id' => $goodsid,
                            'ali_goods_id' => $info['productId'],
                            'account_id' => $accountId
                        ));      
                        $goodOB->importstock();
                        $msg .= '<font style="color:red">'.$attr_object[$j]['skuCode'].'</font>加入成功<br/>'; 
                        
                    }else{
                        $msg .= '<font style="color:red">'.$attr_object[$j]['skuCode'].'</font>重复<br/>';
                    }
                
                }        
            }    
		} catch (Exception $e) {
				throw new Exception($e->getMessage(),'999');exit();
		}
        return $msg;
	}
    /**
     * 加入待刊登
     * @param   array  $info
     * @return  string  
     */
	function joinuploadgood($info){
		$product_id = $info['ali_goods_id'];
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['account_id'] .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['account_id'],
                'longpasstime'=>$longpasstime
            ));
        }
        $newgoodinfo = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$product_id.'&access_token='.$access_token);
        $imgarr = explode(';',$newgoodinfo['imageURLs']);       
		$this->db->insert(CFG_DB_PREFIX.'aligoods',array(
			    'last_update_time' => CFG_TIME,
                'deliveryTime' => $newgoodinfo['deliveryTime'],
                'categoryId' => $newgoodinfo['categoryId'],
                'aeopAeProductSKUs' => json_encode($newgoodinfo['aeopAeProductSKUs']),
                'skuCode' => $newgoodinfo['aeopAeProductSKUs'][0]['skuCode'],
                'keyword' => addslashes($newgoodinfo['keyword']),
                'productMoreKeywords1' => addslashes($newgoodinfo['productMoreKeywords1']),
                'productMoreKeywords2' => addslashes($newgoodinfo['productMoreKeywords2']) ,
                'productPrice' => $newgoodinfo['productPrice'],
                'productUnit' => $newgoodinfo['productUnit'],
                'freightTemplateId' => $newgoodinfo['freightTemplateId'],
                'isImageDynamic' => $newgoodinfo['isImageDynamic'],
                'packageType' => $newgoodinfo['packageType'],
                'lotNum' => $newgoodinfo['lotNum'],
                'aeopAeProductPropertys' => addslashes(json_encode($newgoodinfo['aeopAeProductPropertys'])),
                'ownerMemberId' => $newgoodinfo['ownerMemberId'],
                'wsOfflineDate' => $newgoodinfo['wsOfflineDate'],
                'wsDisplay' => $newgoodinfo['wsDisplay'],
                'wsValidNum' => $newgoodinfo['wsValidNum'],
                'groupId' => $newgoodinfo['groupId'],
                'bulkOrder' => $newgoodinfo['bulkOrder'],
                'bulkDiscount' => $newgoodinfo['bulkDiscount'],
                'goods_img' => $imgarr[0],
                'imageURLs' =>  $newgoodinfo['imageURLs'],
                'packageLength' => $newgoodinfo['packageLength'],
                'packageWidth' => $newgoodinfo['packageWidth'],
                'packageHeight' =>  $newgoodinfo['packageHeight'],
                'grossWeight' =>  $newgoodinfo['grossWeight'],
                'detail' =>  addslashes($newgoodinfo['detail']),
                'account_id' => 112,
                'status' => 1,
                'goods_name' => addslashes($newgoodinfo['subject'])
		    ));
        $acc = ModelDd::getArray('aliaccount');
        return $newgoodinfo['skuCode'].'成功复制到'.$acc[112];
	}
    /**
     * 获取图片银行列表
     * @param   int  $id
     * @return  array  
     */
	function getimgList($id)
	{
		$img = $this->db->getValue('select imageURLs from '.CFG_DB_PREFIX.'aligoods where id='.$id);
		$result = array();
		$imglist = explode(';',$img);
		for($i=1;$i<=count($imglist);$i++){
			$result[] = array('id'=>$i,'url'=>$imglist[$i-1],'goods_id'=>$id);
		}
		return $result;		
	}
    /**
     * 保存图片
     * @param   int  $id
     * @param   string  $img
     */
	function savegoodsimg($id,$img){
		$this->db->update(CFG_DB_PREFIX.'aligoods',array('imageURLs'=>$img),'id='.$id);
	}
    /**
     * 返回更新页面
     * @param   int  $id
     * @return  string  html   
     */
    function getupdatealiprice($id){
        
        $account = ModelDd::getArray('aliaccount');
        $accountstring = ModelDd::getComboData('aliaccount');
        
        
        
        $selectHTML = '<select id="upprice_account"><option value = 0>选择账号</option>';
        
        foreach($account as $aid => $aname){
           $selectHTML .= '<option value = '.$aid.'>'.$aname.'</option>'; 
        } 
        $selectHTML .= '</select>'; 
         
        $html = '
<link rel="stylesheet" type="text/css" href="common/lib/ext-4/resources/css/ext-all-neptune.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javaScript" src="common/lib/ext-4/ext-all.js" ></script>
<script type="text/javaScript" src="common/lib/ext-4/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="common/js/common.js"></script>
<script type="text/javascript">
Ext.onReady(function(){

    var data = ['.$accountstring.'];   

    Ext.create("Ext.form.Panel",{
    labelWidth: 75,
    frame:false,
    id:"imform",
    border:false,
    fileUpload:true, 
    renderTo: Ext.get("aa"),
    items:[
        Ext.create("Ext.form.FieldSet",{
            layout:"column",
            autoWidth:"auto",
            autoHeight:"auto",
            margin: "5px 10px 0px 10px",
            labelWidth:85,
            items:[
                 {
                    xtype:"panel",
                    columnWidth:.4,
                    html:\'<div style="font-size:12px;color:#666;margin:10px;">操作提示：<p>1.选择一个帐号并导出该帐号商品原始数据。</p><p>2.下载示例模版。<a style="color:bule" href="common/lib/download/aliexupdategoods.xls">点击下载模板</a></p><p>3.复制原始数据至模版，将原始数据id字段粘贴至模版文件。</p><p>4.复制需要修改的字段复制原始数据并粘贴至模版。</p><p>5.导入修改后的模版文件。<a target="_blank" href="http://www.cpowersoft.com/blog/?p=468">查看更多详细</a></p></div>\'
                },
                {
                    columnWidth:.6,
                    border:false,
                    defaultType: "textfield",
                    items:[
                        {
                                    xtype: "fieldset",
                                    title:"选择更新的字段",
                                    margin: "5px 10px 0px 10px", 
                                    layout: "anchor",
                                    width:650,
                                    defaults: {
                                        anchor: "100%"
                                    },
                                    items: [{
                                        xtype: "checkboxgroup",
                                        hideLabel:true,
                                        name:"updatefield",
                                        id:"updatefield",
                                        columns: 4,
                                        vertical: true,
                                        cls: "x-check-group-alt",
                                        items: [
                                            {    
                                                boxLabel: "备货期", inputValue: "deliveryTime",name:"ufield"
                                            },{    
                                                boxLabel: "商品一口价", inputValue: "productPrice",checked:true,name:"ufield" 
                                            },{    
                                                boxLabel: "运费模版ID", inputValue: "freightTemplateId",name:"ufield" 
                                            },{    
                                                boxLabel: "商品包装长度", inputValue: "packageLength",name:"ufield" 
                                            },{    
                                                boxLabel: "商品包装宽度", inputValue: "packageWidth",name:"ufield" 
                                            },{    
                                                boxLabel: "商品包装高度", inputValue: "packageHeight",name:"ufield" 
                                            },{    
                                                boxLabel: "商品毛重", inputValue: "grossWeight",name:"ufield" 
                                            },{    
                                                boxLabel: "商品有效天数", inputValue: "wsValidNum",name:"ufield" 
                                            },{    
                                                boxLabel: "批发最小数量", inputValue: "bulkOrder",name:"ufield" 
                                            },{    
                                                boxLabel: "批发折扣", inputValue: "bulkDiscount",name:"ufield" 
                                            },{    
                                                boxLabel: "商品标题", inputValue: "subject",name:"ufield" 
                                            },{    
                                                boxLabel: "Detail详情", inputValue: "detail",name:"ufield" 
                                            }
                                        ]    
                                    }]
                                 },
                     
                        Ext.create("Ext.form.FieldSet",{
                            title: "导出原始数据",
                            layout:"column",
                            autoWidth:"auto",
                            autoHeight:"auto",
                            margin: "5px 10px 0px 10px",
                            labelWidth:85,
                            items:[
                                 Ext.create("Ext.form.field.ComboBox", {
                                    store: Ext.create("Ext.data.ArrayStore", {
                                        fields: ["id", "name"],
                                        data : data
                                    }),
                                    columnWidth:.45,
                                    valueField :"id",
                                    displayField: "name",
                                    mode: "local",
                                    width:370,
                                    renderTo: Ext.get("selaccid"),
                                    editable: false,
                                    forceSelection: true,
                                    triggerAction: "all",
                                    id:"ali_acc_id",
                                    name:"ali_acc_id",
                                    style:"margin:10px;",
                                    hiddenName:"ali_acc_id",  
                                    emptyText: "选择一个账号",
                                    indent: true
                                }),Ext.create("Ext.Button", {
                                  renderTo: Ext.get("exportexcel"),
                                  text: "导出账号商品",
                                  width:100,
                                  columnWidth:.22,
                                  style:"margin:10px;",
                                  handler: function () {
                                    var jsonArray = [];
                                    var CheckboxGroup = Ext.getCmp("updatefield").getChecked(); 
                                                        
                                    Ext.Array.each(CheckboxGroup, function(item){
                                        
                                        var attr = {"name":item.boxLabel,"field":item.inputValue};
                                        jsonArray.push(attr);
                                     
                                    });
                                    
                                   
                                    var aid = Ext.getCmp("ali_acc_id").getValue(); 
                                    if(aid == null || aid == 0 || aid == ""){Ext.Msg.alert("错误","请先选择账号");return false;}
                                    window.open().location.href = "index.php?model=aliexpress&action=exportaliexpressgoods&account="+aid+"&status=1&fields="+Ext.encode(jsonArray);
                                  } 
                                })
                            ]
                        }),
                        Ext.create("Ext.form.FieldSet",{
                            title: "导入修改后文件",
                            layout:"column",
                            autoWidth:"auto",
                            autoHeight:"auto",
                            margin: "25px 10px 0px 10px",
                            labelWidth:85,
                            items:[
                                {
                                fieldLabel: "xls更新文件",
                                labelWidth:75,
                                width:250,
                                style:"margin:10px;",
                                xtype: "fileuploadfield",
                                allowBlank:false,
                                name:"file_path"
                                } ,{
                                    xtype:"button",
                                text:"开始批量更新",
                                style:"margin:10px;",
                                iconCls:"x-tbar-import",
                                handler:function(){
                                    if(Ext.getCmp("imform").getForm().isValid()){var ids = Ext.getCmp("ali_acc_id").getValue();
                                    if(!ids) {Ext.Msg.alert("错误","请先选择账号");return false;return false;}
                                    Ext.getCmp("imform").getForm().submit({
                                         url:"index.php?model=aliexpress&action=fileupdategoods&id="+Ext.getCmp("ali_acc_id").getValue(),
                                         method:"post",
                                         params:"",
                                         success:function(form,action){
                                            if (action.result.success) {
                                            
                                            
                                                alert(action.result.msg);return;
                                            
                                                var searchWin = Ext.create("Ext.window.Window", {
                                                    title : "更新完成",  
                                                    id : "searchWin",  
                                                    width : 550,  
                                                    height : 450,  
                                                    html: action.result.msg,
                                                    autoScroll : true,   
                                                    modal : true,  
                                                    bodyStyle : {  
                                                        background : "#ffffff",  
                                                        margin : "auto"  
                                                    }  
                                                })
                                            } else {
                                                Ext.Msg.alert("导入错误",action.result.msg);
                                            }
                                         },
                                         failure:function(form,action){
                                            Ext.Msg.alert("操作",action.result.msg);
                                         }
                                      });
                                    }}
                                } 
                            ]
                        })
                             
                    ]
                }  
            ]
       })]  
    });
})

</script>
<body>
<input type="hidden" id="goods_id" value="'.$id.'"/>
<div id="aa"></div>

<table>
    <tr>
        <td>
            <div id="selaccid"></div>
        </td>
    </tr>
    <tr>
    <td><div id="exportexcel"></div></td>
    
    </tr>
</table>


</body>
';
    return $html;
    }
    /**
     * 加载速卖通站内信
     * @param   int  $id
     * @return  string  html   
     */
    function loadMSG($info,$starttime=null,$endstart=null,$account_name=null){
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        if($starttime==null && $endstart==null){  /* 按条件同步 */ 
            $page = 1;
            $total = 0;
            $typeFunction = '';
            if($info['orderId']){
                if($info['type']=='order') $typeFunction = 'queryOrderMsgList';
                if($info['type']=='product') $typeFunction = 'queryMessageList';
                
                $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.'.$typeFunction.'/'.$APIDevUserID.'?orderId='.$info['orderId'].'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.'.$typeFunction.'/'.$APIDevUserID,array(
                    'orderId' => $productId,
                    'pageSize' => '50',
                    'currentPage' => $page,
                    'access_token' => $access_token
                )));
                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                if($result['total'] > 50){  //总记录大于50         
                    for($page = 2; $page <= ceil($result['total']/50);$page++){
                        
                        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.'.$typeFunction.'/'.$APIDevUserID.'?orderId='.$info['orderId'].'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.'.$typeFunction.'/'.$APIDevUserID,array(
                            'orderId' => $productId,
                            'pageSize' => '50',
                            'currentPage' => $page,
                            'access_token' => $access_token
                        )));
                        if(count($result) > 0 ){
                            try {
                                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                            } catch (Exception $e) {
                                throw new Exception($e->getMessage(),'999');exit();
                            }    
                        }
                    }
                }
                return '共同步<b>'.$total.'</b>条';            
            }
            $start = explode('-',$info['start']);
            $info['start'] = $start[1].'/'.$start[2].'/'.$start[0].' 00:00:00';
            $end = explode('-',$info['end']);
            $info['end'] = $end[1].'/'.$end[2].'/'.$end[0].' 23:59:59';
            
            /* type:message类型  order=订单留言，msg=站内信 */
            if($info['type'] == 'order'){
                $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID,array(
                    'startTime' => urlencode($info['start']),
                    'endTime' => urlencode($info['end']),
                    'pageSize' => '50',
                    'currentPage' => $page,
                    'access_token' => $access_token
                )));
               // if($result['total'] > 1000){return '亲。已超过5000条，请缩小时间段~';}
                
                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                if($result['total'] > 50){  //总记录大于50         
                    for($page = 2; $page <= ceil($result['total']/50);$page++){
                        
                        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID,array(
                            'startTime' => urlencode($info['start']),
                            'endTime' => urlencode($info['end']),
                            'pageSize' => '50',
                            'currentPage' => $page,
                            'access_token' => $access_token
                        )));
                        if(count($result) > 0 ){
                            try {
                                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                            } catch (Exception $e) {
                                throw new Exception($e->getMessage(),'999');exit();
                            }    
                        }
                    }
                }
                return '共同步新订单留言'.$total.'条';        
            }else{
                /* 站内信 */
                $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID,array(
                    'startTime' => urlencode($info['start']),
                    'endTime' => urlencode($info['end']),
                    'pageSize' => '50',
                    'currentPage' => $page,
                    'access_token' => $access_token
                )));
                //if($result['total'] > 1000){return '亲。已超过1000条，请缩小时间段~';}
                
                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                if($result['total'] > 50){  //总记录大于50         
                    for($page = 2; $page <= ceil($result['total']/50);$page++){
                        
                        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID,array(
                            'startTime' => urlencode($info['start']),
                            'endTime' => urlencode($info['end']),
                            'pageSize' => '50',
                            'currentPage' => $page,
                            'access_token' => $access_token
                        )));
                        if(count($result) > 0 ){
                            try {
                                $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                            } catch (Exception $e) {
                                throw new Exception($e->getMessage(),'999');exit();
                            }    
                        }
                    }
                }
                return '共同步新站内信'.$total.'条';    
            }
        }else{   /* 一键同步 */
            $info['start'] = $starttime;
            $info['end'] = $endstart;
            $page = 1;
            $total = 0;
            $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID,array(
                'startTime' => urlencode($info['start']),
                'endTime' => urlencode($info['end']),
                'pageSize' => '50',
                'currentPage' => $page,
                'access_token' => $access_token
            )));
            if($result['total'] > 1000){return '亲。已超过5000条，请缩小时间段~';}
            
            $total += $this->savedownloadMessage($result['msgList'],$info['id']);
            if($result['total'] > 50){  //总记录大于50         
                for($page = 2; $page <= ceil($result['total']/50);$page++){
                    
                    $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryOrderMsgList/'.$APIDevUserID,array(
                        'startTime' => urlencode($info['start']),
                        'endTime' => urlencode($info['end']),
                        'pageSize' => '50',
                        'currentPage' => $page,
                        'access_token' => $access_token
                    )));
                    if(count($result) > 0 ){
                        try {
                            $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                        } catch (Exception $e) {
                            throw new Exception($e->getMessage(),'999');exit();
                        }    
                    }
                }
            }
            $msg .= $account_name.'共同步新订单留言'.$total.'条,';        
            $page = 1;
            $total = 0;
            /* 站内信 */
            $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID,array(
                'startTime' => urlencode($info['start']),
                'endTime' => urlencode($info['end']),
                'pageSize' => '50',
                'currentPage' => $page,
                'access_token' => $access_token
            )));
            $total += $this->savedownloadMessage($result['msgList'],$info['id']);
            if($result['total'] > 50){  //总记录大于50         
                for($page = 2; $page <= ceil($result['total']/50);$page++){
                    
                    $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID.'?startTime='.urlencode($info['start']).'&endTime='.urlencode($info['end']).'&pageSize=50&currentPage='.$page.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature('param2/1/aliexpress.open/api.queryMessageList/'.$APIDevUserID,array(
                        'startTime' => urlencode($info['start']),
                        'endTime' => urlencode($info['end']),
                        'pageSize' => '50',
                        'currentPage' => $page,
                        'access_token' => $access_token
                    )));
                    if(count($result) > 0 ){
                        try {
                            $total += $this->savedownloadMessage($result['msgList'],$info['id']);
                        } catch (Exception $e) {
                            throw new Exception($e->getMessage(),'999');exit();
                        }    
                    }
                }
            }
            $msg .=  '新站内信'.$total.'条<br/>'; 
            return $msg;   
            
        }   
    }
    function savedownloadMessage($result,$id){ 
        
        $num = 0;  
        for($i=0;$i<count($result);$i++){
            $is_set = $this->db->getValue("select count(message_id) from myr_aliorder_msg where message_id =".$result[$i]['id']); 
            if(!$is_set || $is_set == 0){
                try {                               
                    $createtime = substr($result[$i]['gmtCreate'],0,4).'-'.substr($result[$i]['gmtCreate'],4,2).'-'.substr($result[$i]['gmtCreate'],6,2).' '.substr($result[$i]['gmtCreate'],8,2).':'.substr($result[$i]['gmtCreate'],10,2).':'.substr($result[$i]['gmtCreate'],12,2);
                    $havefile = 0;
                    if($result[$i]['haveFile']==true)$havefile=1;
                    $insert = array(
                        'message_id' => $result[$i]['id'], 
                        "orderId" => $result[$i]['orderId'],
                        "content" => addslashes($result[$i]['content']), 
                        "receiverLoginId" => $result[$i]['receiverLoginId'], 
                        "gmtCreate" => strtotime($createtime) ,
                        'add_time' => CFG_TIME,                        
                        "messageType" => $result[$i]['messageType'],        
                        "receiverEmail" => $result[$i]['receiverEmail'], 
                        "receiverName" => $result[$i]['receiverName'],       
                        "orderUrl" => $result[$i]['orderUrl'],                          
                        "senderName" => $result[$i]['senderName'],  
                        "senderLoginId" => $result[$i]['senderLoginId'],                  
                        "typeId" => $result[$i]['typeId'],   
                        "relationId" => $result[$i]['relationId'],
                        "account_id" => $id,
                        "readed" => $result[$i]['read'],
                        'haveFile' => $havefile,
                        'fileUrl' => $result[$i]['fileUrl'],
                        'productId' => $result[$i]['productId'],
                        'productName' => addslashes($result[$i]['productName']),
                        'productUrl' => $result[$i]['productUrl']
                    );
                    $this->db->insert('myr_aliorder_msg',$insert);
                } catch (Exception $e) {
                    throw new Exception($e->getMessage(),'999');exit();
                }     
                
                $num++; 
            }
        }
        return $num;    
    }
    /**
     * 获取message列表
     * 
     */
    function getMessageList($from,$to,$where=NULL,$sort=NULL,$type=NULL){
        if($sort){
            $sort = str_replace(","," ",$sort);
        }else{
            $sort = 'gmtCreate asc';
        }
        $account = ModelDd::getArray('aliaccount');
        $delivery = new ModelDelivery();
        $order = new ModelOrder();
        $this->db->open('SELECT DISTINCT `senderLoginId`,`senderName`,account_id,message_id,is_re,re_content from '.CFG_DB_PREFIX.'aliorder_msg '.$where.' order by gmtCreate desc',$from,$to);
        $result = array();
        $orderStatus = ModelDd::getArray('orderstatus');
        while ($rs = $this->db->next()) {
            $senid = '';
            require_once(CFG_PATH_DATA . 'ebay/ali_' . $rs['account_id'] .'.php');
            $senid = $resource_owner;
            $content = '';
            if($rs['senderLoginId'] == $senid) continue;
            $msg_option = $this->db->select("SELECT message_id,account_id,gmtCreate,senderLoginId,receiverLoginId,senderName,receiverName,content,messageType,orderId,orderUrl,productUrl,productName,productId,relationId FROM `myr_aliorder_msg` WHERE receiverLoginId = '".$rs['senderLoginId']."' OR senderLoginId = '".$rs['senderLoginId']."' order by gmtCreate desc");

            
            $rs['order_sn'] = CFG_ORDER_PREFIX.$msg_option[0]['order_sn'];
            $content = '<table style="width:99%;word-break:break-all; word-wrap:break-all;margin-bottom:5px;" cellpadding="8" cellspacing="0" >';
            for($i=0;$i<count($msg_option);$i++){
                if($msg_option[$i]['senderLoginId'] == $senid){
                    $background_color = '#FFFFF0';
                    $msg_option[$i]['senderName'] = 'Me';
                    if($i==0)$msg_option[0]['senderName'] = 'Me';
                       
                }else{
                    $background_color = '#F0FFFF';
                }
                $productString = '';
                if($msg_option[$i]['messageType'] == 'product'){
                    $alt = '';
                    $img = $this->getGoodImg($msg_option[$i]['productId'],$msg_option[$i]['account_id']);
                    if($img == '')$alt='<span style="color:blue">图片不显示请到aliexpress产品视图同步该帐号产品</span>';
                    $productString = '
                    <div class="tips-box">
                        <input class="reply-id" value="1666752755" type="hidden"> 
                        '.$alt.'
                        <div class="content" style="margin-top:-10px;">
                            <dl class="clearfix">
                                <dt class="product-img"><a href="'.$msg_option[$i]['productUrl'].'" target="_blank"><img src="'.$img.'" height="50" width="50"></a></dt>
                                <dd class="inquiry-about">
                                    <p class="strong">关于该产品:</p>
                                    <p><a style="color:blue" href="'.$msg_option[$i]['productUrl'].'" target="_blank" class="product-url">'.$msg_option[$i]['productName'].'</a></p>
                                </dd>
                            </dl>
                        </div>
                    </div>
               ';}
                $orderString = '';
                if($msg_option[$i]['messageType'] == 'order'){
                        
                    $order_info = $this->db->getValue('select order_id,order_sn,track_no,paypalid,country,Sales_account_id from '.CFG_DB_PREFIX.'order where paypalid = \''.$msg_option[$i]['orderId'].'\'');
                    
                    $orderstr = '';
                    $height = 130;
                    $goodsstr = '';
                    if(!$order_info){
                        $order_info = $this->getOneOrderDetail($msg_option[$i]['account_id'],$msg_option[$i]['orderId']);
                        //return var_dump($order_info);
                        $ordergoods = $order_info['childOrderExtInfoList'];
                        
                        for($g = 0;$g<count($ordergoods);$g++){
                            $sku = json_decode($ordergoods[$g]['sku']);
                            $goodsstr .= '<p><a href="http://www.aliexpress.com/snapshot/'.$ordergoods[$g]['productId'].'.html">'.$ordergoods[$g]['productName'].'</a></p>';        
                        }
                        
                        $orderstr = $goodsstr.'
                            <p>单号：<a style="color:blue" href="'.$msg_option[$i]['orderUrl'].'"  target="_blank">'.$msg_option[$i]['orderId'].'</a><br/>
                            收件人：'.$order_info['receiptAddress']['contactPerson'].'<br/>    
                            国家'.$order_info['receiptAddress']['country'].'</p>';
                    }
                    else{
                        
                        $ordergoods = $this->db->select('select goods_sn,goods_name,item_no,goods_qty,good_line_img from myr_order_goods where order_id = '.$order_info['order_id']);
                        
                        for($g = 0;$g<count($ordergoods);$g++){
                            $goodsstr .= '<p>SKU: '.$ordergoods[$g]['goods_sn'].'    ,  <a href="http://www.aliexpress.com/snapshot/'.$ordergoods[$g]['item_no'].'.html">'.$ordergoods[$g]['goods_name'].'</a></p>';        
                        }
                        
                        $orderstr = $goodsstr.'
                            <p>单号：<a style="color:blue" href="'.$msg_option[$i]['orderUrl'].'"  target="_blank">'.$msg_option[$i]['orderId'].'</a><br/>
                            收件人：'.$order_info['consignee'].'<br/>    
                            国家'.$order_info['country'].'</p>';
                        $trackinfo = $this->db->getValue('SELECT * FROM `myr_trackinfo` WHERE order_id = '.$order_info['order_id']);
                        if($trackinfo){
                            $height += 25;
                            $orderstr .= '<br/>运单轨迹：状态：'.$trackinfo['status'].'<br/>最近自动更新时间：'.$trackinfo['update_time'].'<br/>最新事件：'.$trackinfo['last_info'];    
                        }
                        $rs['orderId'] = $msg_option[$i]['orderId'];
                    }
                    $orderString = '
                    <div class="tips-box" style="height:'.$height.'px">
                        <input class="reply-id" value="1666752755" type="hidden"> 
                        <div style="font-family: Tahoma;font-size: 11px;">
                            <dl>
                                <dt style="margin-top:-12px;">'.$orderstr.'</dt>
                            </dl>
                        </div>
                    </div>
                   ';
                }
                $content .= '<tr style="font-size:13px;background-color: '.$background_color.';padding:3px 0;" valign="top"><td rowspan="2" style="width:68px;border-bottom:1px solid #999;"><span style="color:#06c;">'.$msg_option[$i]['senderName'].'</span></td><td><span style="color:#666;font-size:11px;width:90%">'.date('m月d日 Y年 '.$a.' h时i分',$msg_option[$i]['gmtCreate']).'   类型：'.$msg_option[$i]['messageType'].'</span></td></tr>
                <tr style="font-size:13px;background-color: '.$background_color.';padding:8px 0;" valign="top"><td style="border-bottom:1px solid #999;padding:2px;"><font style="line-height:1.5;">'.$msg_option[$i]['content'].'</font>'.$productString.$orderString.'</td></tr>';                                       
            }
            $content .= '</table>';   
            $rs['description'] = '<div style="font-size:12px;margin-left:25px">最后回复：<font style="color:#06c">'.$msg_option[0]['senderName'].'</font>&nbsp;&nbsp;&nbsp;&nbsp;'.$msg_option[0]['content'].'</div>';                  
            $rs['order_sn'] = 'Unknown';
            $rs['content'] = $content; 
            
            $rs['title'] = '来自 ：'.$rs['senderName'];
            
            $rs['link'] = $msg_option[0]['orderUrl']; 
            $rs['url'] = $msg_option[0]['orderUrl'];
            $rs['account_name'] = $account[$msg_option[0]['account_id']];
            $rs['pubDate'] = date('m月d日 Y年 ',$msg_option[0]['gmtCreate']); 
            $rs['author'] = $msg_option[0]['senderName'];
            $rs['is_re'] = $rs['is_re'];
            $rs['re_content'] = $rs['re_content'];
            if(strlen($rs['description'])>140){
                $rs['description'] = substr($rs['description'], 0, 140).'...';
            }                                                               
            $result[] = $rs;
        }
        return $result;
    }
    /**
     * 获取条数
     * @param string $where
     */
    function getMessageCount($where=NULL){
        return $this->db->getValue('select count(message_id) from '.CFG_DB_PREFIX.'aliorder_msg '.$where);
    }
    /**
     * 生成查询条件
     * @param array $info
     */
    function getMessageWhere($info){
        specConvert($info,array('account','keyword','type','readed'));
        $wheres = array();
        
        if($info['keyword']){
            /* senderLoginId,receiverLoginId,senderName,receiverName,content,messageType,orderId,productUrl,productName,*/
           //$wheres[] = 'orderId= \''.$info['keyword'].'\'';  
           $wheres[] = 'senderName LIKE \''.$info['keyword'].'\' or receiverName  LIKE \''.$info['keyword'].'\' or orderId  LIKE \''.$info['keyword'].'\' or content  LIKE \'%'.$info['keyword'].'%\'';
        }else{
            if($info['type']=='order'){
               $wheres[] = 'messageType= \''.$info['type'].'\'';  
            } 
            if($info['type']=='product'){
               $wheres[] = 'messageType = \'product\'';  
            }
            if($info['type']=='store'){
               $wheres[] = 'messageType = \'store\'';  
            }
            if($info['type']=='member'){
               $wheres[] = 'messageType = \'member\'';  
            }
            if($info['account']){
               $wheres[] = 'account_id= '.$info['account'];  
            }
            if($info['readed']){                
                if($info['readed']=='0')$info['readed']=' ';
                $wheres[] = 'readed=\''.$info['readed'].'\'';
            }    
        }
        $where = '';
        if ($wheres) {
            $where = ' where ' . implode(' and ', $wheres);
        }
        return $where;
    }
    /**
     * 站内信标记已读
     * @param array $info
     */
    function MarkMsgali($info){
        
        $msg = '';
        //http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.updateReadOrderMessage?
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        
        $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.updateReadOrderMessage/'.$APIDevUserID.'?typeId='.$info['orderId'].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.findOrderById/".$APIDevUserID,array(
                        'orderId' => $orders[$i]['orderId'],
                        'access_token' => $access_token
                    )));   
        if($result['success']){
            $this->db->update(CFG_DB_PREFIX.'aliorder_msg',array('readed'=>'1'),'orderId = '.$info['orderId']);
            return '更新已读';
        }
    }
    function sendorcerMsg($info){    
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $info['id'] .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }                                           
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        $msg_info = $this->db->getValue('select * from '.CFG_DB_PREFIX.'aliorder_msg where message_id = '.$info['message_id']);
        
        if($msg_info['messageType'] == 'order'){
            $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.addOrderMessage/'.$APIDevUserID.'?orderId='.$msg_info['orderId'].'&content='.urlencode($info['content']).'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.addOrderMessage/".$APIDevUserID,array(
            'orderId' => $msg_info['orderId'],
            'content' => urlencode($info['content']),
            'access_token' => $access_token
        )));    
        }else{
            $result = $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.addMessage/'.$APIDevUserID.'?buyerId='.$msg_info['senderLoginId'].'&content='.urlencode($info['content']).'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.addMessage/".$APIDevUserID,array(
            'buyerId' => $msg_info['senderLoginId'],
            'content' => urlencode($info['content']),
            'access_token' => $access_token
        )));
        }
        
        if($result == 0){
            $this->RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.updateReadOrderMessage/'.$APIDevUserID.'?typeId='.$msg_info['orderId'].'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.updateReadOrderMessage/".$APIDevUserID,array(
            'typeId' => $msg_info['orderId'],
            'access_token' => $access_token
        )));
            $this->db->update(CFG_DB_PREFIX.'aliorder_msg',array('is_re'=>1,'re_content'=>$info['content']),'orderId = '.$msg_info['orderId']);
            return $result;
        }else{
            return $result;
        }
    }
    function getMsgTypeInfoCount($type){
        $result = array();
        foreach($type as $k => $v){               
            
            if($v['type'] == 'order'){
                $qty = $this->db->getValue("Select count(message_id) from ".CFG_DB_PREFIX."aliorder_msg where messageType = 'order' and readed  = '".$v['read']."'");            
                $result[] = array(
                    'url' => 'readed='.$v['read'].'&type=order',  
                    'title' => $v['title'].'&nbsp;&nbsp;&nbsp;<font style="color:#999">[</font><font style="color:#f15628">'.$qty.'</font><font style="color:#999">]</font>',
                    'id' => '',
                    'type' => $v['type']
                );
            }
            if($v['type'] == 'msg'){
                $qty = $this->db->getValue("Select count(message_id) from ".CFG_DB_PREFIX."aliorder_msg where messageType in('product','member','store') and readed  = '".$v['read']."'");            
                $result[] = array(  
                    'url' => 'readed='.$v['read'].'&type=msg',  
                    'title' => $v['title'].'&nbsp;&nbsp;&nbsp;<font style="color:#999">[</font><font style="color:#f15628">'.$qty.'</font><font style="color:#999">]</font>',
                    'id' => '',
                    'type' => $v['type']
                );
            }
            if($v['type'] == 'account'){
                $qty = $this->db->getValue("Select count(message_id) from ".CFG_DB_PREFIX."aliorder_msg where account_id = ".$v['id']);            
                $title = $v['title'];
                if(strlen($v['title']) > 18)$title = substr($v['title'], 0, 18).'...';
                $result[] = array(
                    'url' => 'type=account&account='.$v['id'],
                    'title' => $title.'&nbsp;&nbsp;&nbsp;<font style="color:#999">[</font><font style="color:#f15628">'.$qty.'</font><font style="color:#999">]</font>',
                    'id' => $v['id'],
                    'type' => $v['type']
                ); 
            }               
        }
        return $result;        
    }
    function getGoodImg($productId,$id){
        $product_img = $this->db->getValue('SELECT goods_img FROM `myr_aligoods` WHERE `ali_good_id` = '.$productId);
        if(!$product_img){
               $result = $this->getOneProductInfo($productId,$id,true); 
               $product_img = $result['goods_img'];
        }
        return $product_img;
    }
    function getOneProductInfo($productId,$id,$save){
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $id .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        
        $result = $this -> RequestAli('http://gw.api.alibaba.com/openapi/param2/1/aliexpress.open/api.findAeProductById/'.$APIDevUserID.'?productId='.$productId.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.findAeProductById/".$APIDevUserID,array(
            'productId' => $productId,
            'access_token' => $access_token
        )));
        if($save==true){
            if($result['productStatusType'] == 'onSelling'){
                $goods_status = 0;
            }elseif($result['productStatusType'] == 'offline'){
                $goods_status = 2;
            }elseif($result['productStatusType'] == 'auditing'){
                $goods_status = 0;
            }elseif($result['productStatusType'] == 'editingRequired'){
                $goods_status = 1;
            }
            $imgarr = explode(';',$result['imageURLs']);
            $result['goods_img'] = $result['isImageDynamic'] == 0 ? $result['imageURLs'] : $imgarr[0];
            $this->SaveDownProduct($result,$id);
            return $result;    
        }
    }
    function SaveDownProduct($result,$id){
        
        $this->db->insert(CFG_DB_PREFIX.'aligoods',array(
            'last_update_time' => 0,
            'deliveryTime' => $result['deliveryTime'],
            'categoryId' => $result['categoryId'],
            'aeopAeProductSKUs' => json_encode($result['aeopAeProductSKUs']),
            'skuCode' => $result['aeopAeProductSKUs'][0]['skuCode'],
            'keyword' => addslashes($result['keyword']),
            'productMoreKeywords1' => addslashes($result['productMoreKeywords1']),
            'productMoreKeywords2' => addslashes($result['productMoreKeywords2']),
            'productPrice' => $result['aeopAeProductSKUs'][0]['skuPrice'],
            'productUnit' => $result['productUnit'],
            'freightTemplateId' => $result['freightTemplateId'],
            'isImageDynamic' => $result['isImageDynamic'],
            'is_upload' => 0,
            'lotNum' => $result['lotNum'],
            'packageType' => ($result['packageType']==false)?0:1,
            'ali_good_id' => $result['productId'],
            'aeopAeProductPropertys' => addslashes(json_encode($result['aeopAeProductPropertys'])),
            'goods_status' => $result['productStatusType'],
            'ownerMemberId' => $result['ownerMemberId'],
            'wsOfflineDate' => $result['wsOfflineDate'],
            'wsDisplay' => $result['wsDisplay'],
            'wsValidNum' => $result['wsValidNum'],
            'goods_name' => addslashes($result['subject']),
            'groupId' => $result['groupId'],
            'bulkOrder' => $result['bulkOrder'],
            'bulkDiscount' => $result['bulkDiscount'],
            'goods_img' => $result['goods_img'],
            'imageURLs' =>  $result['imageURLs'],
            'packageLength' => $result['packageLength'],
            'packageWidth' => $result['packageWidth'],
            'packageHeight' =>  $result['packageHeight'],
            'grossWeight' =>  $result['grossWeight'],
            'detail' =>  addslashes($result['detail']),
            'account_id' => $id,
            'status' => $goods_status
        ));        
    }
    function del_allmsg(){
        $this->db->execute('delete from '.CFG_DB_PREFIX.'aliorder_msg');    
    }
    /**
     * 获取产品列表
     * 
     */
    function getAliWaitupload($from,$to,$where=NULL,$sort=NULL){
        if($sort){
            $sort = str_replace(","," ",$sort);
        }else{
            $sort = 'id asc';
        }
        $account = ModelDd::getArray('aliaccount');
        $this->db->open('select id,skuCode,goods_name,lotNum,ali_good_id,packageType,productPrice,wsOfflineDate,goods_img,account_id,bulkOrder,bulkDiscount,goods_status,status,imageURLs,packageLength,packageWidth,packageHeight,grossWeight from '.CFG_DB_PREFIX.'aligoods  '.$where.' order by '.$sort,$from,$to);
        $result = array();
        while ($rs = $this->db->next()) {
            $sku_str = '';
            $price_str = '';
            $imgarr = explode(';',$rs['imageURLs']);
            $rs['goods_img'] = $imgarr[0];
            $sku_str = $rs['skuCode'];
            if($rs['bulkOrder'] > 0){
                $a=$rs['bulkDiscount']/100;
                $b=$rs['productPrice']*$a;
                $c = round(($rs['productPrice']-$b), 2);
                $price_str = $rs['productPrice'].'-'.$c;
            }else{
                $price_str = $rs['productPrice'];
            }
            
            $rs['account_name'] = $account[$rs['account_id']];
            $rs['skuCode'] = $sku_str;
            $rs['productPrice'] = $price_str;
            $rs['goods_status'] = $this->ChangeAliStatus($rs['goods_status']);
            $result[] = $rs;
        }
        return $result; 
    }
    function getOneOrderDetail($account,$orderid){
        set_time_limit(30);
        require_once(CFG_PATH_DATA . 'ebay/ali_' . $account .'.php');    
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($account); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(
                'appkey'=>$APIDevUserID,
                'appSecret'=>$APIPassword,
                'refresh_token'=>$refresh_token,
                'id'=>$account,
                'longpasstime'=>$longpasstime
            ));
        }
        
        $result = $this -> RequestAli('http://gw.api.alibaba.com:80/openapi/param2/1/aliexpress.open/api.findOrderById/'.$APIDevUserID.'?orderId='.$orderid.'&access_token='.$access_token."&_aop_signature=".$this->_aop_signature("param2/1/aliexpress.open/api.findOrderById/".$APIDevUserID,array(
            'orderId' => $orderid,
            'access_token' => $access_token
        )));  
        return $result;      
    }
 }
?>
