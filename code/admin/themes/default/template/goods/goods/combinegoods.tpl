<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript" src="js/goods/combinegoodsform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [['65535','组合产品']];
	var goods_brand = [<!--{$goods_brand}-->];
	var orderform = new Ext.ux.goodsForm({
		title:'产品信息',
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		catURL:'index.php?model=goods&action=catList',
		brandURL:'index.php?model=goods&action=brandList',
		listURL:'index.php?model=goods&action=getcomgoods',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree',
		goods_data:[goods_status,goods_cat,goods_brand],
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	var tippanel = new Ext.Panel({
				autoHeight:true,
				renderTo:document.body,
				html:'状态说明:<br>1.产品编码---如不填写，系统将会根据产品分类自动生成唯一的产品编码<br>2.SKU---如不填写，系统将会自动等同于产品编码<br>3.刊登描述---请等待网页编辑器加载完成再进行切换标签页面<br>'			
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
