Ext.ux.StcokGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
		this.creatSupplierstore();
        this.createColumns();
        this.createTbar();
		this.CreatBbar();
		var Item = Ext.data.Record.create([{
			id:'supplier_id',
			name:'supplier_name'
		}]);	
		this.Supplierstore.add(new Item({id:0,name:'所有供应商'}));
        Ext.ux.StcokGrid.superclass.initComponent.call(this);
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
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								depot:Ext.getCmp('depot_id').getValue(),
								supplier1:Ext.fly('supplier').dom.value,
								supplier2:Ext.fly('Sales_channels').dom.value,
								type:Ext.getCmp('stype').getValue(),
								num:Ext.fly('num').dom.value,
								goods_sn:Ext.fly('goods_sn').dom.value
			});
		});
	},
	creatSupplierstore:function(){//供应商明细store
		this.Supplierstore = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.listSupplierURL}),
			reader: new Ext.data.JsonReader({
					root: 'topics',
					totalProperty: 'totalCount',
					id: 'id'
					},['id','name'])
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
		var pagesize = this.pagesize;
		var store = this.store;
        this.tbar = ['产品编码',{
						id:'goods_sn',
						width:50,
						xtype:'textfield'
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From',
						value:new Date()
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To',
						value:new Date()
					},'-',{
								xtype:'combo',
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data: this.depot
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:130,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'depot',
								allowBlank:false,
								fieldLabel: '仓库',
								value:'',
								id:'depot_id'
					},'-','出入库:',{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["key", "key_type"],
							 data: [[1, '出库'], [2, '入库']]
						}),
						valueField :"key",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						width:80,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'stocktype',
						fieldLabel: '选择出入库',
						id: 'stype',
						name:'stocktype',
						value:1,
									listeners: {
										change:function(field,e){
												if(field.getValue() == 1){
													Ext.getCmp('supplier').hide();
													Ext.getCmp('Sales_channels').show();
													}else{
													Ext.getCmp('supplier').show();
													Ext.getCmp('Sales_channels').hide();
												}
											}
										}
					},{
								xtype:'combo',
								store: this.Supplierstore,
								valueField :"id",
								displayField: "name",
								mode: 'remote',
								width:100,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'supplier1',
								fieldLabel: '供应商',
								allowBlank:false,
								value:0,
								pageSize:30,
								minListWidth:220,
								id:'supplier',
									listeners: {
										beforequery:function(qe){
											qe.combo.store.on('beforeload',function(){
												Ext.apply(
												this.baseParams,
												{
													key:qe.query
												});
												});
												qe.combo.store.load();
											}
										}
								
							},{
								xtype:'combo',
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data: this.Sales_channels
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:130,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'supplier2',
								allowBlank:false,
								value:0,
								fieldLabel: '渠道',
								id:'Sales_channels'
							},'-','数量大于:',{
						xtype:'numberfield',
						allowBlank:false,
						width:30,
						id:'num',
						allowNegative:false
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								type:Ext.getCmp('stype').getValue(),
								num:Ext.fly('num').dom.value,
								depot:Ext.getCmp('depot_id').getValue(),
								supplier1:Ext.getCmp('supplier').getValue(),
								supplier2:Ext.getCmp('Sales_channels').getValue(),
								goods_sn:Ext.fly('goods_sn').dom.value,
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						xtype:'button',
						text:'导出搜索',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href = 'index.php?model=Statistics&action=exportstock&goods_sn='+Ext.fly('goods_sn').dom.value+'&depot='+Ext.getCmp('depot_id').getValue()+'&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value+'&type='+Ext.getCmp('stype').getValue()+'&num='+Ext.fly('num').dom.value+'&supplier1='+Ext.fly('supplier').dom.value+'&supplier2='+Ext.fly('Sales_channels').dom.value;
							}
					}];
    },
	
	CreatBbar:function(){
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
	}
});

