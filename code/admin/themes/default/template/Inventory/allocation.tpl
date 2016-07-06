<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/inventory/allocation.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
var first_shipping = [<!--{$first_shipping}-->];
var db_shipping = [<!--{$db_shipping}-->];
var depot = [<!--{$depot}-->];
var status = [<!--{$db_status}-->];
depot.push(['99','所有仓库']);
db_shipping.push(['99','所有物流']);
first_shipping.push(['99','所有头程']);
status.push(['99','所有状态']);
    var DBorderView = Ext.create('Ext.ux.test.inventory.allocation', {
		title: '调拨单',
		headers: ['序号', '调拨单号', '总数', '箱数', '重量', '头程渠道', '物流方式', '追踪单号', '发货仓', '到货仓', '操作员', '状态', '在途天数', '完成时间'],
		fields: ['order_id', 'order_sn', 'totalamt', 'count', 'weight', 'first_shipping', 'db_shipping', 'track_no', 'depot_id_from', 'depot_id_to', 'add_user', 'status', 'delay_time', 'out_time', 'realstatus', 'comment'],
        pagesize:25,
		status: status,
		db_shipping: db_shipping,
		first_shipping: first_shipping,
		depot: depot,
		windowWidth: 320,
		windowHeight: 350,
		autoWidth: true,
		goodsURL: 'index.php?model=inventory&action=getallocationgoods',
		listURL: 'index.php?model=inventory&action=allocationlist',
		updateURL: 'index.php?model=inventory&action=updateallocation',
		addURL: 'index.php?model=inventory&action=addallocation',
		updategoodsURL: 'index.php?model=inventory&action=updateallocationgoods',
		printURL: 'index.php?model=inventory&action=printallocation',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
