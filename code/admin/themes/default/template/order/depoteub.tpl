<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/orderviewpoint.js"></script>
<script type="text/javascript" src="js/order/depoteub.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var shipping = [<!--{$shipping}-->];
var orderstatus = [<!--{$orderstatus}-->];
var user_action = object_Array([<!--{$user_action}-->]);
account.push(['0','所有账户']);
salechannel.push(['0','所有渠道']);
	var viewport = Ext.create('Ext.ux.depotmanagerView',{
		headers:[<!--{$fileds}-->],
        fields: ['order_id','print_status','order_status','paid_time','paypalid','eubpdf','sellsrecord','order_sn','currency','order_amount','goods','shipping_id','track_no','stockout_sn','userid','Sales_channels','Sales_account_id','pay_note','consignee','street1','street2','city','state','country','zipcode','tel','note','has_rma','has_msg','has_fbk','size','esweight'],
		arrdata:[orderstatus,shipping,salechannel,account],
		step:'eubhandle',
		action:user_action,
		listURL:'index.php?model=order&action=Getdepoteub',
		windowTitle:'高级搜索',
		windowWidth:320,
		windowHeight:345,
		pagesize:10
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
