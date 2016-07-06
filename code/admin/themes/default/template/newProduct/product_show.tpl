<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/newProduct/productShow.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var action_type = '<!--{$action_type}-->';
	var imgGrid = {};
	
	var goodsinfo = eval(<!--{$good}-->
	);
	var imgtype =[<!--{$typedata}-->
	];
	var type ='<!--{$type}-->';
	if(goodsinfo){
		if(action_type==3|| action_type==6){
		var sb = Ext.getCmp('basic-statusbar');
        var store = new Ext.data.GroupingStore({
			proxy : new Ext.data.HttpProxy({url:'index.php?model=newProduct&action=imglist&goods_id='+(goodsinfo?goodsinfo.goods_id:'')}),
			autoLoad:true,
			groupField:'img_assign',
			sortInfo:{field: 'add_time', direction: "DESC"},
			reader: new Ext.data.JsonReader({
				root: 'topics',
				id: 'rec_id'
				},['rec_id','img_assign','url','add_user','add_time'])
    	});

		var imgGrid = new Ext.grid.GridPanel({
			store: store,
			columns: [{header:'产品图片',dataIndex:'url',width:120,renderer:function(v){return'<img src='+v+' width=100 height=100>';}},
			{header:'图片类型',dataIndex:'img_assign'},
			{header:'图片地址',dataIndex:'url',width:200},
			{header:'操作员',dataIndex:'add_user'},
			{header:'更新时间',dataIndex:'add_time'}],
			view: new Ext.grid.GroupingView({forceFit:true,groupTextTpl: '{group}: ({[values.rs.length]}个图片)'}),
			frame:true,
			width:960,
			height: 450,
			loadMask:true,
			renderTo: document.body
		});
		}
	}
	
	var showForm = new Ext.ux.showForm({
		title:'产品信息',
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		good:goodsinfo?goodsinfo:{},
		action_type:action_type,
		imgGrid:imgGrid,
		type:type,
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->