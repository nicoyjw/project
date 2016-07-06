<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/Commission.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var sales = [<!--{$sales}-->];
	Ext.form.Field.prototype.msgTarget = 'side';
    var CommissionGrid = new Ext.ux.CommissionGrid({
		id:'CommissionGrid',
        title: '销售分红统计列表',
		headers:['起始日期','销售员','SKU','销售数量','分红(CNY)'],
        fields: ['start_time','name','sku', 'num','commission'],
		autoWidth:true,
		sales:sales,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=commissionlist',
		pagesize:20,
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->