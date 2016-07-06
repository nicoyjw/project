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
<script type="text/javascript" src="js/purchase/planorder.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var PlanView = new Ext.ux.PlanGrid({
        title: '采购计划',
		headers:['goods_id','供应商ID','产品图片','产品编码','产品名称','SKU','供应商价格','库存数量','锁定库存','销售需求','报警库存','采购在途','日均销量','采购周期','建议采购','其他'],
        fields: ['goods_id','supplier_id','goods_img','goods_sn', 'goods_name','SKU','supplier_goods_price','goods_qty','varstock','sold_qty','warn_qty','Purchase_qty','per_sold','period','plan_qty','comment','is_no_auto'],
		pagesize:15,
		frame:true,
		autoWidth:true,
		autoHeight:true,
		listURL:'index.php?model=Purchaseorder&action=supplierPlanList',
		listSupplierURL:'index.php?model=Purchaseorder&action=planBySupplierList',
        saveURL:'index.php?model=Purchaseorder&action=updatePlanTmp',
		renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
