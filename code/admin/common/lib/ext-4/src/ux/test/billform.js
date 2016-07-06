Ext.define('Ext.ux.test.billform', {//BillForm
    extend: 'Ext.form.Panel',
    initComponent: function(){
        this.frame = true, this.buttonAlign = 'center';
        this.creatSupplierstore();
        this.creatoperatorstore();
        this.creatselectstore();
        this.creatinfopart();
        this.creatGridcm();
        this.creatGoodsstore();
        this.creatGoodsgrid();
        this.creatItems();
        this.creatButtons();
        this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
            Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
            Ext.getCmp('editBtn').setDisabled(!sm.hasSelection());
        });
        this.callParent();
    },
    creatSupplierstore: function(){//供应商明细store
        this.Supplierstore = Ext.create('Ext.data.Store', {
            fields: ['id', 'name'],
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listSupplierURL,
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    method: 'POST',
                    idProperty: 'id',
                    root: 'topics'
                }
            }
        });
    },
    creatoperatorstore: function(){//操作员明细
        var operator_id = this.order.operator_id;
        this.operatorstore = Ext.create('Ext.data.Store', {
            fields: this.fields,
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listUserURL,
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    method: 'POST',
                    idProperty: 'user_id',
                    root: 'topics'
                },
                listeners: {
                    load: function(){
                        Ext.getCmp('operatorid').setValue(operator_id);
                    }
                }
            }
        });
    },
    creatinfopart: function(){//基本信息
        this.infopart = Ext.create('Ext.form.FieldSet', {
            height: 100,
            layout: 'column',
            items: [{
                columnWidth: .3,
                items: [{
                    xtype: 'combo',
                    store: this.operatorstore,
                    valueField: "user_id",
                    displayField: "user_name",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    hiddenName: 'operator_id',
                    name: 'operator_id',
                    triggerAction: 'all',
                    fieldLabel: '操作员',
                    allowBlank: false,
                    pagesise: 10,
                    minListWidth: 220,
                    value: this.order.operator_id,
                    id: 'operatorid'
                }, {
                    xtype: 'textfield',
                    fieldLabel: '订单备注',
                    value: this.order.comment,
                    name: 'comment',
                    id: 'comment'
                }]
            }, {
                columnWidth: .3,
                items: [{
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.stocktype
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    width: 130,
                    editable: false,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName: 'stocktype',
                    name: 'stocktype',
                    value: this.order.stocktype,
                    allowBlank: false,
                    fieldLabel: '类型',
                    id: 'stocktypeid'
                }, {
                    xtype: 'combo',
                    store: this.Supplierstore,
                    valueField: "id",
                    displayField: "name",
                    mode: 'remote',
                    width: 100,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName: 'supplier1',
                    name: 'supplier1',
                    fieldLabel: '供应商',
                    hidden: (this.inout == 1) ? false : true,
                    pageSize: 30,
                    minListWidth: 220,
                    id: 'supplier_id',
                    listeners: {
                        beforequery: function(qe){
                            qe.combo.store.on('beforeload', function(){
                                Ext.apply(this.baseParams, {
                                    key: qe.query
                                });
                            });
                            qe.combo.store.load();
                        }
                    }
                }, {
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.Sales_channels
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    width: 130,
                    hidden: (this.inout == 2) ? false : true,
                    editable: false,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName: 'supplier2',
                    name: 'supplier2',
                    value: this.order.supplier ? this.order.supplier : 1,
                    allowBlank: false,
                    fieldLabel: '渠道',
                    id: 'Sales_channels'
                }]
            }, {
                columnWidth: .3,
                items: [{
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.orderstatus
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    width: 130,
                    editable: false,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName: 'status',
                    name: 'status',
                    value: this.order.status,
                    allowBlank: false,
                    fieldLabel: '订单状态',
                    id: 'statusid'
                }, {
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.depot
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    hiddenName: 'depot_id',
                    name: 'depot_id',
                    triggerAction: 'all',
                    fieldLabel: '仓库',
                    allowBlank: false,
                    pagesise: 10,
                    width: 130,
                    value: this.order.depot_id,
                    id: 'depot'
                }, {
                    fieldLabel: '订单编码',
                    id: 'order_sn',
                    name: 'order_sn',
                    value: this.order.order_sn,
                    xtype: 'hidden'
                }, {
                    fieldLabel: '订单号',
                    id: 'order_id',
                    name: 'order_id',
                    value: this.order.order_id,
                    xtype: 'hidden'
                }]
            }]
        });
        /*var Item = Ext.data.Record.create([{
         id:'supplier',
         name:'supplier_name'
         }]);
         if(this.order.supplier && this.inout == 1)	{
         var p = new Item({id:this.order.supplier,name:this.order.supplier_name});
         this.Supplierstore.add(p);
         Ext.getCmp('supplier_id').setValue(this.order.supplier);
         }*/
    },
    
    /*creatGoodsstore:function(){//订单明细store
     var thiz = this;
     this.goodsstore = Ext.create('Ext.data.Store',{
     fields:['rec_id','goods_qty','goods_id','goods_sn','goods_price','goods_name','relate_order_sn','remark'],
     proxy: {
     type: 'ajax',
     url : this.goodsURL,
     actionMethods:{
     read: 'POST'
     },
     reader:{
     type: 'json',
     totalProperty: 'totalCount',
     idProperty:'rec_id',
     root: 'topics'
     }
     },
     baseParams : {
     order_id : this.order.order_id
     },
     listeners:{
     load: function(){
     var reCat = /cgrk/gi;
     if(reCat.test(thiz.goodsURL)){
     var i;
     for (i = 0; i < thiz.goodsstore.getCount(); i++) {
     thiz.goodsstore.getAt(i).set('rec_id',0);
     }
     }
     }
     }
     });
     this.goodsstore.load({
     params:{start:0,limit:30},
     scope:this.goodsstore
     });
     },
     
     creatGridcm:function(){
     var thiz = this;
     this.cmlist = new Ext.grid.ColumnModel([{
     header : '产品编码<font color=red>*</font>',
     dataIndex:'goods_sn',
     align : 'left'
     }, {
     header:'产品名称<font color=red>*</font>',
     width:250,
     dataIndex:'goods_name',
     align:'left'
     }, {
     header:'产品数量<font color=red>*</font>',
     dataIndex:'goods_qty',
     align:'right',
     editor:new Ext.form.NumberField({
     allowBlank:false,
     allowNegative:false,
     decimalPercision:4,
     style:'text-align:left'
     })
     }, {
     header:'产品价格<font color=red>*</font>',
     dataIndex:'goods_price',
     align:'right',
     hidden:(thiz.action[0] == 0)?true:false,
     editor:new Ext.form.NumberField({
     allowBlank:false,
     allowNegative:false,
     readOnly:(thiz.action[1] == 0)?true:false,
     decimalPercision:4,
     style:'text-align:left'
     })
     }, {
     header:'关联单据',
     dataIndex:'relate_order_sn',
     align:'right'
     }, {
     header:'产品备注',
     width:200,
     dataIndex:'remark',
     align:'left',
     editor:new Ext.form.TextField()
     }]);
     },
     creatGoodsgrid:function(){//创建产品明细
     this.goodsGrid = Ext.create('Ext.grid.Panel', {
     frame:true,
     id : "destPanel",
     title:'单据产品明细',
     height : 300,
     autoWidth : true,
     columns : this.cmlist,
     region:'center',
     selModel:  Ext.create('Ext.selection.RowModel',{
     mode: 'SINGLE'
     }),
     clicksToEdit : 1,
     stripeRows : true, // 让基数行和偶数行的颜色不一
     store : this.goodsstore,
     viewConfig : {
     forceFit : true
     },
     border : true,
     iconCls : 'icon-grid',
     tbar : Ext.create('Ext.toolbar.Toolbar',{
     items : [{
     xtype:'button',
     text:'新增产品',
     id: 'addBtn',
     iconCls: 'x-tbar-add',
     handler:this.createWindow.bind(this,['0'])
     },{
     xtype:'button',
     text:'编辑产品',
     id: 'editBtn',
     disabled:true,
     iconCls: 'x-tbar-update',
     handler:this.createWindow.bind(this,['1'])
     },{
     text: '删除',
     iconCls: 'x-tbar-del',
     id: 'removeBtn',
     handler: this.removeItem.bind(this),
     disabled:true
     }]
     }),
     bbar : Ext.create('Ext.toolbar.Paging',{
     pageSize: 30,
     displayInfo: true,
     displayMsg: '第{0} 到 {1} 条数据 共{2}条',
     emptyMsg: "没有数据",
     store: this.goodsstore
     })
     });
     },*/
    creatGoodsstore: function(){//订单明细store
        this.model = Ext.define('goosmdoel', {
            extend: 'Ext.data.Model',
            fields: [{
                name: 'rec_id'
            }, {
                name: 'goods_qty'
            }, {
                name: 'goods_id'
            }, {
                name: 'goods_sn'
            }, {
                name: 'goods_price'
            }, {
                name: 'goods_name'
            }, {
                name: 'relate_order_sn'
            }, {
                name: 'remark'
            }, ]
        })
        this.goodsstore = Ext.create('Ext.data.Store', {
            model: this.model,
            baseParams: {
                order_id: this.order.order_id
            },
            proxy: {
                extraParams: {
                    order_id: this.order.order_id
                },
                type: 'ajax',
                url: this.goodsURL,
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    method: 'POST',
                    idProperty: 'rec_id',
                    root: 'topics'
                }
            }
            /*,
             listeners:{
             load: function(){
             var reCat = /cgrk/gi;
             if(reCat.test(thiz.goodsURL)){
             var i;
             for (i = 0; i < thiz.goodsstore.getCount(); i++) {
             thiz.goodsstore.getAt(i).set('rec_id',0);
             }
             }
             }
             }*/
        })
        this.goodsstore.load();
    },
    
    creatGridcm: function(){
        this.cmlist = [{
            header: '产品编码<font color=red>*</font>',
            dataIndex: 'goods_sn',
            align: 'left'
        }, {
            header: '产品名称<font color=red>*</font>',
            width: 250,
            dataIndex: 'goods_name',
            align: 'left'
        }, {
            header: '产品数量<font color=red>*</font>',
            dataIndex: 'goods_qty',
            align: 'right',
            editor: {
                xtype: 'numberfield',
                allowBlank: false,
                minValue: 0,
                decimalPercision: 4,
                style: 'text-align:left'
            }
        }, {
            header: '产品价格<font color=red>*</font>',
            dataIndex: 'goods_price',
            align: 'right',
            hidden: true,
            renderer: function(v){
                return Ext.util.Format.number(v, "0.00");
            },
            editor: {
                xtype: 'numberfield',
                allowBlank: false,
                minValue: 0,
                decimalPercision: 4,
                style: 'text-align:right'
            }
        }, {
            header: '关联单据',
            dataIndex: 'relate_order_sn',
            align: 'right'
        }, {
            header: '产品备注',
            width: 200,
            dataIndex: 'remark',
            align: 'left',
            editor: {}
        }];
    },
    creatGoodsgrid: function(){//创建产品明细
        this.goodsGrid = Ext.create('Ext.grid.Panel', {
            id: "destPanel",
            title: '订单产品',
            height: 300,
            columns: this.cmlist,
            selModel: Ext.create('Ext.selection.CheckboxModel'),
            store: this.goodsstore,
            plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1
            })],
            viewConfig: {
                stripeRows: true, // 让基数行和偶数行的颜色不一样
                forceFit: true
            },
            border: true,
            iconCls: 'icon-grid',
            tbar: Ext.create('Ext.toolbar.Toolbar', {
                items: [{
                    xtype: 'button',
                    text: '新增产品',
                    id: 'addBtn',
                    iconCls: 'x-tbar-add',
                    handler: this.createWindow.bind(this, ['0'])
                }, {
                    xtype: 'button',
                    text: '编辑产品',
                    id: 'editBtn',
                    disabled: true,
                    iconCls: 'x-tbar-update',
                    handler: this.createWindow.bind(this, ['1'])
                }, {
                    text: '删除',
                    iconCls: 'x-tbar-del',
                    id: 'removeBtn',
                    handler: this.removeItem.bind(this),
                    disabled: true
                }]
            })
        });
    },
    creatItems: function(){
        this.items = [this.infopart, this.goodsGrid];
    },
    
    creatButtons: function(){
        this.buttons = [{
            text: '保存',
            type: 'submit',
            handler: this.formsubmit.bind(this)
        }, {
            text: '取消',
            handler: this.formreset.bind(this)
        }];
    },
    
    formsubmit: function(){
        var saveURL = this.saveURL;
        var addURL = this.addURL;
        if (this.getForm().isValid()) {
            var m = this.goodsstore.modified.slice(0);
            var thiz = this.goodsstore;
            var jsonArray = [];
            Ext.each(m, function(item){
                jsonArray.push(item.data);
            });
            if (jsonArray.length == 0) {
                //Ext.example.msg('提示','系统判断为采购单二次入库');
                Ext.each(thiz.data.items, function(item){
                    jsonArray.push(item.data);
                });
            }
            this.getForm().doAction('submit', {
                url: saveURL,
                method: 'post',
                params: {
                    'data': Ext.encode(jsonArray)
                },
                success: function(form, action){
                    if (action.result.success) {
                        Ext.example.msg('MSG', '订单编辑成功');
                        window.location.href = addURL + '&order_id=' + action.result.msg;
                    }
                    else {
                        Ext.Msg.alert('修改失败', action.result.msg);
                    }
                },
                failure: function(){
                    Ext.example.msg('ERROR', '订单编辑失败');
                }
            });
        }
        else {
            Ext.example.msg('ERROR', '请正确完成表单内容');
        }
    },
    
    formreset: function(){//表单重置
        this.form.reset();
    },
    
    addItem: function(p){//新增物品
        var me = this;
        if (!p) 
            var p = Ext.create(me.model, {
                rec_id: 0,
                goods_sn: '',
                item_no: '',
                goods_name: '',
                goods_qty: 1,
                goods_price: 0,
                amt: 0
            });
        this.goodsstore.insert(0, p);
        this.goodsGrid.plugins[0].startEditByPosition({
            row: 0,
            column: 0
        });
    },
    removeItem: function(){//移除物品
        var data = this.goodsGrid.getSelectionModel().getSelected().data;
        var index = this.goodsstore.findBy(function(record, id){
            return record.get('goods_id') == data.goods_id && record.get('goods_qty') == data.goods_qty;
        });
        var id = data.rec_id;
        if (id == 0) {
            this.goodsstore.remove(this.goodsstore.getAt(index));
            return;
        }
        var thiz = this.goodsstore;
        var delURL = this.delURL;
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn){
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: delURL + '&id=' + id,
                        success: function(response, opts){
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.remove(thiz.getAt(index));
                                Ext.example.msg('MSG', res.msg);
                            }
                            else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            }, this.goodsGrid);
        }
    },
    creatselectstore: function(){//订单明细store
        this.selectstore = Ext.create('Ext.data.Store', {
            fields: ['goods_id', 'goods_sn', 'SKU', 'goods_name', 'cost'],
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                extraParams: {                    /*cat_id:Ext.getCmp('cat_id').getValue(),
                     keyword:Ext.fly('keyword').dom.value*/
                },
                type: 'ajax',
                url: this.goodsgirdURL,
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    method: 'POST',
                    idProperty: 'goods_id',
                    root: 'topics'
                }
            }
        });
    },
    createWindow: function(num){//弹出产品选择窗口
        var selectstore = this.selectstore;
        var thiz = this;
        var selectstore = this.selectstore;
        var thiz = this;
        var Tree = Ext.tree;
        var tree = Ext.create('Ext.tree.Panel', {
            border: false,
            frame: true,
            title: '产品分类',
            region: 'west',
            width: '40%',
            id: 'west-panel',
            margins: '0 0 0 0',
            store: Ext.create('Ext.data.TreeStore', {
                proxy: {
                    type: 'ajax',
                    url: this.catTreeURL
                },
                root: {
                    text: '总类',
                    draggable: false,
                    expanded: true,
                    id: 'root'
                }
            }),
            collapsible: true,
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true
        });
        
        tree.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e){
            if (node.isLeaf()) {
                e.stopEvent();
                Ext.getCmp('cat_id').setValue(node.data.id);
                selectstore.load({
                    params: {
                        start: 0,
                        cat_id: node.data.id,
                        limit: 20
                    },
                    scope: this.store
                });
            }
        };
        var grid = Ext.create('Ext.grid.Panel', {
            store: this.selectstore,
            height: 400,
            region: 'center',
            autoScroll: true,
            columns: [{
                header: '产品编码',
                flex: 1,
                dataIndex: 'goods_sn'
            }, {
                header: 'SKU',
                flex: 1,
                dataIndex: 'SKU'
            }, {
                header: '产品名称',
                flex: 1,
                dataIndex: 'goods_name'
            }],
            tbar: Ext.create('Ext.toolbar.Toolbar', {
                items: ['<b>产品列表</b>', '->', '产品编码:', {
                    xtype: 'textfield',
                    name: 'keyword',
                    id: 'keyword',
                    width: 100,
                    enableKeyEvents: true,
                    listeners: {
                        scope: this,
                        keypress: function(field, e){
                            if (e.getKey() == 13) {
                                selectstore.load({
                                    params: {
                                        start: 0,
                                        limit: 20,
                                        keyword: Ext.getCmp('keyword').getValue(),
                                        cat_id: ''
                                    }
                                });
                            }
                        }
                    }
                }, {
                    xtype: 'hidden',
                    id: 'cat_id',
                    name: 'cat_id',
                    value: 0
                }, '-', {
                    xtype: 'button',
                    text: '搜索',
                    iconCls: 'x-tbar-search',
                    handler: function(){
                        //console.log(Ext.fly('keyword'));
                        selectstore.load({
                            params: {
                                start: 0,
                                limit: 20,
                                keyword: Ext.getCmp('keyword').getValue(),
                                cat_id: ''
                            }
                        });
                    }
                }]
            }),
            bbar: Ext.create('Ext.toolbar.Paging', {
                pageSize: 20,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store: this.selectstore
            }),
            viewConfig: {
                forceFit: true
            }
        });
        var win = Ext.create('Ext.window.Window', {
            closeAction: 'destroy',
            closable: true,
            width: 750,
            height: 400,
            layout: 'border',
            modal: false,
            items: [tree, grid]
        });
        if (!this.goodsGrid) 
            this.creatGoodsgrid();
        var goodsgrid = this.goodsGrid;
        var me = this;
        grid.on('itemclick', function(grid, record, item, rowIndex, e){
            var getinfo = selectstore.getAt(rowIndex);
            var p = Ext.create(me.model, {
                rec_id: 0,
                goods_sn: getinfo.get('goods_sn'),
                item_no: '',
                goods_name: getinfo.get('goods_name'),
                goods_qty: 1,
                goods_price: 0,
                amt: 0
            });
            if (num == 1) {
                var getSelect = goodsgrid.getSelectionModel().getSelection()[0];
                getSelect.set('goods_name', getinfo.get('goods_name'));
                getSelect.set('goods_sn', getinfo.get('goods_sn'));
            }
            else {
                thiz.addItem(p);
                Ext.getCmp('keyword').destroy();
            }
            win.hide();
        });
        win.show();
    }
});

