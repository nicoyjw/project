<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/billview.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var user_action = object_Array([<!--{$user_action}-->]);
    var BillView = Ext.create('Ext.ux.test.billview', {
		headers: ['序号', '出库单号', '仓库', '数量总计', '价格总计', '出库类型', '出库员', '状态', '录单时间', '出库时间', 'comment'],
		fields: ['order_id', 'order_sn', 'depot_id', 'totalqty', 'totalprice', 'stocktype', 'operator', 'status', 'add_time', 'out_time', 'realstatus', 'comment'],
		pagesize: 15,
		frame: true,
		gridTitle: '出库单单列表',
		action: user_action,
		autoWidth: true,
		addURL: 'index.php?model=Stockout&action=add',
		goodsURL: 'index.php?model=Stockout&action=getgoods',
		listURL: 'index.php?model=Stockout&action=list',
		updateURL: 'index.php?model=Stockout&action=update',
		printURL: 'index.php?model=Stockout&action=print',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
