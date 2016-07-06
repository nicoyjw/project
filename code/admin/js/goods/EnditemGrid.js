Ext.define('Ext.ux.EnditemGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.autoHeight = true;
		this.autoScroll = true;
		this.frame = true;
        this.stripeRows = true;
		this.loadMask = true;
		this.pagesize = 15;
		this.plugins=[Ext.create('Ext.grid.plugin.CellEditing', {
	        clicksToEdit: 1
	    })];
        this.createStore();
		this.createTbar();
        this.createBbar();
		this.creatGridsm();
        this.createColumns();
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			remoteSort:true,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
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
			Ext.apply(
			this.baseParams,
			{
				account:Ext.getCmp('account').getValue(),
				goods_sn:Ext.getCmp('goods_sn').getValue()
			});
		});
	},
	creatGridsm:function(){
		this.selModel = Ext.create('Ext.selection.CheckboxModel',{});
	},
    createColumns: function() {
		var ds = this.store;
		var sm = this.selModel;
		this.columns = [{
            header: '图片',
            dataIndex: 'GalleryURL',
            width:85,
            renderer: function(v) {
                return '<img src="' + v + '" width=50 height=50>';
            }
        },{   header: 'ItemID',
            dataIndex: 'ItemID',
            width:105,
        },{   header: 'Title',
            dataIndex: 'Title',
            width:205,
            renderer: function(v, x, rec) {
                return '<a href="http://item.ebay.com/' + rec.get('ItemID') + '" target="_blank" title="' + v + '">' + v + '</a>';
            }
        },{   header: 'SKU',
            dataIndex: 'SKU',
            sortable: true,
            width:105,
        },{   header: 'Startprice',
            dataIndex: 'StartPrice',
            width:105,
            editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },{	header: 'Quantity',
            dataIndex: 'Quantity',
            width:105,
            editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },{
            header: 'ListingType',
            dataIndex: 'ListingType',
            width:105,
        },{
            header: '账号',
            dataIndex: 'account_id',
            width:105,
        },{
            header: '是否更改',
            dataIndex: 'is_need',
            width:105,
        },{
			header:'操作',
            width:105,
			xtype: 'actioncolumn',
			items:[{
				icon   : 'themes/default/images/update.gif',	 
				tooltip: '更新listing',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					Ext.Msg.confirm('Update Alert!', 'Are you sure to update this item listing?', function(btn) {
						if (btn == 'yes') {
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							var id = ds.getAt(rowIndex).get('rec_id');
							Ext.Ajax.request({
							   url: 'index.php?model=goods&action=updateitem&id='+id,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
									Ext.getBody().unmask();
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										}else{
										Ext.Msg.alert('ERROR',res.msg);
										}						
									}
								});
						}
					},this)
				}
			},{
				icon   : 'themes/default/images/delete.gif',	 
				tooltip: '下架产品',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					Ext.Msg.confirm('Delete Alert!', 'Are you sure to end this item from Ebay?', function(btn) {
						if (btn == 'yes') {
							var id = ds.getAt(rowIndex).get('rec_id');
							Ext.Ajax.request({
							   url: 'index.php?model=goods&action=enditem&id='+id,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										}else{
										Ext.Msg.alert('ERROR',res.msg);
										}						
									}
								});
						}
					},this)
				}
			}]
		}];
    },

    createTbar: function() {
		var pagesize = this.pagesize;
		var store = this.store;
		var saveURL=this.saveURL;
		var account = this.accountdata;
        this.tbar = ['SKU',{
			id:'goods_sn',
			width:150,
			xtype:'textfield'
		},'-',{
			xtype:'combo',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			editable: false,
			width:250,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'saccount',
			fieldLabel: '选择账户',
			id: 'account',
			value:0
		},'-',{
			xtype:'button',
			text:'搜索',
			iconCls:'x-tbar-search',
			handler:function(){
				store.load({params:{
					account:Ext.getCmp('account').getValue(),
					goods_sn:Ext.getCmp('goods_sn').getValue(),
					start:0,
					limit:pagesize
					}
				});
			}
		},'-', {
			icon: 'themes/default/images/save.gif',
			pressed: false,
			enableToggle: true,
			text: '保存修改',
			handler: function(){
				var m=store.getModifiedRecords().slice(0);
				if(!m || m=='' ){
					Ext.example.msg('警告','未进行修改，请先修改listing价格或数量！');
					return false;
				}
				var jsonArray=[];
				Ext.each(m,function(item){
				   jsonArray.push(item.data);
				});
				Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
				Ext.Ajax.request({
					url:saveURL,
					loadMask:true,
					params:{'data':Ext.encode(jsonArray)},
					success:function(response,opts){
						var res=Ext.decode(response.responseText);
						Ext.getBody().unmask();
						if(res.success){
							store.commitChanges();
							store.load();
							Ext.example.msg('MSG',res.msg);
						}else{
							Ext.example.msg('ERROR',res.msg);
						}
					}
				});
			}
		}];
    },
    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar =[{
			xtype: 'pagingtoolbar',
			plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:['-',{
			   text:'批量更新listing',
			   pressed:true,
			   handler:this.edititem.bind(this)
		   }]				   
        }];
    },
	edititem:function(){
		var ids = Ext.getCmp('account').getValue();
		if(!ids) {Ext.example.msg('提示','请先选择需要修改账号');return false;}
		var thiz = this.store;
		Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
		Ext.Ajax.request({
			url:this.editURL+'&accountid='+ids,
			success:function(response){
				var res=Ext.decode(response.responseText);
				Ext.getBody().unmask();
				if(res.success){
					thiz.load();
					Ext.example.msg('MSG',res.msg);
				}else{
					Ext.example.msg('ERROR',res.msg);
				}
			},
			failure:function(response){
				Ext.example.msg('警告','批量修改');
				Ext.getBody().unmask();
			},
			params:{id:ids}			 
		});
	}
});

