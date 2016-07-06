Ext.ux.GoodsView = Ext.extend(Ext.Viewport, {
	initComponent: function() {
        this.layout = 'border';
		this.selectid = {};
		this.creatselectionmodel();
		this.getTab();
		this.createColumns();
		this.createStore();
		this.creatTree();
		this.creatgrid();
		this.creatitems();
		this.createForm();
        Ext.ux.GoodsView.superclass.initComponent.call(this);
    },

    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		remoteSort:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},['goods_id','goods_name','sku','brand_id','cat_id','status','img_status','des_status','goods_img','goods_url','weight','goods_title','goods_attribute','resume','depict','comment','price','add_user','add_time','sizes','colors','l','w','h','suttle','type','assign_status','user_id','times','des_id'])
    	});
		this.store.load({
			params:{start:0,limit:this.pagesize,action_type:this.action_type},
			scope:this.store
			});
		this.store.on('beforeload',function(){
			var values = Ext.getCmp('searchform').getForm().getFieldValues();
			Ext.apply(
			this.baseParams,
			{
			sku:Ext.fly('sku').dom.value,
			goods_name:Ext.fly('goods_name').dom.value,
			action_type:values.action_type,
			starttime:values.starttime,
			totime:values.totime,
			brand_id:values.brand_id,
			cat_id:values.cat_id,
			status:values.status
			});
		});
    },
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
	creatTree:function(){
		var store = this.store;
		var Tree = Ext.tree;
		var pagesize = this.pagesize;
		var root = new Tree.AsyncTreeNode({
			text: '总类',
			draggable:false,
			id:'root'
		});
		var tree = new Tree.TreePanel({
			border:true,
			root:root,
			region:'west',
			id:'west-panel',
			width: 200,
			minSize: 175,
			maxSize: 400,
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
				store.load({
					params:{start:0,cat_id:node.id,limit:pagesize},
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
		this.grid = new Ext.grid.GridPanel({
			loadMask:true,
			frame:true,
			height: 500,
			id:'goodsgrid',
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
		 this.grid.on('rowdblclick', this.onRowDblClick, this);
	},
    onRowDblClick: function(grid, rowIndex, e) {
		var id = this.store.getAt(rowIndex).get('goods_id');
		var type = this.store.getAt(rowIndex).get('type');
		switch(parseInt(this.action_type)){
			case 0:
				parent.openWindow(id,'编辑产品','index.php?model=newProduct&action=addProduct&goods_id='+id,1000,450);
				break;
			case 1:case 3: case 5: case 6:
				parent.openWindow(id,'审核产品','index.php?model=newProduct&action=showProduct&goods_id='+id+'&type='+type+'&action_type='+this.action_type,1000,600);
				break;
			case 2:case 4:
				parent.openWindow(id,'编辑产品','index.php?model=newProduct&action=editProduct&goods_id='+id+'&type='+type+'&action_type='+this.action_type,1000,600);
				break;
			default:
				return;
		}
		
    },
	creatselectionmodel:function(){
		var setid = this.setid;
		doSelect = this.doSelect;
		var tab = this.getTab();
		var sm = new Ext.grid.CheckboxSelectionModel({
					checkOnly:true,
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
			var tpl1 = new Ext.Template(
				'<div style="width:300px;float:left;"><p>产品名称: {goods_name}</p>',
				'<p>SKU: {sku}</p>',
				'<p>URL: <a target="_blank" href="{goods_url}">{goods_url}</a></p>',
				'<p>价格: {price}</p>',
				'<p>长: {l}&nbsp;&nbsp;宽:&nbsp;&nbsp;{w}&nbsp;&nbsp;高: {h}</p>',
				'<p>净重: {suttle}&nbsp;&nbsp;毛重: {weight}</p>',
				'<p>颜色: {colors}</p>',
				'<p>尺码: {sizes}</p>',
				'<p>备注: {comment}</p>',
				'</div>',
				'<div style="float:left;"><a href ="{goods_img}" target="_blank"> <img src="{goods_img}" width=270></a></p></div>'
			);
			 var tpl2 = new Ext.Template(
			 	'<p>产品名称: {goods_name}</p>',
				'<p>产品标题: {goods_title}</p>',
				'<p>产品属性: {goods_attribute}</p>',
				'<p>产品简述: {resume}</p>',
				'<p>产品描述: {depict}</p>',
				'<p>&nbsp;&nbsp;备&nbsp;注&nbsp;&nbsp;: {comment}</p>'
			);
			switch(id){
				case 'tab1':
					tpl1.overwrite(Ext.getCmp("tab1").body, info);
					Ext.getCmp("tab1").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab2':
					tpl2.overwrite(Ext.getCmp("tab2").body, info);
					Ext.getCmp("tab2").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab3':
					Ext.getCmp('tab3_item').getStore().load({params:{goods_id:info.goods_id}});
				break;
				case 'tab4':
					Ext.getCmp('tab4_item').getStore().load({params:{goods_id:info.goods_id}});
				break;
			}
	},
	
	creatcolumns:function(){
		var ds = this.store;
		var handleItem=[];
		var action_type=this.action_type;
		switch(action_type){
			case 0:
				handleItem=[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑产品',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('goods_id');
							parent.openWindow(id,'编辑产品','index.php?model=newProduct&action=addProduct&goods_id='+id,1000,400);
							}
						},{
						icon   : 'themes/default/images/delete.gif',	 
						tooltip: '删除产品',
						handler: function(grid, rowIndex, colIndex) {
							Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                				if (btn == 'yes') {
									var id = ds.getAt(rowIndex).get('goods_id');
									Ext.Ajax.request({
									   url: 'index.php?model=newProduct&action=delete&goods_id='+id,
										success:function(response,opts){
											var res = Ext.decode(response.responseText);
												if(res.success){
												ds.reload();
												Ext.example.msg('MSG',res.msg);
												}else{
												Ext.Msg.alert('ERROR',res.msg);
												}						
											}
										});
								}
							},this)
						}
						 }];
				break;
			case 2:case 4:
				handleItem=[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑产品',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('goods_id');
							var type = ds.getAt(rowIndex).get('type');
							parent.openWindow(id,'编辑产品','index.php?model=newProduct&action=editProduct&goods_id='+id+'&type='+type+'&action_type='+action_type,1000,600);
						}
						}];
				break;
			default:
				break;
		}
		var cols =[this.sm,{header:'sku',
				   width:50,
				   dataIndex : 'sku'
				   },{header:'产品名称',
				   width:100,
				   dataIndex : 'goods_name'
				   },{header:'品牌',
				   width:50,
				   dataIndex : 'brand_id'
				   },{
				   header:'所属分类',
				   dataIndex : 'cat_id',
				   width:50
				   }];
		var action_type=parseInt(this.action_type);
		if(action_type==8){
				 cols.push({
				   header:'任务分配',
				   dataIndex : 'assign_status',
				   width:50});
		}
		if(action_type==4 || action_type==5){
				 cols.push({
				   header:'任务',
				   dataIndex : 'type',
				   width:50
				   });
			}
		switch(action_type){
			case 2: case 3:
				 cols.push({
				   header:'图片状态',
				   dataIndex : 'img_status',
				   width:50
				   });
				  break;
			case 4: case 5:
				 cols.push({
				   header:'描述状态',
				   dataIndex : 'des_status',
				   width:50
				   });
				  break;
			
			case 7: case 8:
				 cols.push({
				   header:'产品状态',
				   dataIndex : 'status',
				   width:50
				   },{
				   header:'图片状态',
				   dataIndex : 'img_status',
				   width:50
				   },{
				   header:'描述状态',
				   dataIndex : 'des_status',
				   width:50
				   });
				  break;
			default:
				cols.push({
				   header:'产品状态',
				   dataIndex : 'status',
				   width:50
				   });
				break;
			}
			
			if(action_type==4 || action_type==5 || action_type==2 || action_type==3){
				cols.push({
					   header:'操作人员',
					   dataIndex : 'user_id',
					   width:50
					   },{
					   header:'操作时间',
					   dataIndex : 'times',
					   width:50
					   },{
					  header:'操作',
					  width:45,
					  xtype: 'actioncolumn',
					  items:handleItem
					  });
				
			}else{
				cols.push({
					   header:'录入人',
					   dataIndex : 'add_user',
					   width:50
					   },{
					   header:'录入时间',
					   dataIndex : 'add_time',
					   width:50
					   },{
					  header:'操作',
					  width:45,
					  xtype: 'actioncolumn',
					  items:handleItem
					  });
			}
		return new Ext.grid.ColumnModel(cols);
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
			items:['<b>产品列表</b>',
				   '->','sku:',{
						xtype:'textfield',
						width:80,
						id:'sku',
					    name:'sku',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								store.load({params:{start:0, limit:pagesize,
									action_type:this.action_type,
									sku:Ext.fly('sku').dom.value,
									goods_name:Ext.fly('goods_name').dom.value
									}});
								}
							}
						}
					},'-','产品名称:',{
						xtype:'textfield',
						id:'goods_name',
					    name:'goods_name',
						enableKeyEvents:true,
						width:80,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								store.load({params:{start:0, limit:pagesize,
									action_type:this.action_type,
									sku:Ext.fly('sku').dom.value,
									goods_name:Ext.fly('goods_name').dom.value
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
								action_type:this.action_type,
								sku:Ext.fly('sku').dom.value,
								goods_name:Ext.fly('goods_name').dom.value
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
							window.open().location.href='index.php?model=newProduct&action=exportGoods&sku='+Ext.fly('sku').dom.value+'&goods_name='+Ext.fly('goods_name').dom.value+'&action_type='+values.action_type+'&starttime='+values.starttime+'&totime='+values.totime+'&brand_id='+values.brand_id+'&cat_id='+values.cat_id+'&status='+values.status;
						}
					}]			   				   
		});	
	},
	
	creatBbar: function() {
		var items=new Array();
		var store=this.store;
		switch(this.action_type){
			case 1:case 3:case 5:
				items=['-',{
					   text:'审核',
					   pressed:true,
					   handler:this.showProduct.createDelegate(this,[this.action_type])
					   },'-',{
					   text:'审核通过',
					   pressed:true,
					   handler:this.getAudit.createDelegate(this,[this.action_type,0])
						},'-',{
					   text:'审核失败',
					   pressed:true,
					   handler:this.getAudit.createDelegate(this,[this.action_type,1])
					   }];
				break;
			case 6:
				items=['-',{
					   text:'审核',
					   pressed:true,
					   handler:this.showProduct.createDelegate(this,[this.action_type])
					   },'-',{
					   text:'审核通过',
					   pressed:true,
					   handler:this.getAudit.createDelegate(this,[this.action_type,0])
					   },'-','审核失败原因：',{xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: [[1,'信息'],[2,'图片'],[3,'描述']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:80,
						editable: false,
						forceSelection: true,
						allowBlank: true,
						emptyText:'选择',
						triggerAction: 'all',
						hiddenName:'error',
						id: 'error'
					   },'-',{
					   text:'审核失败',
					   pressed:true,
					   handler:this.getAudit.createDelegate(this,[this.action_type,1])
					   }];
				break;
			case 0:case 2:case 4:
				items=['-',{
					   text:'提交审核',
					   pressed:true,
					   handler:this.getSubmitAudit.createDelegate(this,[this.action_type])
					   }];
				break;
			default:
				break;
		}
		if(this.action_type==8){
			items.push('-','分配任务：',{xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: this.tasks
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:120,
						editable: false,
						forceSelection: true,
						allowBlank: true,
						emptyText:'选择',
						triggerAction: 'all',
						value:0,
						hiddenName:'task',
						id: 'task'
					},' 给：',{xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: this.users
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						allowBlank: true,
						emptyText:'选择',
						triggerAction: 'all',
						hiddenName:'user',
						id: 'user'
					},'-',{
					   text:'分配',
					   pressed:true,
					   handler:this.getAssign.createDelegate(this,[this.action_type])
					 },'-',{
					   text:'重新分配任务',
					   pressed:true,
					   handler:this.getReAssign.createDelegate(this,[this.action_type])
					   });
		}
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
		doSelect = this.doSelect;
		var tab3store = new Ext.data.Store({
			url : 'index.php?model=newProduct&action=imglist',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','img_assign','url','add_user','add_time'])
			});
		var tab3_item = new Ext.grid.GridPanel({
				id:'tab3_item',
				store:tab3store,
				width:1000,
				height:300,
				autoScroll :true,
				columns: [{header:'产品图片',dataIndex:'url',width:120,renderer:function(v){return'<img src='+v+' width=100 height=100>';}},
			{header:'图片类型',dataIndex:'img_assign'},
			{header:'图片地址',dataIndex:'url',width:400,renderer:function(v){return'<a target="_blank" href="'+v+'">'+v+'</a>';}},
			{header:'操作员',dataIndex:'add_user'},
			{header:'更新时间',dataIndex:'add_time'}]											  
			});
		var tab4store = new Ext.data.Store({
			url : 'index.php?model=newProduct&action=assignlist',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'assign_id'
			}, ['assign_id','user_id','user_name','type','add_user','add_time'])
			});
		var deleteAssign=[];
		var action_type=this.action_type;
		if(action_type==8){
			 deleteAssign=[{
					icon   : 'themes/default/images/delete.gif',	 
					tooltip: '删除产品',
					handler: function(grid, rowIndex, colIndex) {
						Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
							if (btn == 'yes') {
								var id = tab4store.getAt(rowIndex).get('assign_id');
								Ext.Ajax.request({
								   url: 'index.php?model=newProduct&action=deleteAssign&assign_id='+id,
									success:function(response,opts){
										var res = Ext.decode(response.responseText);
											if(res.success){
											tab4store.reload();
											Ext.example.msg('MSG',res.msg);
											}else{
											Ext.Msg.alert('ERROR',res.msg);
											}						
										}
									});
							}
						},this)
					}}];
			}
		var tab4_item = new Ext.grid.GridPanel({
				id:'tab4_item',
				store:tab4store,
				width:1000,
				height:300,
				autoScroll :true,
				columns: [{header:'任务',dataIndex:'type'},
			{header:'任务人',dataIndex:'user_name'},
			{header:'分配人',dataIndex:'add_user'},
			{header:'分配时间',dataIndex:'add_time'},
			{header:'操作', width:45,xtype: 'actioncolumn',items:deleteAssign}]											  
			});
		//将任务分配显示在所有产品列表和任务分配列表中
		var items=[{
			    id:'tab1',
                title: '基本信息',
				listeners: {activate: function(){
						doSelect('tab1',getid(),action);
					},
                html: ''
				}
            },{
			    id:'tab2',
                title: '高级信息',
				listeners: {activate: function(){
						doSelect('tab2',getid(),action);
					}
				},
				html: ''
			},{
				id:'tab4',
                title: '任务分配情况',
				listeners: {activate: function(){
						doSelect('tab4',getid(),action);
					}},
                items:[tab4_item]
			},{
				id:'tab3',
                title: '产品图片',
				listeners: {activate: function(){
						doSelect('tab3',getid(),action);
					}},
                items:[tab3_item]
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
		return this.items = [this.tree,this.grid,{
							 title:'产品详情',
							 region:'south',
							 height:250,
							 collapsed:false,
							 collapsible: true,
							 items:[this.tab]
							 }];	
	},
	createForm: function() {
		var afterselect = this.afterselect;
		var store = this.store;
		var pagesize = this.pagesize;
		var cat = this.arrdata[1];
		var brand = this.arrdata[2];
		var status = this.arrdata[0];
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
			id:'searchform',
            trackResetOnLoad: true,
            items: [{xtype:'hidden',id:'action_type',value:this.action_type},
					{
						xtype:'datefield',
						name:'starttime',
						format:'Y-m-d',
						fieldLabel:'From'
					},{
						xtype:'datefield',
						name:'totime',
						format:'Y-m-d',
						fieldLabel:'To'
					},new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'分类',
					xtype:'trigger',
					id:'cat_name',
					value:'All',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=goods&action=getcattree&com=1',0,afterselect);
					}
					}),{xtype:'hidden',id:'cat_id',value:0},{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: brand
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'brand_id',
						fieldLabel: '品牌',
						name: 'brand_id',
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
						fieldLabel: '产品状态',
						name: 'status',
						value:-1
					},new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'分类',
					xtype:'trigger',
					id:'cat_name',
					value:'All',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',0,afterselect);
					}
					}),{xtype:'hidden',id:'cat_id',value:0}],
            buttons: [{
                text: 'submit',
				handler:function(){
						var values = Ext.getCmp('searchform').getForm().getFieldValues();
							store.load({params:{start:0, limit:pagesize,
										action_type:values.action_type,
										sku:Ext.fly('sku').dom.value,
										goods_name:Ext.fly('goods_name').dom.value,
										starttime:values.starttime,
										totime:values.totime,
										brand_id:values.brand_id,
										cat_id:values.cat_id,
										status:values.status						
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
	getSubmitAudit:function(action_type) {
		var ids=selectid['goods_id'];
		var desIds=selectid['des_id'];
		var store = this.store;
		if(!desIds && action_type==4){
			Ext.example.msg('提示:','未添加描述不得进行提交!');
			return;
		}
		if(!ids){
			Ext.example.msg('提示:','请选择需要审核的产品!');
			return;
		}
		var store = this.store;
		Ext.Ajax.request({
			url:'index.php?model=newProduct&action=updateStatusList',
			params:{
				goods_id:selectid['goods_id'],
				type:selectid['type'],
				action_type:action_type
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				store.reload();
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','提交审核失败');
				Ext.getBody().unmask();
				}		 
		});
	},
	getAudit: function(action_type,audit_status){
		var store = this.store;
		var ids=selectid['goods_id'];
		if(!ids){
			Ext.example.msg('提示:','请选择需要审核的产品!');
			return;
		}
		if(action_type==6 && !Ext.getCmp('error').getValue()){
			Ext.example.msg('警告:','请选择审核失败原因！');
			return;
		}
		var status=audit_status;
		if(action_type==6 && status==1){
			status=Ext.getCmp('error').getValue();
		}
		
		Ext.Ajax.request({
			url:'index.php?model=newProduct&action=AuditGoods',
			params:{
				action_type:action_type,
				goods_id:ids,
				type:selectid['type'],
				audit_status:status
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				store.reload();
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','审核失败');
				Ext.getBody().unmask();
				}		 
		});
	},
	showProduct: function(action_type){
		 parent.openWindow(id,'审核产品','index.php?model=newProduct&action=showProduct&goods_id='+selectid['goods_id']+'&type='+selectid['type']+'&action_type='+action_type,1000,600);
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
	afterselect:function(k,v)
	{
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
	},
	getAssign: function(action_type){
		var ids=selectid['goods_id'];
		if(!ids){
			Ext.example.msg('提示:','请选择需要分配任务的产品!');
			return;
		}
		var user=Ext.getCmp('user').getValue();
		if(!user){
			Ext.example.msg('提示:','请选择被分配人!');
			return;
		}
		var store = this.store;
		Ext.Ajax.request({
			url:'index.php?model=newProduct&action=assign',
			params:{
				goods_id:ids,
				user:user,
				task:Ext.getCmp('task').getValue()
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				store.reload();
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','任务分配失败');
				Ext.getBody().unmask();
				}		 
		});
	},
	getReAssign: function(action_type){
		var ids=selectid['goods_id'];
		var store=this.store;
		if(!ids){
			Ext.example.msg('提示:','请选择需要分配任务的产品!');
			return;
		}
		var store = this.store;
		Ext.Ajax.request({
			url:'index.php?model=newProduct&action=reAssign',
			waitMsg:'正在提交产品任务',
			params:{
				goods_id:ids
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				store.reload();
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','任务分配失败');
				Ext.getBody().unmask();
				}		 
		});
	}
});

