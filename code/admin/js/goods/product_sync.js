Ext.define('Ext.ux.SyncGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
		this.creatselectionmodel();
        this.callParent(this);
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
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.getCmp('keyword').getValue()
			});
		});
	},
	createColumns: function() {
        var cols = [{
			xtype: 'rownumberer',
			header : '序号', width : 35
		},{
			header: '产品SKU',
			flex:1,
			dataIndex: 'product_sku'
		},{
			header: '网站名',
			dataIndex: 'website_name',
			flex:1
		},{
			header: '语言CODE',
			dataIndex: 'language_code',
			flex:1
		},{
			header: '产品标题',
			dataIndex: 'product_title',
			flex:1
		},{
			header: '同步状态',
			dataIndex: 'sync_status_remark',
			flex:1
		},{
			header: '同步响应备注',
			dataIndex: 'sync_response_remark',
			flex:1
		},{
			header : '添加日期',
			dataIndex : 'add_data',
			flex:1
		}];
        this.columns = cols;
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [/*{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, */{
            text: '编辑',
            iconCls: 'x-tbar-update',
			id:'editBtn',
			//ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this),
			
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'removeBtn',
			//ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        },
		'->',
		'关键词:',
					{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
							store.load({params:{start:0, limit:pagesize,
								keyword:field.getValue()
								}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								start:0,
								limit:pagesize,
								keyword:Ext.getCmp('keyword').getValue(),
								entity_type_id:Ext.getCmp('entity_type_id').getValue(),
								is_required:Ext.getCmp('is_required').getValue(),
								is_unique:Ext.getCmp('is_unique').getValue(),
								is_update_notice:Ext.getCmp('is_update_notice').getValue()
								}});
							}
					}];
    },
	creatselectionmodel:function(){
		var sm = Ext.create('Ext.selection.RowModel',{
			mode: 'SINGLE'})
		this.sm = sm;
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
    }
});
