<!--{include file="header.tpl"}-->
    <style type="text/css">
#tab11_item .x-panel-body{
	background: white;
	font: 11px Arial, Helvetica, sans-serif;
}
#tab11_item .thumb{
	background: #dddddd;
	padding: 3px;
}
#tab11_item .thumb img{
	height: 80px;
	width: 80px;
}
#tab11_item .thumb-wrap{
	float: left;
	margin: 4px;
	margin-right: 0;
	padding: 5px;
}
#tab11_item .thumb-wrap span{
	display: block;
	overflow: hidden;
	text-align: center;
	
}

#tab11_item .x-view-over{
    border:1px solid #dddddd;
    background: #efefef url(common/lib/ext/resources/images/default/grid/row-over.gif) repeat-x left top;
	padding: 4px;
}

#tab11_item .x-view-selected{
	background: #eff5fb url(themes/default/images/selected.gif) no-repeat right bottom;
	border:1px solid #99bbe8;
	padding: 4px;
}
#tab11_item .x-view-selected .thumb{
	background:transparent;
}
    </style>
<link rel="stylesheet" type="text/css" href="themes/default/css/uploadgoods.css"/>
<script type="text/javascript" src="js/goods/goodslist.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var sp_category = [<!--{$categories_sp}-->];
	var goods_status = [<!--{$goods_status}-->];
	var goods_cat = [<!--{$goods_cat}-->];
	var goods_brand = [<!--{$goods_brand}-->];
	var languages = [<!--{$languages}-->];
	var sizedata = [<!--{$goods_size}-->];
	var colordata = [<!--{$goods_color}-->];
	var user_action = object_Array([<!--{$user_action}-->]);
	goods_status.push(['0','All Status']);
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
	function showStatus(val){
		return object_Array(goods_status)[val];
	}
	goods_cat.push(['0','所有分类']);
	goods_brand.push(['0','所有品牌']);
	function showgroup(v){
		return (v == 0)?'NO':'Yes';
	}
	var viewport = new Ext.ux.GoodsView({
		headers:['goods_id','产品编码', '名称','SKU','库存位置','库存数量','库存下限','所属分类','状态','录入时间'],
        fields: ['goods_id','goods_sn','goods_name','SKU','stock_place','goods_qty','warn_qty','cat_name','status','add_time'],
		renderers:[showStatus,showgroup],
		arrdata:[goods_status,goods_cat,goods_brand,languages],
		webcate:[sp_category],
		listURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree&com=1',
		updatesurl:'index.php?model=goods&action=Uploadgoodsimg',
		windowTitle:'高级搜索',
		rendererlist:[sizing,coloring],
		windowWidth:320,
		windowHeight:300,
		action:user_action,
		pagesize:15
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
