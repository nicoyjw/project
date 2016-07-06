<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/buytimes.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	var buytimeGrid = new Ext.ux.buytimeGrid({
		title: '客户购买排名',
		headers:['客户姓名号','购买次数'],
		fields: ['userid','order_count'],
		frame:true,
		autoWidth:true,
		pagesize:15,
		sales_account:sales_account,
		listURL:'index.php?model=statistics&action=GetBuytimes',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->