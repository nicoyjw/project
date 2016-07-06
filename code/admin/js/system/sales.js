Ext.ux.SalesGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		this.creatselectionmodel();
        Ext.ux.SalesGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
	},
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        }];
    },
	creatselectionmodel:function(){
		var sm = new Ext.grid.RowSelectionModel({
						singleSelect:true,
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									this.grid.removeBtn.setDisabled(false);
									this.grid.editBtn.setDisabled(false);
										Ext.getCmp('SalesGoodsGrid').setid(record.data.id);
										Ext.getCmp('SalesGoodsGrid').setTitle("编辑销售员"+record.data.name+"产品列表");
										Ext.getCmp('SalesGoodsGrid').addBtn.setDisabled(false);
										Ext.getCmp('SalesGoodsGrid').getStore().load({
																	params:{start:0,limit:10,supplier_id:record.data.id}
																	});
									}
								}
							}								 
						});
			this.sm = sm;
	}
});

Ext.ux.SalesGoodsGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		this.id = 0;
		Ext.ux.SalesGoodsGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
		var thiz = this;
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				id:thiz.getid()
			});
		});
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
			ref: '../addBtn',
			disabled:true,
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        }];
    },
    getEmptyRecord: function() {
        var r = {};
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
            r[f] = '';
        }
		r['id'] = this.getid();
        return r;
    },
	setid:function(id){
		this.id = id;
	},
	getid:function(){
		return this.id;
	}

});
Ext.ux.SalesChannelGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		Ext.ux.SalesChannelGrid.superclass.initComponent.call(this);
    },
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
		cols.push({
			header:this.headers[1],
			dataIndex:this.fields[1],
			renderer:this.channelreander
			});
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    }
});