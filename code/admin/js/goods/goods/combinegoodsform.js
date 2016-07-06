Ext.ux.goodsForm = Ext.extend(Ext.FormPanel, {
	initComponent: function() {
		this.frame = true,
		//this.fileUpload = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatselectstore();
		this.creatGridcm();
		this.txt_totQty = new Ext.form.TextField({
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
		this.creatButtons();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
			Ext.getCmp('editBtn').setDisabled(!sm.hasSelection());
		});
        Ext.ux.goodsForm.superclass.initComponent.call(this);
    },
	creatGoodsstore:function(){//组合产品明细store
		this.goodsstore = new Ext.data.Store({
			url : this.listURL,
			pruneModifiedRecords:true,
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','goods_sn','goods_id','goods_name','goods_qty']),
			listeners : {
				'load' : this.calculate.createDelegate(this),
				'add' : this.calculate.createDelegate(this),
				'remove' : this.calculate.createDelegate(this),
				'update' : this.calculate.createDelegate(this)
			}
			});
	},

	creatGridcm:function(){
		var thiz =this;
		this.cmlist = new Ext.grid.ColumnModel([{
						header : '产品编码<font color=red>*</font>',
						dataIndex:'goods_sn',
						width:100,
						align : 'left',
						editor:new Ext.form.TextField({
								allowBlank:false,
								readOnly:true,
								hideLabel:true
						})
					}, {
						header:'产品名称<font color=red>*</font>',
						width:150,
						dataIndex:'goods_name',
						align:'left',
						editor:new Ext.form.TextField({
								allowBlank:false,
								readOnly:true,
								hideLabel:true
						})
					}, {
						header:'产品数量<font color=red>*</font>',
						dataIndex:'goods_qty',
						align:'right',
						editor:new Ext.form.NumberField({
							allowBlank:false,
							allowNegative:false,
							decimalPercision:4,
							style:'text-align:left'
						})
					}]);
	},
	creatGoodsgrid:function(){//创建组合产品明细
		this.goodsGrid =new Ext.grid.EditorGridPanel({
					frame:true,
					id : "destPanel",
					title:'组合产品明细',
					height : 300,
					autoWidth : true,
					cm : this.cmlist,
					ds : this.goodsstore,
					sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
					clicksToEdit : 1,
					stripeRows : true, // 让基数行和偶数行的颜色不一样
					viewConfig : {
						forceFit : true
					},
					iconCls : 'icon-grid',
					tbar : new Ext.Toolbar({
						items : [{
							xtype:'button',
							text:'新增产品',
							id: 'addBtn',
							iconCls: 'x-tbar-add',
							handler:this.createWindow.createDelegate(this,['0'])
						},{
							xtype:'button',
							text:'编辑产品',
							id: 'editBtn',
							disabled:true,
							iconCls: 'x-tbar-update',
							handler:this.createWindow.createDelegate(this,['1'])
						},{
							text: '删除',
							iconCls: 'x-tbar-del',
							id: 'removeBtn',
							handler: this.removeItem.createDelegate(this),
							disabled:true
						}]
					}),
					bbar : new Ext.Toolbar({
						cls : 'u-toolbar-b',
						items : ['合计:', '->', '数量:', this.txt_totQty]
					})
				});
	},
	creatTab:function(){
		var goodsgrid = this.goodsGrid;
		var tab = new Ext.TabPanel({
        activeTab: 0,
        defaults:{autoScroll: true,autoHeight:true},
        items:[{
			    id:'tab1',
                title: '基本信息',
				height:600,
				layout:'form',
                items:[
					   {
						   layout:'column',
						   items:[
									{
									columnWidth:.33,
									layout: 'form',
									defaultType: 'textfield',
									items:[{fieldLabel: '产品编码',id:'goods_sn'},
										   {fieldLabel: '产品名称',id:'goods_name',allowBlank:false},
										   {
											   fieldLabel: '库存',
											   xtype:'numberfield',
											   allowDecimals:false,
											   allowNegative:false,
											   id:'goods_qty',
											   value:0,
											   hidden : true,
											   allowBlank:false
										   },
										   {
												xtype:'combo',
												store: new Ext.data.SimpleStore({
													 fields: ["id", "key_type"],
													 data: this.goods_data[0]
												}),
												valueField :"id",
												displayField: "key_type",
												mode: 'local',
												width:130,
												editable: false,
												forceSelection: true,
												triggerAction: 'all',
												hiddenName:'status',
												name: 'status',
												allowBlank:false,
											   fieldLabel: '产品状态',
											   value:0,
											   id:'status'
											},{
											   fieldLabel: '报关单简称',
											   id:'dec_name'
										   	},{
											   fieldLabel: '自编码',
											   id:'code'
											},{
											   fieldLabel: '组合产品',
											   xtype:'checkbox',
											   id:'is_group',
											   checked:true,
											   hidden : true
											 }
										   ]
									},{
									columnWidth:.33,
									layout: 'form',
									defaultType: 'textfield',
									items:[{
											    xtype:'combo',
												store: new Ext.data.SimpleStore({
													 fields: ["id", "key_type"],
													 data: this.goods_data[2]
												}),
												valueField :"id",
												displayField: "key_type",
												mode: 'local',
												width:130,
												editable: false,
												forceSelection: true,
												triggerAction: 'all',
												hiddenName:'brand_id',
												name: 'brand_id',
												allowBlank:false,
										   		fieldLabel: '品牌',
												id:'brand_id'
												},
										   {fieldLabel: 'SKU',id:'sku'},
										   {
											   fieldLabel: '库存下限',
											   xtype:'numberfield',
											   allowDecimals:false,
											   allowNegative:false,
											   id:'warn_qty',
											   value:0,
											   hidden : true,
											   allowBlank:false
										   },
										   {
											   fieldLabel: '保质期',
											   id:'keeptime',
											   format:'Y-m-d',
											   value:'2037-12-31',
											   xtype:'datefield'
										   },{
											   fieldLabel: '报关名中文',
											   id:'dec_name_cn'
											},{
											   fieldLabel: '管理库存',
											   xtype:'checkbox',
											   id:'is_control',
											   checked:true,
											   hidden : true
										   },{
											   fieldLabel: '有无子产品',
											   xtype:'checkbox',
											   id:'has_child',
											   checked:false,
											   hidden : true
											 }
										   ]
									},{
									columnWidth:.33,
									layout: 'form',
									defaultType: 'textfield',
									items:[{
											    xtype:'combo',
												store: new Ext.data.SimpleStore({
													 fields: ["id", "key_type"],
													 data: this.goods_data[1]
												}),
												valueField :"id",
												displayField: "key_type",
												mode: 'local',
												width:130,
												editable: false,
												forceSelection: true,
												triggerAction: 'all',
												hiddenName:'cat_id',
												name: 'cat_id',
												allowBlank:false,
											    fieldLabel: '分类',
												id:'cat_id',
												value:65535
											},
										   {fieldLabel: '产品链接',id:'goods_url'},
										   {
											   fieldLabel: '更新图片',
											   inputType: 'file',
											   xtype: 'textfield',
											   name:'photo_path',
										       id:'new_img'
											},{
											   fieldLabel: '申报价值',
											   id:'Declared_value',
											   xtype:'numberfield',
											   allowNegative:false
											},
										   {
											   fieldLabel: '重量',
											   id:'weight',
											   value:0,
											   allowBlank:false,
											   hidden : true
											}
										   ]
									}
								]
						},
						{
						fieldLabel: '备注',
						id:'comment',
						width:600,
						height:30,
						xtype:'textarea'
						},this.goodsGrid]
            },{
				id:'tab2',
                title: '费用相关',
				layout:'form',
				autoScroll:true,
                defaultType: 'textfield',
                items: [{
                    fieldLabel: '成本价',
					width:200,
                    name: 'cost',
					value:0,
					xtype:'numberfield'
                },{
                    fieldLabel: '价格1',
					width:200,
                    name: 'price1',
					xtype:'numberfield'
                },{
                    fieldLabel: '价格2',
					width:200,
                    name: 'price2',
					xtype:'numberfield'
                },{
                    fieldLabel: '价格3',
					width:200,
                    name: 'price3',
					xtype:'numberfield'
                }]
            },{
				id:'tab3',
                title: '中国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_CN',
					width:200,
                    name: 'Grade_cn',
					tabTip:'test'
                },{
                    fieldLabel: 'Plan_cn',
					width:200,
                    name: 'plan_cn'
                },{
                    fieldLabel: 'Price_cn',
					width:200,
                    name: 'price_cn',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_cn", 
					width:400,
					height : 230, 
					id : "des_cn", 
					fieldLabel : "中文描述"
					})
				]
			},{
				id:'tab4',
                title: '美国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_US',
					width:200,
                    name: 'Grade_us'
                },{
                    fieldLabel: 'Plan_US',
					width:200,
                    name: 'plan_us'
                },{
                    fieldLabel: 'Price_US',
					width:200,
                    name: 'price_us',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_en", 
					width:400,
					height : 230, 
					id : "des_en", 
					fieldLabel : "英文描述"
					})
 				]
            },{
				id:'tab5',
                title: '澳大利亚刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_AU',
					width:200,
                    name: 'Grade_au'
                },{
                    fieldLabel: 'Price_AU',
					width:200,
                    name: 'price_au',
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_AU',
					width:200,
                    name: 'plan_au'
                }]
            },{
				id:'tab6',
                title: '英国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_UK',
					width:200,
                    name: 'Grade_uk',
					value:this.good
                },{
                    fieldLabel: 'Price_UK',
					width:200,
                    name: 'price_uk',
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_UK',
					width:200,
                    name: 'plan_uk'
                }]
            },{
				id:'tab7',
                title: '德文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_DE',
					width:200,
                    name: 'Grade_de'
                },{
                    fieldLabel: 'Plan_DE',
					width:200,
                    name: 'plan_de'
                },{
                    fieldLabel: 'Price_DE',
					width:200,
                    name: 'price_de',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_de", 
					width:400,
					height : 230, 
					id : "des_de", 
					fieldLabel : "德文描述"
					})
 				]
			},{
				id:'tab8',
                title: '法文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_FR',
					width:200,
                    name: 'Grade_fr'
                },{
                    fieldLabel: 'Plan_FR',
					width:200,
                    name: 'plan_fr'
                },{
                    fieldLabel: 'Price_FR',
					width:200,
                    name: 'price_fr',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_fr", 
					width:400,
					height : 230, 
					id : "des_fr", 
					fieldLabel : "法文描述"
					})
				]
			},{
				id:'tab9',
                title: '西班牙文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_SP',
					width:200,
                    name: 'Grade_sp'
                },{
                    fieldLabel: 'Plan_SP',
					width:200,
                    name: 'plan_sp'
                },{
                    fieldLabel: 'Price_SP',
					width:200,
                    name: 'price_sp',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_sp", 
					width:400,
					height : 230, 
					id : "des_sp", 
					fieldLabel : "西班牙文描述"
					})
				]
			}
			]
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

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.createDelegate(this)
			},{
					text: '取消',
					handler:this.formreset.createDelegate(this)
			}];		
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
			if(this.getForm().getFieldValues().is_group && this.txt_totQty.getValue() == 0){
				Ext.example.msg('错误提示','选择为组合产品后子产品数量不能为0');return;
			}
			var jsonArray = [];
				var m = this.goodsstore.modified.slice(0);
				Ext.each(m,function(item){
					jsonArray.push(item.data);			
					});
			var jsonArray1 = [];
				this.getForm().submit({
					url:'index.php?model=goods&action=save',
					waitMsg: '正在更新产品资料',
					params:{'data':Ext.encode(jsonArray),'childdata':Ext.encode(jsonArray1)},
					method:'post',
					success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('MSG','新增产品成功');
										//window.location.href = 'index.php?model=goods&action=editcombine&goods_id='+action.result.msg;
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
							 		}
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
				});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
			}
	},

	formreset:function(){//表单重置
		this.form.reset();
	},

	addItem:function(p){//新增物品
		this.goodsstore.insert(0, p);
		this.goodsGrid.startEditing(0, 2); // 光标停留在第几行几列
	},
	removeItem:function(){//移除组合物品
		var data = this.goodsGrid.getSelectionModel().getSelected().data;
		var index = this.goodsstore.findBy(function(record,id){
				return record.get('goods_id') == data.goods_id && record.get('goods_qty') == data.goods_qty;									
													});
		thiz.remove(this.goodsstore.getAt(index));
	},
	creatselectstore:function(){//订单明细store
		this.selectstore = new Ext.data.Store({
			url : this.goodsURL,
			baseParams : {
				cat_id : ''
			},
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'goods_id'
			}, ['goods_id','goods_sn','SKU','goods_name'])
			});
		this.selectstore.load({
			params:{start:0,limit:20},
			scope:this.selectstore
			});
		this.selectstore.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value
			});
		});
	},
    createWindow: function(num) {//弹出产品选择窗口
		var selectstore = this.selectstore;
		var thiz = this;
		var Tree = Ext.tree;
		var root = new Tree.AsyncTreeNode({
			text: '总类',
			draggable:false,
			id:'root'
		});
		var tree = new Ext.tree.TreePanel({
			border:true,
			root:root,
			id:'west-panel',
			margins:'0 0 0 0',
			layout:'accordion',
			title:'产品分类',
			collapsible :true,
			layoutConfig:{
				animate:true
				},
			rootVisible:false,
			autoScroll:true,
			loader: new Tree.TreeLoader({
				dataUrl:this.catTreeURL
				})
			});
		tree.on('click',treeClick);
		function treeClick(node,e) {
			 if(node.isLeaf()){
				e.stopEvent();
				//alert(node.id);
				selectstore.load({
					params:{start:0,cat_id:node.id,limit:20},
					scope:this.store
					});
			 }
		};
		var grid = new Ext.grid.GridPanel({
			title: '产品列表',
			store:this.selectstore,
			autoHeight:true,
			columns: [
				{header:'产品编码',dataIndex:'goods_sn'},
				{header:'SKU',dataIndex:'SKU'},
				{header:'产品名称',dataIndex:'goods_name'}
			],
			tbar:new Ext.Toolbar({
						items:['<b>产品列表</b>',
							   '->','产品编码:',
							   new Ext.form.TextField({
									id:'keyword'
								}),
								'-',{
									xtype:'button',
									text:'搜索',
									iconCls:'x-tbar-search',
									handler:function(){
										//console.log(Ext.getCmp('keyword').getValue());
										selectstore.load({params:{start:0, limit:20,
											keyword:Ext.getCmp('keyword').getValue(),
											cat_id:''
											}});
										}
								}
							]}),
			bbar:new Ext.PagingToolbar({
			pageSize: 20,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.selectstore			   
        	}),
			viewConfig: {
				forceFit: true
			}
		});
		
        var win = new Ext.Window({
            title: '产品列表',
            closeAction: 'hide',
			closable:true,
			width:600,
			height:600,
			layout:'column',
            modal: true,
            items: [
					{
						columnWidth:0.3,
						items:[tree]
					},{
						columnWidth:0.7,
						items:[grid]
					}
            ]
        });
		var Item = Ext.data.Record.create([{
			name:'rec_id',
			type:'float'
		},{
			name : 'goods_sn'
		}, {
			name : 'goods_id',
			type:'float'
		}, {
			name : 'goods_name'
		}, {
			name : 'goods_qty',
			type : 'float'
		}]);

		if(!this.goodsGrid) this.creatGoodsgrid();
		var goodsgrid = this.goodsGrid;
		grid.on('rowclick', function(grid, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var p = new Item({rec_id:0,goods_sn:getinfo.get('goods_sn'),goods_id:getinfo.get('goods_id'),goods_name:getinfo.get('goods_name'),goods_qty:0});
			if(num == 1) {
				var getSelect = goodsgrid.getSelectionModel().getSelected();
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
	calculate:function(){//计算物品总数量和总金额
		var i;
		var totalQty = 0;
		for (i = 0; i < this.goodsstore.getCount(); i++) {
			totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
	}
});
