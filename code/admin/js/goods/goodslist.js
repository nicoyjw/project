Ext.define('Ext.ux.GoodsView',{
	extend:'Ext.Viewport',
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
        this.callParent();
    },
    createStore: function() {
    	this.store = Ext.create('Ext.data.JsonStore', {
			fields:['goods_id','goods_sn','cat_id','SKU','goods_name','brand_id','dec_name','code','goods_img','stock_place','warn_qty','goods_qty','keeptime','weight','cost','price1','price2','price3','status','comment','is_group','is_control','provider','Grade_cn','plan_cn','price_cn','des_cn','Grade_us','Grade_au','Grade_uk','Grade_de','Grade_fr','Grade_sp','plan_us','plan_au','plan_uk','plan_de','plan_fr','plan_sp','price_us','price_au','price_uk','price_de','price_fr','price_sp','des_en','des_de','des_fr','des_sp','add_time','is_delete','has_child','fix_price','l','w','h','grossweight','cat_name','aliuploadtext','alitext'],
			remoteSort:true,
			autoLoad:true,
			pageSize:this.pagesize,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
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
		var tree = Ext.create('Ext.tree.Panel',{
			border:true,
			store: Ext.create('Ext.data.TreeStore', {
				autoLoad:true,
				proxy: {
                    type: 'ajax',
					type: 'ajax',
					url:this.catTreeURL
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
			title:'产品分类',
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
				if(Ext.getCmp('cat_id')){
					Ext.getCmp('cat_id').setValue(node.data.id);
				}
				store.on('beforeload', function (store, options) {
							var new_params = {
								cat_id:node.data.id	
								};
				Ext.apply(store.proxy.extraParams, new_params);
				});
				store.load({
					params:{start:0,cat_id:node.data.id,limit:pagesize},
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
			id:'goodgrid',
			height: 500,
			viewConfig:{
            	forceFit: true
			},
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
		var id = this.store.getAt(rowIndex).get('goods_id');
		var is_group = this.store.getAt(rowIndex).get('is_group');
		parent.openWindow(id,'编辑产品1','index.php?model=goods&action='+((is_group==1)?'editcombine':'edit')+'&goods_id='+id,1000,700);
    },
	creatselectionmodel:function(){
		var setid = this.setid;
		var action = this.action;
		doSelect = this.doSelect;
		var tab = this.getTab();
		var sm =  Ext.create('Ext.selection.RowModel',{
			mode: 'SINGLE',
			listeners:{
				"select":function(e,record,rowindex){
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
		});
		this.sm = sm;
	},

	doSelect:function(id,info,action){
		if(!info){
				if(id != 'tab1') Ext.example.msg('错误','请先选择一条产品记录');
				return false;
		}
		var tpl1 = new Ext.Template(
			'<div style="width:300px;float:left;padding:5px;">产品编码: {goods_sn}<br><br>',
			'报关单简称: {dec_name}<br><br>',
			'重量(KG): {weight}<br><br>',
			'长宽高: {l}*{w}*{h}<br><br>',
			'管理库存:{is_control:this.check()}<br><br>',
			'备注: {comment}</p><img src="index.php?model=login&action=Barcode&number={goods_sn}&type=1&height=28"><br><br></div>',
			'<div style="float:left;"><a href ="{goods_img}" target="_blank"> <img src="{goods_img}" width=230></a></p></div>'
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
			'<p>Price_cn: {price_cn}</p>',
			'<p>中文描述: {des_cn}</p>'
		);
		var tpl5 = new Ext.Template(
			'<p>Price_us: {price_us}</p>',
			'<p>英文描述: {des_en}</p>'
		);
		var tpl6 = new Ext.Template(
			'<p>Price_au: {price_au}</p>',
			'<p>英文描述: {des_en}</p>'
		);
		var tpl7 = new Ext.Template(
			'<p>Price_uk: {price_uk}</p>',
			'<p>英文描述: {des_en}</p>'
		);
		var tpl8 = new Ext.Template(
			'<p>Price_de: {price_de}</p>',
			'<p>德文描述: {des_de}</p>'
		);
		var tpl9 = new Ext.Template(
			'<p>Price_fr: {price_fr}</p>',
			'<p>法文描述: {des_fr}</p>'
		);
		var tpl10 = new Ext.Template(
			'<div class="module box">',
			'<div class="module-hd">商品标题：{goods_name} &nbsp;&nbsp;&nbsp<br/>{alitext}</div>',
			'<div class="box-content">',
			'<p class="pc-selected-category-banner">',
			'请选择分类:&nbsp;&nbsp;<input type="text" size="35" id="cat_name" value="{ali_cat_name}"/>',
			'<input type="hidden" id="cat_id" value="{ali_cat_id}"/>&nbsp;&nbsp;<button onclick="getAliCategoryFormTree(\'index.php?model=aliexpress&action=getcattree&com=1\',0,afterselect);" type="button">选择类目</button>&nbsp;&nbsp;{aliuploadtext}',
			'&nbsp;&nbsp;<button onclick="uploadgood({goods_id})" type="button">添加到速卖通产品库</button><b style="float:right">请去速卖通产品管理搜索此产品，进行编辑属性并发布。</b></p>',
			'</div></div>'
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
				var iframe = document.getElementById('tab14_iframe');
				iframe.src="index.php?model=goods&action=getlog&goods_id="+info.goods_id+"&" + Math.random();
				break;
			case 'tab15':
				var iframe = document.getElementById('tab15_iframe');
				iframe.src="index.php?model=goods&action=getstock&goods_id="+info.goods_id+"&" + Math.random();;
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
				var iframe = document.getElementById('tab10_iframe');
            iframe.src = "index.php?model=goods&action=getaligoodsupload&goods_id=" + info.goods_id + "&" + Math.random();
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
		   flex:1,
		   dataIndex : 'goods_sn',
		   sortable:true
		   },{
		   header:'产品名称',
		   flex:2,
		   dataIndex : 'goods_name'
		   },{
		   header:'SKU',
		   flex:1,
		   dataIndex : 'SKU',
		   sortable:true
		   },{
		   header:'库存位置',
		   flex:1,
		   dataIndex : 'stock_place'
		   },{
		   header:'库存下限',
		   flex:1,
		   hidden:true,
		   dataIndex : 'warn_qty'
		   },{
		   header:'库存数量',
		   flex:1,
		   sortable:true,
		   dataIndex : 'goods_qty',
		   renderer:function(val,x,rec){
				return (parseInt(val) >= parseInt(rec.get('warn_qty')))?val:'<font color=red>'+val+'</font>';
			   }
		   },{
		   header:'分类',
		   dataIndex : 'cat_name',
		   flex:1,
		   },{
		   header:'产品状态',
		   dataIndex : 'status',
		  flex:1,
		   renderer:this.renderers[0]
		   },{
		   header:'录入时间',
		   dataIndex : 'add_time',
		   flex:1,
		   },{
			  header:'操作',
			 flex:1,
			  xtype: 'actioncolumn',
			  items:[{
					icon   : 'themes/default/images/update.gif',	 
					tooltip: '编辑产品',
					handler: function(grid, rowIndex, colIndex) {
						var id = ds.getAt(rowIndex).get('goods_id');
						var is_group = ds.getAt(rowIndex).get('is_group');
						parent.openWindow(id,'编辑产品','index.php?model=goods&action='+((is_group==1)?'editcombine':'edit')+'&goods_id='+id,1000,650);
					}
					 },{
					icon   : 'themes/default/images/del.gif',	 
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
												var values = Ext.getCmp('searchform').getForm().getFieldValues();
												ds.on('beforeload', function (store, options) {
													var new_params = {
															keyword:Ext.getCmp('keyword').getValue(),
															starttime:values.starttime,
															totime:values.totime,
															keytype:values.keytype,
															brand_id:values.brand_id,
															cat_id:values.cat_id,
															status:values.status,
															key:values.key		
													};
													Ext.apply(ds.proxy.extraParams, new_params);
													});
											   ds.load({ params: { start: 0, limit: this.pagesize} });
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
		return cols;
	},

    creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		return Ext.create('Ext.toolbar.Toolbar',{
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
									keyword:Ext.getCmp('keyword').getValue()
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
								keyword:Ext.getCmp('keyword').getValue()
								}});
							}
					},'-',{
						xtype:'button',
						text:'高级搜索',
						iconCls:'x-tbar-advsearch',
						handler:this.showWindow.bind(this)
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							//var values = Ext.getCmp('searchform').getForm().getFieldValues();
                            var starttime = Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d');
                            var totime = Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d');
							window.open().location.href = 'index.php?model=goods&action=exportgoods&starttime='+starttime+'&totime='+totime+'&keyword='+Ext.getCmp('keyword').getValue()+'&keytype='+Ext.getCmp('keytype').getValue()+'&cat_id='+Ext.getCmp('cat_id').getValue()+'&status='+Ext.getCmp('status').getValue()+'&key='+Ext.getCmp('key').getValue()+'&products_developers='+Ext.getCmp('products_developers').getValue();
							}
					}
				]			   				   
		});	
	},
	
	creatBbar: function() {
		var	pagesize = this.pagesize;
		return Ext.create('Ext.toolbar.Paging',{
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
		debugger;
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
		var tab2store = Ext.create('Ext.data.Store',{
			fields:['rec_id','goods_sn','goods_id','goods_name','goods_qty'],
			proxy: {
				type: 'ajax',
				url : 'index.php?model=goods&action=getcomgoods',
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			}
		});
		var tab2_item = Ext.create('Ext.list.ListView',{
				id:'tab2_item',
				store:tab2store,
				width:800,
				height:300,
				autoScroll :true,
				columns: [{
					header: '产品编码',
					flex:1,
					dataIndex: 'goods_sn'
				},{
					header: '产品名称',
					flex:1,
					dataIndex: 'goods_name'
				},{
					header: '产品数量',
					flex:1,
					dataIndex: 'goods_qty'
				}]											  
			});
		var tab12store = Ext.create('Ext.data.Store',{
			fields: ['rec_id','child_sn','color','size','price','stock'],
			proxy: {
				type: 'ajax',
				url:'index.php?model=goods&action=getchildgoods',
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			}
		});
		var tab12_item = Ext.create('Ext.grid.Panel',{
				id:'tab12_item',
				store:tab12store,
				width:1000,
				height:300,
				autoScroll :true,
				columns: [{
					header: '子产品编码',
					flex:1,
					dataIndex: 'child_sn'
				},{
						header:'颜色',
						dataIndex:'color',
						flex:1,
						align:'left',
						renderer: rendererlist[1]
				},{
						header:'尺寸',
						dataIndex:'size',
						flex:1,
						align:'left',
						renderer:  rendererlist[0]
				},{
						header:'价格',
						flex:1,
						dataIndex:'price',
						align:'left'
				},{
						header:'库存数量',
						flex:1,
						dataIndex:'stock',
						align:'right'
					}]											  
			});	
		var tab13store = Ext.create('Ext.data.Store',{
			fields:['rec_id','supplier_goods_sn','supplier_goods_name','supplier_goods_price','supplier_goods_remark','name','contact','tel','mail','comment'],
			proxy: {
				type: 'ajax',
				url : 'index.php?model=supplier&action=searchgoods',
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			}
		});
		var tab13store_1 = Ext.create('Ext.data.Store',{
			fields:['rec_id','supplier_id','goods_price','order_sn','status','arrival_qty','goods_qty'],
			proxy: {
				type: 'ajax',
				url : 'index.php?model=purchaseorder&action=gethistory',
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'rec_id',
					root: 'topics'
				}
			}
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
		var tab13_item = Ext.create('Ext.panel.Panel',{
				autoWidth:true,
				height:300,
				layout:'column',
				items:[
					Ext.create('Ext.grid.Panel',{
						id:'tab13_item',
						title:'供应商列表',
						columnWidth:.48,
						store:tab13store,
						height:230,
						frame: false,
						style:'margin:5px 15px 15px 15px;background-color:#666;border-radius:8px;border:1px solid #CCC',
						autoScroll :true,
						plugins: [ cellTips ],
						columns: [{
							header: '供应商',
							flex:1,
							dataIndex: 'name'
						},{
								header:'供应商编码',
								flex:1,
								dataIndex:'supplier_goods_sn',
								align:'left'
						},{
								header:'供应商品名',
								flex:1,
								dataIndex:'supplier_goods_name',
								align:'left'
						},{
								header:'供应商价格',
								flex:1,
								dataIndex:'supplier_goods_price',
								align:'left'
						}]											  
				}),Ext.create('Ext.grid.Panel',{
					id:'tab13_item_1',
					title:'历史采购价格',
					store:tab13store_1,
					columnWidth:.48,
					frame: false,
					style:'margin:5px 15px 15px 15px;background-color:#666;border-radius:8px;border:1px solid #CCC',
					height:230,
					autoScroll :true,
					columns: [{
						header: '供应商',
						flex:1,
						dataIndex: 'supplier_id'
					},{
							header:'采购价格',
							dataIndex:'goods_price',
							flex:1,
							align:'left'
					},{
							header:'采购单号',
							dataIndex:'order_sn',
							flex:2,
							align:'left'
					},{
							header:'状态',
							flex:1,
							dataIndex:'status',
							align:'left'
					},{
							header:'采购量',
							flex:1,
							dataIndex:'goods_qty',
							align:'left'
					},{
							header:'已到货',
							flex:1,
							dataIndex:'arrival_qty',
							align:'left'
					}],		
					bbar:[{
							xtype: 'pagingtoolbar',
							pageSize: 10,
							displayInfo: true,
							displayMsg: '第{0} 到 {1} 条数据 共{2}条',
							emptyMsg: "没有数据",
							store: tab13store_1
					}]											  
			})]
			});
		var tab11store = Ext.create('Ext.data.JsonStore',{
			proxy: {
				type: 'ajax',
				url: 'index.php?model=goods&action=getgoodsgallery',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					root: 'topics'
				}
			},
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
			frame:false,
			border:false,
            overClass:'x-view-over',
            itemSelector:'div.thumb-wrap',
            emptyText: 'No images to display',
            listeners: {
            	selectionchange: function(dv,nodes){
					var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
					if(sel.length > 0) Ext.getCmp('imgdiv').update('<img src="'+sel[0].data.url+'" height=230>');
            	}
            }
		});
		var thiz = this;
		var gallerybtn = Ext.create('Ext.form.Panel',{
				id:'gallery_btn',
				layout:'column',
				border:false,
				frame:false,
				items:[{
					xtype:'button',
					text:'设为主图片',
					border:false,
					handler:function(){
						var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
						if(sel.length > 0){
							modifymodel(getid().goods_id,'goods_img',sel[0].data.url,'goods');
						}else{
							Ext.example.msg('Error','请先选择下面图库中的图片');	
						}
					}
				},{
					xtype:'button',
					iconCls:'x-tbar-save',
					text:'删除图片',
					style:'margin-left:10px',
					border:false,
					handler:function(){
						var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
						if(sel[0]){
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							Ext.Ajax.request({
								url: 'index.php?model=goods&action=delgallery',
								loadMask:true,
								params: { id:sel[0].data.rec_id },
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
		var uploadform =Ext.create('Ext.form.Panel',{
			fileUpload:true,
			id:'uploadform',
			title:'上传图片',
			border:false,
			frame:false,
			layout:'column',
			items:[{
				columnWidth:.28,
				border:false,
				frame:false,
				items:[{
					fieldLabel: '上传图片',
					labelWidth:65,
					width:250,
					xtype: 'fileuploadfield',
					name:'file_path',
					id:'file_path'
				}]
			},{
				columnWidth:.30,
				border:false,
				frame:false,
				items:[{
					fieldLabel: '图片链接',
					labelWidth:65,
					width:250,
					xtype: 'textfield',
					name:'url'
				}]
			},{
				columnWidth:.2,
				border:false,
				frame:false,
				items:[{
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
		var tab = Ext.create('Ext.tab.Panel',{
			activeTab: 0,
			autoWidth:true,
			height:580,
			plain:true,
			defaults:{autoScroll: true},
			items:[{
				id:'tab1',
				title: '基本信息',
				listeners: {
					activate: function(){
						doSelect('tab1',getid(),action);
					}
				},
				html: ''
			},{
				id:'tab3',
				title: '产品价格',
				disabled:(action[0]==0)?true:false,
				listeners: {
					activate: function(){
						doSelect('tab3',getid(),action);
					}
				},
				html: '<p>成本价:</p><p>价格1:</p><p>价格2:</p><p>价格3: </p>'
			},{
				id:'tab15',
				title: '库存情况',
				autoScroll: true,
				html:'<iframe id="tab15_iframe" src="index.php?model=goods&action=getstock" width="100%" height="100%" ></iframe>',
				listeners: {
					activate: function(){
						doSelect('tab15',getid(),action);
					}
				}
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
				id:'tab13',
				title: '供应商信息',
                disabled:(action[17]==0)?true:false,
				listeners: {activate: function(){
						doSelect('tab13',getid(),action);
					}},
				items:[tab13_item]
			},{
                id:'tab5',
                title: '美国刊登',
                disabled:(action[2]==0)?true:false,
                listeners: {activate: function(){
                        doSelect('tab5',getid(),action);
                    }},
                html: ""
            },{
                id:'tab8',
                title: '德国刊登',
                disabled:(action[2]==0)?true:false,
                listeners: {activate: function(){
                        doSelect('tab8',getid(),action);
                    }},
                html: ""
            },{
                id:'tab9',
                title: '法国刊登',
                disabled:(action[2]==0)?true:false,
                listeners: {activate: function(){
                        doSelect('tab9',getid(),action);
                    }},
                html: ""
            },{
				id:'tab14',
				title: '产品日志',
				html:'<iframe id="tab14_iframe" src="index.php?model=goods&action=getstock" width="100%" height="200" ></iframe>',
				listeners: {activate: function(){
						doSelect('tab14',getid(),action);
					}}
			},{
				id:'tab11',
				title: '产品图库',
				width:800,
				height:280,
				layout:'column',
				items:[{
						columnWidth:.3,
						layout: 'form',
						defaultType: 'textfield',
						items:[{xtype:'panel',id:'imgdiv',height:250,html:''}]
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
                id: 'tab10',
                title: 'Aliexpress在线刊登',
                html: '<iframe style="padding:0;margin:0;" id="tab10_iframe" src="index.php?model=goods&action=getaligoodsupload" width="100%" height="200" ></iframe>',
                listeners: {
                    activate: function() {
                        doSelect('tab10', getid(), action)
                    }
                }
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
		return this.items = [
			this.tree,
			this.grid,{
			 title:'产品详情',
			 region:'south',
			 height:320,
			 collapsible: true, 
			 split: true,
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
		var allaccount = this.arrdata[5];
        var form = Ext.create('Ext.form.Panel',{
            frame: false,
			border:false,
			bodyStyle:'padding:10px',
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
			id:'searchform',
            trackResetOnLoad: true,
			items: [{
				xtype:'datefield',
				name:'starttime',
				id:'starttime',
				width:250,
				format:'Y-m-d',
				fieldLabel:'From'
			},{
				xtype:'datefield',
				width:250,
				name:'totime',
				id:'totime',
				format:'Y-m-d',
				fieldLabel:'To'
			},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: keytype
				}),
				width:250,
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'keytype',
				id:'keytype',
				fieldLabel: '搜索字段',
				name: 'keytype',
				value:'0'
			},{
				name:'key',
				id:'key',
				width:250,
				fieldLabel: '关键词',
				value:''
			},{
				xtype:'triggerfield',
				editable: false,
				width:250,
				fieldLabel:'分类',
				xtype:'trigger',
				id:'cat_name',
				name:'cat_name',
				value:'All',
				onSelect: function(record){
				},
				onTriggerClick: function() {
					getCategoryFormTree('index.php?model=goods&action=getcattree&com=1',0,afterselect);
				}
			},{xtype:'hidden',id:'cat_id',name:'cat_id',value:'0'},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: status
				}),
				valueField :"id",
				width:250,
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'status',
				fieldLabel: '产品状态',
				name: 'status',
				id:'status',
				value:'0'
			},{xtype:'hidden',id:'cat_id',name:'cat_id',value:'0'},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: allaccount
				}),
				valueField :"id",
				width:250,
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'products_developers',
				fieldLabel: '产品开发员',
				name: 'products_developers',
				id:'products_developers',
				value:'0'
			}],
            buttons: [{
                text: 'submit',
				handler:function(){
					Ext.getCmp('keyword').setValue('');
					var values = Ext.getCmp('searchform').getForm().getFieldValues();
					store.on('beforeload', function (store, options) {
						var new_params = {
								keyword:Ext.getCmp('keyword').getValue(),
								starttime:values.starttime,
								totime:values.totime,
								keytype:values.keytype,
								brand_id:values.brand_id,
								cat_id:values.cat_id,
								status:values.status,
								key:values.key,
								products_developers:values.products_developers
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
            closeAction: 'destroy',
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
function afterselect(k,v){
	var cname = document.getElementById('cat_name');
	var cid = document.getElementById('cat_id');
	cname.setAttribute('value',v);
	cid.setAttribute('value',k);
}
function uploadgood(goodId){
	if(document.getElementById('cat_id').value){
		var id = document.getElementById('aliaccountId').value;
		var cat_id = document.getElementById('cat_id').value;
		Ext.Ajax.request({
		   url: 'index.php?model=aliexpress&action=addAliLib&id='+id+'&goods_id='+goodId+'&cat_id='+cat_id,
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
					if(res.success){
					Ext.example.msg('MSG',res.msg);
					}else{
					Ext.Msg.alert('ERROR',res.msg);
					}						
				}
			});
	}else{
		Ext.example.msg('信息','请选择分类!');
	}
}	