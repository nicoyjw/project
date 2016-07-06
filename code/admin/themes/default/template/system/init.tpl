<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/system/init.js"></script>
<script type="text/javascript">
var account = [<!--{$allaccount}-->];
var salechannel = [<!--{$Sales_channels}-->];
var depot = [<!--{$depot}-->];
var info = eval(<!--{$info}-->);
var shipping = [<!--{$shipping}-->];
var orderstatus = [<!--{$orderstatus}-->];
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var aliaccount = [<!--{$aliaccount}-->];
	goods_cat.push(['0','所有分类']);
	goods_brand.push(['0','所有品牌']);
	goods_status.push(['0','All Status']);
orderstatus.push(['0','所有状态']);
account.push(['0','所有账户']);
salechannel.push(['0','所有渠道']);
Ext.onReady(function(){
	Ext.QuickTips.init();
	var systemForm = Ext.create('Ext.ux.systemTab',{
		border:false,
		frame:false,
        autoWidth: true,
		autoHeight:true,
		handleURL:'index.php?model=system&action=inithandle',
		arrdata:[goods_status,goods_cat,goods_brand,aliaccount],
		accountdata:account,
		info:info,
		statusdata:orderstatus,
		salesCnldata:salechannel,
		depotdata:depot,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
