Ext.define('Ext.ux.RmaGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
		this.createStore();
        this.createTypeStore();
        this.createFormtiems();
        this.createTbar();
        this.createBbar();
        this.autoWidth = true;
		this.height=480;
        this.stripeRows = true;
        this.createColumns();
        this.getSelectionModel().on('selectionchange',function(sm) {
			Ext.getCmp('editBtn').setDisabled(sm.getCount() < 1);
			Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
        });
        this.callParent(this);
    },
    createColumns: function() {
        var thiz = this;
        var ds = this.store;
        var cols = [{xtype: 'rownumberer'}, {
            header: 'RMA单据ID',
            dataIndex: 'rma_sn',
            renderer: function(val, x, rec) {
                var str = (rec.get('remark')) ? '<img src="themes/default/images/comment.gif" title="' + rec.get('remark') + '">': '';
                return '<b>' + val + '</b>' + str;
            }
        },
        {
            header: '订单号',
            dataIndex: 'order_sn'
        },
        {
            header: '重发订单号',
            dataIndex: 'new_order_sn'
        },
        {
            header: '账号',
            dataIndex: 'Sales_account_id'
        },
        {
            header: 'buyerID',
            dataIndex: 'userid'
        },
        {
            header: '发货日期',
            dataIndex: 'end_time'
        },
        {
            header: '问题产品',
            dataIndex: 'goods_sn'
        },
        {
            header: '数量',
            dataIndex: 'quantity'
        },
        {
            header: 'Reason',
            dataIndex: 'reason',
            renderer: thiz.renderers
        },
        {
            header: '国家',
            dataIndex: 'country'
        },
        {
            header: '退回方式',
            dataIndex: 'return_form'
        },
        {
            header: 'tracking',
            dataIndex: 'tracking'
        },
        {
            header: '状态',
            dataIndex: 'rma_status'
        },
        {
            header: '退回时间',
            dataIndex: 'return_time'
        },
        {
            header: '快递方式',
            dataIndex: 'shipping_id'
        },{
            header: '追踪单号',
            dataIndex: 'track_no'
        },{
            header: '实际重量',
            dataIndex: 'weight'
        },
        {
            header: '实际运费',
            dataIndex: 'shipping_cost'
        },{
            header: '订单总金额',
            dataIndex: 'order_amount'
        },{
            header: '退款金额',
            dataIndex: 'refund'
        },{
            header: '添加人',
            dataIndex: 'admin_id'
        },
        {
            header: '添加时间',
            dataIndex: 'addtime'
        },
        {
            header: '操作',
            xtype: 'actioncolumn',
            renderer: function(v, m, rec) {
                if (rec.get('realstatus') > 0) {
                    this.items[0].iconCls = 'hidden';
                    this.items[1].iconCls = 'hidden';
                    this.items[2].iconCls = 'hidden';
                } else {
                    this.items[0].iconCls = 'iconpadding';
                    this.items[1].iconCls = 'iconpadding';
                    this.items[2].iconCls = 'iconpadding';
                }
            },
            items: [{
                icon: 'themes/default/images/del.gif',
                tooltip: '退付款',
                iconCls: 'iconpadding',
                handler: function(grid, rowIndex, colIndex) {
                    var rec = ds.getAt(rowIndex);
                    parent.openWindow(rec.get('id'), '新建付款单', 'index.php?model=finance&action=addpay&ordersn=' + rec.get('order_sn'), 300, 360);
                }
            },
            {
                icon: 'themes/default/images/drop-add.gif',
                tooltip: '订单重发',
                iconCls: 'iconpadding',
                handler: function(grid, rowIndex, colIndex) {
                    var id = ds.getAt(rowIndex).get('order_id');
                    parent.openWindow(id, '新建重发订单', 'index.php?model=order&action=add&id=' + id, 1000, 680);
                }
            },
            {
                icon: 'themes/default/images/flag_green.gif',
                tooltip: '不处理',
                handler: function(grid, rowIndex, colIndex) {
                    var rec = ds.getAt(rowIndex);
                    thiz.change_status(rec.get('id'), 2);
                }
            }]
        }];
        this.columns = cols;
    },
	createTypeStore: function() {},
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		})
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				/*starttime:Ext.fly('starttime').dom.value,
				totime:Ext.fly('totime').dom.value,
				goods_sn: Ext.fly('goods_sn').dom.value,
				reasonid: Ext.getCmp('reasonid').getValue(),
				accountid: Ext.getCmp('accountid').getValue()*/
			});
		});
    },
	createFormtiems: function() {
        this.formitem = this.formitems;
    },
    createTbar: function() {
         var store = this.store;
         var sales_account = this.sales_account;
         var reason = this.reason;
         var listURL = this.listURL;
         var pagesize = this.pagesize;
		 this.tbar = Ext.create('Ext.toolbar.Toolbar', {
			items:[{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        },
        {
            text: '编辑',
            iconCls: 'x-tbar-update',
            ref: '../editBtn',
			id:'editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
			id:'removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(this)
        },'->', '账户：', {
            xtype: 'combo',
            store: Ext.create('Ext.data.ArrayStore',{
                fields: ["id", "key_type"],
                data: sales_account
            }),
            valueField: "id",
            width: 100,
            displayField: "key_type",
            mode: 'local',
            editable: false,
            forceSelection: true,
            triggerAction: 'all',
            hiddenName: 'accountid',
            value: '0',
            name: 'account_id',
            id: 'accountid'
        },'-',
        '原因：', {
            xtype: 'combo',
            store: Ext.create('Ext.data.ArrayStore',{
                fields: ["id", "key_type"],
                data: reason
            }),
            valueField: "id",
            width: 100,
            displayField: "key_type",
            mode: 'local',
            editable: false,
            forceSelection: true,
            triggerAction: 'all',
            hiddenName: 'reason',
            value: '',
            name: 'reason',
            id: 'reasonid'
        },'-',
        '产品：', {
            xtype: 'textfield',
            name: 'goods_sn',
			labelWidth:55,
			width:100,
            id: 'goods_sn',
            value: ''
        },'-',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						labelWidth:45,
						width:150,
						fieldLabel:'From',
						invalidText:'格式错误！'
					},'-',{
						xtype:'datefield',
						id:'totime',
						labelWidth:35,
						width:150,
						format:'Y-m-d',
						fieldLabel:'To',
						invalidText:'格式错误！'
					},
        '-', {
            xtype: 'button',
            text: '搜索',
            iconCls: 'x-tbar-search',
            handler: function() {
                store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
						starttime:Ext.fly('starttime').dom.value,
						totime:Ext.fly('totime').dom.value,
                        goods_sn: Ext.fly('goods_sn').dom.value,
                        reasonid: Ext.getCmp('reasonid').getValue(),
                        accountid: Ext.getCmp('accountid').getValue()
                    }
                });
            }
        },
        '-', {
            text: '导出统计结果',
            xtype: 'button',
            iconCls: 'x-tbar-import',
            handler: function() {
                window.open().location.href = listURL + '&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&goods_sn='+Ext.fly('goods_sn').dom.value+'&reasonid='+Ext.getCmp('reasonid').getValue()+'&accountid='+Ext.getCmp('accountid').getValue();
            }
        }]
		});
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
        }];
    },
    createRecord: function() {
        this.showWindow();
        var form = this.getForm();
        form.baseParams = {
            create: true
        };
        form.setValues(this.getEmptyRecord());
    },
    updateRecord: function() {
        var r = this.getSelectedRecord();
        if (r != false) {
            this.showWindow();
            var form = this.getForm();
            form.baseParams = {
                create: false
            };
            form.loadRecord(r);
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
                                afterRemove();
                                Ext.example.msg('MSG', res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            },
            this);
        }
    },
    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelection()[0];
        }
    },
    getEmptyRecord: function() {
        var r = {};
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
            r[f] = '';
        }
        return r;
    },
    submitRecord: function() {
        var form = this.getForm();
        var values = form.getFieldValues();
        afterEdit = this.afterEdit;
        var thiz = this.store;
        if (form.isValid()) {
            form.doAction('submit', {
                url: this.saveURL,
                method: 'post',
                params: '',
                success: function(form, action) {
                    if (action.result.success) {
                        thiz.reload();
                        afterEdit();
                        Ext.example.msg('MSG', action.result.msg);
                    } else {
                        Ext.Msg.alert('修改失败', action.result.msg);
                    }
                },
                failure: function() {
                    Ext.example.msg('操作', '服务器出现错误请稍后再试！');
                }
            });
        }
        this.hideWindow();
    },
    getForm: function() {
        return this.getFormPanel().getForm();
    },
    getFormPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },
    createForm: function() {
        var form = Ext.create('Ext.form.Panel',{
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            trackResetOnLoad: true,
            reader: Ext.create('Ext.data.ArrayStore',{
                fields: this.fields
            }),
            items: this.formitem,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.bind(this)
            },
            {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
        return form;
    },
    showWindow: function() {
        this.getWindow().show();
    },
    hideWindow: function() {
        this.getWindow().hide();
    },
    getWindow: function() {
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow();
        }
        return this.gridWindow;
    },
    createWindow: function() {
        var formPanel = this.getFormPanel();
        var win = Ext.create('Ext.window.Window',{
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
    change_status: function(id, status_num) {
        var thiz = this.store;
        Ext.Ajax.request({
            url: 'index.php?model=rma&action=changestatus&id=' + id + '&status=' + status_num,
            success: function(response) {
                var result = Ext.decode(response.responseText);
                if (result.success == true) {
                    thiz.reload();
                }
            }
        });
    }
});