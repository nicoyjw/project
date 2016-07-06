Ext.define('Ext.ux.AttrGroupGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
		this.creatselectionmodel();
        this.callParent();
    },
    createStore: function() {
    	this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			autoLoad:true,
			pageSize:this.pagesize,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		});
		this.store.on('beforeload',function(){
			Ext.apply(this.baseParams,{});
		});
	},
	createColumns: function() {
        var cols = [{
			xtype: 'rownumberer',width:30
		},{
			header: '属性组名123称',
			dataIndex: 'attribute_group_name'
		}/*,{
			header: '排序',
			dataIndex: 'sort_order',
			width:80
		}*/];
        this.columns = cols;
		var ds = this.store;
		cols.push({
			header:'操作1',
			width:45,
			xtype: 'actioncolumn',
			items:[{
				icon: 'themes/default/invalid.gif',	 
				tooltip: '编辑属性',
				handler: function(grid, rowIndex, colIndex) {
					
					var id = ds.getAt(rowIndex).get('attribute_set_id');
					var group_id = ds.getAt(rowIndex).get('attribute_group_set_id');
					var name = ds.getAt(rowIndex).get('attribute_group_name');
					//alert(id);return;
					parent.openWindow(id,'编辑'+name+'属性','index.php?model=attribute&action=edit&id='+id+'&group_id='+group_id,400,450);
				}
			}]
		});
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
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
            id: 'removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	creatselectionmodel:function(){
    	var button = this.tbar;
		var sm = Ext.create('Ext.selection.RowModel',{
			mode: 'SINGLE',
			listeners:{
				"select":function(sel,record,index){
				    Ext.getCmp('editBtn').setDisabled(false);
					Ext.getCmp('removeBtn').setDisabled(false);
				}
			}								 
		});
		this.selModel = sm;
	},
	createFormtiems:function(){
		this.formitem = [{
			xtype:'hidden',
			name: 'attribute_group_set_id'
		},{
			xtype:'textfield',
			padding: '10px',
			name:'attribute_group_name',
			width:250,
			fieldLabel:'属性组名称'
		}/*,{
			name:'sort_order',
			width:180,
			fieldLabel:'排序'
		}*/];
		
	}
});

