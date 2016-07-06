Ext.define('Ext.ux.editgoodsForm',{
	extend:'Ext.form.Panel',
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
        this.childgoodsGrid.getSelectionModel().on('selectionchange',function(sm) {
            Ext.getCmp('childremoveBtn').setDisabled(sm.getCount()<1);
        });
        this.childgoodsstore.on('add',function() {
            Ext.getCmp('childsaveBtn').setDisabled(false);
        });
        this.childgoodsstore.on('update',function() {
            Ext.getCmp('childsaveBtn').setDisabled(false);
        });
        if (this.action[0] == 0) this.tab.items.item[0].setDisabled(true);
        //if (this.action[1] == 0) this.tab.items.item[1].setDisabled(true);
        //if (this.action[2] == 0) this.tab.items.item[2].setDisabled(true);
        //if (this.action[3] == 0) this.tab.items.item[3].setDisabled(true);
        //if (this.action[4] == 0) this.tab.items.item[4].setDisabled(true);
        //if (this.action[5] == 0) this.tab.items.item[5].setDisabled(true);
       // if (this.action[6] == 0) this.tab.items.item[6].setDisabled(true);
        //if (this.action[7] == 0) this.tab.items.item[7].setDisabled(true);
        this.callParent();
    },
    creatChildGoodsstore: function() { //子产品明细store
		this.model = Ext.define('CombineGood', {
			extend: 'Ext.data.Model',
			fields: [{name: 'child_sn'},{name: 'color'}, {name: 'size'},{name: 'price'},{name: 'stock'}
			]
		});
		this.childgoodsstore = Ext.create('Ext.data.JsonStore', {
			model:this.model,
			remoteSort:true,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.childlistURL,
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			}
		});
		this.childgoodsstore.load({
			params:{goods_id: this.good.goods_id},
			scope:this.childgoodsstore
		});
    },
    creatChildGridcm: function() {
        var thiz = this;
        this.childcmlist = [{
            header: '子产品编码<font color=red>*</font>',
            dataIndex: 'child_sn',
            width: 100,
            align: 'left',
            editor: {
                allowBlank: false,
                hideLabel: true
            }
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
            editor: {
				xtype:'numberfield',
				hideTrigger:true,
                minValue:0,
                hideLabel: true
            }
        },
        {
            header: '库存数量<font color=red>*</font>',
            dataIndex: 'stock',
            align: 'right',
            editor: {
				xtype:'numberfield',
                allowBlank: false,
				hideTrigger:true,
                minValue:0,
                allowDecimals: false,
                style: 'text-align:left'
            }
        }];
    },

    creatChildGoodsgrid: function() { //创建子产品明细
        this.childgoodsGrid = Ext.create('Ext.grid.Panel',{
            title: '子产品明细',
            height: 300,
            columns: this.childcmlist,
            store: this.childgoodsstore,
            selModel: Ext.create('Ext.selection.RowModel',{
				mode: 'SINGLE'
			}),
			plugins:[ Ext.create('Ext.grid.plugin.CellEditing', {
					clicksToEdit: 1
				})
			],
            viewConfig: {
				stripeRows: true, // 让基数行和偶数行的颜色不一样
                forceFit: true
            },
            iconCls: 'icon-grid',
            tbar: [{
				xtype: 'button',
				text: '新增子产品',
				id: 'childaddBtn',
				disabled: (this.good.has_child > 0) ? false: true,
				iconCls: 'x-tbar-add',
				handler: this.addChilditem.bind(this)
			},
			{
				text: '删除',
				iconCls: 'x-tbar-del',
				id: 'childremoveBtn',
				handler: this.removeItem.bind(this),
				disabled: true
			},
			{
				text: '保存',
				iconCls: 'x-tbar-save',
				id: 'childsaveBtn',
				handler: this.saveItem.bind(this),
				disabled: true
			}]
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
        var tab = Ext.create('Ext.tab.Panel',{
            activeTab: 0,
            height:580,
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
                    },{
                        columnWidth: .99,
                        frame: false,
                        title: '基本信息',
                        items: [{
                            xtype: 'fieldset',
							margin:'10px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border: true,
                            items: [{
								xtype:'triggerfield',
                                editable: false,
								width : 350,
                                fieldLabel: '所属分类',
                                id: 'cat_name',
                                value: this.good.cat_name,
                                onSelect: function(record) {},
                                onTriggerClick: function() {
                                    getCategoryFormTree('index.php?model=goods&action=getcattree&com=0', 0, afterselect);
                                }
                            }, {
								xtype:'textfield',
                                fieldLabel: '产品编码',
                                id: 'goods_sn',
                                value: this.good.goods_sn,
                                listeners: {
                                    blur: function(field, e) {
										if(Ext.getCmp('goodform').getForm().findField('goods_sn').getValue() == thiz.good.goods_sn){ return;}
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },{
								
                                fieldLabel: 'SKU',
                                id: 'SKU',
                                value: this.good.SKU,
                                listeners: {
                                    blur: function(field, e) {
										if(Ext.getCmp('goodform').getForm().findField('SKU').getValue() == thiz.good.SKU){ return;}
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },{
                                xtype: 'combo',
                                store: Ext.create('Ext.data.ArrayStore',{
                                    fields: ["id", "key_type"],
                                    data: this.goods_data[0]
                                }),
                                valueField: "id",
                                displayField: "key_type",
                                mode: 'local',
                                width: 300,
                                editable: false,
                                forceSelection: true,
                                triggerAction: 'all',
                                hiddenName: 'status',
                                name: 'status',
                                value: this.good.status,
                                fieldLabel: '产品状态',
                                listeners: {
                                    blur: function(field, e) {
                                        modifymodel(thiz.good.goods_id, field.getName(), field.getValue(), 'goods');
                                    }
                                }
                            },{
                                fieldLabel: '产品标题',
                                id: 'goods_name',
								width: 400,
                                value: this.good.goods_name,
                                allowBlank: false,
                                listeners: {
                                    blur: function(field, e) {
										if(Ext.getCmp('goodform').getForm().findField('goods_name').getValue() == thiz.good.goods_name){ return;}
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },{
                                fieldLabel: '产品链接',
                                value: this.good.goods_url,
                                width: 300,
                                id: 'goods_url',
                                 listeners: {
                                    blur: function(field, e) {
										if(Ext.getCmp('goodform').getForm().findField('goods_url').getValue() == thiz.good.goods_url){ return;}
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            },{
                                fieldLabel: '保质期',
                                name: 'keeptime',
								id : 'keeptime',
                                format: 'Y-m-d',
                                xtype: 'datefield',
                                value: this.good.keeptime,
                                listeners: {
                                    blur: function(field, e) {
										if(Ext.getCmp('goodform').getForm().findField('keeptime').getValue() == thiz.good.keeptime){ return;}
                                        modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                    }
                                }
                            }]
                        },{
							columnWidth:.99,
						layout: 'form',
						title: '物流属性',
						border:false,
						frame:false,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							labelWidth: 80,
							border:false,
							margin: '0px 10px 10px 10px',
							items:[{
							xtype:'textfield',
                            fieldLabel: '净重',
							width: 300,
                            value: this.good.grossweight,
                            id: 'grossweight',
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('grossweight').getValue() == thiz.good.grossweight){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
							xtype:'textfield',
                            fieldLabel: '重量',
                            id: 'weight',
							width: 300,
                            value: this.good.weight,
                            allowBlank: false,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('weight').getValue() == thiz.good.weight){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            xtype:'textfield',
							fieldLabel: '长',
                            value: this.good.l,
                            id: 'l',
							width: 300,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('l').getValue() == thiz.good.l){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            fieldLabel: '报关名英文',
                            value: this.good.dec_name,
                            id: 'dec_name',
							width: 300,
							xtype:'textfield',
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('dec_name').getValue() == thiz.good.dec_name){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            fieldLabel: '报关名中文',
                            id: 'dec_name_cn',
							width: 300,
							xtype:'textfield',
                            value: this.good.dec_name_cn,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('dec_name_cn').getValue() == thiz.good.dec_name_cn){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            fieldLabel: '申报价值',
                            id: 'Declared_value',
                            xtype: 'numberfield',
							name : 'Declared_value',
							hideTrigger:true,
							width: 300,
                            value: this.good.Declared_value,
                            minValue:0,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('Declared_value').getValue() == thiz.good.Declared_value){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            fieldLabel: '申报重量kg',
                            id: 'Declared_weight',
							name : 'Declared_weight',
                            xtype: 'numberfield',
							hideTrigger:true,
							width: 300,
                            value: this.good.Declared_weight,
                            minValue:0,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('Declared_weight').getValue() == thiz.good.Declared_weight){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },{
                            fieldLabel: '宽',
							width: 300,
                            value: this.good.w,
                            id: 'w',
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('w').getValue() == thiz.good.w){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },
                        {
                            fieldLabel: '高',
                            value: this.good.h,
                            width: 300,
                            id: 'h',
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('h').getValue() == thiz.good.h){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        }]
						}]
                    },{
						columnWidth:.99,
						frame:false,
						border:false,
						title: '其他信息',
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							margin: '0px 0px 10px 10px',
							defaultType: 'textfield',
							labelWidth: 80,
							border:false,
							items:[{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.combolist[2]
								}),
								value:(this.good.product_purchaser == 0) ? '' : this.good.product_purchaser,
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								id:'product_purchaser',
								triggerAction: 'all',
								hiddenName:'product_purchaser',
								name: 'product_purchaser',
								fieldLabel: '采购员',
								listeners: {
									change: function(field, e) {
										modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
									}
								}
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.combolist[2]
								}),
								value:(this.good.products_developers == 0) ? '' : this.good.products_developers,
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								id:'products_developers',
								triggerAction: 'all',
								hiddenName:'products_developers',
								name: 'products_developers',
								fieldLabel: '产品开发员',
								listeners: {
									change: function(field, e) {
										modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
									}
								}
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.combolist[2]
								}),
								value:(this.good.product_operation == 0) ? '' : this.good.product_operation,
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								id:'product_operation',
								triggerAction: 'all',
								hiddenName:'product_operation',
								name: 'product_operation',
								fieldLabel: '产品运营员',
								listeners: {
									change: function(field, e) {
										modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
									}
								}
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.combolist[2]
								}),
								value:(this.good.product_quality_inspector == 0) ? '' : this.good.product_quality_inspector,
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								id:'product_quality_inspector',
								triggerAction: 'all',
								hiddenName:'product_quality_inspector',
								name: 'product_quality_inspector',
								fieldLabel: '产品质检员',
								listeners: {
									change: function(field, e) {
										modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
									}
								}
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.combolist[2]
								}),
								value:(this.good.product_rights_checker == 0) ? '' : this.good.product_rights_checker,
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								id:'product_rights_checker',
								triggerAction: 'all',
								hiddenName:'product_rights_checker',
								name: 'product_rights_checker',
								fieldLabel: '产品侵权审核员',
								listeners: {
									change: function(field, e) {
										modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
									}
								}
							},{
                            fieldLabel: '管理库存',
                            xtype: 'checkbox',
                            id: 'is_control',
                            checked: (this.good.is_control > 0) ? true: false,
                            listeners: {
                                change: function(field, e) {
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }

                        },{
                            fieldLabel: 'UPC',
                            id: 'upc',
							name : 'upc',
							width: 300,
                            value: this.good.upc,
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('upc').getValue() == thiz.good.upc){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        },{
							fieldLabel: '备注',
							id: 'comment',
							name : 'comment',
							width: 600,
							height: 65,
							value: this.good.comment,
							xtype: 'textarea',
							listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('comment').getValue() == thiz.good.comment){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
						},{
                            fieldLabel: '产品图片',
                            value: this.good.goods_img,
							width:550,
                            id: 'goods_img',
							name : 'goods_img',
                            listeners: {
								blur: function(field, e) {
									if(Ext.getCmp('goodform').getForm().findField('goods_img').getValue() == thiz.good.goods_img){ return;}
									modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
								}
							}
                        }]
						}]},{
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '美国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[
                            {
                                
                            fieldLabel: '美国销售价格',
                            width: 220,
                            id: 'price_us',
                            name : 'price_us',
                            value: thiz.good.price_us,
                            listeners: {
                                blur: function(field, e) {
                                    if(Ext.getCmp('goodform').getForm().findField('price_us').getValue() == thiz.good.price_us){ return;}
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },{
                            xtype: 'button',
                            text: '保存描述(描述需点击保存)',
                            iconCls: 'x-tbar-update',
                            handler: function(){
                               modifymodel(thiz.good.goods_id, 'des_en', Ext.getCmp('des_en').getValue(), 'goods'); 
                            }
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_en',
                            id:'des_en',
                            autoScroll:true,
                            width:900,
                            height:300,
                            coreStyles_bold:{element:'span',attributes:{'class': 'Bold'} },
                            coreStyles_italic:{element:'span',attributes:{'class': 'Italic'}},
                            coreStyles_underline:{element:'span',attributes:{'class': 'Underline'}},
                            coreStyles_strike:{element:'span',attributes:{'class':'StrikeThrough'},overrides:'strike'},
                            coreStyles_subscript:{element:'span',attributes:{'class': 'Subscript'},overrides:'sub'},
                            coreStyles_superscript : { element : 'span',attributes:{'class':'Superscript'},overrides:'sup'},
                            font_names: 'Comic Sans MS/FontComic;Courier New/FontCourier;Times New Roman/FontTimes',
                            font_style:{
                                    element:'span',
                                    attributes:{'class':'#(family)'},
                                    overrides:[{element:'span',attributes:{'class':/^Font(?:Comic|Courier|Times)$/ }}]
                            },
                            fontSize_sizes:'Smaller/FontSmaller;Larger/FontLarger;8pt/FontSmall;14pt/FontBig;Double Size/FontDouble',
                            fontSize_style:{
                            element:'span',
                            attributes:{'class':'#(size)'},
                            overrides:[{element:'span',attributes:{'class':/^Font(?:Smaller|Larger|Small|Big|Double)$/} }]
                            },
                            colorButton_enableMore : false,
                            colorButton_colors:'FontColor1/FF9900,FontColor2/0066CC,FontColor3/F00',
                            colorButton_foreStyle :{
                                element : 'span',
                                attributes : {'class':'#(color)'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
                            },
                            indentClasses : ['Indent1', 'Indent2', 'Indent3'],
                            justifyClasses : [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull' ],
                            stylesSet:[
                                {name:'Strong Emphasis',element:'strong'},
                                {name:'Emphasis',element:'em'},
                                {name:'Computer Code',element:'code'},
                                {name:'Keyboard Phrase',element:'kbd'},
                                {name:'Sample Text',element:'samp'},
                                {name:'Variable',element:'var'},
                                {name:'Deleted Text',element:'del'},
                                {name:'Inserted Text',element:'ins'},
                                {name:'Cited Work',element:'cite'},
                                {name:'Inline Quotation',element:'q' }
                            ]
                            })]
                    }]},
                    {
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '德国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[
                            
                            
                            {
                                
                            fieldLabel: '德国销售价格',
                            width: 220,
                            id: 'price_de',
                            name : 'price_de',
                            value: thiz.good.price_de,
                            listeners: {
                                blur: function(field, e) {
                                    if(Ext.getCmp('goodform').getForm().findField('price_de').getValue() == thiz.good.price_us){ return;}
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },{
                            xtype: 'button',
                            text: '保存描述(描述需点击保存)',
                            iconCls: 'x-tbar-update',
                            handler: function(){
                               modifymodel(thiz.good.goods_id, 'des_de', Ext.getCmp('des_de').getValue(), 'goods'); 
                            }
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_de',
                            id:'des_de',
                            autoScroll:true,
                            width:900,
                            height:300,
                            coreStyles_bold:{element:'span',attributes:{'class': 'Bold'} },
                            coreStyles_italic:{element:'span',attributes:{'class': 'Italic'}},
                            coreStyles_underline:{element:'span',attributes:{'class': 'Underline'}},
                            coreStyles_strike:{element:'span',attributes:{'class':'StrikeThrough'},overrides:'strike'},
                            coreStyles_subscript:{element:'span',attributes:{'class': 'Subscript'},overrides:'sub'},
                            coreStyles_superscript : { element : 'span',attributes:{'class':'Superscript'},overrides:'sup'},
                            font_names: 'Comic Sans MS/FontComic;Courier New/FontCourier;Times New Roman/FontTimes',
                            font_style:{
                                    element:'span',
                                    attributes:{'class':'#(family)'},
                                    overrides:[{element:'span',attributes:{'class':/^Font(?:Comic|Courier|Times)$/ }}]
                            },
                            fontSize_sizes:'Smaller/FontSmaller;Larger/FontLarger;8pt/FontSmall;14pt/FontBig;Double Size/FontDouble',
                            fontSize_style:{
                            element:'span',
                            attributes:{'class':'#(size)'},
                            overrides:[{element:'span',attributes:{'class':/^Font(?:Smaller|Larger|Small|Big|Double)$/} }]
                            },
                            colorButton_enableMore : false,
                            colorButton_colors:'FontColor1/FF9900,FontColor2/0066CC,FontColor3/F00',
                            colorButton_foreStyle :{
                                element : 'span',
                                attributes : {'class':'#(color)'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
                            },
                            indentClasses : ['Indent1', 'Indent2', 'Indent3'],
                            justifyClasses : [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull' ],
                            stylesSet:[
                                {name:'Strong Emphasis',element:'strong'},
                                {name:'Emphasis',element:'em'},
                                {name:'Computer Code',element:'code'},
                                {name:'Keyboard Phrase',element:'kbd'},
                                {name:'Sample Text',element:'samp'},
                                {name:'Variable',element:'var'},
                                {name:'Deleted Text',element:'del'},
                                {name:'Inserted Text',element:'ins'},
                                {name:'Cited Work',element:'cite'},
                                {name:'Inline Quotation',element:'q' }
                            ]
                            })]
                    }]},
                    {
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '法国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[
                            
                            
                            {
                                
                            fieldLabel: '法国销售价格',
                            width: 220,
                            id: 'price_fr',
                            name : 'price_fr',
                            value: thiz.good.price_fr,
                            listeners: {
                                blur: function(field, e) {
                                    if(Ext.getCmp('goodform').getForm().findField('price_fr').getValue() == thiz.good.price_us){ return;}
                                    modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
                                }
                            }
                        },{
                            xtype: 'button',
                            text: '保存描述(描述需点击保存)',
                            iconCls: 'x-tbar-update',
                            handler: function(){
                               modifymodel(thiz.good.goods_id, 'des_fr', Ext.getCmp('des_fr').getValue(), 'goods'); 
                            }
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_fr',
                            id:'des_fr',
                            autoScroll:true,
                            width:900,
                            height:300,
                            coreStyles_bold:{element:'span',attributes:{'class': 'Bold'} },
                            coreStyles_italic:{element:'span',attributes:{'class': 'Italic'}},
                            coreStyles_underline:{element:'span',attributes:{'class': 'Underline'}},
                            coreStyles_strike:{element:'span',attributes:{'class':'StrikeThrough'},overrides:'strike'},
                            coreStyles_subscript:{element:'span',attributes:{'class': 'Subscript'},overrides:'sub'},
                            coreStyles_superscript : { element : 'span',attributes:{'class':'Superscript'},overrides:'sup'},
                            font_names: 'Comic Sans MS/FontComic;Courier New/FontCourier;Times New Roman/FontTimes',
                            font_style:{
                                    element:'span',
                                    attributes:{'class':'#(family)'},
                                    overrides:[{element:'span',attributes:{'class':/^Font(?:Comic|Courier|Times)$/ }}]
                            },
                            fontSize_sizes:'Smaller/FontSmaller;Larger/FontLarger;8pt/FontSmall;14pt/FontBig;Double Size/FontDouble',
                            fontSize_style:{
                            element:'span',
                            attributes:{'class':'#(size)'},
                            overrides:[{element:'span',attributes:{'class':/^Font(?:Smaller|Larger|Small|Big|Double)$/} }]
                            },
                            colorButton_enableMore : false,
                            colorButton_colors:'FontColor1/FF9900,FontColor2/0066CC,FontColor3/F00',
                            colorButton_foreStyle :{
                                element : 'span',
                                attributes : {'class':'#(color)'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
                            },
                            indentClasses : ['Indent1', 'Indent2', 'Indent3'],
                            justifyClasses : [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull' ],
                            stylesSet:[
                                {name:'Strong Emphasis',element:'strong'},
                                {name:'Emphasis',element:'em'},
                                {name:'Computer Code',element:'code'},
                                {name:'Keyboard Phrase',element:'kbd'},
                                {name:'Sample Text',element:'samp'},
                                {name:'Variable',element:'var'},
                                {name:'Deleted Text',element:'del'},
                                {name:'Inserted Text',element:'ins'},
                                {name:'Cited Work',element:'cite'},
                                {name:'Inline Quotation',element:'q' }
                            ]
                            })]
                    }]}
                    
                    ]
                }]
				}]
			},{
                id: 'tab2',
                title: '产品价格',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: '成本价',
					padding:'10px 0px 0px 0px',
                    width: 200,
                    name: 'cost',
                    id: 'cost',
					hideTrigger:true,
                    value: this.good.cost,
                    hidden: (action[8] == 0) ? true: false,
                    readOnly: (action[9] == 0) ? true: false,
                    xtype: 'numberfield',
                    listeners: {
						blur: function(field, e) {
							if(Ext.getCmp('goodform').getForm().findField('cost').getValue() == thiz.good.cost){ return;}
							modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
						}
					}
                },{
                    fieldLabel: '价格1',
                    width: 200,
					hideTrigger:true,
                    name: 'price1',
                    id: 'price1',
                    hidden: (action[10] == 0) ? true: false,
                    readOnly: (action[11] == 0) ? true: false,
                    value: this.good.price1,
                    xtype: 'numberfield',
                    listeners: {
						blur: function(field, e) {
							if(Ext.getCmp('goodform').getForm().findField('price1').getValue() == thiz.good.price1){ return;}
							modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
						}
					}
                },{
                    fieldLabel: '价格2',
                    width: 200,
					hideTrigger:true,
                    name: 'price2',
                    id: 'price2',
                    hidden: (action[12] == 0) ? true: false,
                    readOnly: (action[13] == 0) ? true: false,
                    value: this.good.price2,
                    xtype: 'numberfield',
                    listeners: {
						blur: function(field, e) {
							if(Ext.getCmp('goodform').getForm().findField('price2').getValue() == thiz.good.price2){ return;}
							modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
						}
					}
                },{
                    fieldLabel: '价格3',
                    width: 200,
                    name: 'price3',
					hideTrigger:true,
                    id: 'price3',
                    hidden: (action[14] == 0) ? true: false,
                    readOnly: (action[15] == 0) ? true: false,
                    value: this.good.price3,
                    xtype: 'numberfield',
                    listeners: {
						blur: function(field, e) {
							if(Ext.getCmp('goodform').getForm().findField('price3').getValue() == thiz.good.price3){ return;}
							modifymodel(thiz.good.goods_id, field.getId(), field.getValue(), 'goods');
						}
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
        var me = this;
        this.items = [this.tab];
        Ext.onReady(function(){
           
             Ext.getCmp('des_en').setValue(me.good.des_en);
             Ext.getCmp('des_de').setValue(me.good.des_de);
             Ext.getCmp('des_fr').setValue(me.good.des_fr);    
        });
    },

    addChilditem: function() {
        
        var p = Ext.create(this.model,{
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
        var data = submitgrid.getSelectionModel().getSelection()[0].data;
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
            var m = submitstore.getModifiedRecords().slice(0);
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
                        submitstore.load();
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