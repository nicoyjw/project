Ext.ux.CustomerView = Ext.extend(Ext.Viewport, {
	initComponent: function() {
        this.layout = 'border';
		this.selectid = {};
		this.creatselectionmodel();
		this.getTab();
		this.createStore();
		this.creatColumns();
		this.creatgrid();
		this.creatitems();
		this.createForm();
        Ext.ux.CustomerView.superclass.initComponent.call(this);
    },

    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		remoteSort:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},['id','account','name','sign_time','contact','address','tel','zip','Email','skype','qq','comment','sale_user','pay_cycle','price','remain','status','last_pay_time','add_time','add_user','warn'])
    	});
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){
			var values = Ext.getCmp('searchform').getForm().getFieldValues();
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value,
				starttime:values.starttime,
				totime:values.totime,
				pay_cycles:values.pay_cycles,
				keytype:values.keytype,
				timetype:values.timetype,
				status:values.status,
				key:values.keywords
			});
		});
    },
	creatColumns:function(){
		var ds = this.store;
		var cols =[this.sm,{header:'企业账号',
				   width:100,
				   dataIndex : 'account'
				   },{header:'企业名称',
				   width:100,
				   dataIndex : 'name',
				   renderer:function(val,x,rec){
					   val=(rec.get('warn')==1)?('<font color=red>'+val+'</font>'):val;
					   var str=(rec.get('comment'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('comment')+'">':'';
					   return'<b>'+val+'</b>'+str;
					   }
				   },{header:'联系人',
				   width:80,
				   dataIndex : 'contact'
				   },{
				   header:'状态',
				   dataIndex : 'status',
				   width:80
				   },{
				   header:'电话',
				   dataIndex : 'tel',
				   width:100
				   },{
				   header:'签约时间',
				   dataIndex : 'sign_time',
				   width:100
				   },{
				   header:'付费周期',
				   dataIndex : 'pay_cycle',
				   width:80
				   },{
				   header:'资费',
				   dataIndex : 'price',
				   width:80
				   },{
				   header:'余额',
				   dataIndex : 'remain',
				   width:100
				   },{
				   header:'上次付费时间',
				   dataIndex : 'last_pay_time',
				   width:90
				   },{
				   header:'操作',
				   xtype: 'actioncolumn',
				   width:90,
				   items:[{
						icon   : 'themes/default/images/key.png',	 
						tooltip: '缴费',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('id');
							var name = ds.getAt(rowIndex).get('name');
							parent.openWindow(5678,name+'缴费','index.php?model=customer&action=payPage&id='+id,420,490);
						}
						},'-',{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑客户信息',
						handler: function(grid, rowIndex, colIndex) {
								var id = ds.getAt(rowIndex).get('id');
								var name = ds.getAt(rowIndex).get('name');
								parent.openWindow(6789,'编辑客户：'+name+'的信息','index.php?model=customer&action=add&id='+id,840,405);
							}
						},'-',{
						icon   : 'themes/default/images/del.gif',	 
						tooltip: '停用账户',
						handler: function(grid, rowIndex, colIndex) {
								var remain=ds.getAt(rowIndex).get('remain');
								var msgs='你确定需要停用该账户吗?';
								if(remain>0){
									msgs='当前账号还有余额,'+msgs;
								}
								Ext.Msg.show({title:'停用账户',msg:msgs,buttons:Ext.Msg.YESNO,icon:Ext.MessageBox.ERROR,fn:function(btn){
									if(btn=='yes'){
										Ext.getBody().mask("正在停用账户.请稍等...","x-mask-loading");
										var id=ds.getAt(rowIndex).get('id');
										Ext.Ajax.request({
											url:'index.php?model=customer&action=stop&id='+id,
											success:function(response,opts){
												var res=Ext.decode(response.responseText);
												Ext.getBody().unmask();
												if(res.success){
													ds.reload();
													Ext.example.msg('MSG',res.msg);
												}else{
													Ext.example.msg('ERROR',res.msg);
												}
											}
										});
									}
								}});
							}
						},'-',{
						icon   : 'themes/default/images/user.png',	 
						tooltip: '恢复账户',
						handler: function(grid, rowIndex, colIndex) {
								var id=ds.getAt(rowIndex).get('id');
								Ext.Ajax.request({
									url:'index.php?model=customer&action=start&id='+id,
									success:function(response,opts){
										var res=Ext.decode(response.responseText);
										Ext.getBody().unmask();
										if(res.success){
											ds.reload();
											Ext.example.msg('MSG',res.msg);
										}else{
											Ext.example.msg('ERROR',res.msg);
										}
									}
								});
							}
						}]}];
		return new Ext.grid.ColumnModel(cols);
	},
	creatgrid:function(){
		var cm = this.creatColumns();
		var bbar = this.creatBbar();
		var tbar = this.creatTbar();
		this.grid = new Ext.grid.GridPanel({
			loadMask:true,
			frame:true,
			height: 500,
			width:1000,
			id:'customergrid',
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
							doSelect(tab.getActiveTab().id,record.data);
							}
						}
					}								 
				});
		this.sm = sm;
	},

	doSelect:function(id,info){
		if(!info){
			if(id != 'tab1') Ext.example.msg('错误','请先选择一条产品记录');
			return false;
		}
		var tpl2 = new Ext.Template(
				'<div style="width:300px;float:left;"><p>公司账户: {account}</p>',
				'<p>公司名称: {name}</p>',
				'<p>联系人: {contact}</p>',
				'<p>电话: {tel}</p>',
				'<p>签约时间: {sign_time}</p>',
				'<p>销售人员: {sale_user}</p>',
				'<p>QQ: {qq}</p>',
				'<p>Email: {Email}</p>',
				'<p>skype: {skype}</p>',
				'<p>地址: {address}</p>',
				'<p>邮编: {zip}</p>',
				'<p>备注: {comment}</p></div>'
			);
		switch(id){
			case 'tab1':
				Ext.getCmp('tab1_item').getStore().load({params:{customer_id:info.id}});
			break;
			case 'tab2':
				tpl2.overwrite(Ext.getCmp("tab2").body, info);
				Ext.getCmp("tab2").body.highlight('#c3daf9', {block:true});
			break;
		}
	},
	setid:function(str){
			this.selectid = str;
	},
	
	getid:function(){
			return this.selectid;
	},
	
    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		return new Ext.Toolbar({
			items:['<b>客户信息列表</b>',
				   '->','模糊搜索:',{
						xtype:'textfield',
						width:80,
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								var values=Ext.getCmp('searchform').getForm().getFieldValues();
								store.load({params:{start:0,
										limit:pagesize,
										keyword:Ext.fly('keyword').dom.value,
										starttime:values.starttime,
										totime:values.totime,
										pay_cycles:values.pay_cycles,
										keytype:values.keytype,
										timetype:values.timetype,
										status:values.status,
										key:values.keywords
										
									}});
							}}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							var values=Ext.getCmp('searchform').getForm().getFieldValues();
							store.load({
								params:{start:0,
									limit:pagesize,
									keyword:Ext.fly('keyword').dom.value,
									starttime:values.starttime,
									totime:values.totime,
									pay_cycles:values.pay_cycles,
									keytype:values.keytype,
									timetype:values.timetype,
									status:values.status,
									key:values.keywords
								}});
							}
					},'-',{
						xtype:'button',
						text:'高级搜索',
						iconCls:'x-tbar-advsearch',
						handler:this.showWindow.createDelegate(this)
					},'-',{
						xtype:'button',
						text:'搜索结果导出',
						iconCls:'x-tbar-import',handler:function(){
							var values = Ext.getCmp('searchform').getForm().getFieldValues();
							window.open().location.href='index.php?model=customer&action=list&type=export&keyword='+Ext.fly('keyword').dom.value+'&starttime='+values.starttime+'&totime='+values.totime+'&keytype='+values.keytype+'&timetype='+values.timetype+'&pay_cycles='+values.pay_cycles+'&status='+values.status+'&key='+values.keywords;
						}
					}]			   				   
		});	
	},
	
	creatBbar: function() {
		var items=new Array();
		var store=this.store;
		var items=[{text:'发送邮件',pressed:true,handler:this.sendmessage.createDelegate(this)}];//bbar添加按钮位置
		var	pagesize = this.pagesize;
       	return new Ext.PagingToolbar({
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:items	   
        });
    },
	
	creatTab:function(){
		var store = this.store;
		var getid = this.getid;
		var action = this.action;
		var rendererlist = this.rendererlist;
		var payLoglistURL=this.payLoglistURL;
		doSelect = this.doSelect;
		var tab1store = new Ext.data.Store({
			url : payLoglistURL,
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'id'
			}, ['id','pay_sn','customer_id','payable','paid','remain','pay_type','pay_user','pay_time','add_user','comment'])
			});
		this.tab1store=tab1store;
		var tab1_item = new Ext.grid.GridPanel({
				id:'tab1_item',
				store:tab1store,
				height:200,
				autoWidth:true,
				autoScroll :true,
				columns: [
					new Ext.grid.RowNumberer(),
					{header:'付款编码',dataIndex:'pay_sn',width:120},
					{header:'应付金额',dataIndex:'payable'},
					{header:'支付金额',dataIndex:'paid',width:80, renderer:function(val,x,rec){var str=(rec.get('comment'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('comment')+'">':'';return'<b>'+val+'</b>'+str;}},
					{header:'支付方式',dataIndex:'pay_type'},
					{header:'支付时间',dataIndex:'pay_time'},
					{header:'付款人',dataIndex:'pay_user'},
					{header:'余额',dataIndex:'remain'},
					{header:'操作人',dataIndex:'add_user'}],
				tbar:['->',{text:'打印流水',iconCls:'x-tbar-print',handler:function(){
							window.open().location.href=payLoglistURL+'&type=print&customer_id='+selectid['id'];
						}},
					'-',{text:'导出流水',iconCls:'x-tbar-import',handler:function(){
							window.open().location.href=payLoglistURL+'&type=export&customer_id='+selectid['id'];
						}}]											  
			});
		//将任务分配显示在所有产品列表和任务分配列表中
		var items=[{
			    id:'tab1',
                title: '缴费流水',
				listeners: {activate: function(){
						doSelect('tab1',getid(),action);
					}
				},
				items:[tab1_item]
            },{
			    id:'tab2',
                title: '基本信息',
				listeners: {activate: function(){
						doSelect('tab2',getid(),action);
					}
				},
				html: ''
			}];
		var tab = new Ext.TabPanel({
        activeTab: 0,
		autoWidth:true,
		height:250,
		boxMaxHeight:250,
        plain:true,
        defaults:{autoScroll: true},
        items:items
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
							 title:'缴费详情',
							 region:'south',
							 height:250,
							 collapsed:false,
							 collapsible: true,
							 items:[this.tab]
							 }];	
	},
	createForm: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var status = this.arrdata[0];
		var keytype=this.keytype;
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
			id:'searchform',
            trackResetOnLoad: true,
            items: [{xtype:'combo',
					store:new Ext.data.SimpleStore({fields:["id","key_type"],data:[['1','签约时间'],['2','添加时间']]}),
					valueField:"id",
					displayField:"key_type",
					mode:'local',
					editable:false,
					forceSelection:true,
					triggerAction:'all',
					hiddenName:'timetype',
					fieldLabel:'时间类型',
					name:'timetype',
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
					},{xtype:'combo',
						store:new Ext.data.SimpleStore({fields:["id","key_type"],data:keytype}),
						valueField:"id",
						displayField:"key_type",
						mode:'local',
						editable:false,
						forceSelection:true,
						triggerAction:'all',
						hiddenName:'keytype',
						fieldLabel:'搜索字段',
						name:'keytype'
						},{name:'keywords',
						fieldLabel:'关键词',
						value:'',
						enableKeyEvents:true,
						listeners:{
							scope:this,
							keypress:function(field,e){
								if(e.getKey()==13){
									var values=Ext.getCmp('searchform').getForm().getFieldValues();
									store.load({
										params:{start:0,
											limit:pagesize,
											keyword:Ext.fly('keyword').dom.value,
											starttime:values.starttime,
											totime:values.totime,
											pay_cycles:values.pay_cycles,
											keytype:values.keytype,
											timetype:values.timetype,
											status:values.status,
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
							 data: status
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'status',
						fieldLabel: '状态',
						name: 'status',
						value:-1
					},{xtype:'combo',
					store:new Ext.data.SimpleStore({fields:["id","key_type"],data:[[1,'年'],[2,'季度'],[3,'月']]}),
					valueField:"id",
					displayField:"key_type",
					mode:'local',
					editable:false,
					forceSelection:true,
					triggerAction:'all',
					hiddenName:'pay_cycles',
					fieldLabel:'付费周期',
					name:'pay_cycles'
					}],
            buttons: [{
                text: 'submit',
				handler:function(){
						var values = Ext.getCmp('searchform').getForm().getFieldValues();
							store.load({params:{start:0,
											limit:pagesize,
											keyword:Ext.fly('keyword').dom.value,
											starttime:values.starttime,
											totime:values.totime,
											keytype:values.keytype,
											timetype:values.timetype,
											pay_cycles:values.pay_cycles,
											status:values.status,
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
    getForm: function() {
        return this.getFormPanel().getForm();
    },
    getFormPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
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
    },
	sendmessage: function() {
	}
});

