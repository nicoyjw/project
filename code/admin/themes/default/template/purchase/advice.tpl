<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/purchase/advice.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var depot = [<!--{$depot}-->];
	depot.push(['999','所有仓库']);
    var PlanView = new Ext.ux.PlanGrid({
		headers:['goods_id','产品编码','产品名称','SKU','库存数量','锁定库存','预警天数','日均销量','销售预期','调拨在途(数量/头程/在途天数)','补货天数','主仓库存','供应商'],
        fields: ['goods_id','goods_sn', 'goods_name','SKU','goods_qty','varstock','plan_day','per_sold','expected','db','period','stock_qty','supplier'],
		pagesize:15,
		depot:depot,
		frame:true,
		autoWidth:true,
		autoHeight:true,
		listURL:'index.php?model=Purchaseofs&action=list',
        renderTo: document.body
    });
	var viewport = Ext.create('Ext.Viewport',{
        layout:'fit',
        items:[
			PlanView
		]}
	);
	PlanView.getStore().load({
			params:{start:0,limit:PlanView.pagesize}
			});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
