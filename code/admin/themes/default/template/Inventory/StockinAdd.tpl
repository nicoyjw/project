<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><!--{$cfg.page.title}--></title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/ext-all.css"/>
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/xtheme-gray.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javascript" src="common/lib/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="common/lib/ext/ext-all.js"></script>
<!--<script type="text/javascript" src="common/lib/ext/ext-all-debug.js"></script>-->
<script type="text/javascript" src="common/js/common1.js"></script>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '<!--{$smarty.const.CFG_PATH_IMAGES}-->s.gif';
</script>
</head>
<body>
<script type="text/javascript" src="js/billform-ext.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var orderinfo = eval(<!--{$order}-->);
var order_status = [<!--{$order_status}-->];
var Sales_channels = [<!--{$Sales_channels}-->];
var stocktype = [<!--{$stockin_type}-->];
var depot = [<!--{$depot}-->];
var pid = [<!--{$pid}-->];
	var user_action = object_Array([<!--{$user_action}-->]);
	Ext.QuickTips.init();
	var StockinForm = new Ext.ux.BillForm({
		title:'<center><b>'+((orderinfo.order_id)?'编辑入库单':'新增入库单')+':'+orderinfo.order_sn+'</b></center>',
		border:true,
		labelAlign: 'right',
        labelWidth: 75,
		saveURL:'index.php?model=stockin&action=save',
		addURL:'index.php?model=stockin&action=add',
		goodsURL:'index.php?model=Stockin&action=getgoods&<!--{$from}-->',
		delURL:'index.php?model=Stockin&action=delgoods',
		listSupplierURL:'index.php?model=supplier&action=userlist',
		listUserURL:'index.php?model=User&action=UserList',
		goodsgirdURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree',
		orderstatus:order_status,
		stocktype:stocktype,
		depot:depot,
		action:user_action,
		inout:1,
		pid:pid,
		Sales_channels:Sales_channels,
        autoWidth: true,
		autoHeight:true,
		order:orderinfo,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
