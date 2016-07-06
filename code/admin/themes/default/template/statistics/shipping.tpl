<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/shippinggrid.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var account = [<!--{$account}-->];
	account.push(['0','所有账户']);
	Ext.form.Field.prototype.msgTarget = 'side';

    var ShippinglGrid = new Ext.ux.ShippinglGrid({
		id:'ShippingGrid',
        title: '发货方式统计列表',
		headers:['快递方式','数量','总重','实际运费'],
        fields: ['shipping', 'counts','weights','costs'],
		accountdata:account,
		frame:true,
		listURL:'index.php?model=statistics&action=shippinglist',
        renderTo: document.body
    });
	ShippinglGrid.getStore().load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								account:Ext.getCmp('account').getValue()
								}});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->