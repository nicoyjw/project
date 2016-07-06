Ext.ux.ListingGrid = Ext.extend(Ext.grid.GridPanel, {
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
        Ext.ux.ListingGrid.superclass.initComponent.call(this);
    },
	
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		remoteSort:true,
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				 keyword:Ext.fly('keyword').dom.value,
				 account:Ext.getCmp('account').value,
				 is_check:Ext.getCmp('is_check').value,
				duration:Ext.getCmp('duration').value
			});
		});
	},
	
	createColumns: function() {
        this.columns = [new Ext.grid.RowNumberer(),{
			header:'图片',
			dataIndex:'GalleryURL',
			width:62,
			renderer:function(v){
					return '<img src="'+v+'" width=100 height=100>';
				}
			},{
			header:'ItemID',
			dataIndex:'ItemID',
			width:55
			},{
			header:'Title',
			dataIndex:'Title',
			width:150,
			renderer:function(v,x,rec){
					return '<a href="http://item.ebay.com/'+rec.get('ItemID')+'" target="_blank" title="'+v+'">'+v+'</a>';
				}
			},{
			header:'SKU',
			dataIndex:'SKU',
			sortable:true,
			width:60
			},{
			header:'Duration',
			dataIndex:'ListingDuration',
			width:40
			},{
			header:'BINprice',
			dataIndex:'buyitnowprice',
			sortable:true,
			width:40
			},{
			header:'Startprice',
			dataIndex:'startprice',
			sortable:true,
			width:45
			},{
			header:'Quantity',
			dataIndex:'Quantity',
			sortable:true,
			width:40
			},{
			header:'bidcount',
			dataIndex:'bidcount',
			width:40
			},{
			header:'ListingType',
			dataIndex:'ListingType',
			width:60
			},{
			header:'账号',
			dataIndex:'account_id',
			width:50
			},{
			header:'starttime',
			dataIndex:'starttime',
			width:50
			},{
			header:'endtime',
			dataIndex:'endtime',
			width:50
			}];
    },
    createTbar: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var accountarr = this.accountarr;
		this.tbar =  new Ext.Toolbar({
			items:['ItemNO/SKU/Title:',{
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
									keyword:Ext.fly('keyword').dom.value,
									account:Ext.getCmp('account').value,
									is_check:Ext.getCmp('is_check').value 
									}});
								}
							}
						}
					},'-',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "account_name"],
							 data: accountarr
						}),
						valueField :"id",
						displayField: "account_name",
						mode: 'local',
						width:100,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						fieldLabel: 'Ebay账号',
						emptyText:'Choose Account',
						id:'account',
						value:0,
						allowBlank:false
						},'-','Duration',{
							xtype:"combo",
							fieldLabel: '选择',
							id:'duration',
							store: new Ext.data.SimpleStore({
								fields: ['value', 'text'],
								data: [
									['Days_1', 'Days_1'],
									['Days_3', 'Days_3'],
									['Days_5', 'Days_5'],
									['Days_7', 'Days_7'],
									['Days_10', 'Days_10'],
									['Days_30', 'Days_30'],
									['GTC', 'GTC'],
									['0', '所有类型']
								]
							}),
							displayField: 'text',
							valueField: 'value',
							mode: 'local',
							editable: false,
							width:100,
							value:0,
							forceSelection: true,
							triggerAction: 'all',
							allowBlank:false
						},'-',{
							xtype:"combo",
							fieldLabel: '选择',
							id:'is_check',
							store: new Ext.data.SimpleStore({
								fields: ['value', 'text'],
								data: [
									['1', '检查SKU重复'],
									['2', '检查TiTle重复'],
									['0', '不检查重复']
								]
							}),
							displayField: 'text',
							valueField: 'value',
							mode: 'local',
							editable: false,
							width:100,
							forceSelection: true,
							triggerAction: 'all',
							allowBlank:false
						},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							//console.log(Ext.fly('account').getValue());
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value,
								account:Ext.getCmp('account').value,
								is_check:Ext.getCmp('is_check').value,
								duration:Ext.getCmp('duration').value 
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=goods&action=exportlisting&keyword='+Ext.fly('keyword').dom.value+'&account='+Ext.getCmp('account').value+'&is_check='+Ext.getCmp('is_check').value+'&duration='+Ext.getCmp('duration').value;
							}
					},'-',{
						xtype:'button',
						text:'未上架产品',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=goods&action=exportunlisting&account='+Ext.getCmp('account').value;
							}
					},'-',{
						xtype:'button',
						text:'删除历史数据',
						iconCls:'x-tbar-import',
						handler:function(){
							var account = Ext.getCmp('account').value;
							if(account == '' || account ==0 || account == undefined) {
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
					}
				]			   				   
		});	
    },

    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
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
			   		var m=store.modified.slice(0);
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
								store.reload();
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
        });
    }
});

