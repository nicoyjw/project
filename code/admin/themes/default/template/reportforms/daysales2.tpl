<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/daysales2.js"></script>
<script type="text/javascript">
var goodscatalog= <!--{$goodscatalog}-->;
var sales_account= <!--{$Sales_account}-->;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '热销店铺2',
		headers:['日期','销售量','销售额'],
		fields: ['add_time','xiaoliang','xiaoshou_e'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=getdaysales2',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->