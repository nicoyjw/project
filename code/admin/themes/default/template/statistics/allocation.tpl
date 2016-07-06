<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/allocation.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var first_shipping = [<!--{$first_shipping}-->];
	var db_shipping = [<!--{$db_shipping}-->];
	var depot_id_from = [<!--{$depot}-->];
	var depot_id_to = [<!--{$depot}-->];
	first_shipping.push(['-1','所有渠道']);
	db_shipping.push(['-1','所有物流']);
	depot_id_from.push(['-1','所有发货仓']);
	depot_id_to.push(['-1','所有到货仓']);
	Ext.form.Field.prototype.msgTarget = 'side';

    var pickGrid = new Ext.ux.allocationGrid({
		id:'pickGrid',
        title: '调拨统计列表',
		headers:['总数量','总重量','总箱数','总单量'],
        fields: ['total_qty','total_weight','total_count','counts'],
		first_shippingdata:first_shipping,
		db_shippingdata:db_shipping,
		depot_id_fromdata:depot_id_from,
		depot_id_todata:depot_id_to,
		width:1000,
		frame:true,
		listURL:'index.php?model=statistics&action=allocationlist',
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->