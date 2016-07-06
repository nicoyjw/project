Ext.ux.BillForm = Ext.extend(Ext.FormPanel, {
	initComponent: function() {
		this.frame = true,
		this.buttonAlign = 'center',
		this.creatSupplierstore();
		this.creatoperatorstore();
		this.creatinfopart();
		this.creatGridsm();
		this.creatGridcm();
		this.creatGoodsstore();
		this.creatGoodsgrid();
		this.creatItems();
		this.creatButtons();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
		});
        Ext.ux.BillForm.superclass.initComponent.call(this);
    },
	creatSupplierstore:function(){//供应商明细store
		var supplier_id = this.order.supplier_id;
		this.Supplierstore = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.listSupplierURL}),
			reader: new Ext.data.JsonReader({
					root: 'topics',
					totalProperty: 'totalCount',
					id: 'id'
					},['id','name'])
		});
	},
	creatoperatorstore:function(){//操作员明细
		var operator_id = this.order.operator_id;
		this.operatorstore = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.listUserURL}),
			reader: new Ext.data.JsonReader({
					root: 'topics',
					totalProperty: 'totalCount',
					id: 'user_id'
					},['user_id','user_name']),
			autoLoad:true,
			listeners:{
						load: function(){
							Ext.getCmp('operatorid').setValue(operator_id);
						}
					}
		});
	},
	creatinfopart:function(){//基本信息
		this.infopart = new Ext.form.FieldSet({
				height:100,
				layout:'column',
				items:[{
						columnWidth:.3,
						layout: 'form',
						items:[
							 {
								xtype:'combo',
								store: this.operatorstore,
								valueField :"user_id",
								displayField: "user_name",
								mode: 'local',
								editable: false,
								forceSelection: true,
								hiddenName:'operator_id',
								triggerAction: 'all',
								fieldLabel: '操作员',
								allowBlank:false,
								pagesise:10,
								minListWidth:220,
								value:this.order.operator_id,
								id:'operatorid'							
							},{
								xtype:'textfield',
								fieldLabel: '订单备注',
								value:this.order.comment,
								id:'comment'	
							}
						]
					},{
						columnWidth:.3,
						layout: 'form',
						items:[
							{
								xtype:'combo',
								store: this.Supplierstore,
								valueField :"id",
								displayField: "name",
								mode: 'remote',
								width:100,
								readOnly :true,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'supplier_id',
								fieldLabel: '供应商',
								pageSize:30,
								minListWidth:220,
								id:'supplier_id',
									listeners: {
										beforequery:function(qe){
											qe.combo.store.on('beforeload',function(){
												Ext.apply(
												this.baseParams,
												{
													key:qe.query
												});
												});
												qe.combo.store.load();
											}
										}
							},{
								xtype:'textfield',
								readOnly:true,
								fieldLabel: '关联采购单',
								value:this.order.relate_order_sn,
								id:'relate_order_sn'	
							}
						]
					},{
						columnWidth:.3,
						layout: 'form',
						items:[
							 {
								xtype:'combo',
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data: this.orderstatus
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:130,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'status',
								value:this.order.status,
								allowBlank:false,
								fieldLabel: '订单状态',
								id:'statusid'
							},{fieldLabel: '订单编码',id:'order_sn',value:this.order.order_sn,xtype:'hidden'}
							,{fieldLabel: '订单号',id:'order_id',value:this.order.order_id,xtype:'hidden'}
						]
					}]
			});
		var Item = Ext.data.Record.create([{
			id:'supplier',
			name:'supplier_name'
		}]);
		if(this.order.supplier_id)	{
		var p = new Item({id:this.order.supplier_id,name:this.order.supplier_name});
		this.Supplierstore.add(p);
			Ext.getCmp('supplier_id').setValue(this.order.supplier_id);
		}
	},
	
	creatGoodsstore:function(){//订单明细store
		var thiz = this;
		this.goodsstore = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.goodsURL}),
			baseParams : {
				order_id : this.order.order_id
						},
			pruneModifiedRecords:true,
			reader: new Ext.data.JsonReader({
					root: 'topics',
					totalProperty: 'totalCount'
					},['rec_id','goods_qty','goods_id','goods_sn','goods_price','goods_name','remark']),
			listeners:{
						load: function(){
							var reCat = /cgth/gi;
							if(reCat.test(thiz.goodsURL)){
								var i;
								for (i = 0; i < thiz.goodsstore.getCount(); i++) {
									thiz.goodsstore.getAt(i).set('rec_id',0);
								}
							}
						}
					}
		});
		this.goodsstore.load({
			params:{start:0,limit:30},
			scope:this.goodsstore
			});
	},
	creatGridsm:function(){
		this.sm = new Ext.grid.CheckboxSelectionModel();
	},
	creatGridcm:function(){
		var thiz = this;
		var sm = thiz.sm;
		this.cmlist = new Ext.grid.ColumnModel([sm,{
						header : '产品编码<font color=red>*</font>',
						dataIndex:'goods_sn',
						align : 'left'
					}, {
						header:'产品名称<font color=red>*</font>',
						width:250,
						dataIndex:'goods_name',
						align:'left'
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
					}, {
						header:'产品价格<font color=red>*</font>',
						dataIndex:'goods_price',
						align:'right'
					}, {
						header:'产品备注',
						width:200,
						dataIndex:'remark',
						align:'left',
						editor:new Ext.form.TextField()
					}]);
	},
	creatGoodsgrid:function(){//创建产品明细
		this.goodsGrid =new Ext.grid.EditorGridPanel({
					frame:true,
					id : "destPanel",
					title:'单据产品明细',
					height : 300,
					autoWidth : true,
					cm : this.cmlist,
					sm: this.sm,
					ds : this.goodsstore,
					clicksToEdit : 1,
					stripeRows : true, // 让基数行和偶数行的颜色不一样
					viewConfig : {
						forceFit : true
					},
					border : true,
					iconCls : 'icon-grid',
					tbar : new Ext.Toolbar({
						items : [{
							text: '删除',
							iconCls: 'x-tbar-del',
							id: 'removeBtn',
							handler: this.removeItem.bind(this),
							disabled:true
						}]
					}),
					bbar : new Ext.PagingToolbar({
					pageSize: 30,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据",
					store: this.goodsstore			   
					})
				});
	},

	creatItems:function(){
		this.items = [this.infopart,this.goodsGrid];
	},

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.bind(this)
			},{
					text: '取消',
					handler:this.formreset.bind(this)
			}];
	},

	formsubmit:function(){
		var saveURL = this.saveURL;
		var addURL = this.addURL;
		if(this.getForm().isValid()){
				var m = this.goodsstore.modified.slice(0);
				var thiz = this.goodsstore;
				var jsonArray = [];
				Ext.each(m,function(item){
					jsonArray.push(item.data);				
					});
				this.getForm().doAction('submit',{
					url:saveURL,
					method:'post',
					params:{'data':Ext.encode(jsonArray)},
					success:function(form,action){
						if (action.result.success) {
							Ext.example.msg('MSG','订单编辑成功');
							window.location.href = addURL+'&order_id='+action.result.msg;
							} else {
								Ext.Msg.alert('修改失败',action.result.msg);
							}
						},
					failure:function(){
							Ext.example.msg('ERROR','订单编辑失败');
						}
				});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
			}
	},

	formreset:function(){//表单重置
		this.form.reset();
	},

	removeItem:function(){//移除物品
		var data = this.goodsGrid.getSelectionModel().getSelected().data;
		var index = this.goodsstore.findBy(function(record,id){
				return record.get('goods_id') == data.goods_id && record.get('goods_qty') == data.goods_qty;									
													});
		var id = data.rec_id;
		if(id ==0){
			this.goodsstore.remove(this.goodsstore.getAt(index));return;
		}
		var thiz = this.goodsstore;
		var delURL = this.delURL;
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: delURL+'&id='+id,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.remove(thiz.getAt(index));
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this.goodsGrid);
        }
	}
});

