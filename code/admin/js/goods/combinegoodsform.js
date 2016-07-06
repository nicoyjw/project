Ext.define('Ext.ux.goodsForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = false,
		//this.fileUpload = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatselectstore();
		this.creatGridcm();
		this.txt_totQty = Ext.create('Ext.form.field.Text',{
			id : 'txt_totQty',
			anchor : '95%',
			allowBlank : true,
			value : 0,
			readOnly : true,
			fieldClass : 'textReadOnly'
		}),
		this.creatGoodsstore();
		this.creatGoodsgrid();
		this.getTab();
		this.creatItems();
		this.creatButtons();
		this.goodsGrid.getSelectionModel().on('selectionchange', function(sm){
			Ext.getCmp('removeBtn').setDisabled(!sm.hasSelection());
			Ext.getCmp('editBtn').setDisabled(!sm.hasSelection());
		});
        this.callParent(this);
    },
	creatGoodsstore:function(){//组合产品明细store
		this.model = Ext.define('CombineGood', {
			extend: 'Ext.data.Model',
			fields: [{name: 'rec_id'},{name: 'goods_sn'}, {name: 'goods_id'},{name: 'SKU'},{name: 'goods_name'},{name: 'goods_qty'}]
		});
		
		this.goodsstore = Ext.create('Ext.data.JsonStore',{
			fields:['rec_id','goods_id','goods_sn','SKU','goods_name','goods_qty'],
			pageSize:20,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			},
			listeners : {
				'load' : this.calculate.bind(this),
				'add' : this.calculate.bind(this),
				'remove' : this.calculate.bind(this),
				'update' : this.calculate.bind(this)
			}
		});
	},

	creatGridcm:function(){
		var thiz =this;
		this.cmlist = [{
			header : '产品编码<font color=red>*</font>',
			dataIndex:'goods_sn',
			flex:1,
			align : 'left',
			editor:{
				allowBlank:false,
				readOnly:true,
				hideLabel:true
			}
		}, {
			header:'产品名称<font color=red>*</font>',
			flex:1,
			dataIndex:'goods_name',
			align:'left',
			editor:{
				allowBlank:false,
				readOnly:true,
				hideLabel:true
			}
		}, {
			header:'产品数量<font color=red>*</font>',
			dataIndex:'goods_qty',
			flex:1,
			align:'right',
			editor:{
				xtype:'numberfield',
				allowBlank:false,
				hideTrigger:true,
				minValue:0,
				decimalPercision:4,
				style:'text-align:left'
			}
		}];
	},
	creatGoodsgrid:function(){//创建组合产品明细
		this.goodsGrid = Ext.create('Ext.grid.Panel',{
			id : "destPanel",
			title:'组合产品明细',
			height : 300,
			columns : this.cmlist,
			store : this.goodsstore,
			selModel: Ext.create('Ext.selection.RowModel',{mode: 'SINGLE'}),
			plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
		        clicksToEdit: 1
		    })],
			viewConfig : {
				stripeRows : true, // 让基数行和偶数行的颜色不一样
				forceFit : true
			},
			iconCls : 'icon-grid',
			tbar: [{
				xtype:'button',
				text:'新增产品',
				id: 'addBtn',
				iconCls: 'x-tbar-add',
				handler:this.createWindow.bind(this,['0'])
			},{
				xtype:'button',
				text:'编辑产品',
				id: 'editBtn',
				disabled:true,
				iconCls: 'x-tbar-update',
				handler:this.createWindow.bind(this,['1'])
			},{
				text: '删除',
				iconCls: 'x-tbar-del',
				id: 'removeBtn',
				handler: this.removeItem.bind(this),
				disabled:true
			}],
			bbar : [{
				cls : 'u-toolbar-b',
				items : ['合计:', '->', '数量:', this.txt_totQty]
			}]
		});
	},
	creatTab:function(){
		var goodsgrid = this.goodsGrid;
		var tab = Ext.create('Ext.tab.Panel',{
			activeTab: 0,
			defaults:{autoScroll: true,autoHeight:true},
			items:[{
				id:'tab1',
				title: '基本信息',
				height:600,
				margin:'10px 0px 0px 0px',
				items:[{
					layout:'column',
					items:[{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							fieldLabel: '产品编码',
							labelWidth: 80,
							width: 280,
							id:'goods_sn'
						},{
							fieldLabel: '产品名称',
							id:'goods_name',
							labelWidth: 80,
							width: 280,
							name:'goods_name',
							allowBlank:false
						},{
							xtype:'combo',
							labelWidth: 80,
							width: 280,
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: this.goods_data[0]
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'status',
							name: 'status',
							id:'status',
							fieldLabel: '产品状态'
						},{
							fieldLabel: '报关单简称',
							labelWidth: 80,
							width: 280,
							id:'dec_name',
							name:'dec_name',
						},{
							fieldLabel: '组合产品',
							labelWidth: 80,
							width: 280,
							xtype:'checkbox',
							id:'is_group',
							name:'is_group',
							checked:true,
							hidden : true
						},{
							fieldLabel: '产品ID',id:'goods_id',name:'goods_id',
							xtype:'hidden'
						}]
					},{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							fieldLabel: 'SKU',id:'SKU',
							labelWidth: 80,
							width: 280,
							name:'SKU'
						},{
							fieldLabel: '保质期',
							labelWidth: 80,
							width: 280,
							id:'keeptime',
							name:'keeptime',
							format:'Y-m-d',
							xtype:'datefield'
						},{
							fieldLabel: '报关名中文',
							labelWidth: 80,
							width: 280,
							id:'dec_name_cn',
							name:'dec_name_cn'
						},{
							fieldLabel: '申报价值',
							id:'Declared_value',
							name:'Declared_value',
							labelWidth: 80,
							width: 280,
							xtype:'numberfield',
							minValue:0,
							hideTrigger:true
						},{
							fieldLabel: '管理库存',
							labelWidth: 80,
							width: 280,
							xtype:'checkbox',
							id:'is_control',
							name:'is_control',
							checked:true,
							hidden:true
						},{
							fieldLabel: '有无子产品',
							labelWidth: 80,
							width: 280,
							xtype:'checkbox',
							id:'has_child',
							name:'has_child',
							checked:false,
							hidden : true
						}]
					},{
						columnWidth:.33,
						defaultType: 'textfield',
						items:[{
							xtype:'combo',
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: this.goods_data[1]
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							labelWidth: 80,
							width: 280,
							editable: false,
							forceSelection: true,
							value:'65535',
							triggerAction: 'all',
							hiddenName:'cat_id',
							name: 'cat_id',
							id:'cat_id',
							fieldLabel: '分类'
						},{
							fieldLabel: '产品链接',id:'goods_url',name:'goods_url',
							labelWidth: 80,
							width: 280
						},{
							fieldLabel: '产品图片',id:'goods_img',name:'goods_img',
							labelWidth: 80,
							width: 280
						},{
							fieldLabel: '重量',
							labelWidth: 80,
							width: 280,
							id:'weight',
							name:'weight',
							hidden : true
						}]
					}]
				},{
					fieldLabel: '备注',
					id:'comment',
					name:'comment',
					width:600,
					labelWidth: 80,
					height:30,
					xtype:'textarea',
					margin: '0px 0px 10px 0px'
				},this.goodsGrid]
			},{
				id:'tab2',
				title: '费用相关',
				autoScroll:true,
				defaultType: 'textfield',
				items: [{
					margin: '10px 0px 0px 0px',
					fieldLabel: '成本价',
					width:250,
					hideTrigger:true,
					name: 'cost',
					id:'cost',
					value:0,
					xtype:'numberfield'
				},{
					fieldLabel: '价格1',
					width:250,
					name: 'price1',
					id:'price1',
					hideTrigger:true,
					xtype:'numberfield'
				},{
					fieldLabel: '价格2',
					width:250,
					name: 'price2',
					id:'price2',
					hideTrigger:true,
					xtype:'numberfield'
				},{
					fieldLabel: '价格3',
					width:250,
					hideTrigger:true,
					name: 'price3',
					id:'price3',
					xtype:'numberfield'
				}]
			},{
				id:'tab3',
                title: '中国刊登',
				labelWidth:105,
				align:'left',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Price_cn',
					width:350,
                    name: 'price_cn',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_cn", 
					width:850,
					height:380, 
					id : "des_cn", 
					fieldLabel : "中文描述"
					})
				]
			},{
				id:'tab4',
                title: '美国刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_US',
					width:350,
                    name: 'Grade_us'
                },{
                    fieldLabel: 'Plan_US',
					width:350,
                    name: 'plan_us'
                },{
                    fieldLabel: 'Price_US',
					width:350,
                    name: 'price_us',
					hideTrigger:true,
					xtype: 'numberfield'
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_en", 
					width:850,
					height:380, 
					id : "des_en", 
					fieldLabel : "英文描述"
					})
				]
            },{
				id:'tab5',
                title: '澳大利亚刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_AU',
					width:350,
                    name: 'Grade_au'
                },{
                    fieldLabel: 'Price_AU',
					width:350,
                    name: 'price_au',
					hideTrigger:true,
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_AU',
					width:350,
                    name: 'plan_au'
                }]
            },{
				id:'tab6',
                title: '英国刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_UK',
					width:350,
                    name: 'Grade_uk',
					value:this.good
                },{
                    fieldLabel: 'Price_UK',
					width:350,
                    name: 'price_uk',
					hideTrigger:true,
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_UK',
					width:350,
                    name: 'plan_uk'
                }]
            },{
				id:'tab7',
                title: '德文刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_DE',
					width:350,
                    name: 'Grade_de'
                },{
                    fieldLabel: 'Plan_DE',
					width:350,
                    name: 'plan_de'
                },{
                    fieldLabel: 'Price_DE',
					width:350,
                    name: 'price_de',
					hideTrigger:true,
					xtype: 'numberfield'
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_de", 
					width:850,
					height:380, 
					id : "des_de", 
					fieldLabel : "德文描述"
					})
 				]
			},{
				id:'tab8',
                title: '法文刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_FR',
					width:350,
                    name: 'Grade_fr'
                },{
                    fieldLabel: 'Plan_FR',
					width:350,
                    name: 'plan_fr'
                },{
                    fieldLabel: 'Price_FR',
					width:350,
					hideTrigger:true,
                    name: 'price_fr',
					xtype: 'numberfield'
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_fr", 
					width:850,
					height:380, 
					id : "des_fr", 
					fieldLabel : "法文描述"
					})
				]
			},{
				id:'tab9',
                title: '西班牙文刊登',
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: 'Grade_SP',
					width:350,
                    name: 'Grade_sp'
                },{
                    fieldLabel: 'Plan_SP',
					width:350,
                    name: 'plan_sp'
                },{
                    fieldLabel: 'Price_SP',
					width:350,
                    name: 'price_sp',
					hideTrigger:true,
					xtype: 'numberfield'
                },Ext.create('Ext.ux.form.FCKeditor',{
					name : "des_sp", 
					width:850,
					height:380, 
					id : "des_sp", 
					fieldLabel : "西班牙文描述"
					})
				]
			}]
		});		
		return tab;
	},

	getTab:function(){
        if (!this.tab) {
            this.tab = this.creatTab();
        }
        return this.tab;
	},

	creatItems:function(){
		this.items = [this.tab];
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
		if(this.getForm().isValid()){
			if(Ext.getCmp('is_group').getValue() && this.txt_totQty.getValue() == 0){
				Ext.example.msg('错误提示','子产品数量不能为0');return;
			}
			var jsonArray = [];
			var thiz = this.goodsstore;
			var me = this;
			var m = this.goodsstore.getModifiedRecords().slice(0);
			Ext.each(m,function(item){
				//alert(item.data.goods_sn);
				jsonArray.push(item.data);				
			});
			Ext.Ajax.request({
			   url:'index.php?model=goods&action=save',
			   loadMask:true,
			   params: { 'data':Ext.encode(jsonArray),
			   'goods_sn':Ext.getCmp('goods_sn').getValue(),
			   'goods_name':Ext.getCmp('goods_name').getValue(),
			   'status':Ext.getCmp('status').getValue(),
			   'dec_name':Ext.getCmp('dec_name').getValue(),
			   'is_group':1,
			   'SKU':Ext.getCmp('SKU').getValue(),
			   'keeptime':Ext.getCmp('keeptime').getValue(),
			   'dec_name_cn':Ext.getCmp('dec_name_cn').getValue(),
			   'Declared_value':Ext.getCmp('Declared_value').getValue(),
			   'cat_id':65535,
			   'goods_url':Ext.getCmp('goods_url').getValue(),
			   'goods_img':Ext.getCmp('goods_img').getValue(),
			   'weight':Ext.getCmp('weight').getValue(),
			   'comment':Ext.getCmp('comment').getValue(),
			    'cost':Ext.getCmp('cost').getValue(),
			   'price1':Ext.getCmp('price1').getValue(),
			   'price2':Ext.getCmp('price2').getValue(),
			   'price3':Ext.getCmp('price3').getValue()
			   },
				success:function(response,opts){
					var res = Ext.decode(response.responseText);
					Ext.getBody().unmask();
						if(res.success){
						Ext.example.msg('MSG','新增产品成功');
						window.location.href = 'index.php?model=goods&action=editcombine&goods_id='+res.msg;
						}else{
						Ext.Msg.alert('ERROR',res.msg);
						}						
					}
				});		
			
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
		}
		
		
		
		
		
		
		/*if(this.getForm().isValid()){
			if(Ext.getCmp('is_group').getValue() && this.txt_totQty.getValue() == 0){
				Ext.example.msg('错误提示','子产品数量不能为0');return;
			}
			
			var jsonArray = [];
			var thiz = this.goodsstore;
			var me = this;
			var m = thiz.getModifiedRecords().slice(0);
			Ext.each(m,function(item){
				jsonArray.push(item.data);			
			});
			this.getForm().submit({
				url:'index.php?model=goods&action=save',
				waitMsg: '正在更新产品资料',
				params:{'data':Ext.encode(jsonArray)},
				method:'post',
				success:function(form,action){
					if (action.result.success) {
						Ext.example.msg('MSG','新增产品成功');
						window.location.href = 'index.php?model=goods&action=editcombine&goods_id='+action.result.msg;
					} else {
						Ext.Msg.alert('修改失败',action.result.msg);
					}
				},
				failure:function(){
					Ext.example.msg('操作','服务器出现错误请稍后再试！');
				}
			});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
		}*/
	},

	formreset:function(){//表单重置
		this.form.getForm().reset();
	},

	addItem:function(p){//新增物品
		this.goodsstore.insert(0, p);
		this.goodsGrid.plugins[0].startEditByPosition({row:0,column:0});
	},
	removeItem:function(){//移除组合物品
	    var submitstore = this.goodsstore;
		var data = this.goodsGrid.getSelectionModel().getSelection()[0];
		var index = submitstore.findBy(function(record,id){
			return record.get('goods_sn') == data.get('goods_sn');									
		});
		submitstore.remove(submitstore.getAt(index));
	},
	creatselectstore:function(){//订单明细store
		this.selectstore = Ext.create('Ext.data.Store', {
			fields:['goods_id','goods_sn','SKU','goods_name'],
			remoteSort:true,
			autoLoad:true,
			baseParams : {
				cat_id : ''
			},
			proxy: {
				type: 'ajax',
				url:this.goodsURL,
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'goods_id',
					root: 'topics'
				}
			}
		});
	},
    createWindow: function(num) {//弹出产品选择窗口
		var selectstore = this.selectstore;
		var thiz = this;
		var Tree = Ext.tree;
		var tree = Ext.create('Ext.tree.Panel',{
			border:true,
			id:'west-panel',
			margins:'0 0 0 0',
			title:'产品分类',
			region:'west',
			width: '35%',
			collapsible :true,
			layoutConfig:{
				animate:true
			},
			store:Ext.create('Ext.data.TreeStore', {
				autoLoad:true,
				proxy: {
					type: 'ajax',
					url: this.catTreeURL
				},
				root: {
					text: '总类',
					draggable:false,
					expanded:true,
					id:'root'
				}
			}),
			rootVisible:false,
			autoScroll:true
		});
		tree.on('itemclick',treeClick);
		function treeClick(view,node,item,index,e) {
			if(node.isLeaf()){
				e.stopEvent();
				//alert(node.id);
				selectstore.load({
					params:{start:0,cat_id:node.data.id,limit:20},
					scope:this.store
				});
			}
		};
		var grid = Ext.create('Ext.grid.Panel',{
			title: '产品列表',
			region:'center',
			store:this.selectstore,
			columns: [
				{header:'产品编码',dataIndex:'goods_sn',flex:1},
				{header:'SKU',dataIndex:'SKU',flex:1},
				{header:'产品名称',dataIndex:'goods_name',flex:1}
			],
			tbar:['<b>产品列表</b>',
			   '->','产品编码:',
			   {
					xtype:'textfield',
					name:'keyword',
					id:'keyword'
				},
				'-',{
					xtype:'button',
					text:'搜索',
					iconCls:'x-tbar-search',
					handler:function(){
						//console.log(store.getAt(0).get('order_id'))
						selectstore.load({params:{start:0, limit:20,
							keyword:Ext.getCmp('keyword').getValue(),
							cat_id:''
							}});
					}
				}
			],
			dockedItems:[{
				xtype: 'pagingtoolbar',
				pageSize: 20,
				displayInfo: true,
				displayMsg: '第{0} 到 {1} 条数据 共{2}条',
				emptyMsg: "没有数据",
				dock: 'bottom',
				store: this.selectstore
			}],
			viewConfig: {
				forceFit: true
			}
		});
		
        var win = Ext.create('Ext.window.Window',{
            title: '产品列表',
            closeAction: 'destroy',
			closable:true,
			width:600,
			height:600,
            layout:'border',
            modal: true,
            items: [tree,grid]
        });
		

		if(!this.goodsGrid) this.creatGoodsgrid();
		var goodsgrid = this.goodsGrid;
		grid.on('itemclick', function(grid,record,item, rowIndex, e) {
			var getinfo = selectstore.getAt(rowIndex);
			var p = Ext.create(this.model,{rec_id:0,goods_sn:getinfo.get('goods_sn'),goods_id:getinfo.get('goods_id'),goods_name:getinfo.get('goods_name'),goods_qty:0});
			if(num == 1) {
				var getSelect = goodsgrid.getSelectionModel().getSelection();
					getSelect[0].set('goods_name',getinfo.get('goods_name'));
					getSelect[0].set('goods_id',getinfo.get('goods_id'));
					getSelect[0].set('goods_sn',getinfo.get('goods_sn'));
			}
			else {
				thiz.addItem(p);
			}
			
			win.hide();
		});
		win.show();
    },
	calculate:function(){//计算物品总数量和总金额
		var i;
		var totalQty = 0;
		for (i = 0; i < this.goodsstore.getCount(); i++) {
			totalQty += this.goodsstore.getAt(i).get('goods_qty') * 10000;
		}
		this.txt_totQty.setValue(totalQty / 10000);
	}
});
