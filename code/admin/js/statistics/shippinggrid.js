Ext.ux.ShippinglGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.txt_totQty = new Ext.form.TextField({
			id : 'txt_totQty',
			anchor : '95%',
			allowBlank : true,
			width:80,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
						});
		this.costs = new Ext.form.TextField({
			id : 'costs',
			anchor : '95%',
			allowBlank : true,
			width:80,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.weights = new Ext.form.TextField({
			id : 'weights',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
        this.createStore();
        this.createColumns();
        this.createTbar();
		this.CreatBbar();
        Ext.ux.ShippinglGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},this.fields),
		listeners : {
				'load' : this.calculate.bind(this),
				'add' : this.calculate.bind(this),
				'remove' : this.calculate.bind(this),
				'update' : this.calculate.bind(this)
			}
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
		var account = this.accountdata;
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						labelWidth:65,
						width:200,
						value:new Date()
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						labelWidth:65,
						width:200,
						format:'Y-m-d',
						value:new Date()
					},'-','选择账户:',{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: account
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						labelWidth:75,
						width:250,
						hiddenName:'Saccount',
						id: 'account',
						value:'0'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								account:Ext.getCmp('account').getValue()
								}});
							}
					},'-',{
						text:'导出结果集',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&account='+Ext.getCmp('account').getValue();
						}
	 }];
    },
	
	CreatBbar:function(){
		var txt_totQty = this.txt_totQty;
		var costs = this.costs;
		var weights = this.weights;
			this.bbar = new Ext.Toolbar({
						cls : 'u-toolbar-b',
						items : ['合计:', '->', '数量:', txt_totQty,'总重:',weights,'实际运费:',costs]
					})
	},
	calculate:function(){//计算物品总数量和总金额
		var i;
		var totalQty = 0;
		var weights = 0;
		var costs = 0;
		for (i = 0; i < this.store.getCount(); i++) {
			totalQty += this.store.getAt(i).get('counts') * 10000;
			weights += this.store.getAt(i).get('weights') * 10000;
			costs += this.store.getAt(i).get('costs') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
		this.costs.setValue(costs / 10000);
		this.weights.setValue(weights / 10000);
	}
});

