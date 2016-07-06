Ext.define('Ext.ux.depotmanagerView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
        this.callParent(this);
    },
	creatgrid:function(){
		var cm =this.columns;
		var bbar = this.creatBbar();
		var tbar = this.creatTbar();
		this.grid = Ext.create('Ext.grid.Panel',{
			loadMask:true,
			frame:false,
			height: 400,
			viewConfig:{
				forceFit: true
			},
			plugins:[Ext.create('Ext.grid.plugin.CellEditing', {
				clicksToEdit: 1
			})],
			region:'center',
			store: this.store,
			columns: cm,
			selModel:this.sm,
			tbar:tbar,
			bbar:bbar
   		 });
	},
	addcolumns:function(){
		var ds = this.store;
		this.columns.push({
				  header:'操作',
				  width:50,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
						}
						 }]
				  });
	},
	creatTbar:function(){
		var store = this.store;
		var pagesize = this.pagesize;
		var step = this.step;
		return Ext.create('Ext.toolbar.Toolbar',{
			items:['<b></b>',
				   '->','Order Number:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						width:125
					},'-',{
						xtype:'button',
						text:'Search',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
								keyword:Ext.getCmp('keyword').getValue()
								}});
							}
					},'-',{
						xtype:'button',
						text:'Advanced Search',
						iconCls:'x-tbar-advsearch',
						handler:this.showWindow.bind(this)
					},'-',{
						xtype:'button',
						text:'Export Orders',
						iconCls:'x-tbar-import',
						handler:function(){
							var values = Ext.getCmp('searchform').getForm().getFieldValues();
							//if(values.totime) values.totime = values.totime.format('Y-m-d');
							//if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
							window.open().location.href = 'index.php?model=order&action=exportorder&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();

							}
					}
				]			   				   
		});	 
	},
	creatBbar: function() {
		var	pagesize = this.pagesize;
		var templatelist = this.templatelist;
		var thiz = this;
       return Ext.create('Ext.toolbar.Paging',{
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '{0} - {1}  Total : {2} ',
			emptyMsg: "empty",
            store: this.store,
			items:['-',{
					   text:'Approved',
					   pressed:true,
					   handler:this.updatestatus.bind(this,['1'])
					   }]				   
        });
    },
	update4px:function(type){
		var ids = getIds(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		//alert(ids);return;
		var mk = new Ext.LoadMask(Ext.getBody(), {
			msg: '正在更新数据，请稍候！',
			removeMask: true //完成后移除
			});
		mk.show(); 
		Ext.Ajax.request({
			timeout:180000,
			url:'index.php?model=order&action=geraupostno',
			loadMask:true,
					success:function(response){
						Ext.Msg.alert('Prompt',response.responseText);
						thiz.load();
						mk.hide();
						},
					failure:function(response){
						var reqst=response.status;
						if(reqst=='-1'){ 
							thiz.load();
							Ext.example.msg('警告','交运超时退出');
						}else{
							Ext.example.msg('警告','交运失败');
						}
						mk.hide();
						},
			params:{id:ids}			 
		});
	},
	updatetrack:function(){
		var m = this.store.getModifiedRecords().slice(0);
		if(m.length==0) return false;
		var jsonArray = [];
		Ext.each(m,function(item){
			var moddata =new Object();
			moddata.order_id = item.data.order_id;
			moddata.track_no = item.data.track_no;
			jsonArray.push(moddata);				
			});
		var thiz = this.store;
		Ext.getBody().mask("正在保存追踪单号.请稍等...","x-mask-loading");
		Ext.Ajax.request({
					url:'index.php?model=order&action=updatetrackno',	 
					method:'POST',
					params:{'data':Ext.encode(jsonArray)},
					success:function(response,opts){
						Ext.getBody().unmask();
							var res = Ext.decode(response.responseText);
							if(res.success){
							Ext.Msg.alert('MSG',res.msg);
							thiz.commitChanges();
							}else{
							Ext.Msg.alert('MSG',res.msg);
							}
						},
					failure:function(){
							Ext.example.msg('MSG','保存失败'),
							thize.rejectChanges();
						}
				})	
	}
});

