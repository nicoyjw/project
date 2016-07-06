<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/profitinterzone.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '利润率区间',
		headers:['日期','商品编号','销售额'],
		fields: ['add_time','goods_sn','jine'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=GetProfitinterzone',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->