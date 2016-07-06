Ext.ux.AliGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
        Ext.ux.AliGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: this.listURL
            }),
            autoLoad: true,
            pruneModifiedRecords: true,
            reader: new Ext.data.JsonReader({
                root: 'topics',
                totalProperty: 'totalCount',
                id: this.fields[0]
            },
            this.fields)
        });
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        },
        {
            text: '编辑',
            iconCls: 'x-tbar-update',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
            disabled: true,
            handler: this.removeRecord.createDelegate(this)
        },
        {
            text: '授权',
            iconCls: 'x-tbar-add',
            handler: this.creatTaobao.createDelegate(this)
        }];
    },
    createColumns: function() {
        var paypallist = this.paypallist;
        var cols = [new Ext.grid.RowNumberer(), {
            header: '速卖通账号',
            dataIndex: 'username'
        },
        {
            header: 'appkey',
            dataIndex: 'appkey'
        }];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
                hidden: true
            });
        }
        this.columns = cols;
    },
    creatTaobao: function() {
        var store = this.store;
        var win = new Ext.Window({
            layout: 'fit',
            title: '速卖通账号授权',
            width: 280,
            height: 150,
            id: 'aliauth',
            modal: true,
            closable: true,
            closeAction: 'hide',
            constrainHeader: true,
            html: 'AppKey:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=text id="appkey"><br>输入速卖通AppKey，点击开始授权登录速卖通进行授权操作,完成后点击完成授权',
            buttons: [{
                text: '开始授权',
                handler: function() {
                    Ext.getBody().mask("正在提交数据.请稍等...", "x-mask-loading");
                    Ext.Ajax.request({
                        url: 'index.php?model=aliapi&action=auth',
                        method: 'post',
                        loadMask: true,
                        params: {
                            appkey: Ext.fly('appkey').getValue()
                        },
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            Ext.getBody().unmask();
                            if (res.success) {
                                window.open(res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            },
            {
                text: '完成授权',
                handler: function() {
                    Ext.Ajax.request({
                        url: 'index.php?model=aliapi&action=overauth',
                        method: 'post',
                        params: {
                            appkey: Ext.fly('appkey').getValue()
                        },
                        success: function(response) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                Ext.Msg.alert('提示', res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                    Ext.getCmp('aliauth').hide();
                    store.reload();
                }
            }]
        });
        win.show();
    },
    createFormtiems: function() {
        var paypallist = this.paypallist;
        var items = [{
            xtype: 'hidden',
            name: 'id'
        },
        {
            fieldLabel: 'appkey',
            name: 'appkey',
            allowBlank: false
        },
        {
            xtype: 'hidden',
            id: '',
            value: 'id'
        }];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f,
                allowBlank: false,
                xtype: 'textarea',
                width: 180,
                height: 40
            });
        }
        this.formitem = items;
    }
});