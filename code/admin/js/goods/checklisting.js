Ext.define('Ext.ux.ListingGrid',{
	extend:'Ext.grid.Panel',
    initComponent: function() {
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.pagesize = 20,
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
        this.callParent();
    },
	
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
	
	createColumns: function() {
        this.columns = [{
			xtype: 'rownumberer'
		},{
			header:'图片',
			dataIndex:'GalleryURL',
			width:85,
			renderer:function(v){
				return '<img src="'+v+'" width=50 height=50>';
			}
		},{
			header:'产品标题',
			dataIndex:'Title',
			width:200,
			renderer:function(v,x,rec){
				return '<a href="http://item.ebay.com/'+rec.get('ItemID')+'" target="_blank" title="'+v+'">'+v+'</a>';
			}
		},{
			header:'货号',
			dataIndex:'SKU',
			sortable:true,
			width:105,
		},{
			header:'天数',
			dataIndex:'ListingDuration',
			width:105,
		},{
			header:'一口价',
			dataIndex:'BuyItNowPrice',
			sortable:true,
			width:105,
		},{
			header:'起价',
			dataIndex:'StartPrice',
			sortable:true,
			width:105,
		},{
			header:'数量',
			dataIndex:'Quantity',
			sortable:true,
			width:105,
		},{
			header:'点击',
			dataIndex:'HitCount',
			width:105,
		},{
			header:'出价次',
			dataIndex:'BidCount',
			width:105,
		},{
			header:'售出数',
			dataIndex:'QuantitySold',
			width:105,
		},{
			header:'类型',
			dataIndex:'ListingType',
			width:105,
		},{
			header:'账号',
			dataIndex:'account_id',
			width:105,
		},{
			header:'结束天数',
			dataIndex:'endtime',
			width:105,
		},
		{
			header:'操作',
            width:65,
			xtype: 'actioncolumn',
			items:[{
				iconCls:'x-tbar-form_edit',	 
				tooltip: '编辑listing',
				handler: function(grid, rowIndex, colIndex) {
					Ext.Msg.confirm('Update Alert!', 'Are you sure to update this item listing?', function(btn) {
						if (btn == 'yes') {
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							var id = ds.getAt(rowIndex).get('rec_id');
							Ext.Ajax.request({
							   url: 'index.php?model=goods&action=updateitem&id='+id,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
									Ext.getBody().unmask();
										if(res.success){
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
				iconCls:'x-tbar-ebay',	 
				tooltip: '发布产品到eBay',
				handler: function(grid, rowIndex, colIndex) {
					Ext.Msg.confirm('Delete Alert!', 'Are you sure to end this item from Ebay?', function(btn) {
						if (btn == 'yes') {
							var id = ds.getAt(rowIndex).get('rec_id');
							Ext.Ajax.request({
							   url: 'index.php?model=goods&action=enditem&id='+id,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										}else{
										Ext.Msg.alert('ERROR',res.msg);
										}						
									}
								});
						}
					},this)
				}
			}]
		}];
    },
    createTbar: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var accountarr = this.accountarr;
		this.tbar =  Ext.create('Ext.toolbar.Toolbar',{
			items:[{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "account_name"],
					 data: accountarr
				}),
				valueField :"id",
				displayField: "account_name",
				mode: 'local',
				width:160,
				labelWidth: 60,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				fieldLabel: 'Ebay账号',
				emptyText:'Choose Account',
				id:'account',
				value:'0',
				allowBlank:false
			},'-',{
				xtype:'button',
				text:'同步产品状态',
				iconCls: 'x-tbar-reload',
				handler:function(){
					store.load({
						params:{
							start:0, limit:pagesize,
							keyword:Ext.getCmp('keyword').getValue(),
							account:Ext.getCmp('account').getValue(),
							is_check:Ext.getCmp('is_check').getValue(),
							duration:Ext.getCmp('duration').getValue() 
						}
					});
				}
			},'-',{
				xtype:'button',
				text:'保存修改到Ebay',
				iconCls: 'x-tbar-ebay',
				handler:function(){
					store.load({
						params:{
							start:0, limit:pagesize,
							keyword:Ext.getCmp('keyword').getValue(),
							account:Ext.getCmp('account').getValue(),
							is_check:Ext.getCmp('is_check').getValue(),
							duration:Ext.getCmp('duration').getValue() 
						}
					});
				}
			},'-',{
				xtype:'button',
				text:'下架产品',
				iconCls: 'x-tbar-offline',
				handler:function(){
					store.load({
						params:{
							start:0, limit:pagesize,
							keyword:Ext.getCmp('keyword').getValue(),
							account:Ext.getCmp('account').getValue(),
							is_check:Ext.getCmp('is_check').getValue(),
							duration:Ext.getCmp('duration').getValue() 
						}
					});
				}
			},'->','ItemNO/SKU/Title:',{
				xtype:'textfield',
				id:'keyword',
				width:100,
				name:'keyword',
				enableKeyEvents:true,
				listeners:{
					scope:this,
					keypress:function(field,e){
						if(e.getKey()==13){
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.getCmp('keyword').getValue(),
								account:Ext.getCmp('account').getValue(),
								is_check:Ext.getCmp('is_check').getValue() 
								}});
						}
					}
				}
			},'-',{
				xtype:'button',
				text:'搜索',
				iconCls:'x-tbar-search',
				handler:function(){
					//console.log(Ext.fly('account').getValue());
					store.load({
						params:{
							start:0, limit:pagesize,
							keyword:Ext.getCmp('keyword').getValue(),
							account:Ext.getCmp('account').getValue(),
							is_check:Ext.getCmp('is_check').getValue(),
							duration:Ext.getCmp('duration').getValue() 
						}
					});
				}
			},'-',{
				xtype:'button',
				text:'导出搜索',
				iconCls:'x-tbar-import',
				handler:function(){
					window.open().location.href = 'index.php?model=goods&action=exportlisting&keyword='+Ext.getCmp('keyword').getValue()+'&account='+Ext.getCmp('account').getValue()+'&is_check='+Ext.getCmp('is_check').getValue()+'&duration='+Ext.getCmp('duration').getValue();
				}
			},'-',{
				xtype:'button',
				text:'删除历史数据',
				iconCls:'x-tbar-del',
				handler:function(){
					var account = Ext.getCmp('account').getValue();
					if(account == '' || account == 0 || account == undefined){
						Ext.Msg.alert('提示','请先选择要删除的账户');
						return false;
					}
					Ext.getBody().mask("正在删除历史数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
						url: 'index.php?model=goods&action=dellisting',
						loadMask:true,
						params: { id:account },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
							if(res.success){
								Ext.Msg.alert('MSG',res.msg);
							}else{
								Ext.Msg.alert('ERROR',res.msg);
							}						
						}
					});
				}
			}]			   				   
		});	
    },

    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = [{
        	xtype: 'pagingtoolbar',
	        pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
	        store: this.store,
        	items: ['-', {
                icon: 'themes/default/images/save.gif',
                pressed: false,
				disabled:true,
                enableToggle: true,
                text: '保存修改',
                //修改
                toggleHandler: function(){
			   		var m= store.getModifiedRecords().slice(0);
			  		if(!m || m=='' ){
						Ext.example.msg('警告','未有修改，请先修改产品建议采购量！');
						return false;
					}
					
					var jsonArray=[];
					Ext.each(m,function(item){
					   jsonArray.push(item.data);
					});
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
						url:saveURL,
						loadMask:true,
						params:{'data':Ext.encode(jsonArray)},
						success:function(response,opts){
							var res=Ext.decode(response.responseText);
							Ext.getBody().unmask();
							if(res.success){
								store.commitChanges();
								store.load();
								Ext.example.msg('MSG',res.msg);
							}else{
								Ext.example.msg('ERROR',res.msg);
							}
						}
					});
				}
            },'-', {
                icon: 'themes/default/images/add.gif',
                pressed: false,
                enableToggle: true,
                text: '生成补货',
                //修改
                handler:function() {
					var accountid=Ext.getCmp('account').getValue();
					if(accountid==0){
						Ext.example.msg('警告','不能直接保存所有账户的产品listing!');
						return false;
					}
						Ext.Ajax.request({
							url: 'index.php?model=goods&action=savexml',
							method: 'POST',
							params: {
								accountid: accountid
							},
							success: function(response, opts) {
								var res = Ext.decode(response.responseText);
								if (res.success) {
									Ext.example.msg('信息', res.msg);
								} else {
									Ext.example.msg('ERROR', res.msg);
								}
							}
						});
				}
            }]
        }];
    }
});

