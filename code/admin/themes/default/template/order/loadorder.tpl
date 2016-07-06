<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';

    var top = Ext.create('Ext.form.Panel',{
		id:'loadform',
        buttonAlign:'center',
		labelWidth:70,
		height:170,
        frame:true,
        title: 'Ebay订单加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
			xtype:'panel',
			border:false,
			layout:'hbox',
			items:[{
				xtype:'datefield',
				id: 'start',
				fieldLabel:'开始时间',
				allowBlank:false,
				labelWidth:80,
				width:200,
				value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
				maxValue:'<!--{$today}-->',
				format:'Y-m-d'
	        },{
				xtype:'timefield',
				id: 'stime',
				format:'G',
				increment:60,
				width:60,
				value:'0',
				allowBlank:false
	        }]
		},{
			xtype:'panel',
			layout:'hbox',
			border:false,
			items:[{
				xtype:'datefield',
				fieldLabel:'结束时间',
				id: 'end',
				allowBlank:false,
				labelWidth:80,
				width:200,
				value:'<!--{$today}-->',
				maxValue:'<!--{$today}-->',
				format:'Y-m-d'
	        },{
				xtype:'timefield',
				id: 'etime',
				format:'G',
				increment:60,
				width:60,
				value:'23',
				allowBlank:false
	        }]
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: [<!--{$account}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
			labelWidth:80,
			width:260,
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载订单',
			handler:function(){
				if(top.getForm().isValid()){
						//msgWindow.show();
						var id = top.getForm().getFieldValues().id;
						var starttime= 	Ext.Date.format(Ext.getCmp('start').getValue(),'Y-m-d');
						var endtime = 	Ext.Date.format(Ext.getCmp('end').getValue(),'Y-m-d');
						parent.newTab('ebayload','加载订单','index.php?model=order&action=load&id='+id+'&start='+starttime+'&end='+endtime+'&stime='+Ext.getCmp('stime').getValue()+'&etime='+Ext.getCmp('etime').getValue());

				}
			}
        },{
        	text: '重置',
			handler:function(){top.getForm().reset();}
        }]
    });
    var az = Ext.create('Ext.form.Panel',{
		id:'azform',
        buttonAlign:'center',
		labelWidth:70,
        frame:true,
        title: 'Amazon订单加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始时间',
	        name: 'start',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			format:'Y-m-d',
			value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	    	xtype:'datefield',
	        fieldLabel: '结束时间',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			value:'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: [<!--{$amazonaccount}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
			width:250,
			labelWidth:80,
	        fieldLabel: 'amazon账号',
	        emptyText:'选择Amazon账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],
        buttons: [{
            text: '加载订单',
			handler:function(){
				if(az.getForm().isValid()){
						//msgWindow.show();
						var id = az.getForm().getFieldValues().id;
						var starttime=	Ext.Date.format(az.getForm().getFieldValues().start,'Y-m-d');
						var endtime = 	Ext.Date.format(az.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('azload','加载订单','index.php?model=order&action=loadaz&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
            text: '加载失败产品',
			handler:function(){
				if(az.getForm().isValid()){
						//msgWindow.show();
						var id = az.getForm().getFieldValues().id;
						var starttime=	Ext.Date.format(az.getForm().getFieldValues().start,'Y-m-d');
						var endtime = 	Ext.Date.format(az.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('azload','加载订单','index.php?model=order&action=loadazitem&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){az.getForm().reset();}
        }]
    });
    var zencart = Ext.create('Ext.form.Panel',{
		id:'zcform',
        buttonAlign:'center',
		labelWidth:70,
        frame:true,
        title: 'zencart订单加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始时间',
	        name: 'start',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			format:'Y-m-d',
			value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	    	xtype:'datefield',
	        fieldLabel: '结束时间',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			value:'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data:[<!--{$zcaccount}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
			width:250,
			labelWidth:80,
	        fieldLabel: 'zencart账号',
	        emptyText:'选择zencart账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载订单',
			handler:function(){
				if(zencart.getForm().isValid()){
						//msgWindow.show();
						var id = zencart.getForm().getFieldValues().id;
						var starttime=	Ext.Date.format(zencart.getForm().getFieldValues().start,'Y-m-d');
						var endtime = 	Ext.Date.format(zencart.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('zcload','加载订单','index.php?model=order&action=loadzc&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){zencart.getForm().reset();}
        }]
    });	
    var tb = Ext.create('Ext.form.Panel',{
		id:'tbform',
        buttonAlign:'center',
		labelWidth:70,
        frame:true,
        title: '淘宝订单加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始创建',
	        name: 'start',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			format:'Y-m-d',
			value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	    	xtype:'datefield',
	        fieldLabel: '结束创建',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			value:'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->'
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data:[<!--{$tbaccount}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
			width:250,
			labelWidth:80,
	        fieldLabel: '淘宝账号',
	        emptyText:'选择淘宝账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载订单',
			handler:function(){
				if(tb.getForm().isValid()){
						//msgWindow.show();
						var id = tb.getForm().getFieldValues().id;
						var starttime=Ext.Date.format(tb.getForm().getFieldValues().start,'Y-m-d');
						var endtime = Ext.Date.format(tb.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('ebayload','加载订单','index.php?model=order&action=loadtb&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){top.getForm().reset();}
        }]
    });

    var paypal = Ext.create('Ext.form.Panel',{
        buttonAlign:'center',
		labelWidth:70,
        frame:true,
        title: 'Paypal单据加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始时间',
	        name: 'start',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			format:'Y-m-d',
			value:'<!--{$dday}-->',
			maxValue:'<!--{$today}-->'
		},{
	    	xtype:'datefield',
	        fieldLabel: '结束时间',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			value:'<!--{$dday}-->',
			maxValue:'<!--{$today}-->'
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["p_root_id", "paypal_account"],
	             data: [<!--{$paccount}-->]
	        }),
	        valueField :"p_root_id",
	        displayField: "paypal_account",
	        mode: 'local',
	        editable: false,
			width:250,
			labelWidth:80,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'p_root_id',
	        fieldLabel: 'Paypal账号',
	        emptyText:'选择Paypal账号',
	        name: 'p_root_id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载订单',
			handler:function(){
				if(paypal.getForm().isValid()){
						//msgWindow.show();
						var id = paypal.getForm().getFieldValues().p_root_id;
						var starttime=Ext.Date.format(paypal.getForm().getFieldValues().start,'Y-m-d');
						var endtime = Ext.Date.format(paypal.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('paypalload','加载paypal款单','index.php?model=order&action=loadpaypal&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){top.getForm().reset();}
        }]
    });	
	var aliexpress = Ext.create('Ext.form.Panel',{
        buttonAlign:'center',
        labelWidth:170,
        frame:true,
        title: 'aliexpress订单加载',
        bodyStyle:'padding:25px',
        style:'margin:10px',
        width:650,
        autoHeight:true,
        items: [{
                layout:'column',
                border:false,
                items:[
                    {
                        columnWidth:.5,
                        border:false,
                        id:'loadstatus',
                        items:[
                            {
                                xtype:'checkbox',
                                fieldLabel: '等待买家付款',
                                name:'PLACE_ORDER_SUCCESS',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '买家申请取消',
                                name:'IN_CANCEL',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '等待您发货',
                                name:'WAIT_SELLER_SEND_GOODS',
                                checked:true,
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '部分发货',
                                name:'SELLER_PART_SEND_GOODS',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '等待买家收货',
                                name:'WAIT_BUYER_ACCEPT_GOODS',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '买家确认收货后,等待退放款处理的状态',
                                name:'FUND_PROCESSING',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '已结束的订单',
                                name:'FINISH',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '含纠纷的订单',
                                name:'ISSUE',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '冻结中的订单',
                                name:'IN_FROZEN',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '等待您确认金额',
                                name:'WAIT_SELLER_EXAMINE_MONEY',
                                labelWidth:150,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '资金未到账',
                                name:'RISK_CONTROL',
                                labelWidth:150,
                                }
                        ]
                    },{
                        columnWidth:.5,
                        border:false,
                        items:[{
                                xtype:'checkbox',
                                fieldLabel:'自动同步',
                                id:'autoload',
                                name:'autoload',
                                width:250,
                                hidden:true,
                                labelWidth:105,
                                checked:false,
                            },{
                                xtype:'combo',
                                store: Ext.create('Ext.data.ArrayStore',{
                                     fields: ["id", "value"],
                                     data:[['1','8小时'],['2','12小时'],['3','一天'],['4','两天'],['5','一周']]
                                }),
                                valueField :"id",
                                displayField: "value",
                                mode: 'local',
                                editable: false,
                                hidden:true,
                                forceSelection: true,
                                triggerAction: 'all',
                                width:250,
                                labelWidth:105,
                                hiddenName:'loadtime',
                                fieldLabel: '同步时间',
                                emptyText:'请选择时间',
                                id:'loadtime',
                                name:'loadtime',
                                allowBlank:true,
                                blankText:'请选择'
                                },{
                                xtype:'checkbox',
                                fieldLabel:'同时同步产品到产品库',
                                id:'loadgood',
                                name:'loadgood',
                                hidden:true,
                                width:250,
                                labelWidth:140,
                                checked:false,
                            },
                            {
                                xtype:'datefield',
                                fieldLabel: '开始时间',
                                name: 'start',
                                allowBlank:false,
                                width:250,
                                labelWidth:105,
                                format:'Y-m-d',
                                value:'<!--{$dday}-->',
                                maxValue:'<!--{$today}-->'
                            },{
                                xtype:'datefield',
                                fieldLabel: '结束时间',
                                name: 'end',
                                format:'Y-m-d',
                                allowBlank:false,
                                width:250,
                                labelWidth:105,
                                value:'<!--{$today}-->',
                                maxValue:'<!--{$today}-->'
                            },{
                                xtype:'combo',
                                store: Ext.create('Ext.data.ArrayStore',{
                                     fields: ["id", "account_name"],
                                     data:[<!--{$aliaccount}-->]
                                }),
                                valueField :"id",
                                displayField: "account_name",
                                mode: 'local',
                                editable: false,
                                forceSelection: true,
                                triggerAction: 'all',
                                width:280,
                                labelWidth:105,
                                hiddenName:'id',
                                fieldLabel: 'aliaccount账号',
                                emptyText:'选择aliaccount账号',
                                name: 'id',
                                allowBlank:false,
                                blankText:'请选择'
                                },
                                {
                                text: '加载订单',
                                xtype:'button',
                                handler:function(){
                                    if(aliexpress.getForm().isValid()){
                                        var str = '';
                                        str += "&PLACE_ORDER_SUCCESS="+aliexpress.getForm().getFieldValues().PLACE_ORDER_SUCCESS;
                                        str += "&IN_CANCEL="+aliexpress.getForm().getFieldValues().IN_CANCEL;
                                        str += "&WAIT_SELLER_SEND_GOODS="+aliexpress.getForm().getFieldValues().WAIT_SELLER_SEND_GOODS;
                                        str += "&SELLER_PART_SEND_GOODS="+aliexpress.getForm().getFieldValues().SELLER_PART_SEND_GOODS;
                                        str += "&WAIT_BUYER_ACCEPT_GOODS="+aliexpress.getForm().getFieldValues().WAIT_BUYER_ACCEPT_GOODS;
                                        str += "&FUND_PROCESSING="+aliexpress.getForm().getFieldValues().FUND_PROCESSING;
                                        str += "&FINISH="+aliexpress.getForm().getFieldValues().FINISH;
                                        str += "&IN_ISSUE="+aliexpress.getForm().getFieldValues().IN_ISSUE;
                                        str += "&IN_FROZEN="+aliexpress.getForm().getFieldValues().IN_FROZEN;
                                        str += "&WAIT_SELLER_EXAMINE_MONEY="+aliexpress.getForm().getFieldValues().WAIT_SELLER_EXAMINE_MONEY;
                                        str += "&RISK_CONTROL="+aliexpress.getForm().getFieldValues().RISK_CONTROL;
                                        var isloadgood = aliexpress.getForm().getFieldValues().loadgood;
                                        //alert(isloadgood);return;
                                        var id = aliexpress.getForm().getFieldValues().id;
                                        var starttime=    Ext.Date.format(aliexpress.getForm().getFieldValues().start,'Y-m-d');
                                        var endtime =     Ext.Date.format(aliexpress.getForm().getFieldValues().end,'Y-m-d'); 
                                        var isautoload = aliexpress.getForm().getFieldValues().autoload;
                                        if(isautoload){
                                            var loadstr = aliexpress.getForm().getFieldValues().loadtime;
                                        }else{
                                            var loadstr = '';
                                        }
                                    //alert('index.php?model=aliexpress&action=LoadAliOrder&id='+id+'&start='+starttime+'&end='+endtime+str);return;
                                        parent.newTab('paypalload','同步Aliexpress订单','index.php?model=aliexpress&action=LoadAliOrder&id='+id+'&start='+starttime+'&end='+endtime+str+loadstr+'&isloadgood='+isloadgood);

                                }
                                }
                            },{
                                    xtype:'button',
                                    style:'margin-top:35px;margin-left:100px;',
                                    text:'一键同步<img src="http://www.cpowersoft.com/ice/themes/default/images/newico.gif" />',
                                    tooltip: {text:'来试试一键同步所有帐号。请用鼠标猛戳我!', title:'提示'},
                                    handler:function(){
                                        parent.newTab('paypalload1','一键同步Aliexpress订单','index.php?model=aliexpress&action=FastLoadAliOrder');
                                    }
                                }
                        ]
                    }
                ]
                }
        ],
        buttons: [{
                text: '重置',
                handler:function(){top.getForm().reset();}
            }]
    });    
    var DHgateform = Ext.create('Ext.form.Panel',{
        buttonAlign:'center',
		labelWidth:170,
        frame:true,
        title: 'DHgate订单加载',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:650,
        maxHeight:450,
		autoHeight:true,
        items: [{
				layout:'column',
				border:false,
				items:[
					{
						columnWidth:.5,
						border:false,
						id:'dhloadstatus',
						items:[
							{
                                xtype:'checkbox',
                                fieldLabel: '等待发货',
                                checked:true,
                                name:'S103001',   
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '买家已付款，等待平台确认',
                                name:'S102001',  
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '已部分发货',
                                name:'S103002',              
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '等待买家确认收货',
                                name:'S101009',  
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '已确认收货',
                                name:'S102006',     
                                labelWidth:200,
                                },{
                                xtype:'checkbox',   
                                fieldLabel: '交易成功',
                                name:'S102111',  
                                labelWidth:200,
                                },{
                                xtype:'checkbox', 
                                fieldLabel: '交易关闭',
                                name:'S111111', 
                                labelWidth:200,
                                },{
								xtype:'checkbox',
								fieldLabel: '订单取消',
								name:'S111000', 
                                disabled:true, 
								labelWidth:200,
								},{
								xtype:'checkbox',
								fieldLabel: '等待买家付款',
                                name:'S101003',
                                disabled:true,   
								labelWidth:200,
								},{
								xtype:'checkbox',
								fieldLabel: '买家申请退款，等待协商结果',
                                name:'S105001',
                                disabled:true,    
								labelWidth:200,
								},{
								xtype:'checkbox',
								fieldLabel: '退款协议已达成',
                                name:'S105002',
                                disabled:true,  
								labelWidth:200,
								},{
								xtype:'checkbox',
								fieldLabel: '部分退款后，等待发货',
                                name:'S105003',   
                                disabled:true,   
								labelWidth:200,
								},{
								xtype:'checkbox',
								fieldLabel: '买家取消退款申请',
                                name:'S105004',  
                                disabled:true, 
								labelWidth:200,
								},{
                                xtype:'checkbox',
                                fieldLabel: '退款/退货协商中，等待协议达成',
                                name:'S106001',
                                disabled:true, 
                                value:'106001', 
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '买家投诉到平台',
                                name:'S106002',
                                disabled:true,   
                                labelWidth:200,
                                },{
                                xtype:'checkbox',
                                fieldLabel: '协议已达成，执行中',
                                name:'S106003',
                                disabled:true,   
                                labelWidth:200,
                                }
						]
					},{
						columnWidth:.5,
						border:false,
						items:[
							{
								xtype:'datefield',
								fieldLabel: '开始时间',
								name: 'start',
								allowBlank:false,
								width:250,
								labelWidth:105,
								format:'Y-m-d',
								value:'<!--{$dday}-->',
								maxValue:'<!--{$today}-->'
							},{
								xtype:'datefield',
								fieldLabel: '结束时间',
								name: 'end',
								format:'Y-m-d',
								allowBlank:false,
								width:250,
								labelWidth:105,
								value:'<!--{$today}-->',
								maxValue:'<!--{$today}-->'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "account_name"],
									 data:[<!--{$dhaccount}-->]
								}),
								valueField :"id",
								displayField: "account_name",
								mode: 'local',
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								width:280,
								labelWidth:105,
								hiddenName:'id',
								fieldLabel: 'DHgate账号',
								emptyText:'选择DHgate账号',
								name: 'id',
								allowBlank:false,
								blankText:'请选择'
								}
						]
					}
				]
				}
        ],
        buttons: [{
            text: '加载订单',
			handler:function(){
				//if(DHgateform.getForm().isValid()){
						var str = ''; 
                        str += "&111000="+DHgateform.getForm().getFieldValues().S111000;
                        str += "&101003="+DHgateform.getForm().getFieldValues().S101003;
                        str += "&102001="+DHgateform.getForm().getFieldValues().S102001;
                        str += "&103001="+DHgateform.getForm().getFieldValues().S103001;
                        str += "&105001="+DHgateform.getForm().getFieldValues().S105001;
                        str += "&105002="+DHgateform.getForm().getFieldValues().S105002;
                        str += "&105003="+DHgateform.getForm().getFieldValues().S105003;
                        str += "&105004="+DHgateform.getForm().getFieldValues().S105004;
                        str += "&103002="+DHgateform.getForm().getFieldValues().S103002;
                        str += "&101009="+DHgateform.getForm().getFieldValues().S101009;
                        str += "&106001="+DHgateform.getForm().getFieldValues().S106001;
                        str += "&106002="+DHgateform.getForm().getFieldValues().S106002;
                        str += "&106003="+DHgateform.getForm().getFieldValues().S106003;
                        str += "&102006="+DHgateform.getForm().getFieldValues().S102006;
                        str += "&102111="+DHgateform.getForm().getFieldValues().S102111;
                        str += "&111111="+DHgateform.getForm().getFieldValues().S111111; 
                       
						var id = DHgateform.getForm().getFieldValues().id;
						var starttime=	Ext.Date.format(DHgateform.getForm().getFieldValues().start,'Y-m-d');
						var endtime = 	Ext.Date.format(DHgateform.getForm().getFieldValues().end,'Y-m-d'); 
						//alert(id);
					    //alert('index.php?model=DH&action=LoadOrder&id='+id+'&start='+starttime+'&end='+endtime+str);return;
						parent.newTab('dhload','同步DHgate订单','index.php?model=DH&action=LoadDHOrder&id='+id+'&start='+starttime+'&end='+endtime+str);

				//}
			}
        },{
        	text: '重置',
			handler:function(){top.getForm().reset();}
        }]
    });	
    var paypal1 = Ext.create('Ext.form.Panel',{
        buttonAlign:'center',
		labelWidth:70,
        frame:true,
        title: 'Paypal流水导出',
        bodyStyle:'padding:25px',
		style:'margin:10px',
		width:350,
		height:250,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始时间',
	        name: 'start',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			format:'Y-m-d',
			value:'<!--{$dday}-->',
			maxValue:'<!--{$today}-->'
		},{
	    	xtype:'datefield',
	        fieldLabel: '结束时间',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			width:250,
			labelWidth:80,
			value:'<!--{$dday}-->',
			maxValue:'<!--{$today}-->'
		},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["p_root_id", "paypal_account"],
	             data:[<!--{$paccount}-->]
	        }),
	        valueField :"p_root_id",
	        displayField: "paypal_account",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
			width:250,
			labelWidth:80,
	        hiddenName:'p_root_id',
	        fieldLabel: 'Paypal账号',
	        emptyText:'选择Paypal账号',
	        name: 'p_root_id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '导出',
			handler:function(){
				if(paypal1.getForm().isValid()){
						//msgWindow.show();
						var id = paypal1.getForm().getFieldValues().p_root_id;
						var starttime=	Ext.Date.format(paypal1.getForm().getFieldValues().start,'Y-m-d');
						var endtime = 	Ext.Date.format(paypal1.getForm().getFieldValues().end,'Y-m-d');
						window.open('index.php?model=order&action=exportpaypal&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){top.getForm().reset();}
        }]
    }); 
    
    var magento = Ext.create('Ext.form.Panel',{
        id:'mgform',
        buttonAlign:'center',
        labelWidth:70,
        frame:true,
        title: 'magento订单加载',
        bodyStyle:'padding:25px',
        style:'margin:10px',
        width:350,
        height:250,
        items: [{
            xtype:'datefield',
            fieldLabel: '开始时间',
            name: 'start',
            allowBlank:false,
            width:250,
            labelWidth:80,
            format:'Y-m-d',
            value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
            maxValue:'<!--{$today}-->'
        },{
            xtype:'datefield',
            fieldLabel: '结束时间',
            name: 'end',
            format:'Y-m-d',
            allowBlank:false,
            width:250,
            labelWidth:80,
            value:'<!--{$yesterday}-->',
            maxValue:'<!--{$today}-->'
        },{
            xtype:'combo',
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "account_name"],
                 data:[<!--{$mgaccount}-->]
            }),
            valueField :"id",
            displayField: "account_name",
            mode: 'local',
            editable: false,
            forceSelection: true,
            triggerAction: 'all',
            hiddenName:'id',
            width:250,
            labelWidth:80,
            fieldLabel: 'magento',
            emptyText:'选择magento账号',
            name: 'id',
            allowBlank:false,
            blankText:'请选择'
            }
        ],

        buttons: [{
            text: '加载订单',
            handler:function(){
                if(magento.getForm().isValid()){
                        //msgWindow.show();
                        var id = magento.getForm().getFieldValues().id;
                        var starttime=    Ext.Date.format(magento.getForm().getFieldValues().start,'Y-m-d');
                        var endtime =     Ext.Date.format(magento.getForm().getFieldValues().end,'Y-m-d');
                        parent.newTab('zcload','加载订单','index.php?model=order&action=Loadmagento&id='+id+'&start='+starttime+'&end='+endtime);

                }
            }
        },{
            text: '重置',
            handler:function(){zencart.getForm().reset();}
        }]
    });    		
	var tab = Ext.create('Ext.tab.Panel',{
        activeTab: 0,
		deferredRender:false,
        defaults:{autoScroll: true,autoHeight:true},
        items:[{
			id:'tab1',
			title: 'Ebay',
			defaultType: 'textfield',
			autoScroll:true,
			items:[top,paypal,paypal1]
		},{
			id:'tab2',
			title: 'Amazon',
			defaultType: 'textfield',
			autoScroll:true,
			items:[az]
		},{
            id:'tab7',
            title: 'Aliexpress',
            defaultType: 'textfield',
            autoScroll:true,
            items:[aliexpress]
        },{
            id:'tab8',
            title: 'DHgate',
            defaultType: 'textfield',
            autoScroll:true,
            items:[DHgateform]
        },{
			id:'tab3',
			title: 'Taobao',
			defaultType: 'textfield',
			autoScroll:true,
			items:[tb]
		},{
			id:'tab5',
			title: 'zencart',
			defaultType: 'textfield',
			autoScroll:true,
			items:[zencart]
		},{
			id:'tab6',
			title: 'magento',
			defaultType: 'textfield',
			autoScroll:true,
			disabled:false,
			items:[magento]
		}]
	});
	tab.render(document.body);
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->