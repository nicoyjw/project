<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var goods_field=[<!--{$goods_field}-->];
	goods_field.push(['0','所有字段']);
	var ds = Ext.create('Ext.data.JsonStore', {
			fields:['id','goods_sn','action','field','content','admin_id','addtime'],
			pageSize:  this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=goods&action=getgoodslog',
				actionMethods:{
					read:'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					root: 'topics'
				}
			}
		});
	ds.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				field:Ext.getCmp('field').getValue(),
				keyword:Ext.getCmp('keyword').getValue()
			});
		});
	var colModel = [
		 {header:'产品',flex:1,dataIndex:'goods_sn'},
		 {header:'操作',flex:1,dataIndex:'action'},
		 {header:'对象', flex:1,dataIndex:'field'},
		 {header:'内容', flex:5,dataIndex:'content'},
		 {header:'操作人', flex:1,dataIndex:'admin_id'},
		 {header:'时间', flex:1,dataIndex:'addtime'}
		 
		];
	var grid = Ext.create('Ext.grid.Panel',{
				border:false,
				loadMask: true,
				title:'条目列表',
				store: ds,
				height:450,
				columns: colModel,
				frame:true,
				renderTo: document.body,
				autoScroll: true,
				tbar : ['->',{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: goods_field
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:250,
								labelWidth: 60,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'field',
								id: 'field',
								fieldLabel: '相关操作',
								value:'0',
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
											ds.load({params:{start:0, limit:10,
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
											ds.load({params:{start:0, limit:10,
												field:Ext.getCmp('field').getValue(),
												keyword:Ext.getCmp('keyword').getValue()
												}});
											}
					}],
				bbar: [{
					xtype:'pagingtoolbar',
					pageSize:10,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		}]
            });
	ds.load({params:{start:0, limit:10}});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->