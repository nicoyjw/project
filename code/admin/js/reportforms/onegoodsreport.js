Ext.ux.RmaGrid = Ext.extend(Ext.ux.ComlGrid, {
    initComponent: function() {
        Ext.ux.RmaGrid.superclass.initComponent.call(this);
    },
	createColumns: function() {
        var cols = [new Ext.grid.RowNumberer({header:'序号',width:40}),{
						header: '日期',
						dataIndex: 'add_time',
						width:60
					},{
						header: '销售量',
						dataIndex: 'goods_sale',
						width:60
					},{
						header: '售价',
						dataIndex: 'goods_price',
						width:60
					}/*,{
						header: '重量',
						dataIndex: 'money',
						width:60
					}*/
					];
        this.columns = cols;
    },
	createTbar:function(){
        Ext.ux.RmaGrid.superclass.createTbar.call(this);
		this.tbar=new Array();
		var arr=[
				{
					xtype:'label',
					text: '销售帐户：',
					style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
				},
				{
					xtype:'combo',
					store: new Ext.data.JsonStore({
					fields: ['id','name'],
					data:  sales_account
					}),
					valueField :"id",
					displayField: "name",
					mode: 'local',
					editable: false,
					allowBlank: true,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'Sales_account',
					fieldLabel: '销售帐户',
					emptyText:'选择',
					name: 'Sales_account',
					id:'Sales_account'
				},				 
				{
					xtype:'label',
					text: '商品编号：',
					style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
				},
				{
					xtype:'textfield',
					name: 'goods_sn',
					allowBlank:false,
					blankText:'不能为空',
				},				 
				 {
					xtype:'label',
					text: '开始时间：',
					style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
				},
				{
					xtype:'datefield',
					name: 'starttime',
					format:'Y-m-d',
					editable: false,
					allowBlank:false,
					blankText:'不能为空',
					invalidText:'格式错误！'
				},
				{
					xtype:'label',
					text: '截止时间：',
					style:'font-size:12px;font-family:Arial, Helvetica, sans-serif'
				},
				{
					xtype:'datefield',
					name: 'endtime',
					format:'Y-m-d',
					editable: false,
					allowBlank:false,
					blankText:'不能为空',
					invalidText:'格式错误！'
				},				
				 {
					 text:'查询',
					 xtype:'button',
					 style:'margin-left:20px',
					 pressed:true,
					 handler: this.createScanWin.createDelegate(this)
				 }
				 ];
		var url=this.listURL;
		var form = new Ext.FormPanel({
									 id:'queryform',
									 layout: 'column',
									 columns:3,
									 border:false,
									 items:arr
									 });
		this.tbar.push(form)
	},
	createScanWin:function(){
		var form = Ext.getCmp("queryform").getForm();
		if(form.isValid()) {
			this.getStore().load({
				params:{start:0,limit:this.pagesize,Sales_account:form.findField('Sales_account').getValue(),goods_sn:form.findField('goods_sn').getValue(),starttime:form.findField('starttime').getValue().format('Y-m-d'),endtime:form.findField('endtime').getValue().format('Y-m-d')}
			});
		}
	},
	onBeforechange : function(_p, _o) {
		var form = Ext.getCmp("queryform").getForm();
		Ext.apply(_o, {
			Sales_account : form.findField('Sales_account').getValue(),
			goods_sn:form.findField('goods_sn').getValue(),			
			starttime     : form.findField('starttime').getValue().format('Y-m-d'),
			endtime:form.findField('endtime').getValue().format('Y-m-d')			
		});
		return true;
	}	
});