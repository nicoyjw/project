<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/rma/return.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var RmaGrid = new Ext.ux.ReturnGrid({
		title: '退换货单据_列表',
		headers:['序号','换货单据ID','RMA单据ID','原始订单号','新订单号'],
		fields: ['id','return_sn','rma_sn','order_sn','new_order_sn','remark','order_id'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=rma&action=returnlist',
		windowTitle:'编辑换货单据信息',
		windowWidth:500,
		windowHeight:320,
		renderTo: document.body
	});
	RmaGrid.getStore().load({
		params:{start:0,limit:RmaGrid.pagesize}
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->