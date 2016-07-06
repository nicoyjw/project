<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/customer/customerviewpoint.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
	var viewport = new Ext.ux.CustomerView({
		headers:['序号','名字','邮箱','购买次数','购买总金额','上次购买时间','电话','联系人','有无价值','是黑名单?'],
		fields: ['customer_id','userid','email','buy_degree','buy_sum_money','last_buy_time','tel','consignee','is_value','is_black'],
		listURL:'index.php?model=customer&action=list',
		windowWidth:320,
		windowHeight:330,
		pagesize:15
	});

	loadend();
});
</script>
<!--{include file="footer.tpl"}-->