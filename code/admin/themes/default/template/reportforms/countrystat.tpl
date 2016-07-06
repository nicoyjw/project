<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/countrystat.js"></script>
<script type="text/javascript">
var sales_account= <!--{$Sales_account}-->;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '按销售国家统计销售额',
		headers:['国家','金额'],
		fields: ['country','money'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=GetCountryStat',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->