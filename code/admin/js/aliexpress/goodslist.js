Ext.ux.GoodsView = Ext.extend(Ext.Viewport, {
	initComponent: function() {
        this.layout = 'border';
		this.selectid = '';
		this.createForm();
		this.creatselectionmodel();
		this.getTab();
		this.createStore();
		this.creatTree();
		this.creatgrid();
		this.creatitems();
        Ext.ux.GoodsView.superclass.initComponent.call(this);
    },

    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		remoteSort:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},['goods_id','goods_sn','cat_id','SKU','goods_name','brand_id','dec_name','code','goods_img','stock_place','warn_qty','goods_qty','keeptime','weight','cost','price1','price2','price3','status','comment','is_group','is_control','provider','Grade_cn','plan_cn','price_cn','des_cn','Grade_us','Grade_au','Grade_uk','Grade_de','Grade_fr','Grade_sp','plan_us','plan_au','plan_uk','plan_de','plan_fr','plan_sp','price_us','price_au','price_uk','price_de','price_fr','price_sp','des_en','des_de','des_fr','des_sp','add_time','is_delete','has_child','fix_price','l','w','h','grossweight','cat_name'])
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
				keytype:values.keytype,
				cat_id:values.cat_id,
				brand_id:values.brand_id,
				status:values.status,
				key:values.key
			});
		});
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
		 //this.grid.on('rowdblclick', this.onRowDblClick, this);
	},
    onRowDblClick: function(grid, rowIndex, e) {
		var id = this.store.getAt(rowIndex).get('goods_id');
		var is_group = this.store.getAt(rowIndex).get('is_group');
		parent.openWindow(id,'编辑产品','index.php?model=goods&action='+((is_group==1)?'editcombine':'edit')+'&goods_id='+id,1000,700);
    },
	creatselectionmodel:function(){
		var setid = this.setid;
		var action = this.action;
		doSelect = this.doSelect;
		var tab = this.getTab();
			var sm = new Ext.grid.RowSelectionModel({
						singleSelect:true,
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									setid(record.data);
									if(record.data.is_group == 0){
										Ext.getCmp('tab2').setDisabled(true);
										if(tab.getActiveTab().id == 'tab2') tab.setActiveTab(0);
									}else{
										Ext.getCmp('tab2').setDisabled(false);	
									}
									if(record.data.has_child == 0){
										Ext.getCmp('tab12').setDisabled(true);
										if(tab.getActiveTab().id == 'tab12') tab.setActiveTab(0);
									}else{
										Ext.getCmp('tab12').setDisabled(false);	
									}
									doSelect(tab.getActiveTab().id,record.data,action);
									}
								}
							}								 
						});
			this.sm = sm;
	},

	doSelect:function(id,info,action){
		if(!info){
				if(id != 'tab1') Ext.example.msg('错误','请先选择一条产品记录');
				return false;
			}
                var tpl1 = new Ext.Template(
                    '<div style="width:300px;float:left;"><p>产品编码: {goods_sn}</p>',
                    '<p>报关单简称: {dec_name}</p>',
					'<p>净重: {grossweight}</p>',
					'<p>重量: {weight}</p>',
					'<p>长宽高: {l}*{w}*{h}</p>',
					'<p>自编码: {code}</p>',
					'<p>保质期: {keeptime}</p>',
					'<p>管理库存:{is_control:this.check()}</p>',
                    '<p>备注: {comment}</p><img src="index.php?model=login&action=Barcode&number={goods_sn}&type=1&height=28"></div>',
					'<div style="float:left;"><a href ="{goods_img}" target="_blank"> <img src="{goods_img}" width=270></a></p></div>'
                );
				tpl1.check=function(v){
						return (v == 0)?'NO':'Yes';
					};
				var temp = '<p>固定价($): {fix_price}</p>';
				if(action[8] == 1) temp += '<p>成本价: {cost}</p>';
				if(action[10] == 1) temp += '<p>价格1: {price1}</p>';
				if(action[12] == 1) temp += '<p>价格2: {price2}</p>';
				if(action[14] == 1) temp += '<p>价格3: {price3}</p>';
                var tpl3 = new Ext.Template(temp);
                var tpl4 = new Ext.Template(
                    '<p>Grade_CN: {Grade_cn}</p>',
                    '<p>Plan_cn: {plan_cn}</p>',
					'<p>Price_cn: {price_cn}</p>',
					'<p>中文描述: {des_cn}</p>'
                );
                var tpl5 = new Ext.Template(
                    '<p>Grade_US: {Grade_us}</p>',
                    '<p>Plan_us: {plan_us}</p>',
					'<p>Price_us: {price_us}</p>',
					'<p>英文描述: {des_en}</p>'
                );
                var tpl6 = new Ext.Template(
                    '<p>Grade_AU: {Grade_au}</p>',
                    '<p>Plan_au: {plan_au}</p>',
					'<p>Price_au: {price_au}</p>',
					'<p>英文描述: {des_en}</p>'
                );
                var tpl7 = new Ext.Template(
                    '<p>Grade_UK: {Grade_uk}</p>',
                    '<p>Plan_uk: {plan_uk}</p>',
					'<p>Price_uk: {price_uk}</p>',
					'<p>英文描述: {des_en}</p>'
                );
                var tpl8 = new Ext.Template(
                    '<p>Grade_DE: {Grade_de}</p>',
                    '<p>Plan_de: {plan_de}</p>',
					'<p>Price_de: {price_de}</p>',
					'<p>德文描述: {des_de}</p>'
                );
                var tpl9 = new Ext.Template(
                    '<p>Grafr_FR: {Grafr_fr}</p>',
                    '<p>Plan_fr: {plan_fr}</p>',
					'<p>Price_fr: {price_fr}</p>',
					'<p>法文描述: {frs_fr}</p>'
                );
                var tpl10 = new Ext.Template(
                    '<p>Grasp_SP: {Grasp_sp}</p>',
                    '<p>Plan_sp: {plan_sp}</p>',
					'<p>Price_sp: {price_sp}</p>',
					'<p>西班牙描述: {sps_sp}</p>'
                );
		switch(id){
				case 'tab1':
					tpl1.overwrite(Ext.getCmp("tab1").body, info);
					Ext.getCmp("tab1").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab2':
					Ext.getCmp('tab2_item').getStore().load({params:{comb_goods_id:info.goods_id}});
				break;
				case 'tab12':
					Ext.getCmp('tab12_item').getStore().load({params:{goods_id:info.goods_id}});
				break;
				case 'tab13':
					Ext.getCmp('tab13_item').getStore().load({params:{goods_id:info.goods_id}});
					Ext.getCmp('tab13_item_1').getStore().load({params:{goods_id:info.goods_id}});
				break;
				case 'tab14':
					Ext.getCmp('tab14').load({url: 'index.php?model=goods&action=getlog',params:{goods_id:info.goods_id},text: 'Loading...',timeout: 180});
				break;
				case 'tab15':
					Ext.getCmp('tab15').load({url: 'index.php?model=goods&action=getstock',params:{goods_id:info.goods_id},text: 'Loading...',timeout: 180});
				break;
				case 'tab3':
					tpl3.overwrite(Ext.getCmp("tab3").body, info);
					Ext.getCmp("tab3").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab4':
					tpl4.overwrite(Ext.getCmp("tab4").body, info);
					Ext.getCmp("tab4").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab5':
					tpl5.overwrite(Ext.getCmp("tab5").body, info);
					Ext.getCmp("tab5").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab6':
					tpl6.overwrite(Ext.getCmp("tab6").body, info);
					Ext.getCmp("tab6").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab7':
					tpl7.overwrite(Ext.getCmp("tab7").body, info);
					Ext.getCmp("tab7").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab8':
					tpl8.overwrite(Ext.getCmp("tab8").body, info);
					Ext.getCmp("tab8").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab9':
					tpl9.overwrite(Ext.getCmp("tab9").body, info);
					Ext.getCmp("tab9").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab10':
					tpl10.overwrite(Ext.getCmp("tab10").body, info);
					Ext.getCmp("tab10").body.highlight('#c3daf9', {block:true});
				break;
				case 'tab11':
					Ext.getCmp('imgdiv').update('');
					Ext.getCmp('file_path').setValue('');
					Ext.getCmp('tab11_item').getStore().load({params:{goods_id:info.goods_id}});
				break;
			}
	},

	creatcolumns:function(){
		var ds = this.store;
		var sm = this.sm;
		var cols =[{
				   header:'产品编码',
				   width:80,
				   dataIndex : 'goods_sn',
				   sortable:true
				   },{
				   header:'产品名称',
				   width:150,
				   dataIndex : 'goods_name'
				   },{
				   header:'SKU',
				   width:60,
				   dataIndex : 'SKU',
				   sortable:true
				   },{
				   header:'库存位置',
				   width:50,
				   dataIndex : 'stock_place'
				   },{
				   header:'库存下限',
				   width:50,
				   hidden:true,
				   dataIndex : 'warn_qty'
				   },{
				   header:'库存数量',
				   width:30,
				   sortable:true,
				   dataIndex : 'goods_qty',
				   renderer:function(val,x,rec){
					   	return (parseInt(val) >= parseInt(rec.get('warn_qty')))?val:'<font color=red>'+val+'</font>';
					   }
				   },{
				   header:'分类',
				   dataIndex : 'cat_name',
				   width:50
				   },{
				   header:'产品状态',
				   dataIndex : 'status',
				   width:50,
				   renderer:this.renderers[0]
				   },{
				   header:'录入时间',
				   dataIndex : 'add_time',
				   width:50
				   },{
				  header:'操作',
				  width:45,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑产品',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('goods_id');
							var is_group = ds.getAt(rowIndex).get('is_group');
							parent.openWindow(id,'编辑产品','index.php?model=goods&action='+((is_group==1)?'editcombine':'edit')+'&goods_id='+id,1000,700);
							//alert("编辑 " + rec.get('order_id'));
						}
						 },{
						icon   : 'themes/default/images/delete.gif',	 
						tooltip: '删除产品',
						handler: function(grid, rowIndex, colIndex) {
							Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                				if (btn == 'yes') {
									var id = ds.getAt(rowIndex).get('goods_id');
									Ext.Ajax.request({
									   url: 'index.php?model=goods&action=delete&id='+id,
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
						 },{
						icon   : 'themes/default/images/save.gif',	 
						tooltip: '编辑库存',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('goods_id');
							parent.openWindow(id,'编辑产品','index.php?model=goods&action=modifystock&goods_id='+id,700,400);
						}
						 }]
				  }];
		return new Ext.grid.ColumnModel(cols);
	},

    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		return new Ext.Toolbar({
			items:['<b>产品列表</b>',
				   '->','产品编码:',{
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
							//console.log(store.getAt(0).get('order_id'))
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value
								}});
							}
					},'-',{
						xtype:'button',
						text:'高级搜索',
						iconCls:'x-tbar-advsearch',
						handler:this.showWindow.createDelegate(this)
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							var values = Ext.getCmp('searchform').getForm().getFieldValues();
							window.open().location.href = 'index.php?model=goods&action=exportgoods&keyword='+Ext.fly('keyword').dom.value+'&starttime='+values.starttime+'&totime='+values.totime+'&keytype='+values.keytype+'&cat_id='+values.cat_id+'&brand_id='+values.brand_id+'&status='+values.status+'&key='+values.key;
							}
					},'-',{
						xtype:'button',
						text:'导出搜索价格表',
						iconCls:'x-tbar-import',
						handler:function(){
							var values = Ext.getCmp('searchform').getForm().getFieldValues();
							window.open().location.href = 'index.php?model=goods&action=exportgoodsfix&keyword='+Ext.fly('keyword').dom.value+'&starttime='+values.starttime+'&totime='+values.totime+'&keytype='+values.keytype+'&cat_id='+values.cat_id+'&brand_id='+values.brand_id+'&status='+values.status+'&key='+values.key;
							}
					}
				]			   				   
		});	
	},
	
	creatBbar: function() {
		var	pagesize = this.pagesize;
       return new Ext.PagingToolbar({
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store		   
        });
    },
	formsubmit:function(id){
		if(!id) return false;
		var form = Ext.getCmp('uploadform').getForm();
		if(form.isValid()){
				form.submit({
					url:this.updatesurl,
					waitMsg: '正在上传图片',
					method:'post',
					params:{'goods_id':id},
					success:function(form,action){
							 		if (action.result.success) {
										Ext.getCmp('tab11_item').getStore().load({params:{goods_id:id}});
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('ERROR',action.result.msg);
							 		}
							 },
					failure:function(form,action){
									Ext.Msg.alert('ERROR',action.result.msg);
					}
				});
		}else{
			Ext.example.msg('请选择上传产品图片');
			}		
	},
	creatTab:function(){
		var store = this.store;
		var getid = this.getid;
		var action = this.action;
		var rendererlist = this.rendererlist;
		doSelect = this.doSelect;
		var tab2store = new Ext.data.Store({
			url : 'index.php?model=goods&action=getcomgoods',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','goods_sn','goods_id','goods_name','goods_qty'])
			});
		var tab2_item = new Ext.list.ListView({
				id:'tab2_item',
				store:tab2store,
				width:800,
				height:300,
				autoScroll :true,
				columns: [{
					header: '产品编码',
					dataIndex: 'goods_sn'
				},{
					header: '产品名称',
					width:0.5,
					dataIndex: 'goods_name'
				},{
					header: '产品数量',
					dataIndex: 'goods_qty'
				}]											  
			});
		var tab12store = new Ext.data.Store({
			url : 'index.php?model=goods&action=getchildgoods',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','child_sn','color','size','price','stock'])
			});
		var tab12_item = new Ext.grid.GridPanel({
				id:'tab12_item',
				store:tab12store,
				width:1000,
				height:300,
				autoScroll :true,
				columns: [{
					header: '子产品编码',
					dataIndex: 'child_sn'
				},{
						header:'颜色',
						dataIndex:'color',
						align:'left',
						renderer: rendererlist[1]
				},{
						header:'尺寸',
						dataIndex:'size',
						align:'left',
						renderer:  rendererlist[0]
				},{
						header:'价格',
						dataIndex:'price',
						align:'left'
				},{
						header:'库存数量',
						dataIndex:'stock',
						align:'right'
					}]											  
			});	
		var tab13store = new Ext.data.Store({
			url : 'index.php?model=supplier&action=searchgoods',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','supplier_goods_sn','supplier_goods_name','supplier_goods_price','supplier_goods_remark','name','contact','tel','mail','comment'])
			});
		var tab13store_1 = new Ext.data.Store({
			url : 'index.php?model=purchaseorder&action=gethistory',
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['rec_id','supplier_id','goods_price','order_sn','status','arrival_qty','goods_qty'])
			});
		tab13store_1.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				 goods_id:getid().goods_id
			});
		});
	 var cellTips = new Ext.ux.plugins.grid.CellToolTips([
			{ field: 'name', tpl: '<b>联系人: </b>{contact}<br/>联系电话：{tel}<br/>邮箱:<a href="mailto:{mail}">{mail}<a><br/>备注:{comment}' },
			{ field: 'supplier_goods_name', tpl: '<b>备注: </b>{supplier_goods_remark}' }
		]);			
		var tab13_item = new Ext.Panel({
				autoWidth:true,
				height:300,
				layout:'column',
				items:[new Ext.grid.GridPanel({
				id:'tab13_item',
				title:'供应商列表',
				columnWidth:.45,
				store:tab13store,
				height:230,
				frame: true,
				autoScroll :true,
				plugins: [ cellTips ],
				columns: [{
					header: '供应商',
					dataIndex: 'name'
				},{
						header:'供应商编码',
						dataIndex:'supplier_goods_sn',
						align:'left'
				},{
						header:'供应商品名',
						dataIndex:'supplier_goods_name',
						align:'left'
				},{
						header:'供应商价格',
						dataIndex:'supplier_goods_price',
						align:'left'
				}]											  
			}),new Ext.grid.GridPanel({
				id:'tab13_item_1',
				title:'历史采购价格',
				store:tab13store_1,
				columnWidth:.45,
				frame: true,
				height:300,
				autoScroll :true,
				columns: [{
					header: '供应商',
					dataIndex: 'supplier_id'
				},{
						header:'采购价格',
						dataIndex:'goods_price',
						width:60,
						align:'left'
				},{
						header:'采购单号',
						dataIndex:'order_sn',
						width:120,
						align:'left'
				},{
						header:'状态',
						dataIndex:'status',
						align:'left'
				},{
						header:'采购量',
						dataIndex:'goods_qty',
						align:'left'
				},{
						header:'已到货',
						dataIndex:'arrival_qty',
						align:'left'
				}],
				bbar:new Ext.PagingToolbar({
						pageSize: 10,
						displayInfo: true,
						displayMsg: '第{0} 到 {1} 条数据 共{2}条',
						emptyMsg: "没有数据",
						store: tab13store_1
					})											  
			})]
			});
		var tab11store = new Ext.data.JsonStore({
        url: 'index.php?model=goods&action=getgoodsgallery',
        root: 'topics',
        fields: ['rec_id','url']
    });
	var tpl = new Ext.XTemplate(
		'<tpl for=".">',
            '<div class="thumb-wrap" id="pic{rec_id}">',
		    '<div class="thumb"><img src="{url}"></div>',
		    '</div>',
        '</tpl>',
        '<div class="x-clear"></div>'
	);

		var tab11_item = new Ext.DataView({
			id:'tab11_item',
            store: tab11store,
            tpl: tpl,
			singleSelect: true,
            autoHeight:true,
            overClass:'x-view-over',
            itemSelector:'div.thumb-wrap',
            emptyText: 'No images to display',
            listeners: {
            	selectionchange: {
            		fn: function(dv,nodes){
            			if(this.getSelectedRecords()[0]) Ext.getCmp('imgdiv').update('<img src="'+this.getSelectedRecords()[0].data.url+'" width=300>');
            		}
            	}
            }
		});
		var thiz = this;
		var gallerybtn = new Ext.Panel({
				id:'gallery_btn',
				layout:'column',
				items:[{
					xtype:'button',
					text:'设为主图片',
					handler:function(){
						if(Ext.getCmp('tab11_item').getSelectedRecords()[0]){
							modifymodel(getid().goods_id,'goods_img',Ext.getCmp('tab11_item').getSelectedRecords()[0].data.url,'goods');
							}else{
							Ext.example.msg('Error','请先选择下面图库中的图片');	
							}
						}
					},{
					xtype:'button',
					iconCls:'x-tbar-save',
					text:'删除图片',
					handler:function(){
						if(Ext.getCmp('tab11_item').getSelectedRecords()[0]){
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							Ext.Ajax.request({
							   url: 'index.php?model=goods&action=delgallery',
							   loadMask:true,
							   params: { id:Ext.getCmp('tab11_item').getSelectedRecords()[0].data.rec_id },
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
									Ext.getBody().unmask();
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										Ext.getCmp('tab11_item').getStore().load({params:{goods_id:getid().goods_id}});
										}else{
										Ext.Msg.alert('ERROR',res.msg);
										}						
									}
								});
							}else{
							Ext.example.msg('Error','请先选择下面图库中的图片');	
							}
						}
					}]
			});
		var uploadform =new Ext.FormPanel({
								fileUpload:true,
								id:'uploadform',
								title:'上传图片',
								layout:'column',
								items:[
										{
										columnWidth:.3,
										items:[
										{fieldLabel: '上传图片',
										inputType: 'file',
										xtype: 'textfield',
										name:'file_path',
										id:'file_path'
										}]},{
										columnWidth:.3,
										items:[
										{fieldLabel: '上传图片',
										xtype: 'textfield',
										name:'url'
										}]},{
										columnWidth:.3,
										items:[
										{
										xtype: 'button',
										text: '提交',
											iconCls:'x-tbar-update',
											handler:function(){
												var info = getid();
												thiz.formsubmit(info.goods_id);
											}
										}]
										}]
								});
		var tab = new Ext.TabPanel({
        activeTab: 0,
		autoWidth:true,
		height:300,
		boxMaxHeight:300,
        plain:true,
        defaults:{autoScroll: true},
        items:[{
			    id:'tab1',
                title: '基本信息',
				listeners: {activate: function(){
						doSelect('tab1',getid(),action);
					}},
                html: ''
            },{
				id:'tab3',
                title: '费用明细',
				disabled:(action[0]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab3',getid(),action);
					}},
                html: '<p>成本价:</p><p>价格1:</p><p>价格2:</p><p>价格3: </p>'
            },{
				id:'tab15',
                title: '库存情况',
				listeners: {activate: function(){
						doSelect('tab15',getid(),action);
					}}
            },{
				id:'tab13',
                title: '供应商信息',
				disabled:(action[17]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab13',getid(),action);
					}},
                items:[tab13_item]
            },{
				id:'tab2',
                title: '组合产品',
				listeners: {activate: function(){
						doSelect('tab2',getid(),action);
					}},
                items:[tab2_item]
            },{
				id:'tab12',
                title: '子产品',
				listeners: {activate: function(){
						doSelect('tab12',getid(),action);
					}},
                items:[tab12_item]
            },{
				id:'tab14',
                title: '产品日志',
				listeners: {activate: function(){
						doSelect('tab14',getid(),action);
					}}
            },{
				id:'tab11',
                title: '产品图库',
				width:800,
				layout:'column',
				items:[{
						columnWidth:.3,
						layout: 'form',
						defaultType: 'textfield',
						items:[{xtype:'panel',id:'imgdiv',height:300,html:''}]
					},{
						columnWidth:.7,
						layout: 'form',
						items:[
							uploadform,gallerybtn,tab11_item
						]
					}],
				listeners: {activate: function(){
						doSelect('tab11',getid(),action);
					}}
			},{
				id:'tab4',
                title: '中国刊登',
				disabled:(action[1]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab4',getid(),action);
					}},
                html: ""
            },{
				id:'tab5',
                title: '美国刊登',
				disabled:(action[2]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab5',getid(),action);
					}},
                html: ""
            },{
				id:'tab6',
                title: '澳大利亚刊登',
				disabled:(action[3]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab6',getid(),action);
					}},
                html: ""
            },{
				id:'tab7',
                title: '英国刊登',
				disabled:(action[4]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab7',getid(),action);
					}},
                html: ""
            },{
				id:'tab8',
                title: '德文刊登',
				disabled:(action[5]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab8',getid(),action);
					}},
                html: ""
            },{
				id:'tab9',
                title: '法文刊登',
				disabled:(action[6]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab9',getid(),action);
					}},
                html: ""
            },{
				id:'tab10',
                title: '西班牙文刊登',
				disabled:(action[7]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab10',getid(),action);
					}},
                html: ""
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
		return this.items = [this.tree,this.grid,{
							 title:'产品详情',
							 region:'south',
							 height:350,
							 collapsed:false,
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
			if(!this.keytype) this.keytype = [['0','All Fields'],['1','Goods SN'],['2','Goods Name'],['3','SKU'],['4','Stock Place'],['5','Customs Name']];
			return this.keytype;
	},
	afterselect:function(k,v)
	{
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
	},
    createForm: function() {
		var afterselect = this.afterselect;
		var store = this.store;
		var pagesize = this.pagesize;
		var keytype = this.getKeytype();
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
            items: [{
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
						name:'key',
						fieldLabel: '关键词',
						value:''
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
										brand_id:values.brand_id,
										cat_id:values.cat_id,
										status:values.status,
										key:values.key								
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

