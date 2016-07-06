// JavaScript Document
Ext.ux.currentstockGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.totalcost = new Ext.form.TextField({
			id : 'totalcost',
			anchor : '95%',
			width:100,
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		});
		this.varcost = new Ext.form.TextField({
			id : 'varcost',
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
		Ext.ux.currentstockGrid.superclass.initComponent.call(this);
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
		var depot=this.depot;
		var store = this.store;
		var listURL=this.listURL;
        this.tbar = ['->','-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href=listURL+'&type=export';
						}
	 			}];
    },
	creatBbar:function(){
		var totalcost = this.totalcost;
		var varcost = this.varcost;
		var counts=this.counts;
		this.bbar = new Ext.Toolbar({
					cls : 'u-toolbar-b',
					items : ['合计:', '->', '仓库数:',counts,'库存总成本:',totalcost,'已锁定库存总成本:',varcost]
				})
	},
	calculate:function(){
		var i;
		var totalcost = 0;
		var varcost = 0;
		for (i = 0; i < this.store.getCount(); i++) {
			totalcost += this.store.getAt(i).get('totalcost') * 10000;
			varcost += this.store.getAt(i).get('varcost') * 10000;
		}
		this.varcost.setValue(varcost / 10000);
		this.totalcost.setValue(totalcost / 10000);
		this.counts.setValue(this.store.getCount());
	}
});
