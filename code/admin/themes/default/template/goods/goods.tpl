<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/goodsform.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript" src="common/lib/ckeditor/ckeditor.js"></script>
<script src="common/lib/ckeditor/_samples/sample.js" type="text/javascript"></script>
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
			store: new Ext.data.SimpleStore({
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
	var orderform = Ext.create('Ext.ux.goodsForm',{
		border:false,
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
	loadend();
});
</script>

<!--{include file="footer.tpl"}-->