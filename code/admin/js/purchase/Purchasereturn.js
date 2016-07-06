Ext.ux.PorderView = Ext.extend(Ext.Viewport, {
    initComponent: function() {
        this.layout = 'form';
		this.createStore();
		this.creatgoodsstore();
		this.createColumns();
		this.createTbar();
		this.creatselectionmodel();
		this.creatBbar();
		this.creatgrid();
		this.creatgoodsview();
		this.creatitems();
		this.grid.getSelectionModel().on('selectionchange', function(sm){
			this.grid.addBtn.setDisabled(sm.getCount() < 1);
			this.grid.removeBtn.setDisabled(sm.getCount() < 1);
			this.grid.editBtn.setDisabled(sm.getCount() < 1);
			this.grid.prtBtn.setDisabled(sm.getCount() < 1);
		});
        Ext.ux.PorderView.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value,
				starttime:Ext.fly('starttime').dom.value,
				totime:Ext.fly('totime').dom.value
			});
		});
    },
	createColumns: function() {
		var ds = this.store;
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length-1; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
		cols.push({
				  header:'操作',
				  width:45,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'编辑订单','index.php?model=Purchasereturn&action=add&order_id='+id,1000,580);
							//alert("编辑 " + rec.get('order_id'));
						}
						 }]
				  });
        this.columns = cols;
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '退货确认',
            iconCls: 'x-tbar-save',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this,['1'])
        }, {
            text: '删除单据',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.updateRecord.bind(this,['0'])
        },{
            text: '生成采购单',
            iconCls: 'x-tbar-add',
			ref: '../addBtn',
			disabled:true,
            handler: this.addPurchase.bind(this)
        },{
            text: '打印',
            iconCls: 'x-tbar-print',
			ref: '../prtBtn',
			disabled:true,
            handler: this.updateRecord.bind(this,['2'])
        },'->','From:',{
						xtype:'datefield',
						name:'starttime',
						id:'starttime',
						format:'Y-m-d'
					},'-','To:',{
						xtype:'datefield',
						name:'totime',
						id:'totime',
						format:'Y-m-d'
					},'-','关键词:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value,
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
								}});
							}
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
        if (r != false) {
		if(str == 2){
			window.open(this.printURL+'&order_id='+r.data.order_id);
			return false;
			}
            Ext.Msg.confirm('操作提示!', '确定修改订单状态?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.updateURL+'&order_id='+r.data.order_id+'&status='+str,
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
	addPurchase:function(){
		var thiz = this.store;
        var r = this.getSelectedRecord();
        if (r != false) {//r.data.order_id
			Ext.Ajax.request({
			   url:'index.php?model=Purchasereturn&action=addPurchase&order_id='+r.data.order_id,
				success:function(response,opts){
					var res = Ext.decode(response.responseText);
						if(res.success){
						Ext.example.msg('MSG',res.msg);
						}else{
						Ext.Msg.alert('ERROR',res.msg);
						}						
					}
				});	
		}
		
	},
	creatselectionmodel:function(){
		var thiz = this;
			var sm = new Ext.grid.CheckboxSelectionModel({
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									thiz.setid(record.data.order_id);
									thiz.goodstore.load({
											params:{order_id:record.data.order_id,start:0,limit:10},
											scope:this.store
											});
										}
								}
							}								 
						});
		this.sm = sm;
	},
	setid:function(id){
			this.selectid = id;
		},
	getid:function(id){
		return this.selectid;
	},
	creatBbar: function() {
		var	pagesize = this.pagesize;
       this.bbar =  new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store			   
        });
    },
	creatgrid:function(){
		this.grid = new Ext.grid.GridPanel({
			title:'<b>退货单列表</b>',
			loadMask:true,
			frame:true,
			autoHeight: true,
			viewConfig:{
            	forceFit: true
        		},
			region:'center',
			store: this.store,
			columns: this.columns,
			sm:this.sm,
			tbar:this.tbar,
			bbar:this.bbar
   		 });
	},
	creatgoodsstore:function(){
		var thiz  = this;
		 this.goodstore = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.goodsURL}),
			reader: new Ext.data.JsonReader({
				root: 'topics',
				totalProperty: 'totalCount',
				id: 'rec_id'
				},['rec_id','goods_qty','goods_price','goods_id','goods_sn','goods_name','goods_img',{name:'amt',convert:function(v,rec){ return rec['goods_qty']*rec['goods_price'];}},'remark']),
			listeners:{
						load: function(){
							var order_id = thiz.getid();
							Ext.apply(
							this.baseParams,
							{
								order_id:order_id
							});
						}
					}
    	});
	},
	creatgoodsview:function(){
		var thiz = this;
		this.goodsview = new Ext.grid.GridPanel({
				store:this.goodstore,
				autoWidth:true,
				region:'south',
				title:'退货明细',
				height:250,
				autoScroll :true,
				columns: [{
					header: '产品编码',
					dataIndex: 'goods_sn'
				},{
					header: '产品名称',
					width:200,
					dataIndex: 'goods_name'
				},{
					header: '产品数量',
					dataIndex: 'goods_qty'
				},{
					header: '产品单价',
					dataIndex: 'goods_price'
				},{
					header: '总计',
					dataIndex: 'amt'
				},{
					header: '备注',
					width:200,
					dataIndex: 'remark'
				}],
				bbar:new Ext.PagingToolbar({
						pageSize: 10,
						displayInfo: true,
						displayMsg: '第{0} 到 {1} 条数据 共{2}条',
						emptyMsg: "没有数据",
						store: thiz.goodstore		   
					})											  
			});
	},
	creatitems:function(){
		return this.items = [this.grid,this.goodsview];
	}
});