<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/order/paypalorder.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var paccount =[<!--{$paccount}-->];
	function pa(v){
		return object_Array(paccount)[v];
		}
	var paypalorder = Ext.create('Ext.ux.PaypalGrid',{
		listURL:'index.php?model=order&action=getpaypalorder',
		rendererlist:[pa],
		title: 'Paypal流水列表',
		autoWidth:true,
		autoHeight:true,
		frame:true,
		renderTo: document.body,
		pagesize:15		
		});
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
