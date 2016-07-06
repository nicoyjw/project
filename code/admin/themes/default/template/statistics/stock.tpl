<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/stockgrid.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
var Sales_channels = [<!--{$Sales_channels}-->];
Sales_channels.push(['0','所有渠道']);
	var depot = [<!--{$depot}-->];
	depot.push(['','所有仓库']);
    var stockGrid = new Ext.ux.StcokGrid({
		id:'CategoryGrid',
        title: '出入库统计列表',
		headers:['产品编码','产品名称','数量'],
        fields: ['goods_sn','goods_name', 'num'],
		Sales_channels:Sales_channels,
		depot:depot,
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=stocklist',
		listSupplierURL:'index.php?model=supplier&action=userlist',
		pagesize:20,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->