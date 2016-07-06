Ext.ux.CommissionGrid = Ext.extend(Ext.grid.GridPanel, {
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
        Ext.ux.CommissionGrid.superclass.initComponent.call(this);
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
		var   Nowdate=new   Date();   
		var   MonthFirstDay =new   Date(Nowdate.getYear()+1900,Nowdate.getMonth(),1);
		var pagesize = this.pagesize;
		var sales = this.sales;
		var store = this.store;
        this.tbar = ['开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From',
						value:MonthFirstDay
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To',
						value:new Date()
					},'-','销售员',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: sales
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						allowBlank:false,
						hiddenName:'sales',
						fieldLabel: '选择账户',
						id: 'sales'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								sales:Ext.getCmp('sales').getValue(),
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=Statistics&action=exportcommission&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&sales='+Ext.getCmp('sales').getValue();
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

