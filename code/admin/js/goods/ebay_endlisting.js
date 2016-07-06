Ext.define('Ext.ux.GoodsView', {
    extend: 'Ext.Viewport',
    initComponent: function() {
        this.layout = 'border';
        this.selectid = '';
        this.creatselectionmodel();
        this.getTab();
        this.createStore();
        this.creatgrid();
        this.creatitems();
        this.callParent()
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
            fields:this.fields,
            remoteSort: true,
            autoLoad: true,
            pageSize: this.pagesize,
            proxy: {
                type: 'ajax',
                url: this.listURL,
                actionMethods: {
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0],
                    root: 'topics'
                }
            }
        })
    },
    setid: function(str) {
        this.selectid = str
    },
    getid: function() {
        return this.selectid
    },
    creatgrid: function() {
        var cm = this.creatcolumns();
        var bbar = this.creatBbar();
        var tbar = this.creatTbar();
        this.grid = Ext.create('Ext.grid.Panel', {
            loadMask: true,
            id: 'goodgrid',
            height: 500,
            viewConfig: {
                forceFit: true
            },
            region: 'center',
            store: this.store,
            columns: cm,
            selModel: this.sm,
            tbar: tbar,
            bbar: bbar
        })
    },
    onRowDblClick: function(grid, record, item, rowIndex, e) {
        var id = this.store.getAt(rowIndex).get('goods_id');
        var is_group = this.store.getAt(rowIndex).get('is_group');
        parent.openWindow(id, '编辑产品1', 'index.php?model=goods&action=' + ((is_group == 1) ? 'editcombine': 'edit') + '&goods_id=' + id, 1000, 700)
    },
    creatselectionmodel: function() {
        var setid = this.setid;
        var action = this.action;
        doSelect = this.doSelect;
        var tab = this.getTab();
		this.selModel = Ext.create('Ext.selection.CheckboxModel',{width:50,style:'border-right:1px solid #CCC'});
		var sm = this.selModel;
        this.sm = sm
    },
    creatcolumns: function() {
        var ds = this.store;
        var sm = this.sm;
        cols = [{
            header: '图片',
            dataIndex: 'GalleryURL',
            width:85,
            renderer: function(v) {
                return '<img src="' + v + '" width=70 height=70>';
            }
        },
		{   header: 'ItemID',
            dataIndex: 'ItemID',
            width:105,
        },
		{   header: 'Title',
            dataIndex: 'Title',
            width:305,
            renderer: function(v, x, rec) {
                return '<a href="http://item.ebay.com/' + rec.get('ItemID') + '" target="_blank" title="' + v + '">' + v + '</a>';
            }
        },
		{   header: 'SKU',
            dataIndex: 'SKU',
            sortable: true,
            width:105,
        },
		{   header: 'Startprice',
            dataIndex: 'StartPrice',
            width:75,
            editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },
		{	header: 'Quantity',
            dataIndex: 'Quantity',
            width:75,
            editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },
		{
            header: 'ListingType',
            dataIndex: 'ListingType',
            width:105,
        },
		{
            header: '账号',
            dataIndex: 'account_id',
            width:105,
        },
		{
			header:'操作',
            width:55,
			xtype: 'actioncolumn',
			items:[{ 
				tooltip: '编辑listing',
				style:'margin-right:5px;',
				iconCls: 'x-tbar-form_edit',
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
				tooltip: '重新上架',
				iconCls: 'x-tbar-ebay',
				style:'margin-left:10px;',
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
        return cols
    },
    creatTbar: function() {
        var store = this.store;
        var pagesize = this.pagesize;
        var user = this.user;
		var me = this;
        return Ext.create('Ext.toolbar.Toolbar', {
            items: [{
                xtype: 'button',
                text: '重新发布到eBay',
                iconCls: 'x-tbar-ebay',
                handler: function() {
                    
                }
            },'-',{
                xtype: 'button',
                text: '验证上传测试',
               iconCls: 'x-tbar-upload',
                handler: function() {
					var s = me.grid.getSelectionModel().getSelection();
					if (s.length==0) {
						Ext.Msg.alert('ERROR', '请选择至少一个产品!');
						return false;
					}else{
						var msgWindow = showWindow('验证eBay产品刊登');
						msgWindow.show();
						msgWindow.body.dom.innerHTML = '';
						var sb = Ext.getCmp('basic-statusbar');
						for (i=0;i<s.length;i++) {
							sb.showBusy('正在验证');
							var id = s[i].data.id;
							me.startupload(id,msgWindow);
						}
					}	
                }
            },'->', {
                xtype: 'textfield',
                id: 'keyword',
                width: 160,
                labelWidth: 65,
                fieldLabel: 'ItemNO/Titel/SKU',
                name: 'keyword',
                enableKeyEvents: true,
                listeners: {
                    scope: this,
                    keypress: function(field, e) {
                        if (e.getKey() == 13) {
                            store.on('beforeload',
                            function(store, options) {
                                var new_params = {
                                    keyword: Ext.getCmp('keyword').getValue(),
                                    user_id: Ext.getCmp('user_id').getValue(),
                                };
                                Ext.apply(store.proxy.extraParams, new_params)
                            });
                            store.load({
                                params: {
                                    start: 0,
                                    limit: pagesize
                                }
                            })
                        }
                    }
                }
            },
            '-', {
                xtype: 'button',
                text: '搜索',
                iconCls: 'x-tbar-search',
                handler: function() {
                    store.on('beforeload',
                    function(store, options) {
                        var new_params = {
                            keyword: Ext.getCmp('keyword').getValue(),
                            user_id: Ext.getCmp('user_id').getValue(),
                        };
                        Ext.apply(store.proxy.extraParams, new_params)
                    });
                    store.load({
                        params: {
                            start: 0,
                            limit: pagesize
                        }
                    })
                }
            }]
        })
    },
    creatBbar: function() {
        var pagesize = this.pagesize;
        return Ext.create('Ext.toolbar.Paging', {
            plugins: new Ext.ui.plugins.ComboPageSize(),
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store
        })
    },
    creatTab: function() {
        var store = this.store;
        var getid = this.getid;
        var action = this.action;
        var rendererlist = this.rendererlist;
        doSelect = this.doSelect;
        var tab;
        return tab
    },
    getTab: function() {
        if (!this.tab) {
            this.tab = this.creatTab()
        }
        return this.tab
    },
    creatitems: function() {
        return this.items = [/*this.tree, */this.grid]
    },
    showWindow: function() {
        this.getWindow().show()
    },
    hideWindow: function() {
        this.getWindow().hide()
    },
    getWindow: function() {
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow()
        }
        return this.gridWindow
    },
    createWindow: function() {
        var formPanel = this.getFormPanel();
        var win = Ext.create('Ext.window.Window', {
            id: 'searchwin',
            title: this.windowTitle,
            closeAction: 'destroy',
            width: this.windowWidth,
            height: this.windowHeight,
            modal: true,
            items: [formPanel]
        });
        return win
    },
	startupload:function(id,win){
		var sb = Ext.getCmp('basic-statusbar');
		var me = this;
		Ext.Ajax.request({
			url: 'index.php?model=goods&action=VerifyAddItem',
			params: {id:id},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					Ext.defer(function(){
						sb.setStatus({
							iconCls: 'x-status-valid',
							text: res.msg+'验证完成 ' + Ext.Date.format(new Date(), 'G:i:s')
						});
					}, 1000);
					win.body.dom.innerHTML = win.body.dom.innerHTML+res.msg;
				}
			}
		});
	}
});
 