<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 系统设置
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Controller
 * @version v0.1
 */
class System extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '系统设置';
		$this->name = 'system';
		$this->dir = 'system';
	}
	/**
	 * 登录界面
	 */
	function actionIndex() {
		parent::actionPrivilege('view_system');
		$rs = ModelSystem::get();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$info = $json->encode($rs);
		$this->tpl->assign('info',$info);
		$this->show();
	}
	
	/**
	 * 保存
	 */
	function actionSave()
	{
		if(parent::actionCheck('edit_system'))
		{
			$_POST['CFG_EXPRESS_RULE'] = ($_POST['CFG_EXPRESS_RULE'])?1:0;
			$_POST['CFG_GOODS_CHECK'] = ($_POST['CFG_GOODS_CHECK'])?1:0;
			$_POST['CFG_GOODS_SPLIT'] = ($_POST['CFG_GOODS_SPLIT'])?1:0;
			$_POST['CFG_EUB_MARK'] = ($_POST['CFG_EUB_MARK'])?1:0;
			$_POST['CFG_AUTOCREAT_SN'] = ($_POST['CFG_AUTOCREAT_SN'])?1:0;
			$_POST['CFG_GOODS_UPDATEQTY'] = ($_POST['CFG_GOODS_UPDATEQTY'])?1:0;
			$_POST['CFG_GOODS_COLLATION'] = ($_POST['CFG_GOODS_COLLATION'])?1:0;
			$_POST['CFG_GOODS_UPDATECOST'] = ($_POST['CFG_GOODS_UPDATECOST'])?1:0;
			$_POST['CFG_CHECK_PAYPAL'] = ($_POST['CFG_CHECK_PAYPAL'])?1:0;
			$_POST['CFG_GOODS_SPLIT'] = ($_POST['CFG_GOODS_SPLIT'])?1:0;
			$_POST['CFG_CHECK_SIS'] = ($_POST['CFG_CHECK_SIS'])?1:0;
			$_POST['CFG_REPLACE_ADD'] = ($_POST['CFG_REPLACE_ADD'])?1:0;
			$_POST['CFG_OTHER_SKU'] = ($_POST['CFG_OTHER_SKU'])?1:0;
			$_POST['CFG_ENABLE_4PX'] = ($_POST['CFG_ENABLE_4PX'])?1:0;    
			$_POST['CFG_RETURN_4PX'] = ($_POST['CFG_RETURN_4PX'])?1:0;
			$_POST['CFG_ENABLE_EUB'] = ($_POST['CFG_ENABLE_EUB'])?1:0;
			$_POST['CFG_ENABLE_SFC'] = ($_POST['CFG_ENABLE_SFC'])?1:0;
			$_POST['CFG_ENABLE_CK1'] = ($_POST['CFG_ENABLE_CK1'])?1:0;
			$_POST['CFG_ENABLE_YTG'] = ($_POST['CFG_ENABLE_YTG'])?1:0;
            $_POST['CFG_ENABLE_ICE'] = ($_POST['CFG_ENABLE_ICE'])?1:0;
            $_POST['CFG_ENABLE_EST'] = ($_POST['CFG_ENABLE_EST'])?1:0;
			$_POST['CFG_ENABLE_ZHY'] = ($_POST['CFG_ENABLE_ZHY'])?1:0;
			$_POST['CFG_UPDATE_ORDER'] = ($_POST['CFG_UPDATE_ORDER'])?1:0;
			$_POST['CFG_IGONRE_ORDER'] = ($_POST['CFG_IGONRE_ORDER'])?1:0;
			$_POST['CFG_AUTO_FBA'] = ($_POST['CFG_AUTO_FBA'])?1:0;
			$_POST['CFG_GOODS_COMBSPLIT'] = ($_POST['CFG_GOODS_COMBSPLIT'])?1:0;
			$_POST['CFG_GOODSSN_AUTOLENGTH'] = ($_POST['CFG_GOODSSN_AUTOLENGTH'])?1:0;
			$_POST['CFG_REDUCE_QTY'] = ($_POST['CFG_REDUCE_QTY'])?1:0; 
            $_POST['CFG_IMPORT_CUSTOMS'] = ($_POST['CFG_IMPORT_CUSTOMS'])?1:0;
			$_POST['CFG_DECLARED_ORDER_QTY_1'] = ($_POST['CFG_DECLARED_ORDER_QTY_1'])?1:0;
            $_POST['CFG_EUB1_A4LABEL'] = ($_POST['CFG_EUB1_A4LABEL'])?1:0;
            $_POST['CFG_CK1_A4LABEL'] = ($_POST['CFG_CK1_A4LABEL'])?1:0;
            $_POST['CFG_CK1_LABELDEC'] = ($_POST['CFG_CK1_LABELDEC'])?1:0;
            $_POST['CFG_ZHY_A4LABEL'] = ($_POST['CFG_ZHY_A4LABEL'])?1:0;
            $_POST['CFG_ZHY_LABELDEC'] = ($_POST['CFG_ZHY_LABELDEC'])?1:0;
            $_POST['CFG_ENABLE_PYB'] = ($_POST['CFG_ENABLE_PYB'])?1:0;
            $_POST['CFG_ENABLE_YW'] = ($_POST['CFG_ENABLE_YW'])?1:0;
            $_POST['CFG_ENABLE_SY'] = ($_POST['CFG_ENABLE_SY'])?1:0;
            $_POST['CFG_ALI_SPLITGOODS'] = ($_POST['CFG_ALI_SPLITGOODS'])?1:0;
            $_POST['CFG_MORE_SHIPPINGS'] = ($_POST['CFG_MORE_SHIPPINGS'])?1:0;
            $_POST['CFG_ALI_KEYWORDTODEC'] = ($_POST['CFG_ALI_KEYWORDTODEC'])?1:0;
			$system = new ModelSystem();
			$system->save($_POST);
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	
	function actionsavecolumn()
	{
			$_POST['print_status_1'] = ($_POST['print_status_1'])?1:0;
			$_POST['order_status_1'] = ($_POST['order_status_1'])?1:0;
			$_POST['paid_time_1'] = ($_POST['paid_time_1'])?1:0;
			$_POST['sellsrecord_1'] = ($_POST['sellsrecord_1'])?1:0;
			$_POST['order_sn_1'] = ($_POST['order_sn_1'])?1:0;
			$_POST['paypalid_1'] = ($_POST['paypalid_1'])?1:0;
			$_POST['currency_1'] = ($_POST['currency_1'])?1:0;
			$_POST['order_amount_1'] = ($_POST['order_amount_1'])?1:0;
			$_POST['goods_1'] = ($_POST['goods_1'])?1:0;
			$_POST['shipping_id_1'] = ($_POST['shipping_id_1'])?1:0;
			$_POST['track_no_1'] = ($_POST['track_no_1'])?1:0;
			$_POST['eubpdf_1'] = ($_POST['eubpdf_1'])?1:0;
			$_POST['userid_1'] = ($_POST['userid_1'])?1:0;
			$_POST['country_1'] = ($_POST['country_1'])?1:0;
			$_POST['Sales_channels_1'] = ($_POST['Sales_channels_1'])?1:0;
            $_POST['ShippingService_1'] = ($_POST['ShippingService_1'])?1:0;
			$_POST['Sales_account_id_1'] = ($_POST['Sales_account_id_1'])?1:0;
            $_POST['stockout_sn_1'] = ($_POST['stockout_sn_1'])?1:0;
			$_POST['shipping_fee_1'] = ($_POST['shipping_fee_1'])?1:0;
			$_POST['print_status_2'] = ($_POST['print_status_2'])?1:0;
			$_POST['order_status_2'] = ($_POST['order_status_2'])?1:0;
			$_POST['paid_time_2'] = ($_POST['paid_time_2'])?1:0;
			$_POST['sellsrecord_2'] = ($_POST['sellsrecord_2'])?1:0;
			$_POST['order_sn_2'] = ($_POST['order_sn_2'])?1:0;
			$_POST['paypalid_2'] = ($_POST['paypalid_2'])?1:0;
			$_POST['currency_2'] = ($_POST['currency_2'])?1:0;
			$_POST['order_amount_2'] = ($_POST['order_amount_2'])?1:0;
			$_POST['goods_2'] = ($_POST['goods_2'])?1:0;
			$_POST['stock_place_2'] = ($_POST['stock_place_2'])?1:0;
			$_POST['shipping_id_2'] = ($_POST['shipping_id_2'])?1:0;
			$_POST['track_no_2'] = ($_POST['track_no_2'])?1:0;
			$_POST['eubpdf_2'] = ($_POST['eubpdf_2'])?1:0;
			$_POST['userid_2'] = ($_POST['userid_2'])?1:0;
			$_POST['country_2'] = ($_POST['country_2'])?1:0;
			$_POST['Sales_channels_2'] = ($_POST['Sales_channels_2'])?1:0;
			$_POST['Sales_account_id_2'] = ($_POST['Sales_account_id_2'])?1:0;
			$_POST['stockout_sn_2'] = ($_POST['stockout_sn_2'])?1:0;
            $_POST['ShippingService_2'] = ($_POST['ShippingService_2'])?1:0;
            $_POST['shipping_fee_2'] = ($_POST['shipping_fee_2'])?1:0;
			$_POST['print_status_3'] = ($_POST['print_status_3'])?1:0;
			$_POST['order_status_3'] = ($_POST['order_status_3'])?1:0;
			$_POST['paid_time_3'] = ($_POST['paid_time_3'])?1:0;
			$_POST['sellsrecord_3'] = ($_POST['sellsrecord_3'])?1:0;
			$_POST['order_sn_3'] = ($_POST['order_sn_3'])?1:0;
			$_POST['paypalid_3'] = ($_POST['paypalid_3'])?1:0;
			$_POST['currency_3'] = ($_POST['currency_3'])?1:0;
			$_POST['order_amount_3'] = ($_POST['order_amount_3'])?1:0;
			$_POST['goods_3'] = ($_POST['goods_3'])?1:0;
			$_POST['stock_place_3'] = ($_POST['stock_place_3'])?1:0;
			$_POST['shipping_id_3'] = ($_POST['shipping_id_3'])?1:0;
			$_POST['track_no_3'] = ($_POST['track_no_3'])?1:0;
			$_POST['eubpdf_3'] = ($_POST['eubpdf_3'])?1:0;
			$_POST['userid_3'] = ($_POST['userid_3'])?1:0;
			$_POST['country_3'] = ($_POST['country_3'])?1:0;
			$_POST['Sales_channels_3'] = ($_POST['Sales_channels_3'])?1:0;
			$_POST['Sales_account_id_3'] = ($_POST['Sales_account_id_3'])?1:0;
			$_POST['stockout_sn_3'] = ($_POST['stockout_sn_3'])?1:0;
            $_POST['ShippingService_3'] = ($_POST['ShippingService_3'])?1:0;
			$_POST['print_status_4'] = ($_POST['print_status_4'])?1:0;
			$_POST['order_status_4'] = ($_POST['order_status_4'])?1:0;
			$_POST['paid_time_4'] = ($_POST['paid_time_4'])?1:0;
			$_POST['sellsrecord_4'] = ($_POST['sellsrecord_4'])?1:0;
			$_POST['order_sn_4'] = ($_POST['order_sn_4'])?1:0;
			$_POST['paypalid_4'] = ($_POST['paypalid_4'])?1:0;
			$_POST['currency_4'] = ($_POST['currency_4'])?1:0;
			$_POST['order_amount_4'] = ($_POST['order_amount_4'])?1:0;
			$_POST['goods_4'] = ($_POST['goods_4'])?1:0;
			$_POST['stock_place_4'] = ($_POST['stock_place_4'])?1:0;
			$_POST['shipping_id_4'] = ($_POST['shipping_id_4'])?1:0;
			$_POST['track_no_4'] = ($_POST['track_no_4'])?1:0;
			$_POST['eubpdf_4'] = ($_POST['eubpdf_4'])?1:0;
			$_POST['userid_4'] = ($_POST['userid_4'])?1:0;
			$_POST['country_4'] = ($_POST['country_4'])?1:0;
			$_POST['Sales_channels_4'] = ($_POST['Sales_channels_4'])?1:0;
			$_POST['Sales_account_id_4'] = ($_POST['Sales_account_id_4'])?1:0;
			$_POST['stockout_sn_4'] = ($_POST['stockout_sn_4'])?1:0;
            $_POST['ShippingService_4'] = ($_POST['ShippingService_4'])?1:0;
			$_POST['print_status_5'] = ($_POST['print_status_5'])?1:0;
			$_POST['order_status_5'] = ($_POST['order_status_5'])?1:0;
			$_POST['paid_time_5'] = ($_POST['paid_time_5'])?1:0;
			$_POST['sellsrecord_5'] = ($_POST['sellsrecord_5'])?1:0;
			$_POST['order_sn_5'] = ($_POST['order_sn_5'])?1:0;
			$_POST['paypalid_5'] = ($_POST['paypalid_5'])?1:0;
			$_POST['currency_5'] = ($_POST['currency_5'])?1:0;
			$_POST['order_amount_5'] = ($_POST['order_amount_5'])?1:0;
			$_POST['goods_5'] = ($_POST['goods_5'])?1:0;
			$_POST['stock_place_5'] = ($_POST['stock_place_5'])?1:0;
			$_POST['shipping_id_5'] = ($_POST['shipping_id_5'])?1:0;
			$_POST['track_no_5'] = ($_POST['track_no_5'])?1:0;
			$_POST['eubpdf_5'] = ($_POST['eubpdf_5'])?1:0;
			$_POST['userid_5'] = ($_POST['userid_5'])?1:0;
			$_POST['country_5'] = ($_POST['country_5'])?1:0;
			$_POST['Sales_channels_5'] = ($_POST['Sales_channels_5'])?1:0;
			$_POST['Sales_account_id_5'] = ($_POST['Sales_account_id_5'])?1:0;
			$_POST['stockout_sn_5'] = ($_POST['stockout_sn_5'])?1:0;
            $_POST['ShippingService_5'] = ($_POST['ShippingService_5'])?1:0;
			$_POST['print_status_6'] = ($_POST['print_status_6'])?1:0;
			$_POST['order_status_6'] = ($_POST['order_status_6'])?1:0;
			$_POST['paid_time_6'] = ($_POST['paid_time_6'])?1:0;
			$_POST['sellsrecord_6'] = ($_POST['sellsrecord_6'])?1:0;
			$_POST['order_sn_6'] = ($_POST['order_sn_6'])?1:0;
			$_POST['paypalid_6'] = ($_POST['paypalid_6'])?1:0;
			$_POST['currency_6'] = ($_POST['currency_6'])?1:0;
			$_POST['order_amount_6'] = ($_POST['order_amount_6'])?1:0;
			$_POST['goods_6'] = ($_POST['goods_6'])?1:0;
			$_POST['stock_place_6'] = ($_POST['stock_place_6'])?1:0;
			$_POST['shipping_id_6'] = ($_POST['shipping_id_6'])?1:0;
			$_POST['track_no_6'] = ($_POST['track_no_6'])?1:0;
			$_POST['eubpdf_6'] = ($_POST['eubpdf_6'])?1:0;
			$_POST['userid_6'] = ($_POST['userid_6'])?1:0;
			$_POST['country_6'] = ($_POST['country_6'])?1:0;
			$_POST['Sales_channels_6'] = ($_POST['Sales_channels_6'])?1:0;
			$_POST['Sales_account_id_6'] = ($_POST['Sales_account_id_6'])?1:0;
            $_POST['ShippingService_6'] = ($_POST['ShippingService_6'])?1:0;
			$_POST['stockout_sn_6'] = ($_POST['stockout_sn_6'])?1:0;
			$_POST['print_status_7'] = ($_POST['print_status_7'])?1:0;
			$_POST['order_status_7'] = ($_POST['order_status_7'])?1:0;
			$_POST['paid_time_7'] = ($_POST['paid_time_7'])?1:0;
			$_POST['sellsrecord_7'] = ($_POST['sellsrecord_7'])?1:0;
			$_POST['order_sn_7'] = ($_POST['order_sn_7'])?1:0;
			$_POST['paypalid_7'] = ($_POST['paypalid_7'])?1:0;
			$_POST['currency_7'] = ($_POST['currency_7'])?1:0;
			$_POST['order_amount_7'] = ($_POST['order_amount_7'])?1:0;
			$_POST['goods_7'] = ($_POST['goods_7'])?1:0;
			$_POST['shipping_id_7'] = ($_POST['shipping_id_7'])?1:0;
			$_POST['track_no_7'] = ($_POST['track_no_7'])?1:0;
			$_POST['eubpdf_7'] = ($_POST['eubpdf_7'])?1:0;
			$_POST['userid_7'] = ($_POST['userid_7'])?1:0;
			$_POST['country_7'] = ($_POST['country_7'])?1:0;
			$_POST['Sales_channels_7'] = ($_POST['Sales_channels_7'])?1:0;
			$_POST['Sales_account_id_7'] = ($_POST['Sales_account_id_7'])?1:0;
			$_POST['stockout_sn_7'] = ($_POST['stockout_sn_7'])?1:0;
            $_POST['ShippingService_7'] = ($_POST['ShippingService_7'])?1:0;
			$_POST['print_status_8'] = ($_POST['print_status_8'])?1:0;
			$_POST['order_status_8'] = ($_POST['order_status_8'])?1:0;
			$_POST['paid_time_8'] = ($_POST['paid_time_8'])?1:0;
			$_POST['sellsrecord_8'] = ($_POST['sellsrecord_8'])?1:0;
			$_POST['order_sn_8'] = ($_POST['order_sn_8'])?1:0;
			$_POST['paypalid_8'] = ($_POST['paypalid_8'])?1:0;
			$_POST['currency_8'] = ($_POST['currency_8'])?1:0;
			$_POST['order_amount_8'] = ($_POST['order_amount_8'])?1:0;
			$_POST['goods_8'] = ($_POST['goods_8'])?1:0;
			$_POST['stock_place_8'] = ($_POST['stock_place_8'])?1:0;
			$_POST['shipping_id_8'] = ($_POST['shipping_id_8'])?1:0;
			$_POST['track_no_8'] = ($_POST['track_no_8'])?1:0;
			$_POST['eubpdf_8'] = ($_POST['eubpdf_8'])?1:0;
			$_POST['userid_8'] = ($_POST['userid_8'])?1:0;
			$_POST['country_8'] = ($_POST['country_8'])?1:0;
			$_POST['Sales_channels_8'] = ($_POST['Sales_channels_8'])?1:0;
			$_POST['Sales_account_id_8'] = ($_POST['Sales_account_id_8'])?1:0;
            $_POST['ShippingService_8'] = ($_POST['ShippingService_8'])?1:0;
			$_POST['stockout_sn_8'] = ($_POST['stockout_sn_8'])?1:0;
			$_POST['print_status_9'] = ($_POST['print_status_9'])?1:0;
			$_POST['order_status_9'] = ($_POST['order_status_9'])?1:0;
			$_POST['paid_time_9'] = ($_POST['paid_time_9'])?1:0;
			$_POST['sellsrecord_9'] = ($_POST['sellsrecord_9'])?1:0;
			$_POST['order_sn_9'] = ($_POST['order_sn_9'])?1:0;
			$_POST['paypalid_9'] = ($_POST['paypalid_9'])?1:0;
			$_POST['currency_9'] = ($_POST['currency_9'])?1:0;
			$_POST['order_amount_9'] = ($_POST['order_amount_9'])?1:0;
			$_POST['goods_9'] = ($_POST['goods_9'])?1:0;
			$_POST['stock_place_9'] = ($_POST['stock_place_9'])?1:0;
			$_POST['shipping_id_9'] = ($_POST['shipping_id_9'])?1:0;
			$_POST['track_no_9'] = ($_POST['track_no_9'])?1:0;
			$_POST['eubpdf_9'] = ($_POST['eubpdf_9'])?1:0;
			$_POST['userid_9'] = ($_POST['userid_9'])?1:0;
			$_POST['country_9'] = ($_POST['country_9'])?1:0;
			$_POST['Sales_channels_9'] = ($_POST['Sales_channels_9'])?1:0;
			$_POST['Sales_account_id_9'] = ($_POST['Sales_account_id_9'])?1:0;
			$_POST['stockout_sn_9'] = ($_POST['stockout_sn_9'])?1:0;
            $_POST['ShippingService_9'] = ($_POST['ShippingService_9'])?1:0;
			$_POST['print_status_10'] = ($_POST['print_status_10'])?1:0;
			$_POST['order_status_10'] = ($_POST['order_status_10'])?1:0;
			$_POST['paid_time_10'] = ($_POST['paid_time_10'])?1:0;
			$_POST['sellsrecord_10'] = ($_POST['sellsrecord_10'])?1:0;
			$_POST['order_sn_10'] = ($_POST['order_sn_10'])?1:0;
			$_POST['paypalid_10'] = ($_POST['paypalid_10'])?1:0;
			$_POST['currency_10'] = ($_POST['currency_10'])?1:0;
			$_POST['order_amount_10'] = ($_POST['order_amount_10'])?1:0;
			$_POST['goods_10'] = ($_POST['goods_10'])?1:0;
			$_POST['shipping_id_10'] = ($_POST['shipping_id_10'])?1:0;
			$_POST['track_no_10'] = ($_POST['track_no_10'])?1:0;
			$_POST['eubpdf_10'] = ($_POST['eubpdf_10'])?1:0;
			$_POST['userid_10'] = ($_POST['userid_10'])?1:0;
			$_POST['country_10'] = ($_POST['country_10'])?1:0;
			$_POST['Sales_channels_10'] = ($_POST['Sales_channels_10'])?1:0;
			$_POST['Sales_account_id_10'] = ($_POST['Sales_account_id_10'])?1:0;
			$_POST['stockout_sn_10'] = ($_POST['stockout_sn_10'])?1:0;
            $_POST['ShippingService_10'] = ($_POST['ShippingService_10'])?1:0;
			$_POST['print_status_11'] = ($_POST['print_status_11'])?1:0;
			$_POST['order_status_11'] = ($_POST['order_status_11'])?1:0;
			$_POST['paid_time_11'] = ($_POST['paid_time_11'])?1:0;
			$_POST['sellsrecord_11'] = ($_POST['sellsrecord_11'])?1:0;
			$_POST['order_sn_11'] = ($_POST['order_sn_11'])?1:0;
			$_POST['paypalid_11'] = ($_POST['paypalid_11'])?1:0;
			$_POST['currency_11'] = ($_POST['currency_11'])?1:0;
			$_POST['order_amount_11'] = ($_POST['order_amount_11'])?1:0;
			$_POST['goods_11'] = ($_POST['goods_11'])?1:0;
			$_POST['shipping_id_11'] = ($_POST['shipping_id_11'])?1:0;
			$_POST['track_no_11'] = ($_POST['track_no_11'])?1:0;
			$_POST['eubpdf_11'] = ($_POST['eubpdf_11'])?1:0;
			$_POST['userid_11'] = ($_POST['userid_11'])?1:0;
			$_POST['country_11'] = ($_POST['country_11'])?1:0;
			$_POST['Sales_channels_11'] = ($_POST['Sales_channels_11'])?1:0;
			$_POST['Sales_account_id_11'] = ($_POST['Sales_account_id_11'])?1:0;
			$_POST['stockout_sn_11'] = ($_POST['stockout_sn_11'])?1:0;
            $_POST['ShippingService_11'] = ($_POST['ShippingService_11'])?1:0;
			$_POST['print_status_12'] = ($_POST['print_status_12'])?1:0;
			$_POST['order_status_12'] = ($_POST['order_status_12'])?1:0;
			$_POST['paid_time_12'] = ($_POST['paid_time_12'])?1:0;
			$_POST['sellsrecord_12'] = ($_POST['sellsrecord_12'])?1:0;
			$_POST['order_sn_12'] = ($_POST['order_sn_12'])?1:0;
			$_POST['paypalid_12'] = ($_POST['paypalid_12'])?1:0;
			$_POST['currency_12'] = ($_POST['currency_12'])?1:0;
			$_POST['order_amount_12'] = ($_POST['order_amount_12'])?1:0;
			$_POST['goods_12'] = ($_POST['goods_12'])?1:0;
			$_POST['shipping_id_12'] = ($_POST['shipping_id_12'])?1:0;
			$_POST['track_no_12'] = ($_POST['track_no_12'])?1:0;
			$_POST['eubpdf_12'] = ($_POST['eubpdf_12'])?1:0;
			$_POST['userid_12'] = ($_POST['userid_12'])?1:0;
			$_POST['country_12'] = ($_POST['country_12'])?1:0;
			$_POST['Sales_channels_12'] = ($_POST['Sales_channels_12'])?1:0;
			$_POST['Sales_account_id_12'] = ($_POST['Sales_account_id_12'])?1:0;
			$_POST['stockout_sn_12'] = ($_POST['stockout_sn_12'])?1:0;
            $_POST['ShippingService_12'] = ($_POST['ShippingService_12'])?1:0;
			$_POST['print_status_13'] = ($_POST['print_status_13'])?1:0;
			$_POST['order_status_13'] = ($_POST['order_status_13'])?1:0;
			$_POST['paid_time_13'] = ($_POST['paid_time_13'])?1:0;
			$_POST['sellsrecord_13'] = ($_POST['sellsrecord_13'])?1:0;
			$_POST['order_sn_13'] = ($_POST['order_sn_13'])?1:0;
			$_POST['paypalid_13'] = ($_POST['paypalid_13'])?1:0;
			$_POST['currency_13'] = ($_POST['currency_13'])?1:0;
			$_POST['order_amount_13'] = ($_POST['order_amount_13'])?1:0;
			$_POST['goods_13'] = ($_POST['goods_13'])?1:0;
			$_POST['shipping_id_13'] = ($_POST['shipping_id_13'])?1:0;
			$_POST['track_no_13'] = ($_POST['track_no_13'])?1:0;
			$_POST['eubpdf_13'] = ($_POST['eubpdf_13'])?1:0;
			$_POST['userid_13'] = ($_POST['userid_13'])?1:0;
			$_POST['country_13'] = ($_POST['country_13'])?1:0;
			$_POST['Sales_channels_13'] = ($_POST['Sales_channels_13'])?1:0;
			$_POST['Sales_account_id_13'] = ($_POST['Sales_account_id_13'])?1:0;
			$_POST['stockout_sn_13'] = ($_POST['stockout_sn_13'])?1:0;
            $_POST['ShippingService_13'] = ($_POST['ShippingService_13'])?1:0;
			$_POST['print_status_0'] = ($_POST['print_status_0'])?1:0;
			$_POST['order_status_0'] = ($_POST['order_status_0'])?1:0;
			$_POST['paid_time_0'] = ($_POST['paid_time_0'])?1:0;
			$_POST['sellsrecord_0'] = ($_POST['sellsrecord_0'])?1:0;
			$_POST['order_sn_0'] = ($_POST['order_sn_0'])?1:0;
			$_POST['paypalid_0'] = ($_POST['paypalid_0'])?1:0;
			$_POST['currency_0'] = ($_POST['currency_0'])?1:0;
			$_POST['order_amount_0'] = ($_POST['order_amount_0'])?1:0;
			$_POST['goods_0'] = ($_POST['goods_0'])?1:0;
			$_POST['stock_place_0'] = ($_POST['stock_place_0'])?1:0;
			$_POST['shipping_id_0'] = ($_POST['shipping_id_0'])?1:0;
			$_POST['track_no_0'] = ($_POST['track_no_0'])?1:0;
			$_POST['eubpdf_0'] = ($_POST['eubpdf_0'])?1:0;
			$_POST['userid_0'] = ($_POST['userid_0'])?1:0;
			$_POST['country_0'] = ($_POST['country_0'])?1:0;
			$_POST['Sales_channels_0'] = ($_POST['Sales_channels_0'])?1:0;
			$_POST['Sales_account_id_0'] = ($_POST['Sales_account_id_0'])?1:0;
			$_POST['stockout_sn_0'] = ($_POST['stockout_sn_0'])?1:0;
            $_POST['ShippingService_0'] = ($_POST['ShippingService_0'])?1:0;
			$system = new ModelSystem();
			$system->savecolumn($_POST);
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	
	/****************
	** 系统初始
	***
	****************/
	function actionInit()
	{
		parent::actionPrivilege('sys_init');
		$this->name = 'init';
		$rs = ModelSystem::getorderlumn();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		$info = $json->encode($rs);
		$this->tpl->assign('info',$info);
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$arr = ModelDd::getArray('orderstatus');
		array_pop($arr);
		$this->tpl->assign('orderstatus',ModelDd::arrayFormat($arr));
		$account = ModelDd::getArray('allaccount');
		if($_SESSION['account_list'] != 'all') {
			$ex_list = explode(",",$_SESSION['account_list']);
			for($i=0;$i<count($ex_list);$i++){
				if(!array_key_exists($ex_list[$i],$account)) unset($account[$ex_list[$i]]);
				}
		}
		
		$this->tpl->assign('aliaccount',ModelDd::getComboData('aliaccount'));
		$this->tpl->assign('allaccount',ModelDd::arrayFormat($account));
		$this->tpl->assign('goods_status',ModelDd::getComboData('goods_status'));
		$this->tpl->assign('goods_cat',ModelDd::getComboData('goods_cat'));
		$this->tpl->assign('goods_brand',ModelDd::getComboData('goods_brand'));
		$this->show();
	}
	
	function actioninithandle()
	{
		parent::actionCheck('sys_init');
		$object = new ModelSystem();
		try{
			switch($_GET['type']){
			case 'delorders':
			$object->delorders();
			break;
			case 'delpaypals':
			$object->delpaypals();
			break;
			case 'clearlock':
			$object->clearlock($_GET['depot']);
			break;
			case 'delorderlog':
			$object->delorderlog($_GET['logtime']);
			break;
			case 'delorder':
			$order = new ModelOrder();
			$where = $order->getWhere($_GET);
			$object->delorder($where);
			break;
			case 'unlock':
			$object->unlock($_GET['depot']);
			break;
			case 'clearcat':
			$object->clearcat();
			break;
			case 'clearbrand':
			$object->clearbrand();
			break;
			case 'delgoodslog':
			$object->delgoodslog($_GET['logtime']);
			break;
			case 'delgoods':
			$goods = new ModelGoods();
			$where = $goods->getWhere($_GET);
			$object->delgoods($where);
			break;
			case 'matchimg':
			$object->matchimg($_GET);
			break;
            case 'delaligoods':
            $object->delaligoods($_GET['account']);
            break;
			default:
			echo "{success:false,msg:'错误的操作'}";exit;
			}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
					echo "{success:false,msg:'$errorMsg'}";exit;
			}
		echo "{success:true,msg:'OK'}";exit;
	}
	
	
	function actionTest()
	{
		$object = new ModelSystem();
		echo $object->SendMail('vekincheng@163.com','Email_system','testing');
	}
	/**************
	**打印历史记录
	**************/
	function actionprintlog()
	{
		$this->name = 'printlog';
		$this->show();
	}
	
	function actionPrintloglist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSystem();
		$where ='';
		$list = $object->getprintlogList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getprintlogCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	
	function actionsoftinfo()
	{
		$num =5;
		$str = '无法获取软件更新信息';
		$i=0;
		while(!$request && $i<3){
			//$request = @file_get_contents('http://www.softsilkroad.com/blog/wordpress.php?num='.$num);
			$ch = curl_init('http://www.softsilkroad.com/blog/wordpress.php?num='.$num);
			curl_setopt($ch, CURLOPT_TIMEOUT, 1);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			$request = curl_exec($ch);
			curl_close ($ch);
			if($request){
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				$info = $json->decode($request);
				$info = $info->topics;
				$str = "<ul>";
				for($i=0;$i<$num;$i++){
					$str = $str."<li>[".substr($info[$i]->post_date,0,10)."]<a href='".$info[$i]->guid."' target=_blank title='".$info[$i]->post_title."'>".$info[$i]->post_title."</a></li>";
				}
				$str .="<li><a href='http://www.softsilkroad.com/blog/?cat=6' target=_blank>更多...</a></li>";
				$str .= "</ul>";
				echo $str;exit();
			}
			$i++;
		} 
		echo $str;
	}
	/**************
	******快递查询
	**************/
	function actionTrack()
	{
		$this->name = 'expressquery';
		$this->show();
	}
	function actionTrackquery()
	{
		if(empty($_POST['keyword'])){
			echo '{success:true,msg:\'快递号为空\'}';exit;
		}
		$key= $_POST['keyword'];
			$list = array();
		if($_POST['type'] != '0'){
			$list[] = $_POST['type'];
		}else{
			$rules = ModelDd::getArray('tracking_rule');
			foreach($rules as $k=>$v){
					if(preg_match('/'.$v.'/', $key)) $list[] = $k;
				}
			if(empty($list)){
			echo "{success:true,msg:'暂时不支持此单号类型'}"; 
			exit;
			}
		}
		foreach($list as $way){
			switch ($way) {
				case 'DHL':
					$msg .= 'DHL:<hr>';
					$tempStr=$this->getUrlPage('http://www.dhl.com/content/g0/en/express/tracking.shtml?brand=DHL&AWB='.urlencode($key));
					preg_match('/<table border="0" summary="Summary of table content">.*?<\/table>|No result found for your  DHL query. Please try again\./is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case 'UPS':
					$msg .= 'UPS:<hr>';
					$msg .= $this->ups($key);
					break;
				case 'USPS':
					$msg .= 'USPS:<hr>';
					$tempStr=$this->getUrlPage('https://tools.usps.com/go/TrackConfirmAction.action','tLabels='.urlencode($key));
					preg_match('/<table id="tc-hits" summary="Table describes the label details returned from track query.">.*?<\/table>|<p id="error-track" class="error invalid bold hide">.*?<\/p>/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case 'FEDEX':
					$msg .= 'FEDEX:<hr>';
					$tempStr=$this->getUrlPage('http://www.fedex.com/Tracking','tracknumbers='.urlencode($key));
					preg_match('/<div id="appcontent" class="detailcolumn">.*?<form id="footer-search" method="post" action="\/cgi-bin\/search_redirect\/">.*?<\/div>(?=.*?<div id="fx-global-footer" class="fx_clearfix">)/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case 'Yanwen':
					$msg .= 'Yanwen:<hr>';
					$tempStr=iconv('GB2312','UTF-8',$this->getUrlPage('http://www.yw56.com.cn/DIY.asp','orderid='.urlencode(trim($key))));
					file_put_contents('./test.txt',$tempStr);
					preg_match('/<table border="1" cellpadding="0" cellspacing="0">
            <tr>
              <td width="122" align="center" bgcolor="#f3f3f3" height="22"><strong>处理时间<\/strong><\/td>
              <td width="175" align="center" bgcolor="#f3f3f3" height="22"><strong>处理地点<\/strong><\/td>
              <td width="179" align="center" bgcolor="#f3f3f3" height="22"><strong>邮件状态<\/strong><\/td>.*?<\/table>/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case 'TNT':
					$msg .= 'TNT:<hr>';
					$cons=trim($key);
					$cons=substr($cons,2,strlen($cons)-4);
					$tempStr=$this->getUrlPage('http://lit2.tnt.com.cn/tracker/tracking.do','respLang=en&searchType=CON&cons='.urlencode($cons));
					preg_match('/<div id="content" style="width:710px;">.*?<hr class="hide" \/>
																<\/div>/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case '4PX':
					$msg .= '4PX:<hr>';
					$tempStr=iconv('GB2312','UTF-8',$this->getUrlPage('http://www.4px.com/trackIndex.html','hawb='.urlencode(trim($key))));
					preg_match('/<div class="chaxun3">.*?<\/table>
						  <\/div>/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
				case 'HKMail':
					$msg .= 'HKMail:<hr>';
					$tempStr=$this->getUrlPage('http://app3.hongkongpost.com/CGI/mt/genresult.jsp','tracknbr='.urlencode($key));
					preg_match('/<p><span class="textNormalBlack">Destination<\/span>.*?<br \/><br \/>|To promptly retrieve the record of your item, please key in your Enquiry Reference Number \(if available\), for example, 05000123A:/is',$tempStr,$matches);
					$msg .= addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
					break;
			}
		}
		if(empty($msg)) $msg='No matching results';
		echo "{success:true,msg:'{$msg}'}";
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
		curl_setopt($ch, CURLOPT_URL,$url);
		curl_setopt($ch,CURLOPT_USERAGENT,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3');
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
	function ups($trackingNO){
		$url='http://wwwapps.ups.com/WebTracking/track?HTMLVersion=5.0&loc=en_US&Requester=UPSHome&WBPM_lid=&trackNums='.$trackingNO.'&track.x=Track';
		$html = $this->getUrlPage($url);
		preg_match('/<form name="detailForm" id="detailFormid" action="http\:\/\/wwwapps\.ups\.com\/WebTracking\/detail" method="post">.*?<\/form>/is',$html,$matches);
		if(empty($matches))
		return 'UPS could not locate the shipment details for your request. Please verify your information and try again later.';
		preg_match_all('/<input type="hidden" name="(\w+?)" value="(\w*?)".*?>/is',$matches[0],$matches2);
		preg_match('/<INPUT name="HIDDEN_FIELD_SESSION" type="HIDDEN" value="(.*?)">/is',$matches[0],$matches3);
		$param_str = 'HIDDEN_FIELD_SESSION='.urlencode($matches3[1]);
		foreach($matches2[1]as $key=>$val){
			if($val=='showSpPkgProg1')
				$matches2[2][$key]='true';
			if(!isset($param_str)&&empty($param_str)){
				$param_str = $val.'='.urlencode($matches2[2][$key]);
			}
			else{
				$param_str .='&'.$val.'='.urlencode($matches2[2][$key]);
			}
		}
		$url='http://wwwapps.ups.com/WebTracking/detail';
		$html2 = $this->getUrlPage($url,$param_str);
		preg_match('/<table border="0" cellpadding="0" cellspacing="0" class="dataTable">.*?<\/table>/is',$html2,$matches);
		return addslashes(str_replace(array("\n","\r","\r\n"),'',$matches[0]));
	}
	function actionClient(){
		$this->name = 'client';
		$this->show();
	}
	function actionClientlist()
	{
		$pageLimit = getPageLimit();
		$object = new ModelSystem();
		$where ='';
		$list = $object->getClientList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getClientCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	function actioncreateclient(){
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
		$object = new ModelSystem();
		try {
			$object->saveclient($_GET);
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		if($errorMsg <>'') echo "<br>添加过程中发生以下错误:'" . $errorMsg . "'";
	}
	function actiondeleteclient(){
		$object = new ModelSystem();
		try {
				$object->deleteclient($_REQUEST['ids']);
				echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 系统更新内容
	 */
	function actionsystemupdate(){
		$object = new ModelNews();
		$where ='';
		$list = $object->getList(1,1000);
		$result['news'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
		/*echo '{"news":[
		{"content":"优化群发邮件，同步Amazon产品图片。","add_time":1383596361,"url":"http://www.cpowersoft.com/blog/?p=621"},
		{"content":"10/16相关更新。","add_time":1381898898,"url":"http://www.cpowersoft.com/blog/?p=563"},
		{"content":"09/21速卖通相关更新内容。","add_time":1379697828,"url":"http://www.cpowersoft.com/blog/?p=468"},
		{"content":"增加加拿大和澳大利亚线下E邮宝接口。","add_time":1378955965,"url":"http://www.cpowersoft.com/blog/?p=458"},
		{"content":"优化速卖通同步产品，增加速卖通订单声明发货。","add_time":1378407250,"url":"http://www.cpowersoft.com/blog/?p=446"},
		{"content":"优化速卖通订单。","add_time":1378047394,"url":"http://www.cpowersoft.com/blog/?p=443"},
		{"content":"修复订单里面打印模板重复选中无响应的BUG,首页添加快捷菜单。","add_time":1377516749,"url":"http://www.cpowersoft.com/blog/?p=435"},
		{"content":"订单明细新增自动识别渠道。","add_time":1377052815,"url":"http://www.cpowersoft.com/blog/?p=430"},
		{"content":"速卖通同步订单自动同步产品创建产品库。","add_time":1377046815,"url":"http://www.cpowersoft.com/blog/?p=418"},
		{"content":"修复导出缺货订单bug,导出搜索订单增加产品所有价格。","add_time":1376875731,"url":"http://www.cpowersoft.com/blog/?p=410"},
		{"content":"同步速卖通产品,同步订单可选择自动同步订单里的产品进产品库，增加速卖通订单状态字段。修复导入bug。","add_time":1376595703,"url":"http://www.cpowersoft.com/blog/?p=393"},
		{"content":"登陆系统不区分大小写。","add_time":1376358614,"url":"#"},
		{"content":"同步速卖通订单可选择订单状态,修复多次同步出现重复订单的Bug,订单同步提醒。。","add_time":1376320942,"url":"http://www.cpowersoft.com/blog/?p=369"},
		{"content":"系统即日起分为六个版本。","add_time":1376105615,"url":"http://www.cpowersoft.com/blog/?p=347"},
		{"content":"新增状态已发货订单、查询订单物流追踪、修复新增产品BUG","add_time":1376105615,"url":"http://www.cpowersoft.com/blog/?p=329"},
		{"content":"新增打印记录","add_time":1376018731,"url":"http://www.cpowersoft.com/blog/?p=326"},
		{"content":"增加互联易(香港小包挂号、香港小包平邮)订单发货","add_time":1375708514,"url":"http://www.cpowersoft.com/blog\/?p=272"},
		{"content":"支持线下E邮宝A4与10*10标签切换","add_time":1375707914,"url":"http://www.cpowersoft.com/blog/?p=323"},
		{"content":"支持添加速卖通帐号，速卖通订单抓取api接口,上传产品api接口","add_time":1375605011,"url":"http://www.cpowersoft.com/blog\/?p=272"}
		]}';*/
	}
	//,{"content":"支持线下E邮宝A4与10*10标签切换","add_time":1375707914,"url":"http://www.cpowersoft.com/blog/?p=323"}
	/**
	 * 导入条码页面
	 */
	function actionImportSn()
	{
		$this->name = 'snimport';
		$this->show();
	}
	/**
	 * 导入条码
	 */
	function actionsnimporthandle(){
		include_once(CFG_PATH_LIB.'PHPExcel/Reader/Excel5.php');
		$objReader = new PHPExcel_Reader_Excel5();
		$objReader->setReadDataOnly(true);
		$objPHPExcel = $objReader->load($_FILES['file_path']['tmp_name']);
		$currentSheet =$objPHPExcel->getSheet(0);
		$allColumn = $currentSheet->getHighestColumn();
		$allColumnIndex = PHPExcel_Cell::columnIndexFromString($allColumn);
		$allRow = $currentSheet->getHighestRow();
		$object = new ModelSystem();
		for($currentRow = 1;$currentRow<=$allRow;$currentRow++){
			$info = array('sn' => trim($currentSheet->getCell('A'.$currentRow)->getValue()),'type'=>$_POST['channels']);
			$object->insertsn($info);
		}
		echo "{success:true,msg:'OK'}";exit;
	}
	function actionChannels($id){
		$return = '';
		switch($id){
			case '1' :
			$return = 'QT';
			break;
			case '2' :
			$return = 'QT';
			break;
		}
		return $return;
	}
	function actionregister(){
		echo 'ok';
	}
	function actionemailconfig(){
		$config = @include(CFG_PATH_DATA.'dd/email_setting_'.$_SESSION['admin_id'].'.php');
		$this->name = 'emailconfig';
		$this->tpl->assign('info',$config);
		$this->show();
	}
	function actionsaveeamil(){
		$info = array (
		  'host' => $_POST['host'],
		  'port' => $_POST['port'],
		  'user' => $_POST['user'],
		  'pass' => $_POST['pass'],
		  'from' => $_POST['from'],
		  'reply' => $_POST['reply'],
		);
		$fp = fopen(CFG_PATH_DATA.'dd/email_setting_'.$_SESSION['admin_id'].'.php','w');
		fputs($fp,'<?php return '.var_export($info,true).';?>');
		fclose($fp);
		echo "{success:true,msg:'OK'}";exit;
	}
	/***
	 * 客户服务
	 *
	 */
	function actionClientService(){
		$this->name = 'clientservice';
		$this->show();
	}
	/***
	 * 个人信息
	 *
	 */
	function actionclientinfo(){
		$this->tpl->assign('user',ModelUser::getCacheInfo($_SESSION['admin_id']));
		$this->name = 'clientinfo';
		$this->show();
	}
	function actiontestflush(){
		$object = new ModelSystem();
		$list = $object->showtrack($_GET['status']);
		for ($i = 1; $i <= 50; $i++) {
			ob_flush();
			flush();
			echo $i.'<br/>';
			sleep(rand(0, 1));
		}
		$this->name = 'loading';
		$this->show();
	}
}
?>