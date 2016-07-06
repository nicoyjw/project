Ext.define('Ext.ux.LanguageGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: 'name',
						flex:1,
						dataIndex: 'name'
					},{
						header: 'code',
						flex:1,
						dataIndex: 'code'
					},{
						header: '排序',
						flex:1,
						dataIndex: 'sort_order'
					},{
						header: '是否活动',
						flex:1,
						dataIndex: 'is_active',
						renderer:function(v){return (v == 0)?'否':'是';}
					}];
        this.columns = cols;
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
			hide:true,
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'editBtn',
			hide:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			id:'removeBtn',
			hide:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	createFormtiems:function(){
		var getSelect = this.getSelectionModel().getSelection();
		if(getSelect){
			var is_active = 1;
		}else{
			var is_active = 0;
		}
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		}
					,{
						fieldLabel: 'name',
						xtype:'textfield',
						allowNegative:false,
						allowDecimals:true,
						decimalPrecision:5,
						allowBlank:false,
						name:'name'
					}
					,{
						fieldLabel: 'code',
						xtype:'textfield',
						allowNegative:false,
						allowDecimals:true,
						decimalPrecision:5,
						allowBlank:false,
						name:'code'
					},{
						fieldLabel: '排序',
						xtype:'numberfield',
						allowNegative:false,
						allowDecimals:true,
						decimalPrecision:5,
						allowBlank:false,
						name:'sort_order'
					},{xtype :'combo',
						store : Ext.create('Ext.data.ArrayStore',{
							fields:["appkey","account"],
							data:[['1','是'],['0','否']]}),
							valueField:"appkey",
							displayField:"account",
							mode:'local',
							editable:false,
							forceSelection:true,
							triggerAction:'all',
							value: is_active,
							width:100,
							allowBlank:false,
							hiddenName:'is_active',
							fieldLabel:'是否活动',
							id:'is_active'
								}];	
		this.formitem = items;
	}
});
