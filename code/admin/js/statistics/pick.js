Ext.ux.pickGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		
		this.total_qty  = new Ext.form.TextField({
			id : 'total_qty',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.total_price = new Ext.form.TextField({
			id : 'total_price',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.counts = new Ext.form.TextField({
			id : 'counts',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.arrival_qty = new Ext.form.TextField({
			id : 'arrival_qty',
			anchor : '95%',
			width:80,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.return_qty = new Ext.form.TextField({
			id : 'return_qty',
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
		this.creatBbar();
        Ext.ux.pickGrid.superclass.initComponent.call(this);
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
				'load' : this.calculate.createDelegate(this),
				'add' : this.calculate.createDelegate(this),
				'remove' : this.calculate.createDelegate(this),
				'update' : this.calculate.createDelegate(this)
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
		var operator = this.operatordata;
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['选择采购员:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: operator
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						hiddenName:'operator',
						fieldLabel: '选择采购员',
						id: 'operator',
						value:0
					},'-','SKU:',{
						id:'sku',
						width:100,
						xtype:'textfield'
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m',
						fieldLabel:'From'
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m',
						fieldLabel:'To'
					},'-',{
						xtype:'button',
						text:'统计',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								operator:Ext.getCmp('operator').getValue(),
								sku:Ext.fly('sku').dom.value
								}});
							}
					},'-',{
						text:'导出结果集',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&operator='+Ext.getCmp('operator').getValue()+'&sku='+Ext.fly('sku').dom.value;
						}
					}];
    },
	creatBbar:function(){
		var total_qty = this.total_qty;
		var total_price = this.total_price;
		var counts = this.counts;
		var arrival_qty = this.arrival_qty;
		var return_qty = this.return_qty;
		this.bbar = new Ext.Toolbar({
					cls : 'u-toolbar-b',
					items : ['合计:', '->', '总数量:',total_qty,'总金额:',total_price,'总单数:',counts,'到货总数量:',arrival_qty,'退货总数量:',return_qty]
				})
	},
	calculate:function(){//计算物品总数量和总金额
		var i;
		var total_qty = 0;
		var total_price = 0;
		var counts = 0;
		var arrival_qty = 0;
		var return_qty = 0;
		for (i = 0; i < this.store.getCount(); i++) {
			total_qty += this.store.getAt(i).get('total_qty') * 10000;
			total_price += this.store.getAt(i).get('total_price') * 10000;
			counts += this.store.getAt(i).get('counts') * 10000;
			arrival_qty += this.store.getAt(i).get('arrival_qty') * 10000;
			return_qty += this.store.getAt(i).get('return_qty') * 10000;
		}
		this.total_qty.setValue(total_qty / 10000);
		this.total_price.setValue(total_price / 10000);
		this.counts.setValue(counts / 10000);
		this.arrival_qty.setValue(arrival_qty / 10000);
		this.return_qty.setValue(return_qty / 10000);
	}
});