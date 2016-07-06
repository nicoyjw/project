Ext.ux.PlanGrid = Ext.extend(Ext.grid.EditorGridPanel, {
	initComponent: function() {
		this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.loadMask=true;
        this.createStore();
		this.creatSupplierstore();
        this.createTbar();
		this.createBbar();
		this.createColumns();
        Ext.ux.PlanGrid.superclass.initComponent.call(this);
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
    createStore: function() {
        this.store = new Ext.data.Store({
			proxy : new Ext.data.HttpProxy({url:this.listURL}),
			remoteSort: true,
			reader: new Ext.data.JsonReader({
				root: 'topics',
				totalProperty: 'totalCount',
				id: this.fields[0]
				},this.fields)
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				supplier_id:Ext.getCmp('supplierid').getValue()
			});
		});
    },
    createTbar: function() {
		var store = this.store;
		var depot = this.depot;
		var listURL =this.listURL;
		var submiturl=this.saveURL;
		var planBySupplierURL=this.planBySupplierURL;
		var pagesize=this.pagesize;
        this.tbar = [{xtype:'combo',
				store:this.Supplierstore,
				valueField:"id",
				displayField:"name",
				mode:'remote',
				width:100,
				forceSelection:true,
				triggerAction:'all',
				hiddenName:'supplier_id',
				fieldLabel:'选择供应商',
				allowBlank:false,
				pageSize:30,
				minListWidth:220,
				id:'supplierid',
				listeners:{
					beforequery:function(qe){
						qe.combo.store.on('beforeload',function(){Ext.apply(this.baseParams,{key:qe.query});
					});
					qe.combo.store.load();
				}}
			},'-',{text:'查找',
				iconCls:'x-tbar-search',
				handler:function(){
					var supplierid=Ext.getCmp('supplierid').getValue();
					if(!supplierid){
						Ext.example.msg('警告','请选择供应商！');
						return false;
					}
					if(supplierid){
						store.load({params:{start:0,limit:pagesize,supplier_id:supplierid}});
					}
				}
			},'-',{text:'保存',
				iconCls:'x-tbar-save',
				handler:function(){
					var supplierid=Ext.getCmp('supplierid').getValue();
					if(!supplierid){
						Ext.example.msg('警告','请选择供应商！');
						return false;
					}
					
			   		var m=store.modified.slice(0);
			  		if(!m || m=='' ){
						Ext.example.msg('警告','未有修改，请先修改产品建议采购量！');
						return false;
					}
					
					var jsonArray=[];
					Ext.each(m,function(item){
					   jsonArray.push(item.data);
					});
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
						url:submiturl,
						loadMask:true,
						params:{'data':Ext.encode(jsonArray),'supplier_id':supplierid},
						success:function(response,opts){
							var res=Ext.decode(response.responseText);
							Ext.getBody().unmask();
							if(res.success){
								store.commitChanges();
								store.reload();
								Ext.example.msg('MSG',res.msg);
							}else{
								Ext.example.msg('ERROR',res.msg);
							}
						}
					});
				}
			},'-',{text:'生成该供应商采购单',
				iconCls:'x-tbar-add',
				handler:function(){
					var supplierid=Ext.getCmp('supplierid').getValue();
					if(!supplierid){
						Ext.example.msg('警告','请选择供应商！');
						return false;
					}
					var m=store.modified.slice(0);
			  		var jsonArray=[];
					Ext.each(m,function(item){
					   jsonArray.push(item.data);
					});
					if(jsonArray.length>0){
						Ext.example.msg('警告','请将修改的数据保存！');
						return false;
					}
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
						url:'index.php?model=purchaseorder&action=saveOrder',
						loadMask:true,
						params:{'supplier_id':Ext.getCmp('supplierid').getValue()},
						success:function(response,opts){
							var res=Ext.decode(response.responseText);
							Ext.getBody().unmask();
							if(res.success){
								Ext.example.msg('MSG',res.msg);
							}else{
								Ext.example.msg('ERROR',res.msg);
							}
						}
					});
				}
		}];
    },
	
	createColumns: function() {
		this.columns = [
			new Ext.grid.RowNumberer(),
			{header:'产品图片',dataIndex:'goods_img',width:170,renderer:function(v){return(v)?"<a href='"+v+"' target=_blank><img src='"+v+"' width=100></a>":'';}},
			{header:'产品编码',dataIndex:'goods_sn',sortable: true,
				renderer:function(val,x,rec){
				var str = (rec.get('is_no_auto') == '1')? '<font style="color:red">'+val+'</font>' : val;
				return str;
			   }},
			{header:'产品名称',dataIndex:'goods_name',width:150,sortable: true},
			{header:'SKU',dataIndex:'SKU',sortable: true},
			{header:'供应商价格',dataIndex:'supplier_goods_price',width:100,sortable: true},
			{header:'库存数量',dataIndex:'goods_qty',sortable: true},
			{header:'锁定库存',dataIndex:'varstock',sortable: true},
			{header:'销售需求',dataIndex:'sold_qty',sortable: true},
			{header:'报警库存',dataIndex:'warn_qty',sortable: true},
			{header:'采购在途',dataIndex:'Purchase_qty',sortable: true},
			{header:'日均销量',dataIndex:'per_sold',sortable: true},
			{header:'采购周期',dataIndex:'period',sortable: true},
			{header:'建议采购',dataIndex:'plan_qty',width:150,sortable: true,editor:new Ext.form.NumberField({allowNegative:false,hideLabel:true})},
			{header:'其他',dataIndex:'comment',sortable: true}];
    },
	createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			plugins:new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
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

