<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/statistics/salesByAccount.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var salesByAccountGrid = new Ext.ux.salesByAccountGrid({
		id:'salesByAccountGrid',
        title: '销售账户排行榜',
		headers:['销售账户名','销售额'],
        fields: ['account_name','order_sale'],
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=salesByAccountList',
        renderTo: document.body
    });
	salesByAccountGrid.getStore().load();
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->