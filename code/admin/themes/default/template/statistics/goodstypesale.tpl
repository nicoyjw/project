<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/goodstypesale.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	Ext.form.Field.prototype.msgTarget = 'side';	
	var goodstypesaleGrid = new Ext.ux.goodstypesaleGrid({
		title: '商品分类销售',
		headers:['日期','销售量','销售额','成本价','利润'],
		fields: ['times','goods_sale','goods_price','costs','profit'],
		frame:true,
		autoWidth:true,
		pagesize: 15,
		sales_account:sales_account,
		listURL:'index.php?model=statistics&action=getgoodstypesale',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->