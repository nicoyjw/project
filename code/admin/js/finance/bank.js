Ext.define('Ext.ux.bankGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
		this.creatBbar();
		this.createTbar();
		this.createStore();
		this.createColumns();
        this.callParent(this);
    },
	createStore:function(){
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		})
		this.store.load({
			params:{start:0,limit:this.pagesize},
			scope:this.store
			});
		this.store.on('beforeload',function(){Ext.apply(this.baseParams);});},
	createTbar:function(){
		var listURL=this.listURL;
		var store=this.store;var pagesize=this.pagesize;
		this.tbar=[{text:'创建',iconCls:'x-tbar-add',handler:this.addItem.bind(this)},
		{text:'编辑',iconCls:'x-tbar-update',id:'editBtn',ref:'../editBtn',disabled:true,handler:this.addItem.bind(this,['edit'])},
		{text:'删除',iconCls:'x-tbar-del',id:'removeBtn',ref:'../removeBtn',disabled:true,handler:this.removeRecord.bind(this)},'->',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						labelWidth:35,
						width:150,
						fieldLabel:'From',
						invalidText:'格式错误！'
					},'-',{
						xtype:'datefield',
						id:'totime',
						labelWidth:35,
						width:150,
						format:'Y-m-d',
						fieldLabel:'To',
						invalidText:'格式错误！'
					},'-', {
            xtype: 'button',
            text: '搜索',
            iconCls: 'x-tbar-search',
            handler: function() {
                store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
						starttime:Ext.fly('starttime').dom.value,
						totime:Ext.fly('totime').dom.value
                    }
                });
            }
        },
		'-',{
			text:'导出',
			xtype:'button',
			iconCls:'x-tbar-import',
			handler:function(){
				window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
			}
		}];},
	createColumns:function(){
		var ds=this.store;
		var cols=[{xtype: 'rownumberer'},
			{header:'账户',dataIndex:'account',width:100,flex:1},
			{header:'账户金额',dataIndex:'money',flex:1},
			{header:'应收金额',dataIndex:'collect_money',flex:1},
			{header:'应付金额',dataIndex:'pay_money',flex:1},
			{header:'开户人',dataIndex:'add_user',flex:1},
			{header:'开户时间',dataIndex:'add_time',flex:1},
			{header:'操作',width:60,xtype: 'actioncolumn',items:[{
					icon   : 'themes/default/images/update.gif',	 
					tooltip: '编辑账户信息',
					handler: function(grid, rowIndex, colIndex) {
						var id = ds.getAt(rowIndex).get('id');
						parent.openWindow(id, '编辑账户', 'index.php?model=finance&action=addBank&id='+id,469,337);
					}
				}]}];this.columns=cols;},
	addItem:function (action) {
		var id = 0;
		if (action=='edit') {
			var id = getId(this);
			if (!id) {
				Ext.Msg.alert('出错啦','你还没有选择要操作的记录！');
				return;
			}
			parent.openWindow(id, '编辑账户', 'index.php?model=finance&action=addBank&id='+id,469,337);
		} else {
			parent.openWindow(id, '添加账户', 'index.php?model=finance&action=addBank',469,337);
		}
	},
	creatBbar: function() {
		var store=this.store;
		var	pagesize = this.pagesize;
       	this.bbar=Ext.create('Ext.toolbar.Paging',{
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    }
	});