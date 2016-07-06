<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/newgoods.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var currency = [<!--{$currency}-->];
    var OrdergoodsGrid = new Ext.ux.OrdergoodsGrid({
		id:'OrdergoodsGrid',
        title: '新品采购销售统计列表(RMB)',
		headers:['产品编码','产品名称','上货时间','采购数量','成本','运费','包装费','固定价($)','销售均价','销售数量','销售额','总均摊运费','利润率%','类别','等级','可用库存','采购在途','报警库存'],
        fields: ['goods_sn','goods_name', 'add_time','purchase_qty','cost','shipping_fee','package_fee','fix_price','avrprice','total_qty','amount','shippingcost','interest','status','grade','valid_qty','onarrive_qty','want_qty'],
		autoWidth:true,
		loadMask:true,
		cry:currency,
		frame:true,
		listURL:'index.php?model=statistics&action=newGoodslist',
		pagesize:15,
        renderTo: document.body
    });
    var OldgoodsGrid = new Ext.ux.OldgoodsGrid({
		id:'OrdergoodsGrid',
        title: '呆货统计表(使用此功能每天需对订单进行出库开单)',
		headers:['产品编码','产品名称','上货时间','采购数量','成本','运费','包装费','固定价($)','销售均价','销售数量','销售额','总均摊运费','利润率%','类别','等级','可用库存','采购在途','报警库存'],
        fields: ['goods_sn','goods_name', 'add_time','purchase_qty','cost','shipping_fee','package_fee','fix_price','avrprice','total_qty','amount','shippingcost','interest','status','grade','valid_qty','onarrive_qty','want_qty'],
		autoWidth:true,
		loadMask:true,
		cry:currency,
		frame:true,
		listURL:'index.php?model=statistics&action=oldGoodslist',
		pagesize:15,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->