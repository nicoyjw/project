<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/reportui.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '订单情况表-2',
		headers:['销售量','订单量'],
		fields: ['order_gross','good_gross'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=list',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->