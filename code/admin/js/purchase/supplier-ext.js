Ext.ux.SupplierGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		this.creatselectionmodel();
        Ext.ux.SupplierGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value
			});
		});
	},
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        },'->','-','关键词:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
							store.load({params:{start:0, limit:pagesize,
								keyword:field.getValue()
								}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出供应商产品列表',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href='index.php?model=supplier&action=supplierGoods&type=export&keyword='+Ext.fly('keyword').dom.value;
							}
					}];
    },
	creatselectionmodel:function(){
		var sm = new Ext.grid.RowSelectionModel({
						singleSelect:true,
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									this.grid.removeBtn.setDisabled(false);
									this.grid.editBtn.setDisabled(false);
										Ext.getCmp('SupplierGoodsGrid').setid(record.data.id);
										Ext.getCmp('SupplierGoodsGrid').setTitle("编辑供应商"+record.data.name+"产品列表");
										//console.log(Ext.getCmp('SupplierGoodsGrid').getid());
										Ext.getCmp('addBtn').setDisabled(false);
										Ext.getCmp('exportBtn').setDisabled(false);
										Ext.getCmp('delBtn').setDisabled(false);
										Ext.getCmp('SupplierGoodsGrid').getStore().load({
																	params:{start:0,limit:10,supplier_id:record.data.id}
																	});
										Ext.getCmp('SupplierGoodsGrid').calculate();
									}
								}
							}								 
						});
			this.sm = sm;
	}
});

Ext.ux.SupplierGoodsGrid = Ext.extend(Ext.grid.EditorGridPanel, {
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.clicksToEdit = 1,
		this.creatselectstore();
		this.sm = new Ext.grid.RowSelectionModel({singleSelect:true});
        this.createStore();
        this.createColumns();  
		this.createTbar();
		this.createBbar();
		this.getSelectionModel().on('selectionchange', function(sm){
			this.removeBtn.setDisabled(sm.getCount() < 1);
			this.editBtn.setDisabled(sm.getCount() < 1);
		});
		Ext.ux.SupplierGoodsGrid.superclass.initComponent.call(this);
    },
	setid:function(id){
		this.supplier_id = id;
	},
	getid:function(){
		return this.supplier_id;
	},
    createStore: function() {
		var thiz = this;
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields),
			listeners : {
				'load' : this.calculate.createDelegate(this),
				'add' : this.calculate.createDelegate(this),
				'remove' : this.calculate.createDelegate(this),
				'update' : this.calculate.createDelegate(this)
			}
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				supplier_id:thiz.getid()
			});
		});
    },
	calculate:function(){
		if(this.store.getCount() > 0) {
			Ext.getCmp('saveBtn').setDisabled(false);
			Ext.getCmp('editBtn').setDisabled(false);
			Ext.getCmp('removeBtn').setDisabled(false);
		}else{
			Ext.getCmp('saveBtn').setDisabled(true);
			Ext.getCmp('editBtn').setDisabled(true);
		}
	},
	createColumns: function() {
		this.cm = new Ext.grid.ColumnModel([{
						header : '产品编码<font color=red>*</font>',
						dataIndex:'goods_sn',
						width:50,
						align : 'left',
						editor:new Ext.form.TextField({
								allowBlank:false,
								readOnly:true,
								hideLabel:true
						})
					}, {
						header:'供应商编码<font color=red>*</font>',
						dataIndex:'supplier_goods_sn',
						width:50,
						align:'right',
						editor:new Ext.form.TextField({
							allowNegative:false,
							style:'text-align:left'
						})
					}, {
						header:'供应商名称<font color=red>*</font>',
						dataIndex:'supplier_goods_name',
						align:'right',
						editor:new Ext.form.TextField({
							allowNegative:false,
							style:'text-align:left'
						})
					}, {
						header:'供应商价格<font color=red>*</font>',
						dataIndex:'supplier_goods_price',
						width:50,
						align:'right',
						editor:new Ext.form.NumberField({
							allowBlank:false,
							allowNegative:false,
							decimalPercision:4,
							style:'text-align:left'
						})
					}, {
						header:'采购链接',
						dataIndex:'url',
						width:50,
						align:'right',
						editor:new Ext.form.TextField({
							allowNegative:false,
							style:'text-align:left'
						})
					}, {
						header:'备注',
						width:30,
						dataIndex:'supplier_goods_remark',
						align:'right',
						editor:new Ext.form.TextField({
							allowNegative:false,
							style:'text-align:left'
						})
					}]);
    },
    createTbar: function() {
		var getid = this.getid;
		var store = this.store;
        this.tbar = new Ext.Toolbar({
						items : [{
							xtype:'button',
							text:'新增产品',
							id: 'addBtn',
							disabled:true,
							ref: '../addBtn',
							iconCls: 'x-tbar-add',
							handler:this.createWindow.createDelegate(this,['0'])
						},{
							xtype:'button',
							text:'更换产品',
							id: 'editBtn',
							ref: '../editBtn',
							disabled:true,
							iconCls: 'x-tbar-update',
							handler:this.createWindow.createDelegate(this,['1'])
						},{
							text: '删除产品',
							iconCls: 'x-tbar-del',
							id: 'removeBtn',
							ref: '../removeBtn',
							handler: this.removeItem.createDelegate(this),
							disabled:true
						},{
							text: '保存产品列表',
							iconCls: 'x-tbar-save',
							ref: '../saveBtn',
							id: 'saveBtn',
							handler: this.saveItem.createDelegate(this),
							disabled:true
						},{
							text: '导出产品列表',
							iconCls:'x-tbar-import',
							ref: '../exportBtn',
							id: 'exportBtn',
							handler: this.exportItem.createDelegate(this),
							disabled:true
						},{
							text: '清空此供应商产品',
							iconCls: 'x-tbar-del',
							id: 'delBtn',
							ref: '../delBtn',
							disabled:true,
							handler: this.delItem.createDelegate(this)
						},{
						xtype:'textfield',
						id:'keyword1',
					    name:'keyword1',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
							store.load({params:{start:0, limit:10,
								supplier_id:getid(),
								keyword:field.getValue()
								}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:10,supplier_id:getid(),keyword:Ext.fly('keyword1').dom.value}});
							}
					}]
					});
    },
    createBbar: function() {
        this.bbar = new Ext.PagingToolbar({
			pageSize: 10,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
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
				cat_id:Ext.getCmp('cat_id').getValue(),
				keyword:Ext.fly('keyword2').dom.value
			});
		});
	},
    createWindow: function(num) {//弹出产品选择窗口
		var supplier_id = this.getid();
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
				Ext.getCmp('cat_id').setValue(node.id);
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
									name:'keyword2',
									id:'keyword2',
									enableKeyEvents:true,
									listeners:{
										scope:this,
										keypress:function(field,e){
												if(e.getKey()==13){
													selectstore.load({params:{start:0, limit:20,
														keyword:Ext.getCmp('keyword2').getValue(),
														cat_id:''
														}});
												}
											}
									}
								}),{xtype:'hidden',id:'cat_id',value:0},
								'-',{
									xtype:'button',
									text:'搜索',
									iconCls:'x-tbar-search',
									handler:function(){
										//console.log(store.getAt(0).get('order_id'))
										selectstore.load({params:{start:0, limit:20,
											keyword: Ext.getCmp('keyword2').getValue(),
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
			autoScroll:true,
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
			name : 'supplier_goods_sn'
		},{
			name : 'supplier_goods_name'
		}, {
			name : 'supplier_goods_price',
			type : 'float'
		},{
			name : 'supplier_goods_remark'
		}, {
			name : 'supplier_id',
			type:'float'
		}]);
		grid.on('rowclick', function(grid, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var p = new Item({rec_id:0,goods_sn:getinfo.get('goods_sn'),goods_id:getinfo.get('goods_id'),supplier_goods_sn:'',supplier_goods_name:getinfo.get('goods_name'),supplier_goods_price:0,supplier_goods_remark:'',supplier_id:supplier_id});
			if(num == 1) {
				var getSelect = thiz.getSelectionModel().getSelected();
				if(!getSelect) Ext.example.msg('发生错误','请先选择一条产品数据进行再更换产品操作');
				getSelect.set('supplier_goods_name',getinfo.get('goods_name'));
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
	addItem:function(p){//新增物品
		this.store.insert(0, p);
		this.startEditing(0, 1); // 光标停留在第几行几列
	},
	removeItem:function(){//移除物品
		if(this.store.getCount() == 0) {
				Ext.example.msg('错误','产品数据不能为空');
				return false;
				}
		var data = this.getSelectionModel().getSelected().data;
		var index = this.store.findBy(function(record,id){
				return record.get('supplier_goods_sn') == data.supplier_goods_sn;									
													});
		var id = data.rec_id;
		if(id ==0){
			this.store.remove(this.store.getAt(index));return;
		}
		var thiz = this.store;
		var delURL = this.delURL;
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: delURL+'&id='+id,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.reload();
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
        }
	},
	saveItem:function(){
			var thiz = this.store;
			if(thiz.getCount() == 0) {
				Ext.example.msg('错误','产品数据不能为空');
				return false;
				}
			var jsonArray = [];
				var m = this.store.modified.slice(0);
				Ext.each(m,function(item){
					if(item.data.supplier_goods_sn != '' && item.data.supplier_goods_name != "") jsonArray.push(item.data);
					});
            Ext.Msg.confirm('保存数据', '确定提交?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.saveURL,
					   params:{'data':Ext.encode(jsonArray)},
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								thiz.commitChanges();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
	},
	delItem:function(){
		var id = this.getid();
		if(!id) return false;
		var thiz = this.store;
            Ext.Msg.confirm('确定清空此供应商产品', '确定提交?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.clearURL,
					   params:{'id':id},
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								thiz.reload();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
	},
	exportItem:function(){
		window.open().location.href = 'index.php?model=supplier&action=exportgoods&supplier_id='+this.getid();
	}
});
