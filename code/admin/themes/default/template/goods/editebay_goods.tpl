<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/edit_ebaygoodsform.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript" src="common/lib/ckeditor/ckeditor.js"></script>
<script src="common/lib/ckeditor/_samples/sample.js" type="text/javascript"></script>
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
	var goodsinfo = eval(<!--{$good}-->);
	
		var orderform = Ext.create('Ext.ux.editgoodsForm',{
		border:true,
		id:'ebaygoodform',
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		delchildURL:'index.php?model=goods&action=delChildgoods',
		catURL:'index.php?model=goods&action=catList',
		brandURL:'index.php?model=goods&action=brandList',
		childlistURL:'index.php?model=goods&action=getchildgoods',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		savechildURL:'index.php?model=goods&action=savechild',
		updatesurl:'index.php?model=goods&action=Uploadgoodsimg',
		goods_data:[DispatchTimeMax,ListingDuration,ListingType,condition,account],
		good:goodsinfo,
        autoWidth: true,
		renderTo:document.body
	});
	loadend();
	
});
</script>
<!--{include file="footer.tpl"}-->
