Ext.define('Ext.ux.OrderstatusEditor',{
	extend:'Ext.ux.NormalEditor',
    initComponent: function() {
        this.callParent(this);
    },
	
	createColumns: function() {
	var cols = [];
	cols.push({xtype: 'rownumberer'});
	for (var i = 1; i < this.fields.length; i++) {
		var f = this.fields[i];
		var h = this.headers[i];
		var e = this.editors[i];
		var r = this.renderers[i];
		cols.push({
			header: h,
			dataIndex: f,
			flex:1,
			renderer:r,
			editor:e
		});
	}
	this.columns = cols;
}
});

