<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 订单管理
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
class Order extends Controller  {

    /**
     * 初始化页面信息
     */
    function __construct() {
        parent::__construct();
        $this->title .= '销售管理';
        $this->name = 'loadorder';
        $account = ModelDd::getArray('allaccount');
        if($_SESSION['account_list'] != 'all') {
            $ex_list = explode(",",$_SESSION['account_list']);
            for($i=0;$i<count($ex_list);$i++){
                if(!array_key_exists($ex_list[$i],$account)) unset($account[$ex_list[$i]]);
                }
        }
        $action_list = explode(',',$_SESSION['action_list']);
        $goods_right[] = in_array('view_cost',$action_list)?1:0;
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
        $this->tpl->assign('allaccount',ModelDd::arrayFormat($account));
        $this->tpl->assign('use_sn_prefix',CFG_GOODSSN_PREFIX);
        $this->dir = 'order';
    }
    
    /**
     * 默认页面---加载订单
     */
    function actionIndex() {
        parent::actionPrivilege('load_order');
        $d             = date('Y-m-d');
        $time1         = strtotime(date("Y-m-d",strtotime("$d -1 day")));
        $time2         = strtotime(date("Y-m-d",strtotime("$d -2 day")));
        $time        = date('Y-m-d',$time1);
        $time0        = date('Y-m-d',$time2);
        $this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
        $this->tpl->assign('amazonaccount',ModelDd::getComboData('amazonaccount'));
        $this->tpl->assign('zcaccount',ModelDd::getComboData('zcaccount'));
        $this->tpl->assign('tbaccount',ModelDd::getComboData('taobaoaccount'));
        $this->tpl->assign('paccount',ModelDd::getComboData('paypalaccount'));
        $this->tpl->assign('aliaccount',ModelDd::getComboData('aliaccount'));
        $this->tpl->assign('dhaccount',@ModelDd::getComboData('dhaccount'));
        $this->tpl->assign('mgaccount',@ModelDd::getComboData('mgaccount'));
        $this->tpl->assign('yesterday',$time);
        $this->tpl->assign('dday',$time0);
        $this->tpl->assign('today',$d);
        $this->show();
    }

