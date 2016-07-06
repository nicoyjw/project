<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/profitinterzone.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	var profitinterzoneGrid = new Ext.ux.profitinterzoneGrid({
		title: '利润率区间',
		headers:['日期','商品编号','销售额','销量','成本价','利润'],
		fields: ['times','goods_sn','money','counts','cost','profit'],
		frame:true,
		autoWidth:true,
		sales_account:sales_account,
		pagesize:15,
		listURL:'index.php?model=statistics&action=GetProfitinterzone',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->