<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/currentstock.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var depot = [<!--{$depot}-->];
	depot.push(['-1','所有仓库']);
	var currentstockGrid = new Ext.ux.currentstockGrid({
		id:'currentstockGrid',
        title: '库存情况统计',
		headers:['仓库','SKU总数','有库存SKU总数','持续采购SKU总数','库存总成本','已锁定库存总成本'],
        fields: ['depot','total','hasstock','instatus','totalcost','varcost'],
		depot:depot,
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=currentstocklist',
        renderTo: document.body
    });
	currentstockGrid.getStore().load();
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->