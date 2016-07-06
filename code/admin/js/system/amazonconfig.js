Ext.define('Ext.ux.AmazonGrid',{
	extend:'Ext.ux.NormalGrid',	
	createColumns: function() {
		var data = this.arrdata;
        var cols = [{xtype:'rownumberer'},{
						header: '账号',
						dataIndex: 'account_id',
						flex:1,
						renderer:function(v){return comrender(v,data[0]);}
					},{
						header: 'Schedule类型',
						dataIndex: 'ReportType',
						flex:1,
						renderer:function(v){return comrender(v,data[1]);}
					},{
						header: '时间周期',
						dataIndex: 'Schedule',
						flex:1,
						renderer:function(v){return comrender(v,data[2]);}
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
			id:'editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'removeBtn',
			ref: '../removeBtn',
			hidden:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	createFormtiems:function(){
		var data = this.arrdata;
        var items = [{
				xtype:'hidden',
				name: this.fields[0]
			},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: data[0]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'account_id',
				fieldLabel: '账号',
				name: 'account_id',
				allowBlank:false
			},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: data[1]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'ReportType',
				fieldLabel: 'Schedule类型',
				name: 'ReportType',
				allowBlank:false
			},{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: data[2]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'Schedule',
				fieldLabel: '时间周期',
				name: 'Schedule',
				allowBlank:false
			}];	
		this.formitem = items;
	}
});
