<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/stocktransGrid.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
var Sales_channels = [<!--{$Sales_channels}-->];
var supplier = [<!--{$supplier}-->];
	var depot = [<!--{$depot}-->];
	depot.push(['','所有仓库']);
supplier.push(['0','所有供应商']);
Sales_channels.push(['0','所有渠道']);
    var StcoktransGrid = new Ext.ux.StcoktransGrid({
		id:'CategoryGrid',
        title: '出入库流水列表',
		headers:['产品编码','产品名称','SKU','数量','单号','供应商/渠道','完成时间'],
        fields: ['goods_sn','goods_name','SKU', 'goods_qty','order_sn','supplier','out_time'],
		supplier:supplier,
		Sales_channels:Sales_channels,
		depot:depot,
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=stocktranslist',
		pagesize:20,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->