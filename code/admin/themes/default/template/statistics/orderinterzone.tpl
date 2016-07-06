<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/orderinterzone.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	var orderinterzoneGrid = new Ext.ux.orderinterzoneGrid({
		title: '订单区间查询',
		headers:['所属金额区间','订单个数'],
		fields: ['interzone','counts'],
		frame:true,
		autoWidth:true,
		sales_account:sales_account,
		listURL:'index.php?model=statistics&action=GetOrderinterzone',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->