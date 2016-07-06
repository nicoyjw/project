<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/orderinterzone.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '订单区间查询',
		headers:['所属金额区间','订单个数'],
		fields: ['jine','order_count'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=GetOrderinterzone',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->