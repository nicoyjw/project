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
<script type="text/javascript" src="js/purchase/Purchaseorder-ext.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var status = [<!--{$status}-->];
	status.push(['99','所有状态']);
    var PorderView = new Ext.ux.PorderView({
		id:'stockgrid',
        title: '采购订单',
		headers:['序号','采购单号','总数量','总金额','供应商','产品','运费','预计到货','到货时间','采购员','状态','添加人'],
            fields: ['order_id','order_sn', 'totalqty','totalamt','supplier','goods','shipping_fee','pre_time','arrive_time','operator','status','add_user','realstatus','comment','overtime'],
		pagesize:15,
		status:status,
		windowWidth:320,
		windowHeight:240,
		goodswinWidth:900,
		goodswinHeight:450,
		frame:true,
		autoWidth:true,
		goodsURL:'index.php?model=Purchaseorder&action=getgoods',
		listURL:'index.php?model=Purchaseorder&action=list',
		updateURL:'index.php?model=Purchaseorder&action=update',
		listUserURL:'index.php?model=User&action=UserList',
		listSupplierURL:'index.php?model=supplier&action=userlist',
		printURL:'index.php?model=Purchaseorder&action=print',
        addstockURL:'index.php?model=Stockin&action=add&type=cgrk',
		ScanstockURL:'index.php?model=Stockin&action=addScan&type=cgrk',
		returnURL:'index.php?model=Purchasereturn&action=add&type=cgth',
        renderTo: document.body
    });
	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
