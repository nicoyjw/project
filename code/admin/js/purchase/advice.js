Ext.ux.PlanGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.stripeRows = true;
        this.autoWidth = true;
        this.viewConfig = {
            forceFit: true
        };
		this.loadMask=true,
        this.createStore();
        this.createTbar();
		this.createBbar();
		this.createColumns();
        Ext.ux.PlanGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		});
    },
    createTbar: function() {
		var store = this.store;
		var depot = this.depot;
		var listURL =this.listURL;
        this.tbar = [{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: depot
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					editable: false,
					name:'depot_id',
					forceSelection: true,
					hiddenName:'depot_id',
					triggerAction: 'all',
					fieldLabel: '仓库',
					allowBlank:false,
					pagesise:10,
					width:180,
					labelWidth:35,
					value:'999',
					id:'depot'							
					},{
            text: '初始化采购计划',
            iconCls: 'x-tbar-update',
            handler: function(){
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=purchaseorder&action=initplan&depot='+Ext.getCmp('depot').getValue(),
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
		},{
            text: '导出',
            iconCls: 'x-tbar-add',
            handler: function(){
				window.open(listURL+'&type=export');
				}
        }];
    },
	
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
				sortable: true,
                dataIndex: f,
				flex:1
            });
        }
        this.columns = cols;
    },

    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:[
			]
        });
    },

    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelections()[0];
        }
    }
});

