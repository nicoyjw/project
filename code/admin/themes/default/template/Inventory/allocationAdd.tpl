<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/inventory/allocationadd.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var orderinfo = eval(<!--{$order}-->);
var order_status = [<!--{$order_status}-->];
var depot = [<!--{$depot}-->];      
var first_shipping = [<!--{$first_shipping}-->];
var db_shipping = [<!--{$db_shipping}-->];
	Ext.QuickTips.init();
	var stockoutForm = Ext.create('Ext.ux.test.inventory.allocationadd', {
		title: '<center><b>' + ((orderinfo.order_id) ? '编辑调拨单' : '新增调拨单') + ':' + orderinfo.order_sn + '</b></center>',
		border: true,
		labelAlign: 'right',
		labelWidth: 60,
		saveURL: 'index.php?model=inventory&action=saveallocation',
		addURL: 'index.php?model=inventory&action=Addallocation',
		goodsURL: 'index.php?model=inventory&action=getallocationgoods',
		delURL: 'index.php?model=inventory&action=delallocationgoods',
		listUserURL: 'index.php?model=User&action=UserList',
		goodsgirdURL: 'index.php?model=goods&action=getgoodslist',
		catTreeURL: 'index.php?model=goods&action=getcattree',
		order: orderinfo,
		orderstatus: order_status,
		depot: depot,
		db_shipping: db_shipping,
		first_shipping: first_shipping,
		autoWidth: true,
		autoHeight: true,
		order: orderinfo,
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
