Ext.define('Ext.ux.test.inventory.startcheck', {//StartCheckGrid
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
                extraParams: { //sku: Ext.fly('key').dom.value
}                ,
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
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
    
    createFormtiems: function(){
        this.formitem = this.formitems;
    },
    formsubmit: function(){
        if (Ext.getCmp('file_path').isValid()) {
            Ext.Ajax.request({
                url: this.updatesurl,
                method: 'POST',
                params: {
                    file_path: Ext.getCmp('file_path').getValue()
                },
                timeout: 10000,
                success: function(response){
                    Ext.MessageBox.hide();
                    var result = Ext.JSON.decode(response.responseText);
                    if (result.success) {
                        Ext.Msg.alert('MSG', action.result.msg);
                    }
                    else {
                        Ext.Msg.alert('ERROR', action.result.msg);
                    }
                },
                failure: function(response){
                    var result = Ext.JSON.decode(response.responseText);
                    Ext.Msg.alert('ERROR', result.msg);
                }
            })
        }
        else {
            Ext.Msg.alert('提示', '请选择上传盘点数据文件');
        }
    },
    createTbar: function(){
        var ds = this.store;
        var thiz = this;
        var exporturl = this.exporturl;
        this.tbar = ['订单号或产品编码:', {
            xtype: 'textfield',
            id: 'key',
            name: 'key',
            enableKeyEvents: true,
            listeners: {
                scope: this,
                keypress: function(field, e){
                    var keyword = field.getValue();
                    if (e.getKey() == 13 && keyword.length > 0) {
                        Ext.Ajax.request({
                            url: this.listURL + '&sku=' + keyword,
                            success: function(response, opts){
                                var qty = Ext.getCmp('qty');
                                qty.setVisible(true);
                                qty.setValue('');
                                qty.focus();
                                ds.load();
                            }
                        });
                    }
                }
            }
        }, '-',{
            xtype: 'numberfield',
            id: 'qty',
            name: 'qty',
			labelWidth:40,
			fieldLabel:'数量',
            width: 90,
            hidden: true,
            allowNegative: false,
            allowDecimals: false,
            hideMode: 'visibility',
            enableKeyEvents: true,
            listeners: {
                scope: this,
                keypress: function(field, e){
                    var keyword = field.getValue();
                    if (e.getKey() == 13) {
                        var key = Ext.getCmp('key');
                        Ext.getBody().mask("正在提交数据.请稍等...", "x-mask-loading");
                        Ext.Ajax.request({
                            url: this.saveURL,
                            loadMask: true,
                            params: {
                                qty: keyword,
                                sku: key.getValue()
                            },
                            success: function(response, opts){
                                var res = Ext.decode(response.responseText);
                                Ext.getBody().unmask();
                                if (res.success) {
                                    field.setValue('');
                                    key.setValue('');
                                    key.focus();
                                    ds.load();
                                }
                                else {
                                    Ext.Msg.alert('ERROR', res.msg);
                                }
                            }
                        });
                    }
                }
            }
        }, '-', '', '-', {
            xtype: 'button',
            text: '导出盘点表',
            iconCls: 'x-tbar-import',
            handler: function(){
                window.open().location.href = exporturl;
            }
        }, '-', '', '-', {
            xtype: 'fileuploadfield',
            msgTarget: 'side',
            allowBlank: false,
            width: 300,
            buttonText: '浏览...',
            fieldLabel: '上传盘点表',
            labelAlign: 'right',
            name: 'file_path',
            allowBlank: false,
            id: 'file_path'
        }, {
            xtype: 'button',
            iconCls: 'x-tbar-update',
            text: '提交',
            handler: thiz.formsubmit.bind(thiz)
        }];
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

