Ext.ux.MailView = Ext.extend(Ext.Viewport, {
	initComponent: function() {
        this.layout = 'border';
		this.selectid = '';
		this.createForm();
		this.creatselectionmodel();
		this.getTab();
		this.createStore();
		this.creatgrid();
		this.creatitems();
        Ext.ux.MailView.superclass.initComponent.call(this);
    },

    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		remoteSort:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
		this.store.load({
			params:{start:0,limit:this.pagesize,keyword:'',starttime:'',key:''},
			scope:this.store
			});
		this.store.on('beforeload',function(){
			var values = Ext.getCmp('searchform').getForm().getFieldValues();
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value
			});
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
		var cm = this.creatcolumns();
		var bbar = this.creatBbar();
		var tbar = this.creatTbar();
		this.grid = new Ext.grid.GridPanel({
			loadMask:true,
			//frame:true,
			//border:false,
			height: 400,
			viewConfig:{
            	forceFit: true
        		},
			region:'center',
			store: this.store,
			cm: cm,
			sm:this.sm,
			tbar:tbar,
			bbar:bbar
   		 });
	},

	creatselectionmodel:function(){
		var setid = this.setid;
		doSelect = this.doSelect;
		var tab = this.getTab();
			var sm = new Ext.grid.CheckboxSelectionModel({
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									setid(record.data);
									doSelect(record.data);
									}
								}
							}								 
						});
			this.sm = sm;
	},

	doSelect:function(info){
		if(info.email_msg_id!=undefined){
			Ext.ux.MailView.getMailDetail(info.email_msg_id);
			Ext.ux.MailView.getOutBox(info.email_msg_id);
			Ext.getCmp("mail_reply_form_id").getForm().findField('email_msg_id').setValue(info.email_msg_id);
		}
	},

	creatcolumns:function(){
		var ds = this.store;
		var sm = this.sm;
		var cols =[{
				   header:'回复状态',
				   width:58,
				   sortable:false,
				   dataIndex : 'is_reply',
				   renderer:Ext.ux.MailView.deal_bool_fld
				   },{
				   header:'发件人',
				   width:220,
				   sortable:true,
				   dataIndex : 'fromName'
				   },{
				   id:'subject_id',
				   header:'主题',
				   width:500,
				   dataIndex : 'subject'
				   },{
				   header:'时间',
				   sortable:true,
				   dataIndex : 'date',
				   renderer:function(value){return Ext.util.Format.date(value,'Y-m-d');}
				   },{
				  header:'操作',
				  width:45,
				  xtype: 'actioncolumn',
				  items:[
						 {
							icon   : 'themes/default/images/delete.gif',	 
							tooltip: '删除',
							handler: function(grid, rowIndex, colIndex) {
								var row = ds.getAt(rowIndex);
								var id = row.get('uid');
								Ext.MessageBox.confirm('提示','确定要删除吗？',
									function(btn){
										if (btn == 'yes'){
											Ext.ux.MailView.del_mail(id,ds);
										}
									}
								);
							}
						 },'-',
						 {
							icon   : 'themes/default/images/drop-add.gif',	 
							tooltip: '回复',
							handler: function(grid, rowIndex, colIndex) {
								var row = ds.getAt(rowIndex);
								var id = row.get('email_msg_id');
								if(row.get('is_value')==0)
								Ext.ux.MailView.del_mail(id,0,'v',ds);
							}
						 }
						 ]
				  }];
		return new Ext.grid.ColumnModel(cols);
	},

    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		var step = this.step;
		return new Ext.Toolbar({
			items:['<b>邮件_列表</b>',
				   '->',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								store.load({params:{start:0, limit:pagesize,
									keyword:Ext.fly('keyword').dom.value
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
					}
				]			   				   
		});	
	},
	
	creatBbar: function() {
		var	pagesize = this.pagesize;
       return new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    },
	updatestatus:function(ispass){
		var ids = getIds(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
		
		Ext.Ajax.request({
			url:'index.php?model=order&action=updatestatus',
					success:function(response){
						Ext.example.msg('提示',response.responseText);
						thiz.reload();
						Ext.getBody().unmask();
						},
					failure:function(response){
						Ext.example.msg('警告','订单流程审核失败');
						Ext.getBody().unmask();
						},
			params:{id:ids,ispass:ispass}			 
		});
	},
	creatTab:function(){
		var store = this.store;
		var getid = this.getid;
		doSelect = this.doSelect;
		
		var mail_reply_form =new  Ext.FormPanel({
			labelWidth: 30,
			url:'index.php?model=message&action=reply',
			frame:false,
			id:'mail_reply_form_id',
			bodyStyle:'padding:5 5 5 5;',
			border:false,
			defaultType: 'textfield',
			defaults:{
			width:'80%'
			},
			items: [{
					name: 'email_msg_id',
					readOnly  : true,
					style:'border:none;background:none;display:none',
					value: '0'
				},{
					fieldLabel: '主题',
					name: 'subject'
				},
				{
					fieldLabel: '内容',
					xtype:'htmleditor',
					height:120,
					id:'content',
					name: 'body'
				},{
					xtype:'button',
					width:30,
					style:'margin-top:5px;margin-left:400px',
					text: '回复',
					handler: function() {
						if(mail_reply_form.getForm().findField('email_msg_id').getValue()!='0'){
							if(mail_reply_form.getForm().isValid()){
								mail_reply_form.getForm().submit({
									success:function(form,action){
										if(action.result.success==true){
											  Ext.example.msg('提示','添加一条跟踪记录成功');
										 }
										 mail_reply_form.getForm().reset();
									}
								});						
							}
						}else
						Ext.example.msg('错误','请先选择一条订单记录');
				   }
				}
			]
		});//end_form
		
		var outboxPanel = new Ext.Panel({
			border:false,
			height: 140,
			autoScroll:true,
			id:'outboxPanel_id',
			style:"background-color:#999900",
			padding:'5',
			autoScroll:true,
			html:''
		})		
	
		var mailRightCt = new Ext.Container({
			defaults: {
				style: {
					padding: '0',
					margin:'0'
				}
			},
			items: [mail_reply_form,outboxPanel]
		});	
		
		var mailDetailPanel = new Ext.Panel({
			border:false,
			height: 290,
			id:'mail_detail_panel',
			padding:'5',
			autoScroll:true,
			html:''
		})		
		
		var mailShowCt = new Ext.Container({
			layout: 'column',
			defaults: {
				columnWidth: 0.5,
				style: {
					padding: '0',
					margin:'0'
				}
			},
			items: [mailDetailPanel,mailRightCt]
		});		
		return mailShowCt;
	},
	
	getTab:function(){
        if (!this.tab) {
            this.tab = this.creatTab();
        }
        return this.tab;
	},
	creatitems:function(){
		return this.items = [this.grid,{
							 region:'south',
							 height:350,
							 border:false,
							 layout:'fit',
							 collapsed:false,
							 collapsible: true,
							 defaults:{border:false},
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
			if(!this.keytype) this.keytype = [['0','All Fields'],['1','Order SN'],['2','Country'],['3','Buyerid'],['4','Buyer Name'],['5','Email'],['6','paypalID'],['7','Tracking No'],['8','SKU'],['9','itemNO'],['10','Phone'],['11','Sales Record']];
			return this.keytype;
		},

    createForm: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var keytype = this.getKeytype();
		var shipping = this.shippingdata;
		var account = this.accountdata;
		var status = this.statusdata;
		var salechannel = this.salesCnldata;
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
			id:'searchform',
            trackResetOnLoad: true,
            items: [{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: [['1','Paid time'],['2','Shipping time']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'timetype',
						fieldLabel: '时间类型',
						name: 'timetype',
						value:1
					},{
						xtype:'datefield',
						name:'starttime',
						format:'Y-m-d',
						fieldLabel:'From'
					},{
						xtype:'datefield',
						name:'totime',
						format:'Y-m-d',
						fieldLabel:'To'
					},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: keytype
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'keytype',
						fieldLabel: '搜索字段',
						name: 'keytype',
						value:0
					},{
						name:'keywords',
						fieldLabel: '关键词',
						value:'',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								Ext.fly('keyword').dom.value = '';
								var values = Ext.getCmp('searchform').getForm().getFieldValues();
									store.load({params:{start:0, limit:pagesize,
												keyword:Ext.fly('keyword').dom.value,
												starttime:values.starttime,
												totime:values.totime,
												keytype:values.keytype,
												timetype:values.timetype,
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
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: shipping
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'shipping',
						fieldLabel: '发货方式',
						name: 'shipping',
						value:0
					},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: account
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'account',
						fieldLabel: '选择账户',
						name: 'account',
						value:0
					},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: status
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'status',
						fieldLabel: '订单状态',
						name: 'status',
						value:0
					},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: salechannel
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'salechannel',
						fieldLabel: '销售渠道',
						name: 'salechannel',
						value:0
					}],
            buttons: [{
                text: 'submit',
				handler:function(){
						Ext.fly('keyword').dom.value = '';
						var values = Ext.getCmp('searchform').getForm().getFieldValues();
							store.load({params:{start:0, limit:pagesize,
										keyword:Ext.fly('keyword').dom.value,
										starttime:values.starttime,
										totime:values.totime,
										keytype:values.keytype,
										timetype:values.timetype,
										shipping:values.shipping,
										account:values.account,
										status:values.status,
										salechannel:values.salechannel,
										key:values.keywords					
										}});
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

        var win = new Ext.Window({
			id:'searchwin',
            title: this.windowTitle,
            closeAction: 'hide',
			width:this.windowWidth,
			height:this.windowHeight,
            modal: true,
            items: [
                formPanel
            ]
        });
        return win;
    }
});

Ext.ux.MailView.del_mail=function(id,yds){
	Ext.Ajax.request({
		url: 'index.php?model=message&action=delmail&uid='+id,
		success: function(response){
			var result =Ext.decode(response.responseText);
			if(result.success==true){
				  yds.reload();
				  Ext.example.msg('提示',result.msg);
			 }
			if(result.success==false){
				  Ext.example.msg('提示',result.msg);
			 }
		}
	});
}
Ext.ux.MailView.deal_bool_fld=function(value, metaData, record){
	return ['<span style="color:red">未回复</span>','已回复'][value];
}
Ext.ux.MailView.getMailDetail=function(val){
	Ext.ux.MailView.noteTpl = new Ext.XTemplate(
		'<div style="margin-right:30px">',
		'<div style="background-color:#F7EEE5;border:#F1E4D7 1px solid">',
		'<div><span class="mail_item2">&nbsp;&nbsp;主&nbsp;&nbsp;&nbsp;题： </span><span class="mail_item">{subject}</span></div>',
		'<div><span class="mail_item2">&nbsp;&nbsp;发件人： </span>{fromName}&lt;{from}&gt;</div>',
		'<div><span class="mail_item2">&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;间：</span>{date}</div>',
		'<div><span class="mail_item2">&nbsp;&nbsp;收件人：</span>{to}</div>',
		'</div>',
		'<div style="padding:20px;">{body}</div>',
		'<tpl if="attaches.length > 0">',
		'<div style="margin:12px 0;background-color:#E9D5C1;border:#F1E4D7 1px solid">&nbsp;&nbsp;<span class="mail_item2">附件：</span></div>',
		'<tpl for="attaches">',
		'<div>{path} [<a href="index.php?model=message&action=getmailattach&path={parent.uid}&name={path}" target="_blank" style="color: #666666">下载</a>]</div>',
		'</tpl>',
		'</tpl>',
		'</div>'
	);			
	Ext.Ajax.request({
		url: 'index.php?model=message&action=getmaildetail&id='+val,
		success: function(response){
			var result = Ext.decode(response.responseText);
			Ext.ux.MailView.noteTpl.overwrite(Ext.getCmp("mail_detail_panel").body,result);
		}
	});
}
Ext.ux.MailView.getOutBox=function(val){
	Ext.ux.MailView.noteTpl2 = new Ext.XTemplate(
		'<div style="margin-left:34px;margin-bottom:10px">',
		'<tpl for=".">',
		'<div>{manage_user}于{addtime},回复:{subject}<br/>{body}</div>',
		'</tpl>',
		'</div>'
	);			
	Ext.Ajax.request({
		url: 'index.php?model=message&action=getoutbox&id='+val,
		success: function(response){
			var result = Ext.decode(response.responseText);
			Ext.ux.MailView.noteTpl2.overwrite(Ext.getCmp("outboxPanel_id").body,result);
		}
	});
	
}