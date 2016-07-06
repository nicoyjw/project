<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext/ux/css/MultiSelect.css"/>
<script type="text/javascript" src="common/lib/ext/ux/MultiSelect.js"></script>
<script type="text/javascript" src="common/lib/ext/ux/ItemSelector.js"></script>
<script type="text/javascript" src="js/newProduct/addProduct.js"></script>
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var goodsinfo = eval(<!--{$good}-->);
	var sizeData = new Ext.data.ArrayStore({
        data: [<!--{$info.goods_size}-->],
        fields: ['value','text']
    });
	var setSizeData = new Ext.data.ArrayStore({
        data: [<!--{$info.set_goods_size}-->],
        fields: ['value','text']
    });
	var colorData = new Ext.data.ArrayStore({
        data: [<!--{$info.goods_color}-->],
        fields: ['value','text']
    });
	var setColorData = new Ext.data.ArrayStore({
        data: [<!--{$info.set_goods_color}-->],
        fields: ['value','text']
    });
	Ext.QuickTips.init();
	var productform = new Ext.ux.addProductForm({
		title:'产品信息',
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		goods_data:[goods_status,goods_cat,goods_brand],
		good:goodsinfo?goodsinfo:{},
		sizeData:sizeData,
		setSizeData:setSizeData,
		colorData:colorData,
		setColorData:setColorData,
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->