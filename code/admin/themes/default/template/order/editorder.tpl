<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/editorderform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var shipping = [<!--{$shipping}-->];
var status = [<!--{$order_status}-->];
var payment = [<!--{$payment}-->];
var shippingstatus = [<!--{$shippingstatus}-->];
var orderinfo = eval(<!--{$order}-->);
var use_sn_prefix = <!--{$use_sn_prefix > 0}-->;

	Ext.QuickTips.init();
	var orderform = Ext.create('Ext.ux.EditorderForm',{
		title:'<center><b>'+'编辑订单--订单号:'+orderinfo.torder_sn+'</b></center>',
		border:true,
		labelAlign: 'right',
        labelWidth: 75,
		delURL:'index.php?model=order&action=delgoods',
		listURL:'index.php?model=order&action=getOrdergoods',
		goodsgirdURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree',
        autoWidth: true,
		autoHeight: true,
		order:orderinfo,
		use_sn_prefix:use_sn_prefix,
		arrdata:[account,salechannel,shipping,status,payment,shippingstatus],
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
