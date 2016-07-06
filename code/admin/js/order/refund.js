Ext.define('Ext.ux.refundView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
		//this.getTab();
		//this.tab.getItem(0).setDisabled(true);
        this.callParent(this);
    },
	addcolumns:function(){
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
					   text:'退款成功',
					   pressed:true,
					   handler:this.updatestatus.bind(this,['1'])
					   }]				   
        });
    }
});

