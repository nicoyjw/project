<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var goods_field=[<!--{$goods_field}-->];
	goods_field.push(['0','所有字段']);
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:'index.php?model=goods&action=getgoodslog'}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},[
			'id','goods_sn','action','field','content','admin_id','addtime'
      	])
    });
	ds.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				field:Ext.getCmp('field').getValue(),
				keyword:Ext.getCmp('keyword').getValue()
			});
		});
	var colModel = new Ext.grid.ColumnModel([
		 {header:'产品',width:50,dataIndex:'goods_sn'},
		 {header:'操作',width:50,dataIndex:'action'},
		 {header:'对象', width:80,dataIndex:'field'},
		 {header:'内容', width:300,dataIndex:'content'},
		 {header:'操作人', width:50,dataIndex:'admin_id'},
		 {header:'时间', width:50,dataIndex:'addtime'}
		 
		]);
	var grid = new Ext.grid.GridPanel({
				border:false,
				loadMask: true,
				autoHeight:true,
				title:'条目列表',
				store: ds,
				cm: colModel,
				autoWidth:true,
				frame:true,
				viewConfig : {
					forceFit: true
				},
				renderTo: document.body,
				autoScroll: true,
				tbar : ['->',{
								xtype:'combo',
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data: goods_field
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:120,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'field',
								id: 'field',
								fieldLabel: '销售渠道',
								value:0,
								allowBlank:false
							},'-','关键词:',{
										xtype:'textfield',
										id:'keyword',
										name:'keyword',
										enableKeyEvents:true,
										listeners:{
										scope:this,
										keypress:function(field,e){
											if(e.getKey()==13){
											ds.load({params:{start:0, limit:20,
												field:Ext.getCmp('field').getValue(),
												keyword:field.getValue()
												}});
												}
											}
										}
									},'-',{
										xtype:'button',
										text:'搜索',
										iconCls:'x-tbar-search',
										handler:function(){
											ds.load({params:{start:0, limit:20,
												field:Ext.getCmp('field').getValue(),
												keyword:Ext.fly('keyword').dom.value
												}});
											}
					}],
				bbar: new Ext.PagingToolbar({
					pageSize:20,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		})
            });
	ds.load({params:{start:0, limit:20}});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->