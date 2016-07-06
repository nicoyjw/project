Ext.ux.SkuGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
        Ext.ux.SkuGrid.superclass.initComponent.call(this);
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        },
        {
            text: '清空',
            iconCls: 'x-tbar-del',
            id: 'delBtn',
            ref: '../delBtn',
            handler: function(){
				Ext.getBody().mask("Delete Data .waiting...","x-mask-loading");
				Ext.Ajax.request({
				   url: 'index.php?model=goods&action=skudel&type=empty',
				   loadMask:true,
				   success:function(response,opts){
						var res = Ext.decode(response.responseText);
						Ext.getBody().unmask();
							if(res.success){
							Ext.example.msg('MSG',res.msg);
							store.reload();
							}else{
							Ext.Msg.alert('ERROR',res.msg);
							}						
						}
					});
			}
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
									keyword:Ext.get('keyword').dom.value
									}});
								}
							}
						}
					}];
    }
});

