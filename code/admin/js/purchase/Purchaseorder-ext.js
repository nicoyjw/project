Ext.ux.PorderView = Ext.extend(Ext.Viewport, {
    initComponent: function() {
        this.layout = 'border';
        this.createStore();
        this.creatgoodsstore();
        this.creatSupplierstore();
        this.creatoperatorstore();
        this.createForm();
        this.creatselectionmodel();
        this.createColumns();
        this.createTbar();
        this.creatBbar();
        this.creatgrid();
        this.creatgoodsview();
        this.creatitems();
        this.grid.getSelectionModel().on('selectionchange',
        function(sm) {
            this.grid.removeBtn.setDisabled(sm.getCount() < 1);
            this.grid.editBtn.setDisabled(sm.getCount() < 1);
            this.grid.scanBtn.setDisabled(sm.getCount() < 1);
			this.grid.stopBtn.setDisabled(sm.getCount() < 1);
            Ext.getCmp('prtBtn').setDisabled(sm.getCount() < 1);
            Ext.getCmp('prtBtn1').setDisabled(sm.getCount() < 2);
			 Ext.getCmp('prtBtn2').setDisabled(sm.getCount() < 1);
            this.grid.returnBtn.setDisabled(sm.getCount() < 1);
            this.grid.conBtn.setDisabled(sm.getCount() < 1);
			this.grid.confirmBtn.setDisabled(sm.getCount() < 1);
        });
        Ext.ux.PorderView.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: this.listURL
            }),
            reader: new Ext.data.JsonReader({
                root: 'topics',
                totalProperty: 'totalCount',
                id: this.fields[0]
            },
            this.fields)
        });
        this.store.load({
            params: {
                start: 0,
                limit: this.pagesize
            },
            scope: this.store
        });
        this.store.on('beforeload',
        function() {
            var values = Ext.getCmp('searchform').getForm().getFieldValues();
            Ext.apply(this.baseParams, {
                keyword: Ext.fly('keyword').dom.value,
                status: values.status,
                starttime: values.starttime,
                totime: values.totime,
                operatorid: values.operator_id,
                supplierid: values.supplier_id,
                key: values.keywords
            });
        });
    },
    creatSupplierstore: function() {
        this.Supplierstore = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: this.listSupplierURL
            }),
            reader: new Ext.data.JsonReader({
                root: 'topics',
                totalProperty: 'totalCount',
                id: 'id'
            },
            ['id', 'name'])
        });
    },
    creatoperatorstore: function() {
        this.operatorstore = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: this.listUserURL
            }),
            reader: new Ext.data.JsonReader({
                root: 'topics',
                totalProperty: 'totalCount',
                id: 'user_id'
            },
            ['user_id', 'user_name']),
            autoLoad: true
        });
    },
    createColumns: function() {
        var ds = this.store;
        var sm = this.sm;
        var cols = [this.sm];
        for (var i = 1; i < this.fields.length - 3; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            if (i == 1) {
                cols.push({
                    header: h,
                    dataIndex: f,
                    renderer: function(val, x, rec) {
                        var str = (rec.get('comment')) ? '<img src="themes/default/images/comment.gif" title="' + rec.get('comment') + '">': '';
                        if (rec.get('overtime') > 0) val = "<font color='red'>" + val + "</font>";
                        return '<b>' + val + '</b>' + str;
                    }
                });
            } else {
                cols.push({
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
                tooltip: '编辑订单',
                handler: function(grid, rowIndex, colIndex) {
                    var id = ds.getAt(rowIndex).get('order_id');
                    parent.openWindow(id, '编辑订单', 'index.php?model=Purchaseorder&action=add&order_id=' + id, 1000, 580);
                }
            }],
            renderer: function(v, m, rec) {
                if ( rec.get('realstatus') == 0 || rec.get('realstatus') == 6 ) {
                    this.items[0].iconCls = '';
                } else {
                    this.items[0].iconCls = 'hidden';
                }
            }
        });
        this.columns = cols;
    },
    createTbar: function() {
        var store = this.store;
        var pagesize = this.pagesize;
        this.tbar = [{
            text: '新建采购',
            iconCls: 'x-tbar-add',
            ref: '../addBtn',
            handler: function() {
                parent.openWindow(id, '新建采购订单', 'index.php?model=Purchaseorder&action=add', 1000, 580);
            }
        },
        {
            text: '审核通过',
            iconCls: 'x-tbar-save',
            ref: '../confirmBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['7'])
        },
        {
            text: '问题订单',
            iconCls: 'x-tbar-save',
            ref: '../stopBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['8'])
        },
        {
            text: '扫描入库',
            iconCls: 'x-tbar-save',
            ref: '../scanBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['9'])
        },
        {
            text: '到货入库',
            iconCls: 'x-tbar-save',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['1'])
        },
        {
            text: '采购退货',
            iconCls: 'x-tbar-save',
            ref: '../returnBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['4'])
        },
        {
            text: '强制完成',
            iconCls: 'x-tbar-save',
            ref: '../conBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['3'])
        },
        {
            text: '删除单据',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
            disabled: true,
            handler: this.updateRecord.createDelegate(this, ['0'])
        },'->', 'SKU:', {
            xtype: 'textfield',
			labelWidth:30,
            id: 'keyword_sn',
            name: 'keyword_sn',
			width:100,
			keypress:function(field,e){
				if(e.getKey()==13){
					store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
						goods_sn: Ext.fly('keyword_sn').dom.value,
                    }
                });
				}
			}
        },
        '-','OrderSn:',{
            xtype: 'textfield',
            id: 'keyword',
            name: 'keyword',
			labelWidth:30,
			width:100,
			keypress:function(field,e){
				if(e.getKey()==13){
					store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
                        keyword: Ext.fly('keyword').dom.value
                    }
                });
				}
			}
        },{
			xtype:'button',
			text:'搜索',
			iconCls:'x-tbar-search',
			handler:function(){
				store.load({params:{start:0, limit:pagesize,
					keyword: Ext.fly('keyword').dom.value,
					goods_sn: Ext.fly('keyword_sn').dom.value
					}});
				}
					},
        '-', {
            xtype: 'button',
            text: '高级搜索',
            iconCls: 'x-tbar-advsearch',
            handler: this.showWindow.createDelegate(this)
        }];
    },
    getSelectedRecord: function() {
        var sm = this.grid.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelections()[0];
        }
    },
    updateRecord: function(str) {
        var thiz = this.store;
        var r = this.getSelectedRecord();
		var grid=this.grid;
        if (r != false) {
            if (str == 2) {
                window.open(this.printURL + '&order_id=' + r.data.order_id);
                return false;
            }
            if (str == 5) {
                var ids = getIds(this.grid);
                window.open(this.printURL + '&order_id=' + ids);
                return false;
            }
			if (str == 6) {
                var ids = getIds(this.grid);
                window.open(this.printURL + '&type=1&order_id=' + ids);
                return false;
            }
			if (str == 7) {
				var data = grid.getSelectionModel().getSelections();
				for(var i=0;i<data.length;i++){
					if (data[0].data.realstatus == 0 || data[0].data.realstatus == 6){
						var ids = getIds(grid);
						Ext.Ajax.request({
							url: this.updateURL + '&order_id=' + ids + '&status=1',
							success: function(response, opts) {
								var res = Ext.decode(response.responseText);
								if (res.success) {
									thiz.reload();
									Ext.example.msg('MSG', res.msg);
								} else {
									Ext.Msg.alert('ERROR', res.msg);
								}
							}
						});
						return false;
                	}else{
						Ext.example.msg('MSG', '单据：'+data[i].data.order_sn+'已确认!');
						return false;
					}
				}
            }
			if (str == 8) {
				var data = grid.getSelectionModel().getSelections();
				for(var i=0;i<data.length;i++){
					
					if (r.data.realstatus == 3) {
						Ext.example.msg('MSG', '该单据已完成');
						return false;
					}
					if (r.data.realstatus == 6) {
						Ext.example.msg('MSG', '该单据已是问题订单');
						return false;
					}
					
				}
				var ids = getIds(grid);
				Ext.Ajax.request({
					url: this.updateURL + '&order_id=' + ids + '&status=6',
					success: function(response, opts) {
						var res = Ext.decode(response.responseText);
						if (res.success) {
							thiz.reload();
							Ext.example.msg('MSG', res.msg);
						} else {
							Ext.Msg.alert('ERROR', res.msg);
						}
					}
				});
				return false;
            }
            if (str == 1) {
                if (r.data.realstatus == 0) {
                    Ext.example.msg('MSG', '该单据未审核');
                    return false;
                }
                if (r.data.realstatus == 3) {
                    Ext.example.msg('MSG', '该单据已完成');
                    return false;
                }
                if (r.data.realstatus == 5) {
                    Ext.example.msg('MSG', '该单据待入库');
                    return false;
                }
                if (r.data.realstatus == 6) {
                    Ext.example.msg('MSG', '该单据存在问题，需审核');
                    return false;
                }
                parent.openWindow(id, '新建入库单', this.addstockURL + '&id=' + r.data.order_id, 1000, 580);
                return false;
            }
            
            if (str == 9) {
                if (r.data.realstatus == 0) {
                    Ext.example.msg('MSG', '该单据未审核');
                    return false;
                }
                if (r.data.realstatus == 3) {
                    Ext.example.msg('MSG', '该单据已完成');
                    return false;
                }
				if (r.data.realstatus == 5) {
                    Ext.example.msg('MSG', '该单据待入库');
                    return false;
                }
				if (r.data.realstatus == 6) {
                    Ext.example.msg('MSG', '该单据存在问题，需审核');
                    return false;
                }
                parent.openWindow(id, '采购单'+r.data.order_sn+'扫描入库', this.ScanstockURL + '&id=' + r.data.order_id, 1000, 580);
                return false;
            }
			
            if (str == 4) {
                if (r.data.realstatus == 0) {
                    Ext.example.msg('MSG', '该单据未审核');
                    return false;
                }
                if (r.data.realstatus == 3) {
                    Ext.example.msg('MSG', '该单据已完成');
                    return false;
                }
                parent.openWindow(id, '采购退货单', this.returnURL + '&id=' + r.data.order_id, 1000, 580);
                return false;
            }
            if (str == 0 && (r.data.realstatus == 3 || r.data.realstatus == 2 || r.data.realstatus == 1 || r.data.realstatus == 5 || r.data.realstatus == 6)) {
                Ext.example.msg('MSG', '该单据已审核,不能删除!');
                return false;
            }
            Ext.Msg.confirm('操作提示!', '确定修改订单状态?',
            function(btn) {
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: this.updateURL + '&order_id=' + r.data.order_id + '&status=' + str,
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                thiz.reload();
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
    creatselectionmodel: function() {
        var thiz = this;
        var sm = new Ext.grid.CheckboxSelectionModel({
            listeners: {
                "rowselect": {
                    fn: function(e, rowindex, record) {
						thiz.setid(record.data.order_id);
						var data = thiz.grid.getSelectionModel().getSelections();//获取所选行数
						if(data.length==1){
							thiz.goodstore.load({
								params: {
									order_id: record.data.order_id,
									start: 0,
									limit: 10
								},
								scope: this.store
							});
						}
                    }
                }
            }
        });
        this.sm = sm;
    },
    setid: function(id) {
        this.selectid = id;
    },
    getid: function(id) {
        return this.selectid;
    },
    creatBbar: function() {
        var pagesize = this.pagesize;
		var me = this;
        this.bbar = new Ext.PagingToolbar({
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
			items:[
				'-',{
					text: '打印',
					iconCls: 'x-tbar-print',
					ref: '../prtBtn',
					style:'margin-left:35px;',
					id:'prtBtn',
					disabled: true,
					handler: me.updateRecord.createDelegate(this, ['2'])
				},
				{
					text: '合并打印',
					iconCls: 'x-tbar-print',
					ref: '../prtBtn1',
					id:'prtBtn1',
					disabled: true,
					handler: me.updateRecord.createDelegate(this, ['5'])
				},
				{
					text:'打印产品标签',
					disabled: true,
					ref: '../prtBtn2',
					id:'prtBtn2',
					iconCls:'x-tbar-print',
					handler:me.updateRecord.createDelegate(this,['6'])
				}
			]
        });
    },
    creatgrid: function() {
        this.grid = new Ext.grid.GridPanel({
            title: '<b>采购订单列表</b>',
            loadMask: true,
            frame: true,
            height: 500,
            viewConfig: {
                forceFit: true
            },
            region: 'center',
            store: this.store,
            columns: this.columns,
            sm: this.sm,
            tbar: this.tbar,
            bbar: this.bbar
        });
     	this.grid.on('rowdblclick', this.onRowDblClick, this);
	},
    onRowDblClick: function(grid, rowIndex, e) {
		var sn = this.store.getAt(rowIndex).get('order_sn');
		var supplier = this.store.getAt(rowIndex).get('supplier');
		if(this.goodswin != null){   
			if(this.goodswin.hidden)  
				this.goodswin.show();   
		}else{   
			this.goodswin = new Ext.Window({
				id: 'goodswin',
				title: '供应商：'+supplier+' 采购单：'+sn,
				closeAction: 'hide',
				width: this.goodswinWidth,
				height: this.goodswinHeight,
				modal: true,
				items: [this.goodsview]
			});  
			this.goodswin.show();   
		}
    },
    creatgoodsstore: function() {
        var thiz = this;
        this.goodstore = new Ext.data.Store({
            proxy: new Ext.data.HttpProxy({
                url: this.goodsURL
            }),
            reader: new Ext.data.JsonReader({
                root: 'topics',
                totalProperty: 'totalCount',
                id: 'rec_id'
            },
            ['rec_id', 'goods_qty', 'goods_price', 'goods_id', 'goods_sn', 'goods_img', 'goods_name','supplier_goods_sn','url',{
                name: 'amt',
                convert: function(v, rec) {
                    return rec['goods_qty'] * rec['goods_price'];
                }
            },
            'arrival_qty', 'return_qty', 'remark']),
            listeners: {
                load: function() {
                    var order_id = thiz.getid();
                    Ext.apply(this.baseParams, {
                        order_id: order_id
                    });
                }
            }
        });
    },

    creatgoodsview: function() {
        var thiz = this;
        this.goodsview = new Ext.grid.GridPanel({
            store: this.goodstore,
            autoWidth: true,
            loadMask: true,
            region: 'south',
            title: '采购明细',
            height: 420,
            autoScroll: true,
            columns: [{
                header: '产品图片',
                dataIndex: 'goods_img',
                width: 120,
                renderer: function(v) {
                    return '<img src=' + v + ' width=100 height=100>';
                }
            },
            {
                header: '产品编码',
                dataIndex: 'goods_sn'
            },
            {
                header: '供应商编码',
                dataIndex: 'supplier_goods_sn'
            },
			
            {
                header: '产品名称',
                width: 200,
                dataIndex: 'goods_name'
            },
            {
                header: '产品数量',
                dataIndex: 'goods_qty'
            },
            {
                header: '产品单价',
                dataIndex: 'goods_price'
            },
            {
                header: '总计',
                dataIndex: 'amt'
            },
            {
                header: '入库数量',
                dataIndex: 'arrival_qty'
            },
            {
                header: '退货数量',
                dataIndex: 'return_qty'
            },
            {
                header: '采购网址',
                dataIndex: 'url'
            },
            {
                header: '备注',
                width: 200,
                dataIndex: 'remark'
            }],
            bbar: new Ext.PagingToolbar({
                pageSize: 10,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store: thiz.goodstore
            })
        });
    },
    creatitems: function() {
        return this.items = [this.grid];
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
        var win = new Ext.Window({
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
    getFormPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },
    createForm: function() {
        var store = this.store;
        var status = this.status;
        var pagesize = this.pagesize;
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            id: 'searchform',
            trackResetOnLoad: true,
            items: [{
                xtype: 'combo',
                store: new Ext.data.SimpleStore({
                    fields: ["id", "key_type"],
                    data: status
                }),
                valueField: "id",
                displayField: "key_type",
                mode: 'local',
                width: 130,
                editable: false,
                forceSelection: true,
                triggerAction: 'all',
                hiddenName: 'status',
                name: 'pstatus',
                value: 99,
                allowBlank: false,
                fieldLabel: '状态',
                id: 'status'
            },
            {
                xtype: 'datefield',
                name: 'starttime',
                format: 'Y-m-d',
                fieldLabel: 'From'
            },
            {
                xtype: 'datefield',
                name: 'totime',
                format: 'Y-m-d',
                fieldLabel: 'To'
            },
            {
                xtype: 'combo',
                store: this.Supplierstore,
                valueField: "id",
                displayField: "name",
                mode: 'remote',
                width: 100,
                forceSelection: true,
                triggerAction: 'all',
                hiddenName: 'supplier_id',
                fieldLabel: '供应商',
                allowBlank: false,
                pageSize: 30,
                minListWidth: 220,
                id: 'supplierid',
                listeners: {
                    beforequery: function(qe) {
                        qe.combo.store.on('beforeload',
                        function() {
                            Ext.apply(this.baseParams, {
                                key: qe.query
                            });
                        });
                        qe.combo.store.load();
                    }
                }
            },
            {
                xtype: 'combo',
                store: this.operatorstore,
                valueField: "user_id",
                displayField: "user_name",
                mode: 'local',
                editable: false,
                forceSelection: true,
                triggerAction: 'all',
                width: 80,
                hiddenName: 'operator_id',
                fieldLabel: '采购员',
                allowBlank: false,
                id: 'operatorid'
            },
            {
                name: 'keywords',
                fieldLabel: '关键词',
                value: '',
                enableKeyEvents: true,
                listeners: {
                    scope: this,
                    keypress: function(field, e) {
                        if (e.getKey() == 13) {
                            Ext.fly('keyword').dom.value = '';
                            var values = Ext.getCmp('searchform').getForm().getFieldValues();
                            store.load({
                                params: {
                                    start: 0,
                                    limit: pagesize,
                                    keyword: Ext.fly('keyword').dom.value,
                                    status: values.status,
                                    starttime: values.starttime,
                                    totime: values.totime,
                                    operatorid: values.operator_id,
                                    supplierid: values.supplier_id,
                                    key: values.keywords
                                }
                            });
                            Ext.getCmp('searchwin').hide();
                        }
                    }
                }
            }],
            buttons: [{
                text: 'submit',
                handler: function() {
                    Ext.fly('keyword').dom.value = '';
                    var values = Ext.getCmp('searchform').getForm().getFieldValues();
                    store.load({
                        params: {
                            start: 0,
                            limit: pagesize,
                            keyword: Ext.fly('keyword').dom.value,
                            status: values.status,
                            starttime: values.starttime,
                            totime: values.totime,
                            operatorid: values.operator_id,
                            supplierid: values.supplier_id,
                            key: values.keywords
                        }
                    });
                    Ext.getCmp('searchwin').hide();
                }
            },
            {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
        return form;
    }
});