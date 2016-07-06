<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/ordercircs.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	var ordercircsGrid = new Ext.ux.ordercircsGrid({
		title: '订单情况统计',
		headers:['时间','订单量','销售量'],
		fields: ['paid_times','counts','qtys','shipping_cost','order_amount'],
		frame:true,
		autoWidth:true,
		pagesize:15,
		sales_account:sales_account,
		listURL:'index.php?model=statistics&action=ordercircsList',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->