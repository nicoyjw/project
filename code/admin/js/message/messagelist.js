Ext.define('Ext.ux.MessageView',{
	extend:'Ext.Viewport',
	initComponent: function() {
		this.layout = 'border';
		this.selectid = '';
		this.createStore();
		this.createorderStore();
		this.creatForm();
		this.creatselectionmodel();
		this.creatTree();
		this.creatgrid();
		this.creatordergrid();
		this.creatitems(); 
        this.callParent();
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:['id','messageid','SenderID','sender_mail','body','subject','itemid','itemtitle','goods_img','answer','accountid','CreationDate','answerstatus','ebay_ack','itemEndTime','msg_type','has_history','note'],
			pageSize: this.pagesize,
			//autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		});
		/*this.store.on('beforeload',function(){
			Ext.getCmp('message_status_fld_id').setValue('');
			Ext.getCmp('message_type_id').setValue('');
			Ext.apply(
			this.baseParams,
			{
				key:Ext.fly('key_id').dom.value,
				starttime:Ext.fly('starttime_id').dom.value,
				totime:Ext.fly('totime_id').dom.value,
				msg_type:Ext.getCmp('msg_type1_id').getValue(),
				answerstatus:Ext.getCmp('answerstatus_id').getValue(),
				accountid:Ext.getCmp('accountid').getValue()
			});
		});*/
    },
    createorderStore: function() {
		this.store/* = Ext.create('Ext.data.JsonStore', {
			fields:['order_id','order_sn','track_no','order_status','end_time','street1','street2','consignee','city','state','zipcode','country','tel'],
			pageSize: this.pagesize,
			proxy: {
				type: 'ajax',
				url:this.orderURL,
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'order_id',
					root: 'topics'
				}
			}
		})*/;			
    },

	setid:function(str){
		this.selectid = str;
	},

	getid:function(){
		return this.selectid;
	},

	creatTree:function(){
		var store = this.store;
		var Tree = Ext.tree;
		/*var tree = Ext.create('Ext.tree.Panel',{
			border:true,
			store: Ext.create('Ext.data.TreeStore', {
				autoLoad:true,
				proxy: {
					type: 'ajax',
					url:this.accountTreeURL
				},
				root: {
					text: '总类',
					draggable:false,
					id:'root'
				}
			}),
			region:'west',
			id:'west-panel',
			width: 280,
			minSize: 175,
			maxSize: 400,
			margins:'0 0 0 0',
			title:'选择账号',
			collapsible :true,
			split: true,
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
				Ext.getCmp('accountid').setValue(node.data.id);
				store.load({
					params:{start:0,accountid:node.data.id,limit:20},
					scope:this.store
				});
			 }
		};*/
        var tree = Ext.create('Ext.tree.Panel',{
            border:true,
            store: Ext.create('Ext.data.TreeStore', {
                autoLoad:true,
                proxy: {          
                    type: 'ajax',
                    url:this.accountTreeURL
                },
                root: {
                    text: '总类',
                    draggable:false,
                    id:'root'
                }
            }),
            region:'west',
            id:'west-panel',
            width: 280,
            minSize: 175,
            maxSize: 400,
            margins:'0 0 0 0',
            title:'选择账号',
            collapsible :true,
            split: true,
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
                if(Ext.getCmp('accountid')){
                    Ext.getCmp('accountid').setValue(node.data.id);
                }
                store.on('beforeload', function (store, options) {
                            var new_params = {
                                accountid:node.data.id    
                                };
                Ext.apply(store.proxy.extraParams, new_params);
                });
                store.load({
                    params:{start:0,accountid:node.data.id,limit:pagesize},
                    scope:this.store
                });
             }
        };              
		this.tree = tree;
	},

	creatgrid:function(){
		var cm = this.creatcolumns();
		var bbar = this.creatBbar();
		var tbar = this.creatTbar();
		this.grid = Ext.create('Ext.grid.Panel',{
			loadMask:true,
			frame:true,
			height: 500,
			id:'message_grid_id', 
			region:'center',
			store: this.store,
			columns : cm,
			selModel:this.sm,
			tbar:tbar,
			bbar:bbar
   		 });
	},

	creatselectionmodel:function(){
		var setid = this.setid;
		doSelect = this.doSelect;
			var sm /*= Ext.create('Ext.selection.CheckboxModel',{
                
                    listeners: {
                    select:function(e,rowindex,record){
                        setid(record.data.id);
                        doSelect(record.data);
                        Ext.getCmp('childremoveBtn').setDisabled(false);
                    },
                    selectionchange:function(sm){
                            if (sm.getCount()) {
                            //Ext.getCmp("sendmsg").enable();
                            } else {
                            Ext.getCmp("sendmsg").disable();
                            }                                    
                        }
                    }})*/    ;
			this.sm = sm;
	},

	doSelect:function(info){
		if(!info){
				return false;
			}
		Ext.getCmp('buyerid').setText('<a href="http://myworld.ebay.com/'+info.SenderID+'" target="_blank">'+info.SenderID+'</a>',false);
		Ext.getCmp('creatdate').setText(info.CreationDate);
		Ext.getCmp('messagebody').setText(info.body,false);
		Ext.getCmp('answer').setValue(info.answer);
		Ext.getCmp('note').setValue(info.note);
		Ext.getCmp('msg_type').setValue(info.msg_type);
		Ext.getCmp('template').setValue(0);
		Ext.getCmp('title').setText('<a href="http://item.ebay.com/'+info.itemid+'" target="_blank">'+info.itemtitle+'</a>',false);
		if(info.has_history) Ext.getCmp("look_history_record").enable();
		else Ext.getCmp("look_history_record").disable();
		if(info.itemid) Ext.getCmp('orderGird').getStore().load({
					params:{Sales_account_id:info.accountid,itemid:info.itemid,buyerid:info.SenderID}
					});
		Ext.getCmp("order_addr_panel_id").update('');
	},
	creatcolumns:function(){
		var ds = this.store;
		var sm = this.sm;
		var msgtype = this.arrdata[2];
		var thiz = this;
		var cols =[sm,{
				   header:'回复状态',
				   width:30,
				   dataIndex : 'answerstatus',
				   renderer:function(v){
					   			if(v == 1) return '<img src=themes/default/images/flag_green.gif>';
								if(v == 0) return '<img src=themes/default/images/flag_red.gif>';
								if(v == 3) return '<img src=themes/default/images/flag_blue.gif>';
								}
				   },{
				   header:'发送状态',
				   width:40,
				   dataIndex : 'ebay_ack',
				   renderer:function(v){if(v==0) return '未发送';if(v==1) return 'Success';if(v==2) return 'Failure';}
					},{
				   header:'分类',
				   width:40,
				   dataIndex : 'msg_type',
				   renderer:function(v){ return comrender(v,msgtype);}
					},{
				   header:'FROM',
				   width:50,
				   dataIndex : 'SenderID'
				   },{
				   header:'Item Ends',
				   width:30,
				   dataIndex : 'itemEndTime'
				   },{
				   header:'Subject',
				   dataIndex : 'subject'
				   },{
				   header:'Date',
				   width:40,
				   dataIndex : 'CreationDate'
				   }];
		return new Ext.grid.ColumnModel(cols);
	},
    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		var keytype = this.getKeytype();
		var cat = this.arrdata[0];
		var msgtype = this.arrdata[2];
		return new Ext.Toolbar({
			items:['<b>Message列表</b>',
				   '->','From：',{
						xtype:'datefield',
						name:'starttime',
						id:'starttime_id',
						format:'Y-m-d'
					},'To：',{
						xtype:'datefield',
						name:'totime',
						id:'totime_id',
						format:'Y-m-d'
					},'关键词：',{
					xtype:'textfield',
					width:80,
					name:'key',
					id:'key_id',
					value:''
					},'账户：',{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: cat
						}),
						valueField :"id",
						width:100,
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'accountid',
						name: 'accountid',
						id:'accountid',
						value:0
					},'是否回复：',{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: keytype
						}),
						valueField :"id",
						width:100,
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'answerstatus',
						name: 'answerstatus',
						id:'answerstatus_id',
						value:2
					},'分类：',{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: msgtype
								}),
								valueField :"id",
								width:100,
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'msg_type1',
								id: 'msg_type1_id',
								value:0
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
									key:Ext.fly('key_id').dom.value,
									starttime:Ext.fly('starttime_id').dom.value,
									totime:Ext.fly('totime_id').dom.value,
									msg_type:Ext.getCmp('msg_type1_id').getValue(),
									answerstatus:Ext.getCmp('answerstatus_id').getValue(),
									accountid:Ext.getCmp('accountid').getValue()
								}});
							}
					}
				]			   				   
		});	
	},
	
	creatBbar: function() {
		var store=this.store;
		var	pagesize = this.pagesize;
		var msgtype = this.arrdata[2];
		var type_comb = {
		xtype:'combo',
		store: Ext.create('Ext.data.ArrayStore',{
			fields: ['id','name'],
			data: msgtype
		}),
		width:70,
		valueField :"id",
		listeners:{
			select:function(combo,record,index){
				var grid= Ext.getCmp('message_grid_id');
				var msgtype=record.data.id;
				var ids = getIds(grid);
				if(msgtype!=null&&ids!=null){
					Ext.Ajax.request({
						url: 'index.php?model=message&action=changetype&ids='+ids+'&msg_type='+msgtype,
						success: function(response){
							var result =Ext.decode(response.responseText);
							if(result.success==true){
								Ext.example.msg('提示',result.msg);
								store.reload();
							 }
							if(result.success==false){
								Ext.example.msg('提示',result.msg);
							 }
						}
					});
				}//end if
				else{
					Ext.example.msg('提示','没有选择记录');
				}
			}
		},
		displayField: "name",
		mode: 'local',
		editable: false,
		allowBlank: true,
		forceSelection: true,
		triggerAction: 'all',
		hiddenName:'message_type',
		emptyText:'选择',
		name: 'message_type',
		id:'message_type_id'
		};
		var type_comb2 = {
		xtype:'combo',
		store: Ext.create('Ext.data.ArrayStore',{
			fields: ['id','name'],
			data: [['0','未回复'],['1','已回复'],['3','无需回复']]
		}),
		width:70,
		valueField :"id",
		listeners:{
			select:function(combo,record,index){
				var grid= Ext.getCmp('message_grid_id');
				var statustype=record.data.id;
				var ids = getIds(grid);
				if(statustype!=null&&ids!=null){
					Ext.Ajax.request({
						url: 'index.php?model=message&action=changestatus&ids='+ids+'&statustype='+statustype,
						success: function(response){
							var result =Ext.decode(response.responseText);
							if(result.success==true){
								Ext.example.msg('提示',result.msg);
								store.reload();
							 }
							if(result.success==false){
								Ext.example.msg('提示',result.msg);
							 }
						}
					});
				}//end if
				else{
					Ext.example.msg('提示','没有选择记录');
				}
			}
		},
		displayField: "name",
		mode: 'local',
		editable: false,
		allowBlank: true,
		forceSelection: true,
		triggerAction: 'all',
		hiddenName:'message_status_fld',
		emptyText:'选择',
		name: 'message_status_fld',
		id:'message_status_fld_id'
		};		
       return Ext.create('Ext.toolbar.Paging',{
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:['-','更改分类:',type_comb,'-','更改状态:',type_comb2,'-',
				   {
					   text:'批量回复Message',
					   pressed:true,
					   id: 'sendmsg',
					   disabled: true,
					   handler:this.sendMsg.bind(this)
					}
				   ]
        }); 
        
    },

	sendMsg:function(){
		var ids = getIds(this.grid);
		var url=this.editMsgUrl+'&ids='+ids;
		parent.openWindow('send_history','编辑Message',url,800,500);	
	},

	creatForm:function(){
		var store1 = this.store;
		var getid = this.getid;
		var temp = this.arrdata[1];
		var lookReplyUrl = this.lookReplyUrl;
		var msgtype = this.arrdata[2];
		doSelect = this.doSelect;
		this.form = Ext.create('Ext.form.Panel',{
				labelAlign: 'right',
				labelWidth: 40,
				autoWidth: true,
				autoScroll:true,
				frame: true,
				items: [{
					layout: 'column',
					items:[{
						columnWidth:.2,
						layout: 'form',
						items:[{
							xtype:'label',
							id:'buyerid',
							height:50,
							fieldLabel: 'Buyerid',
							html:''
						}]},{
						columnWidth:.4,
						layout: 'form',
						items:[{
						xtype:'label',
						id:'title',
						fieldLabel: 'Title',
						html:''
						}]},{
						columnWidth:.2,
						layout: 'form',
						items:[{
								xtype:'combo',
								fieldLabel: '分类',
								width:80,
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: msgtype
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'msg_type',
								id: 'msg_type',
								listeners: {
									change:function(field,e){
										var mid= getid();
										if(!mid) {Ext.example.msg('ERROR','请先选择一条message记录进行更改');return false;}
										Ext.getBody().mask("正在更改message分类.请稍等...","x-mask-loading");
										Ext.Ajax.request({
										   url: 'index.php?model=message&action=changetype&msg_type='+field.getValue()+'&mid='+mid,
										   loadMask:true,
											success:function(response,opts){
																Ext.getBody().unmask();
																var res = Ext.decode(response.responseText);
																if(res.success){
																Ext.example.msg('MSG',res.msg);
																store1.reload();
																}else{
																Ext.Msg.alert('ERROR',res.msg);
																}						
												}
											});									
									}
								}
						}]
						},{
						columnWidth:.15,
						layout: 'form',
						items:[{
							xtype:'label',
							id:'creatdate',
							fieldLabel: 'Date',
							html:''
						}]
						}
						]
					},{
						xtype:'combo',
						fieldLabel: '模板',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: temp
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'template',
						id: 'template',
						listeners: {
							change:function(field,e){
								Ext.getBody().mask("正在获取模板数据.请稍等...","x-mask-loading");
								Ext.Ajax.request({
								   url: 'index.php?model=template&action=getcontent&rec_id='+field.getValue()+'&mid='+getid(),
								   loadMask:true,
									success:function(response,opts){
										Ext.getBody().unmask();
											Ext.getCmp('answer').setValue(response.responseText);
										}
									});									
							}
						}
					},{
						layout: 'column',
						items:[{
							columnWidth:.7,
							layout: 'form',
							items:[{
								fieldLabel: 'Answer',
								id:'answer',
								width:500,
								height:140,
								xtype:'textarea'
								}]
							},{
							columnWidth:.3,
							layout: 'column',
							items:[{
								width:50,
								height:30,
								text:'Reply',
								xtype:'button',
								listeners: {
									click:function(){
										var mid = getid();
										if(!mid){
												Ext.example.msg('请先选中需要回复的message');
												return false;
												};
										 var answervalue = Ext.getCmp('answer').getValue();
										 if(answervalue == ''){
												Ext.example.msg('回复内容不能为空');
												return false;
												};
													Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
													Ext.Ajax.request({
													   url: 'index.php?model=message&action=replyanswer',
													   loadMask:true,
													   params: { value:answervalue,id:mid },
														success:function(response,opts){
															var res = Ext.decode(response.responseText);
															Ext.getBody().unmask();
																if(res.success){
																Ext.example.msg('MSG',res.msg);
																store1.reload();
																}else{
																Ext.Msg.alert('ERROR',res.msg);
																}						
															}
														});
										}
									}
								},{
								id:'look_history_record',
								width:50,
								height:30,
								text:'查看历史记录',
								disabled: true,
								style:'margin-left:5px',
								xtype:'button',
								listeners:{
									click:function(){
										var data=store1.getById(getid());
										lookReplyUrl=lookReplyUrl+'&info_SenderID='+data.data.SenderID+'&info_itemid='+data.data.itemid+'&info_id='+data.data.id;
										parent.openWindow('msg_history','历史记录',lookReplyUrl,840,600);
										}
									}
								}]
							}
						]
					},{
								fieldLabel: 'NOTE',
								id:'note',
								width:500,
								xtype:'textfield',
									listeners: {
										change:function(field,e){
											if(!getid()) return;
												modifymodel(getid(),field.getId(),field.getValue(),'message');
											}
										}
					},{
						xtype:'label',
						id:'messagebody',
						fieldLabel: 'Message',
						html:''
					}]			
			});
	},
	creatordergrid:function(){
		var sm = new Ext.grid.RowSelectionModel({
		singleSelect:true,									 
		listeners:{
			select:{
				fn:function(e,rowindex,record){
						var tpl = new Ext.Template(
							'<div style="padding-left:10px"><p>{consignee}</p>',
							'<p>{street1} {street2}</p>',
							'<p>{city}</p>',
							'<p>{state}</p>',
							'<p>{zipcode}</p>',
							'<p>{country}</p>',
							'<p>{tel}</p></div>'
						);
						tpl.overwrite(Ext.getCmp("order_addr_panel_id").body, {});
						tpl.overwrite(Ext.getCmp("order_addr_panel_id").body, record.data);
					}
				}
			}								 
		});
		
		this.ordergrid = Ext.create('Ext.grid.Panel',{
			loadMask:true,
			id:'orderGird',
			frame:false,
			autoWidth:true,
			autoHeight:true,
			region:'center',
			store: this.orderstore,
			selModel:sm,
			columns: [{header:'订单号',dataIndex:'order_sn'},{header:'状态',dataIndex:'order_status',width:50},{header:'发货时间',dataIndex:'end_time',width:60},{header:'单号',dataIndex:'track_no'}]
   		 });
	},
	creatitems:function(){
		return this.items = [this.tree,this.grid,{
							 region:'south',
							 layout:'column',
							 collapsed:false,
							 height:315,
							 autoScroll:true,
							 collapsible: true,
							 items:[{
								 	title:'message详情',
								 	columnWidth:.65,
							 		items:[this.form]
									},{
									title:'关联订单',
									columnWidth:.35,	
									items:[this.ordergrid,{xtype:'panel',id:'order_addr_panel_id',html:'',border:false}]
									}]
							 }];	
	},

	getKeytype:function(){
			if(!this.keytype) this.keytype = [['0','未回复'],['1','已回复'],['3',' 无需回复'],['2','所有状态']];
			return this.keytype;
	}
});

