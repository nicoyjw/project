Ext.define('Ext.ux.GoodsView', {
    extend: 'Ext.Viewport',
    initComponent: function() {
        this.layout = 'border';
        this.selectid = '';
        this.creatselectionmodel();
        this.getTab();
        this.creatTree();
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
    creatTree: function() {
        var me = this;
        var Tree = Ext.tree;
        var pagesize = this.pagesize;
		
		
		var cate = Ext.create('Ext.tree.Panel', {
            border: true,
			width:220,
            store: Ext.create('Ext.data.TreeStore', {
                autoLoad: true,
                proxy: {
                    type: 'ajax',
                    url: this.catTreeURL
                },
                root: {
                    text: '总类',
                    draggable: false,
                    id: 'root'
                }
            }),
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true
        });
        cate.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e) {
            if (node.isLeaf()) {
                e.stopEvent();
                //Ext.getCmp('cat_id').setValue(node.data.id);
                me.store.load({
                    params: {
                        start: 0,
                        account: node.data.id,
                        limit: pagesize
                    },
                    scope: me.store
                })
            }
        };
		
		
		 var tree = Ext.create('Ext.tab.Panel', {
            activeTab: 0,
			region: 'west',
            id: 'west-panel',
            width: 240,
            minSize: 55,
            maxSize: 300,
            margins: '0 0 0 0',
            split: true,
            layoutConfig: {
                animate: true
            },
			autoScroll: true,
            items: [{
                id: 'tab2_1',
                title: '帐号',
				autoScroll: true,
                items:[
					cate
				]
            },
            {
                id: 'tab2_2',
                title: '分类',
                html: '<iframe style="padding:0;margin:0;" id="tab4_iframe" src="index.php?model=goods&action=getdes" width="100%" height="200" ></iframe>',
				disabled: true,
                listeners: {
                    activate: function() {
                        doSelect('tab4', getid(), action)
                    }
                }
            },
            {
                id: 'tab2_3',
                title: '状态',
				disabled: true,
                html: '<iframe style="padding:0;margin:0;" id="tab4_iframe" src="index.php?model=goods&action=getdes" width="100%" height="200" ></iframe>',
                listeners: {
                    activate: function() {
                        doSelect('tab4', getid(), action)
                    }
                }
            }]
        });
		
		
        
		
		
		
		
        this.tree = tree
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
                forceFit: true,
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
        var sm = Ext.create('Ext.selection.CheckboxModel', {
            //mode: 'SINGLE',
            listeners: {
                "select": function(e, record, rowindex) {
                    setid(record.data);
                    
                    doSelect(tab.getActiveTab().id, record.data, action)
                }
            }
        });
        this.sm = sm
    },
    doSelect: function(id, info, action) {
		if (!info) {
            if (id != 'tab1') Ext.example.msg('错误', '请先选择一条产品记录');
            return false
        }
        var tpl1 = new Ext.Template('<div style="width:40%;float:left;padding:5px;"><div style="height:23px;">商品货号: {skuCode}</div>', '<div style="height:auto;margin:5px 0">标题: {goods_name}</div>', '<div style="height:23px;">长宽高: {packageLength}*{packageWidth}*{packageHeight}</div>',  '<div style="height:23px;">净重: {grossWeight}</div>', '<div style="height:23px;">备注: {comment}</div><img src="index.php?model=login&action=Barcode&number={skuCode}&type=1&height=35"><br><br></div>', '<div style="float:left;"><a href ="{goods_img}" target="_blank"> <img src="{goods_img}" width=230></a></p></div>');
        tpl1.check = function(v) {
            return (v == 0) ? 'NO': 'Yes'
        };
		
		
        if (!info) {
            if (id != 'tab1') Ext.example.msg('错误', '请先选择一条产品记录');
            return false
        }
       
        switch (id) {
        case 'tab1':
			tpl1.overwrite(Ext.getCmp("tab1").body, info);
            Ext.getCmp("tab1").body.highlight('#c3daf9', {
                block: true
            });
            break;
        case 'tab2':
            var iframe = document.getElementById('tab2_iframe');
            iframe.src = "index.php?model=aliexpress&action=getskuattribute&id=" + info.id + "&" + Math.random();
            break;
         case 'tab11':
            Ext.getCmp('imgdiv').update('');
            Ext.getCmp('file_path').setValue('');
            Ext.getCmp('tab11_item').getStore().load({
                params:
                {
                    id:
                    info.id
                }
            });
            break
        case 'tab4':
			var iframe = document.getElementById('tab4_iframe');
            iframe.src = "index.php?model=aliexpress&action=Edit_Ali_Attributes&id=" + info.id + "&" + Math.random();
            break;
        }
    },
    creatcolumns: function() {
		var pstore = this.store;
        var ds = this.store;
        var sm = this.sm;
        cols = [{
            header: '图片',
            dataIndex: 'goods_img',
			width:85,
            renderer: function(v) {
                return '<a href="'+v+'" target="_blank" >'+'<img src="' + v + '" width=80 height=80>'+'</a>';
            }
        },/*{   header: 'ItemID',
            dataIndex: 'ItemID',
            flex:1
        },*/{  header: '标题',
            dataIndex: 'goods_name',
			width:155,
        },{   
		header: '商品货号',
            dataIndex: 'skuCode',
            sortable: true,
			width:105,
        },{header: '售价',
            dataIndex: 'productPrice',
			width:120,
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
								restr += '售价：￥'+price[0];
								if(price[1]){
									restr += '批发价：￥'+Ext.util.Format.number((price[0]-b),"0.00")+'<br>起批量:'+rec.get('lotNum')+'<br>折扣：'+rec.get('bulkDiscount');
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
							restr = '售价：￥'+price[0];
							if(price[1]){
									restr += '<br/>批发价￥'+Ext.util.Format.number((price[0]-b),"0.00")+'<br>起批量:'+rec.get('lotNum')+'<br>折扣：'+rec.get('bulkDiscount');
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
        }*/,{ header: '销量',
            dataIndex: 'bulkDiscount',
			flex:1,
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
            header: '库存',
            dataIndex: 'bulkDiscount',
			flex:1,
        }/*,{
            header: 'Keyword',
            dataIndex: 'keyword',
			width:105,
        }*/,{
            header: '账号',
            dataIndex: 'account_name',
			flex:1,
		},{
			header:'<font style="color:#157FCC">编辑</font>',
			width:65,
			align:'center',
			xtype: 'actioncolumn',
			items:[{ 
				tooltip: '编辑',
				icon: 'themes/default/images/update.gif',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
                    parent.openWindow(id, '编辑Aliexpress产品', 'index.php?model=goods&action=EditALIGoods&status=1&id=' + id, 1000, 600)
				}
			}]
		},{
			header:'<font style="color:#157FCC">发布</font>',
			width:65,
			align:'center',
			xtype: 'actioncolumn',
			items:[{
				tooltip: '发布产品到Aliexpress',
				iconCls: 'iconpadding',
				icon: 'themes/default/images/aliexpress.png',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
					 Ext.Msg.confirm('Upload Product!', 'Are you sure?',
                     function(btn) {
                        if (btn == 'yes') {
							Ext.getBody().mask("正在上传数据...","x-mask-loading");
							Ext.Ajax.request({
								url: 'index.php?model=aliexpress&action=goodupload',
								params: {id:id},
								success:function(response,opts){
									Ext.getBody().unmask();
									var res = Ext.decode(response.responseText);
									if(res.success){
											ds.load({params: {}})
										 Ext.example.msg('MSG', res.msg);
									}else{
										Ext.Msg.alert('发布产品失败',res.msg);
									}
								}
							});
                        }
                    },
                    this)
				}
			}]
		}/*,{
			header:'操作',
			flex:1,
			xtype: 'actioncolumn',
			items:[{ 
				tooltip: '编辑',
				icon: 'themes/default/images/update.gif',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
                    parent.openWindow(id, '编辑Aliexpress产品', 'index.php?model=goods&action=EditALIGoods&status=1&id=' + id, 1000, 600)
				}
			},{ 
				tooltip: '发布产品到Aliexpress',
				iconCls: 'iconpadding',
				icon: 'themes/default/images/aliexpress.png',
				handler: function(grid, rowIndex, colIndex) {
					var id = ds.getAt(rowIndex).get('id');
					 Ext.Msg.confirm('Upload Product!', 'Are you sure?',
                     function(btn) {
                        if (btn == 'yes') {
							Ext.getBody().mask("正在上传数据...","x-mask-loading");
							Ext.Ajax.request({
								url: 'index.php?model=aliexpress&action=goodupload',
								params: {id:id},
								success:function(response,opts){
									Ext.getBody().unmask();
									var res = Ext.decode(response.responseText);
									if(res.success){
										Ext.Msg.alert('提示',res.msg);
									}else{
										Ext.Msg.alert('发布产品失败',res.msg);
									}
								}
							});
                        }
                    },
                    this)
				}
			}]
		}*/];
        return cols
    },
    creatTbar: function() {
        var store = this.store;
        var pagesize = this.pagesize;
		var account = this.accountdata;
        var user = this.user;
		var me = this;
        return Ext.create('Ext.toolbar.Toolbar', {
            items: [{
                xtype: 'button',
                text: '新增',
                iconCls: 'x-tbar-add',
                handler: function() {
                    parent.newTab('addali','新增Aliexpress产品','index.php?model=goods&action=AddALIGoods')
                }
            },'-',{
                xtype: 'button',
                text: '发布产品到Aliexpress',
                icon: 'themes/default/images/aliexpress.png',
                handler: function() {
                   
				    var ids = getIds(me.grid);
					if(!ids){
						Ext.Msg.alert('ERROR', '请选择至少一个产品!');
						return false;
					}
					var msgWindow = showWindow('Aliexpress产品刊登');
					msgWindow.show();
					msgWindow.body.dom.innerHTML = '';
					var sb = Ext.getCmp('basic-statusbar');
					
					Ext.Ajax.request({
						url: 'index.php?model=aliexpress&action=goodupload',
						params: {ids:ids},
						success:function(response,opts){
							Ext.getBody().unmask();
							var res = Ext.decode(response.responseText);
							if(res.success){
								Ext.Msg.alert('提示',res.msg);
							}else{
								Ext.Msg.alert('发布产品失败',res.msg);
							}
						}
					});
					
					
					
                }
            },'->',/*,'-',{
                xtype: 'button',
                text: '定时规则',
                iconCls: 'x-tbar-addhourglass',
                handler: function() {
                    
                }
            }*/{
					xtype: 'button',
					text: '批量删除产品',
					icon: 'themes/default/images/del.gif',
					handler: function() {
						var ids = getIds(me.grid);
						if(!ids){
							Ext.Msg.alert('ERROR', '请选择至少一个产品!');
							return false;
						}
						Ext.Msg.confirm('Delete Alert!', 'Are you sure?',
						function(btn) {
							if (btn == 'yes') {
								//alert(ids);return;
								Ext.Ajax.request({
									url: 'index.php?model=goods&action=deletealigoods',
									params: {ids:ids},
									success:function(response,opts){
										var res = Ext.decode(response.responseText);
										if(res.success){
											store.load({
												params: {
													start: 0,
													limit: pagesize
												}
											})
										}
									}
								});
							}
						},
						this)
					}
				},'-',{
                xtype: 'textfield',
                id: 'keyword',
                width: 160,
                labelWidth: 65,
                fieldLabel: '模糊搜索',
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
                                    account: Ext.getCmp('account').getValue(),
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
							account: Ext.getCmp('account').getValue()
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
            }/*,
            '-', {
                xtype: 'button',
                text: '高级搜索',
                iconCls: 'x-tbar-advsearch',
                handler: this.showWindow.bind(this)
            },
            '-', {
                xtype: 'button',
                text: '导出搜索',
                iconCls: 'x-tbar-import',
                handler: function() {
                    var values = Ext.getCmp('searchform').getForm().getFieldValues();
                    window.open().location.href = 'index.php?model=goods&action=exportgoods&keyword=' + Ext.getCmp('keyword').getValue() + '&keytype=' + Ext.getCmp('keytype').getValue() + '&cat_id=' + Ext.getCmp('cat_id').getValue() + '&status=' + Ext.getCmp('status').getValue() + '&key=' + Ext.getCmp('key').getValue()
                }
            }*/]
        })
    },
    creatBbar: function() {
        var pagesize = this.pagesize;
		var me = this;
		var store = this.store;
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
       
		var tab11store = Ext.create('Ext.data.JsonStore', {
            proxy: {
                type: 'ajax',
                url: 'index.php?model=aliexpress&action=getgoodsgallery',
                actionMethods: {
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    root: 'topics'
                }
            },
            fields: ['id', 'url']
        });
        var tpl = new Ext.XTemplate('<tpl for=".">', '<div class="thumb-wrap" id="pic{id}">', '<div class="thumb"><img src="{url}"></div>', '</div>', '</tpl>', '<div class="x-clear"></div>');
        var tab11_item = new Ext.DataView({
            id: 'tab11_item',
            store: tab11store,
            tpl: tpl,
            singleSelect: true,
            autoHeight: true,
            frame: true,
            border: true,
            overClass: 'x-view-over',
            itemSelector: 'div.thumb-wrap',
            emptyText: 'No images to display',
            listeners: {
                selectionchange: function(dv, nodes) {
                    var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
                    if (sel.length > 0){
						Ext.getCmp('imgdiv').update('<img src="' + sel[0].data.url + '" height=230>');
					}else{
						
						Ext.getCmp('imgdiv').update('<img src="' + tab11store.getAt(0).get('url') + '" height=230>');
					}
                }
            }
        });
		var thiz = this;
        var gallerybtn = Ext.create('Ext.form.Panel', {
            id: 'gallery_btn',
            layout: 'column',
            border: false,
            frame: false,
            items: [{
                xtype: 'button',
                text: '设为主图片',
                border: false,
                handler: function() {
                    var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
                    if (sel.length > 0) {
                        modifymodel(getid().goods_id, 'goods_img', sel[0].data.url, 'goods')
                    } else {
                        Ext.example.msg('Error', '请先选择下面图库中的图片')
                    }
                }
            },
            {
                xtype: 'button',
                iconCls: 'x-tbar-save',
                text: '删除图片',
                style: 'margin-left:10px',
                border: false,
                handler: function() {
                    var sel = Ext.getCmp('tab11_item').getSelectionModel().getSelection();
                    if (sel[0]) {
                        Ext.getBody().mask("Updating Data .waiting...", "x-mask-loading");
                        Ext.Ajax.request({
                            url: 'index.php?model=goods&action=delgallery',
                            loadMask: true,
                            params: {
                                id: sel[0].data.rec_id
                            },
                            success: function(response, opts) {
                                var res = Ext.decode(response.responseText);
                                Ext.getBody().unmask();
                                if (res.success) {
                                    Ext.example.msg('MSG', res.msg);
                                    Ext.getCmp('tab11_item').getStore().load({
                                        params: {
                                            goods_id: getid().goods_id
                                        }
                                    })
                                } else {
                                    Ext.Msg.alert('ERROR', res.msg)
                                }
                            }
                        })
                    } else {
                        Ext.example.msg('Error', '请先选择下面图库中的图片')
                    }
                }
            }]
        });
        var uploadform = Ext.create('Ext.form.Panel', {
            fileUpload: true,
            id: 'uploadform',
            border: false,
            frame: false,
            layout: 'column',
            items: [{
                columnWidth: .4,
                items: [{
                    fieldLabel: '上传图片',
                    labelWidth: 65,
                    width: 250,
                    xtype: 'fileuploadfield',
                    name: 'file_path',
                    id: 'file_path'
                }]
            },
            {
                columnWidth: .35,
                border: false,
                frame: false,
                items: [{
                    fieldLabel: '图片链接',
                    labelWidth: 65,
                    width: 300,
                    xtype: 'textfield',
                    name: 'url'
                }]
            },
            {
                columnWidth: .2,
                border: false,
                frame: false,
                items: [{
                    xtype: 'button',
                    text: '提交',
                    iconCls: 'x-tbar-update',
                    handler: function() {
                        var info = getid();
                        thiz.formsubmit(info.goods_id)
                    }
                }]
            }]
        });
		
        var tab = Ext.create('Ext.tab.Panel', {
            activeTab: 0,
            autoWidth: true,
			autoScroll: true,
            height: 500,
            defaults: {
                autoScroll: true
            },
            items: [{
                id: 'tab1',
                title: '基本信息',
				autoScroll: true,
                listeners: {
                    activate: function() {
                        doSelect('tab1', getid(), action)
                    }
                },
                html: ''
            },
            {
                id: 'tab4',
                title: '属性',
                html: '<iframe style="padding:0;margin:0;" id="tab4_iframe" src="index.php?model=aliexpress&action=Edit_Ali_Attributes" width="100%" height="200" ></iframe>',
                listeners: {
                    activate: function() {
                        doSelect('tab4', getid(), action)
                    }
                }
            },
			{
                id: 'tab11',
                title: '图库',
                width: 800,
                height: 280,
                layout: 'column',
                items: [{
                    columnWidth: .3,
                    layout: 'form',
                    defaultType: 'textfield',
                    items: [{
                        xtype: 'panel',
                        id: 'imgdiv',
                        height: 250,
                        html: ''
                    }]
                },
                {
                    columnWidth: .7,
                    layout: 'form',
                    items: [uploadform, gallerybtn, tab11_item]
                }],
                listeners: {
                    activate: function() {
                        doSelect('tab11', getid(), action)
                    }
                }
            },
			{
                id: 'tab2',
                title: '属性产品',
				 html: '<iframe style="padding:0;margin:0;" id="tab2_iframe" src="index.php?model=aliexpress&action=getskuattribute" width="100%" height="200" ></iframe>',
                listeners: {
                    activate: function() {
                        doSelect('tab2', getid(), action)
                    }
                }
            }]
        });
        return tab
    },
    getTab: function() {
        if (!this.tab) {
            this.tab = this.creatTab()
        }
        return this.tab
    },
    creatitems: function() {
        return this.items = [this.tree, this.grid, {
            title: '产品详情',
            region: 'south',
            height: 280,
            collapsible: true,
            split: true,
            items: [this.tab]
        }]
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
			url: 'index.php?model=aliexpress&action=goodupload',
			params: {id:id},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					alert(res.msg);
					
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
