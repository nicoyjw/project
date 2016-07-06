Ext.ux.OrdergoodsGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
        this.createTbar();
		this.CreatBbar();
        Ext.ux.OrdergoodsGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},this.fields)
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
								timetype:Ext.getCmp('timetype').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								account:Ext.getCmp('account').getValue()
			});
		});
	},
	
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },

    createTbar: function() {
		var pagesize = this.pagesize;
		var store = this.store;
		var account = this.accountdata;
		var currency = this.cry;
        this.tbar = [{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: [['1','Paid time'],['2','Shipping time']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'stimetype',
						id: 'timetype',
						value:1
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From',
						value:new Date()
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To',
						value:new Date()
					},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: account
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:100,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'saccount',
						fieldLabel: '选择账户',
						id: 'account',
						value:0
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								timetype:Ext.getCmp('timetype').getValue(),
								account:Ext.getCmp('account').getValue(),
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=Statistics&action=exportprofit&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&account='+Ext.getCmp('account').getValue()+'&timetype='+Ext.getCmp('timetype').getValue();
							}
					}];
    },
	
	CreatBbar:function(){
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
	}
});

