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
				 account:Ext.getCmp('account').value
			});
		});
	},
	
	createColumns: function() {
        this.columns = [new Ext.grid.RowNumberer(),{
			header:'图片',
			dataIndex:'image_url',
			width:62,
			renderer:function(v){
					return '<img src="'+v+'" width=100 height=100>';
				}
			},{
			header:'item_name',
			dataIndex:'item_name',
			width:55
			},{
			header:'SKU',
			dataIndex:'seller_sku',
			sortable:true,
			width:60
			},{
			header:'price',
			dataIndex:'price',
			sortable:true,
			width:40
			},{
			header:'quantity',
			dataIndex:'quantity',
			sortable:true,
			width:45
			},{
			header:'ASIN',
			dataIndex:'product_id',
			width:40
			},{
			header:'open_date',
			dataIndex:'open_date',
			sortable:true,
			width:40
			},{
			header:'fulfillment',
			dataIndex:'fulfillment_channel',
			width:60
			}];
    },
    createTbar: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var accountarr = this.accountarr;
		this.tbar =  new Ext.Toolbar({
			items:['Asin/SKU/Title:',{
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
						fieldLabel: 'AMZ账号',
						emptyText:'Choose Account',
						id:'account',
						value:0,
						allowBlank:false
						},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							//console.log(Ext.fly('account').getValue());
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value,
								account:Ext.getCmp('account').value
								}});
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
            store: this.store
        });
    }
});

