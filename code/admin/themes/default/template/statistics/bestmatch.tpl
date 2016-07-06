<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/bestmatch.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = [<!--{$account}-->];
	account.push(['0','所有账户']);
	Ext.form.Field.prototype.msgTarget = 'side';
    var CommissionGrid = new Ext.ux.BestmatchGrid({
		id:'CommissionGrid',
        title: 'BestMatch数据',
		headers:['itemid','sku', 'itemrank','impression','viewitemcount','salescount','watchcount','viewItemPerImpression','salesPerImpression','salesPerViewItem','currentprice','bidcount','quantityAvailable','quantitySold'],
        fields: ['itemid','SKU', 'itemrank','impression','viewitemcount','salescount','watchcount','viewItemPerImpression','salesPerImpression','salesPerViewItem','currentprice','bidcount','quantityAvailable','quantitySold'],
		autoWidth:true,
		accountdata:account,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=Bestmatchlist',
		pagesize:20,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->