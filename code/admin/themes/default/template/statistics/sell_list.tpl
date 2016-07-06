<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript">
var account = [<!--{$account}-->];
var Sales_channels=[<!--{$Sales_channels}-->];
account.push(['0','所有账户']);
Sales_channels.push(['0','所有渠道']);
Ext.chart.Chart.CHART_URL = 'common/lib/ext/resources/charts.swf';
Ext.onReady(function(){
	Ext.QuickTips.init();
	
	var store = Ext.create('Ext.data.JsonStore', {
		fields:['title','value'],
		remoteSort:true,
		proxy: {
			type: 'ajax',
			url:'index.php?model=Statistics&action=orderlist',
			actionMethods:{
				read: 'POST'
			},
			reader: {
				type: 'json',
				totalProperty: 'total',
				idProperty:'title',
				root: 'results'
			}
		}
	});
  	store.load();
	//统计数据
	var orderpanel = new Ext.Panel({
        title: '当天订单情况统计',
        renderTo: document.body,
        width:1000,
        height:200,
        layout:'fit',
		tbar:['-','StartTime',{	
								xtype:'datefield',
								id:'starttime',
								editable:false,
								format:'Y-m-d',
								value:new Date()
							
					   },'-','EndTime',{	
								xtype:'datefield',
								id:'endtime',
								editable:false,
								format:'Y-m-d',
								value:new Date()
							
					   },'-','选择账号',{
					  id: 'account',
					  xtype:'combo',
					  store: new Ext.data.SimpleStore({
										 fields: ["key", "key_account"],
										 data: account
									}),
						valueField :"key",
						displayField: "key_account",
						mode: 'local',
						editable: false,
						width:100,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'accounttype',
						name:'accounttype',
						value:0	//默认设置
				 
				 },'-','选择渠道',{
					  id: 'channels',
					  xtype:'combo',
					  store: new Ext.data.SimpleStore({
										 fields: ["key", "key_channels"],
										 data: Sales_channels
									}),
						valueField :"key",
						displayField: "key_channels",
						mode: 'local',
						editable: false,
						width:100,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'channelstype',
						name:'channelstype',
						value:0	//默认设置
				   
				   },'-','统计选择',{
					  id: 'time',
					  xtype:'combo',
					  store: new Ext.data.SimpleStore({
										 fields: ["key", "key_time"],
										 data: [['1','发货时间'],['2','付款时间']]
									}),
						valueField :"key",
						displayField: "key_time",
						mode: 'local',
						editable: false,
						width:100,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'timetype',
						name:'timetype',
						value:1	//默认设置
				   },'-',{
				   		xtype:'button',
						text:'统计',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({
								params:{
									starttime:Ext.fly('starttime').dom.value,
									endtime:Ext.fly('endtime').dom.value,
									account:Ext.getCmp('account').getValue(),
									channels:Ext.getCmp('channels').getValue(),
									timetype:Ext.getCmp('time').getValue()
								}
							});
						}				   
				   },'-',{
						text:'导出统计结果',
						xtype:'button',
						iconCls:'x-tbar-import',
						handler:function(){
							window.open().location.href='index.php?model=Statistics&action=orderlist'+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&endtime='+Ext.fly('endtime').dom.value+'&account='+Ext.getCmp('account').getValue()+'&channels='+Ext.getCmp('channels').getValue()+'&timetype='+Ext.getCmp('time').getValue();
						}
	 }],
        items: {
            xtype: 'columnchart',
			width:200,
            store: store,
            xField: 'title',
            yField: 'value',
        }
    });
	 var week_store = new Ext.data.Store({
			 proxy: new Ext.data.HttpProxy({url:'index.php?model=Statistics&action=weeklist'}),
			 reader: new Ext.data.JsonReader({
			 totalProperty: 'total',
			 root: 'result',
		}, [
			{name: 'order_amount'},
			{name: 'goods_amount'},
			{name: 'total_porfit'},
			{name: 'week'}
		]),
			remoteSort: true
		});



	//本周统计
	var weekpanel =  new Ext.Panel({
        iconCls:'chart',
        title: '本周订单统计',
        frame:true,
        renderTo: document.body,
        width:700,
        height:200,
        layout:'fit',
		tbar:['-','选择账号',{
				xtype:'combo',
				mode:'local',
				width:100,
				valueField:'week_account_id',
				displayField:'week_account',
				editable: false,		
				triggerAction:'all',
				id:'week_account',
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['week_account_id','week_account'],
							data: account
						})		

		},'-','选择渠道',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'week_channels_id',
				displayField:'week_channels',
				editable: false,		
				triggerAction:'all',
				width:100,
				id:'week_channels',
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['week_channels_id','week_channels'],
							data: Sales_channels
						})		

		},'-','统计方式',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'week_time_id',
				displayField:'week_time',
				editable: false,		
				triggerAction:'all',
				width:100,
				id:'week_time',
				value:'1',
				store:new Ext.data.SimpleStore({
							fields:['week_time_id','week_time'],
							data: [['1','发货时间'],['2','付款时间']]
						})		

		},'-',{
				xtype:'button',
				text:'统计',
				iconCls:'x-tbar-search',
				style:'padding:5px',
				handler:function(){
					week_store.load({
								params:{
									account:Ext.getCmp('week_account').getValue(),
									channels:Ext.getCmp('week_channels').getValue(),
									timetype:Ext.getCmp('week_time').getValue()
								}
							});
				}
		},'-',{
				text:'导出统计结果',
				xtype:'button',
				iconCls:'x-tbar-import',
				handler:function(){
					window.open().location.href='index.php?model=Statistics&action=weeklist'+'&type=export&account='+Ext.getCmp('week_account').getValue()+'&channels='+Ext.getCmp('week_channels').getValue()+'&timetype='+Ext.getCmp('week_time').getValue();
				}
	 }],
        items: {
            xtype: 'columnchart',
            store: week_store,
            url:'common/lib/ext/resources/charts.swf',
            xField: 'week',
            chartStyle: {
                padding: 10,
                animationEnabled: true,
                font: {
                    name: 'Tahoma',
                    color: 0x444444,
                    size: 11
                },
                dataTip: {
                    padding: 5,
                    border: {
                        color: 0x99bbe8,
                        size:1
                    },
                    background: {
                        color: 0xDAE7F6,
                        alpha: .9
                    },
                    font: {
                        name: 'Tahoma',
                        color: 0x15428B,
                        size: 10,
                        bold: true
                    }
                },
              xAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xeeeeee}
                },
                yAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xdfe8f6}
                }
            },
            series: [{
                type: 'line',
                displayName: '订单总金额',
                yField: 'order_amount',
                style: {
                    color: 0x009966
                }
            },{
                type:'line',
                displayName: '产品总金额',
                yField: 'goods_amount',
                style: {
                    color: 0xCC33FF
                }
            },{
                type:'line',
                displayName: '总利润',
                yField: 'total_porfit',
                style: {
                    color: 0x15428B
                }
            }]
        }
    });
	//月数据
	 var mon_store = new Ext.data.Store({
			 proxy: new Ext.data.HttpProxy({url:'index.php?model=Statistics&action=monlist'}),
			 reader: new Ext.data.JsonReader({
			 totalProperty: 'total',
			 root: 'result',
		}, [
			{name: 'mon_order_amount'},
			{name: 'mon_goods_amount'},
			{name: 'mon_total_porfit'},
			{name: 'day'}
		]),
			remoteSort: true
		});



	//月统计
	var moonpanel = new Ext.Panel({
        iconCls:'chart',
        title: '月订单统计',
        frame:true,
        renderTo: document.body,
        width:900,
        height:200,
        layout:'fit',
				tbar:['-','选择账号',{
				xtype:'combo',
				mode:'local',
				width:100,
				valueField:'mon_account_id',
				displayField:'mon_account',
				editable: false,	
				id:'mon_account',	
				triggerAction:'all',
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['mon_account_id','mon_account'],
							data: account
						})		

		},'-','选择渠道',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'mon_channels_id',
				displayField:'mon_channels',
				editable: false,		
				triggerAction:'all',
				id:'mon_channels',
				width:100,
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['mon_channels_id','mon_channels'],
							data: Sales_channels
						})		

		},'-','统计方式',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'mon_time_id',
				displayField:'mon_time',
				editable: false,		
				triggerAction:'all',
				id:'mon_time',
				width:100,
				value:'1',
				store:new Ext.data.SimpleStore({
							fields:['mon_time_id','mon_time'],
							data: [['1','发货时间'],['2','付款时间']]
						})		

		},'-',{
				xtype:'button',
				text:'检索',
				iconCls:'x-tbar-search',
				style:'padding:5px',
				handler:function(){
					mon_store.load({
								params:{
									account:Ext.getCmp('mon_account').getValue(),
									channels:Ext.getCmp('mon_channels').getValue(),
									timetype:Ext.getCmp('mon_time').getValue()
								}
							});
				}
		},'-',{
				text:'导出统计结果',
				xtype:'button',
				iconCls:'x-tbar-import',
				handler:function(){
					window.open().location.href='index.php?model=Statistics&action=monlist'+'&type=export&account='+Ext.getCmp('mon_account').getValue()+'&channels='+Ext.getCmp('mon_channels').getValue()+'&timetype='+Ext.getCmp('mon_time').getValue();
				}
	 }],
        items: {
            xtype: 'columnchart',
            store: mon_store,
            url:'common/lib/ext/resources/charts.swf',
            xField: 'day',
			
            chartStyle: {
                padding: 10,
                animationEnabled: true,
                font: {
                    name: 'Tahoma',
                    color: 0x444444,
                    size: 11
                },
                dataTip: {
                    padding: 5,
                    border: {
                        color: 0x99bbe8,
                        size:1
                    },
                    background: {
                        color: 0xDAE7F6,
                        alpha: .9
                    },
                    font: {
                        name: 'Tahoma',
                        color: 0x15428B,
                        size: 10,
                        bold: true
                    }
                },
                xAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xeeeeee}
                },
                yAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xdfe8f6}
                }
            },
            series: [{
                type: 'line',
                displayName: '订单总金额',
                yField: 'mon_order_amount',
                style: {
                    color:0x009966
                }
            },{
                type:'line',
                displayName: '产品总金额',
                yField: 'mon_goods_amount',
                style: {
                    color: 0xCC33FF
                }
            },{
                type:'line',
                displayName: '总利润',
                yField: 'mon_total_porfit',
                style: {
                    color: 0x15428B
                }
            }]
        }
    });
	//年数据
	 var year_store = new Ext.data.Store({
			 proxy: new Ext.data.HttpProxy({url:'index.php?model=Statistics&action=yearlist'}),
			 reader: new Ext.data.JsonReader({
			 totalProperty: 'total',
			 root: 'result',
		}, [
			{name: 'year_order_amount'},
			{name: 'year_goods_amount'},
			{name: 'year_total_porfit'},
			{name: 'mon'}
		]),
			remoteSort: true
		});
		


	//今年统计
	 new Ext.Panel({
        iconCls:'chart',
        title: '年发货统计',
        frame:true,
        renderTo: document.body,
        width:700,
        height:200,
        layout:'fit',
				tbar:['-','选择账号',{
				xtype:'combo',
				mode:'local',
				width:100,
				valueField:'year_account_id',
				displayField:'year_account',
				id:'year_account',
				editable: false,		
				triggerAction:'all',
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['year_account_id','year_account'],
							data: account
						})		

		},'-','选择渠道',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'year_channels_id',
				displayField:'year_channels',
				editable: false,		
				triggerAction:'all',
				width:100,
				id:'year_channels',
				value:0,
				store:new Ext.data.SimpleStore({
							fields:['year_channels_id','year_channels'],
							data: Sales_channels
						})		

		},'-','统计方式',{				
				xtype:'combo',
				baseCls:'x-plain',
				mode:'local',
				valueField:'year_time_id',
				displayField:'year_time',
				editable: false,		
				triggerAction:'all',
				width:100,
				id:'year_time',
				value:1,
				store:new Ext.data.SimpleStore({
							fields:['year_time_id','year_time'],
							data: [['1','发货时间'],['2','付款时间']]
						})		

		},'-',{
				xtype:'button',
				text:'检索',
				iconCls:'x-tbar-search',
				style:'padding:5px',
				handler:function(){
					year_store.load({
								params:{
									account:Ext.getCmp('year_account').getValue(),
									channels:Ext.getCmp('year_channels').getValue(),
									timetype:Ext.getCmp('year_time').getValue()
								}
							});
				}
		},'-',{
				text:'导出统计结果',
				xtype:'button',
				iconCls:'x-tbar-import',
				handler:function(){
					window.open().location.href='index.php?model=Statistics&action=yearlist'+'&type=export&account='+Ext.getCmp('year_account').getValue()+'&channels='+Ext.getCmp('year_channels').getValue()+'&timetype='+Ext.getCmp('year_time').getValue();
				}
	 }],
        items: {
            xtype: 'columnchart',
            store: year_store,
            url:'common/lib/ext/resources/charts.swf',
            xField: 'mon',
            chartStyle: {
                padding: 10,
                animationEnabled: true,
                font: {
                    name: 'Tahoma',
                    color: 0x444444,
                    size: 11
                },
                dataTip: {
                    padding: 5,
                    border: {
                        color: 0x99bbe8,
                        size:1
                    },
                    background: {
                        color: 0xDAE7F6,
                        alpha: .9
                    },
                    font: {
                        name: 'Tahoma',
                        color: 0x15428B,
                        size: 10,
                        bold: true
                    }
                },
                xAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xeeeeee}
                },
                yAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xdfe8f6}
                }
            },
            series: [{
                type: 'line',
                displayName: '订单总金额',
                yField: 'year_order_amount',
                style: {
                    color:0x009966
                }
            },{
                type:'line',
                displayName: '产品总金额',
                yField: 'year_goods_amount',
                style: {
                    color: 0xCC33FF
                }
            },{
                type:'line',
                displayName: '总利润',
                yField: 'year_total_porfit',
                style: {
                    color: 0x15428B
                }
            }]
        }
    });	
	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->