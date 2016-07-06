Ext.define('Ext.ux.test.inventory.stockchange', {//stockchangeForm
    extend: 'Ext.form.Panel',
    initComponent: function(){
        this.frame = true, this.buttonAlign = 'center';
        this.txt_totQty = Ext.create('Ext.form.field.Text', {
            xtype: 'textfield',
            id: 'txt_totQty',
            anchor: '95%',
            allowBlank: true,
            value: 0,
            readOnly: true,
            fieldClass: 'textReadOnly'
        }), this.txt_totQty1 = Ext.create('Ext.form.field.Text', {
            xtype: 'textfield',
            id: 'txt_totQty1',
            anchor: '95%',
            allowBlank: true,
            value: 0,
            readOnly: true,
            fieldClass: 'textReadOnly'
        });
        this.creatGoodsstore();
        this.creatGoodsgrid();
        this.creatItems();
        this.creatButtons();
        this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
            Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
        });
        this.callParent();
    },
    
    
    creatGoodsstore: function(){//订单明细store
        var data = [['rec_id', 'sku1', 'sku2', 'goods_qty']];
        this.goodsstore = Ext.create('Ext.data.Store', {
            fields: ['rec_id', 'sku1', 'sku2', 'goods_qty'],
            autoLoad: true,
            data: data,
            proxy: {
                type: 'memory',
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty: 'rec_id',
                    root: 'topics'
                }
            },
            listeners: {
                'load': this.calculate.bind(this),
                'add': this.calculate.bind(this),
                'remove': this.calculate.bind(this),
                'update': this.calculate.bind(this)
            }
        });
        //this.goodsstore.load();
    },
    
    creatGoodsgrid: function(){//创建产品明细
        this.goodsGrid = Ext.create('Ext.grid.Panel', {
            plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1
            })],
            frame: false,
            id: "destPanel",
            title: '调换产品明细',
            height: 300,
            autoWidth: true,
            columns: [{
                header: '调入产品<font color=red>*</font>',
                dataIndex: 'sku1',
                align: 'left',
                editor: new Ext.form.TextField({
                    allowBlank: false,
                    hideLabel: true
                })
            }, {
                header: '调出产品<font color=red>*</font>',
                width: 250,
                dataIndex: 'sku2',
                align: 'left',
                editor: new Ext.form.TextField({
                    allowBlank: false,
                    hideLabel: true
                })
            }, {
                header: '产品数量<font color=red>*</font>',
                dataIndex: 'goods_qty',
                align: 'right',
                editor: new Ext.form.NumberField({
                    allowBlank: false,
                    allowNegative: false,
                    decimalPercision: 4,
                    style: 'text-align:left'
                })
            }],
            selModel: Ext.create('Ext.selection.CheckboxModel'),
            store: this.goodsstore,
            clicksToEdit: 1,
            stripeRows: true, // 让基数行和偶数行的颜色不一样
            viewConfig: {
                forceFit: true
            },
            border: true,
            iconCls: 'icon-grid',
            tbar: new Ext.Toolbar({
                items: [{
                    xtype: 'button',
                    text: '新增产品',
                    id: 'addBtn',
                    iconCls: 'x-tbar-add',
                    handler: this.addItem.bind(this)
                }, {
                    text: '删除',
                    iconCls: 'x-tbar-del',
                    id: 'removeBtn',
                    handler: this.removeItem.bind(this),
                    disabled: true
                }]
            }),
            bbar: new Ext.Toolbar({
                cls: 'u-toolbar-b',
                items: ['合计:', '->', '产品种类:', this.txt_totQty1, '-', '产品总计:', this.txt_totQty]
            })
        });
    },
    
    creatItems: function(){
        this.items = [this.goodsGrid];
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
        if (this.txt_totQty.getValue() == 0) {
            Ext.example.msg('错误提示', '商品数量不能为空');
            return false;
        }
        if (this.getForm().isValid()) {
            var m = this.goodsstore.getModifiedRecords();
            var thiz = this.goodsstore;
            var jsonArray = [];
            Ext.each(m, function(item){
                jsonArray.push(item.data);
            });
            this.getForm().doAction('submit', {
                url: this.saveURL,
                method: 'post',
                params: {
                    'data': Ext.encode(jsonArray)
                },
                success: function(form, action){
                    if (action.result.success) {
                        Ext.Msg.alert('MSG', action.result.msg);
                    }
                    else {
                        Ext.Msg.alert('修改失败', action.result.msg);
                    }
                },
                failure: function(){
                    Ext.Msg.alert('ERROR', action.result.msg);
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
    
    addItem: function(){//新增物品
        Ext.define('Item', {
            extend: 'Ext.data.Model',
            fields: [{
                name: 'rec_id',
                type: 'float'
            }, {
                name: 'sku1'
            }, {
                name: 'sku2'
            }, {
                name: 'goods_qty',
                type: 'float'
            }]
        });
        //var Item = Ext.data.Record.create();
        var p = Ext.create('Item', {
            rec_id: 0,
            sku1: '',
            sku2: '',
            goods_qty: 1
        });
        this.goodsstore.insert(0, p);
        //this.goodsGrid.startEditing(0, 0); // 光标停留在第几行几列
    },
    removeItem: function(){//移除物品
        var data = this.goodsGrid.getSelectionModel().getSelected().data;
        var index = this.goodsstore.findBy(function(record, id){
            return record.get('sku1') == data.sku1 && ecord.get('sku2') == data.sku2 && record.get('goods_qty') == data.goods_qty;
        });
        var id = data.rec_id;
        if (id == 0) {
            this.goodsstore.remove(this.goodsstore.getAt(index));
            return;
        }
    },
    
    calculate: function(store, rec, success){//计算物品总数量和总金额
        var i;
        var totalQty = 0;
        var totalAmt = 0;
        for (i = 0; i < store.getCount(); i++) {
            totalQty += store.getAt(i).get('goods_qty') * 10000;
        }
        this.txt_totQty1.setValue(store.getCount());
        this.txt_totQty.setValue(totalQty / 10000);
    }
});

