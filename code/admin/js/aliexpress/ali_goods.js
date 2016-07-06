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
            timeout: 20000,
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
        });
       
       this.store.load({
            params:{
                start:0, 
                limit:this.pagesize  
            }
       });
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
		var acco = Ext.create('Ext.tree.Panel', {
            border: true,
            id:'account_tree',
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
        acco.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e) {
            if (node.isLeaf()) {
                e.stopEvent();
                Ext.getCmp('ali_goods_account_id').setValue(node.data.id);
                me.store.load({
                    params: {start: 0, limit: pagesize,account:node.data.id,status:Ext.getCmp('ali_status_id').getValue() }
                });
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
                    
					acco
				]
            },
            
            {
                id: 'tab2_2',
                title: '分类',         
				autoScroll: true,
                listeners: {                                                                                  
                activate: function(tab) {
					var cate =  Ext.create('Ext.tree.Panel', {
							border: true,
							width:220,
							id:'tab2_2_item',
							store: Ext.create('Ext.data.TreeStore', {
								//autoLoad: true,
								proxy: {
									type: 'ajax',
									url: 'index.php?model=aliexpress&action=getAliCate&com=0'
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
                            
                            listeners:{
                                afterrender:function(){
                                  var record = this.getStore().getNodeById('select');
                                    this.getSelectionModel().select(record)
                                }
                            },
							rootVisible: false,
							autoScroll: true
						});
					tab.add(
						cate 
					);
					cate.on('itemclick', treeClick2);
					function treeClick2(view, node, item, index, e) {
						if (node.isLeaf()) {
							e.stopEvent();
                            var new_params = {   
                                account:Ext.getCmp('ali_goods_account_id').getValue(),
                                status:Ext.getCmp('ali_status_id').getValue()
                            };
                            Ext.apply(me.store.proxy.extraParams, new_params);
                            
							me.store.load({
								params: {start: 0, limit: pagesize }
							})
						}
					};
                    }
                }
            }/*,
            {
                id: 'tab2_3',
                title: '状态',
                autoScroll: true,
                items:[{
                     xtype:'button',
                     //style:'margin-left:120px;',
                     text:'重置', 
                     handler: function(grid, rowIndex, colIndex) {
                        Ext.getCmp("ali_category_id").setValue(0);  
                        Ext.getCmp('ali_goods_account_id').setValue(0);
                        Ext.getCmp('ali_status_id').setValue(0);
                        me.store.load({
                            params: {
                                start: 0,
                                account:Ext.getCmp('ali_goods_account_id').getValue(),
                                status:Ext.getCmp('ali_status_id').getValue(),
                                cat_id:Ext.getCmp("ali_category_id").getValue(),
                                limit: pagesize
                            },
                            scope: me.store
                        })
                    }  
                   },
                    Ext.create('Ext.tree.Panel', {
                                border: true,
                                width:220,
                                id:'tab2_3_item',
                                store: Ext.create('Ext.data.TreeStore', {
                                    autoLoad: true,
                                    proxy: {
                                        type: 'ajax',
                                        url: 'index.php?model=aliexpress&action=getAliStatus&com=0'
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
                            })
                ],
                listeners: {
                    activate: function(tab) {
                        Ext.getCmp('tab2_3_item').on('itemclick', treeClick3);
                        function treeClick3(view, node, item, index, e) {
                        if (node.isLeaf()) {
                            e.stopEvent();
                            Ext.getCmp('ali_status_id').setValue(node.data.id);
                            me.store.load({
                                params: {
                                    start: 0,
                                    account:Ext.getCmp('ali_goods_account_id').getValue(),
                                    status: node.data.id,
                                    cat_id:Ext.getCmp('ali_category_id').getValue(),
                                    limit: pagesize
                                },
                                scope: me.store
                            })
                        }
                    };
                    }    
                }
             }*/]
        });
		
        this.tree = tree
    },
    creatgrid: function() {
        var cm = this.creatcolumns();
        var bbar = this.creatBbar();
        var tbar = this.creatTbar();
        this.grid = Ext.create('Ext.grid.Panel', {
            loadMask: true,
            id: 'aliGrid',
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
        case 'tab5':
            var iframe = document.getElementById('tab5_iframe');
            iframe.src = "index.php?model=aliexpress&action=Update_Ali_Price&id=" + info.id + "&" + Math.random();
            break;
		case 'tab2_2':
          Ext.getCmp('tab2_2_item').getStore().load({
                params:{}
            });
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
            iframe.src = "index.php?model=aliexpress&action=Edit_Ali_Attributes&account_id="+info.account_id+"&id=" + info.id + "&" + Math.random();
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
			flex:1,
        },{header: '售价',
            dataIndex: 'productPrice',
			flex:1,
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
								restr += '售价：＄'+price[0];
								if(price[1]){
									restr += '批发价：＄'+Ext.util.Format.number((price[0]-b),"0.00")+'<br>起批量:'+rec.get('lotNum')+'<br>折扣：'+rec.get('bulkDiscount');
								}
							}else{
								restr += '＄'+strs[i]+'<br>';
							}
							
						} 
					}else{
						if(rec.get('bulkOrder') > 0){
							var price= new Array();
							price = v.split('-');
							var a = rec.get('bulkDiscount')/100;
							var b = price[0] * a;
							restr = '售价：＄'+price[0];
							if(price[1]){
									restr += '<br/>批发价＄'+Ext.util.Format.number((price[0]-b),"0.00")+'<br>起批量:'+rec.get('lotNum')+'<br>折扣：'+rec.get('bulkDiscount');
								}
						}else{
							restr = '＄'+v;
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
        }*/,{ header: '状态',
            dataIndex: 'goods_status',
			flex:1,
        },{ header: '近一月浏览量',
            dataIndex: 'ProductViewed',
            flex:1
        },{ header: '近一月销量',
            dataIndex: 'SalesInfo',
			flex:1
        }/*,{
            header: '库存',
            dataIndex: 'bulkDiscount',
			flex:1,
            renderer: function(v) {
                return '0';
            }
        },{
            header: 'Keyword',
            dataIndex: 'keyword',
			width:105,
        }*/,{
            header: '账号',
            dataIndex: 'account_name',
			flex:1,
		},{
			header:'<font style="color:#157FCC">下架/上架</font>',
			width:85,
			align:'center',
			xtype: 'actioncolumn',
			items:[{
				icon: 'themes/default/images/sort_down.png',
				tooltip: '下架',
				iconCls: 'iconpadding',
				handler: function(grid, rowIndex, colIndex) {
                        Ext.Msg.alert('MSG','正在升级'); 
                        return;
					Ext.getBody().mask("正在下架，请等候...","x-mask-loading");
					Ext.Ajax.request({
						url: 'index.php?model=aliexpress&action=downshelf',
						params: {id:ds.getAt(rowIndex).get('id')},
						success:function(response,opts){
							Ext.getBody().unmask();
							ds.load();
							Ext.Msg.alert('MSG',response.responseText);
						}
					});
				}
			},{ 
                    icon: 'themes/default/images/sort_up.png',
                    tooltip: '上架',
                    iconCls: 'iconpadding',
                    handler: function(grid, rowIndex, colIndex) {
                        Ext.Msg.alert('MSG','正在升级'); 
                        return;
                        Ext.getBody().mask("正在上架，请等候...","x-mask-loading");
                        Ext.Ajax.request({
                            url: 'index.php?model=aliexpress&action=onlineshelf',
                            params: {id:ds.getAt(rowIndex).get('id')},
                            success:function(response,opts){
                                Ext.getBody().unmask();
                                ds.load();
                                Ext.Msg.alert('MSG',response.responseText);
                            }
                        });
                    }}]
		},{
            header:'<font style="color:#157FCC">编辑</font>',
            width:50,
            align:'center',
            xtype: 'actioncolumn',
            items:[{ 
                tooltip: '编辑',
                iconCls: 'iconpadding',
                icon: 'themes/default/images/update.gif',
                style:'margin-right:35px;',
                handler: function(grid, rowIndex, colIndex) {
                    Ext.Msg.alert('MSG','正在升级'); 
                    
                    return;
                    var id = ds.getAt(rowIndex).get('id');
                    parent.openWindow(id, '编辑Aliexpress产品', 'index.php?model=goods&action=EditALIGoods&status=0&id=' + id, 1000, 600)
                }
            }]
        },/*{
            header:'<font style="color:#157FCC">发布</font>',
            width:50,
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
                                     
                                    ds.load({
                                        params: {start: 0, limit: 20 }
                                    })
                                     Ext.Msg.alert('MSG',response.responseText);   
                                     Ext.getBody().unmask(); 
                                }
                            });
                        }
                    },
                    this)
                }
            }]
            }*/
            ];
        return cols
    },
    creatTbar: function() {
		var pagesize = this.pagesize;
		var store = this.store;
		var saveURL=this.saveURL;
		var account = this.accountdata;
		var goodstatus = this.goodstatus;
		var me = this;
        var accstore = Ext.create('Ext.data.ArrayStore', {
            fields: ['id', 'name'],
            data : account
        });
        
        var acccombo = Ext.create('Ext.form.field.ComboBox', {
            hideLabel: true,
            store: accstore,
            valueField :"id",
            displayField: "name",
            mode: 'local',
            width:270,
            editable: false,
            forceSelection: true,
            triggerAction: 'all',
            id:'ali_account_id',
            name:'ali_account_id',
            hiddenName:'ali_account_id',  
            emptyText: '选择一个账号...',
            width: 135,
            indent: true
        }); 
        var menu = Ext.create('Ext.menu.Menu', {
            id: 'mainMenu',
            style: {
                overflow: 'visible' 
            },
            items: [
                ,
                {
                    text:'状态', 
                    menu: { 
                        items: [            
                            '<b class="menu-title">Choose a status</b>',
                            {
                                text: '上架销售',
                                checked: true,
                            }, '-',{
                                text: '下架结束',
                                checked: true,
                            }, '-',{
                                text: '审核中',
                                checked: true,
                            }, '-',{
                                text: '审核不通过',
                                checked: true,
                            }
                        ]
                    }
                }            ]
        });
		return Ext.create('Ext.toolbar.Toolbar', {
            items: [{
                xtype:'hidden',
                id:'ali_goods_account_id',
                value:0
            },/*{
                xtype:'hidden',
                id:'ali_status_id',
                value:0
            },*/ {
                xtype:'hidden',
                id:'ali_category_id',
                value:0
            },'-',{
			icon: 'themes/default/images/downshelf.png',
			menu: menu, 
			text: '批量操作'
		},/*{
            xtype:'combo',
            hideLabel: true,
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data:account
                 
                 
                   * account = this.accountdata;
                    var goodstatus = this.goodstatus;
                  
            }),
             valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '选择账号',
            selectOnFocus: true,
            width: 105,
            hiddenName:'ali_goods_account_id',
            name: 'ali_goods_account_id',
            id:'ali_goods_account_id',
            value:'0'
        },*/{
            xtype:'combo',
            hideLabel: true,
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: goodstatus
            }),
             valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '选择状态',
            selectOnFocus: true,
            width: 105,
            hiddenName:'ali_status_id',
            name: 'ali_status_id',
            id:'ali_status_id',
            value:'allStatus'
        },'-',acccombo,'-',{
            id:'goods_sn',
            width:155,
            emptyText: '按标题模糊搜索',
            xtype:'textfield',
            enableKeyEvents: true,
            listeners: {
                scope: this,
                keypress: function(field, e){
                    if (e.getKey() == 13) {
                        
                        var new_params = {   
                            account:Ext.getCmp('ali_goods_account_id').getValue(),
                            status:Ext.getCmp('ali_status_id').getValue(),
                            goods_sn:Ext.getCmp('goods_sn').getValue()
                        };
                        Ext.apply(me.store.proxy.extraParams, new_params);
                        
                        me.store.load({
                            params: {start: 0, limit: 20,goods_sn:Ext.getCmp('goods_sn').getValue() }
                        })    
                          
                    }
                }
            }
        },'-',{
            xtype:'button',
            text:'搜索',
            iconCls:'x-tbar-search',
            handler:function(){
                
                var new_params = {   
                    account:Ext.getCmp('ali_goods_account_id').getValue(),
                    status:Ext.getCmp('ali_status_id').getValue(),
                    goods_sn:Ext.getCmp('goods_sn').getValue()
                };
                Ext.apply(me.store.proxy.extraParams, new_params);
                
                store.load({
                    params: {start: 0, limit: 20,goods_sn:Ext.getCmp('goods_sn').getValue() }
                })    
            }
        },'-',{
            xtype:'button',
            text:'加入本地产品库',
            iconCls:'x-tbar-import',
            handler:function(){            
                var s = Ext.getCmp('aliGrid').getSelectionModel().getSelection();
                if (s.length==0) {
                   return false;  
                }
                var ids = [];
                for (i=0;i<s.length;i++) {
                    ids.push(s[i].data.id+'-'+s[i].data.account_id);
                }
                ids = ids.join(',');    
                var thiz = this.store;
                Ext.getBody().mask("同步Aliexpress商品到ERP本地视图库.请稍等...","x-mask-loading");
                Ext.Ajax.request({
                    url:'index.php?model=aliexpress&action=exportgoods&id='+ids+'&status=0',
                    loadMask:true,
                    timeout: 300000,
                    success:function(response,opts){
                        var res=Ext.decode(response.responseText);
                        Ext.getBody().unmask();
                        if(res.success){
                            /*store.commitChanges();
                            store.load({params:{                             
                                goods_sn:Ext.getCmp('goods_sn').getValue(),
                            }
                            });*/
                            Ext.Msg.alert('MSG',res.msg);
                        }else{
                            
                        }
                    },
                    failure:function(response){
                        Ext.getBody().unmask();
                        Ext.Msg.alert('ERROR','超时或者失败，请重试');
                    }
                });
            }
        },'-',{
			xtype:'button',
			text:'复制到店铺',
			iconCls:'x-tbar-import',
			handler:function(){            
                var s = Ext.getCmp('aliGrid').getSelectionModel().getSelection();
                if (s.length==0) {
                   return false;  
                }
                var ids = [];
                for (i=0;i<s.length;i++) {
                    ids.push(s[i].data.id+'-'+s[i].data.account_id);
                }
                ids = ids.join(',');    
				var thiz = this.store;
				Ext.getBody().mask("同步Aliexpress商品到ERP本地视图库.请稍等...","x-mask-loading");
				Ext.Ajax.request({
					url:'index.php?model=aliexpress&action=blukJoinUploadGood&ids='+ids,
					loadMask:true,
					timeout: 300000,
					success:function(response,opts){
						var res=Ext.decode(response.responseText);
						Ext.getBody().unmask();
						if(res.success){
							/*store.commitChanges();
							store.load({params:{                             
								goods_sn:Ext.getCmp('goods_sn').getValue(),
							}
							});*/
							Ext.Msg.alert('MSG',res.msg);
						}else{
							
						}
					},
                    failure:function(response){
                        Ext.getBody().unmask();
                        Ext.Msg.alert('ERROR','超时或者失败，请重试');
                    }
				});
			}
		}]
        })   
    },
    creatBbar: function() {
		var pagesize = this.pagesize;
        return Ext.create('Ext.toolbar.Paging', {          
            pageSize: 50,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,    
        })
		
		/*var store = this.store;
		var pagesize = this.pagesize;
        this.bbar =[{
			xtype: 'pagingtoolbar',
			plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:[
				'<a href="common/lib/download/aliexupdategoods.xls">示例模板下载</a>','-'Ext.create('Ext.form.Panel',{
					labelWidth: 75,
					frame:false,
					border:false,
					fileUpload:true,
					id:'imform',
					items: [{
							fieldLabel: 'xls更新文件',
							labelWidth:75,
							width:250,
							xtype: 'fileuploadfield',
							allowBlank:false,
							name:'file_path'
						}
					]
				}),{
				xtype:'button',
				text:'提交更新文件',
				iconCls:'x-tbar-import',
				handler:function(){
					if(Ext.getCmp('imform').getForm().isValid()){var ids = Ext.getCmp('account').getValue();
					if(ids=='0') {Ext.example.msg('提示','请先选择需要修改账号');return false;}
					Ext.getCmp('imform').getForm().submit({
						 url:'index.php?model=aliexpress&action=fileupdategoods&id='+Ext.getCmp('account').getValue(),
						 method:'post',
						 params:'',
						 success:function(form,action){
							if (action.result.success) {
								var searchWin = Ext.create('Ext.window.Window', {
									title : "更新完成",  
									id : 'searchWin',  
									width : 550,  
									height : 450,  
									html: action.result.msg,
									autoScroll : true,   
									modal : true,  
									bodyStyle : {  
										background : '#ffffff',  
										margin : 'auto'  
									}  
								})  
								//显示窗口  
								searchWin.show();  
								store.load({params:{
									status:Ext.getCmp('goods_status').getValue(),
									account:Ext.getCmp('account').getValue(),
									goods_sn:Ext.getCmp('goods_sn').getValue(),
									}
								});
							} else {
								Ext.Msg.alert('导入错误',action.result.msg);
							}
						 },
						 failure:function(form,action){
							Ext.Msg.alert('操作',action.result.msg);
						 }
					  });
					}
				}
			}
			]			   
			}];*/	
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
	},
	startdownshelf:function(id,account_id,skuCode,win){
		var sb = Ext.getCmp('basic-statusbar');
		Ext.Ajax.request({
			url: 'index.php?model=aliexpress&action=downshelf',
			params: {id:id,account_id:account_id},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					Ext.defer(function(){
						sb.setStatus({
							iconCls: 'x-status-valid',
							text: skuCode+'&nbsp;&nbsp;'+res.msg + '&nbsp;&nbsp;'+ Ext.Date.format(new Date(), 'G:i:s')
						});
					}, 1000);
					win.body.dom.innerHTML = win.body.dom.innerHTML+skuCode+'&nbsp;&nbsp;'+res.msg;
				}
			}
		});
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
            items: [/*{
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
            },*/
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
                    activate: function( ) {
                        doSelect('tab2', getid(), action)
                    }
                }
            },
            {
                id: 'tab5',
                title: '批量修改',
                 html: '<iframe style="padding:0;margin:0;" id="tab5_iframe" src="index.php?model=aliexpress&action=getskuattribute" width="100%" height="200" ></iframe>',
                listeners: {
                    activate: function() {
                        doSelect('tab5', getid(), action)
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
        var account = this.accountdata;
        Ext.getCmp('ali_status_id').setValue('onSelling');
        
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
	startonline:function(id,account_id,skuCode,win){
		var sb = Ext.getCmp('basic-statusbar');
		var me = this;
		Ext.Ajax.request({
			url: 'index.php?model=aliexpress&action=onlineshelf',
			params: {account_id:account_id,id:id},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					Ext.defer(function(){
						sb.setStatus({
							iconCls: 'x-status-valid',
							text: skuCode+'&nbsp;&nbsp;'+res.msg + '&nbsp;&nbsp;'+ Ext.Date.format(new Date(), 'G:i:s')
						});
					}, 1000);
					win.body.dom.innerHTML = win.body.dom.innerHTML+skuCode+'&nbsp;&nbsp;'+res.msg;
				}
			}
		});
	}
});

