Ext.define('Ext.ux.AmzreportGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.autoHeight = false;
		this.autoWidth = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.pagesize = 15,
		this.loadMask = true;
        this.createStore();
        this.createColumns();
        this.createTbar();
		this.createBbar();
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			pageSize: this.pagesize,
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
				account:Ext.getCmp('account').getValue()
			});
		});
	},
	createColumns: function() {
		var store = this.store;
        var cols = [];
		cols.push({xtype: 'rownumberer'});
        for (var i = 1; i < this.fields.length-1; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
				flex:1,
                dataIndex: f
            });
        }
		cols.push({
		  header:'操作',
		  width:65,
		  flex:1, 
		  xtype: 'actioncolumn',
		  renderer:function(v,m,rec){
				if(rec.get('status') == 0) {
					this.items[0].iconCls ='iconpadding';
					this.items[1].iconCls ='hidden';
					this.items[2].iconCls ='hidden';
				}else{
					this.items[0].iconCls ='hidden';
					this.items[1].iconCls ='iconpadding';
					this.items[2].iconCls ='iconpadding';
				}
			},
		  items:[{
				icon   : 'themes/default/images/icons1/page_down.gif',	 
				tooltip: '加载report',
				handler: function(grid, rowIndex, colIndex) {
					var id = store.getAt(rowIndex).get('id');
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
						Ext.Ajax.request({
							   url: 'index.php?model=amazon&action=loadreport&id='+id,
							   timeout: 600000,
								success:function(response,opts){
									Ext.getBody().unmask();
									var res = Ext.decode(response.responseText);
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										store.reload();
										}else{
										Ext.Msg.alert('ERROR',res.msg);
										}						
									}
								});
				}
			},{
				icon   : 'themes/default/images/book.gif',	 
				tooltip: '查看report文件',
				handler: function(grid, rowIndex, colIndex) {
					var id = store.getAt(rowIndex).get('id');
					window.open('index.php?model=amazon&action=downloadreport&id='+id);
				}
			},{
				icon   : 'themes/default/images/icons/arrow_refresh.png',	 
				tooltip: '重新加载report',
				handler: function(grid, rowIndex, colIndex) {
					var id = store.getAt(rowIndex).get('id');
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
						url: 'index.php?model=amazon&action=loadreport&id='+id,
						timeout: 600000,
						success:function(response,opts){
							Ext.getBody().unmask();
							var res = Ext.decode(response.responseText);
							if(res.success){
								Ext.example.msg('MSG',res.msg);
								store.reload();
							}else{
								Ext.Msg.alert('ERROR',res.msg);
							}						
						}
					});
				}
			}]
		});
        this.columns = cols;
    },
	createTbar: function() {
			var account = this.accountdata;
			var store = this.store;
			this.tbar = [{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				editable: false,
				width:250,
				labelWidth:75,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'saccount',
				fieldLabel: '选择账户',
				id: 'account'
			},'-',{
				xtype:'button',
				text:'搜索',
				iconCls:'x-tbar-search',
				handler:function(){
					store.load({params:{account:Ext.getCmp('account').getValue()}});
					}
			},'-',{
				text: '加载report',
				iconCls: 'x-tbar-import',
				handler: this.createRecord.bind(this)
			}];
	},
	createBbar: function() {
		this.bbar = [{
			xtype: 'pagingtoolbar',
			pageSize: 15,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
			store: this.store
		}];
	},
	createRecord:function(){
		if(!Ext.getCmp('account').getValue()) {
			Ext.example.msg('Error','请先选择一个账号获取最新Report数据');return false;
		}
		var thiz = this.store;
			Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
			Ext.Ajax.request({
				url: this.outdepotURL,
				timeout: 600000,
				params:{id:Ext.getCmp('account').getValue()},
				success:function(response,opts){
					Ext.getBody().unmask();
					var res = Ext.decode(response.responseText);
					if(res.success){
						Ext.example.msg('MSG',res.msg);
						thiz.reload();
					}else{
						Ext.Msg.alert('ERROR',res.msg);
					}						
				}
			});
	}
});
