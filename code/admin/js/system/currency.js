Ext.define('Ext.ux.CurrencyGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },	
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '币种',
						flex:1,
						dataIndex: 'currency'
					},{
						header: '汇率',
						flex:1,
						dataIndex: 'rate'
					}];
        this.columns = cols;
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			id:'removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }, {
            text: '自动更新汇率',
            iconCls: 'x-tbar-update',
			ref: '../ajaxBtn',
            handler: this.ajaxRecord.bind(this)
        }];
    },

    ajaxRecord: function() {
		var thiz = this.store;
            Ext.Msg.confirm('Update Alert!', 'Are you sure to get the rate automatically?', function(btn) {
                if (btn == 'yes') {
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: this.ajaxURL,
					   timeout:180000,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								thiz.reload();
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
    },


	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
						fieldLabel: '币种',
						xtype:'textfield',
						vtype:'alpha',
						labelWidth:65,
						width:250,
						minLength:3,
						maxLength:5,
						name:'currency'
					},{
						fieldLabel: '汇率',
						xtype:'numberfield',
						labelWidth:65,
						width:250,
						allowNegative:false,
						allowDecimals:true,
						decimalPrecision:5,
						allowBlank:false,
						name:'rate'
					}];	
		this.formitem = items;
	}
});
