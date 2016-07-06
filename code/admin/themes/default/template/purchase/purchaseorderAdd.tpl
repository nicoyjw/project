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
<script type="text/javascript" src="js/purchase/purchaseorderform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var orderinfo = eval(<!--{$order}-->);
var order_status = [<!--{$order_status}-->];
	Ext.QuickTips.init();
	var PorderForm = new Ext.ux.PorderForm({
		title:'<center><b>'+((orderinfo.order_id)?'编辑采购订单':'新增采购订单')+':'+orderinfo.order_sn+'</b></center>',
		border:true,
		labelAlign: 'right',
        labelWidth: 75,
		goodsURL:'index.php?model=Purchaseorder&action=getgoods',
		delURL:'index.php?model=Purchaseorder&action=delgoods',
		listSupplierURL:'index.php?model=supplier&action=userlist',
		listUserURL:'index.php?model=User&action=UserList',
		goodsgirdURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree',
		order:orderinfo,
		orderstatus:order_status,
        autoWidth: true,
		autoHeight:true,
		order:orderinfo,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