    /**
     * 默认页面---订单添加和复制页面
     */
    function actionAdd() {
        parent::actionPrivilege('add_order');
        $this->tpl->assign('order_status',ModelDd::getComboData('orderstatus'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('payment',ModelDd::getComboData('payment'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('shippingstatus',ModelDd::getComboData('shippingstatus'));
        $object = new ModelOrder();
        if($_GET['id']){
            $rs = $object->order_info($_GET['id']);
            $rs['paid_time'] = date('Y-m-d');
            $rs['add_time'] = MyDate::transform('date',$rs['add_time']);
            $rs['track_no'] = "";
            $rs['order_id'] = "";
            $rs['paypalid'] = "";
            $rs['sellsrecord'] = "";
            $rs['shipping_fee'] = 0;
            $rs['FEEAMT'] = 0;
            $rs['order_amount'] = 0;
            $rs['from_order_id'] = $_GET['id'];
            $rs['from']=0;
        }elseif($_GET['paypalid']){
            $dt = $object->getPorder($_GET['paypalid']);
            $rs = array(
                    "order_id" => "",
                    "order_sn" => "",
                    "userid" => "",
                    "track_no" => "",
                    "shipping_fee" => 0,
                    "pay_id" => 1,
                    "FEEAMT" => $dt['FEEAMT'],
                    "order_amount" => $dt['AMT'],
                    "currency" => $dt['CURRENCYCODE'],
                    "Sales_channels" => 1,
                    "Sales_account_id" => 1,
                    "paypalid" => $dt['paypalid'],
                    "consignee" => $dt['consignee'],
                    "email" => $dt['email'],
                    "street1" => $dt['street1'],
                    "street2" => $dt['street2'],
                    "city" => $dt['city'],
                    "state" => $dt['state'],
                    "country" => $dt['country'],
                    "zipcode" => $dt['zipcode'],
                    "tel" => $dt['tel'],
                    "pay_note" => $dt['note'],
                    "is_lock" => 0,
                    "sellsrecord" => "",
                    "ShippingService" => "",
                    "paid_time" =>  MyDate::transform('date',$dt['ORDERTIME']),
                    "from" => 1,
                    "from_order_id" => $dt['paypalid']
                    );
        }else{
            $rs = array(
                    "order_id" => "",
                    "from_order_id" => "",
                    "order_sn" => "",
                    "userid" => "",
                    "track_no" => "",
                    "shipping_fee" => 0,
                    "pay_id" => 1,
                    "FEEAMT" => 0,
                    "order_amount" => 0,
                    "currency" => "USD",
                    "Sales_channels" => 1,
                    "Sales_account_id" => 1,
                    "paypalid" => "",
                    "consignee" => "",
                    "email" => "",
                    "street1" => "",
                    "street2" => "",
                    "city" => "",
                    "state" => "",
                    "country" => "",
                    "zipcode" => "",
                    "tel" => "",
                    "pay_note" => "",
                    "is_lock" => 0,
                    "sellsrecord" => "",
                    "ShippingService" => "",
                    "paid_time" => date("Y-m-d"),
                    "from" => 0
                    );
        }
        $rs['order_status'] = $object->getorderflow(12)?$object->getorderflow(12):"112";
        $rs['shipping_id'] ="0";
        $rs['order_sn'] = $object->get_order_sn();
        $rs['torder_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $order = $json->encode($rs);
        $this->tpl->assign('order',$order); 
        $this->name = 'order';
        $this->show();
    }
    /******
    *订单修改页面
    ******/
    function actionEdit() {
        parent::actionPrivilege('edit_order');
        $this->tpl->assign('order_status',ModelDd::getComboData('orderstatus'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('payment',ModelDd::getComboData('payment'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('shippingstatus',ModelDd::getComboData('shippingstatus'));
        $object = new ModelOrder();
            $rs = $object->order_info($_GET['id']);
            $rs['paid_time'] = MyDate::transform('date',$rs['paid_time']);
            $rs['add_time'] = MyDate::transform('date',$rs['add_time']);
        $rs['torder_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $order = $json->encode($rs);
        $this->tpl->assign('order',$order); 
        $this->name = 'editorder';
        $this->show();
    }

    /**
     * 订单保存
     */
    function actionSave(){
        if(parent::actionCheck('edit_order'))
        {
        $object = new ModelOrder();
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $goodsarr = $json->decode(stripslashes($_POST['data']));
        foreach($goodsarr as $goods){
            $goods->goods_name = addslashes_deep($goods->goods_name);
            if($goods->goods_name == "" || $goods->goods_sn == "") {
            echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
            }
        }
        $_POST['data'] = $goodsarr;
        try{
            $order_id =$object->saveOrder($_POST);
            echo "{success:true,msg:'".$order_id."'}";exit;    
        } catch (Exception $e) {
            echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
        }
        }
    }

    /**
     * 订单删除产品
     */
    function actiondelgoods(){
        $object = new ModelOrder();
        try{
            $object->delOrdergoods($_GET['rec_id']);
            echo "{success:true,msg:'删除产品成功,如未做其他修改无需进行订单保存操作'}";exit();
        } catch (Exception $e) {
            echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
        }
    }

    /**
     * 订单状态管理
     */
    function actionStatus() {
        parent::actionPrivilege('list_orderstatus');
        $this->tpl->assign('is_true',ModelDd::getComboData('is_true'));
        $this->tpl->assign('order_status',ModelDd::getComboData('orderstatus'));
        $this->tpl->assign('start_end',ModelDd::getComboData('start_end'));
        $this->name = 'orderstatus';
        $this->show();
    }

    /**
     * 自动审核页面
     */
    function actionCheckpaypal() {
        parent::actionPrivilege('check_paypal');
        $this->name = 'checkpaypal';
        $this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
        $this->show();
    }

    /**
     * 订单标记页面
     */
    function actionMarkorder() {
        parent::actionPrivilege('order_mark');
        $this->name = 'markorder';
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
        $this->tpl->assign('aliaccount',ModelDd::getComboData('aliaccount'));
        $this->tpl->assign('dhaccount',ModelDd::getComboData('dhaccount'));
        $this->show();
    }
    
    /**
     * paypal流水
     */
    function actionPaypal() {
        parent::actionPrivilege('paypal_order');
        $this->name = 'paypalorder';
        $this->tpl->assign('paccount',ModelDd::getComboData('paypalaccount'));
        $this->show();
    }
    /**
     * 获取paypal流水列表
     */
    function actionGetpaypalorder(){
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $where = $object->getpWhere($_REQUEST);
        $list = $object->getpOrderList($pageLimit['from'],$pageLimit['to'],$where);
        $result['totalCount'] = $object->getpOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);        
    }
    /**
     * 订单解锁页面
     */
    function actionUnlock() {
        parent::actionPrivilege('order_unlcok');
        $this->name = 'unlockorder';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $arr = ModelDd::getArray('orderstatus');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(6));
        array_pop($arr);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }

    /**
     * 客服审核页面
     */
    function actionServicecheck() {
        parent::actionPrivilege('service_check');
        $this->name = 'servicecheck';
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(1));
        $arr = $object->getorderflow(1,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }

    /**
     * 库管审核页面
     */
    function actionDepotmanager() {
        parent::actionPrivilege('depot_check');
        $this->name = 'depotmanager';
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(2));
        $arr = $object->getorderflow(2,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }

    /**
     * 库管缺货EUB页面
     */
    function actionDepoteub() {
        parent::actionPrivilege('depot_check');
        $this->name = 'depoteub';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(13));
        $arr = $object->getorderflow(13,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }

    /**
     * 价格审批页面
     */
    function actionOrdercheck() {
        parent::actionPrivilege('order_check');
        $this->name = 'ordercheck';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(2));
        $arr = $object->getorderflow(14,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 订单处理页面
     */
    function actionOrderhandle() {
        parent::actionPrivilege('order_handle');
        $this->name = 'orderhandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(3));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    
    /**
     * 缺货订单页面
     */
    function actionOfsorder() {
        parent::actionPrivilege('order_ofs');
        $this->name = 'Ofsorder';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(9));
        $arr = $object->getorderflow(9,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 拣货订单页面
     */
    function actionPickuporder() {
        parent::actionPrivilege('order_pickup');
        $this->name = 'pickuporder';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(8));
        $arr = $object->getorderflow(8,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 已发货订单页面
     */
    function actionshippinghandle() {
        parent::actionPrivilege('order_shippinged');
        $this->name = 'shipedorder';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('shippingstatus',ModelDd::getComboData('shippingstatus'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(17));
        $arr = $object->getorderflow(17,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * E邮宝订单处理页面
     */
    function actionEubhandle() {
        parent::actionPrivilege('eub_order_handle');
        $this->name = 'eubhandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 线下E邮宝订单处理页面
     */
    function actionEub1handle() {
        parent::actionPrivilege('eub1_order_handle');
        $this->name = 'eubhandle1';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    
    /**
     * 4px订单处理页面
     */
    function action4pxhandle() {
        parent::actionPrivilege('list_4px');
        $this->name = '4pxhandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));      
        $moreshippings = ModelSystem::get('CFG_MORE_SHIPPINGS');      //是否使用物流多账号   
        $this->tpl->assign('is_more_ships_account',$moreshippings);  
        $ships_account = array();  
        if($moreshippings){ 
            $ships_account = array(
                'DZ7552200' => ModelSystem::get('CFG_4PX_TOKEN'),
                'DZ7551614' => ModelSystem::get('CFG_4PX_TOKEN2'),
            
            );         
        }
        $this->tpl->assign('ships_account',ModelDd::arrayFormat($ships_account));
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 互联易香港小包处理页面
     */
    function actionicehkhandle(){
        
        //if($_SERVER['REMOTE_ADDR'] !== '183.49.57.137'){ header('location:http://www.cpowersoft.com/blog/?page_id=1605'); }
        
        parent::actionPrivilege('list_icehkpost');
        $this->name = 'icehkposthandel';
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.szice.net');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        
        $moreshippings = ModelSystem::get('CFG_MORE_SHIPPINGS');      //是否使用物流多账号   
        $this->tpl->assign('is_more_ships_account',$moreshippings);  
        $ships_account = array(); 
        
         
        if($moreshippings){ 
            $ships_account = array(
                'lyzb电子' => ModelSystem::get('CFG_TOKEN_ICE'),
                'tsm珠宝' => ModelSystem::get('CFG_TOKEN_ICE2'),
            
            );         
        }
        $this->tpl->assign('ships_account',ModelDd::arrayFormat($ships_account));
        
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * SFC订单处理页面
     */
    function actionsfchandle() {
        parent::actionPrivilege('list_sfc');
        $this->name = 'sfchandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.sfcservice.com');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 出口易订单处理页面
     */
    function actionck1handle() {
        parent::actionPrivilege('list_ck1');
        $this->name = 'ck1handle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://yewu.chukou1.cn/store/login.aspx');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 易通关订单处理页面
     */
    function actionytghandle() {
        parent::actionPrivilege('list_ytg');
        $this->name = 'ytghandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://sys.etg56.com:8989/ytg/client');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    
    /**
     * 德国DHL订单处理页面
     */
    function actiondedhlhandle() {
        parent::actionPrivilege('list_dedhl');
        $this->name = 'dedhlhandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.dhl.de');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    
    /**
     * 退款处理页面
     */
    function actionRefund() {
        parent::actionPrivilege('order_refund');
        $this->name = 'refund';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(10));
        $arr = $object->getorderflow(10,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * USPS订单处理页面
     */
    function actionuspshandle() {
        //parent::actionPrivilege('list_usps');
        $this->name = 'uspshandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.usps.com');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 获取USPS待处理订单列表
     */
    function actionGetuspshandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('USPS');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    
    
    
    
    /**
     * 货到付款处理页面
     */
    function actionCod() {
        parent::actionPrivilege('order_cod');
        $this->name = 'cod';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(11));
        $arr = $object->getorderflow(11,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 所有订单处理页面
     */
    function actionAllorder() {
        parent::actionPrivilege('order_all');
        $this->name = 'allorder';
        $this->tpl->assign('reason',ModelDd::getComboData('rma_reason'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(0));
        $arr = ModelDd::getArray('orderstatus');
        array_pop($arr);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    
    /**
     * 打印页面
     */
    function actionPrint(){
        include CFG_PATH_DATA.'ebay/eub_address.php';
        $this->tpl->assign('params',$params2);
        if($_GET['type']>900){
            $this->name = 'print_mainland';
        }else{
            $this->name = 'orderprint'.((CFG_RUN_MODE ==1)?'_'.$_SESSION['company']:'');
        }
        $object = new ModelOrder();
        $where = $object->getWhere('','',$_POST['ids']);
        $list = $object->getOrderList('',count(explode(',',$_POST['ids'])),$where,'',0,0,0,$_GET['printsort']);
        $shipping = ModelDd::getArray('shipping');
        $Sales_channels = ModelDd::getArray('Sales_channels');
        for($i=0;$i<count($list);$i++){                          
            $total = 0;
            $totalprice = 1;
            $list[$i]['goodsarr'] = $object->order_goods_info($list[$i]['order_id']);
            $good_printstr ='';
            $good_eubstr ='';
            $goodspricei = 0;
            $total_ali_qty = 0;
            
            //商品数量
            $goodstotalqty = 0;
            
                        
            for($j=0;$j<count($list[$i]['goodsarr']);$j++){
                
                
                
                
                
                if($j<30) $good_eubstr .= ','.$list[$i]['goodsarr'][$j]['goods_sn'].'&'.$list[$i]['goodsarr'][$j]['goods_qty'];
                if(($j %3 != 0)) $good_printstr .= '---';
                $good_printstr .=  $list[$i]['goodsarr'][$j]['goods_sn'].'&'.$list[$i]['goodsarr'][$j]['goods_qty'];
                if(($j+1) % 3 == 0&& $j != 0) $good_printstr .= '<br>';
                $goods = new ModelGoods();
                $depot = $object->getdepot($list[$i]['order_id']);
                $goodsinfo = $goods->goods_info('',$list[$i]['goodsarr'][$j]['goods_sn'],$depot);
                $dec_val_total = 0;
                $dec_weight_total = 0;
                if(CFG_IMPORT_CUSTOMS){
                    $list[$i]['goodsarr'][$j]['location'] = $goodsinfo['stock_place'];
                    $list[$i]['goodsarr'][$j]['goods_title'] = $list[$i]['goodsarr'][$j]['goods_name'];
                    $list[$i]['goodsarr'][$j]['goods_name'] = $list[$i]['goodsarr'][$j]['goods_name'];
                    $list[$i]['goodsarr'][$j]['dec_name'] = $list[$i]['goodsarr'][$j]['goods_name'];
                    $list[$i]['goodsarr'][$j]['dec_name_cn'] = CFG_DEC_NAME_CN;
                    $list[$i]['goodsarr'][$j]['Declared_value'] = $list[$i]['goodsarr'][$j]['goods_price'];
                    $list[$i]['goodsarr'][$j]['goods_price'] = $list[$i]['goodsarr'][$j]['goods_price'];    
                }else{
                    if($goodsinfo){
                        $list[$i]['goodsarr'][$j]['location'] = $goodsinfo['stock_place'];
                        $list[$i]['goodsarr'][$j]['goods_title'] = $list[$i]['goodsarr'][$j]['goods_name'];
                        $list[$i]['goodsarr'][$j]['goods_name'] = $goodsinfo['goods_name'];
                        $list[$i]['goodsarr'][$j]['dec_name'] = $goodsinfo['dec_name'];
                        $list[$i]['goodsarr'][$j]['dec_name_cn'] = $goodsinfo['dec_name_cn'];
                        $list[$i]['goodsarr'][$j]['Declared_value'] = $goodsinfo['Declared_value'];
                        $list[$i]['goodsarr'][$j]['Declared_weight'] = $goodsinfo['Declared_weight'];
                        $list[$i]['goodsarr'][$j]['total_dec_weight'] = $goodsinfo['Declared_weight'] * $list[$i]['goodsarr'][$j]['goods_qty'];
                    }else{
                        $list[$i]['goodsarr'][$j]['location'] = $goodsinfo['stock_place'];
                        $list[$i]['goodsarr'][$j]['goods_title'] = $list[$i]['goodsarr'][$j]['goods_name'];
                        $list[$i]['goodsarr'][$j]['goods_name'] = $list[$i]['goodsarr'][$j]['goods_name'];
                        $list[$i]['goodsarr'][$j]['dec_name'] = CFG_DEC_NAME;
                        $list[$i]['goodsarr'][$j]['dec_name_cn'] = CFG_DEC_NAME_CN;
                        $list[$i]['goodsarr'][$j]['Declared_value'] = CFG_DECLARED_VALUE; 
                        $list[$i]['goodsarr'][$j]['Declared_weight'] = $goodsinfo['Declared_weight'];
                    }
                        
                    if($list[$i]['goodsarr'][$j]['dec_name']=='')$list[$i]['goodsarr'][$j]['dec_name'] = CFG_DEC_NAME;    
                    if($list[$i]['goodsarr'][$j]['dec_name_cn']=='')$list[$i]['goodsarr'][$j]['dec_name_cn'] = CFG_DEC_NAME_CN;    
                    if($list[$i]['goodsarr'][$j]['Declared_value']==0)$list[$i]['goodsarr'][$j]['Declared_value'] = CFG_DECLARED_VALUE;    
                    if($list[$i]['goodsarr'][$j]['Declared_weight']==0)$list[$i]['goodsarr'][$j]['Declared_weight'] = CFG_DECLARED_WEIGHT;    
                        
                }
                
                
               
                $list[$i]['goodsarr'][$j]['vargoods_price'] = rand(1,10)/10;
                $list[$i]['goodsarr'][$j]['goods_attribute'] = $list[$i]['goodsarr'][$j]['goods_attribute'];
                
                /* 1014-07-06 更新报关 */ 
                $list[$i]['goodsarr'][$j]['total_dec_val'] = $list[$i]['goodsarr'][$j]['Declared_value'] * $list[$i]['goodsarr'][$j]['goods_qty'];
                $list[$i]['goodsarr'][$j]['total_weight_val'] = $list[$i]['goodsarr'][$j]['Declared_weight'] * $list[$i]['goodsarr'][$j]['goods_qty'];
                $dec_val_total += $list[$i]['goodsarr'][$j]['total_dec_val'];
                $dec_weight_total += $list[$i]['goodsarr'][$j]['total_weight_val'];
                /* 1014-07-06 更新报关 */ 
                
                $total += $list[$i]['goodsarr'][$j]['goods_qty'];
                $totalprice += $list[$i]['goodsarr'][$j]['goods_qty']*$list[$i]['goodsarr'][$j]['goods_price'];
                $vartotalprice += $list[$i]['goodsarr'][$j]['goods_qty']*$list[$i]['goodsarr'][$j]['vargoods_price'];
                    
            }
            //$list[$i]['country'] = $object->getCountry($list[$i]['country']);
            $list[$i]['area']    =(substr($list[$i]['zipcode'],0,1)<8)?1:2;
            
            $zip = $list[$i]['zipcode'];
            $zip0 = explode("-",$zip);
            if(count($zip0) >=2){
                $zip = $zip0[0];
            }
            $isd = substr($zip,0,1);
            if($isd>=6){
                $isd = '2';
            }else{
                $isd = '1';    
            }
            
            $list[$i]['isd'] = $isd;
            
            
            $list[$i]['Cncountry']    = $object->getCncountry($list[$i]['country']);
            $ywtrackno2 = explode('_',$list[$i]['track_no_2']);                                          
            $list[$i]['yw_logistic_no'] =  $ywtrackno2[0];                       
            $list[$i]['yw_no'] =  '';                       
            $yw_ping = array(
                '美国' => array('平7','A'),   
                '英国' => array('平8','A'),   
                '俄罗斯' => array('平9','A'),   
                '巴西' => array('平10','A'),   
                '澳大利亚' => array('平11','A'),   
                '法国' => array('平12','A'),   
                '加拿大' => array('平13','A'),   
                '西班牙' => array('平14','A'),   
                '德国' => array('平15','A'),   
                '以色列' => array('平16','A'),   
                '瑞典' => array('平17','A'),   
                '挪威' => array('平18','A'),     
                '阿根廷' => array('平29','A'),     
                '乌克兰' => array('平20','A'),     
                '荷兰' => array('平21','A'),     
                '匈牙利' => array('平21','A'),     
                '克罗地亚' => array('平21','A')
            );      
            $list[$i]['yw_no'] .= @array_key_exists($list[$i]['Cncountry'],$yw_ping) ? $yw_ping[$list[$i]['Cncountry']][0] .$yw_ping[$list[$i]['Cncountry']][1] : '平1  B';
            $yw_xu = array(
                "俄罗斯"  =>   "序1",
                "美国"  =>   "序2",
                "巴西"  =>   "序3",
                "英国"  =>   "序4",
                "瑞典"  =>   "序5",
                "澳大利亚"  =>   "序6",
                "阿根廷"  =>   "序7",
                "乌克兰"  =>   "序8",
                "日本"  =>   "序9",
                "以色列"  =>   "序10",
                "加拿大"  =>   "序11",
                "挪威"  =>   "序12",
                "西班牙"  =>   "序13",
                "法国"  =>   "序14",
                "德国"  =>   "序15",
                "土耳其"  =>   "序16",
                "意大利"  =>   "序17",
                "芬兰"  =>   "序18",
                "比利时"  =>   "序19",
                "智利"  =>   "序20",
                "克罗地亚"  =>   "序21",
                "捷克"  =>   "序22",
                "希腊"  =>   "序23",
                "台湾"  =>   "序24",
                "匈牙利"  =>   "序25",
                "葡萄牙"  =>   "序26",
                "爱尔兰"  =>   "序27",
                "丹麦"  =>   "序28",
                "荷兰"  =>   "序29",
                "白俄罗斯"  =>   "序30",
                "墨西哥"  =>   "序31",
                "拉脱维亚"  =>   "序32 ",
                "波兰"  =>   "序33",
                "斯洛伐克"  =>   "序34",
                "立陶宛"  =>   "序35",
                "新加坡"  =>   "序36",
                "奥地利"  =>   "序37",
                "马耳他"  =>   "序38",
                "爱沙尼亚"  =>   "序39",
                "保加利亚"  =>   "序40",
                "其他"  =>   "序41"
            );
            
            $list[$i]['yw_no'] .= @array_key_exists($list[$i]['Cncountry'],$yw_xu) ? $yw_xu[$list[$i]['Cncountry']] : '序 41';     
            $list[$i]['phone'] = $list[$i]['tel'];
            $telstr=explode(',',$list[$i]['tel']);
            $list[$i]['tel'] = strlen($telstr[0])>5 ? $telstr[0] : $telstr[1];
            
                                          
            $list[$i]['good_eubstr']    =substr($good_eubstr,1);
            $list[$i]['Sales_channels'] = $Sales_channels[$list[$i]['Sales_channels']];
            $list[$i]['shipping'] = $shipping[$list[$i]['shipping_id']];
            $list[$i]['good_printstr']    =$good_printstr;
            $list[$i]['total']    = $total;
            $list[$i]['vartotalprice']    = number_format($totalprice, 2, '.', '');
            $list[$i]['pricei']    = $goodspricei;
            $list[$i]['allaccount'] = ModelDd::getCaption('allaccount',$list[$i]['Sales_account_id']);
            /* 1014-07-06 更新报关 */
            $list[$i]['dec_val_total'] = $dec_val_total;
            $list[$i]['dec_weight_total'] = $dec_weight_total;
        }
        $object->updataprtstatus($_POST['ids']);
        $object->saveprintlog($_POST['ids'],$_GET['type']);
        $this->tpl->assign('today',date('M-d-Y'));
        $this->tpl->assign('orders',$list);
        $this->tpl->assign('type',$_GET['type']);
        $this->show();    
    }

    function actiongeteubapply()
    {
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $modelgoods = new ModelGoods();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('EUB');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $count = $object->getOrderCount($where);
        $list = $object->getOrderList(0,$count,$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        require_once(CFG_PATH_DATA . 'ebay/eub_address.php');
        $this->tpl->assign('deliver',$params2);
        for($i=0;$i<count($list);$i++){
            $goods_info = $object->order_goods_info($list[$i]['order_id'],0);
            $goodsarr = array();
                for($j=0;$j<count($goods_info);$j++){
                    $getgoods = $modelgoods->goods_info('',$goods_info[$j]['goods_sn']);
                    $eubgoods['dec_name'] = ($getgoods['dec_name']<>'')?$getgoods['dec_name']:CFG_DEC_NAME;
                    $eubgoods['dec_name_cn'] = ($getgoods['dec_name_cn']<>'')?$getgoods['dec_name_cn']:CFG_DEC_NAME_CN;
                    $eubgoods['Declared_value'] = ($getgoods['Declared_value']>0)?$getgoods['Declared_value']:CFG_DECLARED_VALUE;
                    $eubgoods['weight'] = CFG_DECLARED_WEIGHT*$goods_info[$j]['goods_qty'];
                    $eubgoods['qty'] = $goods_info[$j]['goods_qty'];
                    $goodsarr[] = $eubgoods;
                }
                $list[$i]['goods'] = $goodsarr;
        }
        $this->tpl->assign('orders',$list);
        $this->name = 'eubApply';
        $this->show();    
    }
    /**
     * -订单状态列表
     */
    function actionListStatus() {
        parent::actionTableList('order_status','ModelOrder');
    }

    /**
     * 保存状态列表的修改
     */
    function actionSaveStatus() {
        try{
        $object = new ModelOrder();
        $object->savestatus($_POST);
            echo "{success:true,msg:'OK'}";exit;    
        } catch (Exception $e) {
            echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
        }
    }

        /**
     * Ebay订单加载
     */
    function actionLoad() {
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
            $object = new ModelChannel();
            try {
                $msg = explode('|',$object->saveEbayorder($_GET));
                echo '<br>共有'.$msg[1].'页共'.$msg[2].'条记录';
                if($msg[1] == 0) die('<br>加载完成');
                for($i=1;$i<=$msg[1];$i++){
                    $info['id'] = $_GET['id'];
                    $info['page'] = $i;
                    $msg1 = $object->loadXml($info);
                    echo "<br>第".$i."页加载完成，共有".$msg1."个订单被加载";
                    //if($i == $msg[1]) echo '<br>开始分析多产品订单<br>'.$object->saveSuborder($_GET);
                }
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
    }
    /**
     * Amazon订单加载
     */
    function actionLoadaz() {
            $object = new ModelChannel();
            try {
                $msg = $object->saveazorder($_GET);
                echo '共有'.$msg.'页订单被加载<br>开始加载订单产品<br>';
                if($msg) echo $object->loadazorderitem($_GET)."个订单加载产品";
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }    
    
    function actionloadazitem()
    {
            $object = new ModelChannel();
            try {
                echo $object->loadazorderitem($_GET)."个订单加载产品";
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
    
    /**
     * 淘宝订单加载
     */
    function actionLoadtb() {
            $object = new ModelChannel();
            try {
                $msg = explode('|',$object->savetborder($_GET));
                echo '<br>共有'.$msg[1].'页共'.$msg[2].'条记录';
                if($msg[1] == 0) die('<br>加载完成');
                for($i=1;$i<=$msg[1];$i++){
                    $info['id'] = $_GET['id'];
                    $info['page'] = $i;
                    $msg1 = $object->loadtbXml($info);
                    echo "<br>第".$i."页加载完成，共有".$msg1."个订单被加载";
                }
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
    /**
     * paypal订单加载
     */
    function actionLoadpaypal() {
            $object = new ModelChannel();
            try {
                $msg = $object->savePaypalorder($_GET);
                echo $msg;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
    
    /**
     * zencart订单加载
     */
    function actionLoadzc() {
        $object = new ModelChannel();
        try {
            $msg = $object->savezcorder($_GET);
            echo '共有'.$msg.'条订单被加载';
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }    
    /**
     * 加载magento订单
     */
    function actionLoadmagento() {
        $object = new ModelChannel();
        try {
            $msg = $object->savemgorder($_GET);
            echo '共有'.$msg.'条订单被加载';
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
    /**
     * 获取待自动审核列表
     */
    function actionWaitcheck() {
        $object = new ModelOrder();
        $list = $object->waitCheckList();
        $result['topics'] = $list;
        
        echo $json->encode($result);
    }
    /**
     * 自动审核
     */
    function actionAjaxpaypal() {
        $object = new ModelChannel();
        try {
            $msg = $object->ajaxPaypal($_POST);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "<br>自动与paypal订单核对过程中发生以下错误:$errorMsg";exit;
    }

    /**
     * 获取客服审核列表
     */
    function actionGetserviceorder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(1,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,1,0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }

    /**
     * 获取库管审核列表
     */
    function actionGetdepotorder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(2,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,1,1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    function actionGetdepoteub()
    {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(13,2);
        $shipping_ex = $object->getExshipping('EUB');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    /**
     * 获取待处理订单列表
     */
    function actionGetordercheck() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(14,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }    
    /**
     * 获取待处理订单列表
     */
    function actionGetorderhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);   
        $shipping_ex = $object->getExshipping();
        $where = $object->getWhere($_REQUEST,$status,'',$shipping_ex);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    /**
     * 获取缺货订单列表
     */
    function actionGetOfsorder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(9,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,0,1,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取EUB待处理订单列表
     */
    function actionGeteubhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('EUB');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取线下EUB待处理订单列表
     */
    function actionGeteubhandle1() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('EUB-1');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取互联易香港小包待处理订单列表
     */
    function actionGeticehkhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('ICE');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    /**
     * 获取4px待处理订单列表
     */
    function actionGet4pxhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('4PX');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取SFC待处理订单列表
     */
    function actionGetsfchandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('SFC');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取ck1待处理订单列表
     */
    function actionGetck1handle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('CHUKOU1');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取易通关待处理订单列表
     */
    function actionGetytghandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('YTG');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取DEDHL待处理订单列表
     */
    function actionGetdedhlhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('DEDHL');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取拣货状态订单列表
     */
    function actionGetPickuporder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(8,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取发货状态订单列表
     */
    function actionGetShipedorder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(17,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 获取买家信息
     */
    function actiongetBuyer() {
        $object = new ModelOrder();
        $result = $object->buyer_info($_REQUEST['order_id']);
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    
    /**
     * 获取订单产品信息
     */
    function actiongetOrdergoods() {
        $object = new ModelOrder();
        $type = isset($_REQUEST['type'])?1:0;
        $list = $object->order_goods_info($_REQUEST['order_id'],$type);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 获取paypal款单产品信息
     */
    function actiongetpOrdergoods() {
        $object = new ModelOrder();
        $list = $object->porder_goods_info($_POST['order_id']);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }

    /**
     * 更改订单状态
     */
    function actionupdateStatus() {
        if(parent::actionCheck('edit_orderstatus'))
        {
            $object = new ModelOrder();
            try {
                    if($_POST['step'] == 'servicecheck') $status = $object->getorderflow(1,2);
                    
                    elseif($_POST['step'] == 'deportmanager') $status = $object->getorderflow(2,2);
                    
                    elseif($_POST['step'] == 'ordercheck') $status = $object->getorderflow(14,2);
                    elseif($_POST['step'] == 'cod') $status = $object->getorderflow(11,2);
                    elseif($_POST['step'] == 'refund') $status = $object->getorderflow(10,2);
                    elseif($_POST['step'] == 'ofsorder') $status = $object->getorderflow(9,2);
                    elseif($_POST['step'] == 'pickuporder') $status = $object->getorderflow(8,2);
                    elseif($_POST['step'] == 'orderhandle_waitprint') $status = $object->getorderflow(19,2);
                    elseif($_POST['step'] == 'allorder') $status = NULL;
                    else $status = $object->getorderflow(3,2);
                $msg = $object->updateStatus($_POST,$status);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
        }
    }
    /***************
    ****解锁订单
    ***************/
    function actionunlockorder()
    {
            $object = new ModelOrder();
            try {
                if(isset($_GET['id'])) $msg = $object->unlock($_GET['id']);
                if(isset($_GET['ids'])) {
                    $id_arr = explode(",",$_GET['ids']);
                    for($i=0;$i<count($id_arr);$i++){
                        $msg .= $object->unlock($id_arr[$i]);
                    }
                }
                echo "{success:true,msg:'订单解锁成功'}";exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "{success:false,msg:'解锁过程中发生以下错误:$errorMsg'}";exit;
    }
    /**
     * 获取e邮宝追踪单号
     */
    function actiongeteubtrack() {
        set_time_limit(300);
            $object = new ModelDelivery();
            try {
                $msg = $object->getEUBtrack($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
     * 获取线下e邮宝追踪单号
     */
    function actiongeteubtrack1() {
        set_time_limit(300);
            $object = new ModelDelivery();
            try {
                $msg = $object->getEUBtrack1($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
     *提交USPS
     */
    function actionupdateusps() {
        set_time_limit(300);
            $object = new ModelDelivery();
            try {
                $msg = $object->getUSPS($_POST);
                //var_dump($msg);exit();
                echo $msg;exit;
            } catch (Exception $e) {
                $errorMsg = $e->getMessage();
            }
            echo "发生以下错误:$errorMsg";exit;
    }
    /**
     *批量合并订单pdf
     */
    function actionopenpdfs() {
        set_time_limit(300);
            $object = new ModelDelivery();
            try {
                $msg = $object->getUSPS($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                $errorMsg = $e->getMessage();
            }
            echo "发生以下错误:$errorMsg";exit;
    }
    /**
     * 获取e邮宝pdf
     */
    function actiongeteubpdf() {
            $object = new ModelDelivery();
            try {
                $msg = $object->getEUBpdf($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "获取过程中发生以下错误:$errorMsg";exit;
    }
    /**
     * 获取线下e邮宝zip
     */
    function actiongeteubzip() {
            $object = new ModelDelivery();
            try {
                $msg = $object->getEUBzip($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "获取过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
    **更新EUB订单处理完成
    **/
    function actionupdateEUB()
    {
            $object = new ModelDelivery();
            try {
                $msg = $object->updateEUB($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
    **取消EUB订单处理完成
    **/
    function actioncancelEUB()
    {
            $object = new ModelDelivery();
            try {
                $msg = $object->cancelEUB($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
    **更新4px订单处理完成
    **/
    function actionupdate4px(){
        $object = new ModelDelivery();
        try {
            if($_POST['type'] == 0) $msg = $object->get4pxtrack($_POST);
            if($_POST['type'] == 1) $msg = $object->Create4pxOrder($_POST);
            if($_POST['type'] == 2) $msg = $object->PreAlert4pxOrder($_POST);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
    **更新英仓订单处理完成
    **/
    function actionupdatededhl()
    {
        set_time_limit(100);
            $object = new ModelDelivery();
            try {
                $msg = $object->getDEDHL($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
    **更新美仓订单处理完成
    **/
    function actionupdatecool()
    {
            $object = new ModelDelivery();
            try {
                $msg = $object->uploadcool($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
    **更新英仓订单处理完成
    **/
    function actionupdatebird()
    {
            $object = new ModelDelivery();
            try {
                $msg = $object->uploadbird($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
    **三态订单处理完成
    **/
    function actionupdatesfc(){
            $object = new ModelDelivery();
            try {
                $msg = $object->uploadsfc($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
    **出口易订单处理完成
    **/
    function actionupdateck1()
    {
            $object = new ModelDelivery();
            try {
                $msg = $object->uploadck1($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
    **出口易订单处理完成
    **/
    function actioncompleteck1(){
        $object = new ModelDelivery();
        try {
            $msg = $object->completeck1($_POST);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    
    /**
    **易通关订单处理完成
    **/
    function actionupdateytg()
    {
            $object = new ModelDelivery();
            try {
                if($_POST['type'] == 1) $msg = $object->CreateytgOrder($_POST);
                if($_POST['type'] == 2) $msg = $object->PreAlertytgOrder($_POST);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    function actioncompletecool()
    {
        set_time_limit(1000);
            $object = new ModelDelivery();
            try {
                $msg = $object->completecool();
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    function actioncompletebird()
    {
        set_time_limit(1000);
            $object = new ModelDelivery();
            try {
                $msg = $object->completebird();
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /**
     * 更新追踪单号
     */
    function actionupdateTrackno() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $trackarr = $json->decode(stripslashes($_POST['data']));
        $object = new ModelOrder();
        foreach($trackarr as $track){
            $track->track_no = addslashes_deep($track->track_no);
            try {
                $object->savetrackNO($track);
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
                    echo "{success:false,msg:'保存过程中发生以下错误:$errorMsg'}";exit;
            }
        }
        echo "{success:true,msg:'追踪单号保存成功'}";exit;
    }
    /**
     * 更新追踪单号
     */
    function actiondelOrder() {
        parent::actionCheck('del_order');
        $object = new ModelOrder();
            try {
                $object->delorder($_GET['id']);
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
                    echo "{success:false,msg:'订单删除过程中发生以下错误:$errorMsg'}";exit;
            }
        echo "{success:true,msg:'订单删除成功'}";exit;
    }

    /**
     * 删除订单状态
     */
    function actiondelStatus() {
        if(parent::actionCheck('edit_orderstatus'))
        {
            $object = new ModelOrder();
            try {
                $object->delStatus($_GET['ids']);
                echo "{success:true,msg:'订单状态删除成功'}";exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "{success:false,msg:'订单状态删除过程中发生以下错误:$errorMsg'}";exit;
        }
    }

    /**
     * 合并订单
     */
    function actioncomBineorder() {
            $object = new ModelOrder();
            try {
                $msg = $object->combineorder($_POST['ids']);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /*******
    ***订单拆分
    *******/
    function actionDivideorder()
    {
            $object = new ModelOrder();
            try {
                $msg = $object->divideorder($_POST['ids']);
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "审核过程中发生以下错误:$errorMsg";exit;
    }

    /************
    **** 导出搜索结果订单
    ************/
    function actionexportorder() {
        set_time_limit(0);
        parent::actionPrivilege('export_order');
        $object = new ModelOrder();
        $action_list = explode(',',$_SESSION['action_list']);
        $goods = new ModelGoods();
        if($_GET['step'] == 'servicecheck') $status = $object->getorderflow(1,2);
        elseif($_GET['step'] == 'orderhandle') $status = $object->getorderflow(3,2);
        elseif($_GET['step'] == 'deportmanager') $status = $object->getorderflow(2,2);
        elseif($_GET['step'] == 'cod') $status = $object->getorderflow(11,2);
        elseif($_GET['step'] == 'refund') $status = $object->getorderflow(10,2);
        elseif($_GET['step'] == 'ofsorder') $status = $object->getorderflow(9,2);
        elseif($_GET['step'] == 'pickuporder') $status = $object->getorderflow(8,2);
        elseif($_GET['step'] == 'shipedorder') $status = $object->getorderflow(17,2);
        elseif($_GET['step'] == 'eubhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shipping'] = $object->getExshipping('EUB');
        }
        elseif($_GET['step'] == '4pxhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('4PX');
        }
        elseif($_GET['step'] == 'coolhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('US');
        }
        elseif($_GET['step'] == 'birdhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('BIRD');
        }
        elseif($_GET['step'] == 'sfchandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('SFC');
        }
        elseif($_GET['step'] == 'ck1handle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('CHUKOU1');
        }
        elseif($_GET['step'] == 'ytghandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YTG');
        }
        elseif($_GET['step'] == 'dedhlhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('DEDHL');
        }elseif($_GET['step'] == 'esthandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('EST');
        }elseif($_GET['step'] == 'zhyhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('ZHY');
        }elseif($_GET['step'] == 'ywhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YW');
        }elseif($_GET['step'] == 'syhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('SY');
        }
        if($_GET['step'] == 'orderhandle'){
            $where = $object->getWhere($_REQUEST,$status,'',$object->getExshipping());
        }else{
            $where = $object->getWhere($_REQUEST,$status);
        }
            $list = $object->getOrderList(0,1000,$where);
    if($_GET['style'] == 'xml'){
        $xml ='<?xml version="1.0" encoding="windows-1252"?>
<DAZzle Layout="C:\softsilkroad.lyt" Start="PRINTING" Prompt="NO" AutoClose="NO" OutputFile="'.date('Y-m-d').'-OUTPUT.XML" SkipUnverified="YES" AutoPrintCustomsForms="YES">';
        for($i=0;$i<count($list);$i++){
            $xml .= '<Package ID="'.$list[$i]['order_id'].'">';
            $xml .= '<MailClass>FIRST</MailClass><DateAdvance>0</DateAdvance> 
          <PackageType>RECTPARCEL</PackageType> 
          <ReplyPostage>FALSE</ReplyPostage>
          <WeightOz>1</WeightOz>
          <Width>0</Width>
          <Length>0</Length>
          <Depth>0</Depth>
          <BaloonRate>FALSE</BaloonRate>
          <NonMachinable>FALSE</NonMachinable>
          <OversizeRate>FALSE</OversizeRate>
          <Stealth>TRUE</Stealth>
          <SignatureWaiver>FALSE</SignatureWaiver>
          <NoWeekendDelivery>FALSE</NoWeekendDelivery>
          <NoHolidayDelivery>FALSE</NoHolidayDelivery>
          <ReturnToSender>TRUE</ReturnToSender>
          <Services RegisteredMail="OFF" InsuredMail="OFF" CertifiedMail="OFF" RestrictedDelivery="OFF" CertificateOfMailing="OFF" ReturnReceipt="OFF" DeliveryConfirmation="ON" SignatureConfirmation="OFF" COD="OFF"> 
          <CostCenter></CostCenter> 
          <Value>0.00999999999999979</Value>
          <Description>APPTO-1422</Description> 
          <ReferenceID>'.$rs['paypalid'].'</ReferenceID>
          <EndorsementLine></EndorsementLine>
          <ToName>'.$list[$i]['consignee'].'</ToName>
          <ToTitle></ToTitle>
          <ToCompany></ToCompany>
          <ToAddress1>'.$list[$i]['street1'].'</ToAddress1>
          <ToAddress2>'.$list[$i]['street1'].'</ToAddress2>
          <ToCity>'.$list[$i]['city'].'</ToCity>
          <ToState>'.$list[$i]['state'].'</ToState>
          <ToPostalCode>'.$list[$i]['zipcode'].'</ToPostalCode>
          <ToZIP4></ToZIP4>
          <ToCountry>'.$list[$i]['country'].'</ToCountry>
          <ToDeliveryPoint></ToDeliveryPoint>
          <ToCarrierRoute></ToCarrierRoute>
          <ToReturnCode></ToReturnCode>
          <ToEMail>'.$list[$i]['email'].'</ToEMail>
          <ToPhone>'.$list[$i]['tel'].'</ToPhone>';
         $goodsinfo = $object->order_goods_info($list[$i]['order_id']);
         $total = 0;
         for($j=0;$i<count($goodsinfo);$i++){
             $total += $goodsinfo[$j]['goods_qty'];
             if($j<=10) $xml .= '<RubberStamp'.($j+2).'>'.$goodsinfo[$j]['goods_sn'].'='.$goodsinfo[$j]['goods_qty'].'</RubberStamp'.($j+2).'>';
            }
        $xml .= '<RubberStamp1>'.$total.'</RubberStamp1>';
        $xml .='<Status></Status> 
          <PIC></PIC> 
          <FinalPostage></FinalPostage> 
          <TransactionID></TransactionID> 
          <TransactionDateTime></TransactionDateTime> 
          <PostmarkDate></PostmarkDate> 
</Package>';
            }
        $xml .= '</DAZzle>';
        echo $xml;die();
    }elseif($_GET['style'] == 'csv'){
            ob_start();
        include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
        $zip = new PHPZip;
        $content ='"Sales Record Number","User Id","Buyer Full name","Buyer Phone Number","Buyer Email","Buyer Address 1","Buyer Address 2","Buyer Town/City","Buyer County","Buyer Postcode","Buyer Country","Item Number","Item Title","Custom Label","Quantity","Sale Price","Included VAT Rate","Postage and Packaging","Insurance","Cash on delivery fee","Total Price","Payment Method","Sale Date","Checkout Date","Paid on Date","Dispatch Date ","Invoice date","Invoice number","Feedback left","Feedback received","Notes to yourself","PayPal Transaction ID","Postage Service","Cash on delivery option","Transaction ID","Order ID","Variation Details"'. "\n";
    }else{
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
                    $fileds = ModelDd::getArray('orderexport');
                    $content = array_values($fileds);
                    $keys = array_keys($fileds);
            $objPHPExcel->getActiveSheet()->setTitle('sheet1');
            echo date('H:i:s') . " Write to Excel5 format<br>";
            include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
            $sf = 'A';
            $showtable = 0;
            if($showtable) echo '<table border="1"><tr>';
            for($i=0;$i<count($content);$i++){
                    $objPHPExcel->getActiveSheet()->setCellValue($sf.'1', $content[$i]);
                    if($showtable)  echo '<td>'.$content[$i].'</td>';
                    $sf++;
                }
            if($showtable) echo '</tr>';
            $t =2;
            }
        for($i=0;$i<count($list);$i++){
            $goodslist = $object->order_goods_info($list[$i]['order_id']);
            if($_GET['style'] == 'csv'){
                for($j = 0;$j<count($goodslist);$j++){
                    $order_value['Record'] = '"' . $list[$i]['sellsrecord'] . '"';
                    $order_value['userid'] = '"' . $list[$i]['userid'] . '"';
                    $order_value['consignee'] = '"' . $list[$i]['consignee'] . '"';
                    $order_value['tel'] = '"' . $list[$i]['tel'] . '"';
                    $order_value['email'] = '"' . $list[$i]['email'] . '"';
                    $order_value['street1'] = '"' . $list[$i]['street1'] . '"';
                    $order_value['street2'] = '"' . $list[$i]['street2'] . '"';
                    $order_value['city'] = '"' . $list[$i]['city'] . '"';
                    $order_value['state'] = '"' . $list[$i]['state'] . '"';
                    $order_value['zipcode'] = '"' . $list[$i]['zipcode'] . '"';
                    $order_value['country'] = '"' . $list[$i]['country'] . '"';
                    $order_value['zipcode'] = '"' . $list[$i]['zipcode'] . '"';
                    $order_value['Number'] = '" "';
                    $order_value['Title'] = '" "';
                    $order_value['goods_sn'] = '"' . $goodslist[$j]['goods_sn'] . '"';
                    $order_value['goods_qty'] = '"' . $goodslist[$j]['goods_qty'] . '"';
                    $order_value['Price'] = '" "';
                    $order_value['VAT'] = '" "';
                    $order_value['Packaging'] = '" "';
                    $order_value['Insurance'] = '" "';
                    $order_value['deliveryfee'] = '" "';
                    $order_value['Total'] = '" "';
                    $order_value['Payment'] = '" "';
                    $order_value['SaleDate'] = '" "';
                    $order_value['CheckoutDate'] = '" "';
                    $order_value['PaidDate'] = '" "';
                    $order_value['DispatchDate'] = '" "';
                    $order_value['InvoiceDate'] = '" "';
                    $order_value['Invoicenumber'] = '" "';
                    $order_value['Feedback'] = '" "';
                    $order_value['Feedbackreceived'] = '" "';
                    $order_value['Notes'] = '" "';
                    $order_value['Transaction'] = '" "';
                    $order_value['PostageService'] = '"' . $list[$i]['ShippingService'] . '"';
                    $order_value['deliveryoption'] = '" "';
                    $order_value['TransactionID'] = '" "';
                    $order_value['OrderID'] = '" "';
                    $order_value['Variation'] = '" "';
                    $content .= implode(",", $order_value) . "\n";
                }
            }else{
                for($j = 0;$j<count($goodslist);$j++){
                    for($s = 0;$s<count($keys);$s++){
                        
                        $priceinfo = $goods->goods_info($goodslist[$j]['goods_id']);
                        if($keys[$s] =='pay_note') $order_value[] =  $list[$i]['pay_note'];
                        if($keys[$s] =='note') $order_value[] =  $list[$i]['pay_note'];
                        if($keys[$s] =='sellsrecord') $order_value[] =  $list[$i]['sellsrecord'];
                        if($keys[$s] =='sellerID') $order_value[] =  $list[$i]['sellerID'];
                        if($keys[$s] =='paypalid') $order_value[] =  $list[$i]['paypalid'];
                        if($keys[$s] =='item_no') $order_value[] =  $goodslist[$j]['item_no'];
                        if($keys[$s] =='goods_sn') $order_value[] =  $goodslist[$j]['goods_sn'];
                        if($keys[$s] =='goods_name') $order_value[] =  $goodslist[$j]['goods_name'];
                        if($keys[$s] =='goods_qty') $order_value[] =  $goodslist[$j]['goods_qty'];
                        if($keys[$s] =='goods_price') $order_value[] =  $goodslist[$j]['goods_price'];
                        if($keys[$s] =='paid_time') $order_value[] =  $list[$i]['paid_time'];
                        if($keys[$s] =='price1') $order_value[] =  $priceinfo['price1'];
                        if($keys[$s] =='price2') $order_value[] =  $priceinfo['price2'];
                        if($keys[$s] =='price3') $order_value[] =  $priceinfo['price3'];
                        if($keys[$s] =='rec_id') $order_value[] =  $goodslist[$j]['rec_id'];
                        if($keys[$s] =='eubpdf') $order_value[] =  $goodslist[$j]['eubpdf'];
                        if($keys[$s] =='shipping_fee') $order_value[] =  ($j==0)?$list[$i]['shipping_fee']:'';
                        if($keys[$s] =='FEEAMT') $order_value[] =  ($j==0)?$list[$i]['FEEAMT']:'';
                        if($keys[$s] =='order_amount') $order_value[] =  ($j==0)?$list[$i]['order_amount']:'';
                        if($keys[$s] =='currency') $order_value[] =  ($j==0)?$list[$i]['currency']:'';
                        if($keys[$s] =='rate') $order_value[] =  ($j==0)?$list[$i]['rate']:'';
                        if($keys[$s] =='userid') $order_value[] =  $list[$i]['userid'];
                        if($keys[$s] =='consignee') $order_value[] =  $list[$i]['consignee'];
                        if($keys[$s] =='street1') $order_value[] =  $list[$i]['street1'];
                        if($keys[$s] =='street2') $order_value[] =  $list[$i]['street2'];
                        if($keys[$s] =='state') $order_value[] =  $list[$i]['state'];
                        if($keys[$s] =='city') $order_value[] =  $list[$i]['city'];
                        if($keys[$s] =='zipcode') $order_value[] =  $list[$i]['zipcode'];
                        if($keys[$s] =='country') $order_value[] =  $list[$i]['country'];
                        if($keys[$s] =='CountryCode') $order_value[] =  $list[$i]['CountryCode'];
                        if($keys[$s] =='tel') $order_value[] =  $list[$i]['tel'];
                        if($keys[$s] =='email') $order_value[] =  $list[$i]['email'];
                        if($keys[$s] =='ShippingService') $order_value[] =  $list[$i]['ShippingService'];
                        if($keys[$s] =='track_no') $order_value[] =  $list[$i]['track_no'];
                        if($keys[$s] =='order_sn') $order_value[] =  $list[$i]['order_sn'];
                        if($keys[$s] =='shipping_id') $order_value[] =  ModelDd::getCaption('shipping',$list[$i]['shipping_id']);
                        if($keys[$s] =='pay_id') $order_value[] =  ModelDd::getCaption('payment',$list[$i]['pay_id']);
                        if($keys[$s] =='Sales_channels') $order_value[] =  ModelDd::getCaption('Sales_channels',$list[$i]['Sales_channels']);
                        if($keys[$s] =='Sales_account_id') $order_value[] =  ModelDd::getCaption('allaccount',$list[$i]['Sales_account_id']);
                        if($keys[$s] =='sales_site') $order_value[] =  $list[$i]['sales_site'];
                        if($keys[$s] =='weight') $order_value[] =  ($j==0)?$list[$i]['weight']:'';
                        if($keys[$s] =='shipping_cost') $order_value[] =  ($j==0)?$list[$i]['shipping_cost']:''; 
                        if($keys[$s] =='goods_name_self') $order_value[] =  $goodslist[$j]['goods_name'];
                        if($keys[$s] =='sn_prefix') $order_value[] =  $goodslist[$j]['sn_prefix'];
                        if($keys[$s] =='OrderLineItemID') $order_value[] =  $goodslist[$j]['OrderLineItemID'];
                        if($keys[$s] =='end_time') $order_value[] =  ($j==0)?$list[$i]['end_time']:'';
                        if($keys[$s] =='code'){
                             $goodsinfo = $goods->goods_info('',$goodslist[$j]['goods_sn']);
                             $order_value[] =  $goodsinfo['code'];
                        }
                        if($keys[$s] =='cost' && in_array('view_cost',$action_list)){
                                $goodsinfo = $goods->goods_info($goodslist[$j]['goods_id'],$goodslist[$j]['goods_sn']);
                                 $order_value[] =  $goodsinfo['cost'];
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
            }
        }
        if($showtable) echo '</table>';
        if($_GET['style'] == 'csv'){
                $zip->add_file(ecs_iconv('utf-8', 'utf-8', $content), 'csv_list.csv');
                header("Content-Disposition: attachment; filename=csv_list.zip");
                header("Content-Type: application/unknown");
                die($zip->file());
        }else{
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
            //var_dump($objWriter);
            $file = CFG_PATH_DATA.'ordertmp/orderlist'.$_SESSION['admin_id'].'.xlsx';
            if(file_exists($file)) unlink($file);
            $objWriter->save($file);//define xls name
            $file = str_replace(CFG_PATH_ROOT, '', $file);
            echo date('H:i:s') . " Done writing files.<br>";
            page::todo($file);
            die();
        }
    }
    /**
     * 导出paypal搜索结果单据
     */
    function actionexportpaypal() {
        set_time_limit(0);
        $object = new ModelOrder();
        include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
        $zip = new PHPZip;
        $content = '"Date","Name","Type","Status","Currency","Gross","Fee","Net","From Email Address","Transaction ID"'. "\n";
        $list = $object->getPaypalorder($_GET);
        for($i=0;$i<count($list);$i++){
            $order_value['Date'] = '"' . $list[$i]['L_TIMESTAMP'] . '"';
            $order_value['Name'] = '"' . $list[$i]['L_NAME'] . '"';
            $order_value['Type'] = '"' . $list[$i]['L_TYPE'] . '"';
            $order_value['Status'] = '"' . $list[$i]['L_STATUS'] . '"';
            $order_value['Currency'] = '"' . $list[$i]['L_CURRENCYCODE'] . '"';
            $order_value['Gross'] = '"' . $list[$i]['L_AMT'] . '"';
            $order_value['Fee'] = '"' . $list[$i]['L_FEEAMT'] . '"';
            $order_value['Net'] = '"' . $list[$i]['L_NETAMT'] . '"';
            $order_value['From Email Address'] = '"' . $list[$i]['L_EMAIL'] . '"';
            $order_value['Transaction ID'] = '"' . $list[$i]['L_TRANSACTIONID'] . '"';
            $content .= implode(",", $order_value) . "\n";
        }
        $content .=  '"Balance:"'."\n";
        $balancelist = $object->getPaypalbalance($_GET);
        for($t=0;$t<count($balancelist);$t++){
            $b_value['L_CURRENCYCODE'] = '"' . $balancelist[$t]['L_CURRENCYCODE'] . '"';
            $b_value['L_AMT'] = '"' . $balancelist[$t]['L_AMT'] . '"';
            $content .= implode(",", $b_value) . "\n";
        }
        $zip->add_file(ecs_iconv('utf-8', 'utf-8', $content), 'paypal_list.csv');
        header("Content-Disposition: attachment; filename=paypal_list.zip");
        header("Content-Type: application/unknown");
        die($zip->file());
    }    


    /**
     * 导出缺货订单
     */
    function actionexportofs() {
        /*  /////////第一种导出方式 csv文件
        header("Content-type: application/vnd.ms-excel; charset=utf-8");
        header("Content-Disposition: attachment; filename=test.xls");
        echo 'test\t\n';
        echo 'a1\t';
        echo 'a2\t';
        echo 'a3\t';
        echo 'tttt\t\n';
        */
        //////////////////第二种导出方式
        include_once(CFG_PATH_LIB.'includes/cls_phpzip.php');
        $zip = new PHPZip;
        $count = "序号,运单号码,运输方式,物品名称,币种,价格,件数,总值,重量,是否保险,姓名,地址第1行,地址第2行/区,城镇/城市,省/市/自治区/直辖市/特别行政区,邮政编码,国家/地区,联系电话,邮件地址,交易号,买家号,自定义配货信息,寄件人公司名称或姓名,寄件人地址\n";
        //$zip->add_file(file_get_contents(ROOT_PATH . $row['goods_img']), $row['goods_img']);
        $zip->add_file(ecs_iconv('utf-8', 'GBK', $count), 'order_list.csv');
        $count = "订单编号,Item Number,物品名称,销售编码,数量,单价,分摊运费\n";
        //$zip->add_file(file_get_contents(ROOT_PATH . $row['goods_img']), $row['goods_img']);
        $zip->add_file(ecs_iconv('utf-8', 'GBK', $count), 'order_info_list.csv');
        header("Content-Disposition: attachment; filename=order_list.zip");
        header("Content-Type: application/unknown");
        die($zip->file());
        
    }
    /**
     * 订单校对
     */
    function actioncollation()
    {
        parent::actionPrivilege('order_collation');
        $this->name = 'collation';
        $this->show();
    }
    /**
    * 订单校对流程
    */
    function actioncheckcollation()
    {
        $object = new ModelOrder();
        $is_order = $object->isorder($_GET['key']);
        if(isset($_GET['complete'])){
                try{
                    $object->completecollation($_GET['track'],$_GET['weight'],$_GET['cost']);
                    echo "{success:true,msg:'ok',type:'success'}";exit;
                } catch (Exception $e){
                    $errorMsg = $e->getMessage();
                }
                    
        }elseif((substr($_GET['key'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX )||$is_order){//前缀判断为订单
                if($object->getcompletecol()){ echo "{success:false,msg:'存在未确定发货的订单信息,请先按空格键'}";exit;}
                $info['keytype'] =1;
                $info['key'] = $_GET['key'];
                $status = $object->getorderflow(4,2);
                $where = $object->getWhere($info,$status);
                $info['keytype'] =7;
                $where1 = $object->getWhere($info,$status);
                if($object->getOrderCount($where) == 0  && $object->getOrderCount($where1) == 0) {
                    echo "{success:false,msg:'该订单未处于待核对状态'}";exit;
                }else{
                    try{
                        $note = $object->savecheckcollation($is_order);
                        if(CFG_GOODS_COLLATION == 1){
                         echo "{success:true,msg:'ok',type:'order',note:'".addslashes($note)."'}";exit;
                        }
                        echo "{success:true,msg:'ok',type:'complete'}";exit;
                        } catch (Exception $e) {
                                $errorMsg = $e->getMessage();
                        }
                }
        }else{
            try{
                $response = $object->checkcol($_GET['key'],$_GET['qty']);
                if( $response == 1) $result = 'complete';
                if( $response == 0) $result = 'inflow';
                if( $response == 2) $result = 'sncheck';
                echo "{success:true,msg:'ok',type:'".$result."',key:'".$_GET['key']."'}";exit;
            } catch (Exception $e) {
                $errorMsg = $e->getMessage();
            }
        }
        echo "{success:false,msg:'" . $errorMsg . "'}";exit;
    }
    
    function actioncollationCost()
    {
        $object = new ModelOrder();    
            try{
            $result = $object->collationCost($_GET['value']);
            echo "{success:true,msg:'".$result."'}";exit;
            } catch (Exception $e) {
                $errorMsg = $e->getMessage();
            }
            echo "{success:false,msg:'" . $errorMsg . "'}";exit;
    }
    
    function actioncollationsn()
    {
        $object = new ModelOrder();
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $data = $json->decode(stripslashes($_POST['data']));
            try{
             $type = $object->collationSN($data,$_POST['goods_sn']);
            echo "{success:true,msg:'ok',type:'".$type."'}";exit;
            } catch (Exception $e) {
                $errorMsg = $e->getMessage();
            }
        echo "{success:true,msg:'" . $errorMsg . "'}";exit;    
    }
    /**
    ** 判断是否订单
    */
    function actioncheckOrder()
    {
        $object = new ModelOrder();
        $is_order = $object->isorder($_GET['key']);
        if($is_order){//前缀判断为订单
            $trackNo=$object->getorderTrack($is_order);
            if($trackNo){//前缀判断为订单
                echo "{success:true,msg:'".$trackNo."'}";exit;
            }
            echo "{success:true,msg:''}";exit;
        }else{
                $errorMsg = '未找到对应订单';
        }
        echo "{success:false,msg:'" . $errorMsg . "'}";exit;
    }
    /*****
    ***保存追踪单号
    *****/
    function actionsavetrack()
    {
        $object = new ModelOrder();
        try{
            $rs = $object->savetrack($_REQUEST);
            if($rs>=1){
                echo "{success:true,msg:'ok'}";exit;
            }else{
                echo "{success:false,msg:'".$_REQUEST['order_sn']."保存失败'}";exit;
            }
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
        echo "{success:false,msg:'" . $errorMsg . "'}";exit;
    }
    /**
    * 获取待校对的订单
    */
    function actiongetcollation()
    {
        $object = new ModelOrder();
        $list = $object->getcollation($status);
        $result['totalCount'] = count($list);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 获取待标记列表
     */
    function actionWaitmark() {
        $object = new ModelOrder();
        $status = $object->getorderflow(6,2);
        $status1 = $object->getorderflow(13,2);
        $list = $object->waitMarkList($status,$status1);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 获取Amazon待标记列表
     */
    function actionAmazonWaitmark() {
        $object = new ModelOrder();
        $status = $object->getorderflow(6,2);
        $list = $object->amazonwaitMarklist($status);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 获取Aliexpress待标记列表
     */
    function actionAliexpressWaitmark() {
        $object = new ModelOrder();
        $status = $object->getorderflow(6,2);
        if($_REQUEST['paid_time'])  $where = ' and paid_time >= '.strtotime($_REQUEST['paid_time'].' 00:00:00').' and paid_time < '.strtotime($_REQUEST['paid_time'].' 23:59:59').' and Sales_account_id = '.$_REQUEST['id'];
        $list = $object->aliwaitMarklist($status,$where);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 获取DHgate待标记列表
     */
    function actionDHgateWaitmark() {
        $object = new ModelOrder();
        $status = $object->getorderflow(6,2);
        if($_REQUEST['paid_time'])  $where = ' and paid_time >= '.strtotime($_REQUEST['paid_time'].' 00:00:00').' and paid_time < '.strtotime($_REQUEST['paid_time'].' 23:59:59').' and Sales_account_id = '.$_REQUEST['id'];
        $list = $object->DHgatewaitMarklist($status,$where);
        $result['topics'] = $list;
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    /**
     * 出库开单
     */
    function actionoutdepot()
    {
        parent::actionPrivilege('order_stockout');
        $this->tpl->assign('depot',ModelDd::getComboData('depot'));
        $this->name = 'outdepot';
        $this->show();
    }
    /**
     * 获取待出库订单明细
     */
    function actiongetoutdepot()
    {
        $object = new ModelOrder();
        $status = $object->getorderflow(5,2);
        $list = $object->getOutdepot($status.',139',$_POST['account'],$_POST['depot']);
        $result['totalCount'] = count($list);
        $result['topics'] = $list;
        //echo '<pre>';
        //var_dump($list);
       // echo '</pre>';
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        echo $json->encode($result);
    }
    function actionexportoutdepot()
    {
        $object = new ModelOrder();
        $status = $object->getorderflow(5,2);
        $list = $object->getOutdepot($status,$_REQUEST['account'],$_REQUEST['depot']);
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
        $header = '序号,产品编码,产品名称,库存位置,申请出库量,实际库存量,管理库存';
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
                $order_value[] =  $list[$i]['goods_sn'];
                $order_value[] =  $list[$i]['goods_name'];
                $order_value[] =  $list[$i]['stock_place'];
                $order_value[] =  $list[$i]['out_qty'];
                $order_value[] =  $list[$i]['goods_qty'];
                $order_value[] =  $list[$i]['is_control']?'是':'否';
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
        $file = 'data/ordertmp/applyout_list'.$_SESSION['admin_id'].'.xlsx';
        if(file_exists($file)) unlink($file);
        $objWriter->save($file);//define xls name
        echo date('H:i:s') . " Done writing files.<br>";
        page::todo($file);
        die();
    }
    /**
     * 生成出库单
     */
    function actionMakeoutdepot()
    {
        $object = new ModelOrder();
        try {
            $object->makeOutdepot();
                    echo "{success:true,msg:'生成出库单成功'}";exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    } 
     
    /**
     * 退款订单
     */
     function actiongetrefund()
    {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(10,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     *到付收款
     */
     function actiongetcod()
    {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(11,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     *所有订单
     */
     function actiongetallorder()
    {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = '0';
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',1,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     *订单解锁
     */
     function actiongetunlockorder()
    {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(7,2);
        $_REQUEST['is_lock'] =  1;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,'',0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * Ebay自动标记
     */
    function actionAjaxmark() {
        $object = new ModelChannel();
        try {
            $msg = $object->ajaxMark($_POST);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "<br><font color=red>$errorMsg</font>";exit;
    }
    
    /*****
    ***Amazon自动标记发货
    ******/
    function actionAmazonmark()
    {
        $object = new ModelChannel();
        try {
            $msg = $object->amazonMark($_GET['id']);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "<br><font color=red>$errorMsg</font>";exit;
    }
    /*****
    ***Aliexpress自动标记发货
    ******/
    function actionAlimark()
    {
        $object = new ModelAliexpress();
        try {
            $msg = $object->orderMark($_GET['id']);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "<br><font color=red>$errorMsg</font>";exit;
    }
    /*****
    ***Aliexpress批量标记发货
    ******/
    function actionAlimarks()
    {
        $object = new ModelAliexpress();
        try {
            if($_REQUEST['paid_time'])  $where = ' and paid_time >= '.strtotime($_REQUEST['paid_time'].' 00:00:00').' and paid_time < '.strtotime($_REQUEST['paid_time'].' 23:59:59');
            $status = $object->getorderflow(6,2);
            $msg = $object->orderMarks($_GET['id'],$status,$where);
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:false,msg:'".$errorMsg."'}";exit;
    }
    /*****
    ***DH自动标记发货
    ******/
    function actionDHgatemark()
    {
        $object = new ModelDH();
        try {
            $msg = $object->orderMark($_GET['id']);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "<br><font color=red>$errorMsg</font>";exit;
    }
    /*****
    ***DH批量标记发货
    ******/
    function actionDHgatemarks()
    {
        $object = new ModelDH();
        try {
            if($_REQUEST['paid_time'])  $where = ' and paid_time >= '.strtotime($_REQUEST['paid_time'].' 00:00:00').' and paid_time < '.strtotime($_REQUEST['paid_time'].' 23:59:59');
            $status = $object->getorderflow(6,2);
            $msg = $object->orderMarks($_GET['id'],$status,$where);
            echo "{success:true,msg:'".$msg."'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:false,msg:'".$errorMsg."'}";exit;
    }
    /*****
    *订单修改记录
    *****/
    function actionModify()
    {
        $object = new ModelOrder();
        try {
                $object->modify($_POST);
                echo "{success:true,msg:'操作已成功'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    }
    /**********
    **保存订单产品明细
    **********/
    function actionSavegoods(){
        $object = new ModelOrder();
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $goodsarr = $json->decode(stripslashes($_POST['data']));
        foreach($goodsarr as $goods){
            $goods->goods_name = addslashes_deep($goods->goods_name);
            if($goods->goods_name == "" || $goods->goods_sn == "") {
            echo "{success:false,msg:'产品编码及名称不能为空'}";exit;
            }
        }
        $_POST['data'] = $goodsarr;
            try {
                    $object->savegoods($_POST);
                    echo "{success:true,msg:'操作已成功'}";exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    }
    /*****************
    *更改paypal交易流水状态
    *****************/
    function actionchangeporder()
    {
        $object = new ModelOrder();
        try {
                $object->changeporder($_GET['paypalid']);
                echo "{success:true,msg:'操作已成功'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    }
    /*****************
    *检查paypal流水是否存在订单中
    *****************/
    function actionchecktrans()
    {
        $object = new ModelOrder();
        try {
                $object->checktrans();
                echo "{success:true,msg:'操作已成功'}";exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    }
    /*****************
    ****获取订单日志信息
    *****************/
    function actionGetlog()
    {
        $object = new ModelOrder();
        echo $object->getlog($_REQUEST['order_id']);
    }
    /*****************
    ****获取订单费用信息
    *****************/
    function actionGetfee()
    {
        $object = new ModelOrder();
        echo $object->getfee($_REQUEST['order_id']);
    }
    /*****************
    ****订单导入
    *****************/
    function actionImport()
    {
        parent::actionPrivilege('order_import');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('payment',ModelDd::getComboData('payment'));
        $this->name = 'orderimport';
        $this->show();
    }
    /*****************
    ****订单导入数据处理
    *****************/
    function actionUpLoad()
    {
        //echo "{success:true,msg:'".$_FILES['file_path']['tmp_name']."'}";exit;
        set_time_limit(0);
        parent::actionPrivilege('order_import');
        $object = new ModelOrder();
        if($_REQUEST['type']==1){//amazon订单处理
            $content = file_get_contents($_FILES['file_path']['tmp_name']);
            try {
                $object->loadamzfile($content,$_POST['id']);
            } catch (Exception $e) {
                echo "{success:false,msg:'".$e->getMessage()."'}";exit;
            }
            echo "{success:true,msg:'订单导入完成'}";exit;
        }
        if($_REQUEST['type']==2){
            $content = file_get_contents($_FILES['file_path']['tmp_name']);
            try {
                $object->loadamzFBAfile($content,$_POST['id']);
            } catch (Exception $e) {
                            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
            }
            echo "{success:true,msg:'订单导入完成'}";exit;
        }
        if($_REQUEST['type']==5){
            $content = file_get_contents($_FILES['file_path']['tmp_name']);
            try {
                $object->loadamzunship($content,$_POST['id']);
            } catch (Exception $e) {
                            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
            }
            echo "{success:true,msg:'订单导入完成'}";exit;
        }
        include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
        $objReader = new PHPExcel_Reader_Excel5();
        $objReader->setReadDataOnly(true);
        $objPHPExcel = $objReader->load(addslashes_deep($_FILES['file_path']['tmp_name']));//
        $currentSheet =$objPHPExcel->getSheet(0);
        $allColumn = $currentSheet->getHighestColumn();
        $allColumnIndex = PHPExcel_Cell::columnIndexFromString($allColumn);
        $allRow = $currentSheet->getHighestRow();
        if($_REQUEST['type']==0){
            $shipping = ModelDd::getArray('shipping');
            $code = date('ymds'). str_pad(mt_rand(1, 9999999), 5, '0', STR_PAD_LEFT);
            for($i='A';$i<=$allColumn;$i++){
                $line_list[$i] = trim($currentSheet->getCell($i."1")->getValue());
            }
            for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
                $order_info['paypalid'] = '';
                $order_info['order_status'] = $object->getorderflow(12,2);
                $order_info['Sales_account_id'] = $_POST['id'];
                $order_info['Sales_channels'] = $_POST['Sales_channels'];
                $order_info['pay_id'] = $_POST['payment'];
                
                
                $shipping_id = 0;
                
                for($i='A';$i<=$allColumn;$i++){
                    $field = $this->changeOrderField($line_list[$i]);
                    $order_info[$field] = trim($currentSheet->getCell($i.$currentRow)->getValue());
                }
                try {
                    if(empty($order_info['paypalid'])) $order_info['paypalid'] = date('ymd').mt_rand(621231,666252);
                    if(!empty($order_info['shipping_id'])){
                        $shipping_id = array_search($order_info['shipping_id'],$shipping);
                        $order_info['shipping_id'] = $shipping_id;
                        $order_info['paid_time'] = strtotime($order_info['paid_time']);
                    }
                    if(!$order_info['currency']) $order_info['currency'] = 'USD';
                    $object->saveimport($order_info);
                } catch (Exception $e) {
                        echo "{success:false,msg:'".$e->getMessage()."'}";exit;
                }
            }
             echo "{success:true,msg:'订单导入成功'}";exit;
        }
        if($_REQUEST['type']==3){//速卖通
            for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
                if($currentSheet->getCell("B".$currentRow)->getValue() != '等待您发货') continue;
                    $order['paypalid'] = trim($currentSheet->getCell("A".$currentRow)->getValue());
                    $order['order_amount'] = substr($currentSheet->getCell("E".$currentRow)->getValue(),1);
                    $order['userid'] = trim($currentSheet->getCell("D".$currentRow)->getValue());
                    $order['sellerID'] = trim($currentSheet->getCell("C".$currentRow)->getValue());
                    $order['currency'] = 'USD';
                    $order['Sales_account_id'] = $_POST['id'];
                    $order['Sales_channels'] = $_POST['Sales_channels'];
                    $order['pay_id'] = $_POST['payment'];
                    $order['order_status'] = $object->getorderflow(12,2);
                    $order['email'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
                    $order['paid_time'] = str_replace('.','-',trim($currentSheet->getCell("G".$currentRow)->getValue()));
                    $order['shipping_fee'] = str_replace('$','',trim($currentSheet->getCell("I".$currentRow)->getValue()));
                    $order['order_amount'] = str_replace('$','',trim($currentSheet->getCell("J".$currentRow)->getValue()));
                    $goodsprice = str_replace('$','',trim($currentSheet->getCell("H".$currentRow)->getValue()));
                    $order['pay_note'] = trim($currentSheet->getCell("M".$currentRow)->getValue());
                    $order['consignee'] = trim($currentSheet->getCell("O".$currentRow)->getValue());
                    $order['tel'] = trim($currentSheet->getCell("U".$currentRow)->getValue());
                    if($order['tel'] == '') $order['tel'] = trim($currentSheet->getCell("V".$currentRow)->getValue());
                    $order['street1'] = trim($currentSheet->getCell("S".$currentRow)->getValue());
                    $order['zipcode'] = trim($currentSheet->getCell("T".$currentRow)->getValue());
                    $order['city'] = trim($currentSheet->getCell("R".$currentRow)->getValue());
                    $order['state'] = trim($currentSheet->getCell("Q".$currentRow)->getValue());
                    $order['country'] = trim($currentSheet->getCell("P".$currentRow)->getValue());
                    $order['ShippingService'] = trim($currentSheet->getCell("W".$currentRow)->getValue());
                    $goods = explode("\n",$currentSheet->getCell("L".$currentRow)->getValue());
                    $count = count($goods)-1;
                    $total = 0;
                    for($gt=0;$gt<$count;$gt++){
                        if(strpos($goods[$gt],'产品数量')) {
                                if(strpos($goods[$gt],'lot')) preg_match_all('/(数量:)(.*)( Lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pair / lot')) preg_match_all('/(数量:)(.*)( pair / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pieces / lot')) preg_match_all('/(数量:)(.*)( pieces / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'sets / lot')) preg_match_all('/(数量:)(.*)( sets / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pair')) preg_match_all('/(数量:)(.*)( pair)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'bag')) preg_match_all('/(数量:)(.*)( bag)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pack')) preg_match_all('/(数量:)(.*)( pack)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'piece')) preg_match_all('/(数量:)(.*)( piece)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'set')) preg_match_all('/(数量:)(.*)( set)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pairs / lot')) preg_match_all('/(数量:)(.*)( pairs / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'gram / lot')) preg_match_all('/(数量:)(.*)( gram / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'grams / lot')) preg_match_all('/(数量:)(.*)( grams / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'dozen')) preg_match_all('/(数量:)(.*)( dozen)/',$goods[$gt],$match);
                                else preg_match_all('/(数量:)(.*)( gram)/',$goods[$gt],$match);
                                if($match[2][0]>0) $total += $match[2][0];
                            }
                    }
                    $order['goods_price'] = number_format($goodsprice/$total,2,'.','');
                    $ordernum = 1;
                    for($gt=0;$gt<$count;$gt++){
                        if(strpos($goods[$gt],'商家编码')) {
                                preg_match_all('/(商家编码:)(.*)(\))/',$goods[$gt],$match);
                                $order['SKU'] = $match[2][0];
                            }
                        elseif(strpos($goods[$gt],'产品数量')) {
                                $order['TransactionID'] =$order['paypalid'].str_pad($ordernum, 2, '0', STR_PAD_LEFT);
                                if(strpos($goods[$gt],'lot')) preg_match_all('/(数量:)(.*)( Lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pair / lot')) preg_match_all('/(数量:)(.*)( pair / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pieces / lot')) preg_match_all('/(数量:)(.*)( pieces / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'sets / lot')) preg_match_all('/(数量:)(.*)( sets / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pair')) preg_match_all('/(数量:)(.*)( pair)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'bag')) preg_match_all('/(数量:)(.*)( bag)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pack')) preg_match_all('/(数量:)(.*)( pack)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'piece')) preg_match_all('/(数量:)(.*)( piece)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'set')) preg_match_all('/(数量:)(.*)( set)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'pairs / lot')) preg_match_all('/(数量:)(.*)( pairs / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'gram / lot')) preg_match_all('/(数量:)(.*)( gram / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'grams / lot')) preg_match_all('/(数量:)(.*)( grams / lot)/',$goods[$gt],$match);
                                elseif(strpos($goods[$gt],'dozen')) preg_match_all('/(数量:)(.*)( dozen)/',$goods[$gt],$match);
                                else preg_match_all('/(数量:)(.*)( gram)/',$goods[$gt],$match);
                                $order['goods_qty'] = $match[2][0];
                                    try {
                                        $object->saveimport($order);
                                        $ordernum++;
                                    } catch (Exception $e) {
                                            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
                                    }
                            }
                        elseif(strpos($goods[$gt],'产品属性')) {
                                preg_match_all('/(产品属性:)(.*)(\))/',$goods[$gt],$match);
                                $order['goods_name'] .= '-'.$match[2][0];
                            }
                        else {
                        $order['SKU'] ='';
                        $order['goods_qty'] =1;
                        $order['goods_name'] ='';
                        $order['TransactionID'] =0;
                        $order['goods_name'] = preg_replace('/(【)(.*)(】 )/','',trim($goods[$gt]));
                        }
                        $msg .= $order['SKU'];
                    }
            }
                echo "{success:true,msg:'订单导入完成'}";exit;
        }
        if($_REQUEST['type']==4){
            for($currentRow = 1;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
                    if($currentSheet->getCell("B".$currentRow)->getValue() == '') continue;
                    $order['userid'] = trim($currentSheet->getCell("F".$currentRow)->getValue());
                    $order['paypalid'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
                    $order['TransactionID'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
                    $order['currency'] = 'JPY';
                    $order['Sales_account_id'] = $_POST['id'];
                    $order['Sales_channels'] = $_POST['Sales_channels'];
                    $order['pay_id'] = $_POST['payment'];
                    $order['order_status'] = $object->getorderflow(12,2);
                    $order['order_amount'] = str_replace(' 円','',trim($currentSheet->getCell("D".$currentRow)->getValue()));
                    $goods = trim($currentSheet->getCell("C".$currentRow)->getValue());
                    $order['goods_name'] = preg_replace('/(\()(.*)(\))/','',$goods);
                    preg_match_all('/(\()(.*)(\))/',$goods,$match);
                    $order['SKU'] = @$match[2][0];
                    $order['goods_qty'] = 1;
                    $order['goods_price'] = $order['order_amount'];
                    $time = trim($currentSheet->getCell("E".$currentRow)->getValue());
                    $arr = array("月","日 ","時","分");
                    $time1 = explode("-",str_replace($arr, "-", $time));
                    $order['paid_time'] = date('Y').'-'.$time1[0].'-'.$time1[1].' '.$time1[2].':'.$time1[3].':00';
                try {
                    $object->saveimport($order);
                } catch (Exception $e) {
                                echo "{success:false,msg:'".$e->getMessage()."'}";exit;
                }
            }
            echo "{success:true,msg:'订单导入完成'}";exit;
        }
    }
    function changeOrderField($field){
        switch($field){
            case 'consignee':case '收件人':
            $result = 'consignee'; 
            break;
            case 'email':case '邮箱':case 'Email':
            $result = 'email'; 
            break;
            case 'street1':case '街道1':case 'address1':case 'ADDRESS1':case '收件人地址1':
            $result = 'street1'; 
            break;
            case 'street2':case '街道2':case 'address2':case 'ADDRESS2':case '收件人地址2':
            $result = 'street2'; 
            break;
            case 'state':case '州':case '省':
            $result = 'state'; 
            break;
            case 'city':case '城市':
            $result = 'city'; 
            break;
            case 'country':case '国家':
            $result = 'country'; 
            break;
            case 'CountryCode':case '国家代码':
            $result = 'CountryCode'; 
            break;
            case 'zipcode':case '邮编':
            $result = 'zipcode'; 
            break;
            case 'tel':case '电话':
            $result = 'tel'; 
            break;
            case 'pay_note':case '付款备注':
            $result = 'pay_note'; 
            break;
            case 'paid_time':case '支付时间':case '付款时间':
            $result = 'paid_time'; 
            break;
            case 'currency':case '货币编码':
            $result = 'currency'; 
            break;
            case 'SKU':
            $result = 'SKU'; 
            break;
            case 'goods_name':case '货物名称':
            $result = 'goods_name'; 
            break;
            case 'goods_qty':case '货物数量':
            $result = 'goods_qty'; 
            break;
            case 'goods_price':case '价格':
            $result = 'goods_price'; 
            break;
            case 'goods_weigth':case '重量':
            $result = 'goods_weigth'; 
            break;
            case 'paypalid':case '订单号':
            $result = 'paypalid'; 
            break;
            case 'userid':case '标识':
            $result = 'userid'; 
            break;
            case 'track_no_2':case '运单号2':
            $result = 'track_no_2'; 
            break;
            case 'client_id':case '客户id':
            $result = 'client_id'; 
            break;
            case 'shipping_id':case '运输方式':
            $result = 'shipping_id'; 
            break;
            case 'track_no':case '运单号':
            $result = 'track_no'; 
            break;
            case 'order_amount':case '总金额':case '总价格':
            $result = 'order_amount'; 
            break;
            default:
            $result = '';
        }
        return $result;
    }
    /*****************
    ****订单批量更新
    *****************/
    function actionOrderUpdate()
    {
        parent::actionPrivilege('order_update');
        $this->tpl->assign('account',ModelDd::getComboData('allaccount'));
        $this->name = 'orderupdate';
        $this->show();
    }
    /*****************
    ****订单导入更新数据处理
    *****************/
    function actionUpLoadupdate()
    {
        set_time_limit(0);
        parent::actionPrivilege('order_update');
        include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
        $objReader = new PHPExcel_Reader_Excel5();
        $objReader->setReadDataOnly(true);
        $objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
        $currentSheet =$objPHPExcel->getSheet(0);
        $allColumn = $currentSheet->getHighestColumn();
        $allRow = $currentSheet->getHighestRow();
        $field_list = array();
        $object = new ModelOrder();
        if($currentSheet->getCell("A1")->getValue() != 'order_sn') {echo "{success:false,msg:'文件格式错误'}";exit;}
        for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){ //第一行取更新字段
            $field_list[] = trim($currentSheet->getCell($currentColumn."1")->getValue());
        }
        $error = '';
        for($currentRow = 2;$currentRow<=$allRow;$currentRow++){//从第二行开始更新数据
            $order_sn = trim($currentSheet->getCell("A".$currentRow)->getValue());
            $order_id = $object->isorder($order_sn,$_POST['accounttype']);
            if(!$order_id){
                echo "{success:false,msg:'".$order_sn."找不到匹配订单'}";exit;
                }
            $filed_value = array();
            $order_info = array();
            for($currentColumn='B';$currentColumn<=$allColumn;$currentColumn++){
                $address = $currentColumn.$currentRow;
                $filed_value[] = trim($currentSheet->getCell($address)->getValue());
            }
            for($i=0;$i<count($field_list);$i++){
                $order_info[$field_list[$i]] = $filed_value[$i];
                }
                if( (!in_array('shipping_cost',$field_list)) && in_array('weight',$field_list)) $order_info['shipping_cost'] = $object->chargeshipping($order_id,$order_info['weight']);
                if(in_array('shipping_time',$field_list)) {
                    $order_info['shipping_time'] = MyDate::transform('timestamp',$info['shipping_time']);
                    $order_info['end_time'] = MyDate::transform('timestamp',$info['shipping_time']);
                }
                if(in_array('track_no',$field_list)) $order_info['mark_with_no'] = 0;
            try {
                $object->updateimport($order_info,$order_id);
            } catch (Exception $e) {
                    echo "{success:false,msg:'".$e->getMessage()."'}";exit;
            }
        }
         echo "{success:true,msg:'订单导入成功'}";exit;
    }
    /***************
    *****显示ebay和paypal订单信息区别
    ****************/
    function actionReadpaypal()
    {
        $object = new ModelOrder();
        $order_info = $object->order_info($_GET['id']);
        $order_info['order_sn'] = CFG_ORDER_PREFIX.$order_info['order_sn'];
        $order_info1 = $object->getOrderpaypal($order_info['paypalid'],$order_info['PayPalEmailAddress']);
                $t = 0;
                while(isset($order_info1['L_NAME'.$t])){
                    $trans_detail['L_NAME'] = $order_info1['L_NAME'.$t];
                    $trans_detail['L_NUMBER'] = $order_info1['L_NUMBER'.$t];
                    $trans_detail['L_QTY'] = $order_info1['L_QTY'.$t];
                    $trans_detail['L_AMT'] = $order_info1['L_AMT'.$t];
                    $order_info1['goods'][] = $trans_detail;
                    unset($trans_detail);
                    $t++;
                    }        
        $this->tpl->assign('ebayorder',$order_info);
        $this->tpl->assign('paypalorder',$order_info1);
        $this->name = 'readpaypal';
        $this->show();
    }
    
    function actionGetValue()
    {
        $object = new ModelOrder();
        $orderinfo = $object->order_info($_POST['id']);
        $orderinfo[$_POST['field']] = str_replace(array("\n", "\r"), array('', ''), $orderinfo[$_POST['field']]);
        echo "{success:true,msg:'". $orderinfo[$_POST['field']]."'}";exit;
    }
    
    /*********
    *直接完成订单操作
    *********/
    function actioncompleteorder()
    {
        if(parent::actionCheck('order_complete')){
            try {
                $object = new ModelOrder();
                $object->completeorder($_POST['id']);
            } catch (Exception $e) {
                    echo "{success:false,msg:'".$e->getMessage()."'}";exit;
            }
         echo "{success:true,msg:'订单已完成'}";exit;
        }
    }
    
    /***********
    ******
    *****自动合并订单
    ****
    ***********/
    function actionautocombine()
    {
        $object = new ModelOrder();
        try {
                if($_POST['step'] == 'servicecheck') $status = $object->getorderflow(1,2);
                elseif($_POST['step'] == 'deportmanager') $status = $object->getorderflow(2,2);
                elseif($_POST['step'] == 'ordercheck') $status = $object->getorderflow(14,2);
                elseif($_POST['step'] == 'cod') $status = $object->getorderflow(11,2);
                elseif($_POST['step'] == 'refund') $status = $object->getorderflow(10,2);
                elseif($_POST['step'] == 'ofsorder') $status = $object->getorderflow(9,2);
                elseif($_POST['step'] == 'pickuporder') $status = $object->getorderflow(8,2);
                elseif($_POST['step'] == 'allorder') $status = NULL;
                else $status = $object->getorderflow(3,2);
                $where = $object->getWhere($_POST,$status);
            $msg = $object->autocombine($where);
            echo $msg;exit;
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "审核过程中发生以下错误:$errorMsg";exit;
    }
    /****************
    ***
    ***速卖通导入订单格式处理
    ***
    ****************/
    function getaliexpress($currentSheet,$currentRow,$info,$object)
    {
        $order['paypalid'] = trim($currentSheet->getCell("B".$currentRow)->getValue()); //速卖通订单ID
        $order['order_amount'] = substr($currentSheet->getCell("E".$currentRow)->getValue(),1);
        $currentRow++;
        $order['consignee'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
        $order['tel'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['userid'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['street1'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
        $order['zipcode'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['city'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['state'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['country'] = trim($currentSheet->getCell("E".$currentRow)->getValue());
        $currentRow++;
        $order['ShippingService'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
        $currentRow++;
        $order['TransactionID'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
        $order['currency'] = 'USD';
        $order['paid_time'] = CFG_TIME;
        $order['Sales_account_id'] = $info['id'];
        $order['Sales_channels'] = $info['Sales_channels'];
        $order['goods_name'] = trim($currentSheet->getCell("C".$currentRow)->getValue());
        $sku = explode("商家编码:",trim($currentSheet->getCell("D".$currentRow)->getValue()));
        $order['SKU'] = @$sku[1];
        $goods_qty = explode("数量:",trim($currentSheet->getCell("E".$currentRow)->getValue()));
        $order['goods_qty'] = $goods_qty[1];
        $goods_price = explode("单价:$",trim($currentSheet->getCell("F".$currentRow)->getValue()));
        $order['goods_price'] = $goods_price[1];
        $order['currentRow'] = $currentRow;
        $object->saveimport($order);
        $order['currentRow'] = $this->moregoods($order,$currentSheet,$object);
        return $order;
    }
    function moregoods($order,$currentSheet,$object)
    {
        $currentRow = $order['currentRow'];
        $currentRow++;
        if($currentSheet->getCell("B".$currentRow)->getValue() <>""){//多产品
            $order['TransactionID'] = trim($currentSheet->getCell("B".$currentRow)->getValue());
            $order['goods_name'] = trim($currentSheet->getCell("C".$currentRow)->getValue());
            $sku = explode("商家编码:",trim($currentSheet->getCell("D".$currentRow)->getValue()));
            $order['SKU'] = $sku[1];
            $goods_qty = explode("数量:",trim($currentSheet->getCell("E".$currentRow)->getValue()));
            $order['goods_qty'] = $goods_qty[1];
            $goods_price = explode("单价:$",trim($currentSheet->getCell("F".$currentRow)->getValue()));
            $order['goods_price'] = $goods_price[1];
            $order['currentRow'] = $currentRow;
            $object->saveimport($order);
            return $this->moregoods($order,$currentSheet,$object);
        }else{
            return $order['currentRow'];
        }
    }
    function actiongetTrackInfo(){
        $object = new ModelDelivery();
        $rs = $object->getTrackInfo($_REQUEST['order_id']);
        echo $rs;exit;
    }
    function actionupdatetrack(){
        $object = new ModelDelivery();
        try {
                $msg = $object->updatetrackinfo($_REQUEST['id']);
                echo $msg;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            if($errorMsg <>'') echo "<br>发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();
    }
    /**
     * 导出ebay格式
     */
    function actionexportebay() {
        set_time_limit(0);
        $object = new ModelOrder();
        $action_list = explode(',',$_SESSION['action_list']);
        $goods = new ModelGoods();
        if($_GET['step'] == 'servicecheck') $status = $object->getorderflow(1,2);
        elseif($_GET['step'] == 'orderhandle') $status = $object->getorderflow(3,2);
        elseif($_GET['step'] == 'deportmanager') $status = $object->getorderflow(2,2);
        elseif($_GET['step'] == 'cod') $status = $object->getorderflow(11,2);
        elseif($_GET['step'] == 'refund') $status = $object->getorderflow(10,2);
        elseif($_GET['step'] == 'ofsorder') $status = $object->getorderflow(9,2);
        elseif($_GET['step'] == 'pickuporder') $status = $object->getorderflow(8,2);
        elseif($_GET['step'] == 'shipedorder') $status = $object->getorderflow(17,2);
        elseif($_GET['step'] == 'eubhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shipping'] = $object->getExshipping('EUB');
        }
        elseif($_GET['step'] == '4pxhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('4PX');
        }
        elseif($_GET['step'] == 'coolhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('US');
        }
        elseif($_GET['step'] == 'birdhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('BIRD');
        }
        elseif($_GET['step'] == 'sfchandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('SFC');
        }
        elseif($_GET['step'] == 'ck1handle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('CHUKOU1');
        }
        elseif($_GET['step'] == 'ytghandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YTG');
        }
        elseif($_GET['step'] == 'dedhlhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('DEDHL');
        }
        elseif($_GET['step'] == 'ppalhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('PYB');
        }
        elseif($_GET['step'] == 'ywhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YW');
        }
        if($_GET['step'] == 'orderhandle'){
            $where = $object->getWhere($_REQUEST,$status,'',$object->getExshipping());
        }else{
            $where = $object->getWhere($_REQUEST,$status);
        }
        $list = $object->getOrderList(0,5000,$where);
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
        $header = 'SalesRecord Number,User Id,Buyer Fullname,Buyer Phone Number,Buyer Email,Buyer Address 1,Buyer Address 2,Buyer City,Buyer State,Paid Time,Buyer Zip,Buyer Country,Order ID,Item ID,SKU,Item Title,Quantity,Sale Price,Total Price,PayPal Transaction ID,Shipping Service,Weigth,Amazon_OrderItem ID';
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
        $objPHPExcel->getActiveSheet()->setTitle('ebay');
        echo date('H:i:s') . " Write to Excel5 format<br>";
        include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php');
        $t =2;    
        for($i=0;$i<count($list);$i++){
            $goodslist = $object->order_goods_info($list[$i]['order_id'],false);
            for($j = 0;$j<count($goodslist);$j++){
                $cf = 'A';
                $order_value[] =  $list[$i]['sellsrecord'];
                $order_value[] =  $list[$i]['userid'];
                $order_value[] =  $list[$i]['consignee'];
                $order_value[] =  $list[$i]['tel'];
                $order_value[] =  $list[$i]['email'];
                $order_value[] =  $list[$i]['street1'];
                $order_value[] =  $list[$i]['street2'];
                $order_value[] =  $list[$i]['city'];
                $order_value[] =  $list[$i]['state'];
                $order_value[] =  $list[$i]['paid_time'];
                $order_value[] =  $list[$i]['zipcode'];
                $order_value[] =  $list[$i]['country'];
                $order_value[] =  $list[$i]['order_sn'];
                $order_value[] =  $goodslist[$j]['item_no'];
                $order_value[] =  $goodslist[$j]['goods_sn'];
                $order_value[] =  $goodslist[$j]['goods_name'];
                $order_value[] =  $goodslist[$j]['goods_qty'];
                $order_value[] =  $goodslist[$j]['goods_price'];
                $order_value[] =  ($j==0)?$list[$i]['order_amount']:'';
                $order_value[] =  '';
                $order_value[] =  $list[$i]['ShippingService'];
                $order_value[] =  $goodslist[$j]['goods_weigth'];
                $order_value[] =  $list[$i]['paypalid'];
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
        }
        if($showtable) echo '</table>';
        $objWriter = new PHPExcel_Writer_Excel2007($objPHPExcel);
        $file = CFG_PATH_DATA.'ordertmp/ebayorder'.$_SESSION['admin_id'].'.xlsx';
        if(file_exists($file)) unlink($file);
        $objWriter->save($file);//define xls name
        $file = str_replace(CFG_PATH_ROOT, '', $file);
        echo date('H:i:s') . " Done writing files.<br>";
        page::todo($file);
        die();
    }
    function actionimportshipworks(){
        parent::actionPrivilege('import_shipworks');
        $this->name = 'shipworkimport';
        $this->show();
    }
    /*****************
    **** 导入处理过的shipworks的订单
    *****************/
    function actionhandleshipwork()
    {
        include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
        $objReader = new PHPExcel_Reader_Excel5();
        $objReader->setReadDataOnly(true);
        $objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
        $currentSheet =$objPHPExcel->getSheet(0);
        $allRow = $currentSheet->getHighestRow();
        $allColumn = $currentSheet->getHighestColumn();
        $object = new ModelOrder();
        $rs = array();
        for($currentRow = 2;$currentRow<=$allRow;$currentRow++){
            $com = array();
            $info = explode(',',$currentSheet->getCell('A'.$currentRow)->getValue());
            $object->shipworksupdate($info);
        }
        echo "{success:true,msg:'OK'}";exit;
    }
    /**
     * 速邮宝订单处理
     */
    function actionSubhandle(){
        parent::actionPrivilege('Subhandle');
        $this->name = 'subhandle';
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('url','http://www.szice.net');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(5));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 获取速邮宝相关订单
     */
    function actionGetsubhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('SUB');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * 捡货清单
     */
    function actionpicklist(){
        $object = new ModelOrder();
        $this->title = '捡货清单';
        $picklist = $object->getPicklist($_REQUEST['id']);
        $this->name = 'picklist';
        $this->tpl->assign('picklist',$picklist);
        $this->show();
    }
    /**
     * FastWay订单处理页面
     */
    function actionfastwayhandle() {
        //parent::actionPrivilege('list_usps');
        $this->name = 'fastwayhandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.usps.com');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 获取USPS待处理订单列表
     */
    function actionGetfastwayhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('FASTWAY');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     * USPS订单处理页面
     */
    function actionauposthandle() {
        //parent::actionPrivilege('list_usps');
        $this->name = 'auposthandle';
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
        $this->tpl->assign('url','http://www.usps.com');
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 获取USPS待处理订单列表
     */
    function actionGetauposthandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('AUPOST');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     *
     * 获取互联易运单条码
     * $_POST['ids']  订单号
     */
    function actiongetIceTrackNo(){
        try {
                $object = new ModelDelivery();
                //$url = "http://kd.szice.net:8086/xms/client/order_online!print.action?userToken=b5cde53b270c4aadb6d859845d03179c&oid=";
                $msg = $object->updateIce($_POST);
                
                echo $msg;exit;
            } catch (Exception $e) {
                    $errorMsg = $e->getMessage();
            }
            echo $errorMsg;exit;
        
        
    }
    /**
     *
     * 互联易打印标签
     * $_POST['ids']  订单号
     */
    function actionPrintIceLabel(){
        try {
            $object = new ModelDelivery();
            $url = $object->icelabelprint($_REQUEST);
            
            echo $url;exit;
        } catch (Exception $e) {
            $errorMsg = $e->getMessage();
        }
        echo $errorMsg;exit;
    }
    /**
     * 批量更新物流方式
     */
    function actionupdateshipping(){
        $object = new ModelOrder();
        try {
            $object->updateshipping($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'OK'}";exit;
    }/**
     * 批量更新物流方式
     */
    function actiongetck1_printlabel(){ 
        $object = new ModelDelivery();
        try {
            $url = $object->getck1_printlabel($_REQUEST);
            
            echo $url;exit;
        } catch (Exception $e) {
            $errorMsg = $e->getMessage();         
        }
        echo $errorMsg;exit;          
    }
    /**
     *未付款订单页面
     */
    function actionunpaidorder() {
        parent::actionPrivilege('list_unpaid');
        $this->name = 'unpaidorder';
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(1));
        $arr = $object->getorderflow(18,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->show();
    }
    /**
     * 获取未付款列表
     */
    function actionGetunpaidorder() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(18,2);
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,1,0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    function actionremark_order(){
        $object = new ModelOrder();
        try {
            $object->remark_order($_POST['ids']);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'OK'}";exit;
    }
    /**
     * 处理线下eub压缩包
     */
    function actionhandlerzip() {                                 
        $object = new ModelDelivery();
        try {
            $id = explode(',',$_POST['id']);
            if(count($id)>200)exit( "测试阶段请不要大于200个订单。");
            $pdflist = $object->eub1blukopen_pdf($_POST);
            require(CFG_PATH_LIB.'util/JSON.php');
            $json = new Services_JSON();
            echo $json->encode($pdflist);exit();
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        echo "发生以下错误:$errorMsg";exit;
    }
    
    /**
     * 处理线下eub压缩包
     */
    function actionopenpdf() {
        $urls = explode(',',$_GET['urls']);
        $this->tpl->assign('urls',$urls);
        $this->name="openpdf";
        $this->show();
    }
    
    /**
     * 清空eubtrack
     */
    function actioncleareuborder() {
        $object = new ModelOrder();
        try {
            $object->cleareuborder($_REQUEST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;         
        }
        echo "{success:true,msg:'OK'}";exit;
    } 
    /**
     * 合并线下EUB的pdf
     */
    function actionbulkpdf() {  
        $object = new ModelOrder();
        if($_POST['ids']){
            require(CFG_PATH_LIB.'util/JSON.php');
            $json = new Services_JSON();
            $arr = $json->decode(stripslashes($_POST['ids']));
            
            
            $type = $arr[0]->label_type; 
            $shell = new shell();
            $path = str_replace('/erp/','',CFG_URL);
            $out_img = array();/*  合并后输出的图片 */
            $dir = '/var/www/html/api/label/img/pdf_'.$_SESSION['company'].'_'.$_SESSION['admin_id'].'/';
            if(!is_dir($dir)){
                mkdir($dir,0777);        
            }else{
                system('rm -rf '.$dir.'*');
            }
            if($type=='A4'){
                //echo 'ok';exit();
                //A4格式的图片宽  w:893  h:1263     870  631.5
                for($i=0;$i<count($arr);$i++){
                    $command = '';
                    $pdf_file = str_replace($path,$_SERVER['DOCUMENT_ROOT'],$arr[$i]->url);
                    $command = 'convert -density 280 -crop 100%x50%+0+0 -resize 893x631.5 '.$pdf_file.' '.$dir.$arr[$i]->track_no.'.jpg';
                    system($command);
                    $new_img[] = $dir.$arr[$i]->track_no.'.jpg';
                    if( ($i+1) % 2 == 0){
                        $lastcommand = 'convert -append ';
                        foreach($new_img as $img){
                            $lastcommand .= ' '.$img;        
                        }
                        $lastcommand .= ' '.$dir.$i.'.jpg';
                        system($lastcommand);
                        $out_img[] = $path.str_replace('/var/www/html','',$dir).$i.'.jpg';
                        system('rm -f '.$new_img[0].' '.$new_img[1]);
                        $new_img = array(); /* 重置数组  */                                                    
                    }
                }                        
            }else{
                //echo 'ok';exit();
                //A4格式的图片宽  w:383  h:383 
                for($i=0;$i<count($arr);$i++){
                    $command = '';
                    $pdf_file = str_replace($path,$_SERVER['DOCUMENT_ROOT'],$arr[$i]->url);
                    $command = 'convert -density 280 -resize 383x '.$pdf_file.' '.$dir.$arr[$i]->track_no.'.jpg';
                    system($command);
                    $out_img[] = $path.str_replace('/var/www/html','',$dir).$arr[$i]->track_no.'-0.jpg';
                    $out_img[] = $path.str_replace('/var/www/html','',$dir).$arr[$i]->track_no.'-1.jpg';  
                }        
            }
        }                                   
        $this->tpl->assign('imgs',$out_img);
        $this->tpl->assign('type',$type);
        $this->name="imgbulk";
        $this->show();
    }
    /**
     * 获取俄速通待处理订单列表
     */
    function actionGetEsthandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('EST');
        $_REQUEST['shipping'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /*
    * 俄速通订单页面 
    */
    function actionEsthandle(){
        parent::actionPrivilege('est_list');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        
        $this->name="esthandle";
        $this->show();    
    }
    /*
    * 提交俄速通订单 
    */
    function actionGetESTtracking(){
        $object = new ModelDelivery();
        try {
            $msg = $object->CreateESuTongOrder($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /*
    * 预报俄速通订单 
    */
    function actionPreAlertEstOrder(){
        $object = new ModelDelivery();
        try {
            $msg = $object->PreAlertEstOrder($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /**
     * 获取中环运待处理订单列表
     */
    function actionGetZhyhandle() {
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2);
        $shipping_ex = $object->getExshipping('ZHY');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],0,0,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /*
    * 中环运订单页面 
    */
    function actionZhyhandle(){
        parent::actionPrivilege('zhy_list');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        
        $this->name="zhyhandle";
        $this->show();    
    }
    /*
    * 提交中环运订单 
    */
    function actionGetzhytracking(){
        $object = new ModelDelivery();
        try {
            $msg = $object->UpdateZHYorder($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /*
    * 贝邮宝订单页面 
    */
    function actionpppackagehandler(){
        parent::actionPrivilege('list_pppackage');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        
        $this->name="ppalhandle";
        $this->show();    
    }
    /*
    * 提交贝邮宝订单 
    */
    function actionGetPPpackagetracking(){
        $object = new ModelDelivery();
        try {
            $msg = $object->GetPPpackagetracking($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /*
    * 获取贝邮宝订单列表 
    */
    function actiongetPYBhandler(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2); 
        $shipping_ex = $object->getExshipping('PYB');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /*
    * 燕文订单页面 
    */
    function actionywhandle(){
       // parent::actionPrivilege('yw_list');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        
        $moreshippings = ModelSystem::get('CFG_MORE_SHIPPINGS');      //是否使用物流多账号   
        $this->tpl->assign('is_more_ships_account',$moreshippings);  
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $ships_account = array();  
        if($moreshippings){ 
            $ships_account = array(
                ModelSystem::get('CFG_YW_KEY') => ModelSystem::get('CFG_YW_TOKEN'),
                ModelSystem::get('CFG_YW_KEY2') => ModelSystem::get('CFG_YW_TOKEN2'),
            
            );         
        }
        $this->tpl->assign('ships_account',ModelDd::arrayFormat($ships_account));
        
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));

        $this->name="ywhandler";
        $this->show();    
    }
    /*
    * 提交燕文订单 
    */
    function actionGetywtracking(){
        $object = new ModelDelivery();
        try {
            $msg = $object->GetYwtracking($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /*
    * 获取燕文订单列表 
    */
    function actiongetywhandler(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2); 
        $shipping_ex = $object->getExshipping('YW');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    /**
     *
     * 燕文打印标签
     * $_POST['ids']  订单号
     */
    function actionPrintYWLabel(){
        
        if($_REQUEST['ids']){
            require(CFG_PATH_LIB.'util/JSON.php');
            $json = new Services_JSON();
            $arr = $json->decode(stripslashes($_REQUEST['ids']));
            
            $account = '';
            
            $ordersn = '<string>';
            
            $labeltype = '';
            $order = '';
            foreach($arr as $value){
                
                $array = explode('_',$value);
                
                $account = $array[0];    
               
                $ordersn .= $array[1].','; 
                $order .= $array[1];
                $labeltype = $array[2];
              
            }
            $ordersn .= '</string>';
            $tokenauth = '';
            if(CFG_YW_KEY == $account){
                $tokenauth = CFG_YW_TOKEN;            
                
            }else{
                $tokenauth = CFG_YW_TOKEN2;             
            }
            
            $post_header = array('Authorization: basic '.$tokenauth, 'Content-Type: text/xml; charset=utf-8');
            $post_data = $ordersn;
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, 'http://online.yw56.com.cn/service/Users/'.$account.'/Expresses/A4Label');

            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_VERBOSE, 1);
            curl_setopt($curl, CURLOPT_HEADER, 0); //不取得返回头信息 



            curl_setopt($curl, CURLOPT_HTTPHEADER, $post_header);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);

            $result = curl_exec($curl);
            curl_close($curl) ;
            
            $dirname = CFG_PATH_DATA.'upload/';
            $temfile = $dirname.'yw_tem'.'.pdf';            
            $temfile = str_replace(CFG_PATH_ROOT, '', $temfile);
            $fp = fopen($temfile, "w+");
            fputs($fp, $result);
            fclose($fp);
            
            echo html_entity_decode($temfile);exit;
        }
        
        try {
            
            /*
            $_REQUEST['users']
            $_REQUEST['track_nos']*/
            
        } catch (Exception $e) {
            $errorMsg = $e->getMessage();
        }
        echo $errorMsg;exit;
    }
    /*
    * 顺友订单页面 
    */
    function actionsyhandle(){
       // parent::actionPrivilege('sy_list');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(3,1);
        
        $moreshippings = ModelSystem::get('CFG_MORE_SHIPPINGS');      //是否使用物流多账号   
        $this->tpl->assign('is_more_ships_account',$moreshippings);  
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $ships_account = array();  
        
        $this->tpl->assign('ships_account',ModelDd::arrayFormat($ships_account));
        
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));

        $this->name="syhandler";
        $this->show();    
    }
    /*
    * 待打印订单页面 
    */
    function actionwait_print_orderhandle(){
       // parent::actionPrivilege('sy_list');
        $this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
        //$shipping = include(CFG_PATH_DATA.'shipping/'.$_SESSION['admin_id'].'.php');
        //$this->tpl->assign('shipping',ModelDd::arrayFormat($shipping));
        $this->tpl->assign('shipping',ModelDd::getComboData('shipping')); 
        $object = new ModelOrder();
        $this->tpl->assign('fileds',$object->getcolumn(4));
        $arr = $object->getorderflow(19,1);
        $this->tpl->assign('print_template',ModelDd::getComboData('print_template'));
        $this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
        $this->name="orderhandle_waitprint";
        $this->show();    
    }
    
    
    
    /*
    * 获取待打印订单列表 
    */
    function actiongetwait_print_orderhandler(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(19,0); 
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    
    
    
    
    
    
    
    /*
    * 提交顺友订单 
    */
    function actionGetsytracking(){
        $object = new ModelDelivery();
        try {
            $msg = $object->GetSytracking($_POST);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
        }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    /*
    * 获取顺友订单列表 
    */
    function actiongetsyhandler(){
        require(CFG_PATH_LIB.'util/JSON.php');
        $json = new Services_JSON();
        $_REQUEST['sort'] = str_replace('\\','',$_REQUEST['sort']);
        $sortob = $json->decode($_REQUEST['sort']);
        $_REQUEST['property'] = $sortob[0]->property;
        $_REQUEST['direction'] = $sortob[0]->direction;
        $pageLimit = getPageLimit();
        $object = new ModelOrder();
        $status = $object->getorderflow(3,2); 
        $shipping_ex = $object->getExshipping('SY');
        $_REQUEST['shippings'] = $shipping_ex;
        $where = $object->getWhere($_REQUEST,$status);
        $list = $object->getOrderList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['checkcombine'],1,1,$pageLimit['sort']);
        $result['totalCount'] = $object->getOrderCount($where);
        $result['topics'] = $list;
        echo $json->encode($result);
    }
    
    
    /*
    * 扫描录入单号 
    */
    function actionscantracking(){
        
        $this->name="scantracking";
        $this->show();    
    }/**
     * 导出ebay格式
     */
    function actionexportPicklist() {
        
        
        
        
        set_time_limit(0);
        $object = new ModelOrder();
        $action_list = explode(',',$_SESSION['action_list']);            
        if($_GET['step'] == 'servicecheck') $status = $object->getorderflow(1,2);
        elseif($_GET['step'] == 'orderhandle') $status = $object->getorderflow(3,2);
        elseif($_GET['step'] == 'deportmanager') $status = $object->getorderflow(2,2);
        elseif($_GET['step'] == 'cod') $status = $object->getorderflow(11,2);
        elseif($_GET['step'] == 'refund') $status = $object->getorderflow(10,2);
        elseif($_GET['step'] == 'ofsorder') $status = $object->getorderflow(9,2);
        elseif($_GET['step'] == 'pickuporder') $status = $object->getorderflow(8,2);
        elseif($_GET['step'] == 'shipedorder') $status = $object->getorderflow(17,2);
        elseif($_GET['step'] == 'eubhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shipping'] = $object->getExshipping('EUB');
        }
        elseif($_GET['step'] == '4pxhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('4PX');
        }
        elseif($_GET['step'] == 'coolhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('US');
        }
        elseif($_GET['step'] == 'birdhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('BIRD');
        }
        elseif($_GET['step'] == 'sfchandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('SFC');
        }
        elseif($_GET['step'] == 'ck1handle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('CHUKOU1');
        }
        elseif($_GET['step'] == 'ytghandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YTG');
        }
        elseif($_GET['step'] == 'dedhlhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('DEDHL');
        }
        elseif($_GET['step'] == 'ppalhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('PYB');
        }
        elseif($_GET['step'] == 'ywhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('YW');
        }
        elseif($_GET['step'] == 'syhandle') {
            $status = $object->getorderflow(3,2);
            $_REQUEST['shippings'] = $object->getExshipping('SY');
        }
        if($_GET['step'] == 'orderhandle'){
            $where = $object->getWhere($_REQUEST,$status,'',$object->getExshipping());
        }else{
            $where = $object->getWhere($_REQUEST,$status);
        }
        $list = $object->getOrderList(0,5000,$where); 
        
        $ids = '';
        
        for($i=0;$i<count($list);$i++){
            
            if($ids == ''){
                $ids .= $list[$i]['order_id'];
            }else{
                $ids .= ','.$list[$i]['order_id'];   
            }
            
        }
                   
        $picklist = $object->getPickListExport($ids);

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
        $header = 'SKU,数量,仓位,订单号';          
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
        $objPHPExcel->getActiveSheet()->setTitle('ebay');
        echo date('H:i:s') . " Write to Excel5 format<br>";
        include_once(CFG_PATH_LIB.'PHPExcel/Writer/Excel2007.php'); 
        
        
        $t =2;    
         
        for($i=0;$i<count($picklist);$i++){
                                                    
                $cf = 'A';
                $order_value[] =  $picklist[$i]['SKU'];
                $order_value[] =  $picklist[$i]['qty'];
                $order_value[] =  $picklist[$i]['stock_place'];
                $order_value[] =  $picklist[$i]['order_sns'];
                
                
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
        $file = CFG_PATH_DATA.'ordertmp/orderpicklist'.$_SESSION['admin_id'].'.xlsx';
        if(file_exists($file)) unlink($file);
        $objWriter->save($file);//define xls name
        $file = str_replace(CFG_PATH_ROOT, '', $file);
        echo date('H:i:s') . " Done writing files.<br>";
        page::todo($file);
        die();
    }


    /*
    * 提交aliexpress
    */
    function actionGetsubalitracking(){
        $object = new ModelAliexpress();
        try {
            $msg = $object->getgetOnlineLogisticsInfo($_POST['id']);
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
         }
        echo "{success:true,msg:'".$msg."'}";exit;
            
    }
    
    /***
    * 
    *  自动完成库管缺货到货
    * 
    ***/
    
    function actionCheckDepotComplete(){
        //checkDepotComplete    
        $object = new ModelOrder();
        try {
            $msg = $object->checkDepotComplete();
          
        } catch (Exception $e) {
            echo "{success:false,msg:'".$e->getMessage()."'}";exit;
         }
        echo "{success:true,msg:'".$msg."'}";exit;
    }
    
    
}
?>
