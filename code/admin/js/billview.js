Ext.define('Ext.ux.test.billview', {//BillView
    extend: 'Ext.Viewport',
    initComponent: function(){
        this.layout = 'border';
        this.createStore();
        this.creatgoodsstore();
        this.createColumns();
        this.createTbar();
        this.selectid = '';
        this.creatBbar();
        this.creatgrid();
        this.creatgoodsview();
        this.creatitems();
        this.grid.getSelectionModel().on('selectionchange', function(sm){
            Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('editBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('delBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('prtBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('prtlbl').setDisabled(sm.getCount() < 1);
        });
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
                reader: {
                    type: 'json',
                    root: 'topics',
                    method: 'POST',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0]
                }
            }
        });
    },
    createColumns: function(){
        var ds = this.store;
        var addURL = this.addURL;
        var thiz = this;
        var cols = [];
        cols.push({
            xtype: 'rownumberer'
        });
        for (var i = 1; i < this.fields.length - 2; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            if (i == 4) {
                cols.push({
                    flex: 1,
                    header: h,
                    hidden: (thiz.action[0] == 0) ? true : false,
                    dataIndex: f
                });
            }
            else 
                if (i == 1) {
                    cols.push({
                        flex: 1,
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
                    parent.openWindow(id, '编辑单据', addURL + '&order_id=' + id, 1000, 540);
                }
            }],
            renderer: function(v, m, rec){
                if (rec.get('realstatus') == 1) {
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
        var store = this.store;
        var addURL = this.addURL;
        var pagesize = this.pagesize;
        var listURL = this.listURL;
        this.tbar = [{
            text: '新建',
            iconCls: 'x-tbar-add',
            ref: '../addBtn',
            handler: function(){
                parent.openWindow('', '新建单据', addURL, 1000, 540);
            }
        }, {
            text: '确认',
            iconCls: 'x-tbar-save',
            ref: '../editBtn',
            id: 'editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['1'])
        }, {
            text: '取消',
            iconCls: 'x-tbar-update',
            ref: '../removeBtn',
            id: 'removeBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['2'])
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../delBtn',
            id: 'delBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['3'])
        }, {
            text: '打印',
            iconCls: 'x-tbar-print',
            ref: '../prtBtn',
            id: 'prtBtn',
            disabled: true,
            handler: this.updateRecord.bind(this, ['4'])
        }, {
            text: '打印产品标签',
            iconCls: 'x-tbar-print',
            id: 'prtlbl',
            ref: '../prtlbl',
            disabled: true,
            handler: this.updateRecord.bind(this, ['5'])
        }, '->', 'From:', {
            xtype: 'datefield',
            name: 'starttime',
			width:80,
            id: 'starttime',
            format: 'Y-m-d'
        }, '-', 'To:', {
            xtype: 'datefield',
            name: 'totime',
            id: 'totime',
			width:80,
            format: 'Y-m-d'
        }, '-', '关键词:', {
            xtype: 'textfield',
            id: 'keyword',
			width:80,
            name: 'keyword'
        }, '-', {
            xtype: 'button',
            text: '搜索',
			width:80,
            iconCls: 'x-tbar-search',
            handler: function(){
                store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
                        keyword: Ext.getCmp('keyword').getValue(),
                        starttime: Ext.getCmp('starttime').getValue(),
                        totime: Ext.getCmp('totime').getValue()
                    }
                });
            }
        }, '-', {
            text: '导出',
            xtype: 'button',
            iconCls: 'x-tbar-import',
            handler: function(){
                window.open().location.href = listURL + '&type=export&starttime=' + Ext.getCmp('starttime').getValue() + '&totime=' + Ext.getCmp('totime').getValue() + '&keyword=' + Ext.getCmp('keyword').getValue();
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
        var thiz = this.store;
        var r = this.getSelectedRecord();
        if (str == 4) {
            window.open(this.printURL + '&order_id=' + r.data.order_id);
            return false;
        }
        if (str == 5) {
            window.open(this.printURL + '&type=1&order_id=' + r.data.order_id);
            return false;
        }
        if (r.data.realstatus > 0 && str != 3) {
            Ext.example.msg('ERROR', '该单据已进行过处理');
            return false;
        }
        if (r != false) {
            Ext.Msg.confirm('操作提示!', '确定进行订单处理?', function(btn){
                if (btn == 'yes') {
                    Ext.getBody().mask("正在提交数据.请稍等...", "x-mask-loading");
                    Ext.Ajax.request({
                        url: this.updateURL + '&order_id=' + r.data.order_id + '&status=' + str,
                        success: function(response, opts){
                            Ext.getBody().unmask();
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.reload();
                                Ext.example.msg('MSG', res.msg);
                            }
                            else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            }, this);
        }
    },
    setid: function(id){
        this.selectid = id;
    },
    getid: function(id){
        return this.selectid;
    },
    creatBbar: function(){
        var pagesize = this.pagesize;
        this.bbar = [{
            xtype: 'pagingtoolbar',
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store
        }];
    },
    creatgrid: function(){
		var thiz = this;
        this.grid = new Ext.grid.GridPanel({
            frame: false,
            height: 500,
            viewConfig: {
                loadMask: true,
            },
            border:false,
            region: 'center',
            store: this.store,
            columns: this.columns,
            selModel: Ext.create('Ext.selection.CheckboxModel'),
            tbar: this.tbar,
            listeners: {
                "select": {
                    fn: function(e, rowindex){
                        var id = rowindex.data.order_id;
                        thiz.goodstore.proxy.extraParams = {
                            order_id: id,
							start:0,
							limit:10
                        };
                        thiz.goodstore.load();
                    }
                }
            },
            bbar: this.bbar
        });
    },
    creatgoodsstore: function(){
        var thiz = this;
        this.goodstore = Ext.create('Ext.data.Store', {
            fields: ['rec_id', 'goods_qty', 'goods_id', 'goods_sn', 'goods_name', 'goods_price', 'relate_order_sn', 'remark', {
                name: 'amt',
                convert: function(v, rec){
                    return rec[2] * rec[3];
                }
            }],
            proxy: {
                extraParams: {order_id: thiz.getid()
}                ,
                type: 'ajax',
                url: this.goodsURL,
				actionMethods:{
					read: 'POST'
				},
                reader: {
                    type: 'json',
                    root: 'topics',
                    method: 'POST',
                    totalProperty: 'totalCount',
                    idProperty: 'rec_id'
                }
            }
        });
    },
    creatgoodsview: function(){
        var thiz = this;
        this.goodsview = new Ext.grid.GridPanel({
            store: this.goodstore,
            frame:false,
            autoWidth: true,
            loadMask: true,
            height: 250,
            region: 'south',
            title: '单据明细',
            autoScroll: true,
            columns: [{
                header: '产品编码',
                flex: 1,
                dataIndex: 'goods_sn'
            }, {
                header: '产品名称',
                width: 200,
                dataIndex: 'goods_name'
            }, {
                header: '产品数量',
                flex: 1,
                dataIndex: 'goods_qty'
            }, {
                header: '产品价格',
                flex: 1,
                hidden: (thiz.action[0] == 0) ? true : false,
                dataIndex: 'goods_price'
            }            /*,{
             header: '价格总计',
             flex:1,
             dataIndex:'amt',
             hidden:(thiz.action[0] == 0)?true:false
             }*/
            , {
                header: '关联单据',
                flex: 1,
                dataIndex: 'relate_order_sn'
            }, {
                header: '备注',
                width: 200,
                dataIndex: 'remark'
            }],
            bbar: [{
                xtype: 'pagingtoolbar',
                pageSize: 15,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store: this.store
            }]
        });
    },
    creatitems: function(){
        return this.items = [this.grid, this.goodsview];
    }
});
