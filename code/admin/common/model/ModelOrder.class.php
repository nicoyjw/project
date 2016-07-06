<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 订单操作类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelOrder extends Model {
    
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
     * 获取Paypal单据
     *
     * @param string $info
     * @return array  $list
     */
    function getPaypalorder($info)
    {
        $list = array();
        $this->db->open("SELECT * FROM ".CFG_DB_PREFIX . "paypal_transaction WHERE paypal_id = '".$info['id']."' and L_TIMESTAMP between '".$info["start"].'T00:00:00.000Z'."' and '".$info["end"].'T24:00:00.000Z'."'");
        while ($rs = $this->db->next()) {
            $list[] = $rs;
        }
        return $list;
    }

    /*****
    *$pid paypalid  $accountid Ebayid
    *****/
    function getOrderpaypal($pid,$PayPalEmailAddress)
    {
        require(CFG_PATH_DATA . 'ebay/' . $PayPalEmailAddress .'.php');
        $data['API_UserName']=$API_USERNAME;
        $data['API_Password']=$API_PASSWORD;
        $data['API_Signature']= $API_SIGNATURE;
        return $this->paypaltransaction($pid,$data);
    }
    
    /**************
    **paypal交易流水明细
    **************/
    function paypaltransaction($paypalid,$data)
    {
        if(!function_exists(PPHttpPost)) require(CFG_PATH_LIB . 'ebay/paypalrequire.php');
        $nvpStr =    "&TRANSACTIONID=$paypalid";
        return PPHttpPost("gettransactionDetails",$nvpStr,$data);
    }
    
    /**************
    **paypal balance
    **************/    
    function getPaypalbalance($info)
    {
        $email = $this->db->getValue("SELECT paypal_account FROM ".CFG_DB_PREFIX."paypal_account where p_root_id = ".$info['id']);
        require(CFG_PATH_DATA . 'ebay/' . $email .'.php');
        $data['API_UserName']=$API_USERNAME;
        $data['API_Password']=$API_PASSWORD;
        $data['API_Signature']= $API_SIGNATURE;
        require_once(CFG_PATH_LIB . 'ebay/paypalrequire.php');
        $nvpStr = "";
        $resArray = PPHttpPost("GetBalance",$nvpStr,$data);
        $list = array();
        $i =0;
        while(isset($resArray["L_AMT".$i])){
            $detail['L_AMT'] = $resArray["L_AMT".$i];
            $detail['L_CURRENCYCODE'] = $resArray["L_CURRENCYCODE".$i];
            $list[] = $detail;
            $i++;
        }
        return $list;
    }
    
    /**
     * 保存订单录入和修改
     *
     * @param string $info
     */

    function saveOrder($info){
        require(CFG_PATH_DATA . 'dd/currency.php');
        $currency['RMB'] = 1;
        $currency['CNY'] = 1;
        $info['paid_time'] = MyDate::transform('timestamp',$info['paid_time']);
            try {
            $this->db->insert($this->tableName, array(
                        'order_sn' => $info['order_sn'],
                        'userid' => $info['userid'],
                        'order_amount' => $info['order_amount'],
                        'currency' => $info['currency'],
                        'rate' =>$currency[$info['currency']],
                        'shipping_fee' => $info['shipping_fee'],
                        'Sales_account_id' => $info['Sales_account_id'],
                        'sellerID' => ($info['sellerID'])?$info['sellerID']:(ModelDd::getCaption('allaccount',$info['Sales_account_id'])),
                        'Sales_channels' => $info['Sales_channels'],
                        'order_status' => $info['order_status'],
                        'shipping_id' => $info['shipping_id'],
                        'paypalid' => $info['paypalid'],
                        'pay_id' => $info['pay_id'],
                        'FEEAMT' => $info['FEEAMT'],
                        'consignee' => $info['consignee'],
                        'email' => $info['email'],
                        'street1' => $info['street1'],
                        'street2' => $info['street2'],
                        'city' => $info['city'],
                        'CountryCode' => $info['CountryCode'],
                        'state' => $info['state'],
                        'country' => $info['country'],
                        'zipcode' => $info['zipcode'],
                        'tel' => $info['tel'],
                        'track_no' => $info['track_no'],
                        'sales_site' => $info['sales_site'],
                        'sellsrecord' => $info['sellsrecord'],
                        'ShippingService' => $info['ShippingService'],
                        'paid_time' => $info['paid_time'],
                        'pay_note' => $info['pay_note'],
                        'add_time' => CFG_TIME
                        ));
                    $order_id = $this->db->getInsertId();
                    $this->db->update(CFG_DB_PREFIX . 'paypal_order',array(
                                    'status'=>1
                                    ),"paypalid ='".$info['paypalid']."'");
                        } catch (Exception $e) {
                    throw new Exception('保存订单失败,订单号为'.CFG_ORDER_PREFIX.$info['order_sn'],'999');exit();
                }
            foreach($info['data'] as $goods){
                    try{
                    $this->db->insert($this->infotableName, array(
                                'order_id' => $order_id,
                                'goods_sn' => $this->getRealSKU($goods->goods_sn),
                                'item_no' => $goods->item_no,
                                'goods_name' => $goods->goods_name,
                                'goods_qty' => $goods->goods_qty,
                                'goods_price' => $goods->goods_price,
                                'sn_prefix' =>$goods->sn_prefix,
                                'TransactionID' => CFG_TIME.mt_rand(10,99)
                                ));
                                } catch (Exception $e) {
                            throw new Exception('保存订单明细失败,订单号'.CFG_ORDER_PREFIX.$info['order_sn'],'999');exit();
                        }        
            }
            if(isset($info['from_order_id']) && $info['from_order_id'] <>''){//
                $this->changeporder($info['from_order_id']);//paypal流水
                $this->db->execute("update ".CFG_DB_PREFIX."rma set new_order_sn='".$info['order_sn']."',rma_status = 1  where new_order_sn = '' and order_id=".$info['from_order_id']);//更新退换货单
                }
            $this->changedepot($info['shipping_id'],$order_id);
            $this->save_order_log($order_id,'新增订单','添加订单');
            return $order_id;
    }
    /********
    **修改订单产品
    ********/
    function savegoods($info){
        if($this->db->getValue('SELECT order_status FROM '.$this->tableName.' where order_id = '.$info['order_id']) == 131) {throw new Exception('订单已处于OOO状态无法更改','999');exit();}
            foreach($info['data'] as $goods){
                if($goods->rec_id == 0){
                    try{
                    $this->db->insert($this->infotableName, array(
                                'order_id' => $info['order_id'],
                                'goods_sn' => $this->getRealSKU($goods->goods_sn),
                                'item_no' => $goods->item_no,
                                'goods_name' => $goods->goods_name,
                                'goods_qty' => $goods->goods_qty,
                                'goods_weigth' => $goods->goods_weigth,
                                'goods_price' => $goods->goods_price,
                                'sn_prefix' =>$goods->sn_prefix,
                                'TransactionID' => CFG_TIME.mt_rand(10,99)
                                ));
                                $this->save_order_log($info['order_id'],'新增订单产品','新增订单产品'.$goods->goods_name);
                                } catch (Exception $e) {
                            throw new Exception('保存订单明细失败,订单号'.CFG_ORDER_PREFIX.$info['order_sn'],'999');exit();
                        }
                }else{
                    try{
                    $this->db->update($this->infotableName, array(
                                'order_id' => $info['order_id'],
                                'goods_sn' => $this->getRealSKU($goods->goods_sn),
                                'item_no' => $goods->item_no,
                                'goods_name' => $goods->goods_name,
                                'goods_qty' => $goods->goods_qty,
                                'goods_weigth' => $goods->goods_weigth,
                                'sn_prefix' =>$goods->sn_prefix,
                                'goods_price' => $goods->goods_price
                                ),'rec_id='.intval($goods->rec_id));
                                $this->save_order_log($info['order_id'],'编辑订单产品','编辑订单产品'.$goods->goods_name);
                                } catch (Exception $e) {
                            throw new Exception('保存订单明细失败,订单号'.CFG_ORDER_PREFIX.$info['order_sn'],'999');exit();
                        }                
                }        
            }        
        }
    /**
     * 保持订单状态
     *
     * @param array $info
     * @return bool
     */

    function savestatus($info){
       
        if (empty($info['id'])) {
            $this->db->insert($this->statustableName,array(
                'status' => $info['status'],
                'next_id' => $info['next_id'],
                'hold_id' => $info['hold_id'],
                'refund_id' => $info['refund_id'],
                'fail_id' => $info['fail_id'],
                'pay_status' => $info['pay_status'],
                'shipping_status' => $info['shipping_status'],
                'start_end' => $info['start_end'],
                'is_show' => $info['is_show'],
                'description' => $info['description']
                ));
        } else {
            $this->db->update($this->statustableName,array(
                'status' => $info['status'],
                'next_id' => $info['next_id'],
                'hold_id' => $info['hold_id'],
                'refund_id' => $info['refund_id'],
                'fail_id' => $info['fail_id'],
                'pay_status' => $info['pay_status'],
                'shipping_status' => $info['shipping_status'],
                'start_end' => $info['start_end'],
                'is_show' => $info['is_show'],
                'description' => $info['description']
                ),'id='.intval($info['id']));
        }
        ModelDd::cacheorderStatus();
    }
    /***********************
    ******自动合并订单
    ***********************/
    function autocombine($where)
    {
        $orderlist  = $this->db->select('select m.street1,m.Sales_account_id,m.userid,m.email,m.order_id from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id '.$where.' group by m.order_id  order by '.$sort.' m.order_id desc');
        $idarr = array();
        $msg = '';
        for($i=0;$i<count($orderlist);$i++){
            if(in_array($orderlist[$i]['order_id'],$idarr)) continue;
            $ids = $this->db->select('select distinct m.order_id from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id '.$where.' and m.street1 = \''.addslashes_deep($orderlist[$i]['street1']).'\' and (m.Sales_account_id = \''.addslashes_deep($orderlist[$i]['Sales_account_id']).'\' and (m.userid = \''.addslashes_deep($orderlist[$i]['userid']).'\' or m.email = \''.addslashes_deep($orderlist[$i]['email']).'\'))');
            if(count($ids) > 1){
                 $this->combineorder(implode(",",$ids));//合并订单
                 $idarr = array_merge($idarr,$ids);
                 $msg .= '客户'.$orderlist[$i]['userid'].'合并了'.count($ids).'个订单<br>';
            }
        }
            return $msg;
    }
    /**
     * 合并订单
     *
     * @param string  $str 订单id字符串
     * @return bool
     */
    function combineorder($str){
        $order = explode(",",$str);
        $new_order = $order[0];
        $result = '';
        for($i=1;$i<count($order);$i++){
                    $this->db->open('select rec_id from '.$this->infotableName.' where order_id  = \''.$order[$i].'\' ');
                    $ids = '';
                    while ($rs = $this->db->next()) {
                        $ids .= ','.$rs['rec_id'];
                    }
                    $total = $this->db->getValue('SELECT sum(shipping_fee) as shipping_fee,sum(FEEAMT) as FEEAMT from '.$this->tableName.' where order_id in('.$str.')');
                    $ids = substr($ids,1);
                    try {
                            $this->db->insert(CFG_DB_PREFIX.'order_combined',array(
                                                            'root_id' => $new_order,
                                                            'order_id' => $order[$i]
                                                        ));
                    } catch (Exception $e) {
                            throw new Exception('插入合并订单信息表失败','992');exit();
                    }
                    try {
                            $this->db->execute("INSERT INTO ".$this->infotableName."(order_id,goods_sn,item_no,goods_name,goods_price,goods_qty,bid_count,StartPrice,TransactionID,ebay_orderid,ebay_CreatedDate,OrderLineItemID) (SELECT '".$order[0]."',goods_sn,item_no,goods_name,goods_price,goods_qty,bid_count,StartPrice,TransactionID,ebay_orderid,ebay_CreatedDate,OrderLineItemID from ".$this->infotableName." WHERE order_id='".$order[$i]."')");
                            $this->db->execute("UPDATE ".$this->tableName." SET order_status = 120 where order_id=".intval($order[$i]));
                            $total_goods = $this->db->getValue("SELECT sum(goods_price*goods_qty) as goods_total FROM ".$this->infotableName." WHERE order_id='".$order[0]."'");
                            $this->db->update($this->tableName,array(
                                    'order_amount' => $total['shipping_fee']+$total_goods,
                                    'shipping_fee' => $total['shipping_fee'],
                                    'FEEAMT' => $total['FEEAMT']
                            ),'order_id='. $order[0]);
                            if($this->check_rule($order[0],1)) $result .= '快递规则自动匹配失败';
                                    $content = $order[$i].'的'.$ids.'产品条目已被合并至订单'.$order[0];
                                    $result .= $content."<br>";
                                    $this->save_order_log($order[$i],'combine',$content);
                            } catch (Exception $e) {
                                    throw new Exception('插入订单产品失败','666');exit();
                            }
        }
        return $result;
    }

    /**
     * 拆分订单
     *
     * @param string  $str 订单id字符串
     * @return bool
     */
    function divideorder($str)
    {
        $order = explode(",",$str);
        $goods = new ModelGoods();
        $result = '';
        for($i=0;$i<count($order);$i++){
            $new_order_goods = array();
            $has_combine=0;
            $orderinfo = $this->order_info($order[$i]);
            $goodsinfo = $this->order_goods_info($order[$i]);
            for($j=0;$j<count($goodsinfo);$j++)
            {
                if($goodsinfo[$j][2] <> $goodsinfo[$j]['goods_sn']) {
                    $has_combine=1;
                    continue;
                }
                $goodid = $goods->getidBySKU($goodsinfo[$j]['goods_sn']);
                if(!$goodid) {
                    $new_order_goods[]=$goodsinfo[$j]['rec_id'];
                    continue;
                }
                $goods_info = $goods->getgoodsqty($goodid,$orderinfo['depot_id']);
                if(($goods_info['goods_qty']-$goods_info['varstock'])<$goodsinfo[$j]['goods_qty']){
                    $new_order_goods[]=$goodsinfo[$j]['rec_id'];
                    continue;
                    }        
            }
            if($has_combine == 1) {
                $result .= CFG_ORDER_PREFIX.$orderinfo['order_sn'].'订单包含组合产品请先手动拆分<br>';
                continue;
                }
            if(count($new_order_goods) == 0){
                $result .= CFG_ORDER_PREFIX.$orderinfo['order_sn'].'订单不需要拆分<br>';
                continue;
            }elseif(count($new_order_goods) == count($goodsinfo)){
                $result .= CFG_ORDER_PREFIX.$orderinfo['order_sn'].'订单全部缺货，不需拆分<br>';
                continue;
            }else{
                $order_sn = $this->get_order_sn();
                $this->db->execute("insert into ".$this->tableName." (order_sn,userid,Sales_account_id,shipping_id,currency,rate,sellerID,paypalid,consignee,email,street1,street2,city,state,country,CountryCode,zipcode,tel,sales_site,pay_note,sellsrecord,ShippingService,paid_time,add_time,order_status) (select '".$order_sn."',userid,Sales_account_id,shipping_id,currency,rate,sellerID,paypalid,consignee,email,street1,street2,city,state,country,CountryCode,zipcode,tel,sales_site,pay_note,sellsrecord,ShippingService,paid_time,add_time,order_status From ".$this->tableName." where order_id =".$order[$i].")");    
                $order_id = $this->db->getInsertId();
                $list = implode(",",$new_order_goods);
                $this->db->execute("UPDATE ".$this->infotableName." set order_id='".$order_id."' where rec_id in(".$list.")");
                $this->calculatefee($order_id);
                $this->calculatefee($order[$i]);
                $this->check_rule($order_id,1);
                $this->check_rule($order[$i],1);
                $result .= CFG_ORDER_PREFIX.$orderinfo['order_sn'].'订单拆分成功<br>';
                $this->save_order_log($order[$i],'拆分订单',CFG_ORDER_PREFIX.$orderinfo['order_sn'].'订单拆分成功，分拆订单为'.CFG_ORDER_PREFIX.$order_sn);
            }
            
        }
        return $result;
    }
    /*************
    ******计算订单费用
    *****param int $id
    *****
    ************/
    function calculatefee($id)
    {
        $goods_fee = $this->getordergoodsfee($id);
        $this->db->execute("update ".$this->tableName." set order_amount = (shipping_fee + ".$goods_fee.") where order_id = ".$id);
    }
    /*************
    ******计算订单产品总费用
    *****param int $id
    *****
    ************/
    function getordergoodsfee($id)
    {
        return $this->db->getValue("SELECT sum(goods_qty*goods_price) FROM ".$this->infotableName." where order_id = ".$id);;
    }
    
    function getordergoodscost($id)
    {
        return $this->db->getValue("SELECT sum(m.goods_qty*n.cost) FROM ".$this->infotableName." as m left join ".CFG_DB_PREFIX."goods as n on m.goods_sn = n.SKU where m.order_id =  ".$id);            
    }
    /**
     * 得到新订单号
     * @return  string
     */
    function get_order_sn()
    {
        /* 选择一个随机的方案 */
        /*mt_srand((double) microtime() * 1000000);
        $sn =  date('md') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
        if($this->db->getValue("SELECT count(*) from ".$this->tableName." where order_sn = '".$sn."'")>0){
            //echo CFG_ORDER_PREFIX.$sn."重复，重新生成订单号<br>";
            $sn = $this->get_order_sn();
            }
        return $sn;*/
        if(!isset($_SESSION['admin_id']) || empty($_SESSION['admin_id'])){
            $aid = '6';    
        }else{
            $aid = $_SESSION['admin_id'];    
        }        
        
        $sn =  date('md').$aid;
        $count = $this->db->getValue("select order_sn from myr_order WHERE order_sn LIKE '".$sn."%' order by order_sn desc");
        
        if($count) {
            $lastsn = $this->db->getValue("select max(order_sn) from ".$this->tableName." WHERE  order_sn LIKE '".$sn."%'");
            $new_sn = $sn.str_pad((substr($lastsn,strlen($sn)) + 1 ),strlen($sn)-1,'0',STR_PAD_LEFT);
        }else{
            $new_sn = $sn.str_pad(1,strlen($sn)-1,'0',STR_PAD_LEFT);
        }
        return $new_sn;
    }    

    /**
     * 订单日志
     *@param int $id 订单自增ID
     *@param string $action 操作
     *@param string $content 内容
     *@param int user_id 操作人id
     *@param int addtime 操作时间
     * @return  string
     */
    function save_order_log($id,$action,$content)
    {
            $this->db->insert($this->logtableName,array(
                'order_id' => $id,
                'action' => $action,
                'content' => $content,
                'user_id' => $_SESSION['admin_id'],
                'addtime' => CFG_TIME
            ));
    }    

    /**
     * 取待自动审核列表
     *
     */
    function waitCheckList()
    {
        $query = 'select order_id,userid,Sales_account_id,PayPalEmailAddress,paypalid,concat("'.CFG_ORDER_PREFIX.'",order_sn) as order_sn from '.$this->tableName. ' where order_status = 111 and Sales_channels =1';
        if($_SESSION['account_list'] != 'all') $query .= ' and Sales_account_id in ('.$_SESSION['account_list'].')';
        $this->db->open($query);
        $result = array();
        while ($rs = $this->db->next()) {
            $result[] = $rs;
        }
        return $result;
    }    

    /**
    *获取订单列表
    **/
    function getOrderList($from,$to,$where=null,$checkcombine=null,$getqty = 0,$split=0,$sort=null,$printsoft=null){
        
        //echo $where;
        if($sort){
            if(preg_match("/goods/i",$sort)){
                $sort = "p.".str_replace("goods","goods_sn",$sort);
            }elseif(preg_match("/stock_place/i",$sort)){
                $sort = "p.".str_replace("stock_place","stock_place",$sort);
            }else{
                $sort = 'm.'.$sort;
            }
        }else{
            $sort = 'p.goods_sn ASC';
        }
        if($printsoft){
            if($printsort == 'goods_sn'){
                $sort = 'p.'.$printsoft.' ASC';
            }else if($printsoft == 'paypalid'){
                $sort = 'm.'.$printsoft.' ASC';
            }else{
                $sort = $sort;
            }
        }
       
        $sort = str_replace(',','',$sort);
        $this->db->open('select m.order_id,m.order_sn,m.userid,m.shipping_id,m.depot_id,m.track_no,m.eubpdf,m.shipping_fee,m.pay_id,m.FEEAMT,m.order_amount,m.currency,m.Sales_channels,m.Sales_account_id,m.paypalid,m.PayPalEmailAddress,m.consignee,m.email,m.street1,m.street2,m.city,m.state,m.country,m.zipcode,tel,m.pay_note,note,m.ShippingService,m.paid_time,m.shipping_time,m.order_status,m.print_status,m.stockout_sn,
        p.goods_sn,p.stock_place from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id '.$where.' group by m.order_id  order by '.$sort,$from,$to);
        $result = array();
        while ($rs = $this->db->next()) {
            $rs['paid_time'] = MyDate::transform('date',$rs['paid_time']);
            $rs['shipping_time'] = MyDate::transform('date',$rs['shipping_time']);
            $rs['end_time'] = MyDate::transform('date',$rs['end_time']);
            $rs['has_rma'] = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."rma  where order_sn='".$rs['order_sn']."'");
            if($rs['Sales_channels'] == 4){
                //$rs['PrepareTime'] = date('Y-m-d',$rs['PrepareTime']);
            }else{
                $rs['has_msg'] = $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."ebaymessage  where SenderID='".addslashes($rs['userid'])."' and itemid in (select item_no from ".$this->infotableName." where order_id ='".$rs['order_id']."')");
            }
            
            $rs['has_fbk'] = $this->db->getValue("SELECT CommentType FROM ".CFG_DB_PREFIX."ebay_feedback  where order_id='".$rs['order_id']."'");
            $rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
            $goods = $this->order_goods_info($rs['order_id'],$split);
            /*if($checkcombine){
                $num = $this->db->getValue('select count(distinct m.order_sn) from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id '.$where.' and m.street1 = \''.addslashes_deep($rs['street1']).'\' and (m.Sales_account_id = \''.addslashes_deep($rs['Sales_account_id']).'\' and (m.userid = \''.addslashes_deep($rs['userid']).'\' or m.email = \''.addslashes_deep($rs['email']).'\'))');
                $rs['hasmore'] = ($num > 1)?1:0;
            }*/
            
            //$sstatus = $this->db->getValue("SELECT status FROM ".CFG_DB_PREFIX."trackinfo  where order_id='".$rs['order_id']."'");
            //$rs['track_status'] = $sstatus;
            $ordersize = $this->ordersize($rs['order_id']);
            $rs['size'] = $ordersize['l'].'*'.$ordersize['w'].'*'.$ordersize['h'];
            $rs['esweight'] = $ordersize['weight'];
            $goods_info = "";
            $stock_place = "";
            $modelgoods = new ModelGoods();
            for($i = 0;$i<count($goods);$i++){
                if($i != 0 ) {$goods_info .= '<br>';$stock_place .= '<br>';}
                $stock_place .= $goods[$i]['stock_place'];
                $goods_info .= $goods[$i]['goods_sn'];
                $goods_info .= ' & ';
                $goods_info .= $goods[$i]['goods_qty'];
                if($getqty){
                        $goodid = $modelgoods->getidBySKU($goods[$i]['goods_sn']);
                        $goodinfo = $modelgoods->getgoodsqty($goodid,$rs['depot_id']);
                        if(($goodinfo['goods_qty']-$goodinfo['varstock']) < $goods[$i]['goods_qty']) $goods_info .= '<font color=red>';
                        $goods_info .= ' * ';
                        $goods_info .= $goodinfo['goods_qty'];
                        $goods_info .= ' * ';
                        $goods_info .= $goodinfo['varstock'];
                        if(($goodinfo['goods_qty']-$goodinfo['varstock']) < $goods[$i]['goods_qty']) $goods_info .= '</font>';
                }
                $sku = json_decode($goods[$i]['Attribute_note'],true);
                //var_dump($sku['sku'][0]['pName']);
                //echo ' ('.$sku['sku']['pName'].':'.$sku['sku']['pValue'].') ';
                for($j=0;$j<count($sku['sku']);$j++){
                    if($sku['sku'][$j]['pName'] && $sku['sku'][$j]['pValue']) $goods_info .= ' ('.$sku['sku'][$j]['pName'].':'.$sku['sku'][$j]['pValue'].') ';
                }
            }
            $rs['goods'] = $goods_info;
            $rs['stock_place'] = $stock_place;
            
            $result[] = $rs;
        }
        return $result;
    }

    /**
     * 总数
     * @param string $where 条件
     * @return int
     */
    function getOrderCount($where=null) {
        return $this->db->getValue('select count(distinct m.order_sn) from '.$this->tableName.' as m left join '.$this->infotableName.' as p on m.order_id = p.order_id '.$where);
    }
    /**
     * 生成查询条件
     * @param array $info
     * @return string
     */
    function getWhere($info,$status=null,$ids=null,$shipping=null,$sort=null) {
        specConvert($info,array('keyword','account','keytype','timetype','key','salechannel','shipping','starttime','status','totime','is_check','end_time1','end_time2','shippingstatus'));
        $wheres = array();
        if ($info['keyword']) {
             $wheres[] = '(m.order_sn=\''.substr($info['keyword'],strlen(CFG_ORDER_PREFIX)).'\' or m.country=\''.$info['keyword'].'\' or m.userid like \'%'.$info['keyword'].'%\'  or m.paypalid like \'%'.$info['keyword'].'%\' or m.track_no=\''.$info['keyword'].'\' or m.sellsrecord=\''.$info['keyword'].'\')';
        }else{
            if ($info['account'] != 0) {
                $wheres[] = 'm.Sales_account_id=\''.$info['account'].'\'';
            }
            if ($info['salechannel'] != 0) {
                $wheres[] = 'm.Sales_channels=\''.$info['salechannel'].'\'';
            }
            if ($info['shipping'] != 0) {
                $wheres[] = 'm.shipping_id=\''.$info['shipping'].'\''; 
            }
            if (isset($info['shippings'])) {
                $wheres[] = 'm.shipping_id in ('.$info['shippings'].')';
            }
            if ($info['is_check']) {
                $wheres[] = 'm.is_check=\''.$info['is_check'].'\'';
            }
            if($info['notetype']){
                $wheres[] = ($info['notetype']==1)?"m.pay_note <> '' ":"m.pay_note = ''";
            }
            /*if($shipping){
                $wheres[] = 'm.shipping_id not in ('.$shipping.')';    
            }*/
            if($info['timetype'] == 3) $timefiled = 'add_time';
            else $timefiled = ($info['timetype'] == 2)?'end_time':'paid_time';
            if($info['end_time2'] <> "" && $info['end_time1'] <> "") $wheres[] = 'm.end_time between \''.MyDate::transform('timestamp',$info['end_time1']).'\' and  \''.MyDate::transform('timestamp',substr($info['end_time2'],0,10).' 23:59:59').'\'';
            if($info['end_time2'] <> "" && $info['end_time1'] == "") $wheres[] = 'm.end_time < \''.MyDate::transform('timestamp',substr($info['end_time2'],0,10).' 23:59:59').'\'';
            if($info['end_time2'] == "" && $info['end_time1'] <> "") $wheres[] = 'm.end_time > \''.MyDate::transform('timestamp',$info['end_time1']).'\'';
            if ($info['key']) {
                if($info['keytype'] == 1) $wheres[] = 'm.order_sn=\''.substr($info['key'],strlen(CFG_ORDER_PREFIX)).'\'';
                if($info['keytype'] == 2) $wheres[] = 'm.country=\''.$info['key'].'\'';
                if($info['keytype'] == 3) $wheres[] = 'm.userid like \'%'.$info['key'].'%\'';
                if($info['keytype'] == 4) $wheres[] = 'm.consignee like \'%'.$info['key'].'%\'';
                if($info['keytype'] == 5) $wheres[] = 'm.email=\''.$info['key'].'\'';
                if($info['keytype'] == 6) $wheres[] = 'm.paypalid=\''.$info['key'].'\'';
                if($info['keytype'] == 7) $wheres[] = 'm.track_no=\''.$info['key'].'\'';
                if($info['keytype'] == 8) $wheres[] = 'p.goods_sn like \'%'.$info['key'].'%\'';
                if($info['keytype'] == 9) $wheres[] = 'p.item_no=\''.$info['key'].'\'';
                if($info['keytype'] == 10) $wheres[] = 'm.tel=\''.$info['key'].'\'';
                if($info['keytype'] == 11) $wheres[] = 'm.sellsrecord=\''.$info['key'].'\'';
                if($info['keytype'] == 12) $wheres[] = 'm.street1 like \'%'.$info['key'].'%\'';
                if($info['keytype'] == 0) $wheres[] = '(m.order_sn=\''.substr($info['key'],strlen(CFG_ORDER_PREFIX)).'\' or m.country=\''.$info['key'].'\' or m.userid like \'%'.$info['key'].'%\' or m.consignee like \'%'.$info['key'].'%\' or m.street1 like \'%'.$info['key'].'%\' or m.email=\''.$info['key'].'\' or m.paypalid=\''.$info['key'].'\' or m.track_no=\''.$info['key'].'\' or p.goods_sn like \'%'.$info['key'].'%\' or p.item_no=\''.$info['key'].'\' or m.tel=\''.$info['key'].'\' or m.sellsrecord=\''.$info['key'].'\')';
            }
            if ($info['status'] != 0) {
                $wheres[] = 'm.order_status=\''.$info['status'].'\'';
            }
            if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'm.'.$timefiled.' between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
            
            if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'm.'.$timefiled.' < \''.MyDate::transform('timestamp',substr($info['totime'],0,10).' 23:59:59').'\'';
            if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'm.'.$timefiled.' > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
        }
        if($status){
            $wheres[] = 'm.order_status in ('.$status.')';
        }
        if ($info['is_lock']) $wheres[] = 'm.is_lock = 1';
        if($ids){
            $wheres[] = 'm.order_id in ('.$ids.')';
        }
        /*
        if($info['shippingstatus'] != 0){
            $arr = ModelDd::getArray('shippingstatus');
            $shippingstatus = $arr[$info['shippingstatus']];
            //echo $shippingstatus;
            $wheres[] = 'm.ship_status ="'.$shippingstatus.'"';
        }*/
        $accountlist = ($_SESSION['account_list'] == '')?0:$_SESSION['account_list'];
        if($_SESSION['account_list'] != 'all') $wheres[] = 'm.Sales_account_id in ('.$accountlist.')';
        $where = '';
        if ($wheres) {
            $where = ' where ' . implode(' and ', $wheres);
        }
        return $where;
    }

    /**
     * 取得订单信息
     * @param   int     $order_id   订单id（如果order_id > 0 就按id查，否则按sn查）
     * @param   string  $order_sn   订单号
     * @return  array   订单信息（金额都有相应格式化的字段，前缀是formated_）
     */
    function order_info($order_id, $order_sn = ''){
        if ($order_id > 0)
        {
            return $this->db->getValue("select * from ".$this->tableName." where ".$this->primaryKey." ='$order_id'");
        }
        else
        {
            return $this->db->getValue("select * from ".$this->tableName." where  order_sn ='$order_sn'");
        }
    }

    /**
     * 取得买家信息
     * @param   int     $order_id   订单id（如果order_id > 0 就按id查，否则按sn查）
     * @param   string  $order_sn   订单号
     * @return  array   订单信息（金额都有相应格式化的字段，前缀是formated_）
     */
    function buyer_info($order_id, $order_sn = ''){
        if ($order_id > 0)
        {
            return $this->db->getValue("select consignee,email,concat(street1,' ',street2) as street,city,state,country,CountryCode,zipcode,tel from ".$this->tableName." where ".$this->primaryKey." in('$order_id')");
        }
        else
        {
            return $this->db->getValue("select consignee,email,concat(street1,' ',street2) as street,city,state,country,CountryCode,zipcode,tel from ".$this->tableName." where  order_sn ='$order_sn'");
        }
    }

    /**
     * 取得订单产品信息
     * @param   int     $order_id   订单id）
     * @return  array   订单信息（金额都有相应格式化的字段，前缀是formated_）
     */
    function order_goods_info($order_id,$split = CFG_GOODS_SPLIT){
        if(!$order_id) return;
        $Sales_channels = $this->db->getValue('select Sales_channels from '.$this->tableName.' where order_id = '.$order_id);
            if($split){
                $rs = $this->db->select('select rec_id,goods_sn,item_no,goods_name,goods_price,goods_weigth,goods_qty,stock_place,good_line_img,Attribute_note,ali_qty,ali_note,ali_logistic from '.$this->infotableName." where ".$this->primaryKey." ='$order_id'  order by goods_sn");
                for($i=0;$i<count($rs);$i++){
                    $str = '';
                    $cc = $this->db->getValue("SELECT goods_id,goods_name as goods_name_self,goods_img,price1,price2,price3 FROM ".CFG_DB_PREFIX."goods where goods_sn = '".$rs[$i]['goods_sn']."' or SKU = '".$rs[$i]['goods_sn']."'");
                    $rs[$i]['goods_id'] = $cc['goods_id'];
                    //$rs[$i]['goods_name_self'] = $cc['goods_name_self'];
                    //if($Sales_channels==4) 
                    $rs[$i]['goods_img'] = $rs[$i]['good_line_img'];
                    //else $rs[$i]['goods_img'] = $cc['goods_img'];
                    $sku = json_decode($rs[$i]['Attribute_note'],true);
                    for($j=0;$j<count($sku['sku']);$j++){
                        if($sku['sku'][$j]['pName'] && $sku['sku'][$j]['pValue']) $str .= ' ('.$sku['sku'][$j]['pValue'].') ';
                    }
                    $rs[$i]['goods_attribute'] = $str;
                }
                $result = array();
                $modelgoods = new ModelGoods();
                for ($j=0;$j<count($rs);$j++) {
                    $str = '';
                    if($modelgoods->checkisgroup($rs[$j]['goods_sn'])){//判断是否为组合产品编码
                        $o_price =$rs[$j]['goods_price'];
                        $o_qty= $rs[$j]['goods_qty'];
                        $combinelist = $modelgoods->combine_goods_info('',$rs[$j]['goods_sn']);
                            for($i=0;$i<count($combinelist);$i++){
                                $rs[$j]['goods_id'] = $combinelist[$i]['goods_id'];
                                $rs[$j]['goods_sn'] = $combinelist[$i]['goods_sn'];
                                $rs[$j]['goods_name_self'] = $combinelist[$i]['goods_name'];
                                if($i >0) $rs[$j]['item_no'] = '';
                                $rs[$j]['goods_price'] = ($i==0)?round(($o_price*$o_qty/($combinelist[$i]['goods_qty']*$o_qty)),2):0;
                                $rs[$j]['goods_qty'] = $combinelist[$i]['goods_qty']*$o_qty;
                                $result[] = $rs[$j];
                            }
                    }else{
                        if(CFG_GOODS_COMBSPLIT == 1){ ///需要进行拆分
                            $rs[$j]['goods_sn'] = str_replace("[","",$rs[$j]['goods_sn']);
                            $rs[$j]['goods_sn'] = str_replace("]","",$rs[$j]['goods_sn']);//fix for opo
                            if(CFG_GOODS_CONCAT <>''){//连接符存在
                                if(strpos($rs[$j]['goods_sn'],CFG_GOODS_CONCAT)||strpos($rs[$j]['goods_sn'],CFG_GOODS_QTYSIGN)){
                                    $combinelist = explode(CFG_GOODS_CONCAT,$rs[$j]['goods_sn']);
                                    $o_price =$rs[$j]['goods_price'];
                                    $o_qty= $rs[$j]['goods_qty'];
                                    for($i=0;$i<count($combinelist);$i++){//分割组合产品
                                        $gd = explode(CFG_GOODS_QTYSIGN,$combinelist[$i]);//$gd 0---sku 1---num
                                        $gd_qty = ($gd[1])?$gd[1]:1;
                                        $gdgoods = $modelgoods->goods_info('',$gd[0]);
                                        if($i >0) $rs[$j]['item_no'] = '';
                                        if($gdgoods['goods_id']){
                                            $rs[$j]['goods_id'] = $gdgoods['goods_id'];
                                            $rs[$j]['goods_sn'] = $gdgoods['goods_sn'];
                                            $rs[$j]['goods_name_self'] = $gdgoods['goods_name'];
                                            $rs[$j]['goods_price'] = ($i==0)?round(($o_price*$o_qty/($gd_qty*$o_qty)),2):0;
                                            $rs[$j]['goods_qty'] = $gd_qty*$o_qty;
                                        }else{
                                            $rs[$j]['goods_id'] = '';
                                            $rs[$j]['goods_sn'] = $gd[0];
                                            $rs[$j]['goods_name_self'] = $rs[$j]['goods_name'];
                                            $rs[$j]['goods_price'] = ($i==0)?round(($o_price*$o_qty/($gd_qty*$o_qty)),2):0;
                                            $rs[$j]['goods_qty'] = $gd_qty*$o_qty;
                                        }
                                        $result[] = $rs[$j];
                                    }
                                }else $result[] = $rs[$j];
                            }else $result[] = $rs[$j];
                        }
                        else $result[] = $rs[$j];//不是组合产品则直接加入数组返回
                    }
                }
                return $result;
            }else{
                $rs =  $this->db->select("select * from ".$this->infotableName." where ".$this->primaryKey." ='$order_id'  order by goods_sn");
                for($i=0;$i<count($rs);$i++){
                    $str = '';
                    $cc = $this->db->getValue("SELECT goods_id,goods_name as goods_name_self,goods_img FROM ".CFG_DB_PREFIX."goods where goods_sn = '".$rs[$i]['goods_sn']."' or SKU = '".$rs[$i]['goods_sn']."'");
                    $rs[$i]['goods_id'] = $cc['goods_id'];
                    $rs[$i]['goods_name_self'] = $cc['goods_name_self'];
                    
                    $rs[$i]['goods_img'] = ($cc['goods_img'] == '')?$rs['good_line_img']:$cc['goods_img'];
                    
                    $sku = json_decode($rs[$i]['Attribute_note'],true);
                    for($j=0;$j<count($sku['sku']);$j++){
                        if($sku['sku'][$j]['pName'] && $sku['sku'][$j]['pValue']) $str .= ' ('.$sku['sku'][$j]['pValue'].') ';
                    }
                    $rs[$i]['ali_qty'] = $rs[$i]['ali_qty'];
                    $rs[$i]['goods_attribute'] = $str;
                }
                
                return $rs;
            }
    }

    /**
     * 删除订单产品信息
     * @param   int     $rec_id
     * @return  string  
     */
    function delOrdergoods($rec_id){
        $info = $this->db->getValue("SELECT order_id,goods_sn,goods_qty FROM ".$this->infotableName." where rec_id = '".$rec_id."'");
        $this->save_order_log($info['order_id'],'删除订单产品','删除订单产品'.$info['goods_sn'].'*'.$info['goods_qty']);
            return $this->db->execute('delete from '.$this->infotableName
                .' where rec_id = '.$rec_id);
    }
    
    /**
     * 删除订单信息
     * @param   int     $rec_id
     * @return  string  
     */
    function delOrder($order_id){
        $order_info = $this->order_info($order_id);
        $this->db->execute('delete from '.$this->infotableName
                .' where order_id = '.$order_id);
        $this->db->execute('delete from '.$this->tableName
                .' where order_id = '.$order_id);
        $this->save_order_log($order_id,'delete',CFG_ORDER_PREFIX.$order_info['order_sn'].'已被删除');
        
    }
    

    /**
    *获取订单状态的相关信息
    *param int status
    **/
    function status_info($status){
        
        return $this->db->getValue("select * from ".$this->statustableName." where id ='$status'");    
    }
    
    /**
    *更新订单状态
    *param $info
    *
    **/
    function updateStatus($info,$step=null){
        $ids = $info['id'];
        $ispass = $info['ispass'];
        if($ispass == 0) $id_field = 'hold_id';
        elseif($ispass == 1) $id_field = 'next_id';
        elseif($ispass == 2) $id_field = 'refund_id';
        elseif($ispass == 3) $id_field = 'fail_id';
        $id = explode(',',$ids);
        $id = array_unique($id);
        $msg = '';
        $object = new ModelGoods();
        $depotstatus = $this->getorderflow(15,1);
        $expresstatus = $this->getorderflow(16,1);
        unset($depotstatus[0]);
        unset($expresstatus[0]);
        $checkdepot = (count($depotstatus)>0)?array_keys($depotstatus):array('114','122');//默认锁定库存步骤
        $checkexpress = (count($expresstatus)>0)?array_keys($expresstatus):array('113');//默认分配快递方式步骤
        
        for($i=0;$i<count($id);$i++){
            
            
            
            $order_info = $this->db->getValue("select order_sn,order_status,Sales_channels,is_lock,depot_id from myr_order where order_id=".intval($id[$i]));
                                                         
            $goodslist =  $this->db->select("select og.rec_id,og.order_id,og.goods_sn,og.goods_qty,g.goods_id,g.goods_sn,g.is_control,g.has_child,g.goods_name from myr_order_goods as og left join myr_goods as g on og.goods_sn = g.goods_sn where og.order_id = '$id[$i]' order by og.rec_id desc");
                
            //$old_status = $order_info['order_status'];
            
            
            if($step){
                if(!in_array($order_info['order_status'],explode(",",$step))){
                    $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'状态已变更,请刷新核实<br>';continue;
                }
            }
              
            $status = $this->db->getValue("select ".$id_field." from ".$this->statustableName." where id = ".intval($order_info['order_status']));
            if($status == '' || $status == 0) {
                throw new Exception('该订单可能已删除或已核对，请注意核实','300');exit();
                }
            $failstatus = $this->db->getValue("select fail_id from ".$this->statustableName." where id =".intval($order_info['order_status']));
            
            if(CFG_GOODS_CHECK && in_array($status,$checkdepot)){//库管审核阶段
                                                              
                    
                    if($order_info['is_lock']>0){//已进行过库存锁定的
                           
                        $this->db->execute("UPDATE ".$this->tableName." SET order_status = ".$status." where order_status = " .$order_info['order_status']." AND order_id=".intval($id[$i]));
                        $this->save_order_log($id[$i],'更改状态','订单状态被更改为'.$status);
                    
                    }else{
                        
                        $is_enough = 1;
                        
                        $goods_sn = '';
                        
                        for($j=0;$j<count($goodslist);$j++){//进行库存判断
                        
                            //$no_control = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE ( SKU = "'.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH).'" or goods_sn = "'.$goodslist[$j]['goods_sn'].'") AND is_control = 0');//无需管理库存
                           
                            if($goodslist[$j]['is_control'] == 0) continue;
                            
                            //$has_child = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE  (SKU = "'.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH).'" or goods_sn = "'.$goodslist[$j]['goods_sn'].'") AND  has_child = 1');
                            
                            if($goodslist[$j]['has_child'] == 1){
                                
                                //如果是子产品*********************************************************************待完善
                                
                                $is_match = $this->db->getValue('SELECT stock as goods_qty,varstock FROM '.CFG_DB_PREFIX .'goods_child WHERE child_sn = "'.$goodslist[$j]['goods_sn'].'"');
                            
                            }else{   
                               
                                $is_match = $object->getgoodsqty($goodslist[$j]['goods_id'],$order_info['depot_id']);
                                
                            }
                            
                            
                            $is_enough = ( $is_enough && ( $is_match['goods_qty']   -  $is_match['varstock'] >= $goodslist[$j]['goods_qty'])) ? 1 : 0 ;
                            
                            if($is_enough == 0){  //0 = 缺货
                            
                                if($_SESSION['company'] == 'dzmy'){
                                       
                                   $is_goods = $this->db->getValue('select count(*) as qty,goods_qty,sold_qty,goods_plan_id from myr_plan_goods_depot where goods_id='.$goodslist[$j]['goods_id']); 
                                   
                                   
                                   if(!$is_goods['qty']){    //缺货待采购还没有
                                        $Purchase_qty = $this->db->getValue('SELECT sum(m.goods_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$goodslist[$j]['goods_id'].' and n.status in(0,1,5,6)');
                                       
                                       //echo $goodslist[$j]['goods_sn'].'在途'.$Purchase_qty.'<br/>'; 
                       //              $goodslist[$j]['goods_qty'] +  $is_match['warn_qty']  +   $is_match['varstock']   -        $Purchase_qty      -   $is_match['goods_qty'] 
                       
                   //建议采购数       =        销售需求       +          报警库存          +           锁定库存          -           采购在途        -    当前库存                            
                                       $plan_qty = $goodslist[$j]['goods_qty'] + $is_match['warn_qty'] + $is_match['varstock'] - $Purchase_qty - $is_match['goods_qty'];
                                       
                                       $this->db->insert('myr_plan_goods_depot',array(
                                            
                                            'goods_id' => $goodslist[$j]['goods_id'],
                                            'goods_sn' => $goodslist[$j]['goods_sn'],
                                            'goods_name' => addslashes($goodslist[$j]['goods_name']),
                                            'SKU' => $goodslist[$j]['goods_sn'],
                                            'goods_qty' => $is_match['goods_qty'],
                                            'warn_qty' => $is_match['warn_qty'],
                                            'varstock' => $is_match['varstock'],
                                            'Purchase_qty' => $Purchase_qty,
                                            'sold_qty' => $goodslist[$j]['goods_qty'],
                                            'per_sold' => 0,
                                            'supplier' => 'lpllp',
                                            'period' => 0,
                                            'plan_qty' => $plan_qty,
                                            'comment' => "建议采购$plan_qty",
                                            'plan_day' => 0,
                                            'depot_id' => 0    
                                       ));   
                                       
                                       $depot_plan_id = $this->db->getInsertId();  
                                       
                                       
                                       $this->db->insert('myr_plan_goods_depot_ordergoods',array(
                                            'goods_plan_id' => $depot_plan_id,     
                                            'goods_id' => $goodslist[$j]['goods_id'],     
                                            'order_id' => $id[$i]     
                                       ));
                                       
                                        
                                   }else{
                                       
                                       
                                       $is_order = $this->db->getValue("select count(*) from myr_plan_goods_depot_ordergoods where goods_id = ".$goodslist[$j]['goods_id']." and order_id = ".$id[$i]);
                                       
                                       
                                       if(!$is_order){
                                           $Purchase_qty = $this->db->getValue('SELECT sum(m.goods_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$goodslist[$j]['goods_id'].' and n.status in(0,1,5,6)');
                                       
                                           $plan_qty = ($is_goods['sold_qty'] + $goodslist[$j]['goods_qty']) + $is_match['warn_qty'] + $is_match['varstock'] - $Purchase_qty - $is_match['goods_qty'];
                                           
                                            $this->db->update('myr_plan_goods_depot',array( 
                                                'goods_qty' => $is_match['goods_qty'],
                                                'warn_qty' => $is_match['warn_qty'],
                                                'varstock' => $is_match['varstock'],
                                                'Purchase_qty' => $Purchase_qty,
                                                'sold_qty' => $is_goods['sold_qty'] + $goodslist[$j]['goods_qty'],      
                                                'plan_qty' => $plan_qty,
                                                'comment' => "建议采购$plan_qty"
                                            ),'goods_id='.$goodslist[$j]['goods_id']);
                                            
                                            
                                           $this->db->insert('myr_plan_goods_depot_ordergoods',array(
                                                'goods_plan_id' => $is_goods['goods_plan_id'],     
                                                'goods_id' => $goodslist[$j]['goods_id'],     
                                                'order_id' => $id[$i]     
                                           ));        
                                       }else{
                                           $Purchase_qty = $this->db->getValue('SELECT sum(m.goods_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$goodslist[$j]['goods_id'].' and n.status in(0,1,5,6)');
                                       
                                           $plan_qty = $is_goods['sold_qty'] + $is_match['warn_qty'] + $is_match['varstock'] - $Purchase_qty - $is_match['goods_qty'];
                                           
                                            $this->db->update('myr_plan_goods_depot',array( 
                                                'goods_qty' => $is_match['goods_qty'],
                                                'warn_qty' => $is_match['warn_qty'],
                                                'varstock' => $is_match['varstock'], 
                                                'Purchase_qty' => $Purchase_qty,        
                                                'sold_qty' => $is_goods['sold_qty'],      
                                                'plan_qty' => $plan_qty,
                                                'comment' => "建议采购$plan_qty"
                                            ),'goods_id='.$goodslist[$j]['goods_id']);
                                       }
                                       
                                       
                                   } 
                                   
                                   
                                   $goods_sn .= $goodslist[$j]['goods_sn'].','; 
                                    
                                    
                                }else{
                                    
                                    $goods_sn = $goodslist[$j]['goods_sn'].',';
                                    
                                    break;
                                }
                                       
                            }
                                   
                            
                        }
                        
                        
                        
                        
                        if($is_enough == 1){
                            
                            if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." where is_lock = 0 and order_id =".$id[$i]) >0) $this->stocklock($id[$i]);        //开始库存锁定
                            
                            $this->db->update($this->tableName,array(
                                    'order_status' => $status,
                                    'is_lock' => 1
                                    ),'order_status = ' .intval($order_info['order_status']).' AND order_id='.intval($id[$i]));
                                    
                            $this->save_order_log($id[$i],'更改状态','订单状态被更改为'.$status);
                            
                            $this->save_order_log($id[$i],'库存变动','库存已被锁定');
                            
                        }else{
                            
                            $this->db->execute("UPDATE ".$this->tableName." SET order_status = ".$failstatus." where order_id=".intval($id[$i]));
                            $this->save_order_log($id[$i],'更改状态','订单状态被更改为'.$failstatus);
                            $msg .= CFG_ORDER_PREFIX.$order_info['order_sn'].'中产品'.$goods_sn.'库存不足<br>';
                            
                        }    
                    }
            }else{
                $this->db->execute("UPDATE ".$this->tableName." SET order_status = ".$status." where order_status = " .intval($order_info['order_status'])." AND order_id=".intval($id[$i]));
                $this->save_order_log($id[$i],'更改状态','订单状态被更改为'.$status);
            }
            if($status == 138) $this->unlock($id[$i]); //销售审核返回解除锁定库存
            if(CFG_EXPRESS_RULE && in_array($status,$checkexpress)) $this->check_rule($id[$i]);//快递规则判断 
        }
        $msg .= '审核完成';
        return $msg;
    }
    
    /****
    * 库管自动检测到货完成   
    */
    function checkDepotComplete(){
        $object = new ModelGoods();
        //缺货状态订单
        $Result = $this->db->getValue("select fail_id,next_id from myr_order_status where id = ".$this->db->getValue("select id from myr_order_status where next_id = ".intval($this->getorderflow(15,2))));
       
       
        $depotstatus = intval($Result['fail_id']);
        
        $status = intval($Result['next_id']);
       
        $depotOrders = $this->db->select("select order_id,order_sn,depot_id from myr_order where order_status = ".$depotstatus);
        
        $msg = '';
       
        for($i=0;$i<count($depotOrders);$i++){
              
            $goodslist =  $this->db->select("select og.rec_id,og.order_id,og.goods_sn,og.goods_qty,g.goods_id,g.goods_sn,g.is_control,g.has_child from myr_order_goods as og left join myr_goods as g on og.goods_sn = g.goods_sn where og.order_id = ".intval($depotOrders[$i]['order_id'])." order by og.rec_id desc");
                    
            $is_enough = 1;
                        
            for($j=0;$j<count($goodslist);$j++){        
                $goods_sn = $goodslist[$j]['goods_sn'];         
                if($goodslist[$j]['is_control'] == 0) continue;
               
                if($goodslist[$j]['has_child'] == 1){  
                    $is_match = $this->db->getValue('SELECT stock as goods_qty,varstock FROM '.CFG_DB_PREFIX .'goods_child WHERE child_sn = "'.$goodslist[$j]['goods_sn'].'"');
                
                }else{
                    $is_match = $object->getgoodsqty($goodslist[$j]['goods_id'],$depotOrders[$i]['depot_id']); 
                } 
                $is_enough = ( $is_enough && ($is_match['goods_qty']   -  $is_match['varstock'] >= $goodslist[$j]['goods_qty'])) ? 1 : 0 ;
                
            
                if($is_enough == 0){   
                
                    $goods_sn = $goodslist[$j]['goods_sn'];      
                    break;       //一个缺货 全部缺货
                }
            }                                 
            if($is_enough == 1){                 
                if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." where is_lock = 0 and order_id =".$depotOrders[$i]['order_id']) >0) $this->stocklock($depotOrders[$i]['order_id']);        //开始库存锁定
                
                $this->db->update($this->tableName,array(
                        'order_status' => $status,
                        'is_lock' => 1
                        ),'order_status = ' .$depotstatus.' AND order_id='.intval($depotOrders[$i]['order_id']));
                        
                $this->save_order_log($depotOrders[$i]['order_id'],'缺货到货更改状态','订单状态被更改为'.$status);
                
                $this->save_order_log($depotOrders[$i]['order_id'],'库存变动','库存已被锁定');
                                                                                                 
                $msg .= CFG_ORDER_PREFIX.$depotOrders[$i]['order_sn'].'中产品'.$goods_sn.'已到货入库，通过审核<br>'; 
                
            }    
        }    
       $msg .= '审核完成';
       return $msg;
    }
    
    
    /******
    *开始锁定库存
    ******/
    function stocklock($id){
        $goodslist = $this->order_goods_info($id);
        $orderinfo = $this->order_info($id);
        $goods = new ModelGoods();
        $depotlist = ModelDd::getArray("depot");
                    for($j=0;$j<count($goodslist);$j++){//进行库存判断
                        $no_control = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE SKU = \''.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH)
                                        .'\' AND is_control = 0');//无需管理库存
                        if($no_control) continue;
                        $has_child = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE SKU = \''.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH)
                                        .'\' AND has_child = 1');
                        if($has_child){//如果是子产品************************************************************待完善
                            $this->db->execute('UPDATE '.CFG_DB_PREFIX .'goods_child set varstock = varstock+'.$goodslist[$j]['goods_qty'].' where child_sn = \''.$goodslist[$j]['goods_sn'].'\'');
                            $goods->updatechildstock('',$goodslist[$j]['goods_sn']);
                        }else{
                            $goods_id = $goods->getidBySKU($goodslist[$j]['goods_sn']);
                            $shelf_id = $goods->getshelfid($orderinfo['depot_id']);
                            $goodsqty = $goods->getgoodsqty($goods_id,$orderinfo['depot_id'],$shelf_id);
                            $goods->updatevarqty($goods_id,$orderinfo['depot_id'],$goodslist[$j]['goods_qty'],1);
                            $log['goods_id'] = $goods_id;
                            $log['action'] = CFG_ORDER_PREFIX.$orderinfo['order_sn'];
                            $log['action'] .= '订单锁定库存';
                            $log['field'] = 'varstock';
                            $log['content'] = $depotlist[$orderinfo['depot_id']].'值由'.$goodsqty['varstock'].'更新为'.($goodsqty['varstock']+$goodslist[$j]['goods_qty']);
                            $log['admin_id'] = $_SESSION['admin_id'];
                            $log['addtime'] = CFG_TIME;
                            $goods->goods_log($log);
                        }
                    }
    }
    /**
    *订单快递规则判断
    *param $id
    *
    **/
    function check_rule($id,$redo=0)
    {
        $order_info = $this->order_info($id);
        if($order_info['shipping_id'] > 0 && $redo == 0) return;
        $object = new ModelExpress();
        $shipping_id = $object->getExpress($order_info);
        $this->changedepot($shipping_id,$id);
    }
    /**
    *删除订单状态
    *param $info
    *
    **/
    function delStatus($ids){
        return $this->db->execute('delete from '.$this->statustableName
                .' where id in ('.$ids.')');
    }
    /**
    *更新订单打印状态
    *param $info
    *
    **/
    function updataPrtStatus($ids){
        $this->db->update($this->tableName, array(
                        'print_status' => 1
                        ),'order_id in('.$ids.')');            
    }
    /**
    *更新追踪单号
    *param $info
    *
    **/
    function savetrackNO($info)
    {
        $this->db->update($this->tableName, array(
                        'track_no' => $info->track_no
                        ),'order_id ='.intval($info->order_id));            
    }
    /**
    *获取可以出库的订单明细
    *param $status 可以出库的订单状态 $account 账户  $depot 出单仓库
    *
    **/
    function getOutdepot($status,$account,$depot)
    {
        $this->db->execute('DELETE from '. CFG_DB_PREFIX .'stockout_tmp WHERE user = '.$_SESSION['admin_id']);
        if($depot==0){
            $depotwhere = " AND shipping_id not in ( SELECT shipping_id FROM ".CFG_DB_PREFIX."shipping_depot where depot_id != 0)";
            }else{
            $depotwhere = " AND shipping_id in ( SELECT shipping_id FROM ".CFG_DB_PREFIX."shipping_depot where depot_id = '".$depot."')";
        }
        $accountwhere = ($account != 0)?" AND Sales_account_id ='".$account."'":"";
        $orders = $this->db->select("SELECT order_id from ".$this->tableName." where order_status in (".$status.")".$accountwhere.$depotwhere." AND (stockout_sn is null or stockout_sn = '') limit 50");
        //return $orders;
        $result = array();
        $idstr = '';
        $t=1;
        for($j=0;$j<count($orders);$j++){
            $goods = $this->order_goods_info($orders[$j]);
            $idstr .= ','.$orders[$j];
            for($i=0;$i<count($goods);$i++){
                $has=0;
                foreach($result as $k=>$v){
                        if($v['goods_sn'] == $goods[$i]['goods_sn']){
                                $has=1;
                                $result[$k]['out_qty'] += $goods[$i]['goods_qty'];
                                break;
                            }
                    }
                if($has) continue;
                $good['id'] = $t;
                $t++;
                $good['out_qty'] = $goods[$i]['goods_qty'];
                $good['goods_sn'] = $goods[$i]['goods_sn'];
                $good['goods_name'] = $goods[$i]['goods_name'];
                $modelgoods = new ModelGoods();
                $goodinfo = $modelgoods->goods_info('',$goods[$i]['goods_sn'],$depot);
                $good['stock_place'] = $goodinfo['stock_place'];
                $good['goods_qty'] = $goodinfo['goods_qty'];
                $good['goods_img'] = $goodinfo['goods_img'];
                $good['is_control'] = $goodinfo['is_control'];
                $result[] = $good;
            }
        }
        if($idstr <> '') $this->db->insert(CFG_DB_PREFIX .'stockout_tmp',array(
                                    'orderstr' => substr($idstr,1),
                                    'depot_id' => $depot,
                                    'user' => $_SESSION['admin_id']
                                    ));
        return $result;
    }
    /**
    *生成出库单
    *
    **/
    function makeOutdepot()
    {
        $orderstr = $this->db->getValue("SELECT orderstr,depot_id from ".CFG_DB_PREFIX .'stockout_tmp WHERE user = '.$_SESSION['admin_id']);
        $orders = $this->db->select("SELECT order_id,order_sn,Sales_account_id from ".$this->tableName." WHERE order_id in (".$orderstr['orderstr'].")");
        $account = ModelDd::getCaption('allaccount',$orders[0]['Sales_account_id']);
        $info['order_id'] ="";
        $Stockout = new ModelStockout();
        $info['order_sn'] = $Stockout->get_order_sn();
        $info['depot_id'] = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot WHERE depot_id = ".$orderstr['depot_id']." and is_main = 1");
        $info['operator_id'] = $_SESSION['admin_id'];
        $info['stocktype'] = 1;
        $info['status'] = 1;
        $info['comment'] = $account.'账号'.date('Y-m-d').'销售出库';
        $info['out_time'] = CFG_TIME;
        for($j=0;$j<count($orders);$j++){
            $goods = $this->order_goods_info($orders[$j]['order_id']);
            for($i=0;$i<count($goods);$i++){
                $good = '';
                $good->goods_qty = $goods[$i]['goods_qty'];
                $good->relate_order_sn = CFG_ORDER_PREFIX.$orders[$j]['order_sn'];
                $modelgoods = new ModelGoods();
                $goodinfo = $modelgoods->goods_info('',$goods[$i]['goods_sn']);
                $good->goods_id = $goodinfo['goods_id'];
                $good->goods_price = $goodinfo['cost'];
                $good->remark = '';
                $info['data'][] = $good;
            }
        }
      try {
                  $stockorder['order_id'] = $Stockout->save($info);
                        } catch (Exception $e) {
                    throw new Exception('保存出库单失败,订单号为'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
                }
      /*$stockorder['status'] = 1;
      try {
          $Stockout->update($stockorder);
                        } catch (Exception $e) {
                    throw new Exception('更新出库单状态失败,订单号为'.CFG_OUT_ORDER_PREFIX.$info['order_sn'],'999');exit();
         }*/
      $out_sn = $Stockout->order_info($stockorder['order_id']);
      try {
      $this->db->update($this->tableName,array(
                'stockout_sn' => CFG_OUT_ORDER_PREFIX.$out_sn['order_sn']
                ),'order_id in ( '.$orderstr['orderstr'].' )');
        $this->db->execute("DELETE FROM ".CFG_DB_PREFIX .'stockout_tmp WHERE user = '.$_SESSION['admin_id']);
                        } catch (Exception $e) {
                    throw new Exception('更新订单出库单号失败','990');exit();
         }
    }
    function isorder($key,$account=0)
    {
        return $this->db->getValue("SELECT order_id from ".$this->tableName." WHERE (order_sn = '".substr($key,strlen(CFG_ORDER_PREFIX))."' or track_no='".$key."' or sellsrecord='".$key."')".(($account==0)?"":" AND Sales_account_id =".$account));    
    }
    function getorderTrack($id){
        return $this->db->getValue("SELECT track_no FROM ".$this->tableName." where order_id ='".$id."'");
    }
    
    /**
    *存储呆核对订单明细
    */
    function savecheckcollation($sn)
    {
        $this->db->execute('DELETE from '. CFG_DB_PREFIX .'order_collation WHERE user = '.$_SESSION['admin_id']);
        $order = $this->order_info($sn);
        $goods = $this->order_goods_info($order['order_id']);
        
        $account = ModelDd::getCaption('allaccount',$order['Sales_account_id']);
        $shipping = ModelDd::getCaption('shipping',$order['shipping_id']);
        
        for($i=0;$i<count($goods);$i++){
            $modelgoods = new ModelGoods();
            $goodsinfo = $modelgoods->goods_info('',$goods[$i]['goods_sn']);
            $sn_control = 0;
            if($goodsinfo) {
                $goods[$i]['goods_name']= $goodsinfo['goods_name'];
                $sn_control = $goodsinfo['sn_control'];
            } 
            
            $goodsurl = '';
            if($order['Sales_channels'] == 1){
                $goodsurl = "http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&item=".$goods[$i]['item_no'];    
            }elseif($order['Sales_channels'] == 4){
                $goodsurl = "http://www.aliexpress.com/snapshot/".$goods[$i]['item_no'].".html";
            }
            //    
            $this->db->insert(CFG_DB_PREFIX .'order_collation',array(
                            'goods_img' => $goods[$i]['goods_img'],
                            'goods_sn' => $goods[$i]['goods_sn'],
                            'sn_control' => $sn_control,
                            'goods_name' => addslashes($goods[$i]['goods_name']),
                            'out_qty' => $goods[$i]['goods_qty'],
                            'goods_qty' => (!check_authz('auto_checkorder') && CFG_GOODS_COLLATION == 1)?0:$goods[$i]['goods_qty'],
                            'order_id' => $order['order_id'],
                            'user' => $_SESSION['admin_id'] ,
                            'order_amount' => $order['order_amount'],
                            'sellerID' => $account,
                            'country' => $order['country'] ,
                            'url' => $goodsurl,
                            'paid_time' => date('Y-m-d',$order['paid_time']),
                            'shipping' => $shipping
                            ));
        }
        return $order['note'];
    }
    /*************
    ****继续未完成操作
    *************/
    function getcompletecol()
    {
        return  $this->db->getValue('SELECT count(*) FROM '. CFG_DB_PREFIX .'order_collation WHERE user = '.$_SESSION['admin_id'].' having sum(out_qty) = sum(goods_qty)');    
    }
    /**
    * 待核对订单列表
    */
    function getcollation()
    {
        $orders = $this->db->open("SELECT * from ".CFG_DB_PREFIX .'order_collation where user = '.$_SESSION['admin_id']);
        $result = array();
        while ($rs = $this->db->next()) {
            $result[] = $rs;
        }
        return $result;
    }
    /**
    * 检查是否存在产品编码
    */
    function checkcol($sn,$qty)
    {
        $sn1 = transSKU($sn);
        if($this->db->getValue('SELECT count(*) from '.CFG_DB_PREFIX ."order_collation where (goods_sn = '$sn' or goods_sn = '$sn1') and user = ".$_SESSION['admin_id']) == 0 ) {
            throw new Exception('订单表中没找到该产品');exit();
        }
        $goods = $this->db->getValue('SELECT id,goods_qty,out_qty,sn_control from '.CFG_DB_PREFIX ."order_collation where (goods_sn = '$sn' or goods_sn = '$sn1') and out_qty > goods_qty");
        $goods_qty = $goods['goods_qty'] + $qty;
        if($goods_qty > $goods['out_qty']){        
             throw new Exception('请确认核对数量未超限','910');exit();
         }else{
             /////////序列号管理Start
             if($goods['sn_control']) return 2;
             /////////序列号管理End
             $this->db->update(CFG_DB_PREFIX .'order_collation',array(
                            'goods_qty' => $goods_qty
                        ),'id='.intval($goods['id']));
         }
         $result = $this->db->getValue('SELECT sum(out_qty) as out_qty,sum(goods_qty) as goods_qty from '.CFG_DB_PREFIX ."order_collation where  user = ".$_SESSION['admin_id']);
         return ($result['out_qty'] == $result['goods_qty'])?1:0;
    }
    function collationSN($data,$sn)
    {
        $sn1 = transSKU($sn);
        foreach($data as $goods){
            if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_sn as m left join ".CFG_DB_PREFIX."goods as n on m.goods_id = n.goods_id where (n.goods_sn = '".$sn."' or n.sku = '".$sn."')  and m.sn = '".$goods->SN."' and m.used = 0") ==0){
                throw new Exception($goods->SN.'序列号不可用','910');exit();
                }
            $snlist[] = $goods->SN;
        }
        //判断数量
        if($this->db->getValue("select sum(out_qty - goods_qty) FRom ".CFG_DB_PREFIX ."order_collation where  (goods_sn = '$sn' or goods_sn = '$sn1') and user = ".$_SESSION['admin_id'])< count($snlist)){
                throw new Exception('序列号数量超出需拣货数量','910');exit();
            }
        $this->db->execute("update ".CFG_DB_PREFIX ."order_collation set goods_qty =".count($snlist).",snlist = concat(snlist,',','".implode(",",$snlist)."') where (goods_sn = '$sn' or goods_sn = '$sn1') and user = ".$_SESSION['admin_id']." order by id desc limit 1");
         $result = $this->db->getValue('SELECT sum(out_qty) as out_qty,sum(goods_qty) as goods_qty from '.CFG_DB_PREFIX ."order_collation where  user = ".$_SESSION['admin_id']);
         return ($result['out_qty'] == $result['goods_qty'])?1:0;
    }
    
    
    /**
    *完成校对
    * param string $track
    */
    function completecollation($track,$weight,$cost)
    {
         $result = $this->db->getValue('SELECT sum(out_qty) as out_qty,sum(goods_qty) as goods_qty from '.CFG_DB_PREFIX ."order_collation where user = ".$_SESSION['admin_id']);
        if($result['out_qty'] <> $result['goods_qty']) {
            throw new Exception('产品校对未完成','305');exit();
            }
        $order_id = $this->db->getValue('SELECT order_id from '.CFG_DB_PREFIX .'order_collation where user = '.$_SESSION['admin_id']);
        $this->db->update($this->tableName,array(
                    'is_check' => 1,
                    'weight' => $weight,
                    'shipping_cost' =>$cost,
                    'end_time' =>CFG_TIME
                ),'order_id='.intval($order_id));
        $snlist = $this->db->select("select goods_sn,snlist FROM ".CFG_DB_PREFIX .'order_collation where sn_control = 1');
        if(count($snlist) > 0){
            $orderinfo = $this->order_info($order_id);
            for($i=0;$i<count($snlist);$i++)
            {
                $goods_id = ModelGoods::getidBySKU($snlist[$i]['goods_sn']);
                $this->db->execute("update ".CFG_DB_PREFIX."goods_sn set order_sn = '".$orderinfo['order_sn']."' where goods_id = ".$goods_id." and sn in ('".substr($snlist[$i]['snlist'],1)."')");                
            }
        }
        if($track <> ''){
        $this->db->update($this->tableName,array(
                    'track_no' => $track
                ),'order_id='.intval($order_id));
            }
        $is_lock = $this->db->getValue('SELECT is_lock FROM '.$this->tableName.' WHERE order_id='.intval($order_id));
        if($is_lock == 1 || (CFG_REDUCE_QTY == 1 && $is_lock == 0)){
            if($is_lock == 1) $this->unlock($order_id,1);//释放锁定并扣除库存
            else  $this->unlock($order_id,1,0);//扣库存不减锁定库存
            $this->db->update($this->tableName,array(
                        'is_lock' => 2
                    ),'order_id='.intval($order_id));
                    $this->save_order_log($order_id,'库存变动','库存锁定结束');
            }
        $info['id'] = $order_id;
        $info['ispass'] = "1";
        $this->db->execute('DELETE from '. CFG_DB_PREFIX .'order_collation WHERE user = '.$_SESSION['admin_id']);
        $this->updateStatus($info);
    }
    
    function savetrack($info)
    {
        if($info['order_sn'] =='' || $info['track_no']=='') {
            throw new Exception('信息不全','305');exit();
        }
        $order_id = $this->isorder($info['order_sn']);
        return $this->db->update($this->tableName,array(
            'track_no' => $info['track_no']
        ),'order_id='.intval($order_id));
        
    }
    
    
    /************
    **计算订单实际运费
    ***
    * @param int value
    * @return  int result
    *************/
    function collationCost($value)
    {
        $order_id = $this->db->getValue('SELECT order_id from '.CFG_DB_PREFIX .'order_collation where user = '.$_SESSION['admin_id']);
        return $this->chargeshipping($order_id,$value);
    }
    function  chargeshipping($order_id,$value)
    {
        $fomula = $this->db->getValue("SELECT value FROM ".CFG_DB_PREFIX."shipping_cost as m left join ".$this->tableName." as n on m.express_id    = n.shipping_id    where n.order_id = ".$order_id);
        if($fomula){
            $fomula = str_replace('{weight}',$value,$fomula);
            @eval("\$fomula = \'$fomula\';");
            return $fomula;
            }else{
            return 0;
        }
    }

    function completeorder($ids)
    {
        $id = explode(',',$ids);
        $id = array_unique($id);
        $msg = '';
        for($i=0;$i<count($id);$i++){
        $this->db->update($this->tableName,array(
                    'is_check' => 1,
                    'end_time' =>CFG_TIME
                ),'order_id='.intval($id[$i]));
        $is_lock = $this->db->getValue('SELECT is_lock FROM '.$this->tableName.' WHERE order_id='.intval($id[$i]));
        if($is_lock == 1 || (CFG_REDUCE_QTY == 1 && $is_lock = 0)){
            if($is_lock == 1) $this->unlock($id[$i],1);//释放锁定并扣除库存
            else  $this->unlock($id[$i],1,0);//扣库存不减锁定库存
            $this->db->update($this->tableName,array(
                        'is_lock' => 2
                    ),'order_id='.intval($id[$i]));
                    $this->save_order_log($id[$i],'库存变动','库存锁定结束');
            }
        $info['id'] = $id[$i];
        $info['ispass'] = "1";
        $this->updateStatus($info);
        }
    }
    /***
    ****释放库存锁定
    ****$restock 是否还实际原库存
    ****param  $id order_id $restock 是否进行库存还原
    ****
    ***/
    function unlock($id,$restock=0,$revar=1)
    {
        $goodslist = $this->order_goods_info($id);
        $orderinfo = $this->order_info($id);
        $depotlist = ModelDd::getArray("depot");
        $goods = new ModelGoods();
                    for($j=0;$j<count($goodslist);$j++){//进行库存处理
                        $no_control = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX .'goods WHERE SKU = \''.substr($goodslist[$j]['goods_sn'],0,CFG_GOODSSN_LENGTH)
                                        .'\' AND is_control = 0');//无需管理库存跳过
                        if($no_control) continue;
                            $goods_id = $goods->getidBySKU($goodslist[$j]['goods_sn']);
                            $shelf_id = $goods->getshelfid($orderinfo['depot_id']);
                            $goodsqty = $goods->getgoodsqty($goods_id,$orderinfo['depot_id'],$shelf_id);
                            if($revar == 1) $goods->updatevarqty($goods_id,$orderinfo['depot_id'],$goodslist[$j]['goods_qty'],0);
                            if($restock == 1) $goods->updategoodsqty($goods_id,$orderinfo['depot_id'],$goodslist[$j]['goods_qty'],0);
                            $log['goods_id'] = $goods_id;
                            $log['action'] = CFG_ORDER_PREFIX.$orderinfo['order_sn'];
                            $log['action'] .= ($restock == 1)?'订单出库':'订单解锁';
                            $log['field'] = 'varstock';
                            $log['content'] = $depotlist[$orderinfo['depot_id']].'值由'.$goodsqty['varstock'].'更新为'.($goodsqty['varstock']-$goodslist[$j]['goods_qty']);
                            $log['admin_id'] = $_SESSION['admin_id'];
                            $log['addtime'] = CFG_TIME;
                            if($revar == 1) $goods->goods_log($log);
                            if($restock == 1){
                                $log['field'] = 'goods_qty';
                                $log['content'] = $depotlist[$orderinfo['depot_id']].'值由'.$goodsqty['goods_qty'].'更新为'.($goodsqty['goods_qty']-$goodslist[$j]['goods_qty']);
                                $goods->goods_log($log);
                            }
                    }
        if($restock == 0) $this->db->execute('UPDATE '.$this->tableName.' SET order_status = 113 where order_id ='.$id);
                            $this->db->update($this->tableName,array(
                                    'is_lock' => 0
                                    ),'order_id='.intval($id));
                            $this->save_order_log($id,'库存变动','订单库存已解锁');
    }
    /**
     * 取Ebay待标记列表
     *
     */
    function waitMarkList($status,$status1 =null)
    {
        $query = 'select order_id,userid,Sales_account_id,track_no,shipping_id,concat("'.CFG_ORDER_PREFIX.'",order_sn) as order_sn from '.$this->tableName. ' where order_status in( '.$status.' )';
        $query .= "and is_mark=0";
        $query .= " and Sales_channels = 1";
        $ebayaccount = ModelDd::getArray('ebaycount');
        $acountlist = implode(",",array_keys($ebayaccount));
        if($_SESSION['account_list'] != 'all') $query .= ' and Sales_account_id in ('.$_SESSION['account_list'].')';
        $this->db->open($query);
        $result = array();
        $arr = ModelDd::getArray('ebaycount');
        while ($rs = $this->db->next()) {
            $rs['account_name'] = $ebayaccount[$rs['Sales_account_id']];
            $result[] = $rs;
        }
        return $result;
    }
    /**
     * 取Amazon待标记列表
     *
     */
    function amazonwaitMarklist($status)
    {
        $query = 'select count(order_id) as num,Sales_account_id  from '.$this->tableName. ' where order_status in( '.$status.' ) and ShippingService <> "AFN"';
        $amazonaccount = ModelDd::getArray('amazonaccount');
        $acountlist = implode(",",array_keys($amazonaccount));
        if($_SESSION['account_list'] != 'all') $query .= ' and Sales_account_id in ('.$_SESSION['account_list'].')';
        $query .= " and Sales_channels = 3 group by Sales_account_id";
        $this->db->open($query);
        $result = array();
        while ($rs = $this->db->next()) {
            $rs['account'] = $amazonaccount[$rs['Sales_account_id']];
            $result[] = $rs;
        }
        return $result;
    }
    /**
     * 取Aliexpress待标记列表
     *
     */
    function aliwaitMarklist($status,$where=NULL)
    {
        $query = 'select order_id,userid,Sales_account_id,track_no,shipping_id,paypalid,concat("'.CFG_ORDER_PREFIX.'",order_sn) as order_sn from '.$this->tableName. ' where order_status in( '.$status.' )';
        $account = ModelDd::getArray('aliaccount');
        $acountlist = implode(",",array_keys($account));
        if($_SESSION['account_list'] != 'all') $query .= ' and Sales_account_id in ('.$_SESSION['account_list'].')';
        $query .= "and is_mark=0";
        $query .= " and Sales_account_id in (".$acountlist.") ".$where;
        $this->db->open($query);
        $result = array();
        while ($rs = $this->db->next()) {
            $rs['account'] = $account[$rs['Sales_account_id']];
            $result[] = $rs;
        }
        return $result;
    }
    /**
     * 取DHgate待标记列表
     *
     */
    function DHgatewaitMarklist($status,$where=NULL)
    {
        $query = 'select order_id,userid,Sales_account_id,track_no,shipping_id,paypalid,concat("'.CFG_ORDER_PREFIX.'",order_sn) as order_sn from '.$this->tableName. ' where order_status in( '.$status.' )';
        $account = ModelDd::getArray('dhaccount');
        $acountlist = implode(",",array_keys($account));
        if($_SESSION['account_list'] != 'all') $query .= ' and Sales_account_id in ('.$_SESSION['account_list'].')';
        $query .= "and is_mark=0";
        $query .= " and Sales_channels = 8 and track_no <> '' ".$where;
        $this->db->open($query);
        $result = array();
        while ($rs = $this->db->next()) {
            $rs['account'] = $account[$rs['Sales_account_id']];
            $result[] = $rs;
        }
        return $result;
    }
    /******
    处理特殊发货方式
    ******/
    function getExshipping($type=null)
    {
        $where = '';
        if(!$type){
             if(CFG_ENABLE_4PX == 1) $where .= ' or value ="4PX"';
             if(CFG_ENABLE_COOL == 1) $where .= ' or value ="US"';
             if(CFG_ENABLE_BIRD == 1) $where .= ' or value ="BIRD"';
             if(CFG_ENABLE_SFC == 1) $where .= ' or value ="SFC"';
             if(CFG_ENABLE_CK1 == 1) $where .= ' or value ="CHUKOU1"';
             if(CFG_ENABLE_YTG == 1) $where .= ' or value ="YTG"';
             if(CFG_ENABLE_EUB == 1) $where .= ' or value ="EUB-1"';
             if(CFG_ENABLE_DEDHL == 1) $where .= ' or value ="DEDHL"';
             if(CFG_ENABLE_ICE == 1) $where .= ' or value ="ICE"';
             if(CFG_ENABLE_EST == 1) $where .= ' or value ="EST"';
             if(CFG_ENABLE_ZHY == 1) $where .= ' or value ="ZHY"'; 
             if(CFG_ENABLE_PYB == 1) $where .= ' or value ="PYB"'; 
             if(CFG_ENABLE_YW == 1) $where .= ' or value ="YW"'; 
             if(CFG_ENABLE_SY == 1) $where .= ' or value ="SY"'; 
             $where .= ' or value ="SUB"';
             $result = $this->db->select('SELECT express_id FROM '.CFG_DB_PREFIX .'shipping_mark where value = "EUB"'.$where);
        }else{
            $result = $this->db->select('SELECT express_id FROM '.CFG_DB_PREFIX .'shipping_mark WHERE value="'.$type.'"');
        }
             return implode(",", $result);
    }
    /*****
    *修改产品字段值并记录
    *****/
    function modify($info)
    {
        //edit_comorder
        if(($this->db->getValue('SELECT order_status FROM '.$this->tableName.' where order_id = '.$info['id']) == 131) && !check_authz('edit_comorder')) {throw new Exception('订单已处于OOO状态无法更改','999');exit();}
        $old_value = $this->db->getValue('SELECT '.$info['field'].' FROM '.$this->tableName.' where order_id = '.$info['id']);
        if($info['field'] == 'paid_time') $info['value'] = MyDate::transform('timestamp',$info['value']);
        $this->db->execute('UPDATE '.$this->tableName.' SET '.$info['field'].'= \''.$info['value'].'\' WHERE order_id = '.$info['id']);
        if($info['field'] == 'currency'){
                require(CFG_PATH_DATA . 'dd/currency.php');
                $currency['RMB'] = 1;
                $currency['CNY'] = 1;
                $this->db->execute('UPDATE '.$this->tableName.' SET rate = \''.$currency[$info['value']].'\' WHERE order_id = '.$info['id']);
            };
        if($info['field'] == 'shipping_id') $this->changedepot($info['value'],$info['id']);
        $this->save_order_log($info['id'],'订单编辑',$info['field'].'值由'.$old_value.'更新为'.$info['value']);
    }
    
    /************
    ****修改快递方式重新分配仓库
    ***input  $shipping_id 快递方式
    ***input  $id  订单id
    ************/
    function changedepot($shipping_id,$id){
        $depot_id = $this->db->getValue("SELECT depot_id FROM ".CFG_DB_PREFIX."shipping_depot where shipping_id='".$shipping_id."'");
        if(!$depot_id) $depot_id=0;
        $goods = $this->order_goods_info($id);
        for($i=0;$i<count($goods);$i++){
            $this->db->execute("update ".$this->infotableName." set stock_place = (select stock_place from ".CFG_DB_PREFIX."depot_stock where goods_id = '".$goods[$i]['goods_id']."' and shelf_id = (select shelf_id from ".CFG_DB_PREFIX."depot where is_main=1 and depot_id='".$depot_id."' )) where rec_id = ".$goods[$i]['rec_id']);
        }
                $this->db->update($this->tableName,array(
                        'shipping_id' => $shipping_id,
                        'depot_id' => $depot_id
                        ),'order_id='.intval($id));
    }
    /*****
    
    ***paypal流水搜索条件生成
    *****/
    function getpwhere($info){
        
        
    }
    /**
     * paypal流水总数
     *
     * @param string $where 条件
     * @return int
     */
    function getpOrderCount($where=null) {
        return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'paypal_order '.$where);
    }
    /**
     * 取Paypal列表
     *
     * @param int $from
     * @param int $to
     */
    function getPorderList($from,$to,$where=null)
    {
        $this->db->open('select * from '.CFG_DB_PREFIX . 'paypal_order '.$where.' order by ORDERTIME desc',$from,$to);
        $result = array();
        while ($rs = $this->db->next()) {
            $rs['ORDERTIME'] = MyDate::transform('standard',$rs['ORDERTIME']); 
            $result[] = $rs;
        }
        return $result;
    }
    /**************
    *
    * @param string $pid
    * @param array $order
    **************/
    function getPorder($pid)
    {
        return $this->db->getValue('SELECT * FROM '.CFG_DB_PREFIX . 'paypal_order WHERE paypalid = "'.$pid.'"');        
    }
    /**
     * 取得Paypal款单产品信息
     * @param   int     $order_id   paypalid）
     * @return  array   
     */
    function porder_goods_info($order_id){
        return $this->db->select("select '0' as rec_id,'0' as order_id,L_NAME as goods_name,L_NUMBER as goods_sn,L_NUMBER as item_no,L_QTY as goods_qty,L_AMT as goods_price from ".CFG_DB_PREFIX . "paypal_order_goods where paypalid ='".$order_id."'");
    }
    /**
     * 更改Paypal款单状态
     * @param   string     $pid   paypalid）
     * @return  bool
     */
    function changeporder($pid)
    {
        $this->db->execute("update ".CFG_DB_PREFIX . "paypal_order set status =1 where paypalid='".$pid."'");
    }
    /**
     * 自动匹配paypal交易流水与订单
     * 
     */
    function checktrans()
    {
        $id_list = $this->db->select("SELECT paypalid FROM ".CFG_DB_PREFIX . 'paypal_order WHERE status = 0');
        for($i=0;$i<count($id_list);$i++){
            if($this->db->getValue("SELECT count(order_id) FROM ".$this->tableName." WHERE paypalid='".$id_list[$i]."'")>0){
                $this->db->execute("DELETE FROM ".CFG_DB_PREFIX . "paypal_order WHERE paypalid='".$id_list[$i]."'");
                $this->db->execute("DELETE FROM ".CFG_DB_PREFIX . "paypal_order_goods WHERE paypalid='".$id_list[$i]."'");
            }
        }
    }
    /*****************
    ****获取订单日志
    ***int $id
    ***string $result
    *****************/
    function getlog($id)
    {
        $this->db->open("SELECT * FROM ".$this->logtableName . " WHERE order_id = ".$id." order by log_id desc");
        $result = "<div style='font-size:13px;font-family:Arial, Helvetica, sans-serif'>";
        $userlist = ModelDd::getArray("user");
        $status = ModelDd::getArray("orderstatus");
        while ($rs = $this->db->next()) {
            if(strstr($rs['content'],"订单状态被更改为")) $rs['content']= substr($rs['content'],0,-3).$status[substr($rs['content'],-3)];
            if(strstr($rs['content'],'order_status值由')) $rs['content']= substr($rs['content'],0,18).$status[substr($rs['content'],18,3)].substr($rs['content'],21,6).$status[substr($rs['content'],-3)];
            $result .= '<font color="#FF0000">'.$userlist[$rs['user_id']].'</font>于<font color="#3366FF">'.MyDate::transform('standard',$rs['addtime']).'</font>进行了'.$rs['action'].'操作,'.$rs['content']."<br>";
        }
        return $result.'</div>';
    }
    
    /*****************
    ****获取订单费用
    ***int $id
    ***string $result
    *****************/
    function getfee($id)
    {
        $order = $this->db->getValue("SELECT shipping_fee,FEEAMT,rate,order_amount,currency,Sales_channels,weight,FinalValueFee,shipping_cost FROM ".$this->tableName." where order_id = '".$id."'");
        $goodsfee = $this->getordergoodscost($id);
        $ordersize = $this->ordersize($id);
        $ordertotal = number_format($order['order_amount']*$order['rate'], 2, '.', '');
        $result .= "<div style='font-size:13px;font-family:Arial, Helvetica, sans-serif'>订单币种:".$order['currency'].'('.$order['rate'].")"."<br>";
        $result .= "产品总计:".$goodsfee."<br>";
        $result .= "实收运费:".$order['shipping_fee']*$order['rate']."<br>";
        $result .= "订单成交费:".number_format($order['FinalValueFee']*$order['rate'], 2, '.', '')."<br>";
        $result .= "订单手续费:".number_format($order['FEEAMT']*$order['rate'], 2, '.', '')."<br>";
        $result .= "订单总计:".$ordertotal."<br>";
        $result .= "预估重量:".$ordersize['weight']."<br>";
        $preshipping = $this->chargeshipping($id,$ordersize['weight']);
        $result .= "预估运费:".$preshipping."<br>";
        $result .= "实际重量:".$order['weight']."<br>";
        $result .= "实际运费:".$order['shipping_cost']."<br>";
        $rate = $this->db->getValue("SELECT rate,fix FROM ".CFG_DB_PREFIX."sales_channels_rate where sales_channels = '".$order['Sales_channels']."'");
        $channelfee = ModelSales::getchannelfee($ordertotal,$order['Sales_channels']);
        $result .= "渠道费用:".$channelfee."<br>";
        $interest =number_format((($order['order_amount']-$order['FinalValueFee']-$order['FEEAMT'])*$order['rate']-$preshipping-$goodsfee-$channelfee), 2, '.', '');
        $result .= "预估利润:".$interest.",利润率:".(($ordertotal==0)?0:floor($interest*100/$ordertotal))."%<br>(预估利润=订单总金额-成交费-手续费-产品成本-预估运费-渠道费用)<br>";
        $interest1 = number_format((($order['order_amount']-$order['FinalValueFee']-$order['FEEAMT'])*$order['rate']-$goodsfee-$order['shipping_cost']-$channelfee), 2, '.', '');
        $result .= "实际利润:".$interest1.",利润率:".(($ordertotal==0)?0:floor($interest1*100/$ordertotal))."%<br>(实际利润=订单总金额-成交费-手续费-产品成本-实际运费-渠道费用)";
        return $result.'</div>';
    }
    /*****************
    ****导入订单信息处理
    ***array $info
    ***string $result
    *****************/
    function saveimport($info)
    {
        $info = addslashes_deep($info);
        $order_id = $this->db->getValue("SELECT order_id FROM ".$this->tableName." WHERE Sales_account_id =".$info['Sales_account_id']." and paypalid='".$info['paypalid']."'");
        $sn_prefix = '';
        if(CFG_GOODSSN_PREFIX >0){
                $sn_prefix = substr($info['SKU'],0,CFG_GOODSSN_PREFIX);
                $info['SKU'] = substr($info['SKU'],CFG_GOODSSN_PREFIX);
            }
        if( $order_id){
            if($this->db->getValue("SELECT count(*) FROM ".$this->infotableName." where goods_name ='".$info['goods_name']."' and order_id = '".$order_id."'")> 0) return;
                    $this->db->insert($this->infotableName, array(
                                'order_id' => $order_id,
                                'goods_sn' => $this->getRealSKU($info['SKU']),
                                'sn_prefix' => $sn_prefix,
                                'item_no' => ($info['item_no']=='')?'280'.mt_rand(666152531,666252531):$info['item_no'],
                                'goods_name' => $info['goods_name'],
                                'goods_qty' => $info['goods_qty'],
                                'goods_weigth' => $info['goods_weigth'],
                                'goods_price' => $info['goods_price'],
                                'TransactionID' => $info['TransactionID']
                                ));
            }else{
            require_once(CFG_PATH_DATA . 'dd/currency.php');
            $info['countrycode'] = ($info['countrycode'] == '')?$this->getcountrycode($info['country']):$info['countrycode'];
            $this->db->insert($this->tableName, array(
                        'order_sn' => $this->get_order_sn(),
                        'userid' => $info['userid'],
                        'order_amount' => $info['order_amount'],
                        'currency' => $info['currency'],
                        'rate' =>$currency[$info['currency']],
                        'shipping_fee' => $info['shipping_fee'],
                        'Sales_account_id' => $info['Sales_account_id'],
                        'Sales_channels' => $info['Sales_channels'],
                        'sellerID' => ($info['sellerID'])?$info['sellerID']:(ModelDd::getCaption('allaccount',$info['Sales_account_id'])),
                        'paypalid' => $info['paypalid'],
                        'FEEAMT' => $info['FEEAMT'],
                        'consignee' => $info['consignee'],
                        'email' => $info['email'],
                        'pay_id' => $info['pay_id'],
                        'street1' => $info['street1'],
                        'street2' => $info['street2'],
                        'city' => $info['city'],
                        'state' => $info['state'],
                        'order_status' => $this->getorderflow(12)?$this->getorderflow(12):"112",
                        'country' => $info['country'],
                        'CountryCode' => $info['countrycode'],
                        'zipcode' => $info['zipcode'],
                        'tel' => $info['tel'],
                        'shipping_id' => $info['shipping_id'],
                        'ShippingService' => $info['ShippingService'],
                        'track_no' => $info['track_no'],
                        'sellsrecord' => $info['sellsrecord'],
                        'shipping_time' => ($info['shipping_time'] != '')?MyDate::transform('timestamp',$info['shipping_time']):0,
                        'end_time' => ($info['shipping_time'] != '')?MyDate::transform('timestamp',$info['shipping_time']):0,
                        'paid_time' => MyDate::transform('timestamp',$info['paid_time']),
                        'pay_note' => $info['pay_note'],
                        'add_time' => CFG_TIME,
                        'track_no_2' => $info['track_no_2'],
                        'client_id' => $info['client_id']
                        ));
                    $order_id = $this->db->getInsertId();        
                    $this->db->insert($this->infotableName, array(
                                'order_id' => $order_id,
                                'goods_sn' => $this->getRealSKU($info['SKU']),
                                'sn_prefix' => $sn_prefix,
                                'item_no' => ($info['item_no']=='')?'280'.mt_rand(666152531,666252531):$info['item_no'],
                                'goods_name' => $info['goods_name'],
                                'goods_weigth' => $info['goods_weigth'],
                                'goods_qty' => $info['goods_qty'],
                                'goods_price' => $info['goods_price'],
                                'TransactionID' => $info['TransactionID']
                                ));
        }
    }
    /*******************
    ******批量更新订单信息
    ******array $info  string $sn
    ******
    *******************/

    function updateimport($info,$id)
    {
        $info = addslashes_deep($info);
        $this->db->update($this->tableName,$info,'order_id="'.$id.'"');
    }
    
    /**************
    *获取订单处理流程状态
    ***$step 订单所处步骤 $type 返回数据格式
    ****return  $type =1 retur array $type =2 return string
    *************/
    function getorderflow($step,$type=2)
    {
        $array = require(CFG_PATH_CONF.'system/system.conf.php');
        $stp = $array['CFG_ORDER_'.$step];
        $status = str_replace(",","','",$stp);
        $ids = array();
/*        链接主数据库共享订单状态表*/
       
        if($type==1){
            $this->db->open("SELECT id,status FROM ".$this->statustableName." WHERE status in('".$status."')");
            while ($rs = $this->db->next()) {
                $ids[$rs['id']] = $rs['status'];
            }
            $ids[0] = '所有状态';
            return $ids;
        }else{
            $ids = $this->db->select("SELECT id FROM ".$this->statustableName." WHERE status in('".$status."')");
            return implode(",",$ids);        
        }
    }
    function getcolumn($step)
    {
        $array = require(CFG_PATH_DATA.'dd/ordercolumn.php');
        return $array[$step];
    }
    function saveprintlog($ids,$type)
    {
        $this->db->insert(CFG_DB_PREFIX.'order_print_log',array(
                'ids'=>$ids,
                'admin_id'=>$_SESSION['admin_id'],
                'type'=>$type,
                'addtime'=>CFG_TIME
                ));
    }
    
    function getRealSKU($sku)
    {
        $sku = trim($sku);
        if(CFG_PREFIX_GOODSSN > 0) $sku = substr($sku,CFG_PREFIX_GOODSSN);
        if(CFG_GOODSSN_SPLIT <> ''){
            $arrs = explode("&&&&",CFG_GOODSSN_SPLIT);
            for($i=0;$i<count($arrs);$i++)
            {
                $arr = explode($arrs[$i],$sku);
                $sku = $arr[0];
            }
        }
        if(CFG_OTHER_SKU == 1){
            $sku1 = $this->db->getValue("SELECT SKU FROM ".CFG_DB_PREFIX . "goods_sku WHERE out_sku ='".addslashes($sku)."'");
            if($sku1) $sku = $sku1;
        }
        if(CFG_GOODSSN_AUTOLENGTH == 1 && CFG_GOODSSN_LENGTH > 0) $sku = substr($sku,0,CFG_GOODSSN_LENGTH);
            return $sku;        
    }
    
    
    function getdepot($id)
    {
        $shipping_id = $this->db->getValue("SELECT shipping_id FROM ".$this->tableName." where order_id = ".$id);
        $depot = $this->db->getValue("SELECT depot_id FROM ".CFG_DB_PREFIX."shipping_depot WHERE shipping_id=".$shipping_id);
        if(!$depot) $depot = 0;
        return $depot;        
    }
    /***********************
    ******获取中文国家名
    ***********************/
    function  getCncountry($name)
    {
        return $this->db->getValue("SELECT cn_country FROM ".CFG_DB_PREFIX."country WHERE country ='".$name."'");
    }
    function getCountry($code){
        return $this->db->getValue("select country from ".CFG_DB_PREFIX."country WHERE code ='".$code."'");
    }
    /***********************
    ******订单均摊运费
    ***********************/
    function getavrshipping($id)
    {
        return $this->db->getValue("SELECT m.shipping_fee/sum(n.goods_qty) FROM ".CFG_DB_PREFIX."order as m right join ".CFG_DB_PREFIX."order_goods as n on m.order_id = n.order_id WHERE m.order_id =".$id);
    }
    /***********************
    ******订单尺寸重量
    ***********************/
    function ordersize($id)
    {
        return $this->db->getValue("SELECT max(n.l) as l,max(n.w) as w,sum(n.h*m.goods_qty) as h,sum(n.weight*m.goods_qty) as weight,sum(n.grossweight*m.goods_qty) as grossweight FROM ".$this->infotableName.' as m left join '.CFG_DB_PREFIX."goods as n on m.goods_sn = n.sku where  m.order_id ='".$id."'");
    }
    //判断订单异常
    function checkordernormal($id)
    {
        $amount1 = $this->db->getValue("SELECT sum(goods_qty*goods_price) from ".$this->infotableName." where order_id = ".$id);
        $amount2 = $this->db->getValue("SELECT sum(order_amount-shipping_fee) FROM ".$this->tableName." where order_id = ".$id);
        $type =0;
        if($amount1 > $amount2) $type = 1;//产品金额大于订单金额
        if($amount1 < $amount2) $type = 2;
        return $type;
    }
    
    
    /*********
    ***加载amazon普通订单文件
    ***
    **********/
    function loadamzfile($content,$id)
    {
        if(file_exists(CFG_PATH_DATA . 'ebay/az_' . $id .'.php')) require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
        require(CFG_PATH_DATA . 'dd/currency.php');    
        $saleschannel = $this->getsaleschannel($id);
        $trans = explode("\n",$content);
        for($i=1;$i<count($trans);$i++){
            $goods = explode("    ",$trans[$i]);
                        $info['paypalid'] = $goods[0];
                        if(trim($goods[70]) <> $saleschannel && $goods[70] <> '') continue;
                        if(!$info['paypalid']) continue;
                        $order_id = $this->db->getValue("SELECT order_id FROm ".$this->tableName." WHERE paypalid = '".$info['paypalid']."' and Sales_account_id =".$id);
                        $goodsinfo['OrderLineItemID'] = $goods[1];
                        if($this->db->getValue("SELECT count(*) FROm ".$this->infotableName." WHERE OrderLineItemID = '".$goodsinfo['OrderLineItemID']."' and order_id ='".$order_id."'")>0) continue;
                        if(!$order_id) {//已存在订单
                                $info['order_sn'] = $this->get_order_sn();
                                $info['paid_time'] = ModelSystem::exchageAMZtime($goods[3]);//MyDate::transform('timestamp',$goods[3]); 
                                $info['ShippingService'] = $goods[15];
                                $info['currency'] = $goods[10];                            //货币类型
                                $info['rate'] =$currency[$info['currency']];
                                $info['email'] = $goods[4];
                                $info['sellerID'] = @$MERCHANT_ID;
                                $info['consignee'] = $goods[16];
                                $info['street1'] = str_replace(chr(128).chr(168),'',$goods[17]);
                                $info['street2'] = str_replace(chr(128).chr(168),'',$goods[18]);
                                $info['city'] = $goods[20];
                                $info['state'] = $goods[21];
                                $info['CountryCode'] = $goods[23];
                                $info['country'] = $this->db->getValue("SELECT country FROM ".CFG_DB_PREFIX."country where code = '".$info['CountryCode']."'");
                                if($info['country'] == '') $info['country'] = $goods[23];
                                $info['zipcode'] = $goods[22];
                                $info['tel'] = $goods[24];
                                $info['userid'] = $goods[5];
                                $info['Sales_channels'] = 3;
                                $info['order_status'] = 112;
                                $info['Sales_account_id'] = $id;
                                $this->db->insert($this->tableName, addslashes_deep($info));
                                $order_id = $this->db->getInsertId();
                          }
                    $goodsinfo['order_id'] = $order_id;
                    $goodsinfo['item_no'] = $goods[1];
                    $goodsinfo['ebay_orderid'] = $info['paypalid'];
                    $SKU = $goods[7];
                    $goodsinfo['goods_sn'] = $SKU;
                    if(CFG_GOODSSN_PREFIX >0){
                        $goodsinfo['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
                        $goodsinfo['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
                    }else{
                        $goodsinfo['goods_sn'] = $this->getRealSKU($SKU);
                    }
                    $goodsinfo['goods_qty'] = $goods[9];
                    $goodsinfo['goods_price'] = $goodsinfo['goods_qty']?$goods[11]/$goodsinfo['goods_qty']:0;
                    $goodsinfo['goods_name'] = $goods[8];
                    $this->db->insert($this->infotableName,addslashes_deep($goodsinfo));
                    $this->db->execute("UPDATE ".$this->tableName." SET shipping_fee = shipping_fee + ".$goods[13].",order_amount = (order_amount+".$goods[13]."+".$goods[11].") where order_id =".$order_id);
        }
    }
    function loadamzunship($content,$id)
    {
        if(file_exists(CFG_PATH_DATA . 'ebay/az_' . $id .'.php')) require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
        $saleschannel = $this->getsaleschannel($id);
        require(CFG_PATH_DATA . 'dd/currency.php');    
        $trans = explode("\n",$content);
        for($i=1;$i<count($trans);$i++){
            $goods = explode("    ",$trans[$i]);
                        $info['paypalid'] = $goods[0];
                        if((trim($goods[24]) <> $saleschannel) && ($goods[24] <> '')) continue;
                        if(!$info['paypalid']) continue;
                        $order_id = $this->db->getValue("SELECT order_id FROm ".$this->tableName." WHERE paypalid = '".$info['paypalid']."' and Sales_account_id ='".$id."'");
                        $goodsinfo['OrderLineItemID'] = $goods[1];
                        if($this->db->getValue("SELECT count(*) FROm ".$this->infotableName." WHERE OrderLineItemID = '".$goodsinfo['OrderLineItemID']."' and order_id ='".$order_id."'")>0) continue;
                        if(!$order_id) {//已存在订单
                                $info['order_sn'] = $this->get_order_sn();
                                $info['paid_time'] = ModelSystem::exchageAMZtime($goods[3]);//MyDate::transform('timestamp',$goods[3]); 
                                $info['ShippingService'] = $goods[15];
                                $info['email'] = $goods[7];
                                $info['sellerID'] = @$MERCHANT_ID;
                                $info['consignee'] = $goods[16];
                                $info['street1'] = str_replace(chr(128).chr(168),'',$goods[17]);
                                $info['street2'] = str_replace(chr(128).chr(168),'',$goods[18]);
                                $info['city'] = $goods[20];
                                $info['state'] = $goods[21];
                                $info['CountryCode'] = $goods[23];
                                $info['country'] = $this->db->getValue("SELECT country FROM ".CFG_DB_PREFIX."country where code = '".$info['CountryCode']."'");
                                if($info['country'] == '') $info['country'] = $goods[23];
                                $info['zipcode'] = $goods[22];
                                $info['tel'] = $goods[9];
                                $info['userid'] = $goods[8];
                                $info['Sales_channels'] = 3;
                                $info['order_status'] = 112;
                                $info['Sales_account_id'] = $id;
                                $this->db->insert($this->tableName, addslashes_deep($info));
                                $order_id = $this->db->getInsertId();
                          }
                    $goodsinfo['order_id'] = $order_id;
                    $goodsinfo['item_no'] = $goods[1];
                    $SKU = $goods[10];
                    $goodsinfo['goods_sn'] = $SKU;
                    $goodsinfo['ebay_orderid'] = $info['paypalid'];
                    if(CFG_GOODSSN_PREFIX >0){
                        $goodsinfo['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
                        $goodsinfo['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
                    }else{
                        $goodsinfo['goods_sn'] = $this->getRealSKU($SKU);
                    }
                    $goodsinfo['goods_qty'] = $goods[14];
                    $goodsinfo['goods_price'] = 0;
                    $goodsinfo['goods_name'] = $goods[11];
                    $this->db->insert($this->infotableName,addslashes_deep($goodsinfo));
        }
    }
    
    function loadamzFBAfile($content,$id)
    {
        require(CFG_PATH_DATA . 'ebay/az_' . $id .'.php');
        require(CFG_PATH_DATA . 'dd/currency.php');
        $saleschannel = $this->getsaleschannel($id);
        $trans = explode("\n",$content);
        for($i=1;$i<count($trans);$i++){
            $goods = explode("    ",$trans[$i]);
                        $info['paypalid'] = $goods[0];
                        if(trim($goods[47]) <> $saleschannel && $goods[47] <> '') continue;
                        if(!$info['paypalid']) continue;
                        $order_id = $this->db->getValue("SELECT order_id FROM ".$this->tableName." WHERE paypalid = '".$info['paypalid']."' and Sales_account_id =".$id);
                        if(!$order_id) {//已存在订单
                                $info['order_sn'] = $this->get_order_sn();
                                $info['paid_time'] = ModelSystem::exchageAMZtime($goods[7]);//MyDate::transform('timestamp',$goods[7]); 
                                $info['ShippingService'] = 'AFN';
                                $info['currency'] = $goods[15];                            //货币类型
                                $info['rate'] =$currency[$info['currency']];
                                $info['email'] = $goods[10];
                                $info['sellerID'] = $MERCHANT_ID;
                                $info['consignee'] = $goods[24];
                                $info['street1'] = str_replace(chr(128).chr(168),'',$goods[25]);
                                $info['street2'] = str_replace(chr(128).chr(168),'',$goods[26]);
                                $info['city'] = $goods[28];
                                $info['state'] = $goods[29];
                                $info['CountryCode'] = $goods[30];
                                $info['country'] = $goods[31];
                                $info['zipcode'] = $goods[30];
                                $info['tel'] = $goods[32];
                                $info['userid'] = $goods[11];
                                $info['Sales_channels'] = 3;
                                $info['order_status'] = 131;
                                $info['is_mark'] = 1;
                                $info['print_status'] =1 ;
                                $info['stockout_sn'] = 'AllreadyMark';
                                $info['Sales_account_id'] = $id;
                                $info['track_no'] = $goods[43];
                                $info['shipping_time'] = MyDate::transform('timestamp',$goods[8]);
                                $this->db->insert($this->tableName, addslashes_deep($info));
                                $order_id = $this->db->getInsertId();
                          }
                    $goodsinfo['OrderLineItemID'] = $goods[4];
                    if($this->db->getValue("SELECT count(*) FROm ".$this->infotableName." WHERE OrderLineItemID = '".$goodsinfo['OrderLineItemID']."' and order_id ='".$order_id."'")>0) continue;
                    $goodsinfo['order_id'] = $order_id;
                    $goodsinfo['item_no'] = $goods[2];
                    $goodsinfo['ebay_orderid'] = $info['paypalid'];
                    $SKU = $goods[13];
                    $goodsinfo['goods_sn'] = $SKU;
                    if(CFG_GOODSSN_PREFIX >0){
                        $goodsinfo['sn_prefix'] = substr($SKU,0,CFG_GOODSSN_PREFIX);
                        $goodsinfo['goods_sn'] = $this->getRealSKU(substr($SKU,CFG_GOODSSN_PREFIX));
                    }else{
                        $goodsinfo['goods_sn'] = $this->getRealSKU($SKU);
                    }
                    $goodsinfo['goods_qty'] = $goods[15];
                    $goodsinfo['goods_price'] = $goods[17]/$goodsinfo['goods_qty'];
                    $goodsinfo['goods_name'] = $goods[14];
                    $this->db->insert($this->infotableName,addslashes_deep($goodsinfo));
                    $this->db->execute("UPDATE ".$this->tableName." SET order_amount = (order_amount+".$goods[17].") where order_id =".$order_id);
                if(CFG_AUTO_FBA == 1){
                    if($this->db->getValue("SELECT count(*) FROM ".$this->tableName." where is_lock =0 AND ShippingService='AFN' AND shipping_time >0 and order_id =".$order_id)){//没有扣除库存的
                        $this->check_rule($order_id);
                        $this->unlock($order_id,1,0);//扣除库存
                        $this->db->execute("update ".$this->tableName." set is_lock = 2 where order_id= ".$order_id);
                        }
                    }
        }
    }
    function getsaleschannel($id)
    {
        switch($this->db->getValue("SELECT site FROM ".CFG_DB_PREFIX."ebay_account where id = ".$id)){
            case 1:
            return 'Amazon.com';
            case 2:
            return 'Amazon.co.uk';
            case 3:
            return 'Amazon.de';
            case 4:
            return 'Amazon.fr';
            case 5:
            return 'Amazon.it';
            case 6:
            return 'Amazon.jp';
            case 7:
            return 'Amazon.cn';
            case 8:
            return 'Amazon.ca';
            case 9:
            return 'Amazon.es';
            default:
            return 'Amazon.ca';
        }
    }
    function getcountrycode($country)
    {
        $code = $this->db->getValue("SELECT code FROM ".CFG_DB_PREFIX."country where country = '".$country."'");
        return $code?$code:'US'; 
    }
    /**
     * 更新订单信息shipworks
     * @param   array  $info
     * @return  bool
     */
    function shipworksupdate($info){
        //$this->db->update($this->tableName,array());
        $this->db->execute("update ".$this->tableName." set track_no = '".$info[2]."' where order_sn= ".trim($info[0]));
    }
    function getPicklist($ids){
        $ordergoods = $this->db->select('select goods_sn,goods_qty from '.CFG_DB_PREFIX.'order_goods where order_id in ('.$ids.')');
        $goods = array();
         try {
            for($i=0;$i<count($ordergoods);$i++){
                $key = array_key_exists($ordergoods[$i]['goods_sn'],$goods);
                
                if($key){
                    $goods[$ordergoods[$i]['goods_sn']] = $goods[$ordergoods[$i]['goods_sn']]+$ordergoods[$i]['goods_qty'];
                }else{
                    $goods[$ordergoods[$i]['goods_sn']] = $ordergoods[$i]['goods_qty'];
                }
            }
            ksort($goods);
            $orderarr = explode(',',$ids);
            $html = '<div style="padding:10px;font-size:12px;" width="100%"><center><h2>拣货清单</h2></center>';
            $html .= '<table cellpadding="2" cellspacing="0" border="0" width="100%" height="50px">
                            <tr>
                                <td width="50%" align="left">制单人:<u> '.ModelUser::getName($_SESSION['admin_id']).'</u></td>
                                <td width="50%" align="right">制单日期：<u>'.date('Y-m-d',time()).'</u></td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border:1px solid #000;">
                            <tr height="50px" style="text-align:center;">
                                <td width="10%" style="border-right:1px solid #000;border-bottom:1px solid #000;">架号</td>
                                <td width="20%" style="border-right:1px solid #000;border-bottom:1px solid #000;">产品编码</td>
                                <td width="20%" style="border-right:1px solid #000;border-bottom:1px solid #000;">SKU</td>
                                <td width="10%" style="border-right:1px solid #000;border-bottom:1px solid #000;">数量</td>
                                <td width="40%" style="border-bottom:1px solid #000;">订单</td>
                            </tr>';
            //拼清单html
            foreach($goods as $key => $value){
                $stock_place = $this->db->getValue("select stock_place from myr_goods where goods_sn ='".$key."'");
                
                $html .= '<tr style="text-align:center;" valign="top">
                                <td height="50px" style="border-right:1px solid #000;border-bottom:1px solid #000;">&nbsp;'.$stock_place.'</td>
                                <td style="border-right:1px solid #000;border-bottom:1px solid #000;">&nbsp;'.$key.'</td>
                                <td style="border-right:1px solid #000;border-bottom:1px solid #000;">&nbsp;'.$this->db->getValue('select SKU from '.CFG_DB_PREFIX.'goods where goods_sn = \''.$key.'\'').'</td>
                                <td style="border-right:1px solid #000;border-bottom:1px solid #000;">&nbsp;'.$value.'</td>';
                
                
                $ogoods = $this->db->select('select o.order_sn,o.sellerID from '.CFG_DB_PREFIX.'order as o left join myr_order_goods as og  on o.order_id=og.order_id where o.order_id in ('.$ids.') and og.goods_sn = \''.$key.'\'');
                $html .=  '<td style="font-size:10px;border-bottom:1px solid #000;text-align:left;word-break:break-all; word-wrap:break-word;">';
                for($g=0;$g<count($ogoods);$g++){
                    
                    $html .=  '&nbsp;&nbsp;'.CFG_ORDER_PREFIX.$ogoods[$g]['order_sn'];
                }
                
                $html .= '</td></tr>';
            }
            
            return $html.'</table></div>';
            
        } catch (Exception $e) {
            throw new Exception($e->getMessage(),'999');exit();
        }
        
    }
    /**
    * 批量更新订单物流方式
    **/
    function updateshipping($info){
        $this->db->update(CFG_DB_PREFIX.'order',array('shipping_id' => $info['shipping_id']),"order_id in ( ".$info['id'].")");
    }
    /**
    * 清空订单track或pdf
    **/
    function cleareuborder($info){
        $this->db->update(CFG_DB_PREFIX.'order',array($info['type'] => ''),"order_id in ( ".$info['id'].")");
    }
    /**
    * 设置订单变为可标记状态
    **/
    function remark_order($ids){
        $id = explode(',',$ids);
        $id = array_unique($id);
        $msg = '';
        foreach($id as $k => $v){
            $this->db->update(CFG_DB_PREFIX.'order',array('is_mark' => 0),"paypalid = '".$v."'"." or order_sn = '".str_replace(CFG_ORDER_PREFIX,'',$v)."'");
        }
    }
    /* 
    * 获取当天追踪物流信息 
    */
    function gettrackCount($where=null)
    {
        return $this->db->getValue("SELECT * FROM ".CFG_DB_PREFIX."track_log order by id desc");
    }
    /*                     
    */
    function getPickListExport($ids)
    {
        $ordergoods = $this->db->select('select goods_sn,goods_qty from '.CFG_DB_PREFIX.'order_goods where order_id in ('.$ids.')');
        $goods = array();
         try {
            for($i=0;$i<count($ordergoods);$i++){
                $key = array_key_exists($ordergoods[$i]['goods_sn'],$goods);
                
                if($key){
                    $goods[$ordergoods[$i]['goods_sn']] = $goods[$ordergoods[$i]['goods_sn']]+$ordergoods[$i]['goods_qty'];
                }else{
                    $goods[$ordergoods[$i]['goods_sn']] = $ordergoods[$i]['goods_qty'];
                }
            }
            ksort($goods);
            $result = array();
            //拼清单html
            foreach($goods as $key => $value){
                
                $r = array(
                    'stock_place' => '',
                    'SKU' => $key,
                    'qty' => $value    
                );
                
                $ogoods = $this->db->select('select o.order_sn,o.sellerID from '.CFG_DB_PREFIX.'order as o left join myr_order_goods as og  on o.order_id=og.order_id where o.order_id in ('.$ids.') and og.goods_sn = \''.$key.'\'');
                $sn = '';
                for($g=0;$g<count($ogoods);$g++){
                    
                    $sn .=  '         '.CFG_ORDER_PREFIX.$ogoods[$g]['order_sn'];
                }
                
                $r['order_sns'] = $sn;
                $result[] = $r; 
            }                            
            return $result;
        } catch (Exception $e) {
            throw new Exception($e->getMessage(),'999');exit();
        }
    }
}
?>
