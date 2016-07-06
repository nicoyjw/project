Ext.define('Ext.ux.QuoteGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
		this.creatselectionmodel();
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			//remoteSort:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		});
		pruneModifiedRecords:true,
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				keyword:Ext.fly('keyword').dom.value,
				starttime:Ext.fly('starttime').dom.value,
				totime:Ext.fly('totime').dom.value
			});
		});
    },
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
			if(i==4){
				cols.push({
					header: h,
					dataIndex: f,
					flex:1,
				   renderer:function(val,x,rec){
					   	var str = (rec.get('remark'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('remark') + '">':'';
					   	return '<b>'+val+'</b>' + str ;
					   }
				});
			}else if(i==6){
				cols.push({
					flex:1,
					header: h,
					dataIndex: f,
					hidden:true
				});
			}else{
				cols.push({
					flex:1,
					width:80,
					header: h,
					dataIndex: f
				});
			}
        }
        this.columns = cols;
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'QuoteGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			id:'QuoteGrid_removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        },'->','From:',{
						xtype:'datefield',
						name:'starttime',
						id:'starttime',
						format:'Y-m-d'
					},'-','To:',{
						xtype:'datefield',
						name:'totime',
						id:'totime',
						format:'Y-m-d'
					},'-','关键词:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.fly('keyword').dom.value,
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href='index.php?model=purchasequote&action=export&keyword='
							+Ext.fly('keyword').dom.value+'&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
							}
						}];
    },
	creatselectionmodel:function(){
		var sm = Ext.create('Ext.selection.RowModel',{
			mode:'SINGLE ',listeners:{"select":{
				fn:function(e,rowindex){
					var sku=sm.getSelected().get("product");
					Ext.getCmp('SupplierGoodsGrid').getStore().load({params:{sku:sku}});}}}});
		this.sm=sm;}
});
Ext.define('Ext.ux.SupplierGoodsGrid',{
	extend:'Ext.grid.GridPanel',
		initComponent: function() {
			this.autoHeight = true;
			this.stripeRows = true;
			this.viewConfig = {
				forceFit: true
			};
			this.createStore();
			this.createColumns();
			this.callParent(this);
		},
		
		createStore: function() {
			this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			//remoteSort:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		});
		},
		createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'SupplierGoodsGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			id:'SupplierGoodsGrid_removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
		createColumns: function() {
			var cols = [];
			cols.push({xtype: 'rownumberer'});
			for (var i = 0; i < this.fields.length; i++) {
				var f = this.fields[i];
				var h = this.headers[i];
				cols.push({
					flex:1,
					header: h,
					dataIndex: f
				});
			}
			this.columns = cols;
		}
	});
