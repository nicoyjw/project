<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/inventory/startcheck.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var order_id = <!--{$order_id}-->;
	var StartCheckGrid = Ext.create('Ext.ux.test.inventory.startcheck', {
		title: '盘点单列表',
		headers: ['rec_id', '产品编码', '产品名称', 'SKU', '账面库存', '盘点库存', '是否盘点'],
		fields: ['rec_id', 'goods_sn', 'goods_name', 'SKU', 'stock_qty', 'check_qty', 'is_ok'],
		pagesize: 20,
		frame: true,
		windowWidth: 350,
		windowHeight: 280,
		listURL: 'index.php?model=Inventory&action=checklistdetail&order_id=' + order_id,
		saveURL: 'index.php?model=inventory&action=savecheck&order_id=' + order_id,
		updatesurl: 'index.php?model=inventory&action=updatecheck&order_id=' + order_id,
		exporturl: 'index.php?model=inventory&action=exportcheck&order_id=' + order_id,
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
