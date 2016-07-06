Ext.ux.editgoodsForm = Ext.extend(Ext.FormPanel, {
    initComponent: function() {
        this.frame = true,
        this.fileUpload = true,
        this.autoHeight = true,
        this.buttonAlign = 'center',
        this.creatChildGridcm();
        this.creatChildGoodsstore();
        this.creatChildGoodsgrid();
        this.getTab();
        this.creatItems();
        this.childgoodsGrid.getSelectionModel().on('selectionchange',
        function(sm) {
            Ext.getCmp('childremoveBtn').setDisabled(!sm.hasSelection());
        });
        this.childgoodsstore.on('add',
        function() {
            Ext.getCmp('childsaveBtn').setDisabled(false);
        });
        this.childgoodsstore.on('update',
        function() {
            Ext.getCmp('childsaveBtn').setDisabled(false);
        });
        if (this.action[0] == 0) this.tab.items.items[0].setDisabled(true);
        if (this.action[1] == 0) this.tab.getItem(2).setDisabled(true);
        if (this.action[2] == 0) this.tab.getItem(3).setDisabled(true);
        if (this.action[3] == 0) this.tab.getItem(4).setDisabled(true);
        if (this.action[4] == 0) this.tab.getItem(5).setDisabled(true);
        if (this.action[5] == 0) this.tab.getItem(6).setDisabled(true);
        if (this.action[6] == 0) this.tab.getItem(7).setDisabled(true);
        if (this.action[7] == 0) this.tab.getItem(8).setDisabled(true);
        Ext.ux.editgoodsForm.superclass.initComponent.call(this);
    },
    creatChildGoodsstore: function() { //子产品明细store
        this.childgoodsstore = new Ext.data.Store({
            url: this.childlistURL,
            baseParams: {
                goods_id: this.good.goods_id
            },
            pruneModifiedRecords: true,
            reader: new Ext.data.JsonReader({
                totalProperty: 'totalCount',
                root: 'topics',
                id: 'rec_id'
            },
            ['rec_id', 'child_sn', 'color', 'size', 'price', 'stock'])
        });
        this.childgoodsstore.load();
    },
    creatChildGridcm: function() {
        var thiz = this;
        this.childcmlist = new Ext.grid.ColumnModel([{
            header: '子产品编码<font color=red>*</font>',
            dataIndex: 'child_sn',
            width: 100,
            align: 'left',
            editor: new Ext.form.TextField({
                allowBlank: false,
                hideLabel: true
            })
        },
        {
            header: '颜色',
            width: 150,
            dataIndex: 'color',
            align: 'left',
            renderer: this.rendererlist[1],
            editor: this.combolist[1]
        },
        {
            header: '尺寸',
            width: 150,
            dataIndex: 'size',
            align: 'left',
            renderer: this.rendererlist[0],
            editor: this.combolist[0]
        },
        {
            header: '价格<font color=red>*</font>',
            width: 150,
            dataIndex: 'price',
            align: 'left',
            editor: new Ext.form.NumberField({
                allowNegative: false,
                hideLabel: true
            })
        },
        {
            header: '库存数量<font color=red>*</font>',
            dataIndex: 'stock',
            align: 'right',
            editor: new Ext.form.NumberField({
                allowBlank: false,
                allowNegative: false,
                allowDecimals: false,
                style: 'text-align:left'
            })
        }]);
    },

    creatChildGoodsgrid: function() { //创建子产品明细
        this.childgoodsGrid = new Ext.grid.EditorGridPanel({
            frame: true,
            title: '子产品明细',
            height: 300,
            autoWidth: true,
            cm: this.childcmlist,
            ds: this.childgoodsstore,
            sm: new Ext.grid.RowSelectionModel({
                singleSelect: true
            }),
            clicksToEdit: 1,
            stripeRows: true,
            // 让基数行和偶数行的颜色不一样
            viewConfig: {
                forceFit: true
            },
            iconCls: 'icon-grid',
            tbar: new Ext.Toolbar({
                items: [{
                    xtype: 'button',
                    text: '新增子产品',
                    id: 'childaddBtn',
                    disabled: (this.good.has_child > 0) ? false: true,
                    iconCls: 'x-tbar-add',
                    handler: this.addChilditem.createDelegate(this)
                },
                {
                    text: '删除',
                    iconCls: 'x-tbar-del',
                    id: 'childremoveBtn',
                    handler: this.removeItem.createDelegate(this),
                    disabled: true
                },
                {
                    text: '保存',
                    iconCls: 'x-tbar-save',
                    id: 'childsaveBtn',
                    handler: this.saveItem.createDelegate(this),
                    disabled: true
                }]
            })
        });
    },
    afterselect: function(k, v) {
        Ext.getCmp('cat_name').setValue(v);
        modifymodel(Ext.getCmp('goods_id').getValue(), 'cat_id', k, 'goods');
    },
    creatTab: function() {
        var thiz = this;
        var afterselect = this.afterselect;
        var goodsgrid = this.goodsGrid;
        var action = this.action;
        var tab = new Ext.TabPanel({
            activeTab: 0,
            autoHeight: true,
            defaults: {
                autoScroll: true,
                autoHeight: true
            },
            items: [{
                id: 'tab1',
                title: '基本信息',
                autoScroll: true,
                layout: 'form',
                items: [{
                    layout: 'column',
                    items: [{
                        fieldLabel: '产品ID',
                        id: 'goods_id',
                        value: this.good.goods_id,
                        xtype: 'hidden'
                    },
                    {
                        columnWidth: .99,
                        layout: 'form',
                        defaultType: 'textfield',
                        frame: false,
                        items: [{
                            xtype: 'fieldset',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border: true,
                            title: '基本信息',
                            items: [new Ext.form.TriggerField({
                                editable: false,
                                fieldLabel: '所属分类',
                                xtype: 'trigger',
                                id: 'cat_name',
                                value: this.good.cat_name,
                                onSelect: function(record) {},
                                onTriggerClick: function() {
                                    getCategoryFormTree('index.php?model=goods&action=getcattree&com=0', 0, afterselect);
                                }
                            }), {
                                fieldLabel: '产品编码',
                                id: 'goods_sn',
                                value: this.good.goods_sn,
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                fieldLabel: 'SKU',
                                id: 'SKU',
                                value: this.good.SKU,
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                fieldLabel: '产品标题',
                                id: 'goods_name',
                                value: this.good.goods_name,
                                allowBlank: false,
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                fieldLabel: '产品链接',
                                value: this.good.goods_url,
                                id: 'goods_url',
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                xtype: 'combo',
                                store: new Ext.data.SimpleStore({
                                    fields: ["id", "key_type"],
                                    data: this.goods_data[0]
                                }),
                                valueField: "id",
                                displayField: "key_type",
                                mode: 'local',
                                width: 130,
                                editable: false,
                                forceSelection: true,
                                triggerAction: 'all',
                                hiddenName: 'status',
                                name: 'status',
                                value: this.good.status,
                                allowBlank: false,
                                fieldLabel: '产品状态',
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getName(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                xtype: 'combo',
                                store: new Ext.data.SimpleStore({
                                    fields: ["id", "key_type"],
                                    data: this.goods_data[2]
                                }),
                                valueField: "id",
                                displayField: "key_type",
                                mode: 'local',
                                width: 130,
                                editable: false,
                                forceSelection: true,
                                triggerAction: 'all',
                                hiddenName: 'brand_id',
                                name: 'brand_id',
                                allowBlank: false,
                                value: this.good.brand_id,
                                fieldLabel: '品牌',
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getName(), field.getValue(), 'goods');
                                    }
                                }
                            },
                            {
                                fieldLabel: '保质期',
                                name: 'keeptime',
                                format: 'Y-m-d',
                                xtype: 'datefield',
                                value: this.good.keeptime,
                                listeners: {
                                    change: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getName(), field.getValue(), 'goods');
                                    }
                                }
                            }]
                        },
                        {
                            fieldLabel: '净重',
                            value: this.good.grossweight,
                            id: 'grossweight',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '重量',
                            id: 'weight',
                            value: this.good.weight,
                            allowBlank: false,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '长',
                            value: this.good.l,
                            id: 'l',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '报关名英文',
                            value: this.good.dec_name,
                            id: 'dec_name',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '报关名中文',
                            id: 'dec_name_cn',
                            value: this.good.dec_name_cn,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '申报价值',
                            id: 'Declared_value',
                            xtype: 'numberfield',
                            value: this.good.Declared_value,
                            allowNegative: false,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '申报重量kg',
                            id: 'Declared_weight',
                            xtype: 'numberfield',
                            value: this.good.Declared_weight,
                            allowNegative: false,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        }]
                    },
                    {
                        columnWidth: .99,
                        layout: 'form',
                        defaultType: 'textfield',
                        items: [{
                            fieldLabel: '宽',
                            value: this.good.w,
                            id: 'w',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '管理库存',
                            xtype: 'checkbox',
                            id: 'is_control',
                            checked: (this.good.is_control > 0) ? true: false,
                            listeners: {
                                'check': function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }

                        },
                        {
                            fieldLabel: '有无子产品',
                            xtype: 'checkbox',
                            id: 'has_child',
                            checked: false,
                            checked: (this.good.has_child > 0) ? true: false,
                            listeners: {
                                'check': function(field, e) {
                                    Ext.getCmp('childaddBtn').setDisabled(!this.checked);
                                    Ext.getCmp('childsaveBtn').setDisabled(!this.checked);
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '自编码',
                            id: 'code',
                            value: this.good.code,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: 'UPC',
                            id: 'upc',
                            value: this.good.upc,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        }]
                    },
                    {
                        columnWidth: .99,
                        layout: 'form',
                        defaultType: 'textfield',
                        items: [{
                            fieldLabel: '产品图片',
                            value: this.good.goods_img,
                            id: 'goods_img',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '高',
                            value: this.good.h,
                            id: 'h',
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },
                        {
                            fieldLabel: '管理序列号',
                            xtype: 'checkbox',
                            id: 'sn_control',
                            checked: (this.good.sn_control > 0) ? true: false,
                            listeners: {
                                'check': function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }

                        },
                        {
                            fieldLabel: '组合产品',
                            xtype: 'checkbox',
                            id: 'is_group',
                            checked: false,
                            disabled: true
                        }]
                    }]
                },
                {
                    fieldLabel: '备注',
                    id: 'comment',
                    width: 600,
                    height: 30,
                    value: this.good.comment,
                    xtype: 'textarea',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                this.childgoodsGrid]
            },
            {
                id: 'tab2',
                title: '费用相关',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: '成本价',
                    width: 200,
                    name: 'cost',
                    id: 'cost',
                    value: this.good.cost,
                    hidden: (action[8] == 0) ? true: false,
                    readOnly: (action[9] == 0) ? true: false,
                    xtype: 'numberfield',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: '价格1',
                    width: 200,
                    name: 'price1',
                    id: 'price1',
                    hidden: (action[10] == 0) ? true: false,
                    readOnly: (action[11] == 0) ? true: false,
                    value: this.good.price1,
                    xtype: 'numberfield',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: '价格2',
                    width: 200,
                    name: 'price2',
                    id: 'price2',
                    hidden: (action[12] == 0) ? true: false,
                    readOnly: (action[13] == 0) ? true: false,
                    value: this.good.price2,
                    xtype: 'numberfield',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: '价格3',
                    width: 200,
                    name: 'price3',
                    id: 'price3',
                    hidden: (action[14] == 0) ? true: false,
                    readOnly: (action[15] == 0) ? true: false,
                    value: this.good.price3,
                    xtype: 'numberfield',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                }]
            },
            {
                id: 'tab3',
                title: '中国刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_CN',
                    width: 200,
                    name: 'Grade_cn',
                    id: 'Grade_cn',
                    value: this.good.Grade_cn,
                    tabTip: 'test',
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_cn',
                    width: 200,
                    name: 'plan_cn',
                    id: 'plan_cn',
                    value: this.good.plan_cn,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_cn',
                    width: 200,
                    name: 'price_cn',
                    id: 'price_cn',
                    xtype: 'numberfield',
                    value: this.good.price_cn,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                new Ext.ux.form.FCKeditor({
                    name: "des_cn",
                    width: 380,
                    height: 430,
                    id: "des_cn",
                    fieldLabel: "中文描述",
                    value: this.good.des_cn
                }), {
                    xtype: 'button',
                    text: '保存中文描述',
                    handler: function() {
                        modifymodel(thiz.good.goods_id, 'des_cn', Ext.getCmp('des_cn').getValue(), 'goods');
                    }
                }]
            },
            {
                id: 'tab4',
                title: '美国刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_US',
                    width: 200,
                    id: 'Grade_us',
                    value: this.good.Grade_us,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_US',
                    width: 200,
                    id: 'plan_us',
                    value: this.good.plan_us,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_US',
                    width: 200,
                    id: 'price_us',
                    xtype: 'numberfield',
                    value: this.good.price_us,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                new Ext.ux.form.FCKeditor({
                    name: "des_en",
                    width: 380,
                    height: 430,
                    id: "des_en",
                    fieldLabel: "英文描述",
                    value: this.good.des_en
                }), {
                    xtype: 'button',
                    text: '保存英文描述',
                    handler: function() {
                        modifymodel(thiz.good.goods_id, 'des_en', Ext.getCmp('des_en').getValue(), 'goods');
                    }
                }]
            },
            {
                id: 'tab5',
                title: '澳大利亚刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_AU',
                    width: 200,
                    id: 'Grade_au',
                    value: this.good.Grade_au,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_AU',
                    width: 200,
                    id: 'price_au',
                    xtype: 'numberfield',
                    value: this.good.price_au,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_AU',
                    width: 200,
                    id: 'plan_au',
                    value: this.good.plan_au,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                }]
            },
            {
                id: 'tab6',
                title: '英国刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_UK',
                    width: 200,
                    id: 'Grade_uk',
                    value: this.good.Grade_uk,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_UK',
                    width: 200,
                    id: 'price_uk',
                    xtype: 'numberfield',
                    value: this.good.price_uk,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_UK',
                    width: 200,
                    id: 'plan_uk',
                    value: this.good.Grade_uk,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                }]
            },
            {
                id: 'tab7',
                title: '德文刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_DE',
                    width: 200,
                    id: 'Grade_de',
                    value: this.good.Grade_de,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_DE',
                    width: 200,
                    id: 'plan_de',
                    value: this.good.plan_de,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_DE',
                    width: 200,
                    id: 'price_de',
                    xtype: 'numberfield',
                    value: this.good.price_de,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                new Ext.ux.form.FCKeditor({
                    name: "des_de",
                    width: 380,
                    height: 430,
                    id: "des_de",
                    fieldLabel: "德文描述",
                    value: this.good.des_de
                }), {
                    xtype: 'button',
                    text: '保存德文描述',
                    handler: function() {
                        modifymodel(thiz.good.goods_id, 'des_de', Ext.getCmp('des_de').getValue(), 'goods');
                    }
                }]
            },
            {
                id: 'tab8',
                title: '法文刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_FR',
                    width: 200,
                    id: 'Grade_fr',
                    value: this.good.Grade_fr,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_FR',
                    width: 200,
                    id: 'plan_fr',
                    value: this.good.plan_fr,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_FR',
                    width: 200,
                    id: 'price_fr',
                    xtype: 'numberfield',
                    value: this.good.price_fr,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                new Ext.ux.form.FCKeditor({
                    name: "des_fr",
                    width: 380,
                    height: 430,
                    id: "des_fr",
                    fieldLabel: "法文描述",
                    value: this.good.des_fr
                }), {
                    xtype: 'button',
                    text: '保存法文描述',
                    handler: function() {
                        modifymodel(thiz.good.goods_id, 'des_fr', Ext.getCmp('des_fr').getValue(), 'goods');
                    }
                }]
            },
            {
                id: 'tab9',
                title: '西班牙文刊登',
                layout: 'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_SP',
                    width: 200,
                    id: 'Grade_sp',
                    value: this.good.Grade_sp,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Plan_SP',
                    width: 200,
                    id: 'plan_sp',
                    value: this.good.plan_sp,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                {
                    fieldLabel: 'Price_SP',
                    width: 200,
                    id: 'price_sp',
                    xtype: 'numberfield',
                    value: this.good.price_sp,
                    listeners: {
                        change: function(field, e) {
                            modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                        }
                    }
                },
                new Ext.ux.form.FCKeditor({
                    name: "des_sp",
                    width: 380,
                    height: 430,
                    id: "des_sp",
                    fieldLabel: "西班牙文描述",
                    value: this.good.des_sp
                }), {
                    xtype: 'button',
                    text: '保存西班牙文描述',
                    handler: function() {
                        modifymodel(thiz.good.goods_id, 'des_sp', Ext.getCmp('des_sp').getValue(), 'goods');
                    }
                }]
            }]
        });
        return tab;
    },

    getTab: function() {
        if (!this.tab) {
            this.tab = this.creatTab();
        }
        return this.tab;
    },

    creatItems: function() {
        this.items = [this.tab];
    },

    addChilditem: function() {
        var Item = Ext.data.Record.create([{
            name: 'rec_id',
            type: 'float'
        },
        {
            name: 'child_sn',
            type: 'string'
        },
        {
            name: 'color',
            type: 'int'
        },
        {
            name: 'size',
            type: 'int'
        },
        {
            name: 'price',
            type: 'float'
        },
        {
            name: 'stock',
            type: 'float'
        }]);
        var p = new Item({
            rec_id: 0,
            child_sn: '',
            size: '0',
            color: '0',
            price: 0,
            stock: 0
        });
        this.childgoodsstore.insert(0, p);
        this.childgoodsGrid.startEditing(0, 0); // 光标停留在第几行几列
    },
    removeItem: function() { //移除组合物品
        var submitstore = this.childgoodsstore;
        var submiturl = this.delchildURL;
        var submitgrid = this.childgoodsGrid;
        var data = submitgrid.getSelectionModel().getSelected().data;
        var index = submitstore.findBy(function(record, id) {
            return record.get('goods_id') == data.goods_id && record.get('goods_qty') == data.goods_qty;
        });
        var id = data.rec_id;
        if (id == 0) {
            submitstore.remove(submitstore.getAt(index));
            return;
        }
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?',
            function(btn) {
                if (btn == 'yes') {
                    Ext.Ajax.request({
                        url: submiturl + '&id=' + id,
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                submitstore.remove(submitstore.getAt(index));
                                Ext.example.msg('MSG', res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            },
            this.goodsGrid);
        }
    },

    saveItem: function() {
        var jsonArray = [];
        var submitstore = this.childgoodsstore;
        var submiturl = this.savechildURL;
        if (this.getForm().getFieldValues().has_child) {
            var m = submitstore.modified.slice(0);
            Ext.each(m,
            function(item) {
                jsonArray.push(item.data);
            });
            Ext.getBody().mask("正在提交数据.请稍等...", "x-mask-loading");
            Ext.Ajax.request({
                url: submiturl,
                loadMask: true,
                params: {
                    'data': Ext.encode(jsonArray),
                    'goods_id': this.good.goods_id
                },
                success: function(response, opts) {
                    var res = Ext.decode(response.responseText);
                    Ext.getBody().unmask();
                    if (res.success) {
                        submitstore.commitChanges();
                        submitstore.reload();
                        Ext.example.msg('MSG', res.msg);
                    } else {
                        Ext.Msg.alert('ERROR', res.msg);
                    }
                }
            });
        } else {
            Ext.example.msg('请确认有无子产品已被选中');
        }
    }
});