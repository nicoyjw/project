Ext.define('Ext.ux.test.inventory.Inventory', {//StockGrid
    extend: 'Ext.grid.Panel',
    initComponent: function(){
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createColumns();
        this.createStore();
        this.createBbar();
        this.createTbar();
        this.callParent();
    },
    createStore: function(){
        this.store = Ext.create('Ext.data.Store', {
            fields: this.fields,
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listURL,
				actionMethods:{
					read:'POST'
				},
                reader: {
                    type: 'json',
                    root: 'topics',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0]
                }
            }
        });
        this.store.on('beforeload', function(){
            Ext.apply(this.baseParams, {
                depot: Ext.getCmp('depot').getValue(),
                keyword: Ext.fly('keyword').dom.value,
                status_id: Ext.getCmp('status_id').getValue(),
                cat_id: Ext.getCmp('cat_id').getValue(),
            });
        });
    },
    createColumns: function(){
        var cols = [];
        cols.push(new Ext.grid.RowNumberer());
        cols.push({
            header: this.headers[1],
            dataIndex: this.fields[1],
            renderer: function(val, x, rec){
                if ((rec.get('goods_qty') + rec.get('Purchase_qty') - rec.get('varstock')) <= rec.get('warn_qty')) 
                    return "<font color='#F00F00'>" + val + "</font>";
                if ((rec.get('goods_qty') - rec.get('varstock')) <= rec.get('warn_qty')) 
                    return "<font color='#00F00F'>" + val + "</font>";
                return val;
            }
        });
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                header: h,
				flex:1,
                sortable: (i >= 4 && i <= 6) ? true : false,
                dataIndex: f
            });
            if (i == 3) 
                cols.push({
                    header: '可用库存',
                    dataIndex: 'stock',
                    renderer: function(val, x, rec){
                        return rec.get('goods_qty') - rec.get('varstock');
                    }
                });
            
        }
        this.columns = cols;
    },
    
    createBbar: function(){
        var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
            items: []
        });
    },
    
    createTbar: function(){
        var store = this.store;
        var depot = this.depot;
        var goods_status = this.goods_status;
        var afterselect = this.afterselect;
        var pagesize = this.pagesize;
        this.tbar = new Ext.Toolbar({
            items: ['<b>库存列表</b>', '->', {
                xtype: 'combo',
                store: Ext.create('Ext.data.ArrayStore', {
                    fields: ["id", "key_type"],
                    data: depot
                }),
                valueField: "id",
                displayField: "key_type",
                mode: 'local',
                forceSelection: true,
                hiddenName: 'depot_id',
                name: 'depot_id',
                triggerAction: 'all',
                fieldLabel: '仓库',
                allowBlank: false,
                pagesise: 10,
                labelWidth: 45,
                width: 150,
                value: '0',
                id: 'depot'
            }, '-', '所属分类:', new Ext.form.TriggerField({
                editable: false,
                value: '所有分类',
                xtype: 'trigger',
                id: 'cat_name',
                width: 150,
                onSelect: function(record){
                },
                onTriggerClick: function(){
                    getCategoryFormTree('index.php?model=goods&action=getcattree&com=1', 0, afterselect);
                }
            }), {
                xtype: 'hidden',
                id: 'cat_id',
                value: '0'
            }, '-', '产品状态:', {
                xtype: 'combo',
                store: Ext.create('Ext.data.ArrayStore', {
                    fields: ["id", "key_type"],
                    data: goods_status
                }),
                valueField: "id",
                displayField: "key_type",
                mode: 'local',
                labelWidth: 55,
                width: 120,
                editable: false,
                forceSelection: true,
                triggerAction: 'all',
                hiddenName: 'status',
                name: 'status',
                value: '0',
                id: 'status_id'
            }, '-', 'SKU:', {
                xtype: 'textfield',
                id: 'keyword',
                name: 'keyword',
                labelWidth: 55,
                width: 120,
                enableKeyEvents: true,
                listeners: {
                    scope: this,
                    keypress: function(field, e){
                        if (e.getKey() == 13) {
                            store.load({
                                params: {
                                    start: 0,
                                    limit: pagesize,
                                    status_id: Ext.getCmp('status_id').getValue(),
                                    cat_id: Ext.getCmp('cat_id').getValue(),
                                    depot: Ext.getCmp('depot').getValue(),
                                    keyword: Ext.fly('keyword').dom.value,
                                    is_warn: Ext.getCmp('is_warn').getValue()
                                }
                            });
                        }
                    }
                }
            }, '-', {
                xtype: 'button',
                text: '搜索',
                iconCls: 'x-tbar-search',
                handler: function(){
                    store.load({
                        params: {
                            start: 0,
                            limit: pagesize,
                            status_id: Ext.getCmp('status_id').getValue(),
                            cat_id: Ext.getCmp('cat_id').getValue(),
                            depot: Ext.getCmp('depot').getValue(),
                            keyword: Ext.getCmp('keyword').getValue()
                        }
                    });
                }
            }, '-', {
                xtype: 'button',
                text: '导出搜索',
                iconCls: 'x-tbar-import',
                handler: function(){
					
                    window.open().location.href = 'index.php?model=Inventory&action=exportgoods&keyword=' + Ext.getCmp('keyword').getValue() + '&depot=' + Ext.getCmp('depot').getValue() +'&cat_id=' + Ext.getCmp('cat_id').getValue() + '&status_id=' + Ext.getCmp('status_id').getValue();
                }
            }]
        });
    },
    afterselect: function(k, v){
        Ext.getCmp('cat_name').setValue(v);
        Ext.getCmp('cat_id').setValue(k);
    }
});

