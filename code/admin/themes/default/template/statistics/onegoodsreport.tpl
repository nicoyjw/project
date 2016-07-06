<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/onegoodsreport.js"></script>
<script type="text/javascript">

Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	var onegoodsreportGrid = new Ext.ux.onegoodsreportGrid({
		title: '单商品报表',
		headers:['日期','销售量','售价'],
		fields: ['add_time','goods_sale','goods_price'],
		frame:true,
		pagesize:15,
		sales_account:sales_account,
		autoWidth:true,
		listURL:'index.php?model=statistics&action=getonegoodsreport',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->