<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/pick.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var operator = [<!--{$operator}-->];
	operator.push(['0','所有采购员']);
	Ext.form.Field.prototype.msgTarget = 'side';

    var pickGrid = new Ext.ux.pickGrid({
		id:'pickGrid',
        title: '采购统计列表',
		headers:['供应商','数量','金额','单数','到货数量','退货数量'],
        fields: ['supplier_name','total_qty','total_price','counts','arrival_qty','return_qty'],
		operatordata:operator,
		width:800,
		frame:true,
		listURL:'index.php?model=statistics&action=picklist',
        renderTo: document.body
    });
	pickGrid.getStore().load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								operator:Ext.getCmp('operator').getValue(),
								sku:Ext.fly('sku').dom.value
								}});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->