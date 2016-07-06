<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/ext-4/ux/RowEditor.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext-4/ux/css/RowEditor.css" />
<script type="text/javascript" src="js/inventory/stockchange.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var StockView = Ext.create('Ext.ux.test.inventory.stockchange', {
		autoWidth: true,
		autoHeight: true,
		goodsURL: 'index.php?model=Stockin&action=getgoods',
		saveURL: 'index.php?model=inventory&action=savestockchange',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
