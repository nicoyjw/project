<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/editgoodsform.js"></script>
<script type="text/javascript" src="common/lib/ckeditor/ckeditor.js"></script>
<script src="common/lib/ckeditor/_samples/sample.js" type="text/javascript"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var account = [<!--{$allaccount}-->];
	var goods_status = [<!--{$goods_status}-->];
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
		return Ext.create('Ext.form.field.ComboBox',{
						typeAhead: true,
						triggerAction: 'all',
						mode: 'local',
						store:  Ext.create('Ext.data.ArrayStore',{
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
		var orderform = Ext.create('Ext.ux.editgoodsForm',{
		border:true,
		id:'goodform',
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
		goods_data:[goods_status,goods_brand],
		combolist:[sizecombo,colorbombo,account],
		action:user_action,
		rendererlist:[sizing,coloring],
		good:goodsinfo,
        autoWidth: true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
