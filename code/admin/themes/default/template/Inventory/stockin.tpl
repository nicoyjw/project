<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/billview.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var user_action = object_Array([<!--{$user_action}-->]);
    var BillView = Ext.create('Ext.ux.test.billview', {
		headers: ['序号', '入库单号', '仓库', '总量', '总价', '入库类型', '入库员', '状态', '入库时间', 'comment'],
		fields: ['order_id', 'order_sn', 'depot_id', 'totalqty', 'totalprice', 'stocktype', 'operator', 'status', 'out_time', 'realstatus', 'comment'],
		pagesize: 15,
		frame: true,
		gridTitle: '入库单列表',
		autoWidth: true,
		action: user_action,
		addURL: 'index.php?model=Stockin&action=add',
		goodsURL: 'index.php?model=Stockin&action=getgoods',
		listURL: 'index.php?model=Stockin&action=list',
		updateURL: 'index.php?model=Stockin&action=update',
		printURL: 'index.php?model=Stockin&action=print',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
