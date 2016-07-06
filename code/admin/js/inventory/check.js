Ext.define('Ext.ux.test.inventory.check', {//CheckGrid
    extend: 'Ext.grid.Panel',
    initComponent: function(){
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
        this.createFormtiems();
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
        var cols = [];
        cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.headers.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                flex: 1,
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
    
    createFormtiems: function(){
        this.formitem = this.formitems;
    },
    
    createTbar: function(){
        this.tbar = [{
            text: '初始化盘点单',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '开始盘点',
            iconCls: 'x-tbar-update',
            handler: this.updateRecord.bind(this)
        }, {
            text: '盘点完成',
            iconCls: 'x-tbar-save',
            handler: this.completeRecord.bind(this)
        }, '->', {
            text: '生成盘盈入库单',
            iconCls: 'x-tbar-save',
            handler: this.finishRecord.bind(this, ['1'])
        }, {
            text: '生成盘亏出库单',
            iconCls: 'x-tbar-save',
            handler: this.finishRecord.bind(this, ['2'])
        }];
    },
    createRecord: function(){
        this.showWindow();
    },
    updateRecord: function(){
        var ids = getIds(this);
        if (ids != null) {
            parent.newTab('check' + ids, '库存盘点', 'index.php?model=inventory&action=startcheck&id=' + ids);
        }
    },
    completeRecord: function(){
        var ids = getIds(this);
        if (ids == null) 
            return false;
        var store = this.store;
        var r = this.getSelectionModel().getSelected();
        if (r.data.status == '已完成') {
            Ext.example.msg('提示', '该订单已完成');
            return false;
        }
        if (r.data.has_un > 0) {
            Ext.Msg.confirm('提示!', '该盘点单包含未盘点产品是否确认盘点完成?', function(btn){
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: this.comURL + '&id=' + r.data.order_id,
                        success: function(response, opts){
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                Ext.example.msg('MSG', res.msg);
                                store.reload();
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
            Ext.Ajax.request({
                url: this.comURL + '&id=' + r.data.order_id,
                success: function(response, opts){
                    var res = Ext.decode(response.responseText);
                    if (res.success) {
                        Ext.example.msg('MSG', res.msg);
                        store.reload();
                    }
                    else {
                        Ext.Msg.alert('ERROR', res.msg);
                    }
                }
            });
        }
    },
    finishRecord: function(id){
        var finishURL = this.finishURL;
        var ids = getIds(this);
        if (ids == null) 
            return false;
		var r = this.getSelectionModel().getSelection()[0];
        if (r.get('status') == '已完成') {
            var str = (id == 1) ? '盘盈入库' : '盘亏出库';
            parent.newTab('finishcheck' + ids, '库存盘点' + str, finishURL + '&id=' + ids + '&type=' + id);
        }
        else {
            Ext.example.msg('提示', '请先完成盘点单再进行盘点校正操作');
            return false;
        }
    },
    getForm: function(){
        return this.getFormPanel().getForm();
    },
    
    getFormPanel: function(){
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },
    afterselect: function(k, v){
        Ext.getCmp('cat_name').setValue(v);
        Ext.getCmp('cat_id').setValue(k);
    },
    createFormtiems: function(){
        var afterselect = this.afterselect;
        var items = [{
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
			name:'depot_id',
            triggerAction: 'all',
            fieldLabel: '仓库',
            allowBlank: false,
            pagesise: 10,
            labelWidth: 45,
            width: 250,
            value: '0',
            id: 'depot'
        }, {
            xtype: "combo",
            fieldLabel: '选择',
            id: 'checktype',
			name:'checktype',
            store: Ext.create('Ext.data.ArrayStore', {
                fields: ['value', 'text'],
                data: [['1', '单品盘点'], ['2', '分类盘点'], ['0', '全库盘点']]
            }),
            displayField: 'text',
            valueField: 'value',
            mode: 'local',
            editable: false,
            labelWidth: 45,
            width: 250,
            value: '0',
            forceSelection: true,
            triggerAction: 'all',
            allowBlank: false,
            listeners: {
                select: function(field, r){
                    if (r.data.value == 0) {
                        Ext.getCmp('cat_name').hide();
                        Ext.getCmp('sku').hide();
                    }
                    if (r.data.value == 2) {
                        Ext.getCmp('sku').hide();
                        Ext.getCmp('cat_name').show();
                    }
                    if (r.data.value == 1) {
                        Ext.getCmp('cat_name').hide();
                        Ext.getCmp('sku').show();
                    }
                }
            }
        }, new Ext.form.TriggerField({
            editable: false,
            fieldLabel: '分类',
            labelWidth: 45,
            width: 250,
            xtype: 'trigger',
            id: 'cat_name',
			name:'cat_name',
            value: 'All',
            hidden: true,
            onSelect: function(record){
            },
            onTriggerClick: function(){
                getCategoryFormTree('index.php?model=goods&action=getcattree&com=0', 0, afterselect);
            }
        }), {
            xtype: 'hidden',
			name:'cat_id',
            id: 'cat_id'
        }, {
            fieldLabel: 'SKU',
            hidden: true,
            id: 'sku'
        }];
        
        this.formitem = items;
    },
    createForm: function(){
        var form = new Ext.form.FormPanel({
            frame: false,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            autoHeight: true,
            labelWidth: 70,
            items: this.formitem,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.bind(this)
            }, {
                text: 'reset',
                handler: function(){
                    form.getForm().reset();
                }
            }]
        });
        return form;
    },
    submitRecord: function(){
        Ext.getBody().mask("正在初始化盘点单.请稍等...", "x-mask-loading");
        var form = this.getForm();
        var values = form.getFieldValues();
        var thiz = this.store;
        if (form.isValid()) {
            form.doAction('submit', {
                url: this.saveURL,
                method: 'post',
                timeout: 180000,
                params: {
                    'checktypeid': values.checktype
                },
                success: function(form, action){
                    Ext.getBody().unmask();
                    if (action.result.success) {
                        thiz.reload();
                        Ext.example.msg('MSG', action.result.msg);
                    }
                    else {
                        Ext.Msg.alert('ERROR', action.result.msg);
                    }
                },
                failure: function(){
                    Ext.example.msg('操作', '服务器出现错误请稍后再试！');
                }
            });
        }
        this.hideWindow();
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
        
        var win = new Ext.Window({
            title: this.windowTitle,
            closeAction: 'hide',
            constrainHeader: true,
            width: this.windowWidth,
            height: this.windowHeight,
            modal: true,
            items: [formPanel]
        });
        
        return win;
    },
    createBbar: function(){
        var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store
        });
    }
});

