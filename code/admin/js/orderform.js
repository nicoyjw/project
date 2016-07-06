Ext.define('Ext.ux.OrderForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = true,
		this.buttonAlign = 'center',
		this.autoHeight = 'true';
		this.txt_totQty = Ext.create('Ext.form.field.Text',{
			id : 'txt_totQty',
			anchor : '95%',
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		}),
		this.txt_totAmt = Ext.create('Ext.form.field.Text',{
			id : 'txt_totAmt',
			anchor : '95%',
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		}),
		this.creatBuyerpart();
		this.creatNotepart();
		this.creatGridsm();
		this.creatGridcm();
		this.creatFeepart();
		this.creatGoodsstore();
		this.creatselectstore();
		this.creatGoodsgrid();
		this.creatButtons();
		this.creatItems();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(sm.getCount()<1);
			Ext.getCmp('editBtn').setDisabled(sm.getCount()<1);
		});
        this.callParent(this);
    },
	
	creatBuyerpart:function(){//买家信息
		this.buyerFieldset = Ext.create('Ext.form.FieldSet',{
				title: '客户信息',
				height:150,
				layout:'column',
				margin: '5px 0px 0px 10px',
				items:[{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: 'buyerid',id:'userid',name:'userid',value:this.order.userid,allowBlank:false,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">姓名*</font>',id:'consignee',name:'consignee',value:this.order.consignee,allowBlank:false,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">City*</font>',id:'city',name:'city',value:this.order.city,allowBlank:false,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">Country*</font>',id:'country',name:'country',value:this.order.country,allowBlank:false,width:250,labelWidth:85}
						]
					},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '邮箱',id:'email',name:'email',vtype:'email',value:this.order.email,allowBlank:false,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">地址一*</font>',id:'street1',name:'street1',value:this.order.street1,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">State*</font>',value:this.order.state,id:'state',name:'state',width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">CountryCode*</font>',id:'CountryCode',name:'CountryCode',value:this.order.CountryCode,width:250,labelWidth:85},
							{fieldLabel: '订单号',id:'order_sn',name:'order_sn',value:this.order.order_sn,xtype:'hidden',width:250,labelWidth:85}
						]
					},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '电话',id:'tel',name:'tel',value:this.order.tel,width:250,labelWidth:85},
							{fieldLabel: '地址二',id:'street2',name:'street2',value:this.order.street2,width:250,labelWidth:85},
							{fieldLabel: '<font color="#F15628">邮编*</font>',value:this.order.zipcode,id:'zipcode',name:'zipcode',width:250,labelWidth:85},
							{fieldLabel: '订单ID',id:'order_id',value:this.order.order_id,name:'order_id',xtype:'hidden',width:250,labelWidth:85},
							{fieldLabel: '订单ID',id:'from_order_id',value:this.order.from_order_id,name:'from_order_id',xtype:'hidden',width:250,labelWidth:85}
						]
					}]
			});
	},
	
	creatNotepart:function(){//付款备注
		this.noteFieldset = Ext.create('Ext.form.FieldSet',{
				height:150,
				title:'客户备注',
				margin: '5px 10px 0px 0px',
				items:[{
					hideLabel:true,
					xtype:'textarea',
					id:'pay_note',
					name:'pay_note',
					width:200,
					height:120,
					value:this.order.pay_note,
					autoScroll:true
				}]
			});
	},
	
	creatGoodsstore:function(){//订单明细store
		this.model = Ext.define('goosmdoel',{
				extend:'Ext.data.Model',
				fields:[
				{name:'rec_id'},
				{name:'goods_sn'},
				{name:'item_no'},
				{name:'goods_name'},
				{name:'goods_qty'},
				{name:'goods_price'},
				{name:'goods_weigth'},
				{name:'sn_prefix'},
				{name:'amt'},
				{name:'weigth'}
				]
			})
		this.goodsstore = Ext.create('Ext.data.JsonStore', {
			model: this.model,
		//	fields:['rec_id','goods_sn','item_no','goods_name','goods_qty','goods_price','sn_prefix',{name:'amt',convert:function(v,rec){ return rec[5]*rec[6];}}],
			baseParams : {
				order_id : this.order.from_order_id
			},
			proxy: {
				type: 'ajax',
				url:(this.order.from == 0)?this.listURL:this.listURL1,
				actionMethods:{
					read: 'POST'
				},
				reader: {
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
		})
		this.goodsstore.load();
	},
	
	creatGridcm:function(){
		var sm = this.sm;
		this.cmlist = [{
			header : '产品编码',
			dataIndex:'goods_sn',
			flex:1,
			width:150,
			align : 'left',
			editor : {
			}
		}, {
			header : 'ItemNumber',
			dataIndex:'item_no',
			align:'left',
			width:150,
			flex:1,
			editor:{}
		}, {
			header:'<font color="#F15628">产品名称*</font>',
			flex:3,
			width:250,labelWidth:85,
			dataIndex:'goods_name',
			align:'left',
			editor:{
				allowBlank:false
			}
		}, {
			header:'<font color="#F15628">产品数量*</font>',
			dataIndex:'goods_qty',
			align:'right',
			width:150,
			flex:1,
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				minValue:0,
				decimalPercision:4,
				style:'text-align:left'
			}
		}, {
			header:'<font color="#F15628">产品单价*</font>',
			width:150,
			dataIndex:'goods_price',
			align:'right',
			flex:1,
			renderer:function(v){ return Ext.util.Format.number(v,"0.00");},
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				minValue:0,
				decimalPercision:4,
				style:'text-align:right'
			}
		}, {
			header:'<font color="#F15628">重量(KG)*</font>',
			dataIndex:'goods_weigth',
			align:'right',
			width:150,
			flex:1,
			renderer:function(v){ return Ext.util.Format.number(v,"0.000");},
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				hideTrigger:true,
				minValue:0,
				decimalPercision:4,
				style:'text-align:right'
			}
		}, {
			header:'销售代码',
			flex:1,
			width:150,
			dataIndex:'sn_prefix',
			hidden:(this.use_sn_prefix>0)?false:true,
			align:'right',
			editor : {}
		}, {
			header:'总金额',
			align:'right',
			flex:1,
			width:150,
			dataIndex:'amt',
			renderer:function(value, cellmeta, record, rowIndex, columnIndex, store) {
				var price = record.get('goods_price');
				var qty = record.get('goods_qty');
				record.set('amt', price * qty);
				return Ext.util.Format.number(record.get('amt'),"0.00");
			}
		}, {
			header:'总重量',
			align:'right',
			dataIndex:'weigth',
			width:150,
			flex:1,
			renderer:function(value, cellmeta, record, rowIndex, columnIndex, store) {
				var price = record.get('goods_weigth');
				var qty = record.get('goods_qty');
				record.set('weigth', price * qty);
				return Ext.util.Format.number(record.get('weigth'),"0.00");
			}
		}];
	},
	creatGridsm:function(){
		this.sm = Ext.create('Ext.selection.CheckboxModel',{});
	},
	creatGoodsgrid:function(){//创建产品明细
		this.goodsGrid =Ext.create('Ext.grid.Panel',{
			id : "destPanel",
			title:'订单产品',
			height : 300,
			columns : this.cmlist,
			selModel: this.sm,
			store : this.goodsstore,
			plugins:[Ext.create('Ext.grid.plugin.CellEditing',{
				clicksToEdit: 1
			})],
			viewConfig : {
				stripeRows : true, // 让基数行和偶数行的颜色不一样
				forceFit : true
			},
			border : true,
			iconCls : 'icon-grid',
			tbar :Ext.create('Ext.toolbar.Toolbar',{
				items : [{
					xtype:'button',
					text:'新增',
					iconCls: 'x-tbar-add',
					handler:this.addItem.bind(this,[''])
				}, {
					text: '删除',
					iconCls: 'x-tbar-del',
					id: 'removeBtn',
					disabled:true,
					handler: this.removeItem.bind(this)
				},{
					xtype:'button',
					text:'产品目录',
					id: 'addBtn',
					iconCls: 'x-tbar-add',
					handler:this.createWindow.bind(this,['0'])
				},{
					xtype:'button',
					text:'替换产品',
					id: 'editBtn',
					disabled:true,
					iconCls: 'x-tbar-update',
					handler:this.createWindow.bind(this,['1'])
				}]
			}),
			bbar : Ext.create('Ext.toolbar.Toolbar',{
				cls : 'u-toolbar-b',
				items : ['合计:', '->', '数量:', this.txt_totQty, '产品总金额:', this.txt_totAmt]
			})
		});
	},

	creatFeepart:function(){//订单信息
	    var thiz = this;
		this.feeFieldset = Ext.create('Ext.form.FieldSet',{
				title: '订单信息',
				layout:'column',
				autoWidth:'auto',
				autoHeight:'auto',
				margin: '5px 10px 0px 10px',
				labelWidth:85,
				items:[{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[1]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								labelWidth:85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'Sales_channels',
								name: 'Sales_channels',
								fieldLabel: '<font color="#F15628">销售渠道*</font>',
								value:this.order.Sales_channels,
								allowBlank:false
							},
							{
								xtype:'combo',
								store:Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[2]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								labelWidth:85,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'shipping_id',
								name: 'shipping_id',
								value:this.order.shipping_id,
								allowBlank:false,
								fieldLabel: '<font color="#F15628">发货方式*</font>',
								listeners: {
									change:function(field,e){
											//alert(field.getValue());
										}
								}
							},
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[4]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								labelWidth:85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'pay_id',
								value:this.order.pay_id,
								name: 'pay_id',
								allowBlank:false,
								fieldLabel: '<font color="#F15628">付款方式*</font>'
							}
						]
						},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[0]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'Sales_account_id',
								pageSize:30,
								labelWidth:85,
								minListWidth:220,
								name: 'Sales_account_id',
								value:this.order.Sales_account_id,
								allowBlank:false,
								value:'default',
								id:'Sales_accountid',
								fieldLabel: '<font color="#F15628">所属账号*</font>'
							},
							{fieldLabel: '快递单号',id:'track_no',name:'track_no',labelWidth:85,width:300,value:this.order.track_no},
							{fieldLabel: '手续费',id:'FEEAMT',name:'FEEANT',labelWidth:85,width:300,value:this.order.FEEAMT,minValue:0,hideTrigger:true,xtype:'numberfield'}
						]
						},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[3]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								labelWidth:85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'order_status',
								name: 'order_status',
								value:this.order.order_status,
								allowBlank:false,
								fieldLabel: '<font color="#F15628">订单状态*</font>',
									listeners: {
										change:function(field,e){
												if(thiz.order.is_lock == 1) Ext.example.msg('该订单已进行过库存锁定，请注意解锁');
											}
										}
							},
							{fieldLabel: 'Shipping',id:'ShippingService',labelWidth:85,name:'ShippingService',value:this.order.ShippingService,width:300},
							{fieldLabel: '总费用',id:'order_amount',name:'order_amount',labelWidth:85,value:this.order.order_amount,width:300,allowBlank:false,minValue:0,hideTrigger:true,xtype:'numberfield'}
						]
						},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: 'PaypalID',value:this.order.paypalid,width:300,labelWidth:85,name:'paypalid',id:'paypalid'},
							{fieldLabel: '运费',id:'shipping_fee',name:'shipping_fee',labelWidth:85,value:this.order.shipping_fee,width:300,allowBlank:false,minValue:0,hideTrigger:true,xtype:'numberfield'},
							{fieldLabel: '付款日期',id:'paid_time',name:'paid_time',labelWidth:85,value:this.order.paid_time,format:'Y-m-d',width:300,allowBlank:false,xtype:'datefield'}
						]
						},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: 'Salesrecord',id:'sellsrecord',name:'sellsrecord',value:this.order.sellsrecord,width:300,minValue:0,labelWidth:85,hideTrigger:true,xtype:'numberfield'},
							{fieldLabel: '币种',id:'currency',name:'currency',value:this.order.currency,width:300,allowBlank:false,labelWidth:85},
							{fieldLabel: '销售站点',id:'sales_site',name:'sales_site',width:300,value:this.order.sales_site,labelWidth:85}
						]
						},{
						columnWidth:.33,
						frame:false,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '快递单号2',id:'track_no_2',name:'track_no_2',labelWidth:85,value:this.order.track_no_2,width:300},
							{fieldLabel: '客户id',id:'client_id',name:'client_id',labelWidth:85,value:this.order.client_id,width:300},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[5]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								labelWidth:85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'ship_status',
								name: 'ship_status',
								value:this.order.ship_status,
								fieldLabel: '运输状态'
							}
						]
						}]
			});
	},

	creatItems:function(){
		this.items = [
				{
			layout:'column',
			frame:false,
			border:false,
			items:[{
				width:60,
				border:false,
				items:[{
					xtype:'button',
					text: '保存',
					handler:this.formsubmit.bind(this)
				}]
					},{
				columnWidth:.25,
				border:false,
				margin:8,
				html:'<div><font color="#F15628"><b>温馨提示：橘色带*为必填项</b></font></div>'
					}]
		  }
		
				,{
			layout:'column',
			frame:false,
			border:false,
			items:[{
				columnWidth:.75,
				border:false,
				items:[this.buyerFieldset]
					},{
				columnWidth:.25,
				border:false,
				items:[this.noteFieldset]
					}]
		  },this.feeFieldset,this.goodsGrid];
	},

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.bind(this)
			}];		
	},

	formsubmit:function(){
		if(Ext.getCmp('Sales_accountid').getValue() == 'default') {
			Ext.example.msg('ERROR','请先选择账号!');
			return false;
		}
		if(this.txt_totQty.getValue() == 0){ 
				Ext.example.msg('错误提示','商品数量不能为空');
				return false;
				}
		if(this.getForm().isValid()){
				var m = this.goodsstore.getModifiedRecords().slice(0);
				var thiz = this.goodsstore;
				var jsonArray = [];
				Ext.each(m,function(item){
					jsonArray.push(item.data);				
					});
				this.getForm().doAction('submit',{
					url:'index.php?model=order&action=save',
					method:'post',
					params:{'data':Ext.encode(jsonArray)},
					success:function(form,action){
							Ext.example.msg('MSG','订单新增完成');
							window.location.href = 'index.php?model=order&action=edit&id='+action.result.msg;
						},
					failure:function(form,action){
							Ext.Msg.alert('订单新增失败',action.result.msg);
						}
				});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
			}
	},

	addItem:function(p){//新增物品
		var me = this;
		if(!p) var p = Ext.create(me.model,{rec_id:0,goods_sn:'',item_no:'',goods_name:'',goods_qty:1,goods_price:0,amt:0});
		this.goodsstore.insert(0, p);
		this.goodsGrid.plugins[0].startEditByPosition({row:0,column:0});
	},
	removeItem:function(){//移除物品
		var s = this.goodsGrid.getSelectionModel().getSelection();
		this.goodsstore.remove(s);
	},

	calculate:function(){//计算物品总数量和总金额
		var i;
		var totalQty = 0;
		var totalAmt = 0;
		for (i = 0; i < this.goodsstore.getCount(); i++) {
			this.goodsstore.getAt(i).set('rec_id',0);
			totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
			totalAmt += this.goodsstore.getAt(i).get('amt') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
		this.txt_totAmt.setValue(Ext.util.Format.number(totalAmt / 10000,"0.00"));
	},
	creatselectstore:function(){//订单明细store
		
		this.selectstore = Ext.create('Ext.data.JsonStore', {
			fields:['goods_id','goods_sn','SKU','goods_name'],
			baseParams : {
				cat_id : ''
			},
			proxy: {
				type: 'ajax',
				url:this.goodsgirdURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
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
			Ext.apply(
			this.baseParams,
			{
				cat_id:Ext.getCmp('cat_id').getValue(),
				keyword:Ext.getCmp('keyword').getValue()
			});
		});
	},
    createWindow: function(num) {//弹出产品选择窗口
		var selectstore = this.selectstore;
		var thiz = this;
		var Tree = Ext.tree;
		var tree = Ext.create('Ext.tree.Panel',{
			border:false,
			frame:true,
			title:'产品分类',
			region:'west',
			width:'40%',
			id:'west-panel',
			margins:'0 0 0 0',
			store: Ext.create('Ext.data.TreeStore', {
				 proxy: {
					type: 'ajax',
					url:this.catTreeURL
				},
				root:{
					text: '总类',
					draggable:false,
					expanded:true,
					id:'root'
				}
			}),
			collapsible :true,
			layoutConfig:{
				animate:true
			},
			rootVisible:false,
			autoScroll:true
		});
			
		tree.on('itemclick',treeClick);
		function treeClick(view,node,item,index,e) {
			 if(node.isLeaf()){
				e.stopEvent();
				Ext.getCmp('cat_id').setValue(node.data.id);
				selectstore.load({
					params:{start:0,cat_id:node.data.id,limit:20},
					scope:this.store
					});
			 }
		};
		var grid = Ext.create('Ext.grid.Panel',{
			store:this.selectstore,
			height:400,
			region:'center',
			autoScroll:true,
			columns: [
				{header:'产品编码',flex:1,dataIndex:'goods_sn'},
				{header:'SKU',flex:1,dataIndex:'SKU'},
				{header:'产品名称',flex:1,dataIndex:'goods_name'}
			],
			tbar:Ext.create('Ext.toolbar.Toolbar',{
						items:['产品列表',
							   '->','产品编码:',
							   {
								xtype:'textfield',
									name:'keyword',
									id:'keyword',
									width:100,
									enableKeyEvents:true,
									listeners:{
										scope:this,
										keypress:function(field,e){
												if(e.getKey()==13){
													selectstore.load({params:{start:0, limit:20,
														keyword:Ext.getCmp('keyword').getValue(),
														cat_id:''
														}});
												}
											}
									}
								},{xtype:'hidden',id:'cat_id',name:'cat_id',value:0},
								'-',{
									xtype:'button',
									text:'搜索',
									iconCls:'x-tbar-search',
									handler:function(){
										//console.log(Ext.fly('keyword'));
										selectstore.load({params:{start:0, limit:20,
											keyword:Ext.getCmp('keyword').getValue(),
											cat_id:''
											}});
										}
								}
							]}),
			bbar:Ext.create('Ext.toolbar.Paging',{
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
		var win = Ext.create('Ext.window.Window',{
            closeAction: 'destroy',
			closable:true,
			width:900,
			height:400,
			layout:'border',
            modal: false,
            items: [tree,grid]
        });
		if(!this.goodsGrid) this.creatGoodsgrid();
		var goodsgrid = this.goodsGrid;
		var me = this;
		grid.on('itemclick', function(grid,record,item, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var p = Ext.create(me.model,{rec_id:0,goods_sn:getinfo.get('goods_sn'),item_no:'',goods_name:getinfo.get('goods_name'),goods_qty:1,goods_price:0,amt:0});
			if(num == 1) {
				var getSelect = goodsgrid.getSelectionModel().getSelection()[0];
				getSelect.set('goods_name',getinfo.get('goods_name'));
				getSelect.set('goods_sn',getinfo.get('goods_sn'));
			}
			else {
				thiz.addItem(p);
				Ext.getCmp('keyword').destroy();
			}
			win.hide();
		});
		win.show();
    }
});

