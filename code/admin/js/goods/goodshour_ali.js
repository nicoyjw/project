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
            dataIndex: 'goods_img',
			width:70,
            renderer: function(v) {
                return '<a href="'+v+'" target="_blank" >'+'<img src="' + v + '" width=50 height=50>'+'</a>';
            }
        },/*{   header: 'ItemID',
            dataIndex: 'ItemID',
            flex:1
        },*/{  header: 'Title',
            dataIndex: 'goods_name',
			width:200,
        },{   
		header: 'SKU',
            dataIndex: 'skuCode',
            sortable: true,
			width:135,
        },{header: 'productPrice',
              dataIndex: 'productPrice',
				width:155,
            	renderer: function(v,x,rec) {
					var strs= new Array();
					var restr = '';
					strs=v.split("<br>");
					if(strs.length > 1){
						for (i=0;i<strs.length ;i++ )
						{   
							var price= new Array();
							price = strs[i].split('-');
							var a = rec.get('bulkDiscount')/100;
							var b = price[0] * a;
							if(rec.get('bulkOrder') > 0){
								restr += '￥'+price[0]+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
								if(price[1]){
									restr += '￥<font style="color:red">'+Ext.util.Format.number((price[0]-b),"0.00")+'</font><br>';
								}
							}else{
								restr += '￥'+strs[i]+'<br>';
							}
							
						} 
					}else{
						if(rec.get('bulkOrder') > 0){
							var price= new Array();
							price = v.split('-');
							var a = rec.get('bulkDiscount')/100;
							var b = price[0] * a;
							restr = '￥'+price[0]+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
							if(price[1]){
									restr += '￥<font style="color:red">'+Ext.util.Format.number((price[0]-b),"0.00")+'</font><br>';
								}
						}else{
							restr = '￥'+v;
						}
					}
					return restr;
            }/*,
			   listeners : {
					click : function(e,record,rowindex) {
						var record = ds.getAt(rowindex);
						record.data.productPrice='0';
					}
				},
            editor:{
				xtype:'textfield',
				hideLabel:true
			}*/
        }/*,{	header: 'Quantity',
            dataIndex: 'Quantity',
             flex:1,
            editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },{ header: '销售方式(1为非打包)',
            dataIndex: 'lotNum',
			width:185,
               editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },{ header: '起批量',
            dataIndex: 'bulkOrder',
			width:105,
               editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        }*/,{ header: '销售数量',
            dataIndex: 'bulkDiscount',
			width:105,
               editor:{
						xtype:'numberfield',
						minValue:0,
						decimalPercision:4,
						hideLabel:true
					},
               editor:{
				xtype:'numberfield',
				minValue:0,
				hideLabel:true
			}
        },{
            header: '产品状态',
            dataIndex: 'goods_status',
			width:105,
        }/*,{
            header: 'Keyword',
            dataIndex: 'keyword',
			width:105,
        }*/,{
            header: '账号',
            dataIndex: 'account_name',
			width:105
        },{
			header:'操作',
			width:105,
			xtype: 'actioncolumn',
			items:[{ 
				tooltip: '编辑',
				iconCls: 'x-tbar-form_edit',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
                    parent.openWindow(id, '编辑产品', 'index.php?model=goods&action=AddALIGoods&id=' + id, 1000, 550)
				}
			},{
				icon   : 'themes/default/images/currency_dollar_yellow.png',	 
				tooltip: '修改价格信息',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					var record = ds.getAt(rowIndex);
					//alert(record.data.productPrice);return;
					var win = Ext.create('Ext.Window',{
						layout:'form',
						width:320,
						title:'更新SKU价格',
						frame:false,
						border:false,
						height:150,
						id:'skugoodsWIN',
						modal: true,
						closable:true,
						padding:15,
						items:[
							{xtype:'numberfield',id:'pricenumber',fieldLabel:'在每个SKU增加或减少相应的金额',labelWidth:200,width:250}
						],
						buttons:[{
							text:'提交更新',
							handler:function(){
								var price = Ext.getCmp('pricenumber').getValue();
								var id = ds.getAt(rowIndex).get('id');
								Ext.Ajax.request({
								   url: 'index.php?model=aliexpress&action=updateitemprice&id='+id+'&price='+price+'&account_id='+Ext.getCmp('account').getValue(),
									success:function(response,opts){
										var res = Ext.decode(response.responseText);
											if(res.success){
												win.destroy();
												Ext.Msg.alert('MSG',res.msg);
												ds.load({params:{
													status:Ext.getCmp('goods_status').getValue(),
													account:Ext.getCmp('account').getValue(),
													goods_sn:Ext.getCmp('goods_sn').getValue(),
													}
												});
											}else{
												Ext.Msg.alert('ERROR',res.msg);
											}						
										}
									});
							}
							}]
						});
					win.show();
				}
			},{
				icon   : 'themes/default/images/icons/arrow_refresh.png',	 
				tooltip: '更新产品',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=aliexpress&action=reloadgood&id='+id+'&account_id='+Ext.getCmp('account').getValue(),
						success:function(response,opts){
							Ext.getBody().unmask();
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
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
 