<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/orderviewpoint.js"></script>
<script type="text/javascript" src="js/order/unpaidorder.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var shipping = [<!--{$shipping}-->];
var orderstatus = [<!--{$orderstatus}-->];
var templatelist = [<!--{$print_template}-->];
var zc_status = [<!--{$zc_status}-->];
var user_action = object_Array([<!--{$user_action}-->]);
account.push(['0','Accounts']);
salechannel.push(['0','Sales Channels']);
	var viewport = Ext.create('Ext.ux.depotmanagerView',{
		headers:[<!--{$fileds}-->],
        fields: ['order_id','print_status','order_status','sales_time','paid_time','paypalid','ShippingService','eubpdf','sellsrecord','order_sn','currency','order_amount','goods','shipping_id','track_no','stockout_sn','userid','Sales_channels','Sales_account_id','pay_note','consignee','street1','street2','city','state','country','zipcode','tel','note','has_rma','has_msg','has_fbk','size','esweight','hasmore'],
		arrdata:[orderstatus,shipping,salechannel,account,templatelist],
		step:'servicecheck',
		listURL:'index.php?model=order&action=getunpaidorder',
		windowTitle:'Advance Search',
		action:user_action,
		zc_status:zc_status,
		uncheckcombine:1,
		windowWidth:320,
		windowHeight:345,
		pagesize:15
	});   
	loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->
