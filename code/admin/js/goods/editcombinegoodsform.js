Ext.define('Ext.ux.editgoodsForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = true,
		this.fileUpload = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatselectstore();
		this.creatGridcm();
		this.txt_totQty = Ext.create('Ext.form.field.Text',{
			id : 'txt_totQty',
			anchor : '95%',
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		}),
		this.creatGoodsstore();
		this.creatGoodsgrid();
		this.getTab();
		this.creatItems();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(sm.getCount()<1);
			Ext.getCmp('editBtn').setDisabled(sm.getCount()<1);
		});
		this.goodsstore.on('add',function(){
			Ext.getCmp('saveBtn').setDisabled(false);
		});
		this.goodsstore.on('update',function(){
			Ext.getCmp('saveBtn').setDisabled(false);
		});
		 if (this.action[0] == 0) this.tab.items.item[0].setDisabled(true);
        if (this.action[1] == 0) this.tab.items.item[1].setDisabled(true);
        if (this.action[2] == 0) this.tab.items.item[2].setDisabled(true);
        if (this.action[3] == 0) this.tab.items.item[3].setDisabled(true);
        if (this.action[4] == 0) this.tab.items.item[4].setDisabled(true);
        if (this.action[5] == 0) this.tab.items.item[5].setDisabled(true);
        if (this.action[6] == 0) this.tab.items.item[6].setDisabled(true);
        if (this.action[7] == 0) this.tab.items.item[7].setDisabled(true);
        this.callParent(this);
    },
	creatGoodsstore:function(){//订单明细store
		this.model =Ext.define('CombineGood', {
			extend: 'Ext.data.Model',
			fields: [{name: 'child_sn'},{name: 'color'}, {name: 'size'},{name: 'price'},{name: 'stock'}
			]
		});
		this.goodsstore = Ext.create('Ext.data.JsonStore', {
			model:this.model,
			remoteSort:true,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			},
			listeners : {
				'load' : this.calculate.bind(this),
				'add' : this.calculate.bind(this),
				'remove' : this.calculate.bind(this),
				'update' : this.calculate.bind(this)
			}
		});
		this.goodsstore.load({
			params:{comb_goods_id : this.good.goods_id}
		});
	},
	creatGridcm:function(){
		var thiz =this;
		this.cmlist = [{
			header : '产品编码<font color=red>*</font>',
			dataIndex:'goods_sn',
			flex:1,
			align : 'left',
			editor:{
				allowBlank:false,
				readOnly:true,
				hideLabel:true
			}
		}, {
			header:'产品名称<font color=red>*</font>',
			flex:1,
			dataIndex:'goods_name',
			align:'left',
			editor:{
				allowBlank:false,
				readOnly:true,
				hideLabel:true
			}
		}, {
			header:'产品数量<font color=red>*</font>',
			dataIndex:'goods_qty',
			align:'right',
			flex:1,
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				minValue:0,
				decimalPercision:4,
				style:'text-align:left'
			}
		}];
	},

	creatGoodsgrid:function(){//创建产品明细
		this.goodsGrid = Ext.create('Ext.grid.Panel',{
			id : "destPanel",
			title:'组合产品明细',
			height : 400,
			columns : this.cmlist,
			store : this.goodsstore,
			selModel: Ext.create('Ext.selection.RowModel',{
				mode: 'SINGLE'
			}),
			plugins:[Ext.create('Ext.grid.plugin.CellEditing', {
				clicksToEdit: 1
			})],
			viewConfig : {
				stripeRows : true, // 让基数行和偶数行的颜色不一样
				forceFit : true
			},
			iconCls : 'icon-grid',
			tbar : [{
				xtype:'button',
				text:'新增产品',
				id: 'addBtn',
				iconCls: 'x-tbar-add',
				handler:this.createWindow.bind(this,['0'])
			},{
				xtype:'button',
				text:'编辑产品',
				id: 'editBtn',
				disabled:true,
				iconCls: 'x-tbar-update',
				handler:this.createWindow.bind(this,['1'])
			},{
				text: '删除',
				iconCls: 'x-tbar-del',
				id: 'removeBtn',
				handler: this.removeItem.bind(this,['1']),
				disabled:true
			},{
				text: '保存',
				iconCls: 'x-tbar-save',
				id: 'saveBtn',
				handler: this.saveItem.bind(this,['1']),
				disabled:true
			}],
			bbar : Ext.create('Ext.toolbar.Toolbar',{
				cls : 'u-toolbar-b',
				items : ['合计:', '->', '数量:', this.txt_totQty]
			})
		});
	},

	creatTab:function(){
		var thiz = this;
		var goodsgrid = this.goodsGrid;
		var action = this.action;
		var tab = Ext.create('Ext.tab.Panel',{
			activeTab: 0,
			defaults:{autoScroll: true,autoHeight:true},
			items:[{
			    id:'tab1',
                title: '基本信息',
				height:600,
				margin: '10px',
                items:[{
				   layout:'column',
				   items:[{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							fieldLabel: '产品编码',
							id:'goods_sn',
							width: 350,
							value:this.good.goods_sn,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '产品名称',id:'goods_name',value:this.good.goods_name,
							width: 350,
							allowBlank:false,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							xtype:'combo',
							width: 350,
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: this.goods_data[0]
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'status',
							name: 'status',
							value:this.good.status,
							allowBlank:false,
							fieldLabel: '产品状态',
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getName(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '报关单简称',
							value:this.good.dec_name,
							width: 350,
							id:'dec_name',
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '自编码',
							width: 350,
							id:'code',
							value:this.good.code,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '组合产品',
							width: 350,
							xtype:'checkbox',
							id:'is_group',
							checked:true,
							hidden : true
						},{
							fieldLabel: '产品ID',id:'goods_id',value:this.good.goods_id,
							xtype:'hidden'
						}]
					},{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							xtype:'combo',
							width: 350,
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: this.goods_data[2]
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'brand_id',
							name: 'brand_id',
							allowBlank:false,
							value:this.good.brand_id,
							fieldLabel: '品牌',
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getName(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: 'SKU',id:'sku',value:this.good.SKU,
							width: 350,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '保质期',
							width: 350,
							id:'keeptime',
							format:'Y-m-d',
							xtype:'datefield',
							value:this.good.keeptime,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '报关名中文',
							width: 350,
							id:'dec_name_cn',
							value:this.good.dec_name_cn,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '管理库存',
							width: 350,
							xtype:'checkbox',
							id:'is_control',
							checked:true,
							hidden:true
						},{
							fieldLabel: '有无子产品',
							width: 350,
							xtype:'checkbox',
							id:'has_child',
							checked:false,
							checked:false,
							hidden : true
						}]
					},{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							xtype:'combo',
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: this.goods_data[1]
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							width: 350,
							editable: false,
							forceSelection: true,
							value:this.good.cat_id,
							triggerAction: 'all',
							hiddenName:'cat_id',
							name: 'cat_id',
							allowBlank:false,
							fieldLabel: '分类',
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getName(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '产品链接',value:this.good.goods_url,id:'goods_url',
							width: 350,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '产品图片',value:this.good.goods_img,id:'goods_img',
							width: 350,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '申报价值',
							id:'Declared_value',
							width: 350,
							xtype:'numberfield',
							value:this.good.Declared_value,
							minValue:0,
							hideTrigger:true,
							listeners: {
								change:function(field,e){
									modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
								}
							}
						},{
							fieldLabel: '重量',
							width: 350,
							id:'weight',
							value:this.good.weight,
							allowBlank:false,
							hidden : true
						}]
					}]
				},{
					fieldLabel: '备注',
					id:'comment',
					width:600,
					height:30,
					value:this.good.comment,
					xtype:'textarea',
					margin: '0px 0px 10px 0px',
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
				},this.goodsGrid]
            },{
				id:'tab2',
                title: '产品价格',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: '成本价',
					width:350,
                    name: 'cost',
					id: 'cost',
					value:this.good.cost,
					hidden:(action[8]==0)?true:false,
					readOnly:(action[9]==0)?true:false,
					xtype:'numberfield',
					hideTrigger:true,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: '价格1',
					width:350,
                    name: 'price1',
					id: 'price1',
					hideTrigger:true,
					value:this.good.price1,
					hidden:(action[10]==0)?true:false,
					readOnly:(action[11]==0)?true:false,
					xtype:'numberfield',
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: '价格2',
					width:350,
                    name: 'price2',
					id: 'price2',
					value:this.good.price2,
					hideTrigger:true,
					hidden:(action[12]==0)?true:false,
					readOnly:(action[13]==0)?true:false,
					xtype:'numberfield',
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: '价格3',
					width:250,
                    name: 'price3',
					id: 'price3',
					value:this.good.price3,
					hidden:(action[14]==0)?true:false,
					readOnly:(action[15]==0)?true:false,
					hideTrigger:true,
					xtype:'numberfield',
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                }]
            },{
				id:'tab3',
                title: '中国刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_CN',
					width:350,
                    name: 'Grade_cn',
					id: 'Grade_cn',
					value:this.good.Grade_cn,
					tabTip:'test',
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_cn',
					width:350,
                    name: 'plan_cn',
					id: 'plan_cn',
					value:this.good.plan_cn,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_cn',
					width:350,
                    name: 'price_cn',
					id: 'price_cn',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_cn,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_cn", 
					width:'90%',
					height:430, 
					id : "des_cn", 
					fieldLabel : "中文描述", 
					value:this.good.des_cn
				}),{
					xtype:'button',
					text:'保存描述',
					handler:function(){
						modifymodel(thiz.good.goods_id,'des_cn',Ext.getCmp('des_cn').getValue(),'goods');
					}		
				}]
			},{
				id:'tab4',
                title: '美国刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_US',
					width:350,
                    id: 'Grade_us',
					value:this.good.Grade_us,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_US',
					width:350,
                    id: 'plan_us',
					value:this.good.plan_us,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_US',
					width:350,
                    id: 'price_us',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_us,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_en", 
					width:'90%',
					height:430, 
					id : "des_en", 
					fieldLabel : "英文描述", 
					value:this.good.des_en
				}),{
					xtype:'button',
					text:'保存英文描述',
					handler:function(){
						modifymodel(thiz.good.goods_id,'des_en',Ext.getCmp('des_en').getValue(),'goods');
					}		
				}]
            },{
				id:'tab5',
                title: '澳大利亚刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_AU',
					width:350,
                    id: 'Grade_au',
					value:this.good.Grade_au,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_AU',
					width:350,
                    id: 'price_au',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_au,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_AU',
					width:350,
                    id: 'plan_au',
					value:this.good.plan_au,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                }]
            },{
				id:'tab6',
                title: '英国刊登',
                defaultType: 'textfield',
				buttonAlign:'center',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_UK',
					width:350,
                    id: 'Grade_uk',
					value:this.good.Grade_uk,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_UK',
					width:350,
                    id: 'price_uk',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_uk,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_UK',
					width:350,
                    id: 'plan_uk',
					value:this.good.Grade_uk,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                }]
            },{
				id:'tab7',
                title: '德文刊登',
                defaultType: 'textfield',
				buttonAlign:'center',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_DE',
					width:350,
                    id: 'Grade_de',
					value:this.good.Grade_de,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_DE',
					width:350,
                    id: 'plan_de',
					value:this.good.plan_de,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_DE',
					width:350,
                    id: 'price_de',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_de,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_de", 
					width:'90%',
					height:430, 
					id : "des_de", 
					fieldLabel : "德文描述", 
					value:this.good.des_de
				}),{
					xtype:'button',
					text:'保存德文描述',
					handler:function(){
					modifymodel(thiz.good.goods_id,'des_de',Ext.getCmp('des_de').getValue(),'goods');
					}		
				}]
			},{
				id:'tab8',
                title: '法文刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_FR',
					width:350,
                    id: 'Grade_fr',
					value:this.good.Grade_fr,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_FR',
					width:350,
                    id: 'plan_fr',
					value:this.good.plan_fr,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_FR',
					width:350,
                    id: 'price_fr',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_fr,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_fr", 
					width:'90%',
					height:430, 
					id : "des_fr", 
					fieldLabel : "法文描述", 
					value:this.good.des_fr
				}),{
					xtype:'button',
					text:'保存法文描述',
					handler:function(){
					modifymodel(thiz.good.goods_id,'des_fr',Ext.getCmp('des_fr').getValue(),'goods');
					}		
				}]
			},{
				id:'tab9',
                title: '西班牙文刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_SP',
					width:350,
                    id: 'Grade_sp',
					value:this.good.Grade_sp,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Plan_SP',
					width:350,
                    id: 'plan_sp',
					value:this.good.plan_sp,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },{
                    fieldLabel: 'Price_SP',
					width:350,
                    id: 'price_sp',
					xtype: 'numberfield',
					hideTrigger:true,
					value:this.good.price_sp,
					listeners: {
						change:function(field,e){
							modifymodel(thiz.good.goods_id,field.getId(),field.getValue(),'goods');
						}
					}
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_sp", 
					width:'90%',
					height:430, 
					id : "des_sp", 
					fieldLabel : "西班牙文描述", 
					value:this.good.des_sp
				}),{
					xtype:'button',
					text:'保存西班牙文描述',
					handler:function(){
						modifymodel(thiz.good.goods_id,'des_sp',Ext.getCmp('des_sp').getValue(),'goods');
					}		
				}]
			}]
		});		
		return tab;
	},

	getTab:function(){
        if (!this.tab) {
            this.tab = this.creatTab();
        }
        return this.tab;
	},

	creatItems:function(){
		this.items = [this.tab];
	},

	addItem:function(p){//新增物品
		this.goodsstore.insert(0, p);
		this.goodsGrid.startEditing(0, 2); // 光标停留在第几行几列
	},
	removeItem:function(){//移除组合物品
		var submitstore = this.goodsstore;
		var submiturl = this.delURL;
		var submitgrid  = this.goodsGrid;
		var data = submitgrid.getSelectionModel().getSelection()[0].data;
		var index = submitstore.findBy(function(record,id){
			return record.get('child_sn') == data.child_sn;									
		});
		var id = data.rec_id;
		if(id ==0){
			submitstore.remove(submitstore.getAt(index));return;
		}
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
						url: submiturl+'&id='+id,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
									submitstore.remove(submitstore.getAt(index));
									Ext.example.msg('MSG',res.msg);
								}else{
									Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this.goodsGrid);
        }
	},
	creatselectstore:function(){//订单明细store
		this.selectstore = Ext.create('Ext.data.Store', {
			fields:['goods_id','goods_sn','SKU','goods_name'],
			remoteSort:true,
			autoLoad:true,
			baseParams : {
				cat_id : ''
			},
			proxy: {
				type: 'ajax',
				url:this.goodsURL,
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'goods_id',
					root: 'topics'
				}
			}
		});
		
		this.selectstore.load({
			params:{start:0,limit:20},
			scope:this.selectstore
			});
		this.selectstore.on('beforeload',function(){
			Ext.apply(this.baseParams,
			{
				keyword:Ext.getCmp('keyword').getValue()
			});
		});
	},
    createWindow: function(num) {//弹出产品选择窗口
		var selectstore = this.selectstore;
		var thiz = this;
		var Tree = Ext.tree;
		var tree = Ext.create('Ext.tree.Panel',{
			border:true,
			id:'west-panel',
			margins:'0 0 0 0',
			title:'产品分类',
			region:'west',
			width: '35%',
			collapsible :true,
			layoutConfig:{
				animate:true
			},
			store:Ext.create('Ext.data.TreeStore', {
				autoLoad:true,
				proxy: {
					type: 'ajax',
					url: this.catTreeURL
				},
				root: {
					text: '总类',
					draggable:false,
					expanded:true,
					id:'root'
				}
			}),
			rootVisible:false,
			autoScroll:true
		});
		tree.on('itemclick',treeClick);
		function treeClick(view,node,item,index,e) {
			 if(node.isLeaf()){
				e.stopEvent();
				//alert(node.id);
				selectstore.load({
					params:{start:0,cat_id:node.id,limit:20},
					scope:this.store
				});
			 }
		};
		var grid = Ext.create('Ext.grid.Panel',{
			title: '产品列表',
			region:'center',
			store:this.selectstore,
			autoHeight:true,
			columns: [
				{header:'产品编码',dataIndex:'goods_sn',flex:1},
				{header:'SKU',dataIndex:'SKU',flex:1},
				{header:'产品名称',dataIndex:'goods_name',flex:1}
			],
			tbar:['<b>产品列表</b>',
			   '->','产品编码:',
			   {
					xtype:'textfield',
					name:'keyword',
					id:'keyword'
				},
				'-',{
					xtype:'button',
					text:'搜索',
					
					iconCls:'x-tbar-search',
					handler:function(){
						//console.log(store.getAt(0).get('order_id'))
						selectstore.load({params:{start:0, limit:20,
							keyword:Ext.getCmp('keyword').getValue(),
							cat_id:''
							}});
					}
				}
			],
			bbar:[{
				xtype: 'pagingtoolbar',
				pageSize: 20,
				displayInfo: true,
				displayMsg: '第{0} 到 {1} 条数据 共{2}条',
				emptyMsg: "没有数据",
				store: this.selectstore			   
        	}],
			viewConfig: {
				forceFit: true
			}
		});
		
        var win = Ext.create('Ext.window.Window',{
            title: '产品列表',
            closeAction: 'hide',
			closable:true,
			width:600,
			height:600,
			layout:'border',
            modal: true,
            items: [tree,grid]
        });
		
		if(!this.goodsGrid) this.creatGoodsgrid();
		var goodsgrid = this.goodsGrid;
		grid.on('itemclick', function(grid,record,item, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var p = Ext.create(this.model,{rec_id:0,goods_sn:getinfo.get('goods_sn'),goods_id:getinfo.get('goods_id'),goods_name:getinfo.get('goods_name'),goods_qty:0});
			if(num == 1) {
				var getSelect = goodsgrid.getSelectionModel().getSelection()[0];
				getSelect.set('goods_name',getinfo.get('goods_name'));
				getSelect.set('goods_id',getinfo.get('goods_id'));
				getSelect.set('goods_sn',getinfo.get('goods_sn'));
			}
			else {
				thiz.addItem(p);
			}
			win.hide();
		});
		win.show();
    },
	saveItem:function(){
		var jsonArray = [];
		var submitstore = this.goodsstore;
		var submiturl = this.savecomURL;
				var m = submitstore.getModifiedRecords().slice(0);
				Ext.each(m,function(item){
					jsonArray.push(item.data);			
					});
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: submiturl,
					   loadMask:true,
					   params: { 'data':Ext.encode(jsonArray),'goods_id':this.good.goods_id },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								submitstore.commitChanges();
								submitstore.load();
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
	},
	calculate:function(){//计算物品总数量和总金额
		var i;
		var totalQty = 0;
		for (i = 0; i < this.goodsstore.getCount(); i++) {
			totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
	}
});
