<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/onegoodsreport.js"></script>
<script type="text/javascript">
var sales_account= <!--{$Sales_account}-->;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '单商品报表',
		headers:['日期','销售量','售价','重量'],
		fields: ['add_time','goods_sale','goods_price'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=getonegoodsreport',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->