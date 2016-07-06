<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/orderviewpoint.js"></script>
<script type="text/javascript" src="js/order/unlockorder.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var shipping = [<!--{$shipping}-->];
var orderstatus = [<!--{$orderstatus}-->];
var user_action = object_Array([<!--{$user_action}-->]);
orderstatus.push(['0','所有状态']);
account.push(['0','所有账户']);
salechannel.push(['0','所有渠道']);
	var viewport = new Ext.ux.allorderView({
		headers:[<!--{$fileds}-->],
        fields: ['order_id','order_status','paid_time','sellsrecord','order_sn','goods','shipping_id','track_no','stockout_sn','userid','Sales_channels','Sales_account_id','pay_note','consignee','street1','street2','city','state','country','zipcode','tel','has_rma','has_msg','has_fbk','size','esweight','stock_place'],
		arrdata:[orderstatus,shipping,salechannel,account],
		listURL:'index.php?model=order&action=getunlockorder',
		windowTitle:'高级搜索',
		windowWidth:320,
		action:user_action,
		windowHeight:345,
		pagesize:15
	});
	viewport.grid.getStore().load({
			params:{start:0,limit:viewport.pagesize}
			});
	loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->
