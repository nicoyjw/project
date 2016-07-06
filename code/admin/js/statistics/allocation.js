Ext.ux.allocationGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
        this.createTbar();
        Ext.ux.allocationGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},this.fields)
    	});
	},
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },

    createTbar: function() {
		var first_shipping=this.first_shippingdata; 
		var db_shipping=this.db_shippingdata; 
		var depot_id_from=this.depot_id_fromdata;  
		var depot_id_to=this.depot_id_todata; 
		var store = this.store;
        this.tbar = ['渠道:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: first_shipping
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						hiddenName:'first_shipping',
						fieldLabel: '选择渠道',
						id: 'first_shipping',
						value:-1
					},'-','物流:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: db_shipping
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						hiddenName:'db_shipping',
						fieldLabel: '选择物流',
						id: 'db_shipping',
						value:-1
					},'-','发货仓:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: depot_id_from
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						hiddenName:'depot_id_from',
						fieldLabel: '选择发货仓',
						id: 'depot_id_from',
						value:-1
					},'-','到货库:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: depot_id_to
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						width:100,
						hiddenName:'depot_id_to',
						fieldLabel: '选择到货仓',
						id: 'depot_id_to',
						value:-1
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From'
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To'
					},'-',{
						xtype:'button',
						text:'统计',
						iconCls:'x-tbar-search',
						handler:function(){
							if((Ext.getCmp('depot_id_from').getValue()!=-1 || Ext.getCmp('depot_id_to').getValue()!=-1)&& Ext.getCmp('depot_id_from').getValue()==Ext.getCmp('depot_id_to').getValue()){
								Ext.example.msg('错误提示','调入仓和调出仓不能相同');
								return false;
							}
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								first_shipping:Ext.getCmp('first_shipping').getValue(),
								db_shipping:Ext.getCmp('db_shipping').getValue(),
								depot_id_from:Ext.getCmp('depot_id_from').getValue(),
								depot_id_to:Ext.getCmp('depot_id_to').getValue()
								}});
							}
					}];
    }
});