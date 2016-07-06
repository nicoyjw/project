Ext.define('Ext.ux.depotmanagerView',{
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
            store: this.store,
			items:['-',{
				text:'审核通过',
				pressed:true,
				handler:this.updatestatus.bind(this,['1'])
			},'-',{
				text:'退回',
				pressed:true,
				handler:this.updatestatus.bind(this,['3'])
			}]				   
        });
    }
});

