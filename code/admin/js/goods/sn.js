Ext.define('Ext.ux.SnGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent(this);
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			id: 'editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        },'->','SKU:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								this.store.load({params:{start:0, limit:10,
									keyword:Ext.getCmp('keyword').getValue()
									}});
								}
							}
						}
					}];
    }
});

