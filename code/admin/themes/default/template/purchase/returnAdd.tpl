<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/purchase/returnform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var orderinfo = eval(<!--{$order}-->);
var order_status = [<!--{$order_status}-->];
	Ext.QuickTips.init();
	var PurchasereturnForm = new Ext.ux.BillForm({
		title:'<center><b>'+((orderinfo.order_id)?'编辑退货单':'新增退货单')+':'+orderinfo.order_sn+'</b></center>',
		border:true,
		labelAlign: 'right',
        labelWidth: 75,
		saveURL:'index.php?model=Purchasereturn&action=save',
		addURL:'index.php?model=Purchasereturn&action=add',
		goodsURL:'index.php?model=Purchasereturn&action=getgoods&<!--{$from}-->',
		delURL:'index.php?model=Purchasereturn&action=delgoods',
		listSupplierURL:'index.php?model=supplier&action=userlist',
		listUserURL:'index.php?model=User&action=UserList',
		order:orderinfo,
		orderstatus:order_status,
        autoWidth: true,
		autoHeight:true,
		order:orderinfo,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
