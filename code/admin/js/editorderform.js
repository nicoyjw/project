Ext.define('Ext.ux.EditorderForm',{
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
		this.txt_totWeigth = Ext.create('Ext.form.field.Text',{
							id : 'txt_totWeigth',
							anchor : '95%',
							allowBlank : true,
							value : 0,
							readOnly : true,
							fieldClass : 'textReadOnly'
						}),
		this.creatBuyerpart();
		this.creatNotepart();
		this.creatGridcm();
		this.creatFeepart();
		this.creatGoodsstore();
		this.creatselectstore();
		this.creatGoodsgrid();
		this.creatItems();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(sm.getCount()<1);
			Ext.getCmp('editBtn').setDisabled(sm.getCount()<1);
		});
        this.callParent(this);
    },
	
	creatBuyerpart:function(){//买家信息
		var thiz = this;
		this.buyerFieldset = Ext.create('Ext.form.FieldSet',{
				title: '客户信息',
				height:150,
				margin: '5px 0px 0px 10px',
				layout:'column',
				items:[{
						columnWidth:.33,
						defaultType: 'textfield',
						frame:false,
						border:false,
						items:[{
							fieldLabel: 'buyerid',id:'userid',width:210,
							value:this.order.userid,
							labelWidth:70,
							allowBlank:false,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '姓名',labelWidth:70,id:'consignee',value:this.order.consignee,allowBlank:false,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '城市',labelWidth:70,id:'city',value:this.order.city,allowBlank:false,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '国家名称',labelWidth:70,id:'country',value:this.order.country,allowBlank:false,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
					},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '邮箱',labelWidth:70,id:'email',vtype:'email',value:this.order.email,allowBlank:false,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '地址一',labelWidth:70,id:'street1',value:this.order.street1,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '省份',labelWidth:70,value:this.order.state,id:'state',width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '国家代码',labelWidth:70,id:'CountryCode',value:this.order.CountryCode,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '订单号',labelWidth:70,id:'order_sn',value:this.order.order_sn,xtype:'hidden',width:210}
						]
					},{
						columnWidth:.33,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '电话',labelWidth:70,id:'tel',value:this.order.tel,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							
							{fieldLabel: '地址二',labelWidth:70,id:'street2',value:this.order.street2,width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '邮编',labelWidth:70,value:this.order.zipcode,id:'zipcode',width:210,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}
							},
							{fieldLabel: '订单ID',labelWidth:70,id:'order_id',value:this.order.order_id,xtype:'hidden',width:210,
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
					}]
			});
	},
	
	creatNotepart:function(){//付款备注
		var thiz = this;
		this.noteFieldset = Ext.create('Ext.form.FieldSet',{
				height:150,
				title:'订单备注',
				margin: '5px 10px 0px 0px',
				items:[{
						hideLabel:true,
						xtype:'textarea',
						id:'pay_note',
						width:200,
						height:120,
						value:this.order.pay_note,
						autoScroll:true,
						 listeners: {
                         blur:function(field,e){
                                modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
                            }
                        }
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
		this.goodsstore = Ext.create('Ext.data.JsonStore', {		//fields:['rec_id','goods_sn','item_no','goods_name','goods_qty','goods_price','sn_prefix',{name:'amt',convert:function(v,rec){ return rec[5]*rec[6];}}],
			fields:['rec_id','goods_sn','item_no','goods_name','goods_qty','goods_price','goods_weigth','sn_prefix','amt','weigth'],
			proxy: {
				type: 'ajax',
				url:this.listURL,
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
		this.goodsstore.load({params : {
				order_id : this.order.order_id}
			});
	},
	
	creatGridcm:function(){
		this.cmlist = [{
			header : '产品编码<font color=red>*</font>',
			dataIndex:'goods_sn',
			align : 'left',
			flex:1,
			width:150,
			editor : {}
		}, {
			header : 'ItemNumber',
			dataIndex:'item_no',
			align:'left',
			editor:{}
		}, {
			header:'产品名称<font color=red>*</font>',
			flex:3,
			width:150,
			dataIndex:'goods_name',
			align:'left',
			editor:{
				allowBlank:false
			}
		}, {
			header:'产品数量<font color=red>*</font>',
			dataIndex:'goods_qty',
			align:'right',
			width:150,
			flex:1,
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				hideTrigger:true,
				minValue:0,
				decimalPercision:4,
				style:'text-align:left'
			}
		}, {
			header:'产品单价',
			dataIndex:'goods_price',
			align:'right',
			width:150,
			flex:1,
			renderer:function(v){ return Ext.util.Format.number(v,"0.00");},
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				hideTrigger:true,
				minValue:0,
				decimalPercision:4,
				style:'text-align:right'
			}
		}, {
			header:'重量(KG)',
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
			dataIndex:'sn_prefix',
			flex:1,
			width:150,
			hidden:(this.use_sn_prefix>0)?false:true,
			align:'right',
			editor : {}
		}, {
			header:'总金额',
			align:'right',
			dataIndex:'amt',
			width:150,
			flex:1,
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
	   var thiz = this;
		this.goodsGrid =Ext.create('Ext.grid.Panel',{
					id : "destPanel",
					title:'订单产品',
					height : 300,
					columns : this.cmlist,
					selModel: this.sm,
					store : this.goodsstore,
					plugins:[Ext.create('Ext.grid.plugin.CellEditing', {
						clicksToEdit: 1
					})],
					viewConfig : {
						stripeRows : true, // 让基数行和偶数行的颜色不一样
						forceFit : true
					},
					border : true,
					iconCls : 'icon-grid',
					tbar : Ext.create('Ext.toolbar.Toolbar',{
						items : [{
							xtype:'button',
							text:'新增',
							iconCls: 'x-tbar-add',
							disabled:(thiz.order.is_lock == 1)?true:false,
							handler:this.addItem.bind(this,[''])
						}, {
							text: '删除',
							iconCls: 'x-tbar-del',
							id: 'removeBtn',
							disabled:true,
							handler: this.removeItem.bind(this)
						}, {
							text: '保存',
							iconCls: 'x-tbar-save',
							id: 'saveBtn',
							disabled:(thiz.order.is_lock == 1)?true:false,
							handler: this.formsubmit.bind(this)
						},{
							xtype:'button',
							text:'产品目录',
							id: 'addBtn',
							disabled:(thiz.order.is_lock == 1)?true:false,
							iconCls: 'x-tbar-add',
							handler:this.createWindow.bind(this,['0'])
						},{
							xtype:'button',
							text:'替换产品',
							id: 'editBtn',
							disabled:(thiz.order.is_lock == 1)?true:false,
							iconCls: 'x-tbar-update',
							handler:this.createWindow.bind(this,['1'])
						}]
					}),
					bbar : Ext.create('Ext.toolbar.Toolbar',{
						cls : 'u-toolbar-b',
						items : ['合计:', '->', '数量:', this.txt_totQty, '产品总金额:', this.txt_totAmt, '产品总重量:', this.txt_totWeigth]
					})
				});
	},

	creatFeepart:function(){//订单信息
	    var thiz = this;
		this.feeFieldset = Ext.create('Ext.form.FieldSet',{
				title: '订单信息',
				layout:'column',
				labelWidth:85,
				margin: '5px 0px 0px 10px',
				items:[{
						columnWidth:.33,
						frame:false,
						border:false,
						defaultType: 'textfield',
						items:[{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[1]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'Sales_channels',
								name: 'Sales_channels',
								fieldLabel: '销售渠道',
								value:this.order.Sales_channels,
								allowBlank:false,
								listeners: {
									change:function(field,e){
										modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
									}
								}
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[2]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'shipping_id',
								name: 'shipping_id',
								value:this.order.shipping_id,
								allowBlank:false,
								fieldLabel: '发货方式',
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
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
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'pay_id',
								value:this.order.pay_id,
								name: 'pay_id',
								allowBlank:false,
								fieldLabel: '付款方式',
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
											}
										}
							}
						]
						},{
						columnWidth:.33,
						frame:false,
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
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'Sales_account_id',
								name: 'Sales_account_id',
								value:this.order.Sales_account_id,
								allowBlank:false,
								fieldLabel: '所属账号',
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
											}
										}
							},
							{fieldLabel: '快递单号',id:'track_no',value:this.order.track_no,width:250,
								labelWidth:70,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '手续费',id:'FEEAMT',labelWidth:70,value:this.order.FEEAMT,minValue:0,hideTrigger:true,xtype:'numberfield',width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
						},{
						columnWidth:.33,
						frame:false,
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
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'order_status',
								name: 'order_status',
								value:this.order.order_status,
								allowBlank:false,
								fieldLabel: '订单状态',
									listeners: {
										change:function(field,e){
												if(thiz.order.is_lock == 1) {
													Ext.example.msg('ERROR','该订单已进行过库存锁定，请先解锁');
													return false;
												}
												modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
											}
										}
							},
							{fieldLabel: 'Shipping',id:'ShippingService',value:this.order.ShippingService,width:250,
								labelWidth:70,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '总费用',
								labelWidth:70,id:'order_amount',value:this.order.order_amount,allowBlank:false,width:250,hideTrigger:true,minValue:0,xtype:'numberfield',
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
						},{
						columnWidth:.33,
						frame:false,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: 'PaypalID',
								labelWidth:70,value:this.order.paypalid,id:'paypalid',width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '运费',
								labelWidth:70,id:'shipping_fee',value:this.order.shipping_fee,allowBlank:false,hideTrigger:true,width:250,minValue:0,xtype:'numberfield',
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '付款日期',
								labelWidth:70,id:'paid_time',value:this.order.paid_time,format:'Y-m-d',allowBlank:false,xtype:'datefield',width:250,
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
						},{
						columnWidth:.33,
						frame:false,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: 'Salesrecord',
								labelWidth:70,id:'sellsrecord',value:this.order.sellsrecord,width:250,hideTrigger:true,minValue:0,xtype:'numberfield',
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '币种',
								labelWidth:70,id:'currency',value:this.order.currency,allowBlank:false,width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '销售站点',
								labelWidth:70,id:'sales_site',value:this.order.sales_site,width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}}
						]
						},{
						columnWidth:.33,
						frame:false,
						border:false,
						defaultType: 'textfield',
						items:[
							{fieldLabel: '快递单号2',id:'track_no_2',name:'track_no_2',labelWidth:70,value:this.order.track_no_2,width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},
							{fieldLabel: '客户id',id:'client_id',name:'client_id',labelWidth:70,value:this.order.client_id,width:250,
									listeners: {
										blur:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.arrdata[5]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:250,
								labelWidth:70,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'ship_status',
								name: 'ship_status',
								value:this.order.ship_status,
								allowBlank:false,
								fieldLabel: '运输状态',
									listeners: {
										change:function(field,e){
												modifymodel(thiz.order.order_id,field.getId(),field.getValue(),'order');
											}
										}
							}
						]
						}]
			});
	},

	creatItems:function(){
		this.items = [{
			layout:'column',
			frame:false,
			border:false,
			items:[{
				columnWidth:.75,
				frame:false,
				border:false,
				items:[this.buyerFieldset]
					},{
				columnWidth:.25,
				frame:false,
				border:false,
				items:[this.noteFieldset]
					}]
		  },this.feeFieldset,this.goodsGrid];
	},

	formsubmit:function(){
		var ts = this;
		//alert(ts.order.order_id);return;
		if(this.txt_totQty.getValue() == 0){ 
				Ext.example.msg('错误提示','商品数量不能为空');
				return false;
				}
				var m = this.goodsstore.getModifiedRecords().slice(0);
				var thiz = this.goodsstore;
				var jsonArray = [];
				Ext.each(m,function(item){
					jsonArray.push(item.data);				
					});
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=order&action=savegoods',
					   loadMask:true,
					   params: { 'data':Ext.encode(jsonArray),'order_id':ts.order.order_id},
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								thiz.commitChanges();
								thiz.load({params:{order_id:ts.order.order_id}});
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});					
	},

	addItem:function(p){//新增物品
		var me = this;
		if(!p) var p = Ext.create(me.model,{rec_id:0,goods_sn:'',item_no:'',goods_name:'',goods_qty:1,goods_price:0,amt:0,weigth:0});
		this.goodsstore.insert(4, p);
		this.goodsGrid.plugins[0].startEditByPosition({row:0,column:0});
	},
	removeItem:function(){//移除物品
		if(this.order.is_lock == 1) {
			Ext.example.msg('ERROR','该订单产品已被锁定');
			return false;
		}
		var s = this.goodsGrid.getSelectionModel().getSelection()[0];
		if(s.get('rec_id') == 0) {
			this.goodsstore.remove(s);
			return;
		}
		var thiz = this.goodsstore;
		var delURL = this.delURL;
        if (s != false) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: delURL+'&rec_id='+s.get('rec_id'),
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.remove(s);
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

	calculate:function(){//计算物品总数量和总  金额
		var i;
		var totalQty = 0;
		var totalAmt = 0;
		var totalWeigth = 0;
		for (i = 0; i < this.goodsstore.getCount(); i++) {
			totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
			totalAmt += this.goodsstore.getAt(i).get('amt') * 10000;
			totalWeigth += this.goodsstore.getAt(i).get('weigth') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
		this.txt_totWeigth.setValue(Ext.util.Format.number(totalWeigth / 10000,"0.00"));
		this.txt_totAmt.setValue(Ext.util.Format.number(totalAmt / 10000,"0.00"));
	},
	creatselectstore:function(){//订单明细store
	
		this.selectstore =Ext.create('Ext.data.JsonStore', {
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
				keyword:Ext.fly('keyword').dom.value
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
			region:'west',
			width:'35%',
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
			title:'产品分类',
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
					scope:view.store
				});
			 }
		};
		var grid = Ext.create('Ext.grid.Panel',{
			title: '产品列表',
			store:this.selectstore,
			height:500,
			frame:true,
			region:'center',
			autoScroll:true,
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
										selectstore.load({params:{start:0, limit:20,
											keyword:Ext.getCmp('keyword').getValue(),
											cat_id:''
											}});
										}
								}
							],
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
            title: '产品列表',
            closeAction: 'destroy',
			closable:true,
			width:700,
			height:430,
			y:20,
			layout:'border',
            modal: true,
            items: [tree,grid]
        });
		/*if(!this.goodsGrid) this.creatGoodsgrid();
		var goodsgrid = this.goodsGrid;
		grid.on('itemclick', function(grid,record,item, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var me = this;
		var p = Ext.create(me.model,{rec_id:0,goods_sn:getinfo.get('goods_sn'),item_no:'',goods_name:getinfo.get('goods_name'),goods_qty:1,goods_price:0,amt:0,weigth:0});
			this.goodsstore.insert(0, p);
			this.goodsGrid.plugins[0].startEditByPosition({row:0,column:0});
			win.hide();*/
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

