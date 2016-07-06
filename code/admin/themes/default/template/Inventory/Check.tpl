<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/inventory/check.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var depot = [<!--{$depot}-->];
    var CheckGrid = Ext.create('Ext.ux.test.inventory.check', {
		fields: ['order_id', 'order_sn', 'admin_id', 'depot_id', 'status', 'add_time', 'end_time', 'is_in', 'is_out', 'has_un'],
		headers: ['order_id', '盘点单号', '操作员', '仓库', '状态', '盘点时间', '完成时间', '已盘盈', '已盘亏'],
		pagesize: 20,
		frame: true,
		depot: depot,
		autoWidth: true,
		autoHeight: true,
		windowTitle: '盘点初始化',
		windowWidth: 350,
		windowHeight: 150,
		listURL: 'index.php?model=Inventory&action=checklist',
		saveURL: 'index.php?model=inventory&action=addcheckorder',
		comURL: 'index.php?model=inventory&action=completecheck',
		finishURL: 'index.php?model=inventory&action=finishcheck',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
