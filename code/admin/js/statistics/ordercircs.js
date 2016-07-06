Ext.ux.ordercircsGrid=Ext.extend(Ext.grid.GridPanel,{
	initComponent:function(){
		this.autoHeight = true;
        this.viewConfig = {
            forceFit: true
        };
		
		this.times  = new Ext.form.TextField({
			id : 'times',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.counts  = new Ext.form.TextField({
			id : 'counts',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.qtys  = new Ext.form.TextField({
			id : 'qtys',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.createStore();
		this.creatBbar();
		this.createTbar();
		this.createColumns();
		Ext.ux.ordercircsGrid.superclass.initComponent.call(this);
	},
	createStore:function(){
		this.store=new Ext.data.Store({proxy:new Ext.data.HttpProxy({url:this.listURL}),
		reader:new Ext.data.JsonReader({
			root:'topics',totalProperty:'totalCount',id:this.fields[0]},this.fields),
			listeners : {
					'load' : this.calculate.createDelegate(this),
					'add' : this.calculate.createDelegate(this),
					'remove' : this.calculate.createDelegate(this),
					'update' : this.calculate.createDelegate(this)
				}});
		this.store.load({
			scope:this.store
			});
		this.store.on('beforeload',function(){Ext.apply(this.baseParams,{
								Sales_account:Ext.getCmp('Sales_account').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
		});});},
	createColumns: function() {
        var cols = [new Ext.grid.RowNumberer({header:'序号',width:40}),{
						header: '时间',
						dataIndex: 'paid_times',
						width:60
					},{
						header: '订单量',
						dataIndex: 'counts',
						width:60
					},{
						header: '销售量',
						dataIndex: 'qtys',
						width:60
					}
					];
        this.columns = cols;
    },
	createTbar:function(){
        var pagesize = this.pagesize;
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['销售帐户:',{xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: this.sales_account
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:120,
						editable: false,
						forceSelection: true,
						allowBlank: true,
						emptyText:'选择',
						triggerAction: 'all',
						hiddenName:'Sales_account',
						id: 'Sales_account'
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From',
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！'
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To',
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								Sales_account:Ext.getCmp('Sales_account').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
								}});
							}
					},'-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&type=export&Sales_account='+Ext.getCmp('Sales_account').getValue()+'&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
						}
	 				}];
	} ,
	 
	creatBbar: function() {
    	var times = this.times;
		var counts = this.counts;
		var qtys = this.qtys;
		this.bbar = new Ext.Toolbar({
					cls : 'u-toolbar-b',
					items : ['合计:', '->', '天数:',times,'总订单量:',counts,'总销售量:',qtys]
				})
	},
	calculate:function(){
		var i;
		var counts = 0;
		var qtys = 0;
		for (i = 0; i < this.store.getCount(); i++) {
			counts += this.store.getAt(i).get('counts') * 10000;
			qtys += this.store.getAt(i).get('qtys') * 10000;
		}
		this.times.setValue(this.store.getCount());
		this.counts.setValue(counts / 10000);
		this.qtys.setValue(qtys / 10000);
	}
	});
	