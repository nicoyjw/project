Ext.define('Ext.ux.UserGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
		var ds = this.store;
        var cols = [{xtype:'rownumberer'},{
						header: '用户名',
						flex:1,
						dataIndex: 'user_name'
					},{
						header: 'Email',
						flex:1,
						dataIndex: 'email'
					},{
					header: '角色',
					dataIndex: 'role_id',
					flex:1,
					renderer:this.renderers
					},{
				  header:'操作',
				  width:45,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑权限',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('user_id');
							parent.openWindow(id,'编辑权限','index.php?model=privilege&action=eidtpriv&userid='+id,1100,450);
							//alert("编辑 " + rec.get('order_id'));
						}
						 }]
				  }];
        this.columns = cols;
    }
});