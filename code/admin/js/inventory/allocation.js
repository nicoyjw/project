Ext.define('Ext.ux.test.inventory.allocation', {//DBorderView
    extend: 'Ext.Viewport',
    initComponent: function(){
        this.layout = 'form';
        this.createStore();
        this.creatgoodsstore();
        this.createForm();
        this.createColumns();
        this.createTbar();
        this.creatselectionmodel();
        this.creatBbar();
        this.creatgrid();
        this.creatgoodsview();
        this.creatitems();
        this.grid.getSelectionModel().on('selectionchange', function(sm){
            Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('editBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('removeBtn1').setDisabled(sm.getCount() < 1);
            Ext.getCmp('peditBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('prtBtn').setDisabled(sm.getCount() < 1);
        });
        this.callParent();
    },
    createStore: function(){
        this.astore = Ext.create('Ext.data.Store', {
            fields: this.fields,
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listURL,
				actionMethods:{
					read: 'POST'
				},
                reader: {
                    type: 'json',
                    root: 'topics',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0]
                }
            }
        });
        this.astore.load({
            params: {
                 start: 0,
                 limit: this.pagesize
            },
            scope: this.astore
        });
         
    },
    createColumns: function(){
        var ds = this.astore;
        var addURL = this.addURL;
        var cols = [];
        cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length - 2; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            if (i == 1) {
                cols.push({
                    flex: 2,
                    header: h,
                    dataIndex: f,
                    renderer: function(val, x, rec){
                        var str = (rec.get('comment')) ? '<img src="themes/default/images/comment.gif" title="' + rec.get('comment') + '">' : '';
                        return '<b>' + val + '</b>' + str;
                    }
                });
            }
            else {
                cols.push({
                    flex: 1,
                    header: h,
                    dataIndex: f
                });
            }
        }
        cols.push({
            header: '操作',
            width: 45,
            xtype: 'actioncolumn',
            items: [{
                icon: 'themes/default/images/update.gif',
                tooltip: '编辑单据',
                handler: function(grid, rowIndex, colIndex){
                    var id = ds.getAt(rowIndex).get('order_id');
                    parent.newTab('99991', '编辑订单', addURL + '&order_id=' + id); 
                }
            }],
            renderer: function(v, m, rec){
                if (rec.get('realstatus') == 1 || rec.get('realstatus') == 3) {
                    this.items[0].iconCls = 'hidden';
                }
                else {
                    this.items[0].iconCls = '';
                }
            }
        });
        this.columns = cols;
    },
    createTbar: function(){
        var store = this.astore;
        var addURL = this.addURL;
        var pagesize = this.pagesize;
        this.tbar = [{
            text: '新建调拨',
            iconCls: 'x-tbar-add',
            ref: '../addBtn',
            handler: function(){
               parent.newTab('99992', '新建调拨单', addURL); 
            }
        }, {
            text: '确认在途',
            iconCls: 'x-tbar-save',
            ref: '../peditBtn',
            id: 'peditBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['3'])
        }, {
            text: '确认完成',
            iconCls: 'x-tbar-save',
            ref: '../editBtn',
            id: 'editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['1'])
        }, {
            text: '强制结单',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn1',
            id: 'removeBtn1',
            disabled: true,
            handler: this.updateRecord.bind(this, ['5'])
        }, {
            text: '删除单据',
            iconCls: 'x-tbar-del',
            id: 'removeBtn',
            ref: '../removeBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['2'])
        }, {
            text: '打印',
            iconCls: 'x-tbar-print',
            ref: '../prtBtn',
            id: 'prtBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['4'])
        }, '->', '-', '关键词:', {
            xtype: 'textfield',
            id: 'keyword',
            name: 'keyword'
        }, '-', {
            xtype: 'button',
            text: '搜索',
            iconCls: 'x-tbar-search',
            handler: function(){
                store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
                        keyword: Ext.getCmp('keyword').getValue(),
                    }
                });
            }
        }, '-', {
            xtype: 'button',
            text: '高级搜索',
            iconCls: 'x-tbar-advsearch',
            handler: this.showWindow.bind(this)
        }, '-', {
            xtype: 'button',
            text: '导出搜索',
            iconCls: 'x-tbar-import',
            handler: function(){
                var values = Ext.getCmp('searchform').getForm().getFieldValues();
                window.open().location.href = 'index.php?model=inventory&action=exportAllocation&keyword=' + Ext.fly('keyword').dom.value + '&starttime=' + values.starttime + '&totime=' + values.totime + '&db_status=' + values.db_status + '&depot_id_from=' + values.depot_id_from + '&depot_id_to=' + values.depot_id_to + '&first_shipping=' + values.first_shipping + '&db_shipping=' + values.db_shipping + '&key=' + values.keywords;
            }
        }];
    },
    getSelectedRecord: function(){
        var sm = this.grid.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        }
        else {
            return sm.getSelection()[0];
        }
    },
    updateRecord: function(str){
        var thiz = this.astore;
        var r = this.getSelectedRecord();
        if (r != false) {
            if (str == 4) {
                window.open(this.printURL + '&order_id=' + r.data.order_id);
                return false;
            }
            if (r.data.realstatus > 0 && str == 2) {
                Ext.Msg.confirm('操作提示!', '该订单已进行过处理,确定删除?', function(btn){
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: this.updateURL + '&order_id=' + r.data.order_id + '&status=' + str,
                            success: function(response, opts){
                                var res = Ext.decode(response.responseText);
                                if (res.success) {
                                    thiz.reload();
                                    Ext.Msg.alert('MSG', res.msg);
                                }
                                else {
                                    Ext.Msg.alert('ERROR', res.msg);
                                }
                            }
                        });
                    }
                }, this);
            }
            else {
                if (r.data.realstatus == 1 || (r.data.realstatus == 3 && str == 3)) {
                    Ext.example.msg('ERROR', '该单据已进行过处理');
                    return false;
                }
                Ext.Msg.confirm('操作提示!', '确定修改订单状态?', function(btn){
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: this.updateURL + '&order_id=' + r.data.order_id + '&status=' + str,
                            success: function(response, opts){
                                var res = Ext.decode(response.responseText);
                                if (res.success) {
                                    thiz.reload();
                                    Ext.Msg.alert('MSG', res.msg);
                                }
                                else {
                                    Ext.Msg.alert('ERROR', res.msg);
                                }
                            }
                        });
                    }
                }, this);
            }
        }
    },
    creatselectionmodel: function(){
        var me = this;
        var sm = Ext.create('Ext.selection.CheckboxModel', {            
		listeners:{
            "select": {
             fn: function(e, rowindex){
                    var id = rowindex.data.order_id;
                    me.goodsstore.proxy.extraParams = {
                        order_id: id,
                        start:0,
                        limit:10
                    };
                    me.goodsstore.load();
                }
            }    
        }	
        });
        this.sm = sm;
    },
    setid: function(id){
        this.selectid = id;
    },
    getid: function(id){
        return this.selectid;
    },
    creatBbar: function(){
        var pagesize = this.pagesize;
        this.bbar = Ext.create('Ext.toolbar.Paging',{
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store:this.astore
        });
    },
    creatgrid: function(){
        this.grid = Ext.create('Ext.grid.Panel', {
            loadMask: true,
            region: 'center', 
            frame:false,
            height: 250,
            autoScroll :true,
            store: this.astore,
            columns: this.columns,
            selModel: this.sm,
            tbar: this.tbar,
            bbar: this.bbar
        });
    },
    creatgoodsstore: function(){
        var thiz = this;
        this.goodsstore = Ext.create('Ext.data.JsonStore', {
            fields: ['rec_id', 'goods_qty', 'goods_id', 'goods_sn', 'goods_name', 'no', 'is_ok'],
            pageSize: this.pagesize,
            proxy: {
                type: 'ajax',
                url: this.goodsURL,
                actionMethods: {
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty: 'rec_id',
                    root: 'topics'
                }
            },
             listeners:{
                 load: function(){
                     var order_id = thiz.getid();
                     Ext.apply(this.baseParams,{
                        order_id:order_id
                     });
                 }
             }
        });
    },
    creatgoodsview: function(){
        var thiz = this;
        this.goodsview = Ext.create('Ext.grid.Panel', {
            store: this.goodsstore,
            autoWidth: true,
            loadMask: true,
            height: 250,
            region: 'south',
            title: '单据明细',
            autoScroll: true,
            selModel: Ext.create('Ext.selection.CheckboxModel'),
            columns: [{
                header: '产品编码',
                flex: 1,
                dataIndex: 'goods_sn'
            }, {
                header: '产品名称',
                width: 300,
                dataIndex: 'goods_name'
            }, {
                header: '产品数量',
                flex: 1,
                dataIndex: 'goods_qty'
            }, {
                header: '箱号',
                flex: 1,
                dataIndex: 'no'
            }, {
                header: '状态',
                flex: 1,
                dataIndex: 'is_ok',
                renderer: function(v){
                    if (v == 0) 
                        return '未到货';
                    if (v == 1) 
                        return '已到货';
                    if (v == 2) 
                        return '已报损';
                }
            }],
            bbar: Ext.create('Ext.toolbar.Paging',{
                pageSize: 10,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store:thiz.goodsstore,
                items: ['-', {
                    text: '确认到货',
                    iconCls: 'x-tbar-save',
                    handler: this.updatestatus.bind(this)
                }]
            })   
        });
    },
    updatestatus: function(){
        var ids = getIds(this.goodsview);
        var updateurl = this.updategoodsURL;
        var thiz = this.astore;
        var goodsstore = this.goodsstore;
        if (!ids) 
            return false;
        Ext.getBody().mask("Updating Data .waiting...", "x-mask-loading");
        Ext.Ajax.request({
            url: updateurl,
            success: function(response){
                Ext.example.msg('提示', response.responseText);
                thiz.reload();
                goodsstore.reload();
                Ext.getBody().unmask();
            },
            failure: function(response){
                Ext.example.msg('警告', '确认到货失败');
                Ext.getBody().unmask();
            },
            params: {
                id: ids
            }
        });
    },
    creatitems: function(){
        return this.items = [this.grid, this.goodsview];
    },
    showWindow: function(){
        this.getWindow().show();
    },
    
    hideWindow: function(){
        this.getWindow().hide();
    },
    
    getWindow: function(){
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow();
        }
        return this.gridWindow;
    },
    
    createWindow: function(){
        var formPanel = this.getFormPanel();
        
        var win = Ext.create('Ext.window.Window', {
            id: 'searchwin',
            title: this.windowTitle,
            closeAction: 'hide',
            width: this.windowWidth,
            height: this.windowHeight,
            modal: true,
            items: [formPanel]
        });
        return win;
    },
    getFormPanel: function(){
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },
    createForm: function(){
        var store = this.astore;
        var status = this.status;
        var db_shipping = this.db_shipping;
        var depot = this.depot;
        var first_shipping = this.first_shipping;
        var pagesize = this.pagesize;
        var form = Ext.create('Ext.form.Panel', {
			bodyStyle:'padding:10px',
            frame: false,
			border:false,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            id: 'searchform',
            trackResetOnLoad: true,
            items: [            
			{
             xtype:'combo',
             store: Ext.create('Ext.data.ArrayStore',{
             fields: ["id", "key_type"],
             data: status
             }),
             valueField :"id",
             displayField: "key_type",
             mode: 'local',
             labelWidth:75,
             width:250,
             editable: false,
             forceSelection: true,
             triggerAction: 'all',
             hiddenName:'db_status',
             name: 'db_status',
             value:'99',
             allowBlank:false,
             fieldLabel: '状态',
             id:'status'
             },{
             xtype:'datefield',
             name:'starttime',
             labelWidth:75,
             width:250,
             format:'Y-m-d',
             fieldLabel:'From'
             },{
             xtype:'datefield',
             name:'totime',
             labelWidth:75,
             width:250,
             format:'Y-m-d',
             fieldLabel:'To'
             },{
             xtype:'combo',
             store: Ext.create('Ext.data.ArrayStore',{
             fields: ["id", "key_type"],
             data: first_shipping
             }),
             valueField :"id",
             displayField: "key_type",
             mode: 'local',
             editable: false,
             forceSelection: true,
             triggerAction: 'all',
             labelWidth:75,
             width:250,
             hiddenName:'first_shipping',
			 name:'first_shipping',
             value:'99',
             fieldLabel: '头程渠道',
             allowBlank:false,
             id:'firstshipping'
             },{
             xtype:'combo',
             store: Ext.create('Ext.data.ArrayStore',{
             fields: ["id", "key_type"],
             data: db_shipping
             }),
             valueField :"id",
             displayField: "key_type",
             mode: 'local',
             editable: false,
             forceSelection: true,
             triggerAction: 'all',
             labelWidth:75,
             width:250,
             value:'99',
             hiddenName:'db_shipping',
			 name:'db_shipping',
             fieldLabel: '物流方式',
             allowBlank:false,
             id:'shipping'
             },{
             xtype:'combo',
             store: Ext.create('Ext.data.ArrayStore',{
             fields: ["id", "key_type"],
             data: depot
             }),
             valueField :"id",
             displayField: "key_type",
             mode: 'local',
             editable: false,
             forceSelection: true,
             triggerAction: 'all',
             labelWidth:75,
             width:250,
             value:'99',
             hiddenName:'depot_id_from',
			 name:'depot_id_from',
             fieldLabel: '调出仓',
             labelWidth:75,
             width:250,
             allowBlank:false,
             id:'depot_from'
             },{
             xtype:'combo',
             store: Ext.create('Ext.data.ArrayStore',{
             fields: ["id", "key_type"],
             data: depot
             }),
             valueField :"id",
             displayField: "key_type",
             mode: 'local',
             editable: false,
             forceSelection: true,
             triggerAction: 'all',
             labelWidth:75,
             width:250,
             value:'99',
             hiddenName:'depot_id_to',
			 name:'depot_id_to',
             fieldLabel: '调入仓',
             allowBlank:false,
             id:'depot_to'
             },{
             name:'keywords',
             fieldLabel: '关键词',
			 xtype:'textfield',
             value:'',
             labelWidth:75,
             width:250,
             enableKeyEvents:true,
             listeners:{
             scope:this,
             keypress:function(field,e){
             if(e.getKey()==13){
             Ext.fly('keyword').dom.value = '';
             var values = Ext.getCmp('searchform').getForm().getFieldValues();
             store.load({params:{start:0, limit:pagesize,
                 keyword:Ext.getCmp('keyword').getValue(),
                 db_status:values.db_status,
                 starttime:values.starttime,
                 totime:values.totime,
                 depot_id_from:values.depot_id_from,
                 depot_id_to:values.depot_id_to,
                 first_shipping:values.first_shipping,
                 db_shipping:values.db_shipping,
                 key:values.keywords
             }});
             Ext.getCmp('searchwin').hide();
             }
             }
             }
             }
            ],
            buttons: [{
                text: 'submit',
                handler: function(){
                    Ext.fly('keyword').dom.value = '';
                    var values = Ext.getCmp('searchform').getForm().getFieldValues();
                    store.load({
                        params: {
                            start: 0,
                            limit: pagesize,
                            keyword:Ext.getCmp('keyword').getValue(),
                            db_status: values.db_status,
                            starttime: values.starttime,
                            totime: values.totime,
                            depot_id_from: values.depot_id_from,
                            depot_id_to: values.depot_id_to,
                            first_shipping: values.first_shipping,
                            db_shipping: values.db_shipping,
                            key: values.keywords
                        }
                    });
                    Ext.getCmp('searchwin').hide();
                }
            }, {
                text: 'reset',
                handler: function(){
                    form.getForm().reset();
                }
            }]
        });
        return form;
    }
});
