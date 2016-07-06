Ext.define('Ext.ux.allorderView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
        this.callParent(this);
    },
	addcolumns:function(){
		var ds = this.store;
		this.columns.push({
			header:'操作',
			width:45,
			xtype: 'actioncolumn',
			items:[{
				icon   : 'themes/default/images/update.gif',	 
				tooltip: '编辑订单',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('order_id');
					parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
				}
			},{
				icon   : 'themes/default/images/del.gif',	 
				tooltip: '解锁订单',
				handler: function(grid, rowIndex, colIndex) {
					Ext.Msg.confirm('Unlock Alert!', '确定订单产品解锁库存锁定?', function(btn) {
						if (btn == 'yes') {
							Ext.getBody().mask("正在进行解锁.请稍等...","x-mask-loading");
							var id = ds.getAt(rowIndex).get('order_id');
							Ext.Ajax.request({
								url: 'index.php?model=order&action=unlockorder&id='+id,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
									Ext.getBody().unmask();
									if(res.success){
										ds.load();
										Ext.example.msg('MSG',res.msg+'订单状态已被退回库管审核');
									}else{
										Ext.example.msg('ERROR',res.msg);
									}						
								}
							});
						}
					},this)
				}
			 }]
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
    }
});

