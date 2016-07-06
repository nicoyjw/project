Ext.ux.monthrmaGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
        this.createTbar();
        Ext.ux.monthrmaGrid.superclass.initComponent.call(this);
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
		var listURL=this.listURL;
		var store = this.store;
        this.tbar = ['开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m',
						fieldLabel:'From',
						value:MonthFirstDay
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m',
						fieldLabel:'To',
						value:new Date()
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
								}});
							}
					},'-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
						}
					}];
    }
});
Ext.ux.rmaGrid = Ext.extend(Ext.grid.GridPanel, {
		initComponent: function() {
			this.autoHeight = true;
			this.stripeRows = true;
			this.viewConfig = {
				forceFit: true
			};
			this.createStore();
			this.createColumns();
			this.createTbar();
			Ext.ux.monthrmaGrid.superclass.initComponent.call(this);
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
		var listURL=this.listURL;
        this.tbar = ['-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							var month=Ext.getCmp('monthrmaGrid').getSelectionModel().getSelected().get("month");
							window.open().location.href=listURL+'&type=export&starttime='+month;
						}
					}];
    }
	});

