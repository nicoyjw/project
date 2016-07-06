Ext.define('Ext.ux.OutdepotGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.autoHeight = true;
		this.autoWidth = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.loadMask = true;
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
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
		})
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				account:Ext.getCmp('account').getValue()
			});
		});
	},
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
						header: '产品图片',
						flex:3,
						dataIndex: 'goods_img',
						renderer:function(val){
								return "<img src='"+val+"' width=100 height=100>";
							}
					},{
						header: '产品编码',
						flex:2,
						sortable:true,
						dataIndex: 'goods_sn'
					},{
						header: '产品名',
						flex:3,
						dataIndex: 'goods_name'
					},{
						header: '库存位置',
						flex:1,
						dataIndex: 'stock_place'
					},{
						header: '申请出库量',
						flex:1,
						dataIndex: 'out_qty'
					},{
						header: '实际库存量',
						flex:1,
						dataIndex: 'goods_qty',
						renderer:function(val,x,rec){
					   		return ((rec.get('goods_qty') < rec.get('out_qty')) && rec.get('is_control') == 1)?'<b><font color=red>'+val+'</font></b>':val;
							}
					}];
        this.columns = cols;
    },
	createTbar: function() {
			var account = this.accountdata;
			var depot = this.depot;
			var store = this.store;
			this.tbar = [{
						text: '申请出库',
						iconCls: 'x-tbar-import',
						handler: this.createRecord.bind(this)
						 },'->',{
						xtype:'combo',
						store:Ext.create('Ext.data.ArrayStore',{
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
						hiddenName:'account',
						fieldLabel: '选择账户',
						id: 'account',
						value:'0'
					},'-',{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: depot
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:250,
						labelWidth:75,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'depot',
						fieldLabel: '选择仓库',
						id: 'depot',
						value:'0'
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{account:Ext.getCmp('account').getValue(),depot:Ext.getCmp('depot').getValue()}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=order&action=exportoutdepot&account='+Ext.getCmp('account').getValue()+'&depot='+Ext.getCmp('depot').getValue();
							}
					}];
	},
	createBbar: function() {
			this.bbar = Ext.create('Ext.toolbar.Paging',{
				pageSize: 15,
				displayInfo: true,
				displayMsg: '第{0} 到 {1} 条数据 共{2}条',
				emptyMsg: "没有数据",
				store: this.store
			});
	},
	createRecord:function(){
		if(!Ext.getCmp('account').getValue()) {
			Ext.example.msg('Error','请先选择一个账号搜索需要出库的产品');return false;
		}
		var thiz = this.store;
		if(thiz.getCount() == 0)  {
			Ext.example.msg('Error','没有需要出库的产品');return false;
		}
		/*for(var i=0;i<this.store.getCount();i++){
				var rec = this.store.getAt(i);
				if((rec.get('goods_qty') < rec.get('out_qty')) && rec.get('is_control') == 1){
						Ext.example.msg('库存条件不满足无法执行出库单操作');return false;
					}
			}*/
			Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
				Ext.Ajax.request({
					   url: this.outdepotURL,
					   timeout: 600000,
						success:function(response,opts){
							Ext.getBody().unmask();
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								thiz.load();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
	}
});
