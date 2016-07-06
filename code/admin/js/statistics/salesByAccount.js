// JavaScript Document
Ext.ux.salesByAccountGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.totalSales = new Ext.form.TextField({
			id : 'totalSales',
			anchor : '95%',
			width:100,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.counts = new Ext.form.TextField({
			id : 'counts',
			anchor : '95%',
			width:100,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.creatBbar();
		Ext.ux.salesByAccountGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
		
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
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
			},
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
				flex:1,
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },

    createTbar: function() {
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['->','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						labelWidth:65,
						width:200,
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！'
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						labelWidth:65,
						width:200,
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！'
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
							window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;;
						}
	 			}];
    },
	creatBbar:function(){
		var totalSales = this.totalSales;
		var counts=this.counts;
		this.bbar = new Ext.Toolbar({
					cls : 'u-toolbar-b',
					items : ['合计:', '->', '总销售账号数:',counts,'总销售额:',totalSales]
				})
	},
	calculate:function(){
		var i;
		var totalSales = 0;
		for (i = 0; i < this.store.getCount(); i++) {
			totalSales += this.store.getAt(i).get('order_sale') * 10000;
		}
		this.totalSales.setValue(totalSales / 10000);
		this.counts.setValue(this.store.getCount());
	}
});
