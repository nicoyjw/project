<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/ebay_goodsform.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript" src="common/lib/ckeditor/ckeditor.js"></script>
<script src="common/lib/ckeditor/_samples/sample.js" type="text/javascript"></script>
<style type="text/css">
.fixed{position:fixed;left:200px;bottom:20px;width:400px;}</style>
<script type="text/javascript">
var account = [<!--{$account}-->];
account.push(['0','请选择']);
Ext.onReady(function(){
	Ext.QuickTips.init();
	var DispatchTimeMax = [<!--{$DispatchTimeMax}-->];
	var ListingDuration = [<!--{$ListingDuration}-->];
	var ListingType = [<!--{$ListingType}-->];
	var condition = [<!--{$condition}-->];
	var is_admin = <!--{$role_id}-->;
	var orderform = Ext.create('Ext.ux.goodsForm',{
		border:false,
		id:'goodsForm',
		style:'margin-top:-15px',
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		catURL:'index.php?model=goods&action=catList',
		brandURL:'index.php?model=goods&action=brandList',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		goods_data:[DispatchTimeMax,ListingDuration,ListingType,condition,account],
		is_admin:is_admin,
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	loadend();
});
</script>

<!--{include file="footer.tpl"}-->