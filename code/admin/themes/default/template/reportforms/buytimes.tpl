<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/buytimes.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '客户购买排名',
		headers:['客户姓名号','购买次数'],
		fields: ['userid','order_count'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=GetBuytimes',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->