<!--{include file="header.tpl"}-->
<style type="text/css">
#showimg .x-fieldset-body{
background: white;
padding:10px;
font: 11px Arial, Helvetica, sans-serif;
}
#showimg .x-fieldset-body img{
border:1px solid #dddddd;
width: 200;
height:200
}
#showimg .thumb-wrap{
float: left;
margin: 4px;
margin-right: 0;
padding: 5px;
}
#showimg .thumb-wrap span{
display: block;
overflow: hidden;
text-align: center;
}

#showimg .x-view-over{
border:1px solid #dddddd;
background: #efefef url(common/lib/ext/resources/images/default/grid/row-over.gif) repeat-x left top;
padding: 4px;
}

#showimg .x-view-selected{
background: #eff5fb url(themes/default/images/selected.gif) no-repeat right bottom;
border:1px solid #99bbe8;
padding: 4px;
}
#showimg .x-view-selected .thumb{
background:transparent;
}
</style>
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript" src="js/goods/goodsform.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
var account = [<!--{$allaccount}-->];
var all_account = [<!--{$allaccount}-->];
all_account.push(['0','请选择']);
Ext.onReady(function(){
	Ext.QuickTips.init();
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var sizedata = [<!--{$goods_size}-->];
	var colordata = [<!--{$goods_color}-->];
	var languages = [<!--{$languages}-->];
	var sizecombo = newcombo(sizedata);
	var colorbombo = newcombo(colordata);
	function sizing(v){
		return object_Array(sizedata)[v];
		}
	function coloring(v){
		return object_Array(colordata)[v];
		}
	function newcombo(sdata){
		return new Ext.form.ComboBox({
						typeAhead: true,
						triggerAction: 'all',
						mode: 'local',
						store: new Ext.data.ArrayStore({
							id: 0,
							fields: [
								'myId',
								'displayText'
							],
							data: sdata
						}),
						editable:false,
						valueField: 'myId',
						displayField: 'displayText',
						lazyRender: true,
						listClass: 'x-combo-list-small'
					});
	}
	var orderform = new Ext.ux.goodsForm({
		title:'产品信息',
		border:true,
		id:'goodsForm',
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		catURL:'index.php?model=goods&action=catList',
		brandURL:'index.php?model=goods&action=brandList',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		goods_data:[goods_status,goods_cat,goods_brand,languages],
		combolist:[sizecombo,colorbombo],
		rendererlist:[sizing,coloring],
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