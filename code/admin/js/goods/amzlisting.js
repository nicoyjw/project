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
		this.store.on('beforeload',function(){
			Ext.apply(this.baseParams,{
				//keyword:Ext.getCmp('keyword').getValue(),
				//account:Ext.getCmp('account').getValue()
			});
		});
	},
	createColumns: function() {
        this.columns = [{
			xtype: 'rownumberer'
		},{
			header:'图片',
			dataIndex:'image_url',
			flex:1.5,
			renderer:function(v){
				return '<img src="'+v+'" width=100 height=100>';
			}
		},{
			header:'item_name',
			dataIndex:'item_name',
			flex:1.5
		},{
			header:'SKU',
			dataIndex:'seller_sku',
			sortable:true,
			flex:1.5
		},{
			header:'price',
			dataIndex:'price',
			sortable:true,
			flex:1
		},{
			header:'quantity',
			dataIndex:'quantity',
			sortable:true,
			flex:1
		},{
			header:'ASIN',
			dataIndex:'product_id',
			flex:1
		},{
			header:'open_date',
			dataIndex:'open_date',
			sortable:true,
			flex:1
		},{
			header:'fulfillment',
			dataIndex:'fulfillment_channel',
			flex:1.5
		}];
    },
    //创建工具栏
	createTbar: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var accountarr = this.accountarr;
		this.tbar =  Ext.create('Ext.toolbar.Toolbar',{
			items:[
				'Asin/SKU/Title:',
			{
				xtype:'textfield',
				id:'keyword',
				width:100,
				name:'keyword',
				enableKeyEvents:true,
				listeners:{
					scope:this,
					keypress:function(field,e){
						if(e.getKey()==13){
							store.load({
								params:{
									start:0, limit:pagesize,
									keyword:Ext.getCmp('keyword').getValue(),
									account:Ext.getCmp('account').getValue(),
									is_check:Ext.getCmp('is_check').getValue() 
								}
							});
						}
					}
				}
			},'-',
			{
				xtype:'combobox',
				store:  Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "account_name"],
					 data: accountarr
				}),
				valueField :"id",
				displayField: "account_name",
				mode: 'local',
				width:250,
				labelWidth:80,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				fieldLabel: 'AMZ账号',
				emptyText:'Choose Account',
				id:'account',
				value:0,
				allowBlank:false
			},'-',
			{
				xtype:'button',
				text:'搜索',
				iconCls:'x-tbar-search',
				handler:function(){
					//console.log(Ext.getCmp('keyword').getValue());
					store.load({
						params:{
							start:0, limit:pagesize,
							keyword:Ext.getCmp('keyword').getValue(),
							account:Ext.getCmp('account').getValue()
						}
					});
				}
			}]			   				   
		});	
    },
	//创建分页器
    createBbar: function() {
    
		var pagesize = this.pagesize;
        this.dockedItems = [{
        	xtype: 'pagingtoolbar',
	        pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
			dock: 'bottom',
	        store: this.store
        }];
    }
});

