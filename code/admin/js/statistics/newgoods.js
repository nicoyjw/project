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
								currency:Ext.getCmp('currency').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
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
        this.tbar = ['-','开始时间:',{
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
							 data: currency
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:50,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'scurrency',
						id: 'currency',
						value:'CNY'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								currency:Ext.getCmp('currency').getValue(),
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=Statistics&action=exportnewgoods&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&currency='+Ext.getCmp('currency').getValue();
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
Ext.ux.OldgoodsGrid = Ext.extend(Ext.grid.GridPanel, {
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
        Ext.ux.OldgoodsGrid.superclass.initComponent.call(this);
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
								num:Ext.fly('num').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
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
        this.tbar = ['-','开始时间:',{
						xtype:'datefield',
						id:'starttime1',
						format:'Y-m-d',
						fieldLabel:'From',
						value:new Date()
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime1',
						format:'Y-m-d',
						fieldLabel:'To',
						value:new Date()
					},'-','销售数量小于:',{
						xtype:'numberfield',
						allowBlank:false,
						width:30,
						id:'num',
						allowNegative:false
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime1').dom.value,
								totime:Ext.fly('totime1').dom.value,
								num:Ext.fly('num').getValue(),
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=Statistics&action=exportoldgoods&starttime='+Ext.fly('starttime1').dom.value+'&totime='+Ext.fly('totime1').dom.value+'&num='+Ext.fly('num').getValue();
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

