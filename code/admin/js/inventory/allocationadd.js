Ext.define('Ext.ux.test.inventory.allocationadd', {//BillForm
    extend: 'Ext.form.Panel',
    initComponent: function(){
        this.frame = true,
        this.buttonAlign = 'center',
        this.autoHeight = 'true';
        this.buttonAlign = 'center', this.txt_totQty = new Ext.form.TextField({
            id: 'txt_totQty',
            anchor: '95%',
            allowBlank: true,
            value: 0,
            readOnly: true,
            fieldClass: 'textReadOnly'
        });
        this.creatGoodsstore();
        this.creatoperatorstore();
        this.creatselectstore();
        this.creatinfopart();
        this.creatGridcm();
        this.creatGoodsgrid();
        this.creatItems();
        this.creatButtons();
        this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
            Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
        });
        this.callParent();
    },
    creatoperatorstore: function(){//操作员明细
        var operator_id = this.order.operator_id;
        this.operatorstore = Ext.create('Ext.data.Store', {
            autoLoad: true,
            fields: ['user_id', 'user_name'],
            proxy: {
                type: 'ajax',
                url: this.listUserURL,
                reader: {
                    type: 'json',
                    root: 'topics',
                    method: 'POST',
                    totalProperty: 'totalCount',
                    idProperty: 'user_id'
                }
            },
            listeners: {
                load: function(store, record, success){
                    if (success) 
                        Ext.getCmp('operator_id').setValue(operator_id);
                }
            }
        });
    },
    creatinfopart: function(){//基本信息
        var me = this;
    this.infopart = new Ext.form.FieldSet({
            title: '调拨单信息',
            layout:'column',
            margin: '5px 10px 0px 10px',
            layout: 'column',
            items: [
            {
                columnWidth: .3,
                border:false,
                items: [{
                    xtype: 'combo',
                    store: me.operatorstore,
                    valueField: "user_id",
                    displayField: "user_name",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    hiddenName: 'operator_id',
                    triggerAction: 'all',
                    fieldLabel: '操作员',
                    allowBlank: false,
                    pagesise: 10,
                    width:250,
                    labelWidth:65,
                    value: this.order.operator_id,
                    id: 'operator_id',
                    name:'operator_id'
                }, {
                    xtype: 'textfield',
                    fieldLabel: '订单备注',
                    width:250,
                    labelWidth:65,
                    value: this.order.comment,
                    id: 'comment',
                    name: 'comment'
                }, {
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.first_shipping
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    hiddenName: 'first_shipping',
                    triggerAction: 'all',
                    fieldLabel: '头程渠道',
                    allowBlank: false,
                    pagesise: 10,
                    width:250,
                    labelWidth:65,
                    value: this.order.first_shipping,
                    id: 'first_shipping',
                    name: 'first_shipping'
                }, {
                    xtype: 'textfield',
                    fieldLabel: '追踪单号',
                    value: this.order.track_no,
                    id: 'track_no',
                    width:250,
                    labelWidth:65,
                    name: 'track_no'
                }]
            }, {
                columnWidth: .3,
                border:false,
                style:'margin-left:25px;',
                items: [{
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
                    hiddenName: 'depot_id_from',
                    triggerAction: 'all',
                    fieldLabel: '调出仓',
                    allowBlank: false,
                    pagesise: 10,  
                    width:250,
                    labelWidth:65,
                    value: this.order.depot_id_from,
                    name: 'depot_id_from',
                    id: 'depot_from'
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
                    hiddenName: 'depot_id_to',
                    triggerAction: 'all',
                    fieldLabel: '调入仓',
                    allowBlank: false,
                    pagesise: 10, 
                    width:250,
                    labelWidth:65,
                    value: this.order.depot_id_to,
                    name: 'depot_id_to',
                    id: 'depot_to'
                }, {
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.db_shipping
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    editable: false,
                    forceSelection: true,
                    hiddenName: 'db_shipping',
                    triggerAction: 'all',
                    fieldLabel: '货运方式',
                    allowBlank: false,
                    pagesise: 10,
                    width:250,
                    labelWidth:65,
                    value: this.order.db_shipping,
                    name: 'db_shipping',
                    id: 'db_shipping'
                }]
            }, {
                columnWidth: .3,
                border:false,
                style:'margin-left:25px;',
                items: [{
                    xtype: 'combo',
                    store: Ext.create('Ext.data.ArrayStore', {
                        fields: ["id", "key_type"],
                        data: this.orderstatus
                    }),
                    valueField: "id",
                    displayField: "key_type",
                    mode: 'local',
                    width:250,
                    labelWidth:65,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName: 'status',
                    value: this.order.status ? this.order.status : '0',
                    allowBlank: false,
                    fieldLabel: '订单状态',
                    name: 'status',
                    id: 'status'
                }, {
                    xtype: 'textfield',
                    fieldLabel: '箱数',
                    width:250,
                    labelWidth:65,
                    value: this.order.count,
                    name: 'count',
                    id: 'count'
                }, {
                    xtype: 'textfield',
                    fieldLabel: '重量',
                    width:250,
                    labelWidth:65,
                    value: this.order.weight,
                    name: 'weight',
                    id: 'weight'
                }, {
                    fieldLabel: '订单编码',
                    id: 'order_sn',
                    width:250,
                    labelWidth:65,
                    value: this.order.order_sn,
                    name: 'order_sn',
                    xtype: 'hidden'
                }, {
                    fieldLabel: '订单号',
                    id: 'order_id',
                    width:250,
                    labelWidth:65,
                    value: this.order.order_id,
                    name: 'order_id',
                    xtype: 'hidden'
                }]
            }]
        });
        /*var Item = Ext.create([{
         id: 'supplier',
         name: 'supplier_name'
         }]);
         if (this.order.supplier && this.inout == 1) {
         var p = new Item({
         id: this.order.supplier,
         name: this.order.supplier_name
         });
         this.Supplierstore.add(p);
         Ext.getCmp('supplier_id').setValue(this.order.supplier);
         }*/
    },
    
    creatGoodsstore: function(){//订单明细store
    
        this.model = Ext.define('goosmdoel',{
                extend:'Ext.data.Model',
                fields:[
                {name:'rec_id'},
                {name:'goods_id'},
                {name:'goods_sn'},
                {name:'goods_name'},
                {name:'goods_qty'},
                {name:'no'},
                ]
            })
        this.goodsstore = Ext.create('Ext.data.JsonStore', { 
            fields:['rec_id','goods_id','goods_sn','goods_name','goods_qty','no'],
            proxy: {
                type: 'ajax',
                url: this.goodsURL,
                actionMethods:{
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty:'rec_id',
                    root: 'topics'
                }
            },
            listeners : {
                'load' : this.calculate.bind(this),
                'add' : this.calculate.bind(this),
                'remove' : this.calculate.bind(this),
                'update' : this.calculate.bind(this)
            }
        })
        this.goodsstore.load({params : {
            order_id : this.order.order_id}
        });
    },
    
    creatGridcm: function(){
        var thiz = this;
    },
    checkItem: function(value){
        if (value == '') 
            return false;
        var store = this.goodsstore;
        var thiz = this;
        var mk = new Ext.LoadMask(Ext.getBody(), {
            msg: '正在获取数据，请稍候！',
            removeMask: true //完成后移除
        });
        mk.show();
        Ext.Ajax.request({
            url: 'index.php?model=goods&action=getgoods',
            timeout: 180000,
            loadMask: true,
            success: function(response){
                var res = response.responseText.split('|');
                if (res[0] == 0) {
                    Ext.example.msg('提示', '找不到对应的产品');
                }
                else {
                    var index = store.findBy(function(record, id){
                        return record.get('goods_sn') == value && record.get('goods_id') == 0;
                    });
                    var record = store.getAt(index);
                    if (record) {
                        record.set('goods_id', res[1]);
                        record.set('goods_name', res[2]);
                        thiz.addItem();
                    }
                }
                mk.hide();
            },
            failure: function(response){
                if (reqst == '-1') {
                    Ext.example.msg('警告', '获取产品信息超时退出');
                }
                else {
                    Ext.example.msg('警告', '获取产品信息失败');
                }
                mk.hide();
            },
            params: {
                sku: value
            }
        });
    },
    creatGoodsgrid: function(){//创建产品明细
        var me = this;
        this.goodsGrid = Ext.create('Ext.grid.Panel', {
            id: "destPanel",
            title: '单据产品明细',
            height: 300,
            columns: [{
                header: '产品编码<font color=red>*</font>',
                dataIndex: 'goods_sn',
                flex:1,
                align: 'left'
            }, {
                header: '产品名称<font color=red>*</font>',
                flex:2,
                dataIndex: 'goods_name',
                align: 'left'
            }, {
                header: '产品数量<font color=red>*</font>',
                dataIndex: 'goods_qty',
                flex:1,
                align: 'center',
                editor: new Ext.form.NumberField({
                    allowBlank: false,
                    allowNegative: false,
                    decimalPercision: 4,
                    style: 'text-align:left'
                })
            }, {
                header: '箱号',
                flex:1,
                dataIndex: 'no',
                align: 'center',
                editor:{
                    xtype:'numberfield',
                    allowBlank:false,
                    minValue:0,
                    decimalPercision:4,
                    style:'text-align:left'
                }
            }],
            selModel: Ext.create('Ext.selection.CheckboxModel'),
            store: me.goodsstore,
            plugins:[Ext.create('Ext.grid.plugin.CellEditing',{
                clicksToEdit: 1
            })],
            viewConfig : {
                stripeRows : true, // 让基数行和偶数行的颜色不一样
                forceFit : true
            },
            border: true,
            iconCls: 'icon-grid',
            tbar: Ext.create('Ext.toolbar.Toolbar',{
                items: [{
                    xtype: 'button',
                    text: '新增产品',
                    id: 'addBtn',
                    iconCls: 'x-tbar-add',
                    handler: this.createWindow.bind(this, ['0'])
                }, {
                    text: '删除',
                    iconCls: 'x-tbar-del',
                    id: 'removeBtn',
                    handler: this.removeItem.bind(this),
                    disabled: true
                }]
            }),
            bbar: Ext.create('Ext.toolbar.Toolbar',{
                cls: 'u-toolbar-b',
                items: ['合计:', '->', '数量:', this.txt_totQty]
            })
        });
    },
    
    creatItems: function(){
        this.items = [{
                width:60,
                border:false,
                frame:false,
                items:[{
                    xtype:'button',
                    text: '保存',
                    handler:this.formsubmit.bind(this)
                }]
                },this.infopart, this.goodsGrid];
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
        if (this.txt_totQty.getValue() == 0) {
            Ext.example.msg('错误提示', '商品数量不能为空');
            return false;
        }
        if (Ext.getCmp('depot_to').getValue() == Ext.getCmp('depot_from').getValue()) {
            Ext.example.msg('错误提示', '调入仓和调出仓不能相同');
            return false;
        }
        if (this.getForm().isValid()) {
            
            var m = this.goodsstore.getModifiedRecords().slice(0);
                var thiz = this.goodsstore;
                var jsonArray = [];
                Ext.each(m,function(item){
                    jsonArray.push(item.data);                
                    });
                    Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
            
            
            
            var m = this.goodsstore.getModifiedRecords().slice(0);
            var thiz = this.goodsstore;
            var jsonArray = [];
            Ext.each(m, function(item){
                jsonArray.push(item.data);
            });
            this.getForm().doAction('submit', {
                url: saveURL,
                method: 'post',
                params: {
                    'data': Ext.encode(jsonArray)
                },
                success: function(form, action){
                    if (action.result.success) {
                        Ext.example.msg('MSG', '单据编辑成功');
                        window.location.href = addURL + '&order_id=' + action.result.msg;
                    }
                    else {
                        Ext.Msg.alert('修改失败', action.result.msg);
                    }
                },
                failure: function(){
                    Ext.example.msg('ERROR', '单据编辑失败');
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
        if(!p) var p = Ext.create(me.model,{rec_id:0,goods_sn:'',goods_name:'',goods_qty:1,no:''});
        this.goodsstore.insert(0, p);
        this.goodsGrid.plugins[0].startEditByPosition({row:0,column:0});
    },
    removeItem: function(){//移除物品
        var data = this.goodsGrid.getSelectionModel().getSelection()[0].data;
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
        this.selectstore = Ext.create('Ext.data.JsonStore', {
            fields:['goods_id','goods_sn','SKU','goods_name'],
            baseParams : {
                cat_id : ''
            },
            proxy: {
                type: 'ajax',
                url:this.goodsgirdURL,
                actionMethods:{
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty:'goods_id',
                    root: 'topics'
                }
            }
        });
        this.selectstore.load({
            params:{start:0,limit:20},
            scope:this.selectstore
            });
        this.selectstore.on('beforeload',function(){
            Ext.apply(
            this.baseParams,
            {
                cat_id:Ext.getCmp('cat_id').getValue(),
                keyword:Ext.getCmp('keyword').getValue()
            });
        });
    },
    /*createWindow: function(num){//弹出产品选择窗口
        var selectstore = this.selectstore;
        var thiz = this;
        var tree = Ext.create('Ext.tree.Panel', {
            border: true,
            id: 'west-panel',
            margins: '0 0 0 0',
            //layout: 'accordion',
            title: '产品分类',
            collapsible: true,
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true,
            store: Ext.create('Ext.data.TreeStore', {
                useArrows: true,
                proxy: {
                    type: 'ajax',
                    url: thiz.catTreeURL,
                    reader: {
                        type: 'json',
                        root: 'children'
                    }
                },
                root: {
                    text: '总类',
                    draggable: false,
                    id: 'root'
                }
            })
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
                    scope: this.selectstore
                });
            }
        };
        var grid = Ext.create('Ext.grid.Panel', {
            title: '产品列表',
            store: thiz.selectstore,
            height: 500,
            autoScroll: true,
            columns: [{
                header: '产品编码',
                dataIndex: 'goods_sn'
            }, {
                header: 'SKU',
                dataIndex: 'SKU'
            }, {
                header: '产品名称',
                dataIndex: 'goods_name'
            }],
            tbar: new Ext.Toolbar({
                items: ['<b>产品列表</b>', '->', '产品编码:', new Ext.form.TextField({
                    name: 'keyword',
                    id: 'keyword',
                    enableKeyEvents: true,
                    listeners: {
                        scope: this,
                        keypress: function(field, e){
                            if (e.getKey() == 13) {
                                selectstore.load({
                                    params: {
                                        start: 0,
                                        limit: 20,
                                        keyword: Ext.fly('keyword').dom.value,
                                        cat_id: ''
                                    }
                                });
                            }
                        }
                    }
                }),{xtype:'hidden',id:'cat_id',name:'cat_id',value:0}, '-', {
                    xtype: 'button',
                    text: '搜索',
                    iconCls: 'x-tbar-search',
                    handler: function(){
                        selectstore.load({
                            params: {
                                start: 0,
                                limit: 20,
                                keyword: Ext.fly('keyword').dom.value,
                                cat_id: ''
                            }
                        });
                    }
                }]
            }),
            bbar: new Ext.PagingToolbar({
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
            title: '产品列表',
            closeAction: 'hide',
            closable: true,
            width: 600,
            height: 530,
            border: 0,
            y: 20,
            layout: 'column',
            modal: true,
            items: [{
                columnWidth: 0.3,
                border: 0,
                items: [tree]
            }, {
                columnWidth: 0.7,
                border: 0,
                items: [grid]
            }]
        }).show();
        Ext.define('Item', {
            extend: 'Ext.data.Model',
            fields: [{
                name: 'rec_id',
                type: 'float'
            }, {
                name: 'goods_sn'
            }, {
                name: 'goods_id',
                type: 'float'
            }, {
                name: 'goods_name'
            }, {
                name: 'goods_qty',
                type: 'float'
            }, {
                name: 'num'
            }]
        });
        
        if (!this.goodsGrid) 
            this.creatGoodsgrid();
        var goodsgrid = thiz.goodsGrid;
        grid.on('rowclick', function(grid, rowIndex, e){
            var getinfo = selectstore.getAt(rowIndex);
            var p = Ext.create('Item', {
                rec_id: 0,
                goods_sn: getinfo.get('goods_sn'),
                goods_id: getinfo.get('goods_id'),
                goods_name: getinfo.get('goods_name'),
                goods_qty: 0
            });
            if (num == 1) {
                var getSelect = goodsgridgetSelectionModel().getSelection();
                getSelect.set('goods_name', getinfo.get('goods_name'));
                getSelect.set('goods_id', getinfo.get('goods_id'));
                getSelect.set('goods_sn', getinfo.get('goods_sn'));
            }
            else {
                thiz.addItem(p);
                Ext.getCmp('keyword').destroy();
            }
            win.hide();
        });
    },*/
    createWindow: function(num) {//弹出产品选择窗口
        var selectstore = this.selectstore;
        var thiz = this;
        var Tree = Ext.tree;
        var tree = Ext.create('Ext.tree.Panel',{
            border:false,
            frame:true,
            title:'产品分类',
            region:'west',
            width:'40%',
            id:'west-panel',
            margins:'0 0 0 0',
            store: Ext.create('Ext.data.TreeStore', {
                 proxy: {
                    type: 'ajax',
                    url:this.catTreeURL
                },
                root:{
                    text: '总类',
                    draggable:false,
                    expanded:true,
                    id:'root'
                }
            }),
            collapsible :true,
            layoutConfig:{
                animate:true
            },
            rootVisible:false,
            autoScroll:true
        });
            
        tree.on('itemclick',treeClick);
        function treeClick(view,node,item,index,e) {
             if(node.isLeaf()){
                e.stopEvent();
                Ext.getCmp('cat_id').setValue(node.data.id);
                selectstore.load({
                    params:{start:0,cat_id:node.data.id,limit:20},
                    scope:this.store
                    });
             }
        };
        var grid = Ext.create('Ext.grid.Panel',{
            store:selectstore,
            height:400,
            region:'center',
            autoScroll:true,
            columns: [
                {header:'产品编码',flex:1,dataIndex:'goods_sn'},
                {header:'SKU',flex:1,dataIndex:'SKU'},
                {header:'产品名称',flex:1,dataIndex:'goods_name'}
            ],
            tbar:Ext.create('Ext.toolbar.Toolbar',{
                        items:['产品列表',
                               '->','产品编码:',
                               {
                                xtype:'textfield',
                                    name:'keyword',
                                    id:'keyword',
                                    width:100,
                                    enableKeyEvents:true,
                                    listeners:{
                                        scope:this,
                                        keypress:function(field,e){
                                                if(e.getKey()==13){
                                                    selectstore.load({params:{start:0, limit:20,
                                                        keyword:Ext.getCmp('keyword').getValue(),
                                                        cat_id:''
                                                        }});
                                                }
                                            }
                                    }
                                },{xtype:'hidden',id:'cat_id',name:'cat_id',value:0},
                                '-',{
                                    xtype:'button',
                                    text:'搜索',
                                    iconCls:'x-tbar-search',
                                    handler:function(){
                                        //console.log(Ext.fly('keyword'));
                                        selectstore.load({params:{start:0, limit:20,
                                            keyword:Ext.getCmp('keyword').getValue(),
                                            cat_id:''
                                            }});
                                        }
                                }
                            ]}),
            bbar:Ext.create('Ext.toolbar.Paging',{
                pageSize: 20,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store:selectstore
            }),
            viewConfig: {
                forceFit: true
            }
        });
        var win = Ext.create('Ext.window.Window',{
            closeAction: 'destroy',
            closable:true,
            width:900,
            height:400,
            layout:'border',
            modal: false,
            items: [tree,grid]
        });
        Ext.define('Item', {
            extend: 'Ext.data.Model',
            fields: [{
                name: 'rec_id',
                type: 'float'
            }, {
                name: 'goods_sn'
            }, {
                name: 'goods_id',
                type: 'float'
            }, {
                name: 'goods_name'
            }, {
                name: 'goods_qty',
                type: 'float'
            }, {
                name: 'num'
            }]
        });
        
        if (!this.goodsGrid) 
            this.creatGoodsgrid();
            var goodsgrid = this.goodsGrid;
            var me = this;
            grid.on('itemclick', function(grid,record,item, rowIndex, e) {
            var getinfo = selectstore.getAt(rowIndex);
            var p = Ext.create('Item', {
                rec_id: 0,
                goods_sn: getinfo.get('goods_sn'),
                goods_id: getinfo.get('goods_id'),
                goods_name: getinfo.get('goods_name'),
                goods_qty: 0
            });
            if(num == 1) {
                
                var getSelect = goodsgridgetSelectionModel().getSelection()[0];
                getSelect.set('goods_name', getinfo.get('goods_name'));
                getSelect.set('goods_id', getinfo.get('goods_id'));
                getSelect.set('goods_sn', getinfo.get('goods_sn'));
            }
            else {
                thiz.addItem(p);
                Ext.getCmp('keyword').destroy();
            }
            win.hide();
        });
        /*if(!this.goodsGrid) this.creatGoodsgrid();
        var goodsgrid = this.goodsGrid;
        var me = this;
        grid.on('itemclick', function(grid,record,item, rowIndex, e) {
            var getinfo = selectstore.getAt(rowIndex);
            var p = Ext.create(me.model,{rec_id:0,goods_sn:getinfo.get('goods_sn'),goods_name:getinfo.get('goods_name'),goods_qty:1,num:1});
            
            if(num == 1) {
                var getSelect = goodsgrid.getSelectionModel().getSelection()[0];
                getSelect.set('goods_name',getinfo.get('goods_name'));
                getSelect.set('goods_sn',getinfo.get('goods_sn'));
            }
            else {
                thiz.addItem(p);
                Ext.getCmp('keyword').destroy();
            }
            win.hide();
        });*/
        win.show();
    },
    calculate: function(){//计算物品总数量和总金额
        var i;
        var totalQty = 0;
        var totalAmt = 0;
        for (i = 0; i < this.goodsstore.getCount(); i++) {
            totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
        }
        this.txt_totQty.setValue(totalQty / 10000);
    }
});

