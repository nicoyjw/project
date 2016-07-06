Ext.ux.SyncGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		this.creatselectionmodel();
        Ext.ux.SyncGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
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
				keyword:Ext.fly('keyword').dom.value
			});
		});
	},
	createColumns: function() {
        var cols = [new Ext.grid.RowNumberer({header : '序号', width : 35}),{
						header: '产品SKU',
						dataIndex: 'product_sku'
					},{
						header: '网站名',
						dataIndex: 'website_name',
						width:80
					},{
						header: '语言CODE',
						dataIndex: 'language_code',
						width:80
					},{
						header: '产品标题',
						dataIndex: 'product_title',
						width:80
					},{
						header: '同步状态',
						dataIndex: 'sync_status_remark'
					},{
						header: '同步响应备注',
						dataIndex: 'sync_response_remark'
					},{
						header : '添加日期',
						dataIndex : 'add_data'
					}];
        this.columns = cols;
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [/*{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, */{
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this),
			
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
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
								keyword:Ext.fly('keyword').dom.value,
								entity_type_id:Ext.getCmp('entity_type_id').value,
								is_required:Ext.getCmp('is_required').value,
								is_unique:Ext.getCmp('is_unique').value,
								is_update_notice:Ext.getCmp('is_update_notice').value
								}});
							}
					}];
    },
	creatselectionmodel:function(){
		var sm = new Ext.grid.RowSelectionModel({
						singleSelect:true								 
						});
			this.sm = sm;
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
    }
});
