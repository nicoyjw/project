Ext.define('Ext.ux.NormalGrid', {
    extend: 'Ext.grid.Panel',
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.getpagesize();
        this.createStore();
        this.createTypeStore();
        this.createFormtiems();
        this.createTbar();
        this.createBbar();
        this.createColumns();
        this.getSelectionModel().on('selectionchange',
        function(sm) {
            if (!Ext.getCmp('editBtn')) {
                var gridId = sm.view.ownerCt.id;
                Ext.getCmp(gridId + '_editBtn').setDisabled(sm.getCount() < 1);
                Ext.getCmp(gridId + '_removeBtn').setDisabled(sm.getCount() < 1)
            } else {
                Ext.getCmp('editBtn').setDisabled(sm.getCount() < 1);
                Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1)
            }
        });
        this.callParent()
    },
    getpagesize: function() {
        if (!this.pagesize) this.pagesize = 25
    },
    createTypeStore: function() {},
    createStore: function() {
        this.store = Ext.create('Ext.data.Store', {
            fields: this.fields,
            pageSize: this.pagesize,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listURL,
                actionMethods: {
                    read: 'POST'
                },
                extraParams: {},
                reader: {
                    type: 'json',
                    root: 'topics',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0]
                }
            }
        })
    },
    createColumns: function() {
        var cols = [];
        cols.push({
            xtype: 'rownumberer'
        });
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                flex: 1,
                header: h,
                dataIndex: f
            })
        }
        this.columns = cols
    },
    createFormtiems: function() {
        this.formitem = this.formitems
    },
    createTbar: function() {
        var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        },
        {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'editBtn',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.bind(me)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'removeBtn',
            ref: '../removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(me)
        }]
    },
    createBbar: function() {
        var pagesize = this.pagesize;
        this.bbar = [{
            xtype: 'pagingtoolbar',
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store
        }]
    },
    createRecord: function() {
        this.showWindow();
        var form = this.getForm();
        form.baseParams = {
            create: true
        }
    },
    updateRecord: function() {
        var r = this.getSelectedRecord();
        if (r != false) {
            this.showWindow();
            var form = this.getForm();
            form.baseParams = {
                create: false
            };
            form.loadRecord(r)
        }
    },
    afterEdit: function() {},
    afterRemove: function() {},
    removeRecord: function() {
        var r = this.getSelectionModel().getSelection();
        var ids = getIds(this);
        var thiz = this.store;
        afterRemove = this.afterRemove;
        if (r != false) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?',
            function(btn) {
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: this.delURL + '&ids=' + ids,
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.remove(r);
                                afterRemove()
                            } else {
                                Ext.Msg.alert('ERROR', res.msg)
                            }
                        }
                    })
                }
            },
            this)
        }
    },
    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.Msg.alert('Info', 'Please select one row.');
            return false
        } else {
            return sm.getSelection()[0]
        }
    },
    getEmptyRecord: function() {
        var r = {};
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
            r[f] = ''
        }
        return r
    },
    submitRecord: function() {
        var form = this.getForm();
        var values = form.getFieldValues();
        afterEdit = this.afterEdit;
        var thiz = this.store;
        if (form.isValid()) {
            Ext.getBody().mask("waiting...", "x-mask-loading");
            form.submit({
                url: this.saveURL,
                method: 'post',
                params: '',
                success: function(form, action) {
                    if (action.result.success) {
                        Ext.getBody().unmask();
                        thiz.load();
                        Ext.Msg.alert('MSG', action.result.msg)
                    } else {
                        Ext.getBody().unmask();
                        Ext.Msg.alert('修改失败', action.result.msg)
                    }
                },
                failure: function(form, action) {
                    Ext.getBody().unmask();
                    Ext.Msg.alert('操作', action.result.msg)
                }
            })
        }
        this.hideWindow()
    },
    getForm: function() {
        return this.getFormPanel().getForm()
    },
    getFormPanel: function() {
        var form = Ext.getCmp('form');
        if (!form) {
            form = this.createForm()
        }
        return form
    },
    createForm: function() {
        var form = Ext.create('Ext.form.Panel', {
            frame: false,
            border: false,
            id: 'form',
            width: '100%',
            labelAlign: 'right',
			autoHeight:true,
			autoScroll: true,
            labelWidth: 70,
            padding: 10,
            buttonAlign: 'center',
            items: this.formitem,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.bind(this)
            },
            {
                text: 'reset',
                handler: function() {
                    form.getForm().reset()
                }
            }]
        });
        return form
    },
    showWindow: function() {
        this.getWindow().show()
    },
    hideWindow: function() {
        this.getWindow().hide()
    },
    getWindow: function() {
        var _window = Ext.getCmp('window');
        if (!_window) {
            _window = this.createWindow()
        }
        return _window
    },
    createWindow: function() {
        var formPanel = this.getFormPanel();
        var win = Ext.create('Ext.window.Window', {
            title: this.windowTitle,
            id: 'window',
            closeAction: 'hide',
            constrainHeader: true,
            layout: 'fit',
			style:'text-align:center',
            width: this.windowWidth,
            height: this.windowHeight,
            modal: true,
            items: [formPanel],
            listeners: {
                close: function() {
                    win.destroy()
                }
            }
        });
        return win
    }
});