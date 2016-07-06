Ext.define('Ext.ux.bankLogGrid',{
	extend:'Ext.grid.Panel',
	initComponent:function(){
		this.autoHeight = true;
		this.createStore();
		this.creatBbar();
		this.createTbar();
		this.createColumns();
		this.callParent(this);
	},
	createStore:function(){
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		})
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){Ext.apply(this.baseParams,{
			account_id:Ext.getCmp('account_id').getValue(),
			type:Ext.getCmp('type').getValue(),
			deal_type:Ext.getCmp('deal_type').getValue(),
			starttime:Ext.fly('starttime').dom.value,
			totime:Ext.fly('totime').dom.value,
		});});},
	createColumns:function(){
		var cols=[{xtype: 'rownumberer'},
			{header:'账户',dataIndex:'account',width:100,renderer:function(val,x,rec){
				var str=(rec.get('comment'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('comment')+'">':'';
				var ordersn='<b>'+val+'</b>';return ordersn+str;}},
			{header:'收/支',dataIndex:'type',flex:1},
			{header:'款项类型',dataIndex:'deal_type',flex:1},
			{header:'单据编号',dataIndex:'order_sn',flex:1},
			{header:'金额',dataIndex:'money',flex:1},
			{header:'余额',dataIndex:'balance',flex:1},
			{header:'操作时间',dataIndex:'time',flex:1},
			{header:'创建人',dataIndex:'add_user',flex:1},
			{header:'确认人',dataIndex:'confirm_user',flex:1},
			];this.columns=cols;},
	   createTbar: function() {
		var pagesize = this.pagesize;
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['->','选择账户:',{xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: this.powerBank
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'account_id',
						id: 'account_id',
						value:'-1',
					},'-','收支类型:',{xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: [['-1','所有收支'],['0','收入'],['1','支出']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'type',
						id: 'type',
						value:'-1',
					},'-','款项类型:',{xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: [['-1','所有款项'],['0','收款'],['1','付款'],['2','费用'],['3','账户改动']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'deal_type',
						id: 'deal_type',
						value:'-1',
					},'-',{
						xtype:'datefield',
						id:'starttime',
						width:150,
						labelWidth:35,
						format:'Y-m-d',
						fieldLabel:'From'
					},'-',{
						xtype:'datefield',
						id:'totime',
						width:150,
						labelWidth:35,
						format:'Y-m-d',
						fieldLabel:'To'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								account_id:Ext.getCmp('account_id').getValue(),
								type:Ext.getCmp('type').getValue(),
								deal_type:Ext.getCmp('deal_type').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						text:'导出搜索结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&etype=export&account_id='+Ext.getCmp('account_id').getValue()+'&type='+Ext.getCmp('type').getValue()+'&deal_type='+Ext.getCmp('deal_type').getValue()+'&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
						}
					}];
    },
	 
	creatBbar: function() {
		var	pagesize = this.pagesize;
       	this.bbar = Ext.create('Ext.toolbar.Paging',{
			plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			store: this.store,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据"
        });
    }
	});
	