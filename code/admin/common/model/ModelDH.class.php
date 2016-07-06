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
 * @copyright Copyright (c) 2012 - 2015 ECPP
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
 class ModelDH extends ModelOrder
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
    /**
     * 获取授权的地址
     */
    function geturl($info){
        $redirect_uri = 'http://www.cpowersoft.com/api/dh/erp_getCode.php';
        $get_code_url = "https://secure.dhgate.com/dop/oauth2/authorize?response_type=code&client_id=MCGdMLWOXKV4V0BEO9wU&redirect_uri=".$redirect_uri."&scope=basic&state=ok&display=page";
        return $get_code_url;
    }
    function updateDhAccount($account_name,$id){
        

        $this->db->update(CFG_DB_PREFIX.'ebay_account',array('account_name' => $account_name),'id='.$id);    
    }
    /**
     * refresh_token换取access_token
     *
     * @param array $info  array('appkey','appSecret','refresh_token','id')
     * @return string  (access_token)
     */
    function refreshChangeAccess($info){
        
        $client_id = 'MCGdMLWOXKV4V0BEO9wU';
        $client_secret = 'aQm6qUhGo6Cb7gu3VY9HRbsHGIuaa2Og';
        $curlPost = array(
            'grant_type' => 'refresh_token',
            'client_id' => $client_id,
            'client_secret' => $client_secret,
            'refresh_token' => $info['refresh_token'], 
            'scope' => 'basic'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
        curl_setopt($ch, CURLOPT_URL,'https://secure.dhgate.com/dop/oauth2/access_token');
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        $time = time()+3600;
        $time = time()+ (60*60*24);
        $fp = fopen( CFG_PATH_DATA.'ebay/dh_'.$info['id'].'.php','w');
        fputs($fp, '<?php'. chr(10) . ' $access_token =\''.$result['access_token'].'\';'.chr(10).' $refresh_token =\''.$result['refresh_token'].'\';'.chr(10).' $APIDevUserID =\''.$client_id.'\';'.chr(10). ' $APIPassword =\''.$client_secret.'\';'.chr(10). ' $passtime = '.$time.';'.chr(10).' $longpasstime = '.($time*30).';'.chr(10). '?>');
        fclose($fp);
        return $result['access_token'];
    }
    /**
     * 加载dh订单
     *
     * @param array $info
     * @return string
     */
    function loadorder($info,$starttime=null,$endstart=null,$account_name=null)
    {
     
        set_time_limit(300);
        require_once(CFG_PATH_DATA . 'ebay/dh_' . $info['id'] .'.php');
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(                                
                'refresh_token'=>$refresh_token,
                'id'=>$info['id'],
                'longpasstime'=>$longpasstime
            ));
        }
        
        
        
        
        
        
        /*$curlPost = array(
            'access_token' => $access_token,
            'method' => 'dh.shipping.types.get',
            'timestamp' => time().'000',
            'v' => '1.0'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串            
        curl_setopt($ch, CURLOPT_URL,'http://api.dhgate.com/dop/router');
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        
        return var_dump($result);*/
        
        
        
        
        
        $loadarr = array();
        if($info['111000'] == 'true') $loadarr[] = '111000';
        if($info['101003'] == 'true') $loadarr[] = '101003';
        if($info['102001'] == 'true') $loadarr[] = '102001';
        if($info['103001'] == 'true') $loadarr[] = '103001';
        if($info['105001'] == 'true') $loadarr[] = '105001';
        if($info['105002'] == 'true') $loadarr[] = '105002';
        if($info['105003'] == 'true') $loadarr[] = '105003';
        if($info['105004'] == 'true') $loadarr[] = '105004';
        if($info['103002'] == 'true') $loadarr[] = '103002';
        if($info['101009'] == 'true') $loadarr[] = '101009';
        if($info['106001'] == 'true') $loadarr[] = '106001';
        if($info['106002'] == 'true') $loadarr[] = '106002';
        if($info['106003'] == 'true') $loadarr[] = '106003';
        if($info['102006'] == 'true') $loadarr[] = '102006';
        if($info['102111'] == 'true') $loadarr[] = '102111';
        if($info['111111'] == 'true') $loadarr[] = '111111';
        
        $page = 1;
        $statusStr = implode(',',$loadarr); 
        $curlPost = array(
            'access_token' => $access_token,
            'method' => 'dh.order.list.get',
            'timestamp' => time().'000',
            'v' => '1.1', 
            'startdate' => $info['start'].' 00:00:00',
            'enddate' => $info['end'].' 23:59:59',
            'pagesize' => 50,
            'pages' => $page,
            'statusList' => $statusStr
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串            
        curl_setopt($ch, CURLOPT_URL,'http://api.dhgate.com/dop/router');
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
         
       
        if($result['status']['message'] == 'OK'){
            $str .= $this->savedhorder($result['rfxlist'],$info['id'],'',$info['start'].' 00:00:00',$info['end'].' 23:59:59');
            if($result['sumPage'] > 1){
                for($page=2;$j<$result['sumPage'];$page++){
                    $curlPost = array(
                        'access_token' => $access_token,
                        'method' => 'dh.order.list.get',
                        'timestamp' => time().'000',
                        'v' => '1.1', 
                        'startdate' => $info['start'].' 00:00:00',      
                        'enddate' => $info['end'].' 23:59:59',
                        'pagesize' => 50,
                        'pages' => $page,
                        'statusList' => $statusStr
                    );
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串            
                    curl_setopt($ch, CURLOPT_URL,'http://api.dhgate.com/dop/router');
                    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
                    $re=curl_exec($ch);
                    curl_close($ch);
                    $result = json_decode($re,true);
                    $str .= $this->savedhorder($result['rfxlist'],$info['id'],'',$info['start'].' 00:00:00',$info['end'].' 23:59:59');
                }
            }    
        }    
        return '同步结束';
    } 
    function ChangeDHStatus($status){
        
        switch($status)
        {              
            case '105001':
            return '买家申请退款，等待协商结果';
            case '103001':
            return '等待发货';
            case '102001':
            return '买家已付款，等待平台确认';
            case '101003':
            return '等待买家付款';
            case '111000':
            return '订单取消';
            case '111111':
            return '交易关闭';
            case '102111':
            return '交易成功';
            case '102006':
            return '已确认收货';
            case '106003':
            return '协议已达成，执行中';
            case '106002':
            return '买家投诉到平台';
            case '106001':
            return '退款/退货协商中，等待协议达成';
            case '101009':
            return '等待买家确认收货';
            case '103002':
            return '已部分发货';
            case '105004':
            return '买家取消退款申请';
            case '105003':
            return '部分退款后，等待发货';
            case '105002':
            return '退款协议已达成';
            default:
            return NULL;
        }
    }           
    
    /**
     * 保存订单
     * @param array $orders
     * @param int $id
     * @param bool $isload
     *
     */
    function savedhorder($orders,$id,$country=NULL,$start,$end){
        set_time_limit(50000);
        include(CFG_PATH_DATA . 'ebay/dh_' . $id .'.php');
        include(CFG_PATH_DATA . 'dd/currency.php');
        $goodob = new ModelGoods();
        try { 
            $orderObj = new ModelOrder();
            for($i = 0;$i < count($orders);$i++){
                $string = '';
                $orderid = $this->db->getValue("SELECT order_id,ali_status,order_status  FROM ".$this->tableName." WHERE Sales_account_id =".$id." and paypalid='".$orders[$i]['rfxno']."'");
                $dhstatus = $orders[$i]['rfxstatusid'];
                $getinfo = $this->getUserid($orders[$i]['rfxno'],$start,$end,$access_token);
                if($orderid < 1){       
                    if($dhstatus == '101009' or $dhstatus == '103002'){
                        $orderstatus = 139; //已发货订单
                    }else if($dhstatus == '111111' or $dhstatus == '111000' or $dhstatus == '102111'){
                        $orderstatus = 131; //已完成订单
                    }else if($dhstatus == '102001' or $dhstatus == '105001'){
                        $orderstatus = 116; //资金未到账 默认客服审核失败
                    }else{
                        $orderstatus = 112; //默认待客服审核订单
                    }
                    /*switch($orders[$i]['rfxstatusid'])
                    {              
                        case '105001':
                        return '买家申请退款，等待协商结果';
                        case '103001':
                        return '等待发货';
                        case '102001':
                        return '买家已付款，等待平台确认';
                        case '101003':
                        return '等待买家付款';
                        case '111000':
                        return '订单取消';
                        case '111111':
                        return '交易关闭';
                        case '102111':
                        return '交易成功';
                        case '102006':
                        return '已确认收货';
                        case '106003':
                        return '协议已达成，执行中';
                        case '106002':
                        return '买家投诉到平台';
                        case '106001':
                        return '退款/退货协商中，等待协议达成';
                        case '101009':
                        return '等待买家确认收货';
                        case '103002':
                        return '已部分发货';
                        case '105004':
                        return '买家取消退款申请';
                        case '105003':
                        return '部分退款后，等待发货';
                        case '105002':
                        return '退款协议已达成';
                        default:
                        return NULL;
                    }*/  
                    $content = '';
                    $string .= '同步订单'.$orders[$i]['rfxno'];
                    $order_sn = $this->get_order_sn();
                    $this->db->insert(CFG_DB_PREFIX.'order', array(
                        'order_sn' => $order_sn,
                        'userid' => $getinfo['userid'],
                        'order_amount' => $orders[$i]['ordertotal'],
                        'currency' => 'USD',
                        'rate' => $currency[$orders[$i]['payAmount']['currencyCode']],
                        'shipping_fee' => $orders[$i]['shipcost'],   
                        'ShippingService' => addslashes_deep($orders[$i]['shippingtype']),
                        'Sales_account_id' => $id,
                        'Sales_channels' => 8,
                        'paypalid' => $orders[$i]['rfxno'],
                        'consignee' => addslashes_deep($orders[$i]['firstname'].$orders[$i]['lastname']),
                        'email' => addslashes_deep($orders[$i]['email']),
                        'street1' => addslashes_deep($orders[$i]['addressline1']),
                        'street2' => addslashes_deep($orders[$i]['city']),          
                        'city' => addslashes_deep($orders[$i]['city']),
                        'state' => addslashes_deep($orders[$i]['state']),
                        'order_status' => $orderstatus,
                        'country' => addslashes_deep($orderObj->getCountry($orders[$i]['country'])),
                        'CountryCode' => $orders[$i]['country'],  
                        'zipcode' => addslashes_deep($orders[$i]['postalcode']),
                        'tel' => $orders[$i]['tel'],
                        'pay_note' => $getinfo['pay_note'],
                        'paid_time' => substr($orders[$i]['payConfirmDate'],0,10), //paydate
                        'add_time' => CFG_TIME
                    ));    
                    $order_id = $this->db->getInsertId();
                    $ch = curl_init("http://api.dhgate.com/dop/router?access_token=".$access_token."&method=dh.order.product.get&timestamp=".time()."000"."&v=1.1&orderNo=".$orders[$i]['rfxno']."&rfxid=".urlencode($orders[$i]['rfxid'])); 
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true) ; 
                    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true) ;
                    $re=curl_exec($ch);
                    curl_close($ch);
                    $info = json_decode($re,true);
                    
                    if($info['status']['message'] == 'OK'){
                       for($productIte=0;$productIte<count($info['rfxProductVO2']);$productIte++){
                           
                            $this->db->insert($this->infotableName, array(
                                'order_id' => $order_id,
                                'goods_sn' => addslashes_deep($this->getRealSKU($info['rfxProductVO2'][$productIte]['skuCode'])),
                                'sn_prefix' => $sn_prefix,
                                'item_no' => $info['rfxProductVO2'][$productIte]['itemcode'],
                                'goods_name' => addslashes_deep($info['rfxProductVO2'][$productIte]['productName']),
                                'goods_weigth' => $info['rfxProductVO2'][$productIte]['grossweight'],
                                'goods_qty' => $info['rfxProductVO2'][$productIte]['productCount'],
                                'goods_price' => $info['rfxProductVO2'][$productIte]['targetprice'],
                                'good_line_img' => addslashes_deep($info['rfxProductVO2'][$productIte]['productImage']),
                                'ali_logistic' => addslashes_deep($info['rfxProductVO2'][$productIte]['productUrl']),
                                'ali_note' => addslashes_deep($info['rfxProductVO2'][$productIte]['productRemark']), 
                                'TransactionID' => $info['rfxProductVO2'][$productIte]['itemcode']
                                ));
                           
                            $string .= ',（ '.count($info['rfxProductVO2']).' ）产品';
                            /*return var_dump(array(
                                'order_id' => $order_id,
                                'goods_sn' => addslashes_deep($this->getRealSKU($info['rfxProductVO2'][$productIte]['skuCode'])),
                                'item_no' => addslashes_deep($info['rfxProductVO2'][$productIte]['itemcode']),
                                'goods_name' => addslashes_deep($info['rfxProductVO2'][$productIte]['productName']),
                                'goods_weight' => $info['rfxProductVO2'][$productIte]['grossweight'],
                                'Attribute_note' => '',
                                'goods_qty' => $info['rfxProductVO2'][$productIte]['productCount'],
                                'goods_price' => $info['rfxProductVO2'][$productIte]['targetprice'],
                                'good_line_img' => addslashes_deep($info['rfxProductVO2'][$productIte]['productImage']),
                                'ali_logistic' => addslashes_deep($info['rfxProductVO2'][$productIte]['productUrl']),
                                'ali_note' => addslashes_deep($info['rfxProductVO2'][$productIte]['productRemark']),
                            ));*/         
                       }                         
                    ob_flush();
                    flush();
                    echo '<div style="color:#535353;font-size:12px;line-height:25px;float:left;width:25%">'.$string.'</div>';
                }else{
                    
                }
                }
            }
        }
        catch(Exception $e) 
        {            
            throw new Exception($e->getMessage(),'002');exit();
        }
        return $string;
    }
    function getUserid($order_id,$start,$end,$access_token){
        $curlPost = array(
            'access_token' => $access_token,
            'method' => 'dh.order.list.get',
            'timestamp' => time().'000',
            'v' => '1.2', 
            'startDate' => $start,
            'endDate' => $end, 
            'orderNo' => $order_id 
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串            
        curl_setopt($ch, CURLOPT_URL,'http://api.dhgate.com/dop/router');
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        if($result['status']['message'] == 'OK'){ 
            return array(
                'userid' => $result['rfxlist2'][0]['buyerNickname'],
                'pay_note' => $result['rfxlist2'][0]['orderRemark']
            );
        }        
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
     * 标记发货
     * @param int $order_id
     */
    function orderMark($order_id,$id = NULL){
        set_time_limit(300);
        if(empty($id)) $id = $this->getSaleaccIdByOid($order_id);
        require_once(CFG_PATH_DATA . 'ebay/dh_' . $id .'.php');
        if(time() > $longpasstime) 
        {  
            $url = $this->geturl($info); 
            return array('reauth' => 'reauth' , 'url'=>$url);
        }    
        //验证actoken是否过期,过期则更换重写缓存文件
        if(time() > $passtime) 
        {
            $access_token = $this->refreshChangeAccess(array(                                
                'refresh_token'=>$refresh_token,
                'id'=>$id,
                'longpasstime'=>$longpasstime
            ));
        }
        $orderinfo = $this->db->getValue('select paypalid,track_no,order_sn,shipping_id,ShippingService from myr_order where order_id = '.$order_id);
        $shipname  = $this->db->getValue('SELECT value,name from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$orderinfo['shipping_id']);
        $shiptype ='';
        if($shipname['name'] !== ''){
            $ServiceName = $orderinfo['ShippingService']; 
        }else{
            $arr  = $this->db->getValue('SELECT value,name from '.CFG_DB_PREFIX.'shipping_mark where express_id ='.$orderinfo['shipping_id']);
            if($arr['name'] == ''){
                if($arr['value'] == 'EUB' || $shiptype == 'EUB-1') $ServiceName = 'CHINAPOSTAIR';
            }else{
                $ship = ModelDd::getArray('shipping');
                $Name = $ship[$orderinfo['shipping_id']];
                $ServiceName = 'CHINAPOSTAIR';    
                       
            }
        }
        $curlPost = array(
            'access_token' => $access_token, 
            'method' => 'dh.order.delivery.save', 
            'timestamp' => time().'000',
            'v' => '1.1',
            'deliveryRemark' => '',
            'delvieryState' => 1,
            'rfxNo' => $orderinfo['paypalid'],
            'shippingType' => $ServiceName,  
            'trankNo' => $orderinfo['track_no']
        );                                                                 
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//接收结果为字符串
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  //https请求必须加上此项
        curl_setopt($ch, CURLOPT_URL,'http://api.dhgate.com/dop/router');
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($curlPost));
        $re=curl_exec($ch);
        curl_close($ch);
        $result=json_decode($re,true);
        //return var_dump($result);
        $this->db->execute('update myr_order set is_mark = 1 where order_id ='.$order_id);
        if($result['status']['message'] == 'OK'){
            return '订单'.CFG_ORDER_PREFIX.$orderinfo['order_sn'].'标记成功!<br/>'; 
            
        }else{
            return  '订单'.CFG_ORDER_PREFIX.$orderinfo['order_sn'].'标记失败!'.'错误码:'.$result['status']['subErrors'][0]['code'].','.$result['status']['subErrors'][0]['message'].'!<br/>';
        }                                                                                 
    }
    /**
     * 批量Aliexpress标记发货
     * @param int $order_id
     */
    function orderMarks($account_id,$status,$where=NULL){
        $query = 'select order_id,userid,Sales_account_id,track_no,shipping_id from '.$this->tableName. ' where order_status in( '.$status.' )';
        $account = ModelDd::getArray('dhaccount');
        $acountlist = implode(",",array_keys($account));
        $query .= ' and Sales_account_id in ('.$account_id.')';
        $query .= " and Sales_channels = 8 and track_no <> '' and is_mark = 0 ".$where;
        $this->db->open($query);
        $result = '';
        while ($rs = $this->db->next()) {
            $result .= $this->orderMark($rs['order_id'],$account_id);
        }
        return $result;
    }
 }
 
 
 
 
?>