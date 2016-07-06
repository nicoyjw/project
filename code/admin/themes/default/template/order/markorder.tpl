<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/grouping.css" />
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
Ext.QuickTips.init();
var account = [<!--{$account}-->];
var aliaccount = [<!--{$aliaccount}-->];
var dhaccount = [<!--{$dhaccount}-->];
var shipping_id = [<!--{$shipping}-->];
var msgWindow = showWindow('开始自动标记');
var arr = object_Array(account);
var shipping = object_Array(shipping_id);
 var t = Ext.create('Ext.grid.feature.Grouping',{
        groupHeaderTpl: '{name}账号待标记订单数量: ({[values.rows.length]}个订单)',
        hideGroupedHeader: false
    });
function showaccount(val){
	return arr[val];
}
function showshipping(val){
	return shipping[val];
}
var account_combo = Ext.create('Ext.form.field.ComboBox',{
	            store: Ext.create('Ext.data.ArrayStore',{
	                    fields: ["retrunValue", "displayText"],
	                    data: account
	                    }),
	             valueField :"retrunValue",
	              displayField: "displayText",
	              mode: 'local',
				  allowBlank:false,
				  blankText:'不能为空',
	              editable: false,
				  width:250,
				  labelWidth:65,
	              forceSelection: true,
	              triggerAction: 'all',
	              hiddenName:'account',
	              fieldLabel: '选择帐户',
	              emptyText:'选择',
	              name: 'account',
				  id:'account_combo'
	});

var sb = Ext.getCmp('basic-statusbar');
	var store = Ext.create('Ext.data.JsonStore', {
		fields:['order_id','Sales_account_id','order_sn','shipping_id','userid','track_no','account_name'],
		autoLoad:true,
		groupField:'account_name',
		proxy: {
			type: 'ajax',
			url:'index.php?model=order&action=waitmark',
			actionMethods:{
				read: 'POST'
			},
			reader: {
				type: 'json',
				idProperty:'order_id',
				root: 'topics'
			}
		},
	})
    var grid = Ext.create('Ext.grid.Panel',{
        store: store,
        columns: [
            {header: "id", flex:1,hidden:true, sortable: true, dataIndex: 'order_id'},
			{header: "帐号名", flex:1,hidden:true,dataIndex: 'account_name'},
			{header: "账号",flex:1,hidden:true, dataIndex: 'Sales_account_id',renderer:showaccount},
            {header: "订单号", flex:1, sortable: true, dataIndex: 'order_sn'},
            {header: "Buyer", flex:1, sortable: true, dataIndex: 'userid'},
			{header: "快递方式",flex:1,dataIndex: 'shipping_id',renderer:showshipping},
            {header: "追踪单号", flex:1, sortable: true, dataIndex: 'track_no'}
        ],
        features: [t],
		tbar:[account_combo,{
				xtype:'button',
				text:'开始标记',
				handler:function(){
						startcheck();
						}
				},{
                    xtype:'button',
                    text:'刷新',
                    iconCls:'x-tbar-advsearch',
                    handler:function(){store.load();}
                },'->','重新标记,(eBay或ERP订单号,多个逗号分割)',{
                    xtype:'textfield',
                    hiddenLabel:true,
                    name:'remark_ali',
                    labelWidth:190,
                    width:160,
                    id:'remark_ebay'
                },
                {xtype:'button',
                    text:'确定',
                    iconCls:'x-tbar-advsearch',
                    handler:function(){
                         Ext.getBody().mask("waiting...", "x-mask-loading");
                         Ext.Ajax.request({  
                            url: 'index.php?model=order&action=remark_order',
                            method: 'post',
                            params:{ids:Ext.getCmp('remark_ebay').getValue()},             
                            success:function(response){               
                                res = Ext.decode(response.responseText); 
                                if(res.success){ 
                                    Ext.getBody().unmask();
                                    store.load();
                                    Ext.example.msg('MSG',res.msg);
                                }else{
                                    Ext.getBody().unmask();
                                    Ext.example.msg('ERROR',res.msg);
                                }
                            },
                            failure: function(response) {
                                Ext.getBody().unmask();
                                Ext.example.msg('警告','更新失败');
                            }
                        })
                        
                    }
                }
                
                ],
		loadMask:true,
        frame:true,
        width: 400,
        autoHeight: true,
        title: 'Ebay待标记列表'
    });
	
	var store2 = Ext.create('Ext.data.JsonStore', {
			fields:['Sales_account_id','account','num'],
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=order&action=amazonwaitmark',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'Sales_account_id',
					root: 'topics'
				}
			}
		})
	
	var grid2 =Ext.create('Ext.grid.Panel',{
        store: store2,
        columns: [
            {header: "id", flex:1,hidden:true, dataIndex: 'Sales_account_id'},
			{header: "账号",flex:1.5,dataIndex: 'account'},
            {header: "待标记数量", flex:2, dataIndex: 'num'},
            {
				  header:'操作',
				  width:65,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '标记订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = store2.getAt(rowIndex).get('Sales_account_id');
							parent.openWindow(id,'标记Amazon订单','index.php?model=order&action=amazonmark&id='+id,1000,680);
						}
				  }]
			}
        ],
		tbar:Ext.create('Ext.toolbar.Toolbar',{
			items:[
				{
					xtype:'button',
					text:'刷新',
					iconCls:'x-tbar-advsearch',
					handler:function(){store2.load();}
				}
			]}),
		loadMask:true,
        frame:true,
        width: 400,
        height: 450,
        title: 'Amazon待标记列表'
    });	
	var store3 = Ext.create('Ext.data.JsonStore', {
			fields:['order_id','Sales_account_id','order_sn','shipping_id','userid','track_no','account','paypalid'],
			autoLoad:true,
			groupField:'account',
			proxy: {
				type: 'ajax',
				url:'index.php?model=order&action=AliexpressWaitmark',
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					idProperty:'order_id',
					root: 'topics'
				}
			}
		})
	var d = Ext.create('Ext.grid.feature.Grouping',{
        groupHeaderTpl: '{name}账号待标记订单数量: ({[values.rows.length]}个订单)',
        hideGroupedHeader: true
    });
    
    
   /* Ext.create('Ext.ux.StatusBar', {
            id: 'ali-basic-statusbar',
            border:true,
            frame:true,
            defaultText: 'Begin Marking',
            text: '',
            items: []
        })*/
    
    
    
	var grid3 =Ext.create('Ext.grid.Panel',{
        store: store3,
        columns: [
           {header: "id", flex:1,hidden:true, sortable: true, dataIndex: 'order_id'},
			{header: "账号",flex:1,hidden:true, dataIndex: 'Sales_account_id',renderer:showaccount},
            {header: "订单号", flex:1, sortable: true, dataIndex: 'order_sn'},
            {header: "Buyer", flex:1, sortable: true, dataIndex: 'userid'},
            {header: "快递方式",flex:1,dataIndex: 'shipping_id',renderer:showshipping},
			{header: "Aliexpress订单号",sortable: true,flex:1,dataIndex: 'paypalid'},
            {header: "追踪单号", flex:1, sortable: true, dataIndex: 'track_no'},
            {
			  header:'操作',
			  flex:1,
			  xtype: 'actioncolumn',
			  items:[{
					icon   : 'themes/default/images/update.gif',	 
					tooltip: '标记订单',
					handler: function(grid, rowIndex, colIndex) {
						var id = store3.getAt(rowIndex).get('order_id');
						parent.openWindow(id,'标记Aliexpress订单','index.php?model=order&action=alimark&id='+id,1000,680);
					}
			  }]
			}
        ],
        features: [d],
		tbar:Ext.create('Ext.toolbar.Toolbar',{
			items:[Ext.create('Ext.form.field.ComboBox',{
	            store: Ext.create('Ext.data.ArrayStore',{
				fields: ["retrunValue", "displayText"],
							data: aliaccount
						}),
					 valueField :"retrunValue",
					  displayField: "displayText",
					  mode: 'local',
					  allowBlank:false,
					  blankText:'不能为空',
					  editable: false,
					  width:280,
					  labelWidth:65,
					  forceSelection: true,
					  triggerAction: 'all',
					  hiddenName:'aliaccount',
					  fieldLabel: '选择帐户',
					  emptyText:'选择',
					  name: 'aliaccount',
					  id:'aliaccount_combo'
				}),'-',{
					xtype:'datefield',
					id: 'paid_time',
					fieldLabel:'付款时间',
					allowBlank:false,
					labelWidth:65,
					width:160,
					format:'Y-m-d',
					maxValue: new Date() ,  
					listeners: {  
						select:function(field,value,eOpts ){ 
						//alert(Ext.Date.dateFormat(Ext.getCmp('paid_time').getValue(), 'Y-m-d'));return;
							store3.load({params:{id:Ext.getCmp('aliaccount_combo').getValue(),paid_time:Ext.Date.dateFormat(Ext.getCmp('paid_time').getValue(), 'Y-m-d')}});
						}  
					}  
				},'-',{
					xtype:'button',
					text:'开始标记',
					id:'btn',
					handler:function(){
						var aliaccount_id = Ext.getCmp('aliaccount_combo').getValue();
						var sb = Ext.create('Ext.ux.StatusBar', {
                            id: 'ali-basic-statusbar',
                            border:true,
                            frame:true,
                            defaultText: 'Begin Marking',
                            text: '',
                            items: []
                        });
                                                            
                        if(!aliaccount_id == ''){
                            msgWindow.show();
                            sb.showBusy();             
                            msgWindow.body.dom.innerHTML = '';
                            msgWindow.body.dom.innerHTML = '正在声明发货,可能需要花费数分钟时间,请耐心等候...<br/><br/><br/>';        
                           
                           
                            Ext.getCmp('btn').disable();
                            Ext.Ajax.request({
                                url:'index.php?model=order&action=alimarks&id='+aliaccount_id+'&paid_time='+Ext.Date.dateFormat(Ext.getCmp('paid_time').getValue(), 'Y-m-d'),     
                                params:'',
                                timeout: 180000,
                                success:function(response,opts){
                                    var res = Ext.decode(response.responseText);
                                    if(res.success){
                                        
                                        
                                        
                                        sb.setStatus({
                                            text: res.msg,
                                            iconCls: 'x-status-valid',
                                            clear: false
                                        });
                                        store3.load();
                                        Ext.getCmp('btn').enable();
                                        
                                    }else{
                                        sb.setStatus({
                                            text: res.msg,
                                            iconCls: 'x-status-error',
                                            clear: true
                                        });
                                        Ext.getCmp('btn').enable();
                                    }
                                    msgWindow.body.dom.innerHTML = msgWindow.body.dom.innerHTML+res.msg;         
                                },
                                failure:function(response){
                                        Ext.getCmp('btn').enable();
                                        sb.setStatus({
                                            text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                            iconCls: 'x-status-error',
                                            clear: false
                                        });
                                    }
                            })
                        }
                        
						/*sb.showBusy();
						sb.setText('正在声明发货,可能需要花费数分钟时间,请耐心等候...');
						Ext.getCmp('btn').disable();
						Ext.Ajax.request({
							url:'index.php?model=order&action=alimarks&id='+aliaccount_id+'&paid_time='+Ext.Date.dateFormat(Ext.getCmp('paid_time').getValue(), 'Y-m-d'),	 
							params:'',
							timeout: 180000,
							success:function(response,opts){
								var res = Ext.decode(response.responseText);
								if(res.success){
									sb.setStatus({
										text: res.msg,
										iconCls: 'x-status-valid',
										clear: false
									});
									store3.load();
									Ext.getCmp('btn').enable();
								}else{
									sb.setStatus({
										text: res.msg,
										iconCls: 'x-status-error',
										clear: true
									});
									Ext.getCmp('btn').enable();
								}
							},
							failure:function(response){
									Ext.getCmp('btn').enable();
									sb.setStatus({
										text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
										iconCls: 'x-status-error',
										clear: false
									});
								}
						})*/
						}
				},'-',{
						xtype:'button',
						text:'刷新',
						iconCls:'x-tbar-advsearch',
						handler:function(){store3.load();}
				},'->','重新标记,(Aliexpress或ERP订单号,逗号分割)',{
                    xtype:'textfield',
                    hiddenLabel:true,
                    name:'remark_ali',
                    labelWidth:190,
                    width:160,
                    id:'remark_ali'
                },
                {xtype:'button',
                    text:'确定',
                    iconCls:'x-tbar-advsearch',
                    handler:function(){
                         Ext.getBody().mask("waiting...", "x-mask-loading");
                         Ext.Ajax.request({  
                            url: 'index.php?model=order&action=remark_order',
                            method: 'post',
                            params:{ids:Ext.getCmp('remark_ali').getValue()},             
                            success:function(response){               
                                res = Ext.decode(response.responseText); 
                                if(res.success){ 
                                    Ext.getBody().unmask();
                                    store3.load();
                                    Ext.example.msg('MSG',res.msg);
                                }else{
                                    Ext.getBody().unmask();
                                    Ext.example.msg('ERROR',res.msg);
                                }
                            },
                            failure: function(response) {
                                Ext.getBody().unmask();
                                Ext.example.msg('警告','更新失败');
                            }
                        })
                        
                    }
                }
			]}),
		loadMask:true,
        frame:true,
        width: 400,
        height: 350,
        title: 'Aliexpress待标记列表'                        
    });
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    var w = Ext.create('Ext.grid.feature.Grouping',{
        groupHeaderTpl: '{name}账号待标记订单数量: ({[values.rows.length]}个订单)',
        hideGroupedHeader: true
    });
    
     var store4 = Ext.create('Ext.data.JsonStore', {
            fields:['order_id','Sales_account_id','order_sn','shipping_id','userid','track_no','account','paypalid'],
            autoLoad:true,
            groupField:'account',
            proxy: {
                type: 'ajax',
                url:'index.php?model=order&action=DHgateWaitmark',
                actionMethods:{
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    idProperty:'order_id',
                    root: 'topics'
                }
            }
        })    
    var grid4 =Ext.create('Ext.grid.Panel',{
        store: store4,
        columns: [
           {header: "id", flex:1,hidden:true, sortable: true, dataIndex: 'order_id'},
            {header: "账号",flex:1,hidden:true, dataIndex: 'Sales_account_id',renderer:showaccount},
            {header: "订单号", flex:1, sortable: true, dataIndex: 'order_sn'},
            {header: "Buyer", flex:1, sortable: true, dataIndex: 'userid'},
            {header: "快递方式",flex:1,dataIndex: 'shipping_id',renderer:showshipping},
            {header: "DHgate订单号",sortable: true,flex:1,dataIndex: 'paypalid'},
            {header: "追踪单号", flex:1, sortable: true, dataIndex: 'track_no'},
            {
              header:'操作',
              flex:1,
              xtype: 'actioncolumn',
              items:[{
                    icon   : 'themes/default/images/update.gif',     
                    tooltip: '标记订单',
                    handler: function(grid, rowIndex, colIndex) {
                        var id = store4.getAt(rowIndex).get('order_id');
                        parent.openWindow(id,'标记DHgate订单','index.php?model=order&action=DHgatemark&id='+id,1000,680);
                    }
              }]
            }
        ],
        features: [w],
        tbar:Ext.create('Ext.toolbar.Toolbar',{
            items:[Ext.create('Ext.form.field.ComboBox',{
                store: Ext.create('Ext.data.ArrayStore',{
                fields: ["retrunValue", "displayText"],
                            data: dhaccount
                        }),
                     valueField :"retrunValue",
                      displayField: "displayText",
                      mode: 'local',
                      allowBlank:false,
                      blankText:'不能为空',
                      editable: false,
                      width:300,
                      labelWidth:65,
                      forceSelection: true,
                      triggerAction: 'all',
                      hiddenName:'dhaccount',
                      fieldLabel: '选择帐户',
                      emptyText:'选择',
                      name: 'dhaccount',
                      id:'dhaccount_combo'
                }),'-',{
                    xtype:'button',
                    text:'开始标记',
                    id:'dhbtn',
                    handler:function(){
                        var dhaccount_id = Ext.getCmp('dhaccount_combo').getValue();
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在声明发货,可能需要花费数分钟时间,请耐心等候...');
                        Ext.getCmp('dhbtn').disable();
                        Ext.Ajax.request({
                            url:'index.php?model=order&action=alimarks&id='+dhaccount_id,     
                            params:'',
                            timeout: 180000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                    store4.load();
                                    Ext.getCmp('dhbtn').enable();
                                }else{
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                    Ext.getCmp('dhbtn').enable();
                                }
                            },
                            failure:function(response){
                                    Ext.getCmp('btn').enable();
                                    sb.setStatus({
                                        text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
                                        iconCls: 'x-status-error',
                                        clear: false
                                    });
                                }
                        })
                        }
                },'-',{
                        xtype:'button',
                        text:'刷新',
                        iconCls:'x-tbar-advsearch',
                        handler:function(){store4.load();}
                },'->','重新标记,(DHgate或ERP订单号,逗号分割)',{
                    xtype:'textfield',
                    hiddenLabel:true,
                    name:'remark_dh',
                    labelWidth:190,
                    width:160,
                    id:'remark_dh'
                },
                {xtype:'button',
                    text:'确定',
                    iconCls:'x-tbar-advsearch',
                    handler:function(){
                         Ext.getBody().mask("waiting...", "x-mask-loading");
                         Ext.Ajax.request({  
                            url: 'index.php?model=order&action=remark_order',
                            method: 'post',
                            params:{ids:Ext.getCmp('remark_dh').getValue()},             
                            success:function(response){               
                                res = Ext.decode(response.responseText); 
                                if(res.success){ 
                                    Ext.getBody().unmask();
                                    store4.load();
                                    Ext.example.msg('MSG',res.msg);
                                }else{
                                    Ext.getBody().unmask();
                                    Ext.example.msg('ERROR',res.msg);
                                }
                            },
                            failure: function(response) {
                                Ext.getBody().unmask();
                                Ext.example.msg('警告','更新失败');
                            }
                        })
                        
                    }
                }
            ]}),
        loadMask:true,
        frame:true,
        width: 400,
        height: 350,
        title: 'DHgate待标记列表',
        bbar: Ext.create('Ext.ux.StatusBar', {
            id: 'basic-statusbar',
            border:true,
            frame:true,
            defaultText: 'Begin Marking',
            text: '',
            items: []
        })
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    	
var tab = Ext.create('Ext.tab.Panel',{
    renderTo: Ext.getBody(),
    activeTab: 0,
    renderTo: document.body,
    items: [grid,grid2,grid3,grid4]
});

function startcheck(){
	var account_id = Ext.getCmp('account_combo').getValue();
	if(!account_id == ''){
		msgWindow.show();
		sb.showBusy();
		addText('开始标记'+arr[account_id]+'账号订单<br>');
		midStart(0);
	}
}

function midStart(num){
	var account_id = Ext.getCmp('account_combo').getValue();
		var records=store.queryBy(function(record,id){
			return record.get("Sales_account_id") == account_id;
		}).getRange();
		if(records.length == 0){
			addText('该账户没有需要标记的订单');
		}
		if(num<records.length){
			var track_no = records[num].data.track_no;
			var orderid = records[num].data.order_id;
			var shipping_id = records[num].data.shipping_id;
			ajaxHading(account_id,track_no,orderid,shipping_id,num);
		}else{
		sb.clearStatus();
		sb.setText('标记完成');
		store.load();
		}
}
function ajaxHading(account_id,track_no,orderid,shipping_id,num){
			Ext.Ajax.request({
					url:'index.php?model=order&action=ajaxmark',
					timeout:600000,
					success:function(response){
							addText(response.responseText);
							midStart(num+1);
							},
					failure:function(response){
							addText(response.responseText);
							sb.setStatus({
							text: 'Oops!',
							iconCls: 'x-status-error',
							clear: true 
							});
							},
					params:{account_id:account_id,track_no:track_no,orderid:orderid,shipping:shipping_id}
					});
}
function addText(str){
	msgWindow.body.dom.innerHTML = msgWindow.body.dom.innerHTML+str;
}
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
