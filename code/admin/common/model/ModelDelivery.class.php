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
 * 订单操作类a
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelDelivery extends ModelOrder{
    
    /**
     * 构造函数
     *
     * @param object $query
     */
    function __construct($query=null) {
        parent::__construct($query);
    }
    function updatetrackinfo($order_id){
        set_time_limit(0);
        $ids = explode(',',$order_id);
        $str = '';
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $shippingStatus = array(
            0 => '暂无信息',
            1 => '运输途中',
            2 => '到达待取',
            3 => '成功签收',
            4 => '物件退回',
            5 => '运往当地',
        );
        foreach($ids as $id){
            $order = $this->db->getValue("select track_no,order_sn from ".CFG_DB_PREFIX."order where order_id=".$id);
            $status = $this->db->getValue("select status from ".CFG_DB_PREFIX."trackinfo where order_id=".$id);
                $requestBody = array('mailNo'=>$order['track_no']);
                $connection = curl_init( );
                curl_setopt( $connection, CURLOPT_URL, 'http://api.sao.cn/track');
                curl_setopt( $connection, CURLOPT_SSL_VERIFYPEER, 0 );
                curl_setopt( $connection, CURLOPT_SSL_VERIFYHOST, false );
                curl_setopt( $connection, CURLOPT_POST, 1 );
                curl_setopt( $connection, CURLOPT_POSTFIELDS, http_build_query($requestBody) );
                curl_setopt( $connection, CURLOPT_RETURNTRANSFER, 1 );
                $response = curl_exec( $connection );
                curl_close( $connection );
                
                $text = "";
                $arr = json_decode($rs[11]);
                $today = date("Y-m-d H:i:s",time());           
                $package_location = '';
                $last_info = '';     
                $text = "<ul style=\"list-style:none\"><li>运单状态：{$shippingStatus[$arr->mstatus]}  ,  发件国家:{$arr->srcId}/{$arr->srcName}   ,  收件国家: {$arr->dstId}/{$arr->dstName}</li><li>历史邮包事件:</li>";
                foreach((array)$arr->srcEvent as $key => $value){
                    if(($key+1) == count($arr->srcEvent)){
                        $last_info = "<span>{$value->datetime}, {$value->content} ,{$value->location}</span>";   
                    }
                    $text .= "<li>{$value->datetime}, {$value->content} ,{$value->location}</li>";
                }
                $text .= "</ul>";
                if($shippingStatus[$arr->mstatus] == '')$shippingStatus[$arr->mstatus] = '暂无信息';
                if($last_info=='' || !$last_info || $last_info == null ){
                    $last_info = '暂时没有物流信息';    
                }
                $this->db->execute("DELETE FROM `myr_trackinfo` WHERE `order_id`=".$id);
                $this->db->insert(CFG_DB_PREFIX."trackinfo",array(
                    'order_id' => $id,
                    'text' => trim($text),
                    'status' => $statused,
                    'update_time' => date('Y-m-d',time()),
                    'last_info' => $last_info
                ));
                if($status !== $shippingStatus[$arr->mstatus])
                $this->save_order_log($id,'更改物流运输状态','状态由'.$status.',更新为'.$statused);
                $str .= $order['track_no'].'未更新前状态为'.$status.',更新后状态为'.$shippingStatus[$arr->mstatus].'<br>';
        }
        return $str;
    }
    /**
     * 获取追踪单号的快递信息
     * @param string $order_id  订单号 根据订单号查取追踪单号
     * @return string
     */
    public function getTrackInfo($order_id){
        /*if($type == null){
            $info = $this->db->getValue("select count(order_id) from ".CFG_DB_PREFIX."trackinfo where order_id=".$order_id);
            if($info){
                $re = $this->db->getValue("select text from ".CFG_DB_PREFIX."trackinfo where order_id=".$order_id);
            }else{
                set_time_limit(120);
                $track_no = $this->db->getValue("select track_no from ".$this->tableName." where order_id=".$order_id);
                $ordersn = $this->db->getValue("select order_sn from ".$this->tableName." where order_id=".$order_id);
                if($track_no){
                    $requestBody = array('mailNo'=>$track_no);
                    $connection = curl_init( );
                    curl_setopt( $connection, CURLOPT_URL, 'http://api.sao.cn/track');
                    curl_setopt( $connection, CURLOPT_SSL_VERIFYPEER, 0 );
                    curl_setopt( $connection, CURLOPT_SSL_VERIFYHOST, false );
                    curl_setopt( $connection, CURLOPT_POST, 1 );
                    curl_setopt( $connection, CURLOPT_POSTFIELDS, http_build_query($requestBody) );
                    curl_setopt( $connection, CURLOPT_RETURNTRANSFER, 1 );
                    $response = curl_exec( $connection );
                    curl_close( $connection );
                    $text = "";
                    require(CFG_PATH_LIB.'util/JSON.php');
                    $json = new Services_JSON();
                    $arr = $json->decode($response);
                    $today = date("Y-m-d H:i:s",time());
                    $ordersn = CFG_ORDER_PREFIX.$ordersn;
                    $text = "<table cellpadding=\"1\" cellspacing=\"1\" border=\"0\" style=\"font-size:12px;border:1px solid #000\">
                    <tr><td>订单号:</td><td>{$ordersn}</td></tr>
                    <tr><td>最后更新时间:</td><td>{$today}</td></tr>
                    <tr><td>快递单号:</td><td>{$arr->mailNo}</td></tr>
                    <tr><td>快递方式:</td><td>{$arr->mailType}</td></tr>
                    <tr><td>运单状态:</td><td>{$arr->mailStatus}</td></tr>
                    <tr><td>发件国家:</td><td>{$arr->srcId}/{$arr->srcName}</td></tr>
                    <tr><td>收件国家:</td><td>{$arr->dstId}/{$arr->dstName}</td></tr>
                    <tr><td>最新邮包事件:</td><td>{$arr->lastEvent->datetime}&nbsp;&nbsp;&nbsp;{$arr->lastEvent->content}&nbsp;&nbsp;&nbsp;地点:{$arr->lastEvent->location}</td></tr>
                    <tr><td style=\"text-align:center\" colspan=\"2\">历史邮包事件:</td></tr>";
                    foreach((array)$arr->srcEvent as $key => $value){
                        $key += 1;
                        $text .= "<tr><td>{$key}</td><td>{$value->datetime}&nbsp;&nbsp;&nbsp;{$value->content}&nbsp;&nbsp;&nbsp;地点:{$value->location}</td></tr>";
                    }
                    $status = ($arr->mailStatus) ? $arr->mailStatus : '查询不到';
                    $text .= "</table>";
                    $this->db->insert(CFG_DB_PREFIX."trackinfo",array(
                        'order_id' => $order_id,
                        'text' => trim($text),
                        'status' => $status
                    ));
                    $re = $text;
                }else{
                    $re = '没有追踪单号';
                }
            }*/
            return $this->db->getValue("select text from ".CFG_DB_PREFIX."trackinfo where order_id=".$order_id);;
        
    }
    /******
    *获取4PX4PX追踪单号
    ******/
    function get4pxtrack($info)
    {
        $client = new SoapClient ("http://myorder.4px.cc/services/OrderServices?wsdl", array ('encoding' => 'UTF-8' ));
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> ''){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                $this->db->execute("update ".$this->tableName." set order_status =". $status." where order_id =".$id[$i]);
                continue;
                }
            $shipping = $this->exchange4pxcode($order_info['shipping_id']);
            $params2['Contact'] = $contact_normal."(".ModelDd::getCaption('allaccount',$order_info['Sales_account_id']).")"; 
            if($shipping == 'ERROR' || $shipping == NULL) {$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'运输方式命名非4px指定<br>';continue;}
            $modelgoods = new ModelGoods();
            $expressHawbOrderBeanArray = array();
            $orderdetailArray = array();
            $orderObject = new stdClass();
            if(( $shipping == 'A0115' || $shipping == 'A0119')&& $order_info['CountryCode'] == 'US'){
                $add2 = $order_info['city'];
                $add3 = $order_info['state'];
            }else{
                $add2 = $order_info['city'].','.($order_info['state']?$order_info['state'].',':'');
                $add3 = $order_info['country'];
            }
            $orderObject->customerOrderNo = CFG_ORDER_PREFIX.$order_info['order_sn'];
            $orderObject->orderNo = CFG_ORDER_PREFIX.$order_info['order_sn'];
            $orderObject->trackingHawbCode = null;
            $orderObject->serviceKind = $shipping;
            $orderObject->paymentMode = null;
            $orderObject->cargoType = null;
            $orderObject->countryCode =  $order_info['CountryCode'];
            $orderObject->shipperName = $params2['Contact'];
            $orderObject->shipperAddress = $params2['Street'];
            $orderObject->shipperCompanyName = $params2['Company'];
            $orderObject->shipperTelephone = $params2['Mobile'];
            $orderObject->consigneeName = $order_info['consignee'];
            $orderObject->consigneeAddress1 = $order_info['street1'].(($order_info['street2'])?','.$order_info['street2']:'').',';
            $orderObject->consigneeAddress2 = $add2;
            $orderObject->consigneeAddress3 = $add3;
            $orderObject->consigneeAddress4 = null;
            $orderObject->consigneeAddress5 = null;
            $orderObject->consigneeEMail = 'aa@aa.com';
            $orderObject->consigneeTelephone = ($order_info['tel']=="Invalid Request")?"":$order_info['tel'];
            $orderObject->consigneePostCode = ($order_info['CountryCode'] == 'US')?substr($order_info['zipcode'],0,5):$order_info['zipcode'];
            $orderObject->insuranceType = 'N';
            $orderObject->insuranceValue = null;
            $orderObject->printSign = null;
            $orderObject->transactionID = null;
            $orderObject->totalPieces = null;
            $expressHawbOrderBeanArray[] = $orderObject;
            $goods_info = $this->order_goods_info($id[$i]);
            $total=0;$value=0;
            for($j=0;$j<count($goods_info);$j++){
                        $getgoods = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                        $dec_name = $getgoods['dec_name']?$getgoods['dec_name']:CFG_DEC_NAME;
                        $dec_name_cn = $getgoods['dec_name_cn']?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                        $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                        $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                        $total +=  $goods_info[$j]['goods_qty'];
                        $value += $Declared_value*$goods_info[$j]['goods_qty'];
                        $orderdetail = new stdClass();
                        $orderdetail->declareEName = $dec_name;
                        $orderdetail->pieces = $goods_info[$j]['goods_qty'];
                        $orderdetail->declarePrice = $Declared_value;
                        $orderdetail->declareCurrency = 'USD';
                        $orderdetail->declareCName = $goods_info[$j]['goods_sn'];
                        $orderdetailArray[] = $orderdetail; 
            }
            if($value>$CFG_DECLARED_MAX){
                for($t=0;$t<count($orderdetailArray);$i++){
                    $orderdetailArray[$t]->declarePrice = floor($CFG_DECLARED_MAX/$total);;
                }                
                }
            $orderObject->objDI = $orderdetailArray;
            $temp = array("in0"=>CFG_4PX_NAME,"in1"=>$expressHawbOrderBeanArray);
            $order_register= $client->orderRegisterAndPrealertService($temp);
            if($order_register->out->ReturnValueResult->orderActionState == 'N') {
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].$order_register->out->ReturnValueResult->remark.'<br>';
                continue;
            }elseif($order_register->out->ReturnValueResult->orderActionState == 'Y'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'track_no' => $order_register->out->ReturnValueResult->trackingHawbCode
                                ),'order_id ='.$id[$i]);
            }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误'.$order_register->out->ReturnValueResult->remark.'<br>';
            }
        }
        $msg .= '交运完成';
        return $msg;
    }

    function Create4pxOrder($info){ 
        header ( "content-type:text/html;charset=utf-8" );
        @ini_set("soap.wsdl_cache_enabled", "0"); // disabling WSDL cache
        set_time_limit(600);          
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        
        if(!empty($info['token']) && $info['token'] == 'DZ7551614'){     
            $GLOBALS['AUTHTOKEN'] = CFG_4PX_TOKEN2;
        }else{                                                      
            $GLOBALS['AUTHTOKEN'] = CFG_4PX_TOKEN; 
        }
        require_once(CFG_PATH_LIB . '4px/OrderOnline.php');     
        $soap = new OrderOnline();
        
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> '') continue;
            $shipping = $this->exchange4pxcodenew($order_info['shipping_id']);
            $params2['Contact'] = $contact_normal."(".ModelDd::getCaption('allaccount',$order_info['Sales_account_id']).")"; 
            if($shipping == 'ERROR' || $shipping == NULL) {$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'运输方式命名非4px指定<br>';continue;}
            $modelgoods = new ModelGoods();
            $CreateOrderRequestArray = array(
                "buyerId" => $order_info['userid'],
                "cargoCode" => 'P',
                "city" => $order_info['city'],//城市 【***】
                "consigneeCompanyName" => $order_info['consignee'],//收件人公司名称
                "consigneeEmail" => 'aa@aa.com',//收件人Email 
                "consigneeFax" => ($order_info['tel']=="Invalid Request")?"":$order_info['tel'],//收件人传真号码
                "consigneeName" => $order_info['consignee'],
                "consigneePostCode" => ($order_info['CountryCode'] == 'US')?substr($order_info['zipcode'],0,5):$order_info['zipcode'],//收件人邮编
                "consigneeTelephone" => ($order_info['tel']=="Invalid Request")?"":$order_info['tel'],//收件人电话号码
                "destinationCountryCode" => $order_info['CountryCode'],
                "initialCountryCode" => 'CN',//起运国家二字代码，参照国家代码表【***】        
                "orderNo" => CFG_ORDER_PREFIX.$order_info['order_sn'],//客户订单号码，由客户自己定义【***】
                "orderNote" => '',//订单备注信息 
                "paymentCode" => 'P',//付款类型(默认：P)，参照付款类型表         
                "customerWeight" => '50',//客户自己称的重量(单位：KG) 
                "productCode" => $shipping,//产品代码，指DHL、新加坡小包挂号、联邮通挂号等，参照产品代码表 【***】
                "returnSign" => (CFG_RETURN_4PX == 1)?'Y':'N',//小包退件标识 Y: 发件人要求退回 N: 无须退回(默认) 
                "shipperAddress" => $params2['Street'],
                "shipperCompanyName" => $params2['Company'],//发件人公司名称 
                "shipperName" => $params2['Contact'],//发件人姓名 
                "shipperPostCode" => '518000',//发件人邮编
                "shipperTelephone" => $params2['Mobile'],//发件人电话号码
                "stateOrProvince" => $order_info['state'],//州  /  省 【***】
                "street" => $order_info['street1'].(($order_info['street2'])?','.$order_info['street2']:''),//街道【***】
                "transactionId" => $order_info['paypalid'],//交易ID 
            );
            $DeclareInvoiceItemArray = array();                     
            $goods_info = $this->order_goods_info($id[$i]);
            $total=0;$value=0;
            for($j=0;$j<count($goods_info);$j++){
                $getgoods = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                $dec_name = $getgoods['dec_name']?$getgoods['dec_name']:CFG_DEC_NAME;
                $dec_name_cn = $getgoods['dec_name_cn']?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                $total +=  $goods_info[$j]['goods_qty'];
                $value += $Declared_value*$goods_info[$j]['goods_qty'];
                $DeclareInvoiceItemArray[] = array(
                    "declareNote" => '',//配货备注
                    "declarePieces" => $goods_info[$j]['goods_qty'],//件数(默认: 1)
                    "declareUnitCode" =>'PCE',//申报单位类型代码(默认:  PCE)，参照申报单位类型代码表
                    "eName" => $dec_name,//海关申报英文品名
                    "name" => $dec_name_cn,//海关申报中文品名
                    "unitPrice" => $Declared_value,//单价 0 < Amount <= [10,2]【***】
                ); 
            }
            $CreateOrderRequestArray['pieces'] = $total;
            $CreateOrderRequestArray['customerWeight'] = 1;
            $CreateOrderRequestArray['declareInvoice'] = $DeclareInvoiceItemArray;
            if($value>$CFG_DECLARED_MAX){
                for($t=0;$t<count($DeclareInvoiceItemArray);$t++){
                    $DeclareInvoiceItemArray[$t]->unitPrice = floor($CFG_DECLARED_MAX/$total);
                }                
            }
            $result = $soap->createAndPreAlertOrderService($CreateOrderRequestArray);         
            if($result['ack'] == 'Success'){
                $this->db->execute("update ".$this->tableName." set track_no = '".$result['trackingNumber']."' where order_id = ".intval($id[$i]));        
                $msg .= '订单'.$result['referenceNumber'].'预报成功，追踪号码：'.$result['trackingNumber'].'<br>';
            }else{
                $msg .= '订单'.$result['referenceNumber'].'预报失败，错误码：'.$result['code'].', '.$result['cnMessage'].'<br>';
            }   
        }                       
        return $msg;
    }
    function PreAlert4pxOrder($info)
    {
        
        
        
        if(!empty($info['token']) && $info['token'] == 'DZ7551614'){
            
            $token = CFG_4PX_TOKEN2;    
            
        }else{
            $token = CFG_4PX_TOKEN; 
        }
        $client = new SoapClient ("http://api.4px.com/OrderOnlineService.dll?wsdl", array ('encoding' => 'UTF-8' ));
        $order_info = $this->order_info($id);
        $ids = $info['id'];
        $id = explode(',',$ids);
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            $StringArray[] = CFG_ORDER_PREFIX.$order_info['order_sn'];
        }
        $temp = array("in0"=>$token,"in1"=>$StringArray);
        $order_register= $client->PreAlertOrderService($temp)->out->PreAlertOrderResponse;
        $msg = '';
        if(is_array($order_register)){
            for($i=0;$i<count($order_register);$i++){
                if($order_register[$i]->ack == 'Success'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_sn = '".substr($order_register[$i]->referenceNumber,strlen(CFG_ORDER_PREFIX))."'");
                    $this->db->execute("update ".$this->tableName." set track_no = '".$order_register[$i]->trackingNumber."',order_status = '".$status."' where order_sn = '".substr($order_register[$i]->referenceNumber,strlen(CFG_ORDER_PREFIX))."'");
                    $orderinfo = $this->order_info('',substr($order_register[$i]->referenceNumber,strlen(CFG_ORDER_PREFIX)));
                    $this->save_order_log($orderinfo['order_id'],'更改状态','订单状态被更改为'.$status);
                    }else{
                    $msg .= $order_register[$i]->referenceNumber.'预报失败'.    $order_register[$i]->errors->Error->cnMessage.'<br>';
                }    
            }
        }else{//单个订单
                if($order_register->ack == 'Success'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_sn = '".substr($order_register->referenceNumber,strlen(CFG_ORDER_PREFIX))."'");
                    $this->db->execute("update ".$this->tableName." set track_no = '".$order_register->trackingNumber."',order_status = '".$status."' where order_sn = '".substr($order_register->referenceNumber,strlen(CFG_ORDER_PREFIX))."'");
                    $orderinfo = $this->order_info('',substr($order_register->referenceNumber,strlen(CFG_ORDER_PREFIX)));
                    $this->save_order_log($orderinfo['order_id'],'更改状态','订单状态被更改为'.$status);
                    }else{
                    $msg .= $order_register->referenceNumber.'预报失败'.    $order_register->errors->Error->cnMessage.'<br>';
                }
        }
        return $msg;
    }
    function CreateytgOrder($info)
    {
        $client = new SoapClient ("http://sys.etg56.com:8880/wb_lc/cxf/ParcelWebService?wsdl");
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> '') continue;
            $shipping = $this->exchangeytgcodenew($order_info['shipping_id']);
            $params2['Contact'] = $contact_normal."(".ModelDd::getCaption('allaccount',$order_info['Sales_account_id']).")"; 
            if($shipping == 'ERROR' || $shipping == NULL) {$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'运输方式命名非4px指定<br>';continue;}
            $parameter = array( 
                     'companyID' => CFG_YTG_ID,
                     'pwd' =>CFG_YTG_KEY,
                     'parcelList' => array(
                        array(
                            'vsnumber' => '',
                            'apdate' => date('Y-m-d'),
                            'apTdate' => date('Y-m-d'),
                            'apuserid' => '',
                            'apuserName' => '',
                            'parcelstatus' => '1',
                            'apmethod' => $shipping,
                            'apname' =>  $order_info['consignee'],
                            'apaddress' => $order_info['street1'].(($order_info['street2'])?','.$order_info['street2']:''),
                            'apdestination' => $order_info['country'],
                            'aplabel' => '',
                            'aptrackingNumber' => '',
                            'apnote' => '',
                            'apBuyerID' => $order_info['userid'],
                            'apItemurl' => '',
                            'apItemTitle' => '',
                            'apTransactionID' => '',
                            'apFromEmail' => '',
                            'ebayID' => '',
                            'apTel' => ($order_info['tel']=="Invalid Request")?"":$order_info['tel'],
                            'zipCode' => $order_info['zipcode'],
                            'refNo' => CFG_ORDER_PREFIX.$order_info['order_sn'],
                            'shipName' => '',
                            'desName' => '',
                            'apinsurance' => '',
                            'aptype' => '',
                            'apdescription' => '',
                            'apquantity' => '',
                            'apweight' => '',
                            'apvalue' => '',
                            'apGross' => '',
                            'tm' => '',
                            'city' => $order_info['city'],
                            'province' => $order_info['state']
                        )
                            ),
              );            
        $result=$client->AddParcelService($parameter);    
        if($result->return->success == 1){
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交成功<br>';
            }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败'.$result->return->errorCode.'<br>';
        }
        }
        $msg .= '提交订单完成';
        return $msg;
    }
    function PreAlertytgOrder($info)
    {
        $client = new SoapClient ("http://sys.etg56.com:8880/wb_lc/cxf/ParcelWebService?wsdl");
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        $orderlist = array();
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> '') continue;
            $orderlist[] = CFG_ORDER_PREFIX.$order_info['order_sn'];
        }
        $parameter = array( 
         'companyID' => CFG_YTG_ID,
         'pwd' =>CFG_YTG_KEY,
         'refNos' => orderlist
         );            
        $order_register= $client->forecastByRefNoService($parameter)->return;
        $msg = '';
        if(is_array($order_register)){
            for($i=0;$i<count($order_register);$i++){
                if($order_register[$i]->success == 1){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_sn = '".substr($order_register[$i]->refNo,strlen(CFG_ORDER_PREFIX))."'");
                    $this->db->execute("update ".$this->tableName." set track_no = '".$order_register[$i]->trackingNo."',order_status = '".$status."' where order_sn = '".substr($order_register[$i]->refNo,strlen(CFG_ORDER_PREFIX))."'");
                    $orderinfo = $this->order_info('',substr($order_register[$i]->refNo,strlen(CFG_ORDER_PREFIX)));
                    $this->save_order_log($orderinfo['order_id'],'更改状态','订单状态被更改为'.$status);
                    }else{
                    $msg .= $order_register[$i]->refNo.'预报失败'.    $order_register[$i]->errorCode.'<br>';
                }    
            }
        }else{//单个订单
                if($order_register->ack == 'Success'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_sn = '".substr($order_register->refNo,strlen(CFG_ORDER_PREFIX))."'");
                    $this->db->execute("update ".$this->tableName." set track_no = '".$order_register->trackingNo."',order_status = '".$status."' where order_sn = '".substr($order_register->refNo,strlen(CFG_ORDER_PREFIX))."'");
                    $orderinfo = $this->order_info('',substr($order_register->refNo,strlen(CFG_ORDER_PREFIX)));
                    $this->save_order_log($orderinfo['order_id'],'更改状态','订单状态被更改为'.$status);
                    }else{
                    $msg .= $order_register->refNo.'预报失败'.    $order_register->errorCode.'<br>';
                }
        }
        return $msg;
    }
    
    function exchangeytgcodenew($express)
    {
        $shipping = ModelDd::getCaption('shipping',$express);
        switch($shipping)
        {
            case 'HK挂号':
            return 'HKR';
            case 'HK平邮':
            return 'HKA';
            case 'HKEMS':
            return 'HKEMS';
            case 'HKCP大包空邮':
            return 'HKCP';
            case '大陆CP大包空邮':
            return 'CNCP';
            case '香港DHL':
            return 'HKDHL';
            case '香港UPS':
            return 'HKUPS';
            case 'Fedex':
            return 'Fedex';
            case 'TNT':
            return 'TNT';
            case '新加坡挂号':
            return 'SGR';
            case '新加坡EMS':
            return 'SGPEMS';
            case '深圳EMS普货':
            return 'SZEMS';
            case '深圳挂号':
            return 'SZR';
            case '华邮中港专线':
            return 'CPSHKZX';
            case 'HKCP大包平邮':
            return 'HKPS';
            case '香港特快挂号':
            return 'HKP';
            case '深圳EMS仿货':
            return 'SZEMSFH';
            case 'HKEMS电子烟':
            return 'HKEMSDZY';
            case '邮政美国专线':
            return 'GSSUS';
            default:
            return NULL;
        }
    }
    
    /********
    *4px运输代码转换
    *input  $express系统内部exprssid
    ********/
    function exchange4pxcodenew($express)
    {
        $shipping = ModelDd::getCaption('shipping',$express);
        switch($shipping)
        {
            case '中国小包平邮':
            return 'ZP';
            case '中国小包挂号':
            return 'ZG';
            case '东莞小包平邮':
            return 'ZP';
            case '东莞小包挂号':
            return 'ZG';
            case '华南小包平邮':
            return 'F3';
            case '华南小包挂号':
            return 'F4';
            case '香港联邦IP':
            return 'E4';
            case '香港联邦IE':
            return 'E5';
            case '新加坡EMS':
            return 'C3';
            case '新加坡EMS特惠':
            return 'K9';
            case '香港联邦IP标准':
            return 'D3';
            case '香港联邦IE经济':
            return 'D4';
            case '联邮通空邮包裹服务':
            return 'E2';
            case 'TNT出口':
            return 'H4';
            case '4PX香港件':
            return 'H3';
            case '香港邮政EMS':
            return 'C2';
            case '香港TNT特惠':
            return 'D2';
            case '4PX专线ARMX':
            return 'A4';
            case '香港邮政美国专线':
            return 'C5';
            case '4PX联邮通平邮':
            return 'A7';
            case '4PX联邮通挂号':
            return 'A6';
            case '中国邮政小包(上海)':
            return 'B9';
            case 'DHL出口':
            return 'A1';
            case 'DHL小包裹特惠':
            return 'C8';
            case '杭州小包平邮':
            return 'C9';
            case '杭州小包挂号':
            return 'E3';
            case '新加坡小包挂号':
            return 'B1';
            case '新加坡小包挂号特惠':
            return 'F5';
            case '中国EMS国际':
            return 'C1';
            case '香港小包挂号':
            return 'B3';
            case '香港小包平邮':
            return 'B4';
            case '4PX标准':
            return 'A2';
            case '新加坡小包平邮':
            return 'B2';
            case '香港UPS':
            return 'D5';
            case '香港空邮包裹':
            return 'C4';
            case '大陆联邦快递优先型服务IP':
            return 'D6';
            case '大陆联邦快递经济型服务IE':
            return 'D7';
            default:
            return NULL;
        }
    }
    
    /*******
    ***美仓订单提交
    ********/
    function uploadcool($info)
    {
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_LIB . 'util/nusoap.php');
        $client=new nusoap_client(CFG_COOL_URL.'/ois_server.php?wsdl',true);
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            $info = array();
            $info['userid']= $order_info['userid'];
            $info['shipping_fee']= $order_info['shipping_fee'];
            $info['FEEAMT']= $order_info['FEEAMT'];
            $info['order_amount']= $order_info['order_amount'];
            $info['currency']= $order_info['currency'];
            $info['sellerID']= $order_info['sellerID'];
            $info['paypalid']= CFG_ORDER_PREFIX.$order_info['order_sn'];
            $info['consignee']= $order_info['consignee'];
            $info['email']= 'aa@aa.com';
            $info['street1']= $order_info['street1'];
            $info['street2']= $order_info['street2'];
            $info['city']= $order_info['city'];
            $info['state']= $order_info['state'];
            $info['country']= $order_info['country'];
            $info['CountryCode']= $order_info['CountryCode'];
            $info['zipcode']= $order_info['zipcode'];
            $info['tel']= $order_info['tel'];
            $info['sales_site']= $order_info['sales_site'];
            $info['pay_note']= $order_info['pay_note'];
            $info['sellsrecord']= $order_info['sellsrecord'];
            $info['ShippingService']= $order_info['ShippingService'];
            $info['paid_time']= $order_info['paid_time'];
            $goods = array();
            $goods_info = $this->order_goods_info($id[$i]);
                for($t=0;$t<count($goods_info);$t++){
                    $product['goods_sn'] = $goods_info[$t]['goods_sn'];
                    $product['goods_name'] = $goods_info[$t]['goods_name'];
                    $product['goods_qty'] = $goods_info[$t]['goods_qty'];
                    $product['goods_price'] = $goods_info[$t]['goods_price'];
                    $product['TransactionID'] = $goods_info[$t]['TransactionID'];
                    $product['item_no'] = $goods_info[$t]['item_no'];
                    $goods[] = $product;
                }
            $params=array(CFG_COOL_TOKEN,$info,$goods);
            $result=$client->call('addOrder',$params);
            if($result['faultcode'] == 'False'){
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败:'.$result['faultstring'];
            }elseif($result['faultcode'] == 'True'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'is_upload' =>1
                                ),'order_id ='.$id[$i]);
            }else{
                return $msg.CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误'.'<br>';
            }
        }
        $msg .= '交运完成';
        return $msg;
    }
    
    function completecool()
    {
        if(CFG_ENABLE_COOL == 1){
        $shipping = $this->getExshipping('US');
        $orders = $this->db->select("select order_id,order_sn FROM ".$this->tableName." where shipping_id in(".$shipping.") and order_status in (129,131) and is_upload = 1 order by order_id limit 100");
        if(count($orders) == 0) return '无需要更新订单';
        $msg = '';
        require_once(CFG_PATH_LIB . 'util/nusoap.php');
        $client=new nusoap_client(CFG_COOL_URL.'/ois_server.php?wsdl',true);
        for($i=0;$i<count($orders);$i++){
            $params=array(CFG_COOL_TOKEN,CFG_ORDER_PREFIX.$orders[$i]['order_sn']);
            $result=$client->call('getTrack',$params);
            if($result['faultcode'] == 'False'){
                if($result['faultstring'] == "找不到对应的客户订单") $this->db->execute("update ".$this->tableName." set is_upload =0 where order_id =".$orders[$i]['order_id']);
                $msg .= CFG_ORDER_PREFIX.$orders[$i]['order_sn'].'获取失败:'.$result['faultstring']."<br>";
            }elseif($result['faultcode'] == 'True'){
                $detail = explode("||",$result['faultstring']);
                            $this->db->update($this->tableName,array(
                                'track_no' => $detail[0],
                                'shipping_cost' => $detail[1],
                                'is_upload' =>2
                                ),'order_id ='.$orders[$i]['order_id']);
                $msg .= CFG_ORDER_PREFIX.$orders[$i]['order_sn'].'更新成功'."<br>";
            }else{
                return $msg.CFG_ORDER_PREFIX.$orders[$i]['order_sn'].'未知错误'.'<br>';
            }
            
            }
            return $msg;
        }else{
            return '美仓接口未启用，请在系统设置中启用';    
        }
    }
    /*******
    ***英仓订单提交
    ********/
    function uploadbird($info)
    {
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $ch = curl_init();
        $url = CFG_BIRD_URL.'/Temp-Consignment-Info';
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $object = new ModelGoods();
        $headers = array ('api_key:'.CFG_BIRD_TOKEN);
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            $info = array();
            $info['order_amount']= $order_info['order_amount'];
            $date['alternative_reference'] = $order_info['paypalid'];
            $info['sales_reference']= CFG_ORDER_PREFIX.$order_info['order_sn'];
            $info['contact']= $order_info['consignee'];
            $info['email']= 'aa@aa.com';
            $info['address_line_1']= $order_info['street1'];
            $info['address_line_2']= $order_info['street2'];
            $info['city']= $order_info['city'];
            $info['county']= $order_info['state'];
            $info['country_name']= $order_info['country'];
            $info['post_code']= $order_info['zipcode'];
            $info['telephone']= $order_info['tel'];
            $info['delivery_service_name']= ModelDd::getCaption('shipping',$order_info['shipping_id']);
            $info['paid_time']= $order_info['paid_time'];
            $goods_info = $this->order_goods_info($id[$i]);
            $goods = $goodsname = '';
                for($t=0;$t<count($goods_info);$t++){
                    $goodsname = $goods_info[$t]['goods_name'];
                    $goods_detail = $object->goods_info("",$goods_info[$t]['goods_sn']);
                    $goods_sn = ($goods_detail['code']<>'')?$goods_detail['code']:$goods_info[$t]['goods_sn'];
                    $goods .= '+'.$goods_sn.'*'.$goods_info[$t]['goods_qty'];
                }
            $info['product_name'] = $goodsname;
            $info['product_company_ref'] = substr($goods,1);
            $info['quantity'] = 1;
            curl_setopt ($ch, CURLOPT_URL, $url);
            curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
            curl_setopt ($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT,10);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS,$info);
            $img = curl_exec($ch);
            $result = $json->decode($img);
            $status = $result->success;
            if(!$status){
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败:'.$result['faultstring'];
            }elseif($status == true){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'is_upload' =>1
                                ),'order_id ='.$id[$i]);
            }else{
                return $msg.CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误'.'<br>';
            }
        }
        $msg .= '交运完成';
        return $msg;
    }
    
    function completeBIRD()
    {
        if(CFG_ENABLE_BIRD == 1){
        $ch = curl_init();
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $headers = array ('api_key:'.CFG_BIRD_TOKEN);
        $shipping = $this->getExshipping('BIRD');
        $orders = $this->db->select("select order_id,order_sn FROM ".$this->tableName." where shipping_id in(".$shipping.") and order_status in (129,131) and is_upload = 1 order by order_id limit 100");
        if(count($orders) == 0) return '无需要更新订单';
        $msg = '';
        for($i=0;$i<count($orders);$i++){
            $url = CFG_BIRD_URL.'/consignment/?status=FINISHED&sales_reference='.CFG_ORDER_PREFIX.$orders[$i]['order_sn'];//
            curl_setopt ($ch, CURLOPT_URL, $url);
            curl_setopt ($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT,10);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $img = curl_exec($ch);
            $result = $json->decode($img);
            $status = $result->success;
            if(!$status){
                $msg .= CFG_ORDER_PREFIX.$orders[$i].'获取信息失败<br>';
            }elseif($status == true){
                if($result->total == 0){
                    $msg .= CFG_ORDER_PREFIX.$orders[$i].'未找到可获取单号数据<br>';
                }elseif($result->total == 1) {
                    $info = $result->data[0];
                $this->db->update($this->tableName,array(
                                'track_no' => $info->delivery_reference,
                                'shipping_cost' => $info->total_delivery_fee+$info->total_handling_fee,
                                'weight' => $info->total_weight,
                                'is_upload' =>2
                                ),'order_id ='.$orders[$i]['order_id']);
                }else{
                    $msg .= CFG_ORDER_PREFIX.$orders[$i]['order_sn'].'存在多条返回数据<br>';
                }
            }else{
                return $msg.CFG_ORDER_PREFIX.$orders[$i]['order_sn'].'未知错误'.'<br>';
            }
            
            }
            return $msg;
        }else{
            return '英仓接口未启用，请在系统设置中启用';    
        }
    }
    
    /*******
    ***三态订单提交
    ********/
    function uploadsfc($info)
    {
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $ch = curl_init();
        $token = array( 
       'token' => CFG_SFC_TOKEN, 
       'appKey' => CFG_SFC_KEY, 
       'userId' => CFG_SFC_ID 
     );
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $modelgoods = new ModelGoods();
        $client=new SoapClient('http://www.sendfromchina.com/ishipsvc/web-service?wsdl'); 
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            $shipping = $this->exchangeSFCcode($order_info['shipping_id']);
            if($shipping == 'ERROR' || $shipping == NULL) {$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'运输方式命名非SFC指定<br>';continue;}
            $goods_info = $this->order_goods_info($id[$i]);
            $goodsitem = array();
             $total = 0;
             $value = 0;
                for($t=0;$t<count($goods_info);$t++){
                    $getgoods = $modelgoods->goods_info('',$goods_info[$t]['goods_sn']);
                    $dec_name = $getgoods['dec_name']?$getgoods['dec_name']:CFG_DEC_NAME;
                    $dec_name_cn = ($getgoods['dec_name_cn']<>'')?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                    $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                    $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                 $goodsitem[] = array( 
                     'detailDescription' => $dec_name,
                     'detailDescriptionCN' => $dec_name_cn,
                     'detailQuantity' => $goods_info[$t]['goods_qty'], 
                     'detailCustomLabel' => $goods_info[$t]['goods_sn'], 
                     'detailWorth' => $Declared_value);
                     $total +=  $goods_info[$t]['goods_qty'];
                     $value += $Declared_value*$goods_info[$t]['goods_qty'];
                }
            if($value>$CFG_DECLARED_MAX){
                $value = $CFG_DECLARED_MAX;
                for($p=0;$p<count($goodsitem);$p++){
                    $goodsitem[$p]['detailWorth'] = floor($CFG_DECLARED_MAX/$total);;
                }
            }
            $order = array( 
             'customerOrderNo' => $order_info['sellsrecord'],
             'shipperAddressType' => 1, 
             'shipperName' => $params2['Contact'],
             'shipperPhone' =>  $params2['Phone'],
             'shipperEmail' => $params2['Email'], 
             'shipperAddress' => $params2['Street'].' '.$params1['District'].' '.$params1['City'].' '.$params1['Province'], 
               'shipperZipCode' => $params2['Postcode'], 
                'shippingMethod' => $shipping,         //三态提供运输方式 
               'recipientCountry' => $order_info['country'],    //三态提供的国家英文名称 
               'recipientName' => $order_info['consignee'],
               'recipientCity' => $order_info['city'],
               'recipientState' => $order_info['state'],
               'recipientAddress' => $order_info['street1'].' '.$order_info['street2'], 
               'recipientZipCode' => $order_info['zipcode'], 
               'recipientPhone' => $order_info['tel'], 
               'recipientEmail' => 'aa@aa.com', 
               'goodsDescription' => CFG_DEC_NAME,
               'orderStatus' => 'confirmed',
               'goodsQuantity' => $total, 
               'goodsDeclareWorth' => ($value>$CFG_DECLARED_MAX)?$CFG_DECLARED_MAX:$value,
               'goodsDetails' => $goodsitem);
            $parameter = array('HeaderRequest' =>$token,'addOrderRequestInfo' =>$order);
            $result=$client->addOrder($parameter);
            $status = $result->orderActionStatus;
            if($status == 'N'){
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败:'.$result->exceptionCode;
            }elseif($status == 'Y'){
                $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'track_no' => $result->orderCode
                                ),'order_id ='.$id[$i]);
            }else{
                return $msg.CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误'.'<br>';
            }
        }
        $msg .= '交运完成';
        return $msg;
    }
    /***
    *预报或取消出口易订单
    *CFG_CKE_TOKEN;    token   '887E99B5F89BB18BEA12B204B620D236'
    *CFG_CKE_KEY;      UserKey 'wr5qjqh4gj'
    */
    function uploadck1($info){
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $modelgoods = new ModelGoods();
        
        /***出口易测试账号 开始 取消注释开启***/
        //$client=new SoapClient("http://demo.chukou1.cn/client/ws/v2.1/ck1.asmx?WSDL");
        /***出口易测试账号 结束***/
        
        
        /***出口易正式环境 开始  取消注释开启***/
        $client = new SoapClient("http://yewu.chukou1.cn/client/ws/v2.1/ck1.asmx?WSDL");
        /***出口易正式环境 结束***/
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            $shipping = $this->exchangeCk1Code($order_info['shipping_id']);
            if($shipping == 'ERROR' || $shipping == NULL) {
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'物流方式命名非出口易指定，请到环境设置修改物流方式名称为出口易渠道的实际名称。<br>';continue;
            }
            $IsTracking=true;
            if($shipping == 'HBM'){
                $shipping == 'HKP';$IsTracking=false;
                }
            $goods_info = $this->order_goods_info($id[$i]);
            //产品信息集合
            $productList=array();
            $totalweight = 0;$total=0;$value=0;
            for($t=0;$t<count($goods_info);$t++){
                $getgoods = $modelgoods->goods_info('',$goods_info[$t]['goods_sn']);
                $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                $dec_name_cn = ($getgoods['dec_name_cn']<>'')?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                $dec_name = ($getgoods['dec_name']<>'')?$getgoods['dec_name']:CFG_DEC_NAME;
                $weight= $getgoods['weight']?$getgoods['weight']:CFG_DECLARED_WEIGHT*1000;
                $totalweight += $weight;
                $total +=  $goods_info[$t]['goods_qty'];
                $value += $declared_value*$goods_info[$t]['goods_qty'];
                $quantity=$goods_info[$t]['goods_qty'];
                /****2014 - 06 - 04  nic  修复提交最大报关价值****/
                
                if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                    if($Declared_value > CFG_DECLARED_MAX){
                       $Declared_value = CFG_DECLARED_MAX; 
                    }
                }
                $sku = $getgoods['goods_sn']=='' ? $goods_info[$t]['goods_sn'] : $getgoods['goods_sn']; 
                $productList[]=array(
                        'SKU' => $sku
                        ,'DeclareValue'=>$Declared_value
                        ,'Weight'=>$weight
                        ,'Quantity'=>$quantity
                        ,'CustomsTitleCN'=>$dec_name_cn
                        ,'CustomsTitleEN'=>$dec_name);
            }
            if($value>$CFG_DECLARED_MAX){
                for($t=0;$t<count($productList);$i++){
                    $productList[$t]['DeclareValue'] = floor($CFG_DECLARED_MAX/$total);;
                }
            }
            $shipToAddress= array(
                'City' => $order_info['city'],
                'Contact' => $order_info['consignee'],
                'Country' => $order_info['country'],
                'Email' => 'aa@aa.com',
                'Phone' =>  $order_info['tel'],
                'PostCode' =>$order_info['zipcode'],
                'Province' => $order_info['state'],
                'Street1' => $order_info['street1'],
                'Street2' => $order_info['street2']);
             $PickUpAddress = array(
            'City' => $params4['City'],
            'Contact' => $params4['Contact'],
            'Province' => $params4['Province'],
            'District' => $params4['District'],
            'Street1' => $params4['Street'],
            'Street2' => '',
            'Country' => $params4['Country'],
            'PostCode' => $params4['Postcode'],
            'Phone' => $params4['Mobile'],
            'Email' => $params4['Email'],
            'Company' => $params4['Company'],
            );
            $packing=array('Length' => '24','Width' => '16','Height' => '1');
            $packageDetail=array('Custom'=>CFG_ORDER_PREFIX.$order_info['order_sn'],'Packing'=>$packing,'ProductList'=>$productList,'Remark'=>CFG_ORDER_PREFIX.$order_info['order_sn'],'Weight' => $totalweight,'Status' => 'Initial','ShipToAddress'=>$shipToAddress);
            $order = array('Token' => CFG_CK1_TOKEN,'UserKey' => CFG_CK1_KEY,'PickUpAddress'=>$PickUpAddress,'ExpressType' =>$shipping,'IsTracking' =>$IsTracking,'PickupType' => 0,'PackageDetail' => $packageDetail);
            try {
                $result=$client->ExpressAddPackage(array('request' => $order));
                    if($result->ExpressAddPackageResult->Ack== 'Success'){
                        
                        /*****提审订单*****/  
                        $submitrequest = array(
                            'request' => array(
                                'Token' => CFG_CK1_TOKEN,
                                'UserKey' => CFG_CK1_KEY,
                                'ActionType' => 'Submit',       // 操作类型: 提审Submit 或者 删除Cancel
                                'OrderSign' => $result->ExpressAddPackageResult->OrderSign // 订单号
                            )
                        );
                        $submitresult = $client->ExpressCompleteOrder($submitrequest);
                    try {
                        if($submitresult->ExpressCompleteOrderResult->Ack== 'Success'){  /**预报成功**/
                             /*****更新追踪单号*****/
                            $trackingrequest = array(
                                'request' => array(
                                    'Token' => CFG_CK1_TOKEN,
                                    'UserKey' => CFG_CK1_KEY,
                                    'Custom' => CFG_ORDER_PREFIX.$order_info['order_sn']
                                )
                            );
                            $trackingresult = $client->ExpressGetPackage($trackingrequest); 
                            
                            if($trackingresult->ExpressGetPackageResult->Ack== 'Success'){
                                
                                 /**获取单号成功**/
                                  $trackno = $trackingresult->ExpressGetPackageResult->PackageDetail->TrackCode;
                                
                                  if($trackno <> ''){
                                      @$this->db->update($this->tableName,array( 
                                        'track_no' => $trackno,
                                        'track_no_2' => $result->ExpressAddPackageResult->OrderSign,
                                     ),'order_id ='.$id[$i]);
                                  }
                            }  
                            $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交成功<br/>';
                           
                        }else{
                            //$msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败:'.$result->ExpressCompleteOrderResult->Message;
                        }
                    } catch (Exception $e) {
                        //接口异常
                        $msg .=$e->getMessage();
                    }  
                }else{
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败:'.$result->ExpressAddPackageResult->Message.'<br/>';
                }
            } catch (Exception $e) {
                //接口异常
                $msg .=$e->getMessage();
            }  
        }
        $msg .= '交运完成';
        return $msg;
    }
    /***
    *预报或取消出口易订单
    *CFG_CKE_TOKEN;    token   '887E99B5F89BB18BEA12B204B620D236'
    *CFG_CKE_KEY;      UserKey 'wr5qjqh4gj'
    * 
    * 
    * info =   id    track_no
    */
    function getck1_printlabel($info){   
        try {
            $ids = $info['id'];
            $id = explode(',',$ids);
            $msg = '';
            $modelgoods = new ModelGoods();
           
            $track_str = '';
            for($i=0;$i<count($id);$i++){
                $order_info = $this->order_info($id[$i]);
                if($order_info['track_no']<>'' && $order_info['track_no_2']<>''){
                     $track_str .= $track_str=='' ? 'track_no='.$order_info['track_no'] : '&track_no='.$order_info['track_no'];
                }
            }
             /***出口易测试账号 开始 取消注释开启***/
            //$url = "http://demo.chukou1.cn/v3/direct-express/package/print-label?token=887E99B5F89BB18BEA12B204B620D236&user_key=wr5qjqh4gj&".$track_str."&format=classic_a4&content=Address";
            /***出口易测试账号 结束***/
           
           
           
            /*标签类型*/ $label_type = CFG_CK1_A4LABEL ? 'classic_a4' : 'classic_label';
            $label_content = 'address';
            if($label_type == 'classic_a4' && CFG_CK1_LABELDEC)$label_content = 'address_costoms';  
            if($label_type == 'classic_label' && CFG_CK1_LABELDEC)$label_content = 'address_costoms_split'; 
            $url = "http://api.chukou1.cn/v3/direct-express/package/print-label?token=".CFG_CK1_TOKEN."&user_key=".CFG_CK1_KEY."&".$track_str."&format=".$label_type."&content=".$label_content;
            $ch = curl_init();              
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串         
            curl_setopt($ch, CURLOPT_URL,$url); 
            $result=curl_exec($ch); 
            $arr_result = json_decode($result,true);
            curl_close($ch);
            if(isset($arr_result['meta']['description'])){
                $msg .= $arr_result['meta']['description'];
            }else{
                $dirname = CFG_PATH_DATA.'upload/';   
                $file = $dirname.$_SESSION['admin_name'].'.pdf';
                $file = str_replace(CFG_PATH_ROOT, '', $file);
                $fp = fopen($file, 'w');
                fputs($fp, $result);
                fclose($fp);
                return CFG_URL.$file; 
            }
        } catch (Exception $e) {
            //接口异常
            $msg .=$e->getMessage();
        }
        return $msg;
    }
    /**
    *在使用时发现以下有些货运方式不能使用 邮政大包可以使用
    */
    function exchangeCk1Code($express)
    {
        $shipping = ModelDd::getCaption('shipping',$express);
        switch($shipping)
        {
            case '香港小包平邮' : return 'HBM';
            case '美国经济专线' : return 'UEE';
            case '香港小包挂号' : return 'HTM';
            case '香港小包': return 'HKP';//通过IsTracking区别是平邮还是挂号
            case '中邮小包挂号': return 'CRI';
            case '省外中邮挂号': return 'CRN';
            case 'E邮宝': return 'EUB';
            case '新加坡小包挂号': return 'SGP';
            case '新加坡小包平邮': return 'SGO';
            case '大陆DHL': return 'CND';
            case '邮政大包': return 'CAP';
            case '国际EMS': return 'EMS';
            case '香港DHL': return 'DHL';
            case '香港UPS': return 'UPS';
            case '上海DHL': return 'SHD';
            case '省外EMS': return 'EMP';
            case '香港EMS': return 'HKE';
            case '省内EMS': return 'EMI';
            case '中东专线': return 'MEP';
            case '东南亚专线': return 'SAP';
            case '中英专线': return 'CEE';
            case '欧陆通': return 'CTU';
            case '中澳专线': return 'CAU';
            case '中美专线': return 'CUE';
            case '荷兰小包挂号': return 'NLR';
            case '英国快线': return 'CEF';
            case '中邮小包平邮': return 'CNI';
            case '本地中邮挂号' : return 'CRI';
            case '英国快线' : return 'CEF';
            case '英国专线挂号' : return 'CET';
            default:return NULL;
        }
    }
    /********
    *SFC运输代码转换
    *input  $express系统内部exprssid
    ********/
    function exchangeSFCcode($express)
    {
        $shipping = ModelDd::getCaption('shipping',$express);
        switch($shipping)
        {
            case '比利时邮政小包（平邮）':
            return 'BPAM';
            //case '中国小包挂号':
            //return 'DEAM2';
            case '中国DHL':
            return 'CNDHL';
            case '中国FedEx优先型':
            return 'CNFEDEX';
            case '中国FedEx经济型':
            return 'CNSFEDEX';
            case '中国UPS':
            return 'CNUPS';
            case '德国邮政小包（平邮)':
            return 'DEAM';
            case '德国邮政小包（挂号）':
            return 'DERAM';
            case 'Express International Shipping':
            return 'EIS';
            case 'SFC-e邮宝':
            return 'EPACKET';
            case '三态中欧专线':
            return 'EUEXP';
            case '香港邮政小包(平邮)':
            return 'HKBAM';
            case '香港邮政小包(挂号)':
            return 'HKBRAM';
            case '香港DHL':
            return 'HKDHL';
            case '香港EMS':
            return 'HKEMS';
            case '香港UPS':
            return 'HKUPS';
            case '三态中东专线':
            return 'MEEXP';
            case '英国邮政小包(平邮)':
            return 'RM1';
            case '英国邮政小包(挂号)':
            return 'RM1R';
            case '新加坡邮政小包(平邮)':
            return 'SGAM';
            case '新加坡邮政小包(挂号)':
            return 'SGRAM';
            case '瑞士邮政小包（平邮）':
            return 'SWBAM';
            case '瑞士邮政小包（挂号）':
            return 'SWBRAM';
            case '中国邮政小包挂号）':
            return 'CNRMA';
            case '中国EMS':
            return 'SZEMS';
            case '台湾DHL':
            return 'TWDHL';
            case '英国仓储':
            return 'USPS3DR';
            case '三态中美专线':
            return 'USPS3DR';
            default:
            return NULL;
        }
    }


    
    /******
    *获取线下E邮宝追踪单号
    ******/
    function getEUBtrack1($info)
    {
        set_time_limit(300);
        $modelgoods = new ModelGoods();
        $hoo = '';
        $printcode = (CFG_EUB1_A4LABEL) ? '00' : '01';
        if($info['type'] == 1){
            $wheres ='';
            $status = $this->getorderflow(3,2);
            $wheres .= 'order_status in ('.$status.')';
            $shipping_ex = $this->getExshipping('EUB-1');
            $wheres .= ' and shipping_id=\''.$shipping_ex.'\'';
            $accountlist = ($_SESSION['account_list'] == '')?0:$_SESSION['account_list'];
            if($_SESSION['account_list'] != 'all') $wheres .= ' and Sales_account_id in ('.$accountlist.')';
            $wheres .= ' and (track_no ="" or track_no is null)';
            $id = $this->db->select("SELECT order_id FROM ".$this->tableName." WHERE ".$wheres);
        }else{
            $ids = $info['id'];
            $id = explode(',',$ids);
        }
        $msg = '';
        $url = 'http://www.ems.com.cn:80/partner/api/public/p/order/';
        $modelgoods = new ModelGoods();
        
        
        
        ///地主贸易地址       临时设置代码
        
        if($_SESSION['company'] == 'dzmy'){
            
            require_once(CFG_PATH_DATA . 'ebay/eub_address_dg.php');
        }else{
            require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        }                                   
                                                               
        
        
        
        
        
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> '') continue;
            if(strtoupper($order_info['country']) == 'CANADA'){
                $order_info['country'] = 'CANADA';
                $order_info['zipcode'] = strtoupper($order_info['zipcode']);
            }else if(strtoupper($order_info['country']) == 'AUSTRALIA'){
                $order_info['country'] = 'AUSTRALIA';
            }else if(strtoupper($order_info['country']) == 'UNITED KINGDOM'){
                $order_info['country'] = 'UNITED KINGDOM';
            }else if(strtoupper($order_info['country']) == 'FRANCE'){
                $order_info['country'] = 'FRANCE';
            }else if(strtoupper($order_info['country']) == 'UNITED STATES'){
                $order_info['country'] = 'UNITED STATES OF AMERICA';
            }else if(strtoupper($order_info['country']) == 'US'){
                $order_info['country'] = 'UNITED STATES OF AMERICA';
            }else if(strtoupper($order_info['country']) == 'RUSSIAN FEDERATION'){
                $order_info['country'] = 'RUSSIA';
            }else{
                $msg .= '单号:'.CFG_ORDER_PREFIX.$order_info['order_sn'].'不支持国家为'.$order_info['country'].'的订单<br>';
                continue;
            }
            
            $xml = '<?xml version="1.0" encoding="UTF-8"?> 
                    <orders xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> 
                <order> 
                    <orderid>'.CFG_ORDER_PREFIX.$order_info['order_sn'].'</orderid>
                    <clcttype>1</clcttype> 
                    <pod>false</pod> 
                    <untread>Abandoned</untread> 
                    <startdate>'.date('Y-m-d\TH:i:s').'</startdate> 
                    <printcode>'.$printcode.'</printcode> 
                    <sender> 
                      <name>'.$params2['Contact'].'</name> 
                      <postcode>'.$params2['Postcode'].'</postcode> 
                      <phone>'.$params2['Phone'].'</phone> 
                      <mobile>'.$params2['Mobile'].'</mobile> 
                      <country>CN</country> 
                      <province>'.$params1['Province'].'</province> 
                      <city>'.$params1['City'].'</city> 
                      <county>'.$params1['District'].'</county> 
                      <company>'.$params2['Company'].'</company> 
                      <street>'.$params2['Street'].'</street> 
                      <email>'.$params2['Email'].'</email> 
                    </sender> 
                    <receiver> 
                      <name>'.$order_info['consignee'].'</name> 
                      <postcode>'.$order_info['zipcode'].'</postcode> 
                      <phone>'.(($order_info['tel']=="Invalid Request")?"":$order_info['tel']).'</phone> 
                      <country>'.$order_info['country'].'</country> 
                      <province>'.$order_info['state'].'</province> 
                      <city>'.$order_info['city'].'</city> 
                      <street>'.$order_info['street1'].' '.$order_info['street2'].'</street> 
                    </receiver> 
                    <collect> 
                      <name>'.$params1['Contact'].'</name> 
                      <postcode>'.$params1['Postcode'].'</postcode> 
                      <phone>'.$params1['Phone'].'</phone> 
                      <mobile>'.$params1['Mobile'].'</mobile> 
                      <country>CN</country> 
                      <province>'.$params1['Province'].'</province> 
                      <city>'.$params1['City'].'</city> 
                      <county>'.$params1['District'].'</county> 
                      <company/> 
                      <street>'.$params1['Street'].'</street> 
                      <email>'.$params1['Email'].'</email> 
                    </collect><items>';
                        $ItemList = array();
                        $total_qty = 0;
                        $goods_info = $this->order_goods_info($id[$i]);
                        $EBayTransactionID = ($goods_info[0]['TransactionID']==0) ? CFG_TIME.mt_rand(10,99) : $goods_info[0]['TransactionID'];
                        //return var_dump($goods_info[0]);
        foreach($goods_info as $key => $goodsvalue){
            if(CFG_IMPORT_CUSTOMS){
                //多个产品    
                //优先使用导入产品信息
                $goods_name = $goodsvalue['goods_name'];
                if($goodsvalue['goods_qty'] > 1) $goods_name .= '&'.$goodsvalue['goods_qty'];
                $item_no = $goodsvalue['item_no'];
                $item_sn = $goodsvalue['goods_sn'];
                $goods_price = $goodsvalue['goods_price'];
                $total_qty = $goodsvalue['goods_qty'];
                $dec_name = ($goods_name <> '') ? $goods_name : CFG_DEC_NAME;
                $Declared_weight = ($goodsvalue['goods_weigth'] <> 0) ? $goodsvalue['goods_weigth']*$total_qty : CFG_DECLARED_WEIGHT;
                $Declared_value = ($goods_price <> 0) ? $goods_price : CFG_DECLARED_VALUE;
                $xml .= '<item><cnname>'.CFG_DEC_NAME_CN.'</cnname>
                <enname><![CDATA['.$dec_name.']]></enname> 
                <count>'.$total_qty.'</count> 
                <unit>unit</unit> 
                <weight>'.$Declared_weight.'</weight> 
                <delcarevalue>'.$Declared_value*$total_qty.'</delcarevalue> 
                <origin>CN</origin></item>';
            }else{
                //不优先使用导入产品信息的
                //先查看产品库
                $getgoods = $modelgoods->goods_info('',$goodsvalue['goods_sn']);
                //有产品库的订单产品
                if(count($getgoods)>0){
                    $CustomsTitleEN = $getgoods['dec_name'];
                    $goods_name_cn = $getgoods['dec_name_cn'];
                    $item_no = $goodsvalue['item_no'];
                    $item_sn = $goodsvalue['goods_sn'];
                    $Declared_weight = $getgoods['Declared_weight'];
                    $Declared_value = $getgoods['Declared_value'];
                }else{
                    $CustomsTitleEN =  CFG_DEC_NAME .'  '.$goodsvalue['goods_sn'].'&'.$goodsvalue['goods_qty'];
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
                
                $xml .= '<item><cnname>'.$goods_name_cn.'</cnname>
                <enname><![CDATA['.substr($CustomsTitleEN,0,250).'  '.$goodsvalue['goods_sn'].' & '.$goodsvalue['goods_qty'].']]></enname> 
                <count>'.$goodsvalue['goods_qty'].'</count> 
                <unit>unit</unit> 
                <weight>'.$Declared_weight*$goodsvalue['goods_qty'].'</weight> 
                <delcarevalue>'.$Declared_value*$goodsvalue['goods_qty'].'</delcarevalue> 
                <origin>CN</origin></item>';
            }
        }
        
        
        
        $xml .= '</items><remark/></order></orders>';
        $headers = array ('version:international_eub_us_1.1','authenticate:'.CFG_EUB_TOKEN);
        $ch = curl_init();
        curl_setopt ($ch, CURLOPT_URL, $url);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
        curl_setopt ($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT,10);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS,$xml);
        $result = curl_exec($ch);
          $responseDoc = new DomDocument();
          $responseDoc->loadXML($result);
        $status = @$responseDoc->getElementsByTagName('status')->item(0)->nodeValue;
            if($status != 'error'){
                $this->db->update($this->tableName,array(
                    'track_no' => $responseDoc->getElementsByTagName('mailnum')->item(0)->nodeValue
                    ),'order_id ='.$id[$i]);
            }else{
                $msg .= '订单'.CFG_ORDER_PREFIX.$order_info['order_sn'].'获取追踪单号失败<br>';
                $msg .= $responseDoc->getElementsByTagName('description')->item(0)->nodeValue;
                $msg .='<br>';
            }
        }
            $msg .='获取追踪单号结束';
            return $msg;
    }
    /******
    *获取E邮宝追踪单号
    ******/
    function getEUBtrack($info)
    {
        set_time_limit(0);
        $modelgoods = new ModelGoods();
        $hoo = '';
        if($info['type'] == 1){
            $wheres ='';
            $status = $this->getorderflow(3,2);
            $wheres .= 'order_status in ('.$status.')';
            $shipping_ex = $this->getExshipping('EUB');
            $wheres .= ' and shipping_id=\''.$shipping_ex.'\'';
            $accountlist = ($_SESSION['account_list'] == '')?0:$_SESSION['account_list'];
            if($_SESSION['account_list'] != 'all') $wheres .= ' and Sales_account_id in ('.$accountlist.')';
            $wheres .= ' and (track_no ="" or track_no is null)';
            $id = $this->db->select("SELECT order_id FROM ".$this->tableName." WHERE ".$wheres);
        }elseif($info['type'] == 2){
            $wheres ='';
            $status = $this->getorderflow(13,2);
            $wheres .= 'order_status in ('.$status.')';
            $shipping_ex = $this->getExshipping('EUB');
            $wheres .= ' and shipping_id=\''.$shipping_ex.'\'';
            $accountlist = ($_SESSION['account_list'] == '')?0:$_SESSION['account_list'];
            if($_SESSION['account_list'] != 'all') $wheres .= ' and Sales_account_id in ('.$accountlist.')';
            $wheres .= ' and (track_no ="" or track_no is null)';
            $id = $this->db->select("SELECT order_id FROM ".$this->tableName." WHERE ".$wheres);
        }else{
            $ids = $info['id'];
            $id = explode(',',$ids);
        }
        $msg = '';
        $modelgoods = new ModelGoods();
        //https://api.apacshipping.ebay.com.hk/aspapi/v4/ApacShippingService
        $soapclient = new soapclient("http://shippingapi.ebay.cn/production/v3/orderservice.asmx?wsdl");//http://epacketws.pushauction.net/orderservice.asmx 
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if(preg_match('/,*'.$order_info['order_status'].',*/', $this->getorderflow(13,2))) $hoo = 'HOO ';
            $sellsrecord = $order_info['sellsrecord'];
            $params2['Contact'] = $contact_normal."(".ModelDd::getCaption('allaccount',$order_info['Sales_account_id']).")"; 
            $params3        = array(
                'Email' => $order_info['email'],
                'Company' => '',
                'Contact' => $order_info['consignee'],
                'Phone' => ($order_info['tel']=="Invalid Request")?"":$order_info['tel'],
                'Street' => $order_info['street1'].' '.$order_info['street2'],
                'City' => $order_info['city'],
                'Province' => $order_info['state'],
                'Postcode' => $order_info['zipcode'],  
                'Country' => $order_info['country'],  
                'CountryCode' => $order_info['CountryCode']
            );
            $goods_info = $this->order_goods_info($id[$i],0);
            $ItemList = array();
            if(count($goods_info)>2){
                $total_qty = 0;
                $CustomsTitleEN = CFG_DEC_NAME;
                    $EBayTransactionID = $goods_info[0]['TransactionID'];
                    $goods_name = $goods_info[0]['goods_name'];
                    $item_no = $goods_info[0]['item_no'];
                    $item_sn = $goods_info[0]['goods_sn'];
                    $goods_price = $goods_info[0]['goods_price'];
                for($t=0;$t<count($goods_info);$t++){
                    $total_qty += $goods_info[$t]['goods_qty'];
                    $CustomsTitleEN .= ','.$goods_info[$t]['goods_sn'];
                    if($goods_info[$t]['goods_qty'] > 1) $CustomsTitleEN .= '&'.$goods_info[$t]['goods_qty'];
                }
                $item = array(
                            'CurrencyCode' => $order_info['currency'],
                            'EBayEmail' => $order_info['email'],
                            'EBayBuyerID' => $order_info['userid'],
                            'EBayItemID' => $this->getEBAYITEMNO($item_no,$item_sn,$order_info['Sales_account_id']),
                            'EBayItemTitle' => $goods_name,
                            'EBayMessage' => "",
                            'EBaySiteID' => "0",
                            'EBayTransactionID' => $EBayTransactionID,  
                            'PaymentDate' => MyDate::transform('date',$order_info['paid_time']),
                            'PayPalEmail' => $order_info['email'],
                            'SoldDate' => MyDate::transform('date',$order_info['paid_time']),
                            'PayPalMessage' => "",
                            'PostedQTY' => $total_qty,
                            'SalesRecordNumber' => $order_info['sellsrecord'],
                            'ReceivedAmount' => 0,
                            'OrderSalesRecordNumber' =>'',
                            'SoldPrice' => $goods_price,
                            'SoldQTY' => $total_qty,
                            'Note'=>$hoo,
                            'SKU' => array(
                                    'SKUID' => 'SUMSKU',
                                    'Weight' => (CFG_DECLARED_WEIGHT*$total_qty>2)?2:(CFG_DECLARED_WEIGHT*$total_qty),
                                    'CustomsTitleCN' => CFG_DEC_NAME_CN,
                                    'CustomsTitleEN' => substr($CustomsTitleEN,0,250),
                                    'DeclaredValue' => (CFG_DECLARED_VALUE*$total_qty>$CFG_DECLARED_MAX)?$CFG_DECLARED_MAX:CFG_DECLARED_VALUE*$total_qty,
                                    'OriginCountryName' => "China",
                                    'OriginCountryCode' => "CN"    
                                )
                        );
                    $ItemList['Item'][] = $item;    
            }else{
                for($j=0;$j<count($goods_info);$j++){
                    $getgoods = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                    $dec_name = ($getgoods['dec_name']<>'')?$getgoods['dec_name']:CFG_DEC_NAME;
                    $dec_name_cn = ($getgoods['dec_name_cn']<>'')?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                    $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                    $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                    $Declared_weight = ($getgoods['Declared_weight']>0)?$getgoods['Declared_weight']:CFG_DECLARED_WEIGHT;
                    $item = array(
                            'CurrencyCode' => $order_info['currency'],
                            'EBayEmail' => $order_info['email'],
                            'EBayBuyerID' => $order_info['userid'],
                            'EBayItemID' => $this->getEBAYITEMNO($goods_info[$j]['item_no'],$goods_info[$j]['goods_sn'],$order_info['Sales_account_id']),
                            'EBayItemTitle' => $goods_info[$j]['goods_name'],
                            'EBayMessage' => "",
                            'EBaySiteID' => "0",
                            'EBayTransactionID' => $goods_info[$j]['TransactionID'],  
                            'PaymentDate' => MyDate::transform('date',$order_info['paid_time']),
                            'PayPalEmail' => $order_info['email'],
                            'PayPalMessage' => "",
                            'PostedQTY' => $goods_info[$j]['goods_qty'],
                            'SalesRecordNumber' => $order_info['sellsrecord'],
                            'ReceivedAmount' => 0,
                            'Note'=>$hoo,
                            'OrderSalesRecordNumber' =>'',
                            'SoldDate' => MyDate::transform('date',$order_info['paid_time']),
                            'SoldPrice' => $goods_info[$j]['goods_price'],
                            'SoldQTY' => $goods_info[$j]['goods_qty'],
                            'SKU' => array(
                                    'SKUID' => $goods_info[$j]['goods_sn'],
                                    'Weight' => $Declared_weight*$goods_info[$j]['goods_qty'],
                                    'CustomsTitleCN' => $dec_name_cn,
                                    'CustomsTitleEN' => $dec_name.' '.$goods_info[$j]['goods_sn'].'&'.$goods_info[$j]['goods_qty'],
                                    'DeclaredValue' => ($Declared_value*$goods_info[$j]['goods_qty']>$CFG_DECLARED_MAX)?$CFG_DECLARED_MAX:($Declared_value*$goods_info[$j]['goods_qty']),
                                    'OriginCountryName' => "China",
                                    'OriginCountryCode' => "CN"    
                                )
                        );
                    $ItemList['Item'][] = $item;
                    }
            }
        require(CFG_PATH_DATA . 'ebay/eub_' . $order_info['Sales_account_id'] .'.php');
        $params = array("Version"=>"3.0.0",
                        "APIDevUserID" => $APIDevUserID, 
                        "APIPassword" => $APIPassword, 
                        "APISellerUserID"=>$APISellerUserID,
                        "OrderDetail" => array(
                            "EMSPickUpType"=>1,
                            "PickUpAddress"=>$params1,
                            "ShipFromAddress"=>$params2,
                            "ShipToAddress"=>$params3,
                            "ReturnAddress"=>$params4,
                            "ItemList" =>$ItemList
                            )
                        );
            $pas = array("AddAPACShippingPackageRequest"=>$params);
            $result = $soapclient->AddAPACShippingPackage($pas);
            if($result->AddAPACShippingPackageResult->Ack == 'Success'){
                $this->db->update($this->tableName,array(
                    'track_no' => $result->AddAPACShippingPackageResult->TrackCode
                    ),'order_id ='.$id[$i]);
            }else{
                $msg .= '订单'.CFG_ORDER_PREFIX.$order_info['order_sn'].'获取追踪单号失败<br>';
                $msg .= $result->AddAPACShippingPackageResult->Message;
                $msg .='<br>';
            }
        }
            $msg .='获取追踪单号结束';
            return $msg;
    }
    /************
    ****转换AmazonItemNO
    ************/
    function getEBAYITEMNO($no,$sn,$account)
    {
        if(!is_numeric($no) || strlen($no) > 12){
            $no = $this->db->getValue("SELECT n.item_no FROM ".$this->infotableName." as n left join ".$this->tableName." as m on m.order_id = n.order_id where m.Sales_account_id ='".$account."' and n.goods_sn='".$sn."' and n.item_no REGEXP '^[0-9]*$' and LENGTH(n.item_no) = 12 order by rec_id desc");
            if(!$no) $no = $this->db->getValue("SELECT n.item_no FROM ".$this->infotableName." as n left join ".$this->tableName." as m on m.order_id = n.order_id where m.Sales_account_id ='".$account."'  and n.item_no REGEXP '^[0-9]*$' and LENGTH(n.item_no) = 12 order by rec_id desc");
            if(!$no) $no = CFG_TIME.mt_rand(10,99);
        }
        return $no;
    }
    
    /*******************
    ***
    *获取E邮宝打印pdf文件
    ***
    *******************/
    function getEUBpdf($info)
    {
        set_time_limit(0);
        $ids = $info['id'];
        $id = explode(',',$ids);
        if(count($id)>80){
                throw new Exception('每次获取pdf不允许超过10个订单','350');exit();
            }
        $msg = '';$file = '';
        $soapclient = new soapclient("http://shippingapi.ebay.cn/production/v3/orderservice.asmx?wsdl");
        $TrackCodeList = array();
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> ''){
                $TrackCodeList['TrackCode'][] =     $order_info['track_no'];            
                }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'追踪单号为空';        
            }
        }
        if(count($TrackCodeList['TrackCode']) >0){
            require_once(CFG_PATH_DATA . 'ebay/eub_' . $order_info['Sales_account_id'] .'.php');
            $params = array("Version"=>"3.0.0",
                            "APIDevUserID" => $APIDevUserID, 
                            "APIPassword" => $APIPassword, 
                            "APISellerUserID"=>$APISellerUserID,
                            "PageSize" => $info['type'],
                            "TrackCodeList" =>$TrackCodeList
                            );
            $pas = array("GetAPACShippingLabelRequest"=>$params);
            $result = $soapclient->GetAPACShippingLabels($pas);
            $dirname = CFG_PATH_DATA.'upload/'.date('ymd').'/';
            if(!is_dir($dirname)) mkdir($dirname);
                if($result->GetAPACShippingLabelsResult->Ack == 'Success'){
                    $file = $dirname.time().'.pdf';
                    $file = str_replace(CFG_PATH_ROOT, '', $file);
                    $fp = fopen($file, 'w');
                    fputs($fp, $result->GetAPACShippingLabelsResult->Label);
                    fclose($fp);
                    $this->db->update($this->tableName,array(
                        'eubpdf' => $file,
                        'print_status' =>1
                        ),'order_id in ('.$ids.')');
                    $msg .= '获取pdf完成';
                }else{
                    $msg .= '获取pdf失败<br>';
                    $msg .= $result->GetAPACShippingLabelsResult->Message;
                    $msg .='<br>';
                }
            }
            if($file <> '') $file = CFG_URL.$file;
            return  $msg.'|'.$file;
    }
    
    /*******************
    ***
    *获取线下E邮宝打印pdf文件
    ***
    *******************/
    function getEUBzip($info)
    {
        set_time_limit(0);
        $ids = $info['id'];
        $id = explode(',',$ids);
        $url = 'http://www.ems.com.cn:80/partner/api/public/p/print/batch';
        $msg = '';$file = '';
        $xml = '<?xml version="1.0" encoding="UTF-8"?> 
                    <orders xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> ''){
                $xml .= '<order><mailnum>'.$order_info['track_no'].'</mailnum></order>';
                }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'追踪单号为空';        
            }
        }
        $xml .= '</orders>';
        if($msg == ''){
                $headers = array ('version:international_eub_us_1.1','authenticate:'.CFG_EUB_TOKEN);
                $ch = curl_init();
                curl_setopt ($ch, CURLOPT_URL, $url);
                curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
                curl_setopt ($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT,10);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS,$xml);
                $result = curl_exec($ch);
                $responseDoc = new DomDocument();
                $responseDoc->loadXML($result);
                $status = @$responseDoc->getElementsByTagName('status')->item(0)->nodeValue;
                if($status == 'success'){
                    /*$dirname = CFG_PATH_DATA.'upload/'.date('ymd').'/';
                    if(!is_dir($dirname)) mkdir($dirname);
                    $file = $dirname.time().'.zip';
                    $file = str_replace(CFG_PATH_ROOT, '', $file);
                    $fp = fopen($file, 'w');
                    fputs($fp, file_get_contents($responseDoc->getElementsByTagName('description')->item(0)->nodeValue));
                    fclose($fp);*/
                    $this->db->update($this->tableName,array(
                        'eubpdf' => $responseDoc->getElementsByTagName('description')->item(0)->nodeValue,
                        'print_status' =>1
                        ),'order_id in ('.$ids.')');
                    $msg .= '获取打印文件完成';
                }else{
                    $msg .= '获取打印文件失败<br>';
                    $msg .= $responseDoc->getElementsByTagName('description')->item(0)->nodeValue;
                    $msg .='<br>';
                }
            }
            if($file <> '') $file = CFG_URL.$file;
            return  $msg.'|'.$file;
    }
    
    /*******************
    ***
    *E邮宝交运
    ***
    *******************/
    function updateEUB($info)
    {
        set_time_limit(0);
        if($info['type'] == 1){
            $wheres ='';
            $status = $this->getorderflow(3,2);
            $wheres .= 'order_status in ('.$status.')';
            $shipping_ex = $this->getExshipping('EUB');
            $wheres .= ' and shipping_id=\''.$shipping_ex.'\'';
            $accountlist = ($_SESSION['account_list'] == '')?0:$_SESSION['account_list'];
            if($_SESSION['account_list'] != 'all') $wheres .= ' and Sales_account_id in ('.$accountlist.')';
            $wheres .= ' and track_no <>""';
            $id = $this->db->select("SELECT order_id FROM ".$this->tableName." WHERE ".$wheres);
            }else{
            $ids = $info['id'];
            $id = explode(',',$ids);
        }
        $msg = '';
        $soapclient = new soapclient("http://shippingapi.ebay.cn/production/v3/orderservice.asmx?wsdl");
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> ''){
                require_once(CFG_PATH_DATA . 'ebay/eub_' . $order_info['Sales_account_id'] .'.php');
                $params = array("Version"=>"3.0.0",
                                "APIDevUserID" => $APIDevUserID, 
                                "APIPassword" => $APIPassword,
                                "APISellerUserID"=>$APISellerUserID,
                                "TrackCode" =>$order_info['track_no']
                                );
                        $pas = array("ConfirmAPACShippingPackageRequest"=>$params);
                        $result = $soapclient->ConfirmAPACShippingPackage($pas);
                            $status = $this->db->getValue("select m.next_id from ".$this->statustableName." as m left join ".$this->tableName." as n on m.id = n.order_status where n.order_id=".intval($id[$i]));
                        if($result->ConfirmAPACShippingPackageResult->Ack == 'Success'){
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'is_mark' => (CFG_EUB_MARK == 1)?0:1,
                                'mark_with_no' => (CFG_EUB_MARK == 1)?0:1
                                ),'order_id ='.$id[$i]);
                        }else{
                            $msg .= '订单'.CFG_ORDER_PREFIX.$order_info['order_sn'].'提交E邮宝失败<br>';
                            $msg .= $result->ConfirmAPACShippingPackageResult->Message;
                            if(preg_match('/confirmed/i',$result->ConfirmAPACShippingPackageResult->Message))
                            {
                            $this->db->update($this->tableName,array(
                                'order_status' => $status,
                                'is_mark' => (CFG_EUB_MARK == 1)?0:1,
                                'mark_with_no' => (CFG_EUB_MARK == 1)?0:1
                                ),'order_id ='.$id[$i]);
                            }
                            $msg .='<br>';
                        }
                        $this->save_order_log($id[$i],'更改状态','订单状态被更改为'.$status);
                }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'追踪单号为空<br>';        
            }
        }
        $msg .= '交运完成';
        return  $msg;
    }
    /*******************
    ***
    *E邮宝取消包裹
    ***
    *******************/
    function cancelEUB($info)
    {
        set_time_limit(0);
            $ids = $info['id'];
            $id = explode(',',$ids);
        $msg = '';
        $soapclient = new soapclient("http://shippingapi.ebay.cn/production/v3/orderservice.asmx?wsdl");
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> ''){
                require_once(CFG_PATH_DATA . 'ebay/eub_' . $order_info['Sales_account_id'] .'.php');
                $params = array("Version"=>"3.0.0",
                                "APIDevUserID" => $APIDevUserID, 
                                "APIPassword" => $APIPassword,
                                "APISellerUserID"=>$APISellerUserID,
                                "TrackCode" =>$order_info['track_no']
                                );
                        $pas = array("CancelAPACShippingPackageRequest"=>$params);
                        $result = $soapclient->CancelAPACShippingPackage($pas);
                        if($result->CancelAPACShippingPackageResult->Ack == 'Success'){
                            $this->db->update($this->tableName,array(
                                'track_no' => '',
                                'is_mark' =>0,
                                'mark_with_no'=>0
                                ),'order_id ='.$id[$i]);
                        }else{
                            $msg .= '订单'.CFG_ORDER_PREFIX.$order_info['order_sn'].'取消包裹失败<br>';
                            $msg .= $result->CancelAPACShippingPackageResult->Message;
                            $msg .='<br>';
                        }
                }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'追踪单号为空<br>';        
            }
        }
        $msg .= '取消包裹完成';
        return  $msg;
    }
    /***************
    ***USPS接口
    ***
    ***************/
    function getUSPS($info)
    {
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $dirname = CFG_PATH_DATA.'upload/'.date('ymd').'/';
        if(!is_dir($dirname)) mkdir($dirname,0777);
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        require_once(CFG_PATH_LIB.'util/xmlhandle.php');
        $modelgoods = new ModelGoods();
        for($i=0;$i<count($id);$i++){
            $first = '';
            $order_info = $this->order_info($id[$i]);
            $goods_info = $this->order_goods_info($id[$i]);
            $goodstr ='';
            $totalweight = 0;
            for($j=0;$j<count($goods_info);$j++){
                $gooditem = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                //$totalweight += $gooditem['weight']*$goods_info[$j]['goods_qty'];
                $totalweight += $this->db->getValue("select goods_weigth from myr_order_goods where goods_sn = '".$goods_info[$j]['goods_sn']."'");
                $goodstr .= '  '.$goods_info[$j]['goods_sn'];
                if($goods_info[$j]['goods_qty'] > 1) $goodstr .= '&'.$goods_info[$j]['goods_qty'];
            }
            //转安士
            //first 最大是13安士
            $totalweight = round(($totalweight*1000)/28);
            if(strlen($goodstr) > 65) $goodstr = '************';
            //$shiping = array( 9 => 'FIRST');
            $request = "
            <LabelRequest LabelType=\"Default\" LabelSize=\"4X6\" ImageFormat=\"JPEG\">
            <RequesterID>abcd</RequesterID>
            <AccountID>844537</AccountID>
            <PassPhrase>iclover99</PassPhrase>
            <MailClass>FIRST</MailClass>
            <DateAdvance>0</DateAdvance>
            <WeightOz>".$totalweight."</WeightOz>
            <Stealth>FALSE</Stealth>
            <Services InsuredMail=\"OFF\" SignatureConfirmation=\"OFF\" />
            <Value>0</Value>
            <Description>Sample Label</Description>
            <PartnerCustomerID>12345ABCD</PartnerCustomerID>
            <PartnerTransactionID>6789EFGH</PartnerTransactionID>
            <ToName>".$order_info['consignee']."</ToName>
            <ToAddress1>".$order_info['street1']."</ToAddress1>
            <ToCity>".$order_info['city']."</ToCity>
            <ToState>".$order_info['state']."</ToState>
            <ToPostalCode>20260</ToPostalCode>
            <ToPhone>2025551212</ToPhone>
            <FromCompany>A1 Mart Inc</FromCompany>
            <ReturnAddress1>18305 E VALLEY BLVD STE G</ReturnAddress1>
            <FromCity>PUENTE</FromCity>
            <FromState>LA</FromState>
            <FromPostalCode>91744</FromPostalCode>
            <FromPhone>8005763279</FromPhone>
            </LabelRequest>";
            $postfields = 'labelRequestXML='.$request;
            $curl_handle = curl_init ();
            curl_setopt ($curl_handle, CURLOPT_URL, 'https://www.envmgr.com/LabelService/EwsLabelService.asmx/GetPostageLabelXML');
            curl_setopt ($curl_handle, CURLOPT_FOLLOWLOCATION, 1);
            curl_setopt ($curl_handle, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt ($curl_handle, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt ($curl_handle, CURLOPT_POST, 1);
            curl_setopt ($curl_handle, CURLOPT_POSTFIELDS, $postfields);
            $curl_result = curl_exec ($curl_handle) or die ("There has been a CURL_EXEC error");
            $request=XML_unserialize($curl_result);
            $image = base64_decode($request['LabelRequestResponse']['Base64LabelImage']);
            try {
                $temfile = $dirname.$order_info['order_sn'].'_tem'.'.jpg';            
                $temfile = str_replace(CFG_PATH_ROOT, '', $temfile);
                $fp = fopen($temfile, "w+");
                fputs($fp, $image);
                fclose($fp);
                $im = new Image();
                //header('Content-type: image/jpeg');
                //header("Pragma: no-cache");
                //header("Cache-control: no-cache");
                $re = $im->createImageFromFile($temfile);
                $textcolor = imagecolorallocate($re, 255,0,0);
                $newfile = $dirname.$order_info['order_sn'].'.jpg';            
                $newfile = str_replace(CFG_PATH_ROOT, '', $newfile);
                imagettftext($re, 35, 0,40,700,$textcolor,CFG_PATH_LIB.'arial.ttf',$goodstr);
                imagejpeg($re ,$newfile);
                imagedestroy($re);
                unlink($temfile);
            } catch (Exception $e) {
                throw new Exception('保存图片过程出现错误','999');exit();
            }
            $this->db->update($this->tableName,array(
                'track_no' => $request['LabelRequestResponse']['TrackingNumber'],
                'eubpdf'=>$newfile
            ),'order_id ='.$id[$i]);
        }
        return $msg.'交运完成';
    }
    /***************
    ***德国DHL接口
    ***
    ***************/
    function getDEDHL($info)
    {
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $dirname = CFG_PATH_DATA.'upload/'.date('ymd').'/';
        if(!is_dir($dirname)) mkdir($dirname);
        $client = new SoapClient('http://www.intraship.de/ws/1_0/ISService/DE.wsdl');
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();
        for($i=0;$i<count($id);$i++){
            $first = '';
                $order_info = $this->order_info($id[$i]);
                $goods_info = $this->order_goods_info($id[$i]);
                $goodstr ='';
                $totalweight = 0;
                for($j=0;$j<count($goods_info);$j++){
                    $gooditem = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                    $totalweight += $gooditem['weight']*$goods_info[$j]['goods_qty'];
                    $goodstr .= ','.$goods_info[$j]['goods_sn'].'='.$goods_info[$j]['goods_qty'];
                }
                $origin=array ('countryISOCode'=>'DE');
                $origin2=array ('countryISOCode'=>$order_info['CountryCode']);
                $version=array('majorRelease'=>'1','minorRelease'=>'0');
                $name = explode(' ',$order_info['consignee']);
                for($n =0;$n<count($name)-1;$n++){
                    $first .=' '.$name[$n]; 
                    }
                $person=array ('firstname'=>substr($first,1),'lastname'=>$name[count($name)-1]);
                $streetinfo = $this->destreet($order_info['street1']);
                $test  =array(
                    'Version'=>array('majorRelease'=>'1','minorRelease'=>'0'),
                    'ShipmentOrder'=>array('SequenceNumber'=>'1',
                    'Shipment'=>array('ShipmentDetails'=>array('ProductCode'=>($order_info['CountryCode'] == 'DE')?'EPN':'EPI',
                                                                    'ShipmentDate'=>date('Y-m-d'),
                                                                    'DeclaredValueOfGoods'=>'10.2',
                                                                    'DeclaredValueOfGoodsCurrency'=>'USD',
                                                                    'EKP'=>CFG_DEDHL_EKP,
                                                                    'Attendance'=>array('partnerID'=>'01'),
                                                                    'CustomerReference'=>substr($goodstr,1),
                                                                    'ShipmentItem'=>array(
                                                                                            'WeightInKG'=>$totalweight/1000,
                                                                                            'PackageType'=>'PK')),
                        'Service'=>array('ShipmentServiceGroupIdent'=>array('ReturnReceipt'=>false)),
                        'Service'=>array ('ShipmentServiceGroupIdent'=>array('Personally'=>false)),
                        'Service'=>array('ServiceGroupDHLPaket'=>array('Multipack'=>false)),
                        'BankData'=>  array (
                            'accountOwner'=>'DHL.de',
                            'accountNumber'=>'1234567891',
                            'bankCode'=>'87050000',
                            'bankName'=>'Sparkasse Chemnitz',
                            'iban'=>'DE34870500001234567891',
                            'note'=>'Notiz Bank',
                            'bic'=>'CHEKDE81XXX'
                        ),
                        'Shipper'=>array('Company'=>array('Company' =>array('name1'=>$params2['Company'])),
                                         'Address'=>array('streetName'=>$params2['Street'],
                                                          'streetNumber'=>$params2['District'],
                                                          'Zip'=>array ('germany'=>$params2['Postcode']),
                                                          'city'=>$params2['City'],
                                                          'Origin'=>$origin),
                                         'Communication'=>array('phone'=>$params2['Phone'],
                                                           'email'=>$params2['Email'],
                                                           'contactPerson'=>$params2['Contact'])),
                                         'Receiver'=>array('Company'=>array('Person'=>$person,'Company'=>array('name1'=>'test company','name2'=>'143214321')),
                                                           'Address'=>array ('streetName'=>$streetinfo[0],
                                                                           'streetNumber'=>$streetinfo[1],
                                                                           'Zip'=>array ('other'=>$order_info['zipcode']),
                                                                           'city'=>$order_info['city'],
                                                                           'Origin'=>$origin2),
                                                                           'Communication'=>array('phone'=>($order_info['tel']=="Invalid Request")?"":$order_info['tel'],
                                                           'email'=>$order_info['email'],'contactPerson'=>$order_info['street2'])
                                             ),
                                'ExportDocument'=>array(
                                'InvoiceType'=>'proforma',
                                'InvoiceDate'=>'2010-12-23',
                                'InvoiceNumber'=>'444444',
                                'ExportType'=>'1',
                                'ExportTypeDescription'=>'für Sonstiges',
                                'CommodityCode'=>'8888888',
                                'TermsOfTrade'=>($order_info['CountryCode'] == 'DE')?'DDU':'DDP',
                                'Amount'=>'2000',
                                'Description'=>'777777',
                                'CountryCodeOrigin'=>'DE',
                                'AdditionalFee'=>'3.12',
                                'CustomsValue'=>'2.23',
                                'CustomsCurrency'=>'EUR',
                                'PermitNumber'=>'666666',
                                'AttestationNumber'=>'?',
                                'ExportDocPosition'=>array(
                                'Description'=>'Harddisk',
                                'CountryCodeOrigin'=>'DE',
                                'CommodityCode'=>'123456',
                                'Amount'=>'200',
                                'NetWeightInKG'=>'1',
                                'GrossWeightInKG'=>'1.2',
                                'CustomsValue'=>'200',
                                'CustomsCurrency'=>'EUR')
                                )
                             ),
                        'LabelResponseType'=>'URL'
                        ));
                try {
                    $header = new SoapHeader("http://dhl.de/webservice/cisbase",'Authentification',array(
                                            'user'=> CFG_DEDHL_ID,
                                            'signature'=>CFG_DEDHL_KEY,
                                            'type' => '0'));
                    $client->__setSoapHeaders($header);
                    $info = $client->CreateShipmentDD($test);
                    if($info->CreationState->StatusMessage != 'ok') {
                        $StatusMessage = $info->CreationState->StatusMessage;
                        $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].$StatusMessage[0].'<br>';
                        continue;
                    }elseif($info->CreationState->StatusMessage == 'ok'){
                            $file = $dirname.$order_info['order_sn'].'.pdf';
                            $file = str_replace(CFG_PATH_ROOT, '', $file);
                            $fp = fopen($file, 'w');
                            fputs($fp, file_get_contents($info->CreationState->Labelurl));
                            fclose($fp);
                                    $this->db->update($this->tableName,array(
                                        'track_no' => $info->CreationState->ShipmentNumber->shipmentNumber,
                                        'eubpdf'=>$file
                                        ),'order_id ='.$id[$i]);
                    }else{
                        $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误<br>';
                    }
                } catch (SoapFault $fault) {
                    throw new Exception($fault->faultcode."-".$fault->faultstring,'350');exit();
                }
        }
        return $msg.'交运完成';
    }
    /********
    *ICE运输代码转换
    *input  $express系统内部exprssid
    ********/
    function exchangeICEcode($express)
    {
        switch($express)
        {
            case '香港DHL代理价':
            return 'HKDHL';
            case '香港DHL配套电池价':
            return 'HKDHL-D';
            case '香港DHL-H':
            return 'HK-DHL-H';
            case '大陆DHL小货促销价':
            return 'HK-DHL-TH';
            case '香港UPS代理价':
            return 'HKUPS';
            case '大陆联邦IE':
            return 'CN-FEDEX-IE';
            case '大陆联邦IP':
            return 'CN-FEDEX-IP';
            case '香港联邦IE代理价':
            return 'HK-FEDEX-IE';
            case '香港联邦IP代理价':
            return 'HK-FEDEX-IP';
            case '香港联邦配套电池价':
            return 'HK-FEDEX-PT';
            case '香港ARAMEX':
            return 'HKARAMEX';
            case '深圳EMS':
            return 'SZEMS';
            case '广东EMS':
            return 'GDEMS';
            case '北京EMS':
            return 'BJEMS';
            case 'e邮宝':
            return 'EYB';
            case 'e邮宝(广州)':
            return 'EYBGZ';
            case '澳洲E邮宝':
            return 'AU-EYB';
            case '英国E邮宝':
            return 'HKPOSTPB';
            case '香港E邮宝':
            return 'HK-EYB';
            case '加拿大E邮宝':
            return 'CA-EYB';
            case '新加坡EMS':
            return 'SGEMS';
            case '香港EMS':
            return 'HKEMS';
            case 'DX香港大包裹':
            return 'DX-HK-DB';
            case '香港邮政大包裹':
            return 'HKDB';
            case '香港邮政大包裹平邮':
            return 'HK-PPSM';
            case '香港本地包裹服务':
            return 'HKPOSTPM';
            case '天津中邮小包挂号':
            return 'RSGHPS';
            case '中国邮政航空大包(广州)':
            return 'CNPOSTAIR-GZ';
            case '中国邮政航空大包':
            return 'CNPOSTAIR';
            case '中国邮政水陆路大包(广州)':
            return 'CNPOSTSUR-GZ';
            case '中国邮政水陆路大包':
            return 'CNPOSTSUR';
            case '中国邮政空运水陆大包(广州)':
            return 'CNPOSTSAL-GZ';
            case '中国邮政空运水陆大包':
            return 'CNPOSTSAL';
            case '中国邮政平邮小包特价':
            return 'CNPOSTPY-SZ';
            case '中国邮政航空小包挂号':
            return 'CNPOSTGH-SZ';
            case '中国邮政航空小包挂号(广东)':
            return 'CNPOSTGH-NJ';
            case '中国邮政平邮小包特价(广东)':
            return 'CNPOSTPY-GD';
            case '中国邮政平邮小包特价(北京)':
            return 'CNPOSTPY-BJ';
            case '中国邮政航空小包挂号(北京)':
            return 'CNPOSTGH-BJ';
            case '中国邮政平邮小包特价(福建)':
            return 'CNPOSTPY-FJ';
            case '中国邮政航空小包挂号(福建)':
            return 'CNPOSTGH-FJ';
            case '澳洲专线':
            return 'HKPOSTPGM';
            case '互联易专线':
            return 'HLYZX';
            case '俄罗斯专线':
            return 'CNPOSTRU';
            case '香港小包挂号':
            return 'HKPOSTTH';
            case '马来西亚小包平邮':
            return 'MYA';
            case '马来西亚小包挂号':
            return 'MY';
            case '瑞典小包挂号':
            return 'RDXBGHA';
            case '俄罗斯SLL':
            return 'CNPOSTRUXB';
            case 'DLEMS':
            return 'DLEMS';
            case '顺风':
            return 'SF';
            case '中港快件':
            return 'ZGKD';
            case '国外仓储快件':
            return 'WCCKJ';
            case '空运航线一':
            return 'C-AIR1';
            case '香港小包平邮':
            return 'HKPOSTPY';
            case '瑞士小包平邮':
            return 'RSPOSTPY';
            case '瑞士小包挂号':
            return 'RSPOSTGH';
            case '新小包平邮':
            return 'JPPOSTPY';
            case '新小包挂号':
            return 'XJPPOSTGH';
            case '香港投寄易':
            return 'HK-TJY';
            case '俄罗斯小包挂号':
            return 'CNPOSTRUXB';
            case '中国邮政平邮小包特价(浙江)':
            return 'CN-UPS-HD';
            case '中国邮政平邮小包特价(广东)':
            return 'CNPOSTPY-GD';
            case '中国邮政平邮小包特价(上海)':
            return 'CNPOSTPY-SH';
            case '中国邮政航空小包挂号(上海)':
            return 'CNPOSTGH-SH';
            case '中国邮政航空小包挂号(武汉)':
            return 'CNPOSTGH-WH-A';
            case '中国邮政航空小包挂号(广州)':
            return 'CNPOSTGH-GZ';
            case '中国邮政航空小包挂号(华南)':
            return 'HNCNPOSTGH';
            case '中国邮政平邮小包特价(DG)':
            return 'CNPOSTPY-DG';
            case '中国邮政航空小包挂号(DG)':
            return 'CNPOSTGH-DG';
            case '中国邮政平邮小包特价(SH)':
            return 'CNPOSTPY-SH';
            case '省外中邮小包平邮':
            return 'HK-UPS-LDTH';
            case '省外中邮小包挂号':
            return 'RSGHPS';
            case 'DHL小包挂号':
            return 'RDXBGHH';
            case '香港大量投寄空邮平邮':
            return 'HKPOSTPG';
            case '俄罗斯专线小包':
            return 'RDXB';
            case '瑞典小包挂号(电池)':
            return 'RDXBGHB';
            case 'DHL小包平邮':
            return 'RDXBGHI';
            case '中国邮政平邮小包特价(GZ)':
            return 'CNPOSTPY-GZ';
            case '中国邮政平邮小包特价(ZJ)':
            return 'CN-UPS-HD';
            case 'SZ邮政小包挂号':
            return 'SZCNPOSTGH';
            case 'SZ邮政小包平邮':
            return 'SZCNPOSTPY';
            default:
            return NULL;
        }
    }
    /***************
    ***互联易订单处理
    *   HKDB:香港邮政大包裹

        MR--DENG 2015/4/9 11:38:35
        HNCNPOSTGH:中国邮政航空小包挂号(华南)

        MR--DENG 2015/4/9 11:39:03
         RDXBGHH:DHL小包挂号

    ****************
    ***************/
    function updateIce($info){
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $modelgoods = new ModelGoods();
        $shipping = ModelDd::getArray('shipping'); 
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();   

        if(isset($info['token']) && !empty($info['token'])){
            
            
            if($info['token'] == 'tsm珠宝'){
                 $userToken = CFG_TOKEN_ICE;        
            }else{
                $userToken = CFG_TOKEN_ICE2; 
            }
            
           
            
        }else{
            $userToken = CFG_TOKEN_ICE;
        }
        try {
            for($i=0;$i<count($id);$i++){
                $goods = array();
                $order_info = $this->order_info($id[$i]);
                $code = $this->exchangeICEcode($shipping[$order_info['shipping_id']]);
                //return $this->exchangeICEcode($shipping[$order_info['shipping_id']]);
                $request['orderNo'] = CFG_ORDER_PREFIX.$order_info['order_sn'];
                $request['transportWayCode'] = $code;
                $request['cargoCode'] = 'W';
                $request['originCountryCode'] = 'CN';
                $request['destinationCountryCode'] = $order_info['CountryCode'];
                $request['pieces'] = '1L';
                $request['shipperName'] = $params2['Contact'];
                $request['shipperAddress'] = $params1['City'].$params1['District'].$params1['Street'].$params1['Province'];
                $request['shipperTelephone'] = $params2['Phone'];
                $request['consigneeName'] = $order_info['consignee'];
                $request['street'] = $order_info['street1'].','.$order_info['street2'];
                $request['city'] = $order_info['city'];
                $request['province'] = $order_info['state'];
                $request['consigneePostcode'] = $order_info['zipcode'];
                $request['consigneeTelephone'] = $order_info['tel'];
                $request['insured'] = 'N';
                $request['goodsCategory'] = 'G';
                $goods_info = $this->order_goods_info($id[$i]);
                $weight = 0;  
                if(CFG_DECLARED_ORDER_QTY_1){
                    //全部使用默认
                    $goods_name = $goodsvalue['goods_name']; 
                    $goods_price = $goodsvalue['goods_price'];
                    $total_qty = 1;
                    $dec_name = CFG_DEC_NAME;
                    $Declared_weight = CFG_DECLARED_WEIGHT;
                    $Declared_value = $dec_name; 
                    $goods = array(
                        'name'      => $Declared_value,
                        'pieces'    => '1',
                        'netWeight' => $Declared_weight,
                        'unitPrice' => CFG_DECLARED_VALUE
                    );
                    $request['weight'] = CFG_DECLARED_WEIGHT;     
                }else{
                    foreach($goods_info as $key => $goodsvalue){ 
                        if(CFG_IMPORT_CUSTOMS){
                            //多个产品    
                            //优先使用导入产品信息
                            $goods_name = $goodsvalue['goods_name']; 
                            $goods_price = $goodsvalue['goods_price'];
                            $total_qty = $goodsvalue['goods_qty'];
                            $dec_name = ($goods_name <> '') ? $goods_name : CFG_DEC_NAME;
                            $Declared_weight = ($goodsvalue['goods_weigth'] <> 0) ? $goodsvalue['goods_weigth']*$total_qty : CFG_DECLARED_WEIGHT;
                            $Declared_value = ($goods_price <> 0) ? $goods_price : CFG_DECLARED_VALUE; 
                            $goods[] = array(
                                'name'      => $dec_name,
                                'pieces'    => $total_qty,
                                'netWeight' => $Declared_weight,
                                'unitPrice' => $goodsvalue['goods_price']
                            );     
                        }else{
                            $getgoods = $modelgoods->goods_info('',$goodsvalue['goods_sn']);
                            //有产品库的订单产品
                            if(count($getgoods)>0){ 
                                $goods_name = $getgoods['dec_name'];
                                $goods_name_cn = $getgoods['dec_name_cn'];
                                $item_no = $goodsvalue['item_no'];
                                $item_sn = $goodsvalue['goods_sn'];
                                $goods_price = $getgoods['Declared_value'];
                                $goods_weigth = $getgoods['Declared_weight'];   
                                $dec_name = $goods_name == '' || $goods_name == NULL   || !$goods_name ? CFG_DEC_NAME : $goods_name;
                                
                                
                                $Declared_weight = ($goods_weigth > 0) ? $goods_weigth : CFG_DECLARED_WEIGHT;
                                $Declared_value = ($goods_price > 0) ? $goods_price : CFG_DECLARED_VALUE;
                                $goods[] = array(
                                    'name'      => $dec_name,
                                    'pieces'    => $goodsvalue['goods_qty'],
                                    'netWeight' => $Declared_weight,
                                    'unitPrice' => $Declared_value
                                );  
                            }else{
                                $CustomsTitleEN = $getgoods['dec_name'] == '' ? CFG_DEC_NAME : $getgoods['dec_name'].'  '.$goodsvalue['goods_sn'].'&'.$goodsvalue['goods_qty'];
                                $Declared_weight = CFG_DECLARED_WEIGHT;
                                $Declared_value = CFG_DECLARED_VALUE;
                            }
                            $weight += $Declared_weight*$goodsvalue['goods_qty']; 
                        }       
                    }
                    $request['weight'] = $weight;
                }
                
                /****2014 - 06 - 04  nic  修复提交最大报关价值****/
                $dec_value = $Declared_value*$goodsvalue['goods_qty'];
                if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                    if($dec_value > CFG_DECLARED_MAX){
                       $dec_value = CFG_DECLARED_MAX; 
                    }
                }
                            
                $request['declareItems']  =  $goods;
                $client = new SoapClient ("http://kd.szice.net:8086/xms/services/order?wsdl", array ('encoding' => 'UTF-8' ));
                $order_register= $client->createAndAuditOrder($userToken,$request);    
                if($order_register->success){
                    if(isset($order_register->trackingNo)){
                        
                        $this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $order_register->trackingNo,'track_no_2' => $order_register->id),'order_id ='.$id[$i]);
                    }else{
                        $this->db->update(CFG_DB_PREFIX.'order',array('track_no_2' => $order_register->id),'order_id ='.$id[$i]);
                    }
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'预报成功！</br>';
                }else{
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].$order_register->error->errorInfo.'</br>';                   
                }
            }    
        } catch (Exception $e) {
                throw new Exception($e->getMessage(),'002');exit();
        }
        return     $msg;
    }
    /********
    *ICE打印标签页面
    *
    ********/
    function icelabelprint($info){
        $ids = $info['id'];
        $id = explode(',',$ids);
        
        if(isset($info['token']) && !empty($info['token'])){
            
            
            if($info['token'] == 'tsm珠宝'){
                 $userToken = CFG_TOKEN_ICE;        
            }else{
                $userToken = CFG_TOKEN_ICE2; 
            }
                  
        }else{
            $userToken = CFG_TOKEN_ICE;
        }
        
        
        try {
            $ordersns = '';
            for($i=0;$i<count($id);$i++){
                $order_info = $this->order_info($id[$i]);
                if($order_info['track_no_2']){
                    $ordersns .= $ordersns=='' ? $order_info['track_no_2'] : ','.$order_info['track_no_2'] ; 
                }
            }
        } catch (Exception $e) {
                throw new Exception($e->getMessage(),'002');exit();
        }        
        return "http://kd.szice.net:8086/xms/client/order_online!print.action?userToken=".$userToken."&oid=".$ordersns;
    }
    /********
    *创建提交俄速通订单
    *
    ********/
    function CreateESuTongOrder($info){
        set_time_limit(300);
        $authcode = CFG_TOKEN_EST;
        $userToken = $authcode;
        if(!$userToken || $userToken == ''){
            return '未获取使用的权限,请咨询相关工作人员！';
        }
        $client = new SoapClient ("http://api.ruston.cc/OrderOnline/ws/OrderOnlineService.dll?wsdl", array ('encoding' => 'UTF-8' ));
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';        
        
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        if(defined('CFG_DECLARED_MAX')) $CFG_DECLARED_MAX = CFG_DECLARED_MAX?CFG_DECLARED_MAX:99999;
        else $CFG_DECLARED_MAX = 99999;
        $contact_normal = $params2['Contact'];
        for($i=0;$i<count($id);$i++){
            $order_info = $this->order_info($id[$i]);
            if($order_info['track_no'] <> '') continue;    
            $modelgoods = new ModelGoods();
            $CreateOrderRequestArray = array();
            $DeclareInvoiceItemArray = array();  
            if($order_info['CountryCode'] <> 'RU'){$msg .= '该运输方式不支持国家为'.$order_info['CountryCode'].'的订单！请将CountryCode更改为RU！';continue;}
            $CreateOrderRequestObj = new stdClass();
            $CreateOrderRequestObj->orderNo = CFG_ORDER_PREFIX.$order_info['order_sn'];
            $CreateOrderRequestObj->productCode = 'A3';
            $CreateOrderRequestObj->cargoCode = null;
            $CreateOrderRequestObj->initialCountryCode =  'CN';
            $CreateOrderRequestObj->destinationCountryCode = $order_info['CountryCode'];
            $CreateOrderRequestObj->shipperName = $params2['Contact'];
            $CreateOrderRequestObj->shipperAddress = $params2['Street'];
            $CreateOrderRequestObj->shipperCompanyName = $params2['Company'];
            $CreateOrderRequestObj->shipperTelephone = '22335676';
            $CreateOrderRequestObj->shipperStateOrProvince = $params2['Province'];
            $CreateOrderRequestObj->shipperCity = $params2['City'];
            $CreateOrderRequestObj->mctCode = '3';  
            $CreateOrderRequestObj->buyerId =$order_info['userid'];
            $CreateOrderRequestObj->ReturnSign = (CFG_RETURN_4PX == 1)?'Y':'N';
            $CreateOrderRequestObj->consigneeName = $order_info['consignee'];
            $CreateOrderRequestObj->street = $order_info['street1'].(($order_info['street2'])?','.$order_info['street2']:'');
            $CreateOrderRequestObj->city = $order_info['city'];
            $CreateOrderRequestObj->stateOrProvince = $order_info['state'];
            $CreateOrderRequestObj->consigneeEMail = 'aa@aa.com';
            $CreateOrderRequestObj->consigneeTelephone = ($order_info['tel']=="Invalid Request")?"":$order_info['tel'];
            $CreateOrderRequestObj->consigneePostCode = ($order_info['CountryCode'] == 'US')?substr($order_info['zipcode'],0,5):$order_info['zipcode'];
            $CreateOrderRequestObj->printSign = null;
            $CreateOrderRequestObj->transactionID = null;
            $CreateOrderRequestObj->totalPieces = null;
            $CreateOrderRequestArray[] = $CreateOrderRequestObj;
                $goods_info = $this->order_goods_info($id[$i]);
                $total=0;$value=0;
                for($j=0;$j<count($goods_info);$j++){
                            $getgoods = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                            $dec_name = $getgoods['dec_name']?$getgoods['dec_name']:CFG_DEC_NAME;
                            $dec_name_cn = $getgoods['dec_name_cn']?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                            $Declared_value = ($getgoods['Declared_value_cat']>0)?$getgoods['Declared_value_cat']:CFG_DECLARED_VALUE;
                            $Declared_value = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:$Declared_value;
                            $total +=  $goods_info[$j]['goods_qty'];
                            $value += $Declared_value*$goods_info[$j]['goods_qty'];
                            $DeclareInvoiceItem = new stdClass();
                            $DeclareInvoiceItem->eName = $dec_name;
                            $DeclareInvoiceItem->declarePieces = $goods_info[$j]['goods_qty'];
                            $DeclareInvoiceItem->unitPrice = $Declared_value;
                            $DeclareInvoiceItem->name = $goods_info[$j]['goods_sn'];
                            $DeclareInvoiceItemArray[] = $DeclareInvoiceItem; 
                }
                if($value>$CFG_DECLARED_MAX){
                    for($t=0;$t<count($DeclareInvoiceItemArray);$t++){
                        $DeclareInvoiceItemArray[$t]->unitPrice = floor($CFG_DECLARED_MAX/$total);
                    }                
                }
            $CreateOrderRequestObj->declareInvoice = $DeclareInvoiceItemArray;
            
            $temp = array("arg0"=>$userToken,"arg1"=>$CreateOrderRequestArray);
                 
            $order_register = $client->CreateAndPreAlertOrderService($temp)->return;
            /*return var_dump($order_register);*/ 
            if($order_register->ack == 'Failure') {
                $errors = $order_register->errors;
                $errors = is_array($errors)?$errors[0]:$errors;
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交失败'.$order_register->errors->cnMessage.','.$order_register->errors->cnAction.'!<br>';
                continue;
            }elseif($order_register->ack == 'Success'){
                $this->db->execute("update ".$this->tableName." set track_no = '".$order_register->trackingNumber."' where order_id = ".$id[$i]);
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'提交成功<br>';
            }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'未知错误'.$order_register->errors->cnMessage.'<br>';
            }
        }
        $msg .= '提交订单完成';
        return $msg;
    }
    /*******
    * 转换中环运渠道代码代码
    * 
    *****/
    function exchangezhycode($express){
        switch($express)
        {
            case '马来西亚挂号':
            return 'ZHYA3120';
            case '马来西亚平邮':
            return 'ZHYA3130';
            case '英国专线':
            return 'ZHYA3160';
            case '俄罗斯小包':
            return 'ZHYA3031';
            case '福州小包挂号':
            return 'ZHYA1041';
            case '上海小包(上海)':
            return 'ZHYA1035';
            case '上海小包(义务)':
            return 'ZHYA1036';
            case '上海小包(深圳)':
            return 'ZHYA1037';
            case '未知邮路':
            return 'test8888';
            case '瑞士小包平邮':
            return 'ZHYA3081';
            case '——中国邮政——':
            return 'ZHYA1000';
            case 'SZ邮政小包挂号':
            return 'ZHYA1010';
            case 'SZ邮政小包平邮':
            return 'ZHYA1020';
            case '北京小包挂号':
            return 'ZHYA1030';
            case '上海小包挂号':
            return 'ZHYA1040';
            case '广州小包挂号':
            return 'ZHYA1050';
            case '义乌小包挂号':
            return 'ZHYA1060';
            case '江浙小包挂号':
            return 'ZHYA1070';
            case '深圳大包AIR':
            return 'ZHYA1080';
            case 'SZ邮政大包':
            return 'ZHYA1090';
            case '义乌大包AIR':
            return 'ZHYA1100';
            case '义乌大包SAL':
            return 'ZHYA1110';
            case '上海大包AIR':
            return 'ZHYA1120';
            case '上海大包SAL':
            return 'ZHYA1130';
            case '广州大包AIR':
            return 'ZHYA1140';
            case '广州大包SAL':
            return 'ZHYA1150';
            case '深圳EMS':
            return 'ZHYA1160';
            case '广州EMS':
            return 'ZHYA1170';
            case '杭州EMS':
            return 'ZHYA1180';
            case '义乌EMS':
            return 'ZHYA1190';
            case '上海EMS':
            return 'ZHYA1200';
            case '——香港邮政——':
            return 'ZHYA2000';
            case '香港小包挂号':
            return 'ZHYA2010';
            case '香港小包平邮':
            return 'ZHYA2020';
            case '香港大包':
            return 'ZHYA2030';
            case '香港EMS':
            return 'ZHYA2040';
            case '——专线邮政——':
            return 'ZHYA3000';
            case '澳邮宝':
            return 'ZHYA3010';
            case '澳邮宝(挂号)':
            return 'ZHYA3020';
            case '俄邮宝':
            return 'ZHYA3030';
            case '瑞典小包挂号':
            return 'ZHYA3050';
            case '德国小包挂号':
            return 'ZHYA3060';
            case '德国小包平邮':
            return 'ZHYA3070';
            case '瑞士小包挂号':
            return 'ZHYA3080';
            case '新加坡小包挂号':
            return 'ZHYA3090';
            case '新加坡EMS特惠':
            return 'ZHYA3100';
            case '新加坡EMS':
            return 'ZHYA3110';
            case '——国际快递——':
            return 'ZHYA4000';
            case '香港DHL':
            return 'ZHYA4010';
            case '香港DHL品牌全区价':
            return 'ZHYA4020';
            case '新加坡DHL(2KG)':
            return 'ZHYA4030';
            case '香港DHL-纯电池':
            return 'ZHYA4040';
            case '香港UPS':
            return 'ZHYA4050';
            case '香港UPS红单特惠':
            return 'ZHYA4060';
            case '大陆联邦IE':
            return 'ZHYA4070';
            case '大陆联邦IP特惠':
            return 'ZHYA4080';
            case '香港FEDEX-IE':
            return 'ZHYA4090';
            case '香港FEDEX-IP':
            return 'ZHYA4100';
            case '荷兰小包挂号':
            return 'ZHYA3040';
            case '巴邮宝':
            return 'ZHYA3170';
            case '斐济小包挂号':
            return 'ZHYA3140';
            case '斐济小包平邮':
            return 'ZHYA3150';
            default:
            return NULL;
        }
            
    }
    /*******
    * 转换中环运渠道代码代码
    * 
    *****/
    function exchangesycode($express){
        switch($express)
        {
            case '香港小包挂号':
            return 'HKBRAM';
            case '中邮小包挂号':
            return 'CNRAM';
            case '瑞士小包平邮':
            return 'SWBAM';
            case '瑞士小包挂号':
            return 'SWBRAM';
            case '德国小包平邮':
            return 'DGMAM';
            case '德国小包挂号':
            return 'DGMRAM';
            case '马邮小包平邮':
            return 'MYAM';
            case '马邮小包挂号':
            return 'MYRAM';
            case '顺邮宝平邮':
            return 'SYBAM';
            case '顺邮宝挂号':
            return 'SYBRAM';
            default:
            return NULL;
        }
            
    }
    /********
    *创建提交中环运订单
    *
    ********/
    function UpdateZHYorder($info){
        set_time_limit(300);
        $authcode = CFG_TOKEN_ZHY;
        $userToken = $authcode;
        if(!$userToken || $userToken == ''){
            return '未获取使用的权限,请咨询相关工作人员！';
        }
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';        
        $client = new SoapClient ("http://zhyapi.zhy-sz.com/LosAPIService.asmx?WSDL");
        $modelgoods = new ModelGoods();
        $Sales_channels = ModelDd::getArray('Sales_channels');
        $shipping = ModelDd::getArray('shipping');
        
        /*                                                
        *
        * 字段 format
        *   1：A4纸打印地址标签+报关单+配货信息
            2：10*10标签纸打印地址标签+报关单
            3：10*10标签纸打印地址标签+配货信息
            4：标签纸打印(斐济邮政100*150)
            5：A4纸打印地址标签+配货信息
            6：A4纸打印(斐济邮政) 
        */
        
       
       if(!CFG_ZHY_A4LABEL && !CFG_ZHY_LABELDEC)$labelType = 7;
       if(CFG_ZHY_A4LABEL && !CFG_ZHY_LABELDEC)$labelType = 5;
       if(!CFG_ZHY_A4LABEL && CFG_ZHY_LABELDEC)$labelType = 2;   
       
        try {
            for($i=0;$i<count($id);$i++){
                $order_info = $this->order_info($id[$i]);
                
                if($order_info['track_no'] <> '') continue;
                   $scode = $this->exchangesycode($shipping[$order_info['shipping_id']]);
                   if($scode==null){
                       $msg .= '订单'.$order_info['order_sn'].'运输方式名称不是顺友官方指定方式。请更改！<br/>';continue;
                   }
                   $EyODR_OrderMain = array(
                    "Cust_OrderNo" => $order_info['paypalid'], 
                    "PostalLineNo" => $scode,
                    "BuyesID" => $order_info['userid'],
                    "Province" => $order_info['state'],
                    "City" => $order_info['city'],
                    "ConsigneeTel" => $order_info['tel'],
                    "DestCountryCode" => $order_info['CountryCode'],
                    "ConsigneeName" => $order_info['consignee'],
                    "ConsigneePostCode" => $order_info['zipcode'],
                    "ConsigneeStreet" => $order_info['street1'].$order_info['street2'],
                    "OrderRemark" => $Sales_channels[$order_info['Sales_channels']],
                    "OrderStatus" => 2,
                    "IsImportant" => false,
                    "LastUpdateOn" => date('Y-m-d'), 
                    "logisticsFees" => $order_info['shipping_fee'],
                    "OrderMoney" => $order_info['order_amount'],
                    "PrintStatus" => 0
                );
                $goods_info = $this->order_goods_info($id[$i]);
                
                $weight = 0;
                $productqty = 0; 
                $arrayDetail = array(); 
                if(CFG_DECLARED_ORDER_QTY_1){
                    //全部使用默认
                    $goods_name = $goodsvalue['goods_name']; 
                    $goods_price = $goodsvalue['goods_price'];
                    $total_qty = 1;
                    $dec_name = CFG_DEC_NAME;
                    $Declared_weight = CFG_DECLARED_WEIGHT;
                    $Declared_value = $dec_name;
                    $arrayDetail[] = array(
                        "ID" => 1,
                        "En_Name" => $Declared_value, 
                        "UnitPrice" => CFG_DECLARED_VALUE,
                        "DeclareNumber" => 1,
                        "DeclareUnit" => "PCS",                                                                       
                        "CargoRemark" => ""
                    );   
                    $EyODR_OrderMain['CustomerWeight'] = CFG_DECLARED_WEIGHT; 
                    $productqty = 1; 
                }else{                                            
                    foreach($goods_info as $key => $goodsvalue){  
                        if(CFG_IMPORT_CUSTOMS){
                           
                            //优先使用导入产品信息
                            $goods_name = $goodsvalue['goods_name']; 
                            $goods_price = $goodsvalue['goods_price'];
                            $total_qty = $goodsvalue['goods_qty'];
                            $dec_name = ($goods_name <> '') ? $goods_name : CFG_DEC_NAME;
                            $Declared_weight = ($goodsvalue['goods_weigth'] <> 0) ? $goodsvalue['goods_weigth']*$total_qty : CFG_DECLARED_WEIGHT;
                            $Declared_value = ($goods_price <> 0) ? $goods_price : CFG_DECLARED_VALUE;
                            $arrayDetail[] = array(
                                "ID" => 1,
                                "En_Name" => $dec_name, 
                                "UnitPrice" => $goodsvalue['goods_price'],
                                "DeclareNumber" => $total_qty,
                                "DeclareUnit" => "PCS",                                                                       
                                "CargoRemark" => ""
                            );
                            $productqty += $total_qty;  
                        }else{
                            $getgoods = $modelgoods->goods_info('',$goodsvalue['goods_sn']);
                            //有产品库的订单产品
                            if(count($getgoods)>0){ 
                                $goods_name = $getgoods['dec_name'];
                                $goods_name_cn = $getgoods['dec_name_cn'];
                                $item_no = $goodsvalue['item_no'];
                                $item_sn = $goodsvalue['goods_sn'];
                                $goods_price = $getgoods['Declared_value'];
                                $goods_weigth = $getgoods['Declared_weight'];   
                                $dec_name = $goods_name == '' || $goods_name == NULL   || !$goods_name ? CFG_DEC_NAME : $goods_name;
                                
                                
                                $Declared_weight = ($goods_weigth > 0) ? $goods_weigth : CFG_DECLARED_WEIGHT;
                                $Declared_value = ($goods_price > 0) ? $goods_price : CFG_DECLARED_VALUE;
                                
                                
                                $arrayDetail[] = array(
                                    "ID" => 1,
                                    "En_Name" => $dec_name,  
                                    "UnitPrice" => $Declared_value,
                                    "DeclareNumber" => $goodsvalue['goods_qty'],
                                    "DeclareUnit" => "PCS"
                                );
                                $productqty += $goodsvalue['goods_qty'];
                            }else{
                                $CustomsTitleEN = $getgoods['dec_name'] == '' ? CFG_DEC_NAME : $getgoods['dec_name'].'  '.$goodsvalue['goods_sn'].'&'.$goodsvalue['goods_qty'];
                                $Declared_weight = CFG_DECLARED_WEIGHT;
                                $Declared_value = CFG_DECLARED_VALUE;
                                $arrayDetail[] = array(
                                    "ID" => 1,
                                    "En_Name" => $CustomsTitleEN,  
                                    "UnitPrice" => CFG_DECLARED_VALUE,
                                    "DeclareNumber" => $goodsvalue['goods_qty'],
                                    "DeclareUnit" => "PCS"
                                );
                                $productqty += $goodsvalue['goods_qty'];
                            }
                            $weight += $Declared_weight*$goodsvalue['goods_qty']; 
                        }       
                    }
                    $EyODR_OrderMain['CustomerWeight'] = $weight;  
                    $EyODR_OrderMain['ProductsTotal'] = $productqty;  
                    $EyODR_OrderMain['Pieces'] = $productqty;  
                }                                    
                
                /****2014 - 06 - 04  nic  修复提交最大报关价值****/
                $dec_value = $Declared_value*$goodsvalue['goods_qty'];
                if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                    if($dec_value > CFG_DECLARED_MAX){
                       $dec_value = CFG_DECLARED_MAX; 
                    }
                }      
                $order = array('OrderMain' => $EyODR_OrderMain,'orderDetails' => $arrayDetail,'secretKey'=>'c4a75af837f3d4b09ea041ce5ba3b7a7','format'=>$labelType);
                $result = $client->AddOrderMain($order);
                
                $rs = explode('|',$result->AddOrderMainResult);
                
                if($rs[0]=='SUCCESS'){
                    $this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $rs[3],'track_no_2' => $rs[1],'eubpdf'=>$rs[2]),'order_id ='.$id[$i]);
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'预报成功！</br>';
                }else{
                    
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'预报失败</br>';                   
                }   
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage());exit();
        }
        return $msg;
    }
    /***
    * 预报贝邮宝订单
    * 818e8ce97f6b7829c1cb28a17709d070453
    * info
    */                              /***
    * 预报贝邮宝订单
    * 818e8ce97f6b7829c1cb28a17709d070453
    * info
    */
    function GetPPpackagetracking($info){
        set_time_limit(300);
        $authcode = CFG_PYB_TOKEN;  
        $userToken = $authcode;
        if(!$userToken || $userToken == ''){
            return '未获取使用的权限,请咨询相关工作人员！';
        }
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();                        
        $shipping = ModelDd::getArray('shipping');
            
        $url = "https://www.ppbyb.com/api_v2.asp";
        try {
            for($i=0;$i<count($id);$i++){
                $str_xml = '<?xml version="1.0" encoding="UTF-8"?>
                <orders>
                <api_key>'.$userToken.'</api_key>
                <mark></mark>
                <bid>1</bid>';    
                $order_info = $this->order_info($id[$i]);
                
                if($shipping[$order_info['shipping_id']] == '贝邮宝挂号'){
                    $otype = '1';    
                }elseif($shipping[$order_info['shipping_id']] == '贝邮宝平邮'){
                    $otype = '0'; 
                }else{
                    $otype = '1';     
                }
                
                $goods_info = $this->order_goods_info($id[$i]);
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
                if(!empty($info['dec_name'])) $dec_name = $info['dec_name'];         
                if(!empty($info['Declared_weight'])) $Declared_weight = $info['Declared_weight'];
                if(!empty($info['Declared_value'])) $Declared_value = $info['Declared_value'];
                
                if($order_info['country']=='Russian Federation')$order_info['country']='Russia';
                if($order_info['country']=='Netherlands')$order_info['country']='Netherland';
                if($order_info['country']=='Czech Republic')$order_info['country']='Czech';
                if($order_info['state']==''||$order_info['state']==null)$order_info['state']='.';
                if($order_info['city']==''||$order_info['city']==null)$order_info['city']='.';
                if($order_info['tel']==''||$order_info['state']==null)$order_info['tel']='89277777075'; 
             
                $order_info['paypalid'] = str_replace('-','',$order_info['paypalid']);
                $str_xml .= 
               '<order>
                <guid>'.$order_info['order_id'].'</guid>
                <otype>'.$otype.'</otype>
                <from>'.$params2['Contact'].'</from>
                <sender_addres>'.$params2['Street'].'</sender_addres>
                <sender_province>'.$params2['Province'].'</sender_province>
                <sender_city>'.$params2['City'].'</sender_city>
                <sender_phone>'.$params2['Phone'].'</sender_phone>
                <to>'.$order_info['consignee'].'</to>
                <to_local>'.$order_info['consignee'].'</to_local>
                <recipient_addres>'.$order_info['street1'].$order_info['street2'].'</recipient_addres>
                <recipient_addres_local>'.$order_info['street1'].$order_info['street2'].'</recipient_addres_local>
                <recipient_country>'.$order_info['country'].'</recipient_country>
                <recipient_country_local>'.$order_info['country'].'</recipient_country_local>
                <recipient_province>'.$order_info['state'].'</recipient_province>
                <recipient_province_local>'.$order_info['state'].'</recipient_province_local>
                <recipient_city>'.$order_info['city'].'</recipient_city>
                <recipient_city_local>'.$order_info['city'].'</recipient_city_local>
                <recipient_postcode>'.$order_info['zipcode'].'</recipient_postcode>
                <recipient_phone>'.$order_info['tel'].'</recipient_phone>
                <content>'.$dec_name.'</content>
                <type_no>1</type_no>
                <weight>'.$Declared_weight.'</weight>
                <num>'.$qty.'</num>
                <single_price>'.$Declared_value.'</single_price>
                <from_country>China</from_country>
                <trade_amount>'.$order_info['order_amount'].'</trade_amount>
                <trande_no>'.$order_info['paypalid'].'</trande_no>
                <user_desc>'.$order_info['paypalid'].'</user_desc>
                </order>'; 
                $str_xml .= '</orders>';  

                $responseBody = $this->send($str_xml, $url ,true);
                
                $xmlBody = simplexml_load_string($responseBody);
                
                if($xmlBody->status == 0){
                    foreach($xmlBody->barcode as $k => $order_track_no){ 
                        $this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $order_track_no,'eubpdf'=> str_replace('///','//www.ppbyb.com/',$xmlBody->$info['labeltype'])),'order_id ='.$order_track_no['guid']);
                    }
                    $msg = '预报成功！';    
                }else{
                    $msg = '预报出现错误，错误码：'.$xmlBody->status.'<br>错误详情：<font style="color:red">'.$xmlBody->error_message.'</font>';
                }       
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage());exit();
        }
        return $msg;    
    }
    function GetYwtracking($info){
        
        set_time_limit(300);       
       $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();                        
        $shipping = ModelDd::getArray('shipping');
        
        if(!empty($info['token'])){
            
            $userid = $info['token'];   
            if($info['token'] == CFG_YW_KEY){    
                $userToken = CFG_YW_TOKEN;
            }else{
                $userToken = CFG_YW_TOKEN2;       
            }
                                       
        }else{                          
            $userid = CFG_YW_KEY;   
            $userToken = CFG_YW_TOKEN;
        }
        
        
        $url = "http://Online.yw56.com.cn/service/Users/".$userid."/Expresses";
        try {
            for($i=0;$i<count($id);$i++){
                $order_info = $this->order_info($id[$i]);
                if($order_info['track_no'] <> '') continue;
                   $goods_info = $this->order_goods_info($id[$i]);
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
                   
                   $post_header = array('Authorization: basic '.$userToken, 'Content-Type: text/xml; charset=utf-8');
                   
                   $post_data = '<ExpressType><Epcode></Epcode><Userid>'.$userid.'</Userid><Channel>'. $shipping[$order_info['shipping_id']].'</Channel><Package>无</Package><UserOrderNumber>'.CFG_ORDER_PREFIX.$order_info['order_sn'].'</UserOrderNumber><SendDate>'.date('Y-m-d\TH:i:s').'</SendDate><Receiver><Userid>'.$userid.'</Userid><Name>'.$order_info['consignee'].'</Name><Phone>'.$order_info['tel'].'</Phone><Mobile></Mobile><Email></Email><Company></Company><Country>'.$this->getCncountry($order_info['country']).'</Country><Postcode>'.$order_info['zipcode'].'</Postcode><State>'.$order_info['state'].'</State><City>'.$order_info['city'].'</City><Address1>'.$order_info['street1'].' '.$order_info['street2'].'</Address1><Address2></Address2></Receiver><Memo></Memo>';
                        
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
                            $Declared_weight = 1000*$getgoods['Declared_weight'];
                            $Declared_value = $getgoods['Declared_value'];
                        }else{
                            $CustomsTitleEN =  CFG_DEC_NAME .'  '.$goodsvalue['goods_sn'].'*'.$goodsvalue['goods_qty'];
                            $goods_name_cn = CFG_DEC_NAME_CN;
                            $Declared_weight = 1000*CFG_DECLARED_WEIGHT;
                            $Declared_value = CFG_DECLARED_VALUE;
                        }
                        
                        $dec_value = $Declared_value*$goodsvalue['goods_qty'];
                        if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                            if($dec_value > CFG_DECLARED_MAX){
                               $dec_value = CFG_DECLARED_MAX; 
                            }
                        }
                                                                                   
                        if($goods_name_cn == '') $goods_name_cn = CFG_DEC_NAME_CN;
                        
                        $post_data .= '<Quantity>'.$total_qty.'</Quantity><GoodsName><Userid>'.$userid.'</Userid><NameCh>'.$goods_name_cn.'</NameCh><NameEn>'.$CustomsTitleEN.'</NameEn><Weight>'.$Declared_weight*$goodsvalue['goods_qty'].'</Weight><DeclaredValue>'.$Declared_value*$goodsvalue['goods_qty'].'</DeclaredValue><DeclaredCurrency>'.$order_info['currency'].'</DeclaredCurrency><MoreGoodsName>'.CFG_DEC_NAME_CN.'</MoreGoodsName></GoodsName>';
                       
                    }
                }
                $post_data .= '</ExpressType>';
               
               //echo $post_data;
               
               $curl = curl_init();
                curl_setopt($curl, CURLOPT_URL, 'http://online.yw56.com.cn/service/Users/'.$userid.'/Expresses');

                curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($curl, CURLOPT_POST, 1);
                curl_setopt($curl, CURLOPT_VERBOSE, 1);
                curl_setopt($curl, CURLOPT_HEADER, 0); //不取得返回头信息 
                curl_setopt($curl, CURLOPT_HTTPHEADER, $post_header);
                curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);

                $result = curl_exec($curl);
                curl_close($curl) ;
                
                $xmlBody = simplexml_load_string($result);
                //var_dump($xmlBody);
                if($xmlBody->Response->Success == 'true'){
                    //       
                    
                    $order_track_no = $xmlBody->Response->Epcode;
                    $this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $order_track_no,'track_no_2' => $userid."_".$order_track_no."_10x10LCI",'eubpdf' => "$userid" ),'order_id ='.$id[$i]);
                    $msg .= ''.CFG_ORDER_PREFIX.$order_info['order_sn'].'('.$shipping[$order_info['shipping_id']].')提交成功.运单号：'.$order_track_no.'<br/>';
                    
                }else{
                    $msg .= ''.CFG_ORDER_PREFIX.$order_info['order_sn'].'('.$shipping[$order_info['shipping_id']].')提交失败.错误信息：'.$xmlBody->Response->Reason.','.$xmlBody->Response->ReasonMessage.'<br/>';
                } 
            }
            
        } catch (Exception $e) {
            throw new Exception($e->getMessage());exit();
        }
        return $msg;  
    }
    
    function GetSytracking($info){       
        
        
        
        
        $ids = $info['id'];
        $id = explode(',',$ids);
        $msg = '';
        $modelgoods = new ModelGoods();
        $shipping = ModelDd::getArray('shipping'); 
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $modelgoods = new ModelGoods();   

       
       
        for($i=0;$i<count($id);$i++){
            $goods = array();
            $order_info = $this->order_info($id[$i]);
            $code = $this->exchangesycode($shipping[$order_info['shipping_id']]);
           
            $request['saleNo'] = CFG_ORDER_PREFIX.$order_info['order_sn'];
            $request['hasLabel'] = false;
            $request['country'] = $order_info['CountryCode'];
            $request['fullName'] = $order_info['consignee'];
            $request['email'] = $order_info['email'];
            $request['addr1'] = $order_info['street1'];
            $request['addr2'] = ' '.$order_info['street2'];
            $request['city'] = $order_info['city'];
            $request['state'] = $order_info['state'];
            $request['zip'] = $order_info['zipcode'];
            $request['phone'] = $order_info['tel'];
            $request['typeCode'] = $code;
            $request['memo'] = '';
            $goods_info = $this->order_goods_info($id[$i]);
            $weight = 0;  
            if(CFG_DECLARED_ORDER_QTY_1){
                //全部使用默认
                $goods_name = $goodsvalue['goods_name']; 
                $goods_price = $goodsvalue['goods_price'];
                $total_qty = 1;
                $dec_name = CFG_DEC_NAME;
                $Declared_weight = CFG_DECLARED_WEIGHT;
                $Declared_value = $dec_name; 
                $goods = 
                   array(
                    'proName'      => $Declared_value,
                    'qnt'    => '1',
                    'sku' => $goodsvalue['goods_sn']
                );
                
                
                $request['weight'] = CFG_DECLARED_WEIGHT;     
            }else{
                foreach($goods_info as $key => $goodsvalue){ 
                    if(CFG_IMPORT_CUSTOMS){
                        //多个产品    
                        //优先使用导入产品信息
                        $goods_name = $goodsvalue['goods_name']; 
                        $goods_price = $goodsvalue['goods_price'];
                        $total_qty = $goodsvalue['goods_qty'];
                        $dec_name = ($goods_name <> '') ? $goods_name : CFG_DEC_NAME;
                        $Declared_weight = ($goodsvalue['goods_weigth'] <> 0) ? $goodsvalue['goods_weigth']*$total_qty : CFG_DECLARED_WEIGHT;
                        $Declared_value = ($goods_price <> 0) ? $goods_price : CFG_DECLARED_VALUE; 
                        $goods[] = array(
                            'proName'      => $Declared_value,
                            'qnt'    => $goodsvalue['goods_qty'],
                            'sku' => $goodsvalue['goods_sn']
                        );     
                    }else{
                        $getgoods = $modelgoods->goods_info('',$goodsvalue['goods_sn']);
                        //有产品库的订单产品
                        if(count($getgoods)>0){ 
                            $goods_name = $getgoods['dec_name'];
                            $goods_name_cn = $getgoods['dec_name_cn'];
                            $item_no = $goodsvalue['item_no'];
                            $item_sn = $goodsvalue['goods_sn'];
                            $goods_price = $getgoods['Declared_value'];
                            $goods_weigth = $getgoods['Declared_weight'];   
                            $dec_name = $goods_name == '' || $goods_name == NULL   || !$goods_name ? CFG_DEC_NAME : $goods_name;
                            
                            
                            $Declared_weight = ($goods_weigth > 0) ? $goods_weigth : CFG_DECLARED_WEIGHT;
                            $Declared_value = ($goods_price > 0) ? $goods_price : CFG_DECLARED_VALUE;
                            $goods[] = array(
                                'proName'      => $dec_name,
                                'qnt'    => $goodsvalue['goods_qty'],
                                'sku' => $goodsvalue['goods_sn']
                            );  
                        }else{
                            $CustomsTitleEN = $getgoods['dec_name'] == '' ? CFG_DEC_NAME : $getgoods['dec_name'].'  '.$goodsvalue['goods_sn'].'&'.$goodsvalue['goods_qty'];
                            $Declared_weight = CFG_DECLARED_WEIGHT;
                            $Declared_value = CFG_DECLARED_VALUE;
                        }
                        $weight += $Declared_weight*$goodsvalue['goods_qty']; 
                    }       
                }
                $request['weight'] = $weight;
            }
            
            /****2014 - 06 - 04  nic  修复提交最大报关价值****/
            $dec_value = $Declared_value*$goodsvalue['goods_qty'];
            if(CFG_DECLARED_MAX <> 0 || CFG_DECLARED_MAX <> NULL || CFG_DECLARED_MAX <> '' ){
                if($dec_value > CFG_DECLARED_MAX){
                   $dec_value = CFG_DECLARED_MAX; 
                }
            }
            
            
            $request['decValue'] = $dec_value;

             $url = "http://www.sunyou.hk/api/create_order.htm";
            
            $request['item']  =  $goods;
            
             $data_string = json_encode($request);
             
            $post_header = array('SunYou-Token: '.CFG_TOKEN_SY, 'Content-Type: application/json; charset=utf-8', 'Content-Length: ' . strlen($data_string));
                
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, 'http://www.sunyou.hk/api/create_order.htm');      
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);     
            curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");              
            curl_setopt($curl, CURLOPT_HTTPHEADER, $post_header);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);

            $result = curl_exec($curl);
            curl_close($curl) ;
            
            $result = json_decode($result,true);
            
           if($result['result']['statusCode'] == 100 && $result['result']['obj']['trNum']){
                    $this->db->update(CFG_DB_PREFIX.'order',array('track_no' => $result['result']['obj']['trNum'],'track_no_2' => $result['result']['obj']['serNum']),'order_id ='.$id[$i]);
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].' '.$result['result']['msg'].'</br>';
           }else{
                $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].$result['result']['msg'].'</br>';                   
           }
        }
        return  $msg;
    }
    /**
    * 使用了cURL库发送 xml 内容
    */
   function send( $str_xml, $str_url,$boo_ssl = false )
   {
      $str_header  = "POST {$str_url} HTTP/1.0 \r\n";
      $str_header .= "MIME-Version: 1.0 \r\n";
      $str_header .= "Content-type: text/xml \r\n";
      $str_header .= "Content-length: " . strlen($str_xml) . " \r\n";
      $str_header .= "Content-transfer-encoding: text \r\n";
      $str_header .= "Request-number: 1 \r\n";
      $str_header .= "Document-type: Response\r\n";
      $str_header .= "Interface-Version: Site 1.0 \r\n";
      $str_header .= "Connection: close \r\n\r\n";
      $str_header .= $str_xml;

      $res_curl = curl_init();
      curl_setopt($res_curl, CURLOPT_URL, $str_url);
      curl_setopt($res_curl, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($res_curl, CURLOPT_TIMEOUT, 30);   
      curl_setopt($res_curl, CURLOPT_CUSTOMREQUEST, $str_header);
      curl_setopt($res_curl, CURLOPT_FOLLOWLOCATION, 1);
     
      if ( $boo_ssl ) {
         curl_setopt($res_curl, CURLOPT_SSL_VERIFYHOST,  0);
         curl_setopt($res_curl, CURLOPT_SSL_VERIFYPEER, false);
      }
     
      $str_data = curl_exec($res_curl);
      if ( curl_errno($res_curl) ) {
         trigger_error(curl_error($res_curl), E_USER_ERROR);
      } else {
         curl_close($res_curl);
      }
     
      return $str_data;
   }
    function destreet($street)
    {
        $token = str_replace ('.', '. ', $street);
        $token = addslashes($token);
        $token = str_replace ('strasse', 'str.', $token);
        $token = str_replace ('straße', 'str.', $token);
        $token = str_replace ('Straße', 'Str.', $token);
        $token = str_replace ('Strasse', 'Str.', $token);
        $token = $this->utf8_str_word_count(htmlentities ($token), 1, '0123456789.&auml;&ouml;&uuml;&Auml;&Ouml;&Uuml;\\/');
        $Strasse=''; $Hausnr=''; $HausnrModus=false;
        foreach($token as $v1) {
          if (strspn ($v1, '0123456789')!= 0) {$HausnrModus = true;};
          if ($HausnrModus==true) {$Hausnr .= $v1.' ';} else {$Strasse .= $v1.' ';};
        };
        $info[1] = trim($Hausnr);
        $token = trim($Hausnr, '0123456789');
        $info[0] = trim(html_entity_decode($Strasse));
        return $info;
    }
    
    function utf8_str_word_count($string,$format=0,$charlist='') {
        $array = preg_split("/[^'\-A-Za-z".$charlist."]+/u",$string,-1,PREG_SPLIT_NO_EMPTY);
        switch ($format) {
        case 0:
            return(count($array));
        case 1:
            return($array);
        case 2:
            $pos = 0;
            foreach ($array as $value) {
            $pos = $this->utf8_strpos($string,$value,$pos);
            $posarray[$pos] = $value;
            $pos += $this->utf8_strlen($value);
            }
            return($posarray);
        }
    }
    function utf8_strpos($str, $search, $offset = FALSE) {
         if(strlen($str) && strlen($search)) {
              if ( $offset === FALSE ) {
                   return mb_strpos($str, $search);
              } else {
                   return mb_strpos($str, $search, $offset);
             }
        } else
         return FALSE;
    }
    function utf8_strlen($str) {
        $count = 0;
        for($i = 0; $i < strlen($str); $i++){
        $value = ord($str[$i]);
        if($value > 127) {
        $count++;
        if($value >= 192 && $value <= 223) $i++;
        elseif($value >= 224 && $value <= 239) $i = $i + 2;
        elseif($value >= 240 && $value <= 247) $i = $i + 3;
        else die('Not a UTF-8 compatible string');
        }
        $count++;
        }
        return $count;
    }
}
?>
