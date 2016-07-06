<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/profit.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = [<!--{$allaccount}-->];
	account.push(['0','所有账户']);
    var OrdergoodsGrid = new Ext.ux.OrdergoodsGrid({
		id:'OrdergoodsGrid',
		headers:['订单号','国家','发货方式','收取运费','产品总数量','产品总价','订单总价','重量','手续费'],
        fields: ['order_sn','country', 'shipping_id','shipping_cost','goods_qty','goods_total','order_amount','weight','order_factorage'],
		autoWidth:true,
		loadMask:true,
		accountdata:account,
		frame:true,
		listURL:'index.php?model=statistics&action=profitlist',
		pagesize:20,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->