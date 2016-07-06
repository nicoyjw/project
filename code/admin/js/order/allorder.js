Ext.define('Ext.ux.allorderView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
		this.getTab();
		this.tab.items.items[5].setDisabled(false);
		//this.tab.items.items[7].setDisabled(false);
        this.callParent(this);
    },
	creatcolumns:function(){
		var sm = this.sm;
		var data = this.arrdata;
		var cols = [];
		for (var i = 0; i < this.headers.length; i++) {
			if(this.headers[i] == 'order_status') cols.push({
				   header:'状态',
				   dataIndex : this.headers[i],
				   sortable:true,
				   flex:1.3,
				   renderer:function(v,x,rec){
					   var str = comrender(v,data[0]);/*
					   str += (rec.get('has_msg')>0)?'<img src="themes/default/images/feedbackme.gif">':'<img src="themes/default/images/feedbackme_off.gif">';
					   if(rec.get('has_fbk') == 'Positive') str += '<img src="themes/default/images/drop-add.gif">';
					   else if(rec.get('has_fbk') == 'Neutral') str += '<img src="themes/default/images/blue.gif">';
					   else if(rec.get('has_fbk') == 'Negative') str += '<img src="themes/default/images/delete.gif">';
					   else str += '<img src="themes/default/images/grey.gif">';
					   str += (rec.get('has_rma')>0)?'<img src="themes/default/images/icons1/action_stop.gif">':'<img src="themes/default/images/shipped_gy.gif">';*/
					  return str;
					   }
				   });
			if(this.headers[i] == 'paid_time') cols.push({
				   header:'PaidTime',
				   flex:1.1,
				   sortable:true,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'order_sn') cols.push({
				   header:'订单号',
				   flex:1.5,
				   dataIndex : this.headers[i],
				   renderer:function(val,x,rec){
					   	var str = (rec.get('pay_note'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('pay_note') + '">':'';
					   	return '<b>'+val+'</b>' + str ;
					   }
				   });
			if(this.headers[i] == 'paypalid') cols.push({
				   header:'PaypalId',
					flex:2,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'goods') cols.push({
				   header:'产品',
				   sortable:true,
				   flex:2.5,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'stock_place') cols.push({
				   header:'货位',
				   sortable:true,
				   flex:2,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'currency') cols.push({
				   header:'币种',
				   flex:1,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'order_amount') cols.push({
				   header:'总金额',
				   sortable:true,
				   flex:1,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'shipping_id') cols.push({
				   header:'物流',
				  flex:1,
				   sortable:true,
				   dataIndex : this.headers[i],
				   renderer:function(v){ return comrender(v,data[1]);}
				   });
			if(this.headers[i] == 'userid') cols.push({
				   header:'Buyerid',
				   flex:1,
				   sortable:true,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'country') cols.push({
				   header:'国家',
				   flex:1,
				   sortable:true,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'Sales_channels') cols.push({
				   header:'渠道',
				   flex:1,
				   sortable:true,
				   dataIndex : this.headers[i],
				   renderer:function(v){ return comrender(v,data[2]);}
				   });
			if(this.headers[i] == 'Sales_account_id') cols.push({
				   header:'账号',
				   flex:1,
				   sortable:true,
				   dataIndex : this.headers[i],
				   renderer:function(v){ return comrender(v,data[3]);}
				   });
			if(this.headers[i] == 'track_no') cols.push({
				   header:'追踪单号',
				  flex:1,
				   sortable:true,
				   dataIndex : this.headers[i],
				   editor:{}
				  });
			if(this.headers[i] == 'eubpdf') cols.push({
				   header:'PDF',
				   flex:1,
				   dataIndex : this.headers[i],
				   renderer:function(v){ 
				   		if(v != null && v != ''&& (v.substr(v.length-3,3) == 'pdf'||v.substr(v.length-3,3) == 'jpg') ) return '<a href='+v+' target=_blank>'+v+'</a>';
						}
					});
			if(this.headers[i] == 'print_status') cols.push({
				   header:'已打印',
				   dataIndex : this.headers[i],
				   flex:1,
				   renderer:function(v){return (v == 0)?'NO':'Yes';}
				   });
			if(this.headers[i] == 'sellsrecord') cols.push({
				   header:'Salesrecord',
				   flex:1,
				   sortable:true,
				   dataIndex : this.headers[i]
				   });
			if(this.headers[i] == 'stockout_sn') cols.push({
				   header:'出库单号',
				   flex:1,
				   dataIndex : this.headers[i]
				   });	   
		}
		this.columns = cols;
	},
	addcolumns:function(){
		var ds = this.store;
		this.columns.push({
				   header:'发货时间',
				   flex:1,
				   dataIndex : 'end_time'
				   },{
				  header:'操作',
				  flex:1.2,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑订单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
						}
						 },{
						icon   : 'themes/default/images/del.gif',	 
						tooltip: '删除订单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							Ext.Msg.show({
								title:'Delete order?',
								msg:'Are you sure to delete this order?',
								buttons:Ext.Msg.YESNO,
								icon:Ext.MessageBox.ERROR,
								fn:function(btn){
									if (btn == 'yes') {
										Ext.getBody().mask("正在删除订单.请稍等...","x-mask-loading");
										var id = ds.getAt(rowIndex).get('order_id');
									Ext.Ajax.request({
									   url: 'index.php?model=order&action=delorder&id='+id,
										success:function(response,opts){
											var res = Ext.decode(response.responseText);
											Ext.getBody().unmask();
												if(res.success){
												ds.load();
												Ext.example.msg('MSG',res.msg);
												}else{
												Ext.example.msg('ERROR',res.msg);
												}						
											}
										});
									}
									}
								});
						}
						},{
						icon   : 'themes/default/images/editcopy.png',	 
						tooltip: '复制订单',
						iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'新建订单','index.php?model=order&action=add&id='+id,1000,500);
						}
						 }]
				  });
	},
	creatBbar: function() {
		var tempdata = this.arrdata[5];
		var	pagesize = this.pagesize;
		var thiz = this;
       return Ext.create('Ext.toolbar.Paging',{
				plugins: new Ext.ui.plugins.ComboPageSize(),
				pageSize: pagesize,
				displayInfo: true,
				displayMsg: '{0} - {1}  Total : {2} ',
                emptyMsg: "empty",
				store: this.store,
				items:['-',{
					   text:'发送Message',
					   pressed:true,
					   handler:this.sendmessage.bind(this,['0'])
					   },'-',{
					   text:'发送邮件',
					   pressed:true,
					   handler:this.sendmessage.bind(this,['1'])
					   },'-',{
					   text:'退款',
					   pressed:true,
					   handler:this.updatestatus.bind(this,['2'])
					   }/*,'-',{
							   	fieldLabel:'打印排序',
								xtype:'combo',
								id:'printsort',
								mode:'local',
								valueField: 'id',
								width:180,
								labelWidth:70,
								displayField:'template',
								editable: false,		
								triggerAction:'all',
								store:Ext.create('Ext.data.ArrayStore',{
									fields: ["id", "template"],
									data: [['goods_sn', 'SKU'], ['paypalid', '订单号']]												   								})
					   },'-',{
							   	fieldLabel:'选择模板',
								xtype:'combo',
								mode:'local',
								valueField: 'id',
								width:180,
								labelWidth:60,
								displayField:'template',
								editable: false,		
								triggerAction:'all',
								store:Ext.create('Ext.data.ArrayStore',{
									fields: ["id", "template"],
									data: tempdata												   													   													}),
								listeners:{
										select:function(e,record,rowindex){
											thiz.orderprint(e.getValue());
											e.setValue('');
										}
									}
					   }*/,'-',{
					   text:'撤单入库',
					   pressed:true,
					   handler:this.revocation.bind(this)
					   }]		   
        });
    },orderprint:function(type){
		var ids = getIds(this.grid);
		if(!ids) return false;
		openWindowWithPost('index.php?model=order&action=print&type='+type,ids,'订单打印'+Math.floor(Math.random()*100));
/*		var ids = getIds(this.grid);
		if(!ids) return false;
		openWindowWithPost('index.php?model=order&action=print&type='+type,ids,'订单打印'+Math.floor(Math.random()*100));
*/	},
	revocation:function(){
		var s = this.grid.getSelectionModel().getSelection();
		if (s.length > 1) {
			Ext.example.msg('Error','请只选择一条记录进行撤单入库操作');return false;
		}
		var ids = getId(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		Ext.Msg.confirm('操作提示!', '确定进行撤单入库?', function(btn) {
			if (btn == 'yes') {
				Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
				Ext.Ajax.request({
					url:'index.php?model=stockin&action=revocation',
							success:function(response){
								Ext.example.msg('提示',response.responseText);
								thiz.load();
								Ext.getBody().unmask();
								},
							failure:function(response){
								Ext.example.msg('警告','撤单入库失败');
								Ext.getBody().unmask();
								},
					params:{id:ids}			 
				});
                }
            }, this);
	}
});

