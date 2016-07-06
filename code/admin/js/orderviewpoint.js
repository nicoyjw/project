Ext.define('Ext.ux.OrderView',{
	extend:'Ext.Viewport',
	initComponent: function() {
        this.layout = 'border';
		this.selectid = '';
		this.createForm();
		this.creatselectionmodel();
		this.getTab();
		this.createStore();
		this.creatcolumns();
		this.addcolumns();
		this.creatgrid();
		this.creatitems();
        this.callParent(this);
    },
    createStore: function() {
		var checkcombine = this.uncheckcombine?0:1;
		var values = Ext.getCmp('searchform').getForm().getFieldValues();
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		}); 
        this.store.on('beforeload', function (store, options) {
            var new_params = {
                starttime:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY, -7),"Y-m-d"),
                totime:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY),"Y-m-d"),
                
                };
            Ext.apply(store.proxy.extraParams, new_params);
            });
		this.store.load({
            params:{
                start:0, 
                limit:this.pagesize  
            }
        });
		
    },
	setid:function(str){
			this.selectid ='';
			this.selectid = str;
		},

	getid:function(){
			return this.selectid;
		},

	creatgrid:function(){
		var cm = this.columns;
		var bbar = this.creatBbar();
		var tbar = this.creatTbar();
		this.grid = Ext.create('Ext.grid.Panel',{
			loadMask:true,
			frame:false,
			height: 400,
			autoScroll :true,
			region:'center',
			store: this.store,
			columns: cm,
			selModel:this.sm,
			tbar:tbar,
			bbar:bbar
   		 });
		 //this.grid.on('itemdblclick', this.onRowDblClick, this);
	},
    onRowDblClick: function(grid,record,item, rowIndex, e) {
		var id = this.store.getAt(rowIndex).get('order_id');
		parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,680);
    },
	creatselectionmodel:function(){
		var setid = this.setid;
		doSelect = this.doSelect;
		var tab = this.getTab();
		var sm = Ext.create('Ext.selection.CheckboxModel',{
			listeners:{
				select:function(e,record,rowindex){
					setid(record.data);
					doSelect(tab.getActiveTab().id,record.data);
				}
			}							 
		});
		this.sm = sm;
	},
	doSelect:function(id,info){
		if(!info){
			if(id != 'tab1') Ext.example.msg('错误','请先选择一条订单记录');
			return;
		}
		var tpl1 = new Ext.Template(
			'<div style="padding-left:10px"><p>{consignee}</p>',
			'<p>{street1} {street2}</p>',
			'<p>{city}</p>',
			'<p>{state}</p>',
			'<p>{zipcode}</p>',
			'<p>{country}</p>',
			'<p>{tel}</p><hr>',
			'<p>尺寸:{size}</p>',
			'<p>预估重量:{esweight}</p></div>'
		);
		switch(id){
			case 'tab1':
				tpl1.overwrite(Ext.getCmp("tab1").body, info);
			break;
			case 'tab2':
				Ext.getCmp('tab2_item').getStore().load({params:{order_id:info.order_id}});
			break;
			case 'tab3':
				var iframe = document.getElementById('tab3_iframe');
				iframe.src="index.php?model=order&action=getfee&order_id="+info.order_id+"&" + Math.random();
			break;
			case 'tab10':
				var iframe = document.getElementById('tab10_iframe');
				iframe.src="index.php?model=order&action=getlog&order_id="+info.order_id+"&" + Math.random();
			break;
			case 'tab9':
				var iframe = document.getElementById('tab9_iframe');
				iframe.src="index.php?model=message&action=getordermsg&order_id="+info.order_id+"&" + Math.random();
			break;
			case 'tab4':
				var note  = Ext.getCmp('note1');
				getValueModel(info.order_id,'note','order','note1');
			break;
			case 'tab6':
				Ext.getCmp('tab6_item').getStore().load({params:{order_sn:info.order_sn}});//
			break;
			case 'tab8':
				Ext.getCmp('tab8_item').getStore().load({params:{order_id:info.order_id}});//
			break;
			case 'tab11':
				var iframe = document.getElementById('tab11_iframe');
				iframe.src="index.php?model=order&action=getTrackInfo&order_id="+info.order_id+"&" + Math.random();
			break;
			case 'tab15':
			
				if(info.Sales_channels == 4 && info.has_msg > 0){
					Ext.getCmp('tab15').disabled = false;
				}
				var iframe = document.getElementById('tab15_iframe');
				iframe.src="index.php?model=aliexpress&action=getAlimsg&order_id="+info.paypalid+"&" + Math.random();
			break;
		}
	},

	creatcolumns:function(){
		var sm = this.sm;
		var data = this.arrdata;
		var cols = [];
		for (var i = 0; i < this.headers.length; i++) {
			if(this.headers[i] == 'order_status') 
				cols.push({
				   header:'状态',
				   dataIndex : this.headers[i],
				   sortable:true,
				   flex:1.1,
				   renderer:function(v,x,rec){
					   var str = comrender(v,data[0]);
					   return str;
				   }
				   });
			if(this.headers[i] == 'track_status') 
				cols.push({
				   header:'物流状态',
				   dataIndex : this.headers[i],
				   sortable:true,
				   flex:1.1,
				   renderer:function(v,x,rec){
					   return (v)?v: '未查询';
				   }
				   });
            if(this.headers[i] == 'paid_time') cols.push({
                   header:'PaidTime',
                    flex:1.8,
                   sortable:true,
                   dataIndex : this.headers[i]
                   });
			if(this.headers[i] == 'order_sn') cols.push({
				   header:'订单号',
				    flex:2.8,
				   dataIndex : this.headers[i],
				   renderer:function(val,x,rec){
					   	var str = (rec.get('pay_note'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('pay_note') + '">':'';
						var ordersn = (rec.get('hasmore'))?'<b><font color=red>'+val+'</font></b>':'<b>'+val+'</b>';
						var msgstr = (rec.get('has_msg')>0)?'&nbsp;<img src="themes/default/images/user_msg.png" title="you have '+rec.get('has_msg')+' message!">':'';
					   	return  ordersn + str +msgstr;
					   }
				   });
			if(this.headers[i] == 'paypalid') cols.push({
				   header:'PaypalId/速卖通订单号',
				   flex:2,
				   dataIndex : this.headers[i]
				   }); 
			if(this.headers[i] == 'goods') cols.push({
				   header:'产品',
				   sortable:true,
				    flex:2,
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
            if(this.headers[i] == 'shipping_fee') cols.push({
                   header:'物流费用',
                   flex:1,
                   sortable:true,
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
                   
            if(this.headers[i] == 'ShippingService') cols.push({
                   header:'客选物流',
                   flex:1.6,
                   sortable:true,
                   dataIndex : this.headers[i]
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
				   editor:new Ext.form.TextField()
				   });
			if(this.headers[i] == 'eubpdf') cols.push({
				   header:'PDF',
				    flex:1,
				   dataIndex : this.headers[i],
				   renderer:function(v){ 
				   		if(v != null && v != ''&& (v.substr(v.length-3,3) == 'pdf'||v.substr(v.length-3,3) == 'jpg'||v.substr(0,7) == 'http://'||v.substr(v.length-3,3) == 'zip') ) return '<a href='+v+' target=_blank>'+v+'</a>';
						}
					});
			if(this.headers[i] == 'print_status') cols.push({
				   header:'已打印',
				   dataIndex : this.headers[i],
				    flex:0.6,
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
			//if(this.headers[i] == 'eubpdf') cols.push();
		}
		this.columns = cols;
	},
	addcolumns:function(){
		var ds = this.store;
		this.columns.push({
				  header:'操作',
				  flex:0.6,
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
						icon   : 'themes/default/images/paypal.png',	 
						tooltip: 'paypal信息',
				  		iconCls:'iconpadding',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'paypal信息比对','index.php?model=order&action=readpaypal&id='+id,1000,500);
						}
						 }]
				  });
	},
	orderprint:function(type){
		var ids = getIds(this.grid);
		if(!ids) return false;
		var printsort = Ext.getCmp('printsort').getValue();
		openWindowWithPost('index.php?model=order&action=print&type='+type+'&printsort='+printsort,ids,'订单打印'+Math.floor(Math.random()*100));
	},
    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		var step = this.step;
		var data = this.arrdata;
		var me = this;
        
        var time_type = Ext.create('Ext.form.field.ComboBox', {                 
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: [['1','Paid time'],['2','Shipping time'],['3','Add time']]
            }),
            valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '时间类型...',
            selectOnFocus: true,
            width: 105,
            hideLabel: true,  
            hiddenName:'timetype', 
            name: 'timetype',
            id:'timetype',
            value:'1'
       });
        var account = Ext.create('Ext.form.field.ComboBox', {
            hideLabel: true,
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: data[3]
            }),
             valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '选择账号...',
            selectOnFocus: true,
            width: 120,
            hiddenName:'account',
            name: 'account',
            id:'account',
            value:'0'
        }); 
		return Ext.create('Ext.toolbar.Toolbar',{
			items:['Shipping:','-',{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: data[1]
							}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:140,      
                    forceSelection: true,
                    triggerAction: 'all',
                    queryMode: 'local', 
					name: 'ship',
					id:'ship',
					allowBlank:true,
                    emptyText: '批量改物流方式',
					hideLabel:true,
					listeners: {
						scope:this,
						select: function(c, r, i) {
							Ext.Msg.show({
								title:'更改订单物流方式?',
								msg:'您将改变订单的物流方式，确定吗?',
								buttons:Ext.Msg.YESNO,
								icon: Ext.MessageBox.QUESTION,
								fn:function(btn){
									if (btn == 'yes') {
										Ext.getBody().mask("正在更新订单.请稍等...","x-mask-loading");
										var ids = getIds(me.grid);
										if(!ids) return false;
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
											url:'index.php?model=order&action=updateshipping',
											success:function(response){
											Ext.getCmp('ship').setValue(null);		
											var res = Ext.decode(response.responseText);
											Ext.getBody().unmask();
												if(res.success){
													store.load();
													Ext.getBody().unmask();
													Ext.example.msg('MSG',res.msg);
												}else{
													Ext.getBody().unmask();
													Ext.example.msg('ERROR',res.msg);
												}
												},
											failure:function(response){
                                                Ext.getCmp('ship').setValue(null);
												Ext.example.msg('警告','更新失败');
												Ext.getBody().unmask();
												},
											params:{id:ids,shipping_id:c.getValue()}			 
										});
										}
									}
								});           
							}
						}
            		},'->',account,'-',time_type,'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'starttime',
                        id:'starttime',
                        width:105,
                        allowBlank:false,
                        emptyText: 'From',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY, -7),"Y-m-d") 
                    },'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'totime',
                        id:'totime',
                        width:105,
                        emptyText: 'To',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY),"Y-m-d")   
                    },{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						width:105,      
                        emptyText: '订单号&回车',
                        hideLabel:true,
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){                        
								store.load({params:{start:0, limit:pagesize,
									keyword:Ext.getCmp('keyword').getValue()
									}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'提交查询',
						iconCls:'x-tbar-search',
						handler:function(){
                            store.on('beforeload', function (store, options) {
                            var new_params = {
                                starttime:Ext.getCmp('starttime').getValue(),
                                totime:Ext.getCmp('totime').getValue(),      
                                timetype:Ext.getCmp('timetype').getValue(),      
                                keyword:Ext.getCmp('keyword').getValue(),
                                account:Ext.getCmp('account').getValue()
                                };
                            Ext.apply(store.proxy.extraParams, new_params);
                            });
							store.load({params:{start:0, limit:pagesize}});
							}
					},'-',{
						xtype:'button',
						text:'高级搜索',
						iconCls:'x-tbar-advsearch',
						handler:this.showWindow.bind(this)
					},'-',{
                        text: '导出',
                        iconCls:'x-tbar-import',
                        menu: {
                            xtype: 'menu',
                            plain: true,
                            items: {
                                xtype: 'buttongroup',
                                title: '选择格式', 
                                defaults: {
                                    xtype: 'button',
                                    scale: 'small',
                                    iconAlign: 'left',   
                                    handler: function(){}
                                },
                                items: [{
                                    width: '100%',
                                    text: 'ERP格式',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportorder&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                },{
                                    width: '100%',
                                    text: 'eBay格式',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportebay&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                },{
                                    width: '100%',
                                    text: '拣货清单',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportPicklist&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                }]
                            }
                        }
                    }
				]			   				   
		});	
	},
	
	creatBbar: function() {
		var	pagesize = this.pagesize;
		var tempdata = this.arrdata[4];
		var thiz = this;
        return Ext.create('Ext.toolbar.Paging',{
		   plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '{0} - {1}  Total : {2} ',
            emptyMsg: "empty",
            store: this.store,
			items:[{
			   text:'审核通过',
			   pressed:true,
			   handler:this.updatestatus.bind(this,['1'])
			   },' ',{
			   text:'暂停通过',
			   pressed:true,
			   handler:this.updatestatus.bind(this,['0'])
			   },'-',{
			   text:'自动合并订单',
			   pressed:true,
			   handler:this.autocombine.bind(this)
			   }]				   
        });
    },
	sendmessage:function(type){
		var ids = getIds(this.grid);
		if(!ids) return false;
		alert(type);
		parent.openWindow(ids,'联系客户','index.php?model=message&action=toPartner&ids='+ids+'&type='+type,500,400);
	},
	autocombine:function()
	{
		var step = this.step;
		var thiz = this.store;
		Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
		Ext.Ajax.request({
			url:'index.php?model=order&action=autocombine',
			timeout: 180000,
					success:function(response){
						Ext.example.msg('提示',response.responseText);
						thiz.load();
						Ext.getBody().unmask();
						},
					failure:function(response){
						Ext.example.msg('警告','订单自动合并失败');
						Ext.getBody().unmask();
						},
			params:{step:step}			 
		});
	},
	updatestatus:function(ispass){
		var step = this.step;
		var ids = getIds(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
		Ext.Ajax.request({
			url:'index.php?model=order&action=updatestatus',
					success:function(response){
						Ext.example.msg('提示',response.responseText);
						thiz.load();
						Ext.getBody().unmask();
						},
					failure:function(response){
						Ext.example.msg('警告','订单流程审核失败');
						Ext.getBody().unmask();
						},
			params:{id:ids,ispass:ispass,step:step}			 
		});
	},
	creatTab:function(){
		var add_rma = this.add_rma;
		var store = this.store;
		var getid = this.getid;
		var action = this.action;
		doSelect = this.doSelect;
		var tab2store = Ext.create('Ext.data.JsonStore', {
			fields:['goods_sn','goods_img','good_line_img','item_no','goods_name','goods_qty','goods_price','goods_name_self'],
			proxy: {
				type: 'ajax',
				url:'index.php?model=order&action=getordergoods&type=1',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					root: 'topics'
				}
			}
		});
		var tab2_item = Ext.create('Ext.grid.Panel',{
				id:'tab2_item',
				store:tab2store,
				autoScroll :true,
				columns: [{
					header: '产品图片',
					flex:1,
					dataIndex: 'goods_img',
					renderer:function(v){ return (v)?"<a href='"+v+"' target=_blank><img src='"+v+"' width=100></a>":'';}
				},{
					header: '产品编码',
					flex:1,
					dataIndex: 'goods_sn'
				},{
					header: 'ItemNumber',
					dataIndex: 'item_no',
					flex:1,
					renderer:function(v,x,rec){
						var re;
						if(getid().Sales_channels == 4){
							re = '<a href="http://www.aliexpress.com/snapshot/'+v+'.html" target="_blank">'+v+'</a>';
						}else if(getid().Sales_channels == 1){
							re = "<a href='http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&item="+v+"' target='_blank'>"+v+"</a>";
						}else if(getid().Sales_channels == 3){
							if(getid().country == 'United Kingdom'){
								re = "<a href='http://www.amazon.co.uk/gp/product/"+v+"' target='_blank'>"+v+"</a>";	
							}else if(getid().country == 'Germany'){
								re = "<a href='http://www.amazon.de/gp/product/"+v+"' target='_blank'>"+v+"</a>";
							}else{
								re = "<a href='http://www.amazon.com/gp/product/"+v+"' target='_blank'>"+v+"</a>";
							}
						}else{
							re = v;
						}
						return re;
					}
				},{
					header: '产品名称',
					flex:5,
					dataIndex: 'goods_name',
				   	renderer:function(v,x,rec){
					  return (rec.get('goods_name_self') != v && rec.get('goods_name_self') != 'null')?(v+'<br/>'+rec.get('goods_name_self')):v;
				   }
				},{
					header: '产品数量',
					flex:1,
					dataIndex: 'goods_qty'
				},{
					header: '产品单价',
					flex:1,
					dataIndex: 'goods_price'
				}]											  
			});
			
		var tab6store = Ext.create('Ext.data.JsonStore', {
			fields:['order_time','rma_sn','goods_sn','quantity','order_sn','new_order_sn','reason','country','return_form','tracking','rma_status','return_time'],
			proxy: {
				type: 'ajax',
				url:'index.php?model=rma&action=list',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		});
		
		var data = this.arrdata;
		var tab6_item = Ext.create('Ext.grid.Panel',{
				id:'tab6_item',
				store:tab6store,
				//width:800,
				height:264,
				border:false,
				autoScroll :true,
				columns: [{
					header: 'RMA单据ID',
					flex:2,
					dataIndex: 'rma_sn'
				},{
					header: '订单号',
					flex:2,
					dataIndex: 'order_sn'
				},{
					header: '重发订单号',
					flex:2,
					dataIndex: 'new_order_sn'
				},{
					header: '问题产品',
					flex:2,
					dataIndex: 'goods_sn'
				},{
						header: '数量',
						flex:1,
						dataIndex: 'quantity'
				},{
					header: 'Reason',
					dataIndex: 'reason',
					flex:1,
					renderer:function(v){ return comrender(v,data[4]);}
				},{
					header: '国家',
					flex:1,
					dataIndex: 'country'
				},{
					header: '退回方式',
					flex:1,
					dataIndex: 'return_form'
				},{
					header: 'tracking',
					flex:1,
					dataIndex: 'tracking'
				},{
					header: '状态',
					flex:1,
					dataIndex: 'rma_status'
				},{
					header: '退回时间',
					flex:1,
					dataIndex: 'return_time'
				}],
				tbar:[{
					  text:'创建',
					  iconCls: 'x-tbar-add',
					  handler: function(){
							if(getid())
						  	add_rma(getid(),data[4]);
							else
							Ext.example.msg('MSG','请选择一条订单记录!');
						  }
					  }
				]
			});
			
		var tab8store = Ext.create('Ext.data.JsonStore', {
			fields:['ItemID','ItemTitle','CommentType','answerstatus','CommentTime'],
			proxy: {
				type: 'ajax',
				url:'index.php?model=ecase&action=getfblist',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		});
		var tab8_item = Ext.create('Ext.grid.Panel',{
				id:'tab8_item',
				store:tab8store,
				//width:800,
				height:264,
				border:false,
				autoScroll :true,
				columns: [{
					header: 'ItemID',
					flex:1,
					dataIndex: 'ItemID'
				},{
					header: '产品名',
					flex:1,
					dataIndex: 'ItemTitle'
				},{
					header: '评价类型',
					flex:1,
					dataIndex: 'CommentType'
				},{
					header: '时间',
					flex:1,
					dataIndex: 'CommentTime'
				},{
					header: '是否回复',
					flex:1,
					dataIndex: 'answerstatus',
					renderer:function(v){ return (v==0)?'否':'是';}
				}]
			});		
		var tab = Ext.create('Ext.tab.Panel',{
			activeTab: 0,
			autoWidth:true,
			height:300,
			maxHeight:300,
			plain:true,
			defaults:{autoScroll: true},
			items:[{
			    id:'tab1',
                title: '客户信息',
				listeners: {activate: function(){
						doSelect('tab1',getid());
				}},
                html:''
            },{
				id:'tab2',
                title: '订单明细',
				listeners: {activate: function(){
						doSelect('tab2',getid());
					}},
                items:[tab2_item]
            },{
				id:'tab3',
                title: '费用明细',
				html:'<iframe id="tab3_iframe" src="index.php?model=order&action=getfee" width="100%" height="200" ></iframe>',
				disabled:(action[0]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab3',getid());
				}},
            },{
				id:'tab11',
                title: '物流跟踪',
				html:'<iframe id="tab11_iframe" src="index.php?model=order&action=getTrackNo" width="100%" height="200" ></iframe>',
				listeners: {activate: function(){
						doSelect('tab11',getid());
				}},
            },{
				id:'tab4',
                title: '备注',
				listeners: {activate: function(){
						doSelect('tab4',getid());
					}},
                items:[{
						hideLabel:true,
						xtype:'textarea',
						fieldLabel:'内部备注',
						id:'note1',
						width:220,
						height:150,
						autoScroll:true,
						listeners: {
								change:function(field,e){
									modifymodel(getid().order_id,'note',field.getValue(),'order');
								}
							}
						}]
            },{
				id:'tab15',
                title: 'Aliexpress站内信',
				html:'<iframe id="tab15_iframe" src="index.php?model=message&action=getordermsg" width="100%" height="200"></iframe>',
				listeners: {activate: function(){
					doSelect('tab15',getid());
				}}
            },{
				id:'tab8',
                title: 'EBayFeedback',
				//disabled:true,
				listeners: {activate: function(){
						doSelect('tab8',getid());
					}},
                items:[tab8_item]
            },{
				id:'tab9',
                title: 'EBaymessage',
				border:false,
				//disabled:true,
				html:'<iframe id="tab9_iframe" src="index.php?model=message&action=getordermsg" width="100%" height="200"></iframe>',
				listeners: {activate: function(){
						doSelect('tab9',getid());
					}}
            },{
				id:'tab6',
                title: 'RMA',
				//disabled:true,
				listeners: {activate: function(){
						doSelect('tab6',getid());
					}},
                items:[tab6_item]
            },{
				id:'tab10',
                title: '操作日志'	,
				border:false,
				html:'<iframe id="tab10_iframe" src="index.php?model=order&action=getlog" width="100%" height="200"></iframe>',
				listeners: {activate: function(){
						doSelect('tab10',getid());
					}}

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
	creatitems:function(){
		return this.items = [this.grid,{
							 title:'订单详情',
							 region:'south',
							 height:300,
							 collapsed:false,
							 split: true,
							 collapsible: true,
							 items:[this.tab]
							 }];	
	},
    getForm: function() {
        return this.getFormPanel().getForm();
    },

    getFormPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },

	getKeytype:function(){
			if(!this.keytype) this.keytype = [['0','All Fields'],['1','Order SN'],['2','Country'],['3','Buyerid'],['4','Buyer Name'],['12','Address'],['5','Email'],['6','paypalID'],['7','Tracking No'],['8','SKU'],['9','itemNO'],['10','Phone'],['11','Sales Record']];
			return this.keytype;
		},
	getnotetype:function(){
			if(!this.notetype) this.notetype = [['0','所有'],['1','有'],['2','无']];
			return this.notetype;
	},
    createForm: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var keytype = this.getKeytype();
		var notetype = this.getnotetype();
		var data = this.arrdata;
        var form = Ext.create('Ext.form.Panel',{
            frame: false,
			border:false,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
			autoHeight:true,
			id:'searchform',
            trackResetOnLoad: true,
            items: [{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: keytype
						}),
						valueField :"id",
						width:270,
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'keytype',
						fieldLabel: '搜索字段',
						name: 'keytype',
						id:'keytype',
						value:'0'
					},{
						name:'keywords',
						id:'keywords',
						fieldLabel: '关键词',
						value:'',
						width:270,
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								Ext.getCmp('keyword').setValue('');
								var values = Ext.getCmp('searchform').getForm().getFieldValues();
									store.load({params:{start:0, limit:pagesize,
									starttime:Ext.getCmp('starttime').getValue(),
                                    totime:Ext.getCmp('totime').getValue(),
									keytype:values.keytype,
									shipping:values.shipping,
									account:values.account,
									status:values.status,
									salechannel:values.salechannel,
									key:values.keywords					
									}});
									Ext.getCmp('searchwin').hide();
								}
							}
						}
					},{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: data[1]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:270,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'shipping',
						fieldLabel: '发货方式',
						name: 'shipping',
						id:'shipping',
						value:'0'
					},{
						xtype:'combo',
						store:Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: data[0]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:270,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'status',
						fieldLabel: '订单状态',
						name: 'status',
						id:'status',
						value:'0'
					},{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: data[2]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:270,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'salechannel',
						fieldLabel: '销售渠道',
						name: 'salechannel',
						id:'salechannel',
						value:'0'
					},{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: notetype
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:270,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'notetype',
						fieldLabel: '订单留言',
						name: 'notetype',
						id:'notetype',
						value:'0'
					}],
            buttons: [{
                text: 'submit',
				handler:function(){
						Ext.getCmp('keyword').setValue('');
						var values = Ext.getCmp('searchform').getForm().getFieldValues();
						store.on('beforeload', function (store, options) {
							var new_params = {
								starttime:Ext.getCmp('starttime').getValue(),
                                totime:Ext.getCmp('totime').getValue(),
                                account:values.account,
								keytype:values.keytype,
								notetype:values.notetype,
								timetype:values.timetype,
								shipping:values.shipping,  
								status:values.status,
								salechannel:values.salechannel,
								key:values.keywords		
								};
							Ext.apply(store.proxy.extraParams, new_params);
							});
                       store.load({ params: { start: 0, limit: this.pagesize} });
						Ext.getCmp('searchwin').hide();
						}
            }, {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
		
        return form;
    },

    showWindow: function() {
        this.getWindow().show();
    },

    hideWindow: function() {
        this.getWindow().hide();
    },

    getWindow: function() {
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow();
        }
        return this.gridWindow;
    },

    createWindow: function() {
        var formPanel = this.getFormPanel();

        var win = Ext.create('Ext.window.Window',{
			id:'searchwin',
            title: this.windowTitle,
            closeAction: 'hide',
			width:this.windowWidth,
			border:false,
			frame:true,
			bodyStyle:'padding:5 5 5 5;',
			autoHeight:true,
            modal: true,
            items: [
                formPanel
            ]
        });
        return win;
    },
	add_rma:function(id,reason,showreason) {
		var win,rma_form;
		rma_form =Ext.create('Ext.form.Panel',{
			labelWidth: 75, 
			url:'index.php?model=rma&action=save',
			frame:false,
			bodyStyle:'padding:5 5 5 5;',
			border:false,
			defaultType: 'textfield',
			defaults:{
			width:'60%'
			},
			items: [{
					fieldLabel: '订单号',
					name: 'order_sn',
					width:270,
					labelWidth:75,
					readOnly  : true,
					style:'border:none;background:none',
					value:id.order_sn
				},{
						fieldLabel: '问题产品',
						width:270,
						labelWidth:75,
						name: 'goods_sn'
				},{
						fieldLabel: '数量',
						width:270,
						labelWidth:75,
						name: 'quantity'
				},{
					fieldLabel: '国家',
					name      : 'country',
					width:270,
					labelWidth:75,
					readOnly  : true,
					style:'border:none;background:none',
					value:id.country
				},{
					xtype:'combobox',
					store:Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						data: reason
					}),
					valueField :"id",
					displayField: "key_type",
				  mode: 'local',
				  width:270,
				  labelWidth:75,
				  allowBlank:false,
				  blankText:'不能为空',
				  editable: false,
				  forceSelection: true,
				  triggerAction: 'all',
				  hiddenName:'reason',
				  fieldLabel: 'Reason',
				  emptyText:'选择',
				  name: 'reason_id'
				}
				, {
					fieldLabel: '退回方式',
					width:270,
					labelWidth:75,
					name: 'return_form'
				}, {
					fieldLabel: 'Tracking NO',
					width:270,
					labelWidth:75,
					name: 'tracking'
				}
				, {
					fieldLabel: '退回时间',
					xtype:'datefield',
					width:270,
					labelWidth:75,
					name: 'return_time',
					blankText:'不能为空',
					format:'Y-m-d',
					invalidText:'格式错误！'
				},{
					fieldLabel: '备注',
					xtype:'textarea',
					width:300,
					labelWidth:75,
					name: 'remark'
				}
			],
			buttonAlign :'center',
			buttons: [{
				text: '提交',
				handler: function() {
					if(rma_form.getForm().isValid()){
							  rma_form.getForm().submit({
								 success:function(form,action){
										if (action.result.success) {
											Ext.getCmp('tab6_item').getStore().load();
											Ext.example.msg('MSG',action.result.msg);
										} else {
											Ext.Msg.alert('添加失败',action.result.msg);
										}
								 },
								 failure:function(){
										Ext.example.msg('操作','服务器出现错误请稍后再试！');
								 }
							  });
							  win.hide();
					}
			   }//end handler
			},{
				text: '重设',
				handler:function(){
					rma_form.getForm().reset();
				}
			}]
		});//rma_form
		if(!win){
			win = Ext.create('Ext.window.Window',{
				title:'RMA单据_添加',
				layout:'fit',
				width:500,
				autoHeight:true,
				modal:true,
				plain: true,
				collapsible:true,
				items:rma_form,
				close:function(){
					rma_form.getForm().hide();
				}
			});
		}
		win.show();
	}
});

