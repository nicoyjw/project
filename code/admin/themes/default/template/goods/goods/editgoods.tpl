<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript" src="js/goods/editgoodsform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var goodsinfo = eval(<!--{$good}-->);
	var sizedata = [<!--{$goods_size}-->];
	var colordata = [<!--{$goods_color}-->];
	var user_action = object_Array([<!--{$user_action}-->]);
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
		var orderform = new Ext.ux.editgoodsForm({
		title:'产品信息',
		border:true,
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
		goods_data:[goods_status,goods_cat,goods_brand],
		combolist:[sizecombo,colorbombo],
		action:user_action,
		rendererlist:[sizing,coloring],
		good:goodsinfo,
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
