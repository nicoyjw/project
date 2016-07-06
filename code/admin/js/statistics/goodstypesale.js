Ext.ux.goodstypesaleGrid=Ext.extend(Ext.grid.GridPanel,{
	initComponent:function(){
		this.autoHeight = true;
        this.viewConfig = {
            forceFit: true
        };
		this.createStore();
		this.creatBbar();
		this.createTbar();
		this.createColumns();
		Ext.ux.goodstypesaleGrid.superclass.initComponent.call(this);
	},
	createStore:function(){
		this.store = new Ext.data.Store({
		remoteSort:true,
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount'
			},this.fields)
    	});
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){Ext.apply(this.baseParams,{
								goods_sn:Ext.fly('goods_sn').dom.value,
								cat_id:Ext.fly('cat_id').dom.value,
								starttime:Ext.fly('starttime').dom.value,
								Sales_account:Ext.getCmp('Sales_account').getValue(),
								totime:Ext.fly('totime').dom.value
		});});},
	createColumns: function() {
        var cols = [new Ext.grid.RowNumberer(),{
						header: '日期',
						dataIndex: 'times',
						width:60
					},{
						header: '总销售额',
						dataIndex: 'goods_price',
						width:60
					},{
						header: '销量',
						dataIndex: 'goods_sale',
						width:60
					},{
						header: '总成本',
						dataIndex: 'costs',
						width:60
					},{
						header: '总利润',
						dataIndex: 'profit',
						width:60
					}];
        this.columns = cols;
    },
	createTbar:function(){
        var pagesize = this.pagesize;
		var afterselect=this.afterselect;
		var listURL=this.listURL;
		var store = this.store;
        this.tbar = ['销售帐户:',{xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: this.sales_account
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:120,
						editable: false,
						forceSelection: true,
						allowBlank: true,
						emptyText:'选择',
						triggerAction: 'all',
						hiddenName:'Sales_account',
						id: 'Sales_account'
					},'-','所属分类:',new Ext.form.TriggerField({
							editable:false,
							fieldLabel:'所属分类',
							xtype:'trigger',
							id:'cat_name',
							width:120,
							onSelect:function(record){},
							onTriggerClick:function(){
								getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',0,afterselect);
							}}),{xtype:'hidden',id:'cat_id',value:0}
					,'-','产品编码:',{
						id:'goods_sn',
						width:80,
						xtype:'textfield'
					},'-','开始时间:',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						fieldLabel:'From',
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！',
						value:new Date()
					},'-','结束时间:',{
						xtype:'datefield',
						id:'totime',
						format:'Y-m-d',
						fieldLabel:'To',
						allowBlank:false,
						blankText:'不能为空',
						invalidText:'格式错误！',
						value:new Date()
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								goods_sn:Ext.fly('goods_sn').dom.value,
								cat_id:Ext.fly('cat_id').dom.value,
								Sales_account:Ext.getCmp('Sales_account').getValue(),
								starttime:Ext.fly('starttime').dom.value,
								totime:Ext.fly('totime').dom.value,
								start:0,
								limit:pagesize
								}});
							}
					},'-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href='index.php?model=statistics&action=exportGoodsTypeSale'+'&goods_sn='+Ext.fly('goods_sn').dom.value+'&cat_id='+Ext.fly('cat_id').dom.value+'&Sales_account='+Ext.getCmp('Sales_account').getValue()+'&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
						}
	 				}];
	} ,
	 
	creatBbar: function() {
		var	pagesize = this.pagesize;
       	this.bbar=new Ext.PagingToolbar({
			plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			store: this.store,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据"
        });
    },
	afterselect:function(k,v){
			Ext.getCmp('cat_name').setValue(v);
			Ext.getCmp('cat_id').setValue(k);
		}
	});
	