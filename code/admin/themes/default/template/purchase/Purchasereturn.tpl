<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/purchase/Purchasereturn.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var PorderView = new Ext.ux.PorderView({
        title: '采购退货单',
		headers:['序号','退货单号','总数量','总金额','供应商','关联采购单','采购员','状态'],
        fields: ['order_id','order_sn', 'totalqty','totalamt','supplier','relate_order_sn','operator','status','realstatus'],
		pagesize:15,
		frame:true,
		autoWidth:true,
		goodsURL:'index.php?model=Purchasereturn&action=getgoods',
		listURL:'index.php?model=Purchasereturn&action=list',
		updateURL:'index.php?model=Purchasereturn&action=update',
		printURL:'index.php?model=Purchasereturn&action=print',
        renderTo: document.body
    });
	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
