<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/orderviewpoint.js"></script>
<script type="text/javascript" src="js/order/pickuporder.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var shipping = [<!--{$shipping}-->];
var orderstatus = [<!--{$orderstatus}-->];
var user_action = object_Array([<!--{$user_action}-->]);
var templatelist = [<!--{$print_template}-->];
account.push(['0','所有账户']);
salechannel.push(['0','所有渠道']);
    var viewport = Ext.create('Ext.ux.depotmanagerView',{
        headers:[<!--{$fileds}-->],
        fields: ['order_id','is_check','order_status','paid_time','paypalid','eubpdf','sellsrecord','order_sn','currency','order_amount','goods','shipping_id','track_no','stockout_sn','userid','Sales_channels','Sales_account_id','pay_note','consignee','street1','street2','city','state','country','zipcode','tel','note','has_rma','has_msg','has_fbk','size','esweight','stock_place'],
        arrdata:[orderstatus,shipping,salechannel,account],
        step:'pickuporder',
        templatelist:templatelist,
        listURL:'index.php?model=order&action=GetPickuporder',
        windowTitle:'高级搜索',
        action:user_action,
        windowWidth:320,
        windowHeight:345,
        pagesize:25
    });      
    loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->