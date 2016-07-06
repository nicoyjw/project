<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/countrystat.js"></script>
<script type="text/javascript">

Ext.onReady(function(){
	Ext.QuickTips.init();
	var sales_account =[['0','所有账户']];
    sales_account.push(<!--{$Sales_account}-->);
	Ext.form.Field.prototype.msgTarget = 'side';	
	var countrystatGrid = new Ext.ux.countrystatGrid({
		title: '按销售国家统计销售额',
		headers:['国家','金额'],
		fields: ['country','money'],
		frame:true,
		pagesize:15,
		autoWidth:true,
		sales_account:sales_account,
		listURL:'index.php?model=statistics&action=GetCountryStat',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->