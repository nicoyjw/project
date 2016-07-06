Ext.define('Ext.ux.PaypalGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
		this.createTbar();
        this.createBbar();
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:['ORDERTIME','paypalid','CURRENCYCODE','consignee','AMT','email','country','p_id','status'],
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'paypalid',
					root: 'topics'
				}
			}
		})
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
		})
    },

	
	createColumns: function() {
		var ds = this.store;
        this.columns = [{
			header:'下单时间',
			flex:1,
			dataIndex:'ORDERTIME'
			},{
			header:'交易号',
			flex:1,
			dataIndex:'paypalid'
			},{
			header:'币种',
			flex:1,
			dataIndex:'CURRENCYCODE'
			},{
			header:'客户',
			flex:1,
			dataIndex:'consignee'
			},{
			header:'金额',
			flex:1,
			dataIndex:'AMT'
			},{
			header:'邮箱',
			flex:1,
			dataIndex:'email'
			},{
			header:'国家',
			flex:1,
			dataIndex:'country'
			},{
			header:'收款账户',
			dataIndex:'p_id',
			flex:1,
			renderer:this.rendererlist[0]
			},{
			header:'操作',
			flex:1,
			xtype: 'actioncolumn',
			items:[{
						icon   : 'themes/default/images/drop-add.gif',	 
						tooltip: '制作订单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('paypalid');
							parent.openWindow(id,'新建订单','index.php?model=order&action=add&paypalid='+id,1000,500);
						}
						 },{
						icon   : 'themes/default/images/add.gif',	 
						tooltip: '收款单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('paypalid');
							parent.openWindow(id,'新建收款单','index.php?model=finance&action=addreceipt&paypalid='+id,300,360);
						}
						 },{
						icon   : 'themes/default/images/del.gif',	 
						tooltip: '付款单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('paypalid');
							parent.openWindow(id,'新建付款单','index.php?model=finance&action=addpay&paypalid='+id,300,360);
						}
						 },{
						icon   : 'themes/default/images/save.gif',	 
						tooltip: '关联付款单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('paypalid');
							Ext.Msg.prompt('关联付款单','付款单号',function(btn,text){
									if (btn == 'ok') {
									Ext.getBody().mask("正在处理中.请稍等...","x-mask-loading");
									var id = ds.getAt(rowIndex).get('paypalid');
									Ext.Ajax.request({
									   url: 'index.php?model=finance&action=relategf&paypalid='+id+'&ordersn='+text,
										success:function(response,opts){
											Ext.getBody().unmask();
											var res = Ext.decode(response.responseText);
												if(res.success){
												Ext.example.msg('MSG',res.msg);
												}else{
												Ext.Msg.alert('ERROR',res.msg);
												}						
											}
										});
									}
								});
						}
						 },{
						icon   : 'themes/default/images/flag_green.gif',	 
						tooltip: '标记已做',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							Ext.Msg.confirm('Action Alert!', '确定不处理此交易流水?', function(btn) {
                				if (btn == 'yes') {
									Ext.getBody().mask("正在处理中.请稍等...","x-mask-loading");
									var id = ds.getAt(rowIndex).get('paypalid');
									Ext.Ajax.request({
									   url: 'index.php?model=order&action=changeporder&paypalid='+id,
										success:function(response,opts){
											Ext.getBody().unmask();
											var res = Ext.decode(response.responseText);
												if(res.success){
												ds.load();
												Ext.example.msg('MSG',res.msg);
												}else{
												Ext.Msg.alert('ERROR',res.msg);
												}						
											}
										});
								}
							},this);						
						}
						 }],
			renderer:function(v,m,rec){
				if(rec.get('status') > 0) {
					this.items[0].iconCls ='hidden';
					this.items[1].iconCls ='hidden';
					this.items[2].iconCls ='hidden';
					this.items[3].iconCls ='hidden';
					this.items[4].iconCls ='hidden';
					}else{
					this.items[0].iconCls ='iconpadding';
					this.items[1].iconCls ='iconpadding';
					this.items[2].iconCls ='iconpadding';
					this.items[3].iconCls ='iconpadding';
					this.items[4].iconCls ='iconpadding';
					}
				}
			}];
    },
    createTbar: function() {
        this.tbar = [{
            text: '检查订单存在流水',
            iconCls: 'x-tbar-add',
            handler: this.checktrans.bind(this)
        }];
    },
	checktrans:function(){
		var ds = this.store;
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=order&action=checktrans',
					   loadMask:true,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								Ext.Msg.alert('MSG',res.msg);
								ds.load();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
	},
    createBbar: function() {
        this.bbar =Ext.create('Ext.toolbar.Paging',{
			pageSize: this.pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:[
			]
        });
    }
});

