<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/billform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var orderinfo = eval(<!--{$order}-->);
var order_status = [<!--{$order_status}-->];
var stocktype = [<!--{$stockout_type}-->];
var Sales_channels = [<!--{$Sales_channels}-->];
var depot = [<!--{$depot}-->];
var user_action = object_Array([<!--{$user_action}-->]);
	Ext.QuickTips.init();
	var stockoutForm = Ext.create('Ext.ux.test.billform', {
		title: '<center><b>' + ((orderinfo.order_id) ? '编辑出库单' : '新增出库单') + ':' + orderinfo.order_sn + '</b></center>',
		border: true,
		labelAlign: 'right',
		labelWidth: 75,
		action: user_action,
		saveURL: 'index.php?model=stockout&action=save',
		addURL: 'index.php?model=stockout&action=add',
		goodsURL: 'index.php?model=stockout&action=getgoods&<!--{$from}-->',
		delURL: 'index.php?model=stockout&action=delgoods',
		listSupplierURL: 'index.php?model=supplier&action=userlist',
		listUserURL: 'index.php?model=User&action=UserList',
		goodsgirdURL: 'index.php?model=goods&action=getgoodslist',
		catTreeURL: 'index.php?model=goods&action=getcattree',
		order: orderinfo,
		inout: 2,
		Sales_channels: Sales_channels,
		orderstatus: order_status,
		stocktype: stocktype,
		depot: depot,
		autoWidth: true,
		autoHeight: true,
		order: orderinfo,
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
