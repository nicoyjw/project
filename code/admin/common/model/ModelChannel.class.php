<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 各渠道订单处理类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelChannel extends ModelOrder{
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
	}
    
    /**
     * 加载magento订单
     * 
     */
    function savemgorder($inco){
        set_time_limit(50000);
        require_once(CFG_PATH_DATA . 'ebay/mg_' . $inco['id'] .'.php');
        try { 
            if($url[count($url)] == '/') unset($url[count($url)]);    
            
            $client = new SoapClient($url."index.php/api/?wsdl");    
            $sessionID  =  $client -> login ($APIDevUserID,$APIPassword);    
            $orders = $client -> call($sessionID,'sales_order.list'/*,array(array('status' =>'Processing'))*/);
            $num = 0;
            for($i = 0;$i<count($orders);$i++){
                    $orderInfo = $client->call($sessionID,'sales_order.info',$orders[$i]['increment_id']);
                    $productCount = count($orderInfo['items']);
                for($j = 0;$j<$productCount;$j++)
                {
                    $info[$i]['Sales_account_id'] = $inco['id'];
                    $info[$i]['consignee'] = $orders[$i]['shipping_name'];
                    $info[$i]['currency'] = $orderInfo['store_currency_code'];
                    $info[$i]['order_amount'] = $orderInfo['base_grand_total'];
                    $info[$i]['userid'] = $orders[$i]['shipping_name'];
                    $info[$i]['order_status'] = $orderInfo['status'];
                    $info[$i]['shipping_fee'] = $orderInfo['base_shipping_amount'];
                    $info[$i]['CountryCode'] = $orderInfo['store_currency_code'];        
                    $info[$i]['email'] = $orders[$i]['customer_email']; 
                    $info[$i]['tel'] = $orderInfo['shipping_address']['telephone']; 
                    $info[$i]['zipcode'] = $orderInfo['shipping_address']['postcode']; 
                    $info[$i]['state'] = $orderInfo['shipping_address']['region'];
                    $info[$i]['city'] = $orderInfo['shipping_address']['city'];
                    $info[$i]['country'] = $orderInfo['shipping_address']['country_id'];
                    $info[$i]['street1'] = $orderInfo['shipping_address']['street'];  
                    $info[$i]['order_id'] = $orderInfo['order_id'];
                    $info[$i]['paypalid'] = $orderInfo['order_id'];
                    $info[$i]['SKU'] = $orderInfo['items'][$j]['sku'];
                    $info[$i]['goods_qty'] = $orderInfo['items'][$j]['qty_shipped']; 
                    $info[$i]['name'] = $orderInfo['items'][$j]['name']; 
                    $info[$i]['goods_price'] = $orderInfo['items'][$j]['price'];
                    $info[$i]['TransactionID'] = $orderInfo['items'][$j]['product_id'];
                    $this->saveimport($info[$i]);
                    $num++;
                }
            }
            return $num;
        }
        catch(Exception $e) 
        {            
            throw new Exception($e->getMessage(),'002');exit();
        }
    }
	/**
	 * 检查保存ebay订单文件
	 *
	 * @param array $info
	 * @return string
	 */
	function saveEbayorder($info)
	{                     
		set_time_limit(0);
        require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
        $info['stime'] = ($info['stime'])?str_pad($info['stime'], 2, '0', STR_PAD_LEFT):'00';
        $info['etime'] = ($info['etime'])?str_pad($info['etime'], 2, '0', STR_PAD_LEFT):'23';
        //$data['start'] = $info["start"].'T'.$info['stime'].':00:00.000Z';
        //$data['end'] = $info["end"].'T'.$info['etime'].':59:59.000Z';
        $data['start'] = $info["start"].'T'.'00:00:00.000Z';
        $data['end'] =     $info["end"].'T'.'23:59:59.000Z';
        $verb = 'GetSellerTransactions';
        $page = 1;
        $hasmore = false;
        try {
                $this->saveEbayxml($info['id'],$verb,1,$data);
        } catch (Exception $e) {
                    throw new Exception('保存eba订单文件失败','999');exit();
        }
        $xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['id'] .'_'.$page.'.xml');
            if($request=XML_unserialize($xml)){
                $getorder = $request['GetSellerTransactionsResponse'];
                if($getorder['Errors']){
                        $errormsg = $getorder['Errors']['ErrorCode'] ." " .    $getorder['Errors']['ShortMessage'] ." " . @$getorder['Errors']['LongMessage'];
                        throw new Exception($errormsg,'900');exit();
                }
            }else{
                throw new Exception('读取数据失败','103');exit();
            }
            $totalcount = ceil($getorder['PaginationResult']['TotalNumberOfEntries']/199);
        for($page = 2;$page <= $totalcount; $page++ ){
            try {
                    $this->saveEbayxml($info['id'],$verb,$page,$data);
            } catch (Exception $e) {
                        throw new Exception('保存Page'.$page.'失败','999');exit();
            }
        }
        return $info['id'].'|'.$totalcount.'|'.$getorder['PaginationResult']['TotalNumberOfEntries'];
	}
     /**
     * 加载ebay订单文件XML文件
     *
     * @param string $info
     * @return $counter 加载的数量
     */
    function loadXml($xml){
        $id = $xml['id'];
        require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
        $xml =file_get_contents(CFG_PATH_DATA . 'ebay/GetSellerTransactions_'. $id .'_'.$xml['page'].'.xml');
            if($data=XML_unserialize($xml)){
                $getorder = $data['GetSellerTransactionsResponse'];
            }else{
                savepost($xml,CFG_PATH_ERR.time().'.txt');
                throw new Exception('读取数据失败2','103');exit();
            }
        $counter = 0;
        $info['sellerID'] = $getorder['Seller']['UserID'];//卖家账号ID
        $Trans = (@array_key_exists('CreatedDate', $getorder['TransactionArray']['Transaction']))?@$getorder['TransactionArray']:@$getorder['TransactionArray']['Transaction'];
        require(CFG_PATH_DATA . 'dd/currency.php');
        foreach((array)$Trans as $Transaction){
            $eBayPaymentStatus = $Transaction['Status']['eBayPaymentStatus'];
            $CompleteStatus = $Transaction['Status']['CompleteStatus'];
            $info['paid_time'] = MyDate::transform('timestamp',@$Transaction['PaidTime']);                   //付款时间
            $ShippedTime = @$Transaction['ShippedTime'];
            if($ShippedTime) {
                $info['shipping_time'] = MyDate::transform('timestamp',$ShippedTime); //发货时间
                $info['track_no'] = @$Transaction['ShippingDetails']['ShipmentTrackingDetails']['ShipmentTrackingNumber'];
            }else{
                $info['shipping_time'] = 0;
                $info['track_no'] = '';    
            }
            if($eBayPaymentStatus!='NoPaymentFailure'||$CompleteStatus!='Complete') continue;//非正常订单状态
            /*******
            buyer节点
            ********/
            $Buyer = @$Transaction['Buyer'];
            $info['email'] = @$Buyer['Email'];          //email
            $info['userid'] = @addslashes($Buyer['UserID']);        //userid
            $goods['TransactionID'] = @$Transaction['TransactionID'];
            $goods['ebay_orderid'] = @$Transaction['ContainingOrder']['OrderID'];
            $goods['ebay_CreatedDate'] = MyDate::transform('timestamp',$Transaction['CreatedDate']);   //交易创建时间
            $paypalid = @$Transaction['ExternalTransaction']['ExternalTransactionID'];
            if($info['paid_time']==''){//$paypalid == 'SIS' && 
                echo '<br>'.$info['userid']."存在未付款交易";
                if(CFG_CHECK_SIS != 1) continue;
            }
            if(@$Transaction['ExternalTransaction'][0]['PaymentOrRefundAmount']<0 || @$Transaction['ExternalTransaction'][1]['PaymentOrRefundAmount']<0 ){
                echo '<br>'.$info['userid']."存在退款交易".$paypalid."交易金额".$Transaction['ExternalTransaction'][0]['PaymentOrRefundAmount'];
                continue;
                }
            $info['FEEAMT'] = @$Transaction['ExternalTransaction']['FeeOrCreditAmount'];
            $Item = $Transaction['Item'];
            $goods['item_no'] = $Item['ItemID'];                   // ebay产品id
            if(CFG_IGONRE_ORDER == 1 && $info['shipping_time']) continue;
            $old_order_id = $this->db->getValue('SELECT c.order_id FROM (select a.order_id,b.TransactionID,b.item_no from ' . $this->tableName.' as a left join '.$this->infotableName.' as b on a.order_id = b.order_id where  a.Sales_account_id = '.$id.') as c where c.TransactionID = \''.$goods['TransactionID'].'\' and c.item_no = \''.$goods['item_no'].'\'');
            if($old_order_id) {
                //echo $info['userid'].'创建时间'.$goods['ebay_CreatedDate'].'交易'.$goods['TransactionID'].'已存在<br>';
                if($info['shipping_time'] && CFG_UPDATE_ORDER == 1) {
                    $this->db->execute("update ".$this->tableName." set shipping_time ='".$info['shipping_time']."' AND track_no = '".$info['track_no']."' WHERE order_id = '".$old_order_id."'");
                }
                continue;//已存在交易
            }
            $info['paypalid'] = ($paypalid =="")?'kong'.$this->get_order_sn():$paypalid;
            $goods['OrderLineItemID'] = @$Transaction['OrderLineItemID'];
            if($goods['OrderLineItemID'] == '') $goods['OrderLineItemID']= $goods['item_no'].'-'.$goods['TransactionID'];/// fix missing OrderLineItemID
            $info['order_amount']  = @$Transaction['AmountPaid']; //总付款金额
            $info['pay_note']  = @$Transaction['BuyerCheckoutMessage']; //总付款金额
            $info['ShippingService'] = $Transaction['ShippingServiceSelected']['ShippingService'];
            /*******
            BuyerInfo节点
            ********/
            $country = @$BuyerInfo['CountryName'];
            if(!isset($BuyerInfo['CountryName'])){
                if(isset($BuyerInfo['Country']) && !empty($BuyerInfo['Country'])){
                    $country = $this->db->getValue("select country from myr_country where cn_country = '".@$BuyerInfo['Country']. "'");
                }
            }  
            $BuyerInfo = $Buyer['BuyerInfo']['ShippingAddress'];
            $info['consignee'] = $BuyerInfo['Name'];
            $info['PayPalEmailAddress'] = @$Transaction['PayPalEmailAddress'];
            $info['street1'] = str_replace(chr(128).chr(168),'',$BuyerInfo['Street1']);
            $info['street2'] = str_replace(chr(128).chr(168),'',@$BuyerInfo['Street2']);
            $info['city'] = @$BuyerInfo['CityName'];
            $info['state'] = @$BuyerInfo['StateOrProvince'];
            $info['CountryCode'] = $country;
            $info['country'] = $this->db->getValue('select country from myr_country where code = "'.$BuyerInfo['Country'].'"');
            $info['zipcode'] = @$BuyerInfo['PostalCode'];
            $info['tel'] = (@$BuyerInfo['Phone']=="Invalid Request")?"":$BuyerInfo['Phone'];
            $info['sellsrecord'] = @$Transaction['ShippingDetails']['SellingManagerSalesRecordNumber'];
            /*******
            item节点
            ********/
            $CategoryID = @$Item['PrimaryCategory']['CategoryID']; //ebay登录的种类编号，备用字段
            $info['currency'] = $Item['Currency'];                            //货币类型
            $info['rate'] =$currency[$info['currency']];
            $info['FinalValueFee'] = @$Transaction['FinalValueFee']*$currency[@$Transaction['FinalValueFee attr']['currencyID']]/$currency[$Transaction['Item']['Currency']]; //成交费
            $goods['goods_name'] = $Item['Title'];                                  //产品标题名称
            $SKU = @$Item['SKU'];
            $SKU = (substr($SKU,0,1) == '-')?substr($SKU,1):$SKU;
            $goods['goods_price'] = $Item['SellingStatus']['CurrentPrice'];   //产品当前价格
            $goods['bid_count'] = @$Item['SellingStatus']['BidCount'];//参与拍卖人数
            $goods['goods_qty'] = $Transaction['QuantityPurchased'];   //购买数量
            
            $goods['good_line_img'] = $this->getebayImg($goods['item_no']);   //ebay商品图片  2015-06/05 nic
            
            
            $info['sales_site'] = $Transaction['TransactionSiteID'];
            $goods['StartPrice'] = @$Item['StartPrice'];

            $info['add_time'] = CFG_TIME;
            $info['shipping_fee']=@$Transaction['ShippingServiceSelected']['ShippingServiceCost'];
            $info['Sales_account_id'] = $id;
            $info['order_status'] = 111;
            if(CFG_CHECK_PAYPAL == 1) $info['order_status'] = $this->getorderflow(12)?$this->getorderflow(12):"112";
            $oldorder = $this->db->getValue('select order_id,order_status,order_sn from '.$this->tableName.' where paypalid = \''.$info['paypalid'].'\' and userid = \''.$info['userid'].'\' and paid_time = \''.$info['paid_time'].'\''); //同样的paypalid的使用同种订单编码
            $order_id = $oldorder['order_id'];
            if(($oldorder['order_status'] <> $info['order_status'])&&($oldorder['order_status'] <> 131) && $order_id){//加载回来原定的状态已改变
                $order_id = 0;
                echo $info['userid'].'买家item'.$goods['item_no'].'交易'.$goods['TransactionID'].'已存在,订单号为'.CFG_ORDER_PREFIX.$oldorder['order_sn'].',由于该订单已审核,此条产品将会重新变成新订单加载，请注意合并<br>';
            }
            if(!$order_id) {//相同paypalid的作为同一个订单处理
                                $info['order_sn'] = $this->get_order_sn();
                                try {
                                        $this->db->insert($this->tableName, addslashes_deep($info));
                                        $order_id = $this->db->getInsertId();
                                        if($info['shipping_time']>0) $this->db->update($this->tableName,array('order_status' => 131,'is_mark' => 1,'print_status'=>1,'stockout_sn'=>'AllreadyMark'),'order_id='.intval($order_id));
                                 } catch (Exception $e) {
                                        throw new Exception('保存订单失败,paypalid为'.$paypalid,'999');continue;
                                  }
                                $counter++;
                            }else{
                                if($this->db->getValue('select count(*) from '.$this->infotableName.' where order_id = "'.$order_id.'" and item_no="'.$goods['item_no'].'" and TransactionID="'.$goods['TransactionID'].'"') == 0) $this->db->execute("update ".$this->tableName." set FinalValueFee=FinalValueFee+".$info['FinalValueFee']." where order_id = ".$order_id);    
                            }
                if($this->db->getValue('select count(*) from '.$this->infotableName.' where order_id = "'.$order_id.'" and item_no="'.$goods['item_no'].'" and TransactionID="'.$goods['TransactionID'].'"') == 0){ 
                    try{
                        $goods['sn_prefix'] = '';
                        $goods['goods_sn'] = $SKU;
                        if(CFG_GOODSSN_PREFIX >0){
                                $goods['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
                                $goods['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
                            }else{
                        $goods['goods_sn'] = $this->getRealSKU($SKU);
                    }
                            $goods['order_id'] = $order_id;
                    $this->db->insert($this->infotableName, addslashes_deep($goods));
                                } catch (Exception $e) {
                            throw new Exception('加载中断，保存订单明细失败,订单号'.CFG_ORDER_PREFIX.$order_id,'999');exit();
                    }
                }
        }
        return $counter;
    }
    
    
    function getebayImg($ITEMNO){                 
      
        $res_curl = curl_init();
        curl_setopt($res_curl, CURLOPT_URL,"http://item.ebay.com/".$ITEMNO);
        curl_setopt($res_curl, CURLOPT_TIMEOUT, 30);                         
        curl_setopt($res_curl, CURLOPT_RETURNTRANSFER, 1); 
        $str_data = curl_exec($res_curl);
             
        $regex = "/<img id=\"icImg\".*? src=\"(.*?)\".*?>/i"; 
        
        preg_match_all($regex,$str_data,$res);
        
        return $res[1][0];                  
        
    }
    /**
     * 请求Ebay xml 2014-05-28
     * nic
     *
     * @param string $id  ebay_account_id
     * @param string $verb  ebay api type
     * @param $page load page
     * @param $data include what used to send
     */
    static function saveEbayxml($id,$verb,$page,$data,$add=''){
        require(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php');
        require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
        $add = ($add == '')?'':'_'.$add;
        $file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.$add.'.xml';
        $session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
        $responseXml = $session->sendHttpRequest($requestXmlBody);
        if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400');
        if($fp=fopen($file,'w')){
             if(!fwrite($fp,$responseXml)){
                 throw new Exception('不能写入数据','100');
             }
             fclose($fp);
         }else{
         throw new Exception('不能写入数据','101');
         }
    }
	/**
	 * 检查保存淘宝订单文件
	 *
	 * @param array $info
	 * @return string
	 */
	function savetborder($info)
	{
		set_time_limit(0);
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$data['start'] = date('Y-m-d H:i:s',strtotime($info["start"]." 00:00:00"));
		$data['end'] = date('Y-m-d H:i:s',strtotime($info["end"]." 23:59:59"));
		$verb = 'taobao.trades.sold.get';
		$page = 1;
		try {
				$this->savetbxml($info['id'],$verb,1,$data);
		} catch (Exception $e) {
					throw new Exception('保存淘宝订单文件失败','999');exit();
		}
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['id'] .'_'.$page.'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request['trades_sold_get_response'];
				if(!$getorder){
						$errormsg = $request['error_response']['code'] ." " .	$request['error_response']['msg'] ;
						throw new Exception($errormsg,'900');exit();
				}
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
			$totalcount = ceil($getorder['total_results']/100);
		for($page = 2;$page <= $totalcount; $page++ ){
			try {
					$this->savetbxml($info['id'],$verb,$page,$data);
			} catch (Exception $e) {
						throw new Exception('保存Page'.$page.'失败','999');exit();
			}
		}
		return $info['id'].'|'.$totalcount.'|'.$getorder['total_results'];
	}

	function saveazorder($info)
	{
		set_time_limit(0);
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$data['start'] = date('Y-m-d H:i:s',strtotime($info["start"]." 00:00:00"));
		$data['end'] = date('Y-m-d H:i:s',strtotime($info["end"]." 23:59:59"));
		$page = 1;
		$verb = 'ListOrders';
		try {
				$this->saveazxml($info['id'],$verb,1,$data);
		} catch (Exception $e) {
				throw new Exception($e->getMessage(),'999');exit();
		}
		$next = $this->loadazXML($info['id'],$verb,1);//加载订单
		if($next == ''){
			return 0;
		}elseif($next == '0'){//只有单页订单
			return 1;
			}else{//有多页订单
			$nextverb = 'ListOrdersByNextToken';
			while($next != '0')
			{
				if($page >= 5) {throw new Exception('订单量超过200请缩短时间区间或使用REPORT加载','999');exit();}
				$data['nexttoken'] = $next;
				try {
							$this->saveAzXml($info['id'],$nextverb,$page,$data);
					} catch (Exception $e) {
							throw new Exception('保存Amazon分页订单文件失败','999');exit();
					}
				$next = $this->loadazXML($info['id'],$nextverb,$page);
				$page++;
			}
			return $page;
		}
	}
	
	function loadazorderitem($info)
	{
		$orderlist =$this->db->select("SELECT order_id,paypalid FROM ".$this->tableName." WHERE Sales_account_id	=".$info['id']." AND order_status = 111");
		$verb = 'ListOrderItems';
		$nextverb = 'ListOrdersByNextToken';
		$num = 0;
		for($i=0;$i<count($orderlist);$i++){
			$page = 1;
			if($this->saveAzXml($info['id'],$verb,$i+1,$orderlist[$i])) $num++;
			$next = $this->loadorderitemXML($orderlist[$i]['order_id'],$info['id'],$verb,$i+1);//加载订单产品
				while($next != '0')
				{
					$data['nexttoken'] = $next;
					try {
								$this->saveAzXml($info['id'],$nextverb,$page,$data);
						} catch (Exception $e) {
								throw new Exception('保存Amazon分页订单明细文件失败','999');exit();
						}
				try {
							$next = $this->loadorderitemXML($orderlist[$i]['order_id'],$info['id'],$nextverb,$page);
							$page++;
					} catch (Exception $e) {
							throw new Exception('保存Amazon分页订单明细数据失败','999');exit();
					}
				}
				$this->db->execute("UPDATE ".$this->tableName." SET order_status = 112 where shipping_time =0 and order_id =".$orderlist[$i]['order_id']);
				$this->db->execute("UPDATE ".$this->tableName." SET order_status = 131, is_mark = 1,print_status=1 where shipping_time >0 and order_id =".$orderlist[$i]['order_id']);
				/////////FBA订单
				if(CFG_AUTO_FBA == 1){
					if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." where is_lock =0 AND ShippingService='AFN' AND shipping_time >0 and order_id =".$orderlist[$i]['order_id'])){//没有扣除库存的
						$this->check_rule($orderlist[$i]['order_id']);
						$this->unlock($orderlist[$i]['order_id'],1,0);//扣除库存
						$this->db->execute("update ".$this->tableName." set is_lock = 2 where order_id= ".$orderlist[$i]['order_id']);
						}
					}
				$num++;		
			}
			return $num;
	}
	
	
	function loadorderitemXML($orderid,$id,$verb,$page)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request[$verb.'Response'];
				$info['ebay_orderid'] = $getorder[$verb.'Result']['AmazonOrderId'];
				//return var_dump();
				$Trans = (@array_key_exists('OrderItemId', $getorder[$verb.'Result']['OrderItems']['OrderItem']))?@$getorder[$verb.'Result']['OrderItems']:@$getorder[$verb.'Result']['OrderItems']['OrderItem'];
				foreach((array)$Trans as $Transaction){
					$info['OrderLineItemID'] = $Transaction['OrderItemId'];
					if($this->db->getValue("SELECT count(*) FROm ".$this->infotableName." WHERE OrderLineItemID = '".$info['OrderLineItemID']."' and order_id =".$orderid)>0) continue;
					
					
					/*//获取订单产品图片
					$productverb = 'GetMatchingProduct';
					$data['ASIN'] = $Transaction['ASIN'];
					$this->saveAzProductXml($id,$verb,$page,$data);*/
					$info['order_id'] = $orderid;
					$info['item_no'] = $Transaction['ASIN'];
					
					$SKU = $Transaction['SellerSKU'];
					$info['goods_sn'] = $SKU;
					if(CFG_GOODSSN_PREFIX >0){
						$info['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
						$info['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
					}else{
						$info['goods_sn'] = $this->getRealSKU($SKU);
					}
					$info['goods_qty'] = $Transaction['QuantityOrdered'];
					$info['goods_price'] = $Transaction['ItemPrice']['Amount']/$Transaction['QuantityOrdered'];
					$info['goods_name'] = $Transaction['Title'];
					$this->db->insert($this->infotableName,addslashes_deep($info));
					if($Transaction['ShippingPrice']['Amount']>0) $this->db->execute("UPDATE ".$this->tableName." SET shipping_fee = shipping_fee + ".$Transaction['ShippingPrice']['Amount']." where order_id =".$orderid);
				}
				$nexttoken = @$getorder[$verb.'Result']['NextToken'];
				return $nexttoken?$nexttoken:0;  
			}else{
				throw new Exception('读取数据失败','103');exit();
			}			
	}
	function saveAzProductXml($id,$verb,$page,$data)
	{
		require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
		if(!isset($site)) $site = 1;
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id.'.xml';
		 require(CFG_PATH_LIB."amazon/product/amazon.php");
		 require_once(CFG_PATH_LIB."amazon/product/GetMatchingProductRequest.php");
		 $request = new MarketplaceWebServiceProducts_Model_GetMatchingProductForIdRequest();
		 $request->setSellerId($MERCHANT_ID);
		 $request->setIdType('ASIN');
		 $request->setIdList($data['ASIN']);
		 $request->setMarketplaceId($MARKETPLACE_ID);
		 $responseXml = $service->GetMatchingProductForId($request);
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('产品保存文件失败1','100');
			 }
			 @chmod($file, 0777);
			 fclose($fp);
		 }else{
		 throw new Exception('产品保存文件失败2','101');
		 }
	}

	/******************
	**加载amazon   listorder & by nexttoken
	**$verb 对应ListOrders 和
	**
	**
	******************/
	
	function loadazXML($id,$verb,$page)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request[$verb.'Response'];
				if(!$getorder[$verb.'Result']['Orders']) return;
				$Trans = (@array_key_exists('AmazonOrderId', $getorder[$verb.'Result']['Orders']['Order']))?@$getorder[$verb.'Result']['Orders']:@$getorder[$verb.'Result']['Orders']['Order'];
			require(CFG_PATH_DATA . 'dd/currency.php');
			require(CFG_PATH_DATA . 'dd/countrycode.php');
				foreach((array)$Trans as $Transaction){
					$orderstatus = $Transaction['OrderStatus'];
					if($orderstatus <>'Canceled' && $orderstatus <>'Pending'){
						$info['paypalid'] = $Transaction['AmazonOrderId'];
						if($this->db->getValue("SELECT count(*) FROm ".$this->tableName." WHERE paypalid = '".$info['paypalid']."' and Sales_account_id =".$id)>0) continue;
						$info['order_sn'] = $this->get_order_sn();
						$info['paid_time'] = MyDate::transform('timestamp',$Transaction['PurchaseDate']); 
						$info['ShippingService'] = $Transaction['FulfillmentChannel'];
						$info['order_amount']  = @$Transaction['OrderTotal']['Amount']; //总付款金额
						$info['currency'] = @$Transaction['OrderTotal']['CurrencyCode'];                            //货币类型
						$info['rate'] =$currency[$info['currency']];
						$info['email'] = @$Transaction['BuyerEmail'];
						$info['sellerID'] = $MERCHANT_ID;
						$BuyerInfo = $Transaction['ShippingAddress'];
						$info['consignee'] = $BuyerInfo['Name'];
						$info['street1'] = str_replace(chr(128).chr(168),'',$BuyerInfo['AddressLine1']);
						$info['street2'] = str_replace(chr(128).chr(168),'',@$BuyerInfo['AddressLine2']);
						$info['city'] = @$BuyerInfo['City'];
						$info['state'] = @$BuyerInfo['StateOrRegion'];
						$info['CountryCode'] = @$BuyerInfo['CountryCode'];
						$info['country'] = $this->db->getValue("SELECT country FROM ".CFG_DB_PREFIX."country where code = '".$info['CountryCode']."'");
						if($info['country'] == '') $info['country'] = $info['CountryCode'];
						$info['zipcode'] = @$BuyerInfo['PostalCode'];
						$info['tel'] = @$BuyerInfo['Phone'];
						$info['userid'] = $Transaction['BuyerName'];
						$info['Sales_channels'] = 3;
						$info['Sales_account_id'] = $id;
						$info['shipping_time'] = 0;
						$info['is_mark'] = 0;
						if($orderstatus=='Shipped'){
							$info['shipping_time'] = MyDate::transform('timestamp',$Transaction['LastUpdateDate']);
							$info['is_mark'] = 1;
						}
						$this->db->insert($this->tableName,addslashes_deep($info));
					}
				}
				$nexttoken = @$getorder[$verb.'Result']['NextToken'];
				return $nexttoken?$nexttoken:'0';  
			}else{
				throw new Exception('读取数据失败','103');exit();
			}	
	}
	/**
	 * 检查保存组合订单文件
	 *
	 * @param string $name
	 * @param string $value
	 * @return bool
	 */
	function saveSuborder($info)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$info['stime'] = ($info['stime'])?str_pad($info['stime'], 2, '0', STR_PAD_LEFT):'00';
		$info['etime'] = ($info['etime'])?str_pad($info['etime'], 2, '0', STR_PAD_LEFT):'23';
		$data['start'] = $info["start"].'T'.$info['stime'].':00:00.000Z';
		$data['end'] = $info["end"].'T'.$info['etime'].':59:59.000Z';
		$verb = 'GetOrders';
		$page = 1;
		$hasmore = false;
		try {
				$this->saveEbayxml($info['id'],$verb,1,$data);
		} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					throw new Exception($errormsg,'999');exit();
		}
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['id'] .'_1.xml');
			if($data=XML_unserialize($xml)){
				$getorder = $data['GetOrdersResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$abc= '';
		$orders = @$getorder['OrderArray']['Order'];
		if(!$getorder['OrderArray']['Order']) return "没有多条目订单";
		foreach((array)$orders as $order){
			$OrderID = $order['OrderID'];
			$paypalid = @$order['ExternalTransaction']['ExternalTransactionID'];
			if(!$paypalid){
				$paypalid = $order['ExternalTransaction'][count($order['ExternalTransaction'])-1]['ExternalTransactionID'];
				}
					$this->db->open('select distinct m.order_id from '.$this->infotableName.' as m left join '.$this->tableName.' as n on m.order_id = n.order_id where m.ebay_orderid = \''.$OrderID.'\'');// and n.order_status = 111');
					$ids = '';
					while ($rs = $this->db->next()) {
						$ids .= ','.$rs['order_id'];
					}
					$ids = substr($ids,1);
			if(!preg_match('/,/',$ids)) continue;
			//开始更新paypalid
			$this->db->update($this->tableName,array(
				'paypalid' => $paypalid
				),'order_id in ('.$ids.' )');
			//开始合并订单
			//$abc .= $this->combineorder($ids);
		}	
		return ($abc == '')?'没有需要合并的多条目订单':$abc;
	}
      	
	/**
	 * 保存淘宝订单文件XML文件
	 *
	 * @param string $id  ebay_account_id
	 * @param string $verb  ebay api type
	 * @param $page load page
	 * @param $data include what used to send
	 */
	static function savetbxml($id,$verb,$page,$data){
		require(CFG_PATH_DATA . 'ebay/tb_' . $id .'.php');
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml';
		$tbsession = new taobaoSession($appKey, $sessions, $appSecret);
		$sysArr = array(
	    	'fields' =>  'seller_nick,buyer_nick,title,type,refund_status,created,iid,price,pic_path,num,tid,buyer_message,sid,shipping_type,alipay_no,payment,discount_fee,adjust_fee,snapshot_url,status,seller_rate,buyer_rate,buyer_memo,seller_memo,pay_time,end_time,modified,buyer_obtain_point_fee,point_fee,real_point_fee,total_fee,post_fee,buyer_alipay_no,receiver_name,receiver_state,receiver_city,receiver_district,receiver_address,receiver_zip,receiver_mobile,receiver_phone,consign_time,buyer_email,commission_fee,seller_alipay_no,seller_mobile,seller_phone,seller_name,seller_email,available_confirm_fee,has_postFee,received_payment,cod_fee,timeout_action_time,orders,sku_id,sku_properties_name,item_meal_name,outer_iid,outer_sku_id',  //返回字段
	 'start_created' => $data['start'],  //查询交易创建时间开始
	   'end_created' => $data['end'], //查询交易创建时间结束
	   'WAIT_SELLER_SEND_GOODS' =>'WAIT_SELLER_SEND_GOODS',
	   	   'page_no' => $page, //页码
		  'page_size'=> 100 //每页条数。取值范围:大于零的整数; 默认值:40;最大值:100
		);
		/***
		 可选值： TRADE_NO_CREATE_PAY(没有创建支付宝交易) WAIT_BUYER_PAY(等待买家付款) WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款) WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货) TRADE_BUYER_SIGNED(买家已签收,货到付款专用) TRADE_FINISHED(交易成功) TRADE_CLOSED(交易关闭) TRADE_CLOSED_BY_TAOBAO(交易被淘宝关闭) ALL_WAIT_PAY(包含：WAIT_BUYER_PAY、TRADE_NO_CREATE_PAY) ALL_CLOSED(包含：TRADE_CLOSED、TRADE_CLOSED_BY_TAOBAO)
		***/
		$responseXml = $tbsession->sendHttpRequest($sysArr,$verb);
		if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400');
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp); 	 
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
	}
	
	function saveAzXml($id,$verb,$page,$data)
	{
		require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
		if(!isset($site)) $site = 1;
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml';
		 require(CFG_PATH_LIB."amazon/amazon.php");
		 if($verb == 'ListOrders'){//获取第一页订单
			 require_once(CFG_PATH_LIB."amazon/ListOrdersRequest.php");
		 	 require_once(CFG_PATH_LIB."amazon/MarketplaceIdList.php");
			 $request = new MarketplaceWebServiceOrders_Model_ListOrdersRequest();
			 $request->setSellerId($MERCHANT_ID);
			 $request->setLastUpdatedAfter(new DateTime($data['start'], new DateTimeZone('UTC')));
			 $request->getLastUpdatedBefore(new DateTime($data['end'], new DateTimeZone('UTC')));
			 $marketplaceIdList = new MarketplaceWebServiceOrders_Model_MarketplaceIdList();
			 $marketplaceIdList->setId(array($MARKETPLACE_ID));		 
			 $request->setMarketplaceId($marketplaceIdList);
			 $responseXml = $service->listOrders($request);
		 }
		 if($verb == 'ListOrdersByNextToken'){
			 require_once(CFG_PATH_LIB."amazon/ListOrdersByNextTokenRequest.php");
				 $request = new MarketplaceWebServiceOrders_Model_ListOrdersByNextTokenRequest();
				 $request->setSellerId($MERCHANT_ID);
				 $request->setNextToken($data['nexttoken']);
				 $responseXml = $service->listOrdersByNextToken($request);
			 }
		if($verb == 'ListOrderItems'){
			 require_once(CFG_PATH_LIB."amazon/ListOrderItemsRequest.php");
				 $request = new MarketplaceWebServiceOrders_Model_ListOrderItemsRequest();
				 $request->setSellerId($MERCHANT_ID);
				 $request->setAmazonOrderId($data['paypalid']);
				$responseXml = $service->listOrderItems($request);
			}
		if($verb == 'ListOrderItemsByNextToken'){
			 require_once(CFG_PATH_LIB."amazon/ListOrderItemsByNextTokenRequest.php");
				 $request = new MarketplaceWebServiceOrders_Model_ListOrdersByNextTokenRequest();
				 $request->setSellerId($MERCHANT_ID);
				 $request->setNextToken($data['nexttoken']);
				$responseXml = $service->listOrderItemsByNextToken($request);
			}
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 @chmod($file, 0777);
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
	}
	/**
	 * 加载taobao订单文件XML文件
	 *
	 * @param string $info
	 * @return $counter 加载的数量
	 */
	function loadtbXml($xml){
		$id = $xml['id'];
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/taobao.trades.sold.get_'. $id .'_'.$xml['page'].'.xml');
			if($data=XML_unserialize($xml)){
				$getorder = $data['trades_sold_get_response'];
			}else{
				throw new Exception('读取数据失败2','103');exit();
			}
		$counter = 0;
		$Trans = (@array_key_exists('created', $getorder['trades']['trade']))?@$getorder['trades']:@$getorder['trades']['trade'];
		foreach((array)$Trans as $Transaction){
			$info['sellerID'] = @$Transaction['seller_nick'];//卖家账号ID
			$goods['ebay_CreatedDate'] = MyDate::transform('timestamp',$Transaction['created']);   //交易创建时间
			$info['paid_time'] = MyDate::transform('timestamp',$Transaction['pay_time']);                   //付款时间
			$ShippedTime = @$Transaction['consign_time'];
			if($ShippedTime) {
				$info['shipping_time'] = MyDate::transform('timestamp',$ShippedTime); //发货时间
				$info['track_no'] = '';
			}else{
				$info['shipping_time'] = 0;
				$info['track_no'] = '';	
				}
			/*******
			buyer节点
			********/
			$info['email'] = $Transaction['alipay_id'].'@alipay.com';          //email
			$info['userid'] = @addslashes($Transaction['buyer_nick']);        //userid
			$paypalid = @$Transaction['alipay_no'];//支付交易号
			$info['paypalid'] = ($paypalid =="")?'kong'.$this->get_order_sn():$paypalid;
			if($this->db->getValue('SELECT count(*) FROM ' . $this->tableName.' where Sales_account_id = \''.$id.'\' and paypalid = \''.$info['paypalid'].'\'')>0) {
				continue;//已存在交易
			}
			$ebayOrderID = @$Transaction['tid'];
			$info['order_amount']  = @$Transaction['payment']; //总付款金额
			$info['ShippingService'] = $Transaction['shipping_type'];
			/*******
			BuyerInfo节点
			********/
			$info['consignee'] = $Transaction['receiver_name'];
			$info['street1'] = str_replace(chr(128).chr(168),'',$Transaction['receiver_district']);
			$info['street2'] = str_replace(chr(128).chr(168),'',$Transaction['receiver_address']);
			$info['city'] = @$Transaction['receiver_state'];
			$info['state'] = @$Transaction['receiver_city'];
			$info['CountryCode'] = 'CN';
			$info['country'] = '中国';
			$info['Sales_channels'] = 2;
			$info['pay_id'] =4;
			$info['zipcode'] = @$Transaction['receiver_zip'];
			$info['tel'] = @$Transaction['receiver_mobile'];
			$info['sellsrecord'] = '';
			$info['currency'] = 'CNY';                            //货币类型
			$info['rate'] = 1;
			$info['add_time'] = CFG_TIME;
			$info['shipping_fee']=@$Transaction['post_fee'];
			$info['Sales_account_id'] = $id;
			$info['order_sn'] = $this->get_order_sn();
			$info['sales_site'] = 'Taobao';
			$info['order_status'] = $this->getorderflow(12)?$this->getorderflow(12):"112";
			$info['pay_note'] = @$Transaction['buyer_message'];
			$order_id=0;
			$orders = (@array_key_exists('status', $Transaction['orders']['order']))?@$Transaction['orders']:@$Transaction['orders']['order'];
			foreach((array)$orders as $order){
				if($order['status'] != 'WAIT_SELLER_SEND_GOODS') continue;
				if($order_id == 0){
						try {
									$this->db->insert($this->tableName, addslashes_deep($info));
									$order_id = $this->db->getInsertId();
									$counter++;
									if($info['shipping_time']>0) $this->db->update($this->tableName,array('order_status' => 131,'is_mark' => 1,'print_status'=>1,'stockout_sn'=>'AllreadyMark'),'order_id='.intval($order_id));
								} catch (Exception $e) {
									throw new Exception('保存订单失败,paypalid为'.$paypalid,'999');continue;
							}
					}	
				/*******
				item节点
				********/
				$goods['item_no'] = $order['num_iid'];                                // tb产品id
				$goods['goods_name'] = $order['title'];								  //产品标题名称
				$SKU = @$order['outer_sku_id'];
				if($SKU == '') $SKU = @$order['outer_iid'];
				$SKU = (substr($SKU,0,1) == '-')?substr($SKU,1):$SKU;
				$goods['goods_price'] = $order['price'];   //产品当前价格
				$goods['bid_count'] = 0;//参与拍卖人数
				$goods['goods_qty'] = $order['num'];   //购买数量
				$goods['StartPrice'] = 0;
				$goods['ebay_orderid'] = $Transaction['tid'];
				$goods['OrderLineItemID'] = $order['oid'];
					if($this->db->getValue('select count(*) from '.$this->infotableName.' where order_id = "'.$order_id.'" and OrderLineItemID="'.$goods['OrderLineItemID'].'"') == 0){ 
						try{
							$goods['sn_prefix'] = '';
							$goods['goods_sn'] = $SKU;
							if(CFG_GOODSSN_PREFIX >0){
									$goods['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
									$goods['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
								}else{
						$goods['goods_sn'] = $this->getRealSKU($SKU);
					}
								$goods['order_id'] = $order_id;
						$this->db->insert($this->infotableName, addslashes_deep($goods));
									} catch (Exception $e) {
								throw new Exception('加载中断，保存订单明细失败,订单号'.CFG_ORDER_PREFIX.$order_id,'999');exit();
						}
					}
			}
		}
		return $counter;
	}
	
	/**
	 * 加载Paypal单据
	 *
	 * @param string $info
	 * @return $counter 加载的数量
	 */
	function savePaypalorder($info)
	{
		set_time_limit(0);
		$email = $this->db->getValue("SELECT paypal_account FROM ".CFG_DB_PREFIX."paypal_account where p_root_id = ".$info['id']);
		require(CFG_PATH_DATA . 'ebay/' . $email .'.php');
		$iso_start = $info["start"].'T00:00:00.000Z';
		$iso_end = $info["end"].'T24:00:00.000Z';
		$data['API_UserName']=$API_USERNAME;
		$data['API_Password']=$API_PASSWORD;
		$data['API_Signature']= $API_SIGNATURE;
		$hasmore = 1;
		while($hasmore){
			$resultarr = $this->paypalsearch($iso_start,$iso_end,$data,$info['id']);
			$result = explode('|',$resultarr);
				if($result[0] < 100){
					$hasmore = 0;
					break;
				}else{
				$iso_end =	$result[1];
				}
			}
		$str = "";
		$i=0;
		$t = 0;
		$this->db->open("SELECT L_TRANSACTIONID FROM ".CFG_DB_PREFIX . "paypal_transaction WHERE paypal_id = '".$info['id']."' and L_TIMESTAMP between '".$info["start"].'T00:00:00.000Z'."' and '".$info["end"].'T24:00:00.000Z'."'");
		while ($rs = $this->db->next()) {
				$tid = $rs["L_TRANSACTIONID"];
				if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." WHERE paypalid = '".$tid."'") > 0 ){
					$str .= $tid."已经加载在ebay订单中<br>"; 
					$i++;
					continue;
					}
				if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX . "paypal_order  WHERE paypalid = '".$tid."'") > 0 ){
					$str .= $tid."已经加载在Paypal单据中<br>"; 
					$i++;
					continue;
					}
				$res = $this->paypaltransaction($tid,$data);
				$trans['p_id'] = $info['id'];
				$trans['paypalid'] = $res['TRANSACTIONID'];
				$trans['email'] = $res['EMAIL'];
				$trans['consignee'] = @$res['SHIPTONAME'];
				$trans['consignee'] = ($trans['consignee'] == '')?$res['FIRSTNAME'].' '.$res['LASTNAME']:$trans['consignee'];
				$trans['street1'] =@$res['SHIPTOSTREET'];
				$trans['street2'] =@$res['SHIPTOSTREET2'];
				$trans['city'] = @$res['SHIPTOCITY'];
				$trans['state'] = @$res['SHIPTOSTATE'];
				$trans['country'] = @$res['SHIPTOCOUNTRYNAME'];
				$trans['zipcode'] = @$res['SHIPTOZIP'];
				$trans['tel'] = @$res['SHIPTOPHONENUM'];
				$trans['note'] = @$res['NOTE'];
				$trans['TRANSACTIONTYPE'] = @$res['TRANSACTIONTYPE'];
				$trans['AMT'] = @$res['AMT'];
				$trans['CURRENCYCODE'] = @$res['CURRENCYCODE'];
				$trans['FEEAMT'] = @$res['FEEAMT'];
				$trans['TAXAMT'] = @$res['TAXAMT'];
				$trans['EXCHANGERATE'] = @$res['EXCHANGERATE'];
				$trans['SETTLEAMT'] = @$res['SETTLEAMT'];
				$trans['REASONCODE'] = @$res['REASONCODE'];
				$trans['PENDINGREASON'] = @$res['PENDINGREASON'];
				$trans['ORDERTIME'] =  MyDate::transform('timestamp',$res['ORDERTIME']);
				$trans['PAYMENTSTATUS'] = $res['PAYMENTSTATUS'];
				$trans = addslashes_deep($trans);
				$this->db->insert(CFG_DB_PREFIX . 'paypal_order',$trans);
				unset($trans);
				$t = 0;
				while(isset($res['L_NAME'.$t])){
					$trans_detail['L_NAME'] = $res['L_NAME'.$t];
					$trans_detail['L_NUMBER'] = $res['L_NUMBER'.$t];
					$trans_detail['L_QTY'] = $res['L_QTY'.$t];
					$trans_detail['L_AMT'] = $res['L_AMT'.$t];
					$trans_detail['paypalid'] = $res['TRANSACTIONID'];
					$trans_detail = addslashes_deep($trans_detail);
					$this->db->insert(CFG_DB_PREFIX . 'paypal_order_goods',$trans_detail);
					unset($trans_detail);
					$t++;
					}
			$i++;
		}
		unset($data);
		echo '共有'.$i.'笔Payment交易流水,加载完成系统中未存在交易'.$t.'条<br>'.$str;
	}
	
	/**************
	**paypal交易流水搜索
	**************/
	function paypalsearch($iso_start,$iso_end,$data,$id)
	{
		if(!function_exists(PPHttpPost)) require(CFG_PATH_LIB . 'ebay/paypalrequire.php');
		$nvpStr = "";
		$nvpStr .= "&STARTDATE=$iso_start";
		$nvpStr .= "&ENDDATE=$iso_end";
		$resArray = PPHttpPost("TransactionSearch",$nvpStr,$data);
		$i=0;
		while(isset($resArray["L_TRANSACTIONID".$i])){
			if($this->db->getValue("SELECT count(*) From ".CFG_DB_PREFIX . "paypal_transaction WHERE L_TRANSACTIONID = '".$resArray["L_TRANSACTIONID".$i]."' and paypal_id = '".$id."'") > 0) {
				$i++;
				continue;
			}
			if($resArray["L_STATUS".$i] == "Completed"){
				$detail['L_TIMEZONE'] = $resArray["L_TIMEZONE".$i];
				$detail['L_TYPE'] = $resArray["L_TYPE".$i];
				$detail['L_EMAIL'] = $resArray["L_EMAIL".$i];
				$detail['L_NAME'] = $resArray["L_NAME".$i];
				$detail['L_TRANSACTIONID'] = $resArray["L_TRANSACTIONID".$i];
				$detail['L_STATUS'] = $resArray["L_STATUS".$i];
				$detail['L_AMT'] = $resArray["L_AMT".$i];
				$detail['L_CURRENCYCODE'] = $resArray["L_CURRENCYCODE".$i];
				$detail['L_FEEAMT'] = $resArray["L_FEEAMT".$i];
				$detail['L_NETAMT'] = $resArray["L_NETAMT".$i];
				$detail['L_TIMESTAMP'] = $resArray["L_TIMESTAMP".$i];
				$detail['paypal_id'] = $id;
				$detail = addslashes_deep($detail);
				$this->db->insert(CFG_DB_PREFIX . "paypal_transaction",$detail);
			}
			$i++;
		}
		return $i.'|'.$resArray["L_TIMESTAMP".($i-1)];
	}
	/**
	 * 自动进行订单paypal核对
	 *
	 */
	function ajaxPaypal($info)
	{
		$p_id = $this->db->getValue('select p_id from '.CFG_DB_PREFIX . 'ebay_account'.' where id = '.$info['account_id']);
		require_once(CFG_PATH_DATA . 'ebay/' . $info['PayPalEmailAddress'] .'.php');
		$data['API_UserName']=$API_USERNAME;
		$data['API_Password']=$API_PASSWORD;
		$data['API_Signature']=$API_SIGNATURE;
		$resArray = $this->paypaltransaction($info['paypalid'],$data);
		$result = "";
		$ispass = 1;
		$statusinfo = $this->status_info('111');
		$nextstatus = $statusinfo["next_id"];
		$failstatus = $statusinfo["fail_id"];
		$reqArray	 = $_SESSION['nvpReqArray'];
		$ack		 = strtoupper($resArray["ACK"]);
		$orderinfo = $this->order_info($info['orderid']);
		if($ack != 'SUCCESS') {
				$this->db->execute("UPDATE ".$this->tableName." SET order_status = ".$failstatus." where order_id=".intval($info['orderid']));
			return "<br>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn'].'获取paypal信息失败';
		}
		$gross		 = $resArray["AMT"];
		$moneytype	 = $resArray['CURRENCYCODE'];
		@$SHIPAMOUNT = $resArray['SHIPPINGAMT'];
		$SHIPAMOUNT = ($SHIPAMOUNT == '')?0:$SHIPAMOUNT;
		@$FEEAMT    = $resArray['FEEAMT'];
		$Email		= $resArray['EMAIL'];
		@$notes		= $resArray['NOTE']?$resArray['NOTE']:"";
		$snname			 = $resArray['SHIPTONAME'];
		$snstreet1		 = $resArray['SHIPTOSTREET'];
		$sncity			 = $resArray['SHIPTOCITY'];
		$sncountry		 = $resArray['SHIPTOCOUNTRYNAME'];
		$snpostcode		 = $resArray['SHIPTOZIP'];
		$snstate		 = $resArray['SHIPTOSTATE'];
		$snstreet2		 = (@array_key_exists('SHIPTOSTREET2',$resArray))?$resArray['SHIPTOSTREET2']:"";
		$type = $this->checkordernormal($info['orderid']);
		if($type == 1){
			$result .= "<br><font color=red>订单产品总金额大于订单金额".CFG_ORDER_PREFIX.$orderinfo['order_sn']."</font>";
			$ispass = 0;
		}elseif($type == 2){
			$result .= "<br><font color=red>订单可能需要合并,产品总金额小于于订单金额".CFG_ORDER_PREFIX.$orderinfo['order_sn']."</font>";
			$ispass = 0;
		}
		if($notes != ""){
			$result .= "<br>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."有付款备注";
		}else{
			$notes = $orderinfo['pay_note'];
			}
		if($orderinfo["order_amount"] != $gross){
			$result .= "<br>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."金额不对";
			$ispass = 0;
		}
		if((trim(strtolower($snname)) <> (strtolower($orderinfo["consignee"]))) || (trim(strtolower($snstreet1)) <> (strtolower($orderinfo["street1"]))) || (trim(strtolower($sncity)) <> (strtolower($orderinfo["city"]))) || (trim(strtolower($sncountry)) <> (strtolower($orderinfo["country"]))) || (trim(strtolower($snpostcode)) <> (strtolower($orderinfo["zipcode"])))){
			$snname = ($snname=='')?$orderinfo["consignee"]:$snname;
			$snstreet1 = ($snstreet1=='')?$orderinfo["street1"]:$snstreet1;
			$sncity= ($sncity=='')?$orderinfo["city"]:$sncity;
			$sncountry = ($sncountry=='')?$orderinfo["country"]:$sncountry;
			$snpostcode = ($snpostcode=='')?$orderinfo["zipcode"]:$snpostcode;
			$snstreet2 = ($snstreet2=='')?$orderinfo["street2"]:$snstreet2;
			$snstate = ($snstate=='')?$orderinfo["state"]:$snstate;
			$result .= "<br>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."地址信息有差别";
			$ispass = 0;
		}
		$goodamt = $this->db->getValue("SELECT sum(goods_price*goods_qty) from ".$this->infotableName." WHERE order_id = ".$info['orderid']);
		if($goodamt> $orderinfo["order_amount"]){
			$result .= "<br><strong>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."产品总金额大于订单总金额</strong>";
			$ispass = 0;
		}
		if($ispass == 0){
			$result .= "<br><font color=red>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."审核未通过</font>";
			$nextstatus = $failstatus;
		}else{
			$result .= "<br>订单".CFG_ORDER_PREFIX.$orderinfo['order_sn']."审核通过";
		}
			try{
				$this->db->update($this->tableName,array(
					'order_status' => $nextstatus,
					'FEEAMT' => $FEEAMT,
					'shipping_fee' => $SHIPAMOUNT,
					'pay_note' => addslashes($notes),
					'email' => addslashes($Email)
					),'order_id='.intval($info['orderid']));
					if(CFG_REPLACE_ADD == 1) $this->db->update($this->tableName,array(
						'consignee' => $snname,
						'street1' => $snstreet1,
						'street2' => $snstreet2,
						'city' => $sncity,
						'state' => $snstate,
						'country' => $sncountry,
						'zipcode' => $snpostcode,
					),'order_id='.intval($info['orderid']));
			} catch (Exception $e) {
				throw new Exception('更新订单信息失败','997');exit();
			}	
		return $result;
	}	

	/**
    *进行订单标记
    */
    function ajaxMark($info){  
        require_once(CFG_PATH_DATA . 'ebay/ebay_' . $info['account_id'] .'.php');
        $verb = 'CompleteSale';
        $file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['account_id'].'.xml';
        $msg = '';
        
        //修复合并订单不能标记问题    
        $combinedOrderId = $this->db->getValue("select root_id from myr_order_combined where order_id = ".$info['orderid']);
        
        if($combinedOrderId){
            $orderinfo = $this->db->getValue('select track_no,shipping_id,ShippingService from myr_order where order_id = '.$combinedOrderId);
            $this->db->update('myr_order',array(
                'track_no' => $orderinfo['track_no'],
                'ShippingService' => $orderinfo['ShippingService'],
                'shipping_id' => $orderinfo['shipping_id']
            ),'order_id = '.$info['orderid']); 
        }
            
        $unmarklist = $this->db->select("Select express_id FROM ".CFG_DB_PREFIX."shipping_unmark");
        $this->db->open('SELECT m.ebay_orderid,n.track_no,n.shipping_time,paid_time,m.item_no,n.order_sn,m.OrderLineItemID,m.TransactionID from '.$this->infotableName. ' as m left join '.$this->tableName.' as n on m.order_id = n.order_id where n.order_id = '.$info['orderid'].' limit 0,30');
        while($rs = $this->db->next()){        
            $mark_with_no = (empty($rs['track_no'])||is_null($rs['track_no'])||$rs['track_no']=="")?0:1;
            $order_sn = $rs['order_sn'];
            if($rs['OrderLineItemID'] == '') continue;
                $shipname  = $this->db->getValue('SELECT value,name from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$info['shipping']);
                $shiptype ='';
                if($shipname['name'] == ''){
                    $shiptype = $shipname['value'];
                    if(!$shiptype || $shiptype == 'ZHY' || $shiptype == 'US') $shiptype ='Other';
                    if($shiptype == 'BIRD') $shiptype = 'Royal Mail';
                    if($shiptype == 'EUB' || $shiptype == 'EUB-1') $shiptype = 'China Post';
                    if($shiptype == 'DEDHL') $shiptype = 'DHL';
                    if($shiptype == 'ICE') $shiptype = 'China Post';
                }else{
                    $shiptype = $shipname['name'];
                }
            $requestXmlBody = '<?xml version="1.0" encoding="utf-8"?> 
                            <CompleteSaleRequest xmlns="urn:ebay:apis:eBLBaseComponents"> 
                            <RequesterCredentials> 
                            <eBayAuthToken>'.$userToken.'</eBayAuthToken> 
                            </RequesterCredentials> 
                            <ItemID>'.$rs['item_no'].'</ItemID> 
                            <TransactionID>'.$rs['TransactionID'].'</TransactionID>
                            <OrderLineItemID>'.$rs['OrderLineItemID'].'</OrderLineItemID>';
            if((!is_null($rs['track_no'])&&!empty($rs['track_no'])&&($rs['track_no'] <> ""))|| $shiptype<>''){
                $requestXmlBody .= '<Shipment><ShipmentTrackingDetails>';
                if(!in_array($info['shipping'],$unmarklist) && !is_null($rs['track_no'])&&!empty($rs['track_no'])&& $rs['track_no'] <> "") $requestXmlBody .= '<ShipmentTrackingNumber>'.$rs['track_no'].'</ShipmentTrackingNumber>';
                if($shiptype<>'') $requestXmlBody .= '<ShippingCarrierUsed>'.$shiptype.'</ShippingCarrierUsed>';
                $requestXmlBody .= '</ShipmentTrackingDetails>
                                </Shipment>';
                }
                $shiptime = ($rs['shipping_time']>1)?date("Y-m-d\TH:i:s.000\Z",$rs['shipping_time']):date("Y-m-d\TH:i:s.000\Z");
            if($rs['is_mark']== 1 && $rs['mark_with_no'] == 0 && $rs['track_no'] !=''&&$rs['shipping_time']<=2012) $shiptime = date("Y-m-d\TH:i:s.000\Z",$rs['paid_time']);
                $requestXmlBody .= '<ShippedTime>'.$shiptime.'</ShippedTime><Shipped>true</Shipped>
                                    </CompleteSaleRequest>';
        $session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
        $responseXml = $session->sendHttpRequest($requestXmlBody);
        if(stristr($responseXml, 'HTTP 404') || $responseXml == ''){
            throw new Exception('发送请求失败','999');exit();
        }
        $ecode = 0;
                   $responseDoc = new DomDocument();
                   $responseDoc->loadXML($responseXml);
                 $errors = $responseDoc->getElementsByTagName('Errors');
                 if($responseDoc->getElementsByTagName('Ack')->item(0)->nodeValue == 'Warning'){
                    $msg .= '<br>标记失败,可能单号已上传';continue;
                 }elseif($errors->length > 0)
                    {    
                     savepost($responseXml,CFG_PATH_ERR.CFG_ORDER_PREFIX.$order_sn.'.html');
                     $shortMsg = $errors->item(0)->getElementsByTagName('ShortMessage');
                     $errcode = $errors->item(0)->getElementsByTagName('ErrorCode');
                    $ecode = $errcode->item(0)->nodeValue;
                    $msg .= '<br>标记失败'.$shortMsg->item(0)->nodeValue;
                 }            
        }
                 
                     if(!$this->db->update($this->tableName,array(
                                'is_mark' => 1,
                                'shipping_time'=>CFG_TIME,
                                'mark_with_no' => $mark_with_no
                            ),'order_id='.$info['orderid'])) $msg .= '更改标记状态失败';
                  if($ecode == 21359 || $ecode == 16100){ $this->db->execute("update ".$this->tableName." set is_mark=0,mark_with_no=0 where order_id=".$info['orderid']);}
                if($msg <>''){ return '<br>'.CFG_ORDER_PREFIX.$order_sn.$msg;}
                 else return '<br>'.CFG_ORDER_PREFIX.$order_sn.'标记完成';
    }
	/**
	 * Ebay message加载
	 *
	 * @param array $info
	 */
	function saveEbaymessage($info)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$data['start'] = $info["start"].'T00:00:00.000Z';
		$data['end'] = $info["end"].'T24:00:00.000Z';
		$verb = 'GetMemberMessages';
		$page = 1;
		$hasmore = false;
		try {
				ModelChannel::saveEbayxml($info['id'],$verb,1,$data);
		} catch (Exception $e) {
					throw new Exception('保存ebay Message文件失败','999');exit();
		}
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['id'] .'_'.$page.'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request['GetMemberMessagesResponse'];
				if($getorder['Errors'] && $getorder['Errors']['ErrorCode'] <> 16202){
						$errormsg = $getorder['Errors']['ErrorCode'] ." " .	$getorder['Errors']['ShortMessage'] ." " . @$getorder['Errors']['LongMessage'];
						throw new Exception($errormsg,'900');exit();
				}
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
			$totalcount = ceil($getorder['PaginationResult']['TotalNumberOfEntries']/199);
		for($page = 2;$page <= $totalcount; $page++ ){
			try {
				ModelChannel::saveEbayxml($info['id'],$verb,$page,$data);
			} catch (Exception $e) {
						throw new Exception('保存Page'.$page.'失败','999');exit();
			}
		}
		return $info['id'].'|'.$totalcount.'|'.$getorder['PaginationResult']['TotalNumberOfEntries'];
	}
	
	function saveMymessage($info)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$data['start'] = $info["start"].'T00:00:00.000Z';
		$data['end'] = $info["end"].'T24:00:00.000Z';
		$data['str'] ='';
		$verb = 'GetMyMessages';
		$page = 1;
		try {
				$this->saveEbayxml($info['id'],$verb,1,$data);
		} catch (Exception $e) {
					throw new Exception('保存ebay Message文件失败','999');exit();
		}
		$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $info['id'] .'_'.$page.'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request['GetMyMessagesResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		if(!$getorder['Messages']){ return '加载message条目失败';exit();}
		$Trans = (array_key_exists('Sender', @$getorder['Messages']['Message']))?@$getorder['Messages']:$getorder['Messages']['Message'];
		$ids = array();
		foreach((array)$Trans as $Transaction){
			$ids[] = $Transaction['MessageID'];
		}
		if(count($ids)>0){
			$j= 0;
			for($i=0;$i<count($ids);$i++){
				$data['str'] .= '<MessageID>'.$ids[$i].'</MessageID>';
				if((($i+1) % 10 == 0)|| $i == (count($ids)-1)){
						$j++;
						$this->saveEbayxml($info['id'],$verb,1,$data,$j);
						$data['str'] = '';
					}
				}
		}
		return $this->loadmyxml($j,$info['id']);
	}
	/*****
	*加载Ebay官方message和其他渠道message
	*****/
	function loadmyxml($num,$id)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$counter = 0;
		for($i=1;$i<=$num;$i++){
			$xml =file_get_contents(CFG_PATH_DATA . 'ebay/GetMyMessages_'. $id .'_1_'.$i.'.xml');
				if($request=XML_unserialize($xml)){
					$getorder = $request['GetMyMessagesResponse'];
				}else{
					throw new Exception('读取数据失败','103');exit();
				}
			$Trans = (array_key_exists('Sender', @$getorder['Messages']['Message']))?@$getorder['Messages']:$getorder['Messages']['Message'];
			foreach((array)$Trans as $Transaction){
				$CreatedDate = MyDate::transform('timestamp',strtotime($Transaction['ReceiveDate']));   //交易创建时间
				$messageid = $Transaction['MessageID'];
				$exmessageid = $Transaction['ExternalMessageID'];
				$SenderID = $Transaction['Sender'];
				$Body = $Transaction['Text'];
				$itemid = @$Transaction['ItemID'];
				$itemtitle = @$Transaction['ItemTitle'];
				$subject = $Transaction['Subject'];
				$MessageType = $Transaction['MessageType'];
				if($this->db->getValue('SELECT count(*) from '.CFG_DB_PREFIX . 'ebaymessage where (messageid="'.$messageid.'" or messageid="'.$exmessageid.'") and accountid = '.$id) > 0 ) continue;
										$this->db->insert(CFG_DB_PREFIX . 'ebaymessage', array(
														'accountid' => $id,
														'messageid' => $exmessageid,
														'SenderID' =>addslashes($SenderID),
														'body' => addslashes($Body),
														'itemid' => $itemid,
														'itemtitle' => addslashes($itemtitle),
														'subject' => addslashes($subject),
														'MessageType' => $MessageType,
														'CreationDate' => $CreatedDate,
														'starttime' => CFG_TIME,
														'MessageType' => 'CustomCode'
														));
									$counter++;
			}	
		}
		return $counter;
	}
	/**
	 * 加载ebay message XML文件
	 *
	 * @param string $xml
	 * @param int  $id
	 * @return $counter 加载的数量
	 */
	function loadMSGXml($xml){
		date_default_timezone_set('Asia/Hong_Kong');
		$id = $xml['id'];
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/GetMemberMessages_'. $id .'_'.$xml['page'].'.xml');
			if($request=XML_unserialize($xml)){
				$getorder = $request['GetMemberMessagesResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$counter = 0;
		if(!$getorder['MemberMessage']){ return 0;exit();}
		$Trans = (array_key_exists('CreationDate', @$getorder['MemberMessage']['MemberMessageExchange']))?@$getorder['MemberMessage']:$getorder['MemberMessage']['MemberMessageExchange'];
		foreach((array)$Trans as $Transaction){
			$CreatedDate = MyDate::transform('timestamp',strtotime($Transaction['CreationDate']));   //交易创建时间
			$itemEndTime = MyDate::transform('timestamp',strtotime($Transaction['Item']['ListingDetails']['EndTime']));   //产品下架时间
			$itemid = $Transaction['Item']['ItemID'];
			$endtime = $Transaction['Item']['ListingDetails']['EndTime'];
			$title = $Transaction['Item']['Title'];
			$messageid = $Transaction['Question']['MessageID'];
			$SenderID = $Transaction['Question']['SenderID'];
			if(!$SenderID) $SenderID= $Transaction['Question']['RecipientID'];
			$SenderEmail = $Transaction['Question']['SenderEmail'];
			$Body = $Transaction['Question']['Body'];
			$subject = $Transaction['Question']['Subject'];
			$date = $Transaction['CreationDate'];
			$MessageType = $Transaction['Question']['MessageType'];
			$QuestionType = $Transaction['Question']['QuestionType'];
			$starttime = CFG_TIME;
			if($this->db->getValue('SELECT count(*) from '.CFG_DB_PREFIX . 'ebaymessage where messageid="'.$messageid.'" and accountid = '.$id) > 0 ) continue;
										$this->db->insert(CFG_DB_PREFIX . 'ebaymessage', array(
													'accountid' => $id,
													'messageid' => $messageid,
													'SenderID' =>addslashes($SenderID),
													'sender_mail' => $SenderEmail,
													'body' => addslashes($Body),
													'subject' => addslashes($subject),
													'itemid' => $itemid,
													'itemtitle' => addslashes($title),
													'CreationDate' => $CreatedDate,
													'itemEndTime' => $itemEndTime,
													'starttime' => $starttime,
													'MessageType' => $MessageType,
													'QuestionType' => $QuestionType
													));
								$counter++;
							}
		return $counter;
	}
	/*****************
	**回复Ebay MEssage
	**
	*****************/
	function replyanswer($info)
	{
		$this->db->update(CFG_DB_PREFIX . 'ebaymessage',array('answer' => $info['value']),'id='.$info['id']);
		$data = $this->db->getValue('SELECT messageid,accountid,SenderID,itemid,answer FROM '.CFG_DB_PREFIX . 'ebaymessage where id ='.$info['id']);
		$ispub = 'false';
		$verb = 'AddMemberMessageRTQ';
		require_once(CFG_PATH_DATA . 'ebay/ebay_' . $data['accountid'] .'.php');
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		require_once(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
    	if(stristr($responseXml, 'HTTP 404') || $responseXml == ''){
			 throw new Exception('Error sending request','900');exit();
		}
		$responseDoc = new DomDocument();
		$responseDoc->loadXML($responseXml);
		$root = $responseDoc->documentElement;
		$ack = $responseDoc->getElementsByTagName('Ack');
		$reack = $ack->item(0)->nodeValue;
		if($reack == 'Success'){
			$this->db->update(CFG_DB_PREFIX . 'ebaymessage',array('answerstatus' => 1,'ebay_ack' => 1),'id='.$info['id']);
		}else{
			$this->db->update(CFG_DB_PREFIX . 'ebaymessage',array('ebay_ack' => 2),'id='.$info['id']);
			throw new Exception('Message回复失败','905');exit();
		}
	}
	function replypartner($info)
	{
		$id_arr =array();
		if($info['ids']) $id_arr = explode(',',$info['ids']);
		else $id_arr[0] = $info['order_id'];
		$msg = '';
		for($i=0;$i<count($id_arr);$i++){
			$order = new ModelOrder();
			$order_info = $this->db->getValue("select * from myr_order where order_id =".$id_arr[$i]);
			$goods_info = $this->db->select('select * from myr_order_goods where order_id ='.$id_arr[$i]."  order by goods_sn");
			
			if($info['type'] ==0){
				$data['itemid']=$goods_info[0]['item_no'];
				$data['subject'] = $info['subject'];
				$data['answer'] = ModelTemplate::replacecontent($info['answer'],$id_arr[$i]);
				$data['SenderID'] = $order_info['userid'];
				require(CFG_PATH_DATA . 'ebay/ebay_' . $order_info['Sales_account_id'] .'.php');
				$verb = 'AddMemberMessageAAQToPartner';
				$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
				require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
				$responseXml = $session->sendHttpRequest($requestXmlBody);
				if(stristr($responseXml, 'HTTP 404') || $responseXml == ''){
					 throw new Exception('Error sending request','900');exit();
				}
				$responseDoc = new DomDocument();
				$responseDoc->loadXML($responseXml);
				$root = $responseDoc->documentElement;
				$ack = $responseDoc->getElementsByTagName('Ack');
				$reack = $ack->item(0)->nodeValue;
			}else{
				$info['answer'] = ModelTemplate::replacecontent($info['answer'],$id_arr[$i]);
				$reack = ModelSystem::SendMail($order_info['email'],$info['subject'],$info['answer']);				
			}
			if($reack != 'Success'){
				$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'发送失败<br>';
			}
		}
		if($msg <>'') { throw new Exception($msg,'944');exit();}
	}
	
	/*********
	**
	**Amazon标记发货
	**
	*********/
	function  amazonMark($id)
	{
		$sql = "SELECT order_id,shipping_id,track_no,order_sn,paypalid,shipping_time,paid_time,mark_with_no,is_mark,countrycode from ".$this->tableName. " where Sales_account_id = ".$id;
		$sql .= " and ShippingService <> 'AFN' and order_status in (".$this->getorderflow(6,2).") and Sales_channels = 3 and is_mark = 0 limit 2000";
		$this->db->open($sql);
		$ids = '';
		$ids1 = '';
		$shipping = ModelDd::getArray('shipping');
		$xml = '<?xml version="1.0" encoding="UTF-8"?><AmazonEnvelope xsi:noNamespaceSchemaLocation="amzn-envelope.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier>M_MWSTEST_49045593</MerchantIdentifier></Header><MessageType>OrderFulfillment</MessageType>';
		while ($rs = $this->db->next()) {
			$ids .= ','.$rs['order_id'];//有单号
			$shiptime = date("Y-m-d\TH:i:s",$stamp);
			$mark_with_no = (empty($rs['track_no'])||is_null($rs['track_no'])||$rs['track_no']=="")?0:1;
				if($rs['paypalid'] == '' || $rs['paypalid'] == '0') continue;//去除手动添加订单
			$xml .= "<Message><MessageID>".$rs['order_id']."</MessageID><OperationType>Update</OperationType><OrderFulfillment><AmazonOrderID>".trim($rs['paypalid'])."</AmazonOrderID>";
			$timestamp = $rs['paid_time']+10*3600;
			$timestamp = ($timestamp > CFG_TIME ) ?CFG_TIME:$timestamp;
			$xml .= "<FulfillmentDate>".date("Y-m-d\TH:i:s",$timestamp)."+08:00</FulfillmentDate>";
			$xml .= "<FulfillmentData>";
				$shipname  = $this->db->getValue('SELECT value,name from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$rs['shipping_id']);
				$shiptype ='';
				if($shipname['name'] == ''){
					$shiptype = $shipname['value'];
					if(!$shiptype || $shiptype == 'ZHY' || $shiptype == 'US') $shiptype ='Other';
					if($shiptype == 'BIRD') $shiptype = 'Royal Mail';
					if($shiptype == 'EUB' || $shiptype == 'EUB-1') $shiptype = 'China Post';
					if($shiptype == 'DEDHL') $shiptype = 'DHL';
					
				}else{
					$shiptype = $shipname['name'];
				}
				if($shiptype == '') $shiptype ='Contact Us for Details';
			$xml .= "<CarrierName>".$shiptype."</CarrierName><ShippingMethod>".(preg_match("/([\x81-\xfe][\x40-\xfe])/", $shipping[$rs['shipping_id']], $match)?"Standard":$shipping[$rs['shipping_id']])."</ShippingMethod><ShipperTrackingNumber>".$rs['track_no']."</ShipperTrackingNumber></FulfillmentData>";
			$goods = $this->order_goods_info($rs['order_id'],0);
			for($i=0;$i<count($goods);$i++){
				if($goods[$i]['OrderLineItemID']<>'') $xml .= "<Item><AmazonOrderItemCode>".$goods[$i]['OrderLineItemID']."</AmazonOrderItemCode><Quantity>".$goods[$i]['goods_qty']."</Quantity></Item>";
			}
			$xml .= "</OrderFulfillment></Message>";
		}
		$xml .= "</AmazonEnvelope>";
        
        
		$file = CFG_PATH_DATA . 'ebay/OrderFulfillment_'. $_SESSION['admin_id'] .'.xml';
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$xml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
		 $verb= '_POST_ORDER_FULFILLMENT_DATA_';
		 $result = $this->submitfeed($id,$file,$verb);
         savepost($result);
		 if(!$result) echo '上传信息失败<br>';
		 else{
				require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
					if($request=XML_unserialize($result)){
						if(@$request['SubmitFeedResponse']['SubmitFeedResult']['FeedSubmissionInfo']['FeedProcessingStatus'] == '_SUBMITTED_'){ 
						echo '订单标记发货信息已上传,请等待生效';
						$this->db->execute("update ".$this->tableName." set is_mark = 1,mark_with_no=".$mark_with_no.",shipping_time=".MyDate::transform('timestamp',$shiptime)." where order_id in (".$rs['order_id'].")");}
						else echo $result;
					}else{
						echo "返回信息格式出错";	
					}
		}
	}
	function submitfeed($id,$file,$verb)
	{
		require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
		if(!isset($site)) $site = 1;
		$serviceUrl = $this->getamazonsite($site);
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		require(CFG_PATH_LIB."amazon/report/amazon.php");
		$feedHandle = @fopen('php://temp', 'rw+');
		$feed = file_get_contents($file);
		fwrite($feedHandle, $feed);
		rewind($feedHandle);
		if($verb = '_POST_ORDER_FULFILLMENT_DATA_'){
			require(CFG_PATH_LIB."amazon/report/SubmitFeedRequest.php");
			$request = new MarketplaceWebService_Model_SubmitFeedRequest();
		}
		$request->setMerchant($MERCHANT_ID);
		$request->setMarketplace($MARKETPLACE_ID);
		$request->setFeedType($verb);
		$request->setContentMd5(base64_encode(md5(stream_get_contents($feedHandle), true)));
		rewind($feedHandle);
		$request->setPurgeAndReplace(false);
		$request->setFeedContent($feedHandle);
		rewind($feedHandle);
		try{
			return $service->submitFeed($request);
		 } catch (MarketplaceWebService_Exception $ex) {
			 echo("Caught Exception: " . $ex->getMessage() . "\n");
			 echo("Response Status Code: " . $ex->getStatusCode() . "\n");
			 echo("Error Code: " . $ex->getErrorCode() . "\n");
			 echo("Error Type: " . $ex->getErrorType() . "\n");
			 echo("Request ID: " . $ex->getRequestId() . "\n");
			 echo("XML: " . $ex->getXML() . "\n");
			 echo("ResponseHeaderMetadata: " . $ex->getResponseHeaderMetadata() . "\n");
		 }
		@fclose($feedHandle);
	}
	
	function RequestReport($info)
	{
		require(CFG_PATH_DATA . 'ebay/az_' . $info['id'] .'.php');
		if(!isset($site)) $site = 1;
		$serviceUrl = $this->getamazonsite($site);
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		require(CFG_PATH_LIB."amazon/report/amazon.php");
		require(CFG_PATH_LIB."amazon/report/RequestReportRequest.php");
		$start = date('Y-m-d H:i:s',strtotime($info["start"]." ".$info['stime'].":00:00"));
		$end = date('Y-m-d H:i:s',strtotime($info["end"]." ".$info['etime'].":59:59"));
		$parameters = array (
		  'Merchant' => $MERCHANT_ID,
		  'ReportType' => $info['type'],
   		  'Marketplace' => $MARKETPLACE_ID,
		  'StartDate' => new DateTime(date('Y-m-d H:i:s',strtotime($info['start'].' '.$info['stime'].":00:00")), new DateTimeZone('Asia/Shanghai')),
		  'EndDate' => new DateTime(date('Y-m-d H:i:s',strtotime($info['end'].' '.$info['etime'].":59:59")), new DateTimeZone('Asia/Shanghai')),
  		  'ReportOptions' => 'ShowSalesChannel=true',
		);
		
		try{
			$request = new MarketplaceWebService_Model_RequestReportRequest($parameters);
			$response = $service->requestReport($request);
		 } catch (MarketplaceWebService_Exception $ex) {
			 throw new Exception($ex->getMessage(),'103');exit();
		 }
		$file = CFG_PATH_DATA . 'amazon/RequestReport_'. $_SESSION['admin_id'] .'.xml';
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$response)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
             @chmod($file, 0777);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		if($request=XML_unserialize($response)){
			if(@!$request['RequestReportResponse']) {throw new Exception('返回信息格式出错1','103');exit();}
			else {
						if(@$request['RequestReportResponse']['RequestReportResult']['ReportRequestInfo']['ReportProcessingStatus'] == '_SUBMITTED_') return '申请report成功,请等待生效';
						else echo $result;			}
		}else{
			throw new Exception('返回信息格式出错2','103');exit();
		}
	}
	
	function amazonshedule($info)
	{                           
		if(empty($info['id'])){
			if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."amazon_schedule where account_id = '".$info['account_id']."' AND ReportType ='".$info['ReportType']."' AND Schedule ='".$info['Schedule']."'")>0) {throw new Exception('该类型已存在，请选择编辑','103');exit();}
			}
		require(CFG_PATH_DATA . 'ebay/az_' . $info['account_id'] .'.php');
		if(!isset($site)) $site = 1;
		$serviceUrl = $this->getamazonsite($site);
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		require(CFG_PATH_LIB."amazon/report/amazon.php");
		require(CFG_PATH_LIB."amazon/report/ManageReportScheduleRequest.php");
		$parameters = array (
		  'Merchant' => $MERCHANT_ID,
		  'ReportType' => $info['ReportType'],
		  'Schedule' => $info['Schedule'],
		  'ScheduledDate' => new DateTime('now', new DateTimeZone('UTC')),
		);
		try{
			$request = new MarketplaceWebService_Model_ManageReportScheduleRequest($parameters);
			$response = $service->manageReportSchedule($request);
		 } catch (MarketplaceWebService_Exception $ex) {
			 throw new Exception($ex->getMessage(),'103');exit();
		 }
		$file = CFG_PATH_DATA . 'amazon/manageReportSchedule_'. $_SESSION['admin_id'] .'.xml';
		
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$response)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
             @chmod($file, 0777);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		if($request=XML_unserialize($response)){
			if(@!$request['ManageReportScheduleResponse']) {throw new Exception('返回信息格式出错1','103');exit();}
			else {
				if (empty($info['id'])) {
					$this->db->insert(CFG_DB_PREFIX.'amazon_schedule',array(
						'account_id' => $info['account_id'],
						'ReportType' => $info['ReportType'],
						'Schedule' => $info['Schedule']
						));
				} else {
					$this->db->update(CFG_DB_PREFIX.'amazon_schedule',array(
						'account_id' => $info['account_id'],
						'ReportType' => $info['ReportType'],
						'Schedule' => $info['Schedule']
						),'id='.intval($info['id']));
				}
			}
		}else{
			throw new Exception('返回信息格式出错2','103');exit();
		}
	}
	
	function amazonReportList($id)
	{
		set_time_limit(0);
		require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
		if(!isset($site)) $site = 1;
		$serviceUrl = $this->getamazonsite($site);
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		require(CFG_PATH_LIB."amazon/report/amazon.php");
		require(CFG_PATH_LIB."amazon/report/GetReportListRequest.php");
		 $parameters = array (
		   'Merchant' => $MERCHANT_ID,
		   'MaxCount' => 100,
		   'AvailableToDate' => new DateTime('+1 days', new DateTimeZone('UTC')),
		   'AvailableFromDate' => new DateTime('-2 days', new DateTimeZone('UTC')),
		   'Acknowledged' => false, 
		 );
		$request = new MarketplaceWebService_Model_GetReportListRequest($parameters);
		$response = $service->getReportList($request);
		/*$file = CFG_PATH_DATA . 'amazon/getReportList_'. $_SESSION['admin_id'] .'.xml';
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$response)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 throw new Exception('不能写入数据','101');
		 }*/
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		if($request=XML_unserialize($response)){
			$getorder = @$request['GetReportListResponse'];
			if(!$getorder) {throw new Exception('返回信息格式出错1','103');exit();}
			else {
				$Trans = (@array_key_exists('ReportId', @$getorder['GetReportListResult']['ReportInfo']))?@$getorder['GetReportListResult']:@$getorder['GetReportListResult']['ReportInfo'];
				foreach((array)$Trans as $Transaction){
					if(!$Transaction['ReportId'] || $Transaction['ReportId'] == 'f') continue;
					if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."amazon_report where account_id = ".$id." AND ReportId = ".$Transaction['ReportId'] )>0) continue;
					$info['account_id'] = $id;
					$info['ReportId'] = $Transaction['ReportId'];
					$info['ReportType'] = $Transaction['ReportType'];
					$info['AvailableDate'] = MyDate::transform('timestamp',$Transaction['AvailableDate']);
					$this->db->insert(CFG_DB_PREFIX.'amazon_report',$info);
				}
			}
		}else{
			throw new Exception('返回信息格式出错2','103');exit();
		}
	}
	/*********
	***
	*** 获取加载report
	***
	*********/
	function loadamzreport($id)
	{
		set_time_limit(0);
		$info = $this->db->getValue("SELECT ReportId,account_id,ReportType FROM ".CFG_DB_PREFIX."amazon_report where id = ".$id);
		require(CFG_PATH_DATA . 'ebay/az_' . $info['account_id'] .'.php');
		if(!isset($site)) $site = 1;
		$serviceUrl = $this->getamazonsite($site);
		require(CFG_PATH_LIB."amazon/amazon_".$site.".php");
		require(CFG_PATH_LIB."amazon/report/amazon.php");
		require(CFG_PATH_LIB."amazon/report/GetReportRequest.php");
		 $reportId = $info['ReportId'];
		 $myHandle = @fopen($reportId.'.txt', 'rw+');
		 $parameters = array (
		   'Merchant' => $MERCHANT_ID,
		   'Marketplace' => $MARKETPLACE_ID,
		   'Report' => $myHandle,
		   'ReportId' => $reportId,
		 );
		 $request = new MarketplaceWebService_Model_GetReportRequest($parameters);
		 $file = CFG_PATH_DATA . 'amazon/getReportList_'.$info['account_id'].'_'. $reportId.'.txt';
		 $fp = fopen($file, 'w');
		 fputs($fp, utf8_encode($service->getReport($request)));
		 fclose($fp);
		 $this->db->execute("UPDATE ".CFG_DB_PREFIX."amazon_report set status =1 where id = ".$id);
		 $request = file_get_contents(CFG_PATH_DATA . 'amazon/getReportList_'.$info['account_id'].'_'. $reportId.'.txt');
		 if($info['ReportType'] == '_GET_FLAT_FILE_ORDERS_DATA_') $this->loadamzfile($request,$info['account_id']);
		 if($info['ReportType'] == '_GET_FLAT_FILE_ACTIONABLE_ORDER_DATA_') $this->loadamzunship($request,$info['account_id']);
		 if($info['ReportType'] == '_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_') $this->loadamzFBAfile($request,$info['account_id']);
		 if($info['ReportType'] == '_GET_MERCHANT_LISTINGS_DATA_') ModelGoods::loadfile($request,$info['account_id']);
		 if($info['ReportType'] == '_GET_MERCHANT_LISTINGS_DATA_LITE_') ModelGoods::loadlitefile($request,$info['account_id']);
	}
	function getReportname($id)
	{
		$info = $this->db->getValue("SELECT ReportId,account_id,ReportType FROM ".CFG_DB_PREFIX."amazon_report where id = ".$id);
		$file = CFG_PATH_DATA . 'amazon/getReportList_'.$info['account_id'].'_'. $info['ReportId'].'.txt';
		$file = str_replace(CFG_PATH_ROOT, '', $file);
		return $file;
	}
	
	function getamazonsite($site)
	{
		switch($site){
			case 1:
			$serviceUrl = "https://mws.amazonservices.com";
			break;
			case 2:
			$serviceUrl = "https://mws.amazonservices.co.uk";
			break;
			case 3:
			$serviceUrl = "https://mws.amazonservices.de";
			break;
			case 4:
			$serviceUrl = "https://mws.amazonservices.fr";
			break;
			case 5:
			$serviceUrl = "https://mws.amazonservices.it";
			break;
			case 6:
			$serviceUrl = "https://mws.amazonservices.jp";
			break;
			case 7:
			$serviceUrl = "https://mws.amazonservices.com.cn";
			break;
			case 8:
			$serviceUrl = "https://mws.amazonservices.ca";
			break;
			case 9:
			$serviceUrl = "https://mws.amazonservices.in";
			break;
			default:
			$serviceUrl = "https://mws.amazonservices.com";
			}
		return $serviceUrl;
	}
	function savezcorder($info)
	{
		$data['starttime'] = $info["start"];
		$data['endtime'] = $info["end"];
		require(CFG_PATH_DATA . 'ebay/zc_' . $info['id'] .'.php');
		$result = $this->getUrlPage( $url.'/zencart-order.php?action=getOrder',$this->arrayToUrlParams($data) );
		$result = $this->jsonDecode($result,'utf-8');
		if(!empty($result['order'])){
			$orderCount = count($result['order']);
			if($orderCount>0){
					$this->saveZencartOrder($result,$info['id']);
					return $orderCount;
			}else{
				throw new Exception('当前时间段没有订单','999');exit();
			}
		}
	}
	function saveZencartOrder($info,$id)
	{
		$newInfo = array();
		$orders = array();
		foreach($info['order'] as $val){
			$orders[$val['orders_id']]=$val;
		}
		foreach($info['product'] as $val){
			$newInfo['userid'] = $orders[$val['orders_id']]['customers_email_address'];           
			$newInfo['order_amount'] = $orders[$val['orders_id']]['order_total'];                 
			$newInfo['currency'] = $orders[$val['orders_id']]['currency'];                        
			$newInfo['ShippingService']=$orders[$val['orders_id']]['shipping_method'];               
			$newInfo['Sales_account_id']=$id;                                         
			$newInfo['paypalid']=$val['orders_id'];                                               
			$newInfo['consignee']=$orders[$val['orders_id']]['delivery_name'];                    
			$newInfo['email']=$orders[$val['orders_id']]['customers_email_address'];              
			$newInfo['street1']=$orders[$val['orders_id']]['delivery_street_address'];   
			$newInfo['street2']=$orders[$val['orders_id']]['delivery_suburb'];         
			$newInfo['city']=$orders[$val['orders_id']]['delivery_city'];                         
			$newInfo['state']=$orders[$val['orders_id']]['delivery_state'];                       
			$newInfo['country']=$orders[$val['orders_id']]['delivery_country'];                   
			$newInfo['zipcode']=$orders[$val['orders_id']]['delivery_postcode'];                 
			$newInfo['tel']=$orders[$val['orders_id']]['customers_telephone'];                    
			$newInfo['pay_note']=$orders[$val['orders_id']]['comments'];  
			$newInfo['paid_time']=$orders[$val['orders_id']]['date_purchased'];        
			//product start                                                                       
			$newInfo['SKU'] = $val['products_model'];                                       
			$newInfo['goods_name'] = $val['products_name'];                                       
			$newInfo['goods_qty'] = $val['products_quantity'];                                    
			$newInfo['goods_price'] = $val['products_price'];                                     
			$newInfo['TransactionID'] = $val['orders_products_id'];  
			$this->saveimport($newInfo);
		}
	}
	
	function getUrlPage($url,$params=false)
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_HTTPGET, true);
		if($params){
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
		}
		curl_setopt($ch,CURLOPT_USERAGENT,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3');
		curl_setopt($ch, CURLOPT_URL,$url);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT,30);
		curl_setopt($ch, CURLOPT_TIMEOUT,30);
		$result = curl_exec($ch);
		$error=curl_error($ch);
		curl_close($ch);
		if(empty($error))
		return $result;
		else
		exit(addslashes(str_replace(array("\n","\r","\r\n"),'',$error)));	 
	}
	/**
	 *请求参数创建
	 */
	function arrayToUrlParams($arr)
	{	
		foreach ($arr as $key=>$val)
		{	if($key=='data'){
			$arr=array('data'=>json_decode(stripslashes($_POST['data'])));
			$result .=http_build_query($arr);
			continue;
			}
			$result .= !isset($result)?$key.'='.urlencode($val):'&'.$key.'='.urlencode($val);
		}
		return $result;
	}
	function unicode_encode($name)   
	{   
		$name = iconv('UTF-8', 'UCS-2', $name);   
		$len = strlen($name);   
		$str = '';   
		for ($i = 0; $i < $len - 1; $i = $i + 2)   
		{   
			$c = $name[$i];   
			$c2 = $name[$i + 1];   
			if (ord($c) > 0)   
			{   //两个字节的文字   
				$str .= '\u'.base_convert(ord($c), 10, 16).base_convert(ord($c2), 10, 16);   
			}   
			else  
			{   
				$str .= $c2;   
			}   
		}   
		return $str;   
	}   
	  
	//将UNICODE编码后的内容进行解码   
	function unicode_decode($name)   
	{   
		//转换编码，将Unicode编码转换成可以浏览的utf-8编码   
		$pattern = '/(\\\u([\w]{4}))/i';   
		$name = preg_replace_callback( $pattern , 'ModelChannel::_unicode_decode' , $name );   
		return $name;   
	}  
	static function _unicode_decode( $str ) {   
		$str = $str[0];   
		$name = '';   
		$code = base_convert(substr($str, 2, 2), 16, 10);   
		$code2 = base_convert(substr($str, 4), 16, 10);   
		$c = chr($code).chr($code2);   
		$c = iconv('UCS-2', 'UTF-8', $c);   
		$name .= $c;   
		return $name;   
	}	 
	function jsonDecode( $json , $to_encode = 'gbk' , & $i = 0 ) {   
		if ( null === $i ) {   
			$i = 0;   
		}   
		for( ; $i < strlen( $json ) ; $i ++ ) {        
			$chr = $json[$i];   
			switch( $chr ) {   
				case '"' :   
				case "'" :  
					//字符串         
					$i ++;  
					$val = '';  
					while( $json[$i] != $chr || $lastChr == '\\' ) {  
						$lastChr = $json[$i];  
						$val .= $lastChr;  
						$i ++;  
						  
					}  
					++ $i;  
					//字符串处理  
					//unicode 转汉字  
					$val = $this->unicode_decode( $val );  
					if ( strtolower( str_ireplace( '-' , '' , $to_encode ) ) !== 'utf8' ) {  
						$val = mb_convert_encoding( $val , $to_encode , 'utf-8' );  
					}  
					$val = stripslashes( $val );                  
					return $val;  
					break;  
				case 'a' :  
				case 'b' :  
				case 'c' :  
				case 'd':  
				case 'e':  
				case 'f':  
				case 'g':  
				case 'h':  
				case 'i':  
				case 'j':  
				case 'k':  
				case 'l':  
				case 'm':  
				case 'n':  
				case 'o':  
				case 'p':  
				case 'q':  
				case 'r':  
				case 's':  
				case 't':  
				case 'u':  
				case 'v':  
				case 'w':  
				case 'x':  
				case 'y':  
				case 'z':  
				case 'A' :  
				case 'B' :  
				case 'C' :  
				case 'D':  
				case 'E':  
				case 'F':  
				case 'G':  
				case 'H':  
				case 'I':  
				case 'J':  
				case 'K':  
				case 'L':  
				case 'M':  
				case 'N':  
				case 'O':  
				case 'P':  
				case 'Q':  
				case 'R':  
				case 'S':  
				case 'T':  
				case 'U':  
				case 'V':  
				case 'W':  
				case 'X':  
				case 'Y':  
				case 'Z':     
				case '0':  
				case '1':  
				case '2':  
				case '3':  
				case '4':  
				case '5':  
				case '6':  
				case '7':  
				case '8':  
				case '9':  
					//字符串  
					if ( trim( $chr ) === '' ) {  
						continue;  
					}  
					$val = $chr;  
					while( preg_match( '#^[a-zA-Z0-9\.]$#' , $json[++$i] ) ) {  
						$val .= $json[$i];                                    
					}  
					$lVal = strtolower( $val );  
					if ( $lVal == 'true' ) {  
						return true;  
					}  
					if ( $lVal == 'false' ) {  
						return false;  
					}  
					if ( preg_match( '#^[0-9\.]+$#' , $lVal ) ) {  
						return $val + 0;  
					}  
					return $val;  
				case '{' :  
					$val = array();  
					$i ++;  
					$key = '';  
					while( $json[$i] != '}' ) {  
						$key .= $json[$i];  
						$i ++;  
						if ( $json[$i] == ':' ) {  
							$key = ltrim( $key );  
							$key = ltrim( $key , ',' ); //去除,  
							$key = trim( $key );//去两边的空白  
							if ( preg_match( '#^"(.+?)"$#' , $key , $m ) ) {  
								$key = $m[1];  
							}  
							if ( preg_match( '#^\'(.+?)\'$#' , $key , $m ) ) {   
								$key = $m[1];   
							}   
							++ $i;   
							$val[$key] = $this->jsonDecode( $json , $to_encode , $i );   
							$key = '';                         
						}                      
					}   
					++ $i;   
					return $val;   
					break;   
				case '[' :   
					$val = array();   
					$i ++;   
					$t = 0;   
					while( $json[$i] != ']' ) {   
						if ( $json[$i] == ',' ) {   
							$i ++;   
							continue;   
						}                      
						$val[] = $this->jsonDecode( $json , $to_encode  , $i );                       
					   
					}   
					$i ++;   
					return $val;   
					break;   
			}   
		}   
		return NULL ;   
	}   
	
	function bulk($accountid)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		require_once(CFG_PATH_DATA.'ebay/ebay_'.$accountid.'.php');
		$serverUrl = 'https://webservices.ebay.com/BulkDataExchangeService';
		$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
		<createUploadJobRequest xmlns="http://www.ebay.com/marketplace/services">
		  <uploadJobType>ReviseInventoryStatus</uploadJobType>
		  <UUID>ecpp-'.CFG_TIME.rand(0,1000).'</UUID>
		  <fileType>XML</fileType>
		</createUploadJobRequest>';
			$session = new eBaybulk($userToken, $serverUrl, 'createUploadJob');
			$responseXml = $session->sendHttpRequest($requestXmlBody);
			$data=XML_unserialize($responseXml);
			$result1 = $data['createUploadJobResponse'];
			if($result1['ack'] == 'Failure'){
				if($result1['errorMessage']['error']['errorId'] ==7) return '存在未确认的job';		
			}else{
				$fileReferenceId = $result1['fileReferenceId']; 
				$taskReferenceId =  $result1['jobId'];
			}
			$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
			<uploadFileRequest xmlns="http://www.ebay.com/marketplace/services">
			  <fileAttachment>
				<Data>'.base64_encode(gzencode(file_get_contents(CFG_PATH_DATA.'ebay/bulk_'.$_SESSION['admin_id'].'.xml'), 5)).'</Data>
			  </fileAttachment>
			  <fileFormat>gzip</fileFormat>
			  <fileReferenceId>'.$fileReferenceId.'</fileReferenceId>
			  <taskReferenceId>'.$taskReferenceId.'</taskReferenceId>
			</uploadFileRequest>';
			$session = new eBaybulk($userToken, 'https://storage.ebay.com/FileTransferService', 'uploadFile');
			$responseXml = $session->sendHttpRequest($requestXmlBody);
			$result2 = $data['uploadFileResponse'];
			if($result2['ack'] == 'Failure'){
				return $result2['errorMessage']['error']['message'];
			}
			$requestXmlBody = '<?xml version="1.0" encoding="utf-8"?>
			<startUploadJobRequest xmlns="http://www.ebay.com/marketplace/services">
			  <jobId>'.$taskReferenceId.'</jobId>
			</startUploadJobRequest>';
			$session = new eBaybulk($userToken, $serverUrl, 'startUploadJob');
			$responseXml = $session->sendHttpRequest($requestXmlBody);
			$data=XML_unserialize($responseXml);
			if($result2['ack'] == 'Failure'){
				return $result2['errorMessage']['error']['message'];	
			}
			return '补货完成'.$taskReferenceId;
	}
	function ReviseInventoryStatus($id)
	{
		$info = $this->db->getValue("SELECT account_id,ItemID,SKU,Quantity,StartPrice FROM ".CFG_DB_PREFIX.'ebayselling_bulk where rec_id='.$id);
		$verb = 'ReviseInventoryStatus';
		require_once(CFG_PATH_DATA . 'ebay/ebay_' . $info['account_id'] .'.php');
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		require_once(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
    	if(stristr($responseXml, 'HTTP 404') || $responseXml == ''){
			 throw new Exception('Error sending request','900');exit();
		}
		$responseDoc = new DomDocument();
		$responseDoc->loadXML($responseXml);
		$root = $responseDoc->documentElement;
		$ack = $responseDoc->getElementsByTagName('Ack');
		$reack = $ack->item(0)->nodeValue;
		if($reack == 'Success'){
			return 'OK';
		}else{
			throw new Exception('更改失败','905');exit();
		}
	}
}
?>