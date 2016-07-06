Ext.define('Ext.ux.systemTab',{
	extend:'Ext.TabPanel',
	initComponent: function() {
		this.creatItems();
		this.activeTab= 0;
        this.callParent(this);
    },
	afterselect:function(k,v)
	{
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
	},
	creatItems:function(){
		var info = this.info;
		var afterselect = this.afterselect;
		var handleURL = this.handleURL;
		var account = this.accountdata;
		var status = this.statusdata;
		var salechannel = this.salesCnldata;
		var depot = this.depotdata;
		var orderstatus = this.statusdata;
		var cat = this.arrdata[1];
		var brand = this.arrdata[2];
		var status = this.arrdata[0];
		var aliaccount = this.arrdata[3];
		this.items = [{
			    id:'tab1',
                title: '订单相关',
				autoHeight:true,
				autoWidth:true,
				defaultType: 'textfield',
				autoScroll:true,
                items:[
					   {
                layout:'column', 	
				xtype:'panel',
				style:'margin-top:20px;',
                items:[{
					columnWidth:.2,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'订单重新锁定库存',
					items:[{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: depot
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						labelWidth:35,
						width:150,
						editable: false,
						value:'0',
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'depot_id',
						allowBlank:false,
						fieldLabel: '仓库',
						id:'depot_id',
						name:'depot_id'
						},{
						xtype:'button',
						text:'确认重新锁定',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '清空锁定库存后重新锁定库存?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=clearlock'+'&depot='+Ext.getCmp('depot_id').getValue(),
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.2,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'清空订单',
					items:[{
						xtype:'button',
						text:'确认删除所有订单',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除所有系统订单?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delorders',
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.2,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'清空paypal流水',
					items:[{
						xtype:'button',
						width:200,
						text:'确认删除所有paypal流水',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除所有paypal流水?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delpaypals',
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}						
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.2,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'删除订单日志',
					items:[{
						xtype:'datefield',
						id:'logtime',
						name:'logtime',
						format:'Y-m-d',
						labelWidth:75,
						width:200,
						fieldLabel:'此日期前'
							},{
						xtype:'button',
						text:'确认删除日志',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除订单日志?', function(btn) {
									if (btn == 'yes') {
										var logtime = Ext.getCmp('logtime').getValue('Y-m-d');
										alert(logtime);return;
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delorderlog&logtime='+logtime,
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					}]
				},{ 
					xtype:'fieldset',
					style:'margin-left:20px;',
					defaults: {width: 150},
					items:[
						   new Ext.form.FormPanel({
							width:300,
							height:300,
							buttonAlign:'center',
							id:'dorder',
							frame:true,
							title:'删除订单',
							padding:15,
							border:false,
							items:[
									{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: [['1','Paid time'],['2','Shipping time']]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								labelWidth:75,
								width:250,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'timetype',
								fieldLabel: '时间类型',
								name: 'timetype',
								value:'1'
							},{
								xtype:'datefield',
								id:'starttime',
								name:'starttime',
								labelWidth:75,
								width:250,
								format:'Y-m-d',
								fieldLabel:'From'
							},{
								xtype:'datefield',
								id:'totime',
								name:'totime',
								labelWidth:75,
								width:250,
								format:'Y-m-d',
								fieldLabel:'To'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								labelWidth:75,
								width:250,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'account',
								fieldLabel: '选择账户',
								id: 'account',
								name:'account',
								value:'0'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: orderstatus
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								labelWidth:75,
								width:250,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'status',
								fieldLabel: '订单状态',
								id: 'status',
								name:'status',
								value:'0'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: salechannel
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								labelWidth:75,
								width:250,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'salechannel',
								fieldLabel: '销售渠道',
								id: 'salechannel',
								name:'salechannel',
								value:'0'
							},{
								xtype:'button',
								text:'确认删除订单',
								handler:function(){
									Ext.Msg.confirm('Delete Alert!', '删除订单?', function(btn) {
									if (btn == 'yes') {
										var values = Ext.getCmp('dorder').getForm().getFieldValues();
										//alert(values.starttime+values.totime+values.account+values.status+values.salechannel);return;
										var str = '';
										if(values.starttime)
										{
											str += '&starttime='+values.starttime;
										}
										if(values.totime)
										{
											str += '&totime='+values.totime;
										}
										
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: 'index.php?model=system&action=inithandle&type=delorder'+str+'&account='+values.account+'&status='+values.status+'&salechannel='+values.salechannel,
										success:function(response,opts){
											var res = Ext.decode(response.responseText);
											Ext.getBody().unmask();
												if(res.success){
													Ext.example.msg('MSG',res.msg);
												}else{
													Ext.example.msg('ERROR',res.msg);
												}					
											}
										});
									}
								}, this);
								}
								}	   
								   ]
							})
						]
				}]
            },{
				id:'tab2',
                title: '产品相关',
				layout:'form',
				autoHeight:true,
				autoScroll:true,
                defaultType: 'textfield',
                items: [{
                layout:'column',
				xtype:'panel',
				style:'margin-top:20px;',
                items:[{
					columnWidth:.24,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'重置产品锁定库存',
					items:[{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: depot
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						width:200,
						labelWidth:35,
						editable: false,
						value:0,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'depot_id1',
						allowBlank:false,
						fieldLabel: '仓库',
						id:'depot_id1',
						name:'depot_id1'
						},{
						xtype:'button',
						text:'清空产品锁定',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '确认清空产品锁定状态?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=unlock&depot='+Ext.getCmp('depot_id1').getValue(),
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.2,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'清空分类',
					items:[{
						xtype:'button',
						text:'清空产品分类',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除所有产品分类?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=clearcat',
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.23,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'清空产品品牌',
					items:[{
						xtype:'button',
						text:'清空产品品牌',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除所有产品品牌?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=cacheBrand',
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}						
												}
											});
									}
								}, this);
							}
						}]
					},{
					columnWidth:.3,
					xtype:'fieldset',
					layout:'form',
					style:'margin-left:20px;',
					title:'删除产品日志',
					items:[{
						xtype:'datefield',
						id:'logtime1',
						name:'logtime1',
						format:'Y-m-d',
						width:150,
						labelWidth:45,
						fieldLabel:'此日期前'
							},{
						xtype:'button',
						text:'确认删除日志',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除产品日志?', function(btn) {
									if (btn == 'yes') {
										var logtime = Ext.fly('logtime1').getValue();
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delgoodslog&logtime='+logtime,
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
					}]
				},{ 
                layout:'column',
				xtype:'panel',
				style:'margin-top:20px;',
                items:[{
					columnWidth:.2,
					xtype:'fieldset',
					layout:'form',
					style:'margin-left:20px;',
					labelWidth: 70,
					title:'删除产品',
					items:[{
						xtype:'datefield',
						id:'starttime1',
						name:'starttime1',
						labelWidth:40,
						width:250,
						format:'Y-m-d',
						fieldLabel:'From'
					},{
						xtype:'datefield',
						id:'totime1',
						name:'starttime1',
						labelWidth:40,
						width:250,
						format:'Y-m-d',
						fieldLabel:'To'
					},Ext.create('Ext.form.TriggerField',{
					editable: false,
					fieldLabel:'分类',
					xtype:'trigger',
					id:'cat_name',
					name:'cat_name',
					labelWidth:40,
					width:250,
					value:'All',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=goods&action=getcattree&com=1',0,afterselect);
					}
					}),{xtype:'hidden',id:'cat_id',name:'cat_id',value:0},{
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: status
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'status',
						fieldLabel: '产品状态',
						id: 'status1',
						name:'status1',
						labelWidth:40,
						width:250,
						value:0
					},{
						xtype:'button',
						text:'确认删除产品',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除搜索产品?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delgoods',
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}]
				},{
				columnWidth:.4,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'自动匹配产品图片',
					items:[{
						xtype:'textfield',
						id:'img_src',
						fieldLabel:'匹配公式'
					},{
						xtype:'textfield',
						id:'SKU',
						fieldLabel:'SKU起始'
					},{
						xtype:'checkbox',
						id:'is_replace',
						checked:false,
						fieldLabel:'自动替换主图片'
					},{
						xtype:'displayfield',
						fieldLabel:'说明:',
						value:'匹配公式如data/foldername/{SKU}_{num}.jpg,SKU为空则匹配所有产品'
					},{
						xtype:'button',
						text:'自动匹配图片',
						handler:function(){
							    Ext.Msg.confirm('自动匹配图片!', '确认系统自动更新产品图片?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=matchimg&img_src='+Ext.fly('img_src').getValue()+'&SKU='+Ext.fly('SKU').getValue()+'&is_replace='+Ext.getCmp('is_replace').getValue(),
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
					}]
				},{
				columnWidth:.4,
					xtype:'fieldset',
					style:'margin-left:20px;',
					title:'初始化aliexpress产品',
					items:[
					
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: aliaccount
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								labelWidth:75,
								width:250,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'aliaccount',
								fieldLabel: '选择账户',
								id: 'aliaccount',
								name:'aliaccount',
								value:'0'
							},
							{
						xtype:'button',
						text:'确认删除产品',
						handler:function(){
							    Ext.Msg.confirm('Delete Alert!', '删除搜索产品?', function(btn) {
									if (btn == 'yes') {
										Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
										Ext.Ajax.request({
										   url: handleURL+'&type=delaligoods&account='+Ext.getCmp('aliaccount').getValue(),
											success:function(response,opts){
												var res = Ext.decode(response.responseText);
												Ext.getBody().unmask();
													if(res.success){
													Ext.example.msg('MSG',res.msg);
													}else{
													Ext.example.msg('ERROR',res.msg);
													}					
												}
											});
									}
								}, this);
							}
						}
					
					]
				}]
				}]
            },new Ext.form.FormPanel({
				id:'tab3',
                title: '系统相关',
				autoHeight:true,
				autoWidth:true,
				buttonAlign:'center',
                defaultType: 'textfield',
                items: [{
							xtype: 'checkboxgroup',
							fieldLabel: '客服审核',
							items: [
								{boxLabel: '打印状态', name: 'print_status_1', checked:info.print_status_1?true:false},
								{boxLabel: '订单状态', name: 'order_status_1',checked:info.order_status_1?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_1', checked:info.paid_time_1?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_1', checked:info.sellsrecord_1?true:false},
								{boxLabel: '订单号', name: 'order_sn_1', checked:info.order_sn_1?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_1', checked:info.paypalid_1?true:false}, 
                                {boxLabel: '产品', name: 'goods_1', checked:info.goods_1?true:false},        
								{boxLabel: '币种', name: 'currency_1', checked:info.currency_1?true:false}, 
								{boxLabel: '总金额', name: 'order_amount_1', checked:info.order_amount_1?true:false},   
                                {boxLabel: '物流费用', name: 'shipping_fee_1', checked:info.shipping_fee_1?true:false},
								{boxLabel: '物流', name: 'shipping_id_1', checked:info.shipping_id_1?true:false},
								{boxLabel: '追踪单号', name: 'track_no_1', checked:info.track_no_1?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_1', checked:info.eubpdf_1?true:false},
								{boxLabel: 'Buyer', name: 'userid_1', checked:info.userid_1?true:false},
								{boxLabel: '国家', name: 'country_1', checked:info.country_1?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_1', checked:info.Sales_channels_1?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_1', checked:info.Sales_account_id_1?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_1', checked:info.stockout_sn_1?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_1', checked:info.ShippingService_1?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '库管审核',
							items: [
								{boxLabel: '打印状态', name: 'print_status_2', checked:info.print_status_2?true:false},
								{boxLabel: '订单状态', name: 'order_status_2',checked:info.order_status_2?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_2', checked:info.paid_time_2?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_2', checked:info.sellsrecord_2?true:false},
								{boxLabel: '订单号', name: 'order_sn_2', checked:info.order_sn_2?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_2', checked:info.paypalid_2?true:false},
                                {boxLabel: '产品', name: 'goods_2', checked:info.goods_2?true:false},             
                                {boxLabel: '货位', name: 'stock_place_2', checked:info.stock_place_2?true:false},
								{boxLabel: '币种', name: 'currency_2', checked:info.currency_2?true:false},
								{boxLabel: '总金额', name: 'order_amount_2', checked:info.order_amount_2?true:false},     
                                {boxLabel: '物流费用', name: 'shipping_fee_2', checked:info.shipping_fee_2?true:false},
								{boxLabel: '物流', name: 'shipping_id_2', checked:info.shipping_id_2?true:false},
								{boxLabel: '追踪单号', name: 'track_no_2', checked:info.track_no_2?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_2', checked:info.eubpdf_2?true:false},
								{boxLabel: 'Buyer', name: 'userid_2', checked:info.userid_2?true:false},
								{boxLabel: '国家', name: 'country_2', checked:info.country_2?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_2', checked:info.Sales_channels_2?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_2', checked:info.Sales_account_id_2?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_2', checked:info.stockout_sn_2?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_2', checked:info.ShippingService_2?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '库管缺货EUB',
							items: [
								{boxLabel: '打印状态', name: 'print_status_13', checked:info.print_status_13?true:false},
								{boxLabel: '订单状态', name: 'order_status_13',checked:info.order_status_13?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_13', checked:info.paid_time_13?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_13', checked:info.sellsrecord_13?true:false},
								{boxLabel: '订单号', name: 'order_sn_13', checked:info.order_sn_13?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_13', checked:info.paypalid_13?true:false},
								{boxLabel: '币种', name: 'currency_13', checked:info.currency_13?true:false},
								{boxLabel: '总金额', name: 'order_amount_13', checked:info.order_amount_13?true:false},
								{boxLabel: '产品', name: 'goods_13', checked:info.goods_13?true:false},
								{boxLabel: '物流', name: 'shipping_id_13', checked:info.shipping_id_13?true:false},
								{boxLabel: '追踪单号', name: 'track_no_13', checked:info.track_no_13?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_13', checked:info.eubpdf_13?true:false},
								{boxLabel: 'Buyer', name: 'userid_13', checked:info.userid_13?true:false},
								{boxLabel: '国家', name: 'country_13', checked:info.country_13?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_13', checked:info.Sales_channels_13?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_13', checked:info.Sales_account_id_13?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_13', checked:info.stockout_sn_13?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_13', checked:info.ShippingService_13?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '订单处理',
							items: [
								{boxLabel: '打印状态', name: 'print_status_3', checked:info.print_status_3?true:false},
								{boxLabel: '订单状态', name: 'order_status_3',checked:info.order_status_3?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_3', checked:info.paid_time_3?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_3', checked:info.sellsrecord_3?true:false},
								{boxLabel: '订单号', name: 'order_sn_3', checked:info.order_sn_3?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_3', checked:info.paypalid_3?true:false},
								{boxLabel: '币种', name: 'currency_3', checked:info.currency_3?true:false},
								{boxLabel: '总金额', name: 'order_amount_3', checked:info.order_amount_3?true:false},
								{boxLabel: '产品', name: 'goods_3', checked:info.goods_3?true:false},
								{boxLabel: '货位', name: 'stock_place_3', checked:info.stock_place_3?true:false},
								{boxLabel: '物流', name: 'shipping_id_3', checked:info.shipping_id_3?true:false},
								{boxLabel: '追踪单号', name: 'track_no_3', checked:info.track_no_3?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_3', checked:info.eubpdf_3?true:false},
								{boxLabel: 'Buyer', name: 'userid_3', checked:info.userid_3?true:false},
								{boxLabel: '国家', name: 'country_3', checked:info.country_3?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_3', checked:info.Sales_channels_3?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_3', checked:info.Sales_account_id_3?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_3', checked:info.stockout_sn_3?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_3', checked:info.ShippingService_3?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: 'EUB订单处理',
							items: [
								{boxLabel: '打印状态', name: 'print_status_4', checked:info.print_status_4?true:false},
								{boxLabel: '订单状态', name: 'order_status_4',checked:info.order_status_4?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_4', checked:info.paid_time_4?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_4', checked:info.sellsrecord_4?true:false},
								{boxLabel: '订单号', name: 'order_sn_4', checked:info.order_sn_4?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_4', checked:info.paypalid_4?true:false},
								{boxLabel: '币种', name: 'currency_4', checked:info.currency_4?true:false},
								{boxLabel: '总金额', name: 'order_amount_4', checked:info.order_amount_4?true:false},
								{boxLabel: '产品', name: 'goods_4', checked:info.goods_4?true:false},
								{boxLabel: '货位', name: 'stock_place_4', checked:info.stock_place_4?true:false},
								{boxLabel: '物流', name: 'shipping_id_4', checked:info.shipping_id_4?true:false},
								{boxLabel: '追踪单号', name: 'track_no_4', checked:info.track_no_4?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_4', checked:info.eubpdf_4?true:false},
								{boxLabel: 'Buyer', name: 'userid_4', checked:info.userid_4?true:false},
								{boxLabel: '国家', name: 'country_4', checked:info.country_4?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_4', checked:info.Sales_channels_4?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_4', checked:info.Sales_account_id_4?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_4', checked:info.stockout_sn_4?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_4', checked:info.ShippingService_4?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '4px订单处理',
							items: [
								{boxLabel: '打印状态', name: 'print_status_5', checked:info.print_status_5?true:false},
								{boxLabel: '订单状态', name: 'order_status_5',checked:info.order_status_5?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_5', checked:info.paid_time_5?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_5', checked:info.sellsrecord_5?true:false},
								{boxLabel: '订单号', name: 'order_sn_5', checked:info.order_sn_5?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_5', checked:info.paypalid_5?true:false},
								{boxLabel: '币种', name: 'currency_5', checked:info.currency_5?true:false},
								{boxLabel: '总金额', name: 'order_amount_5', checked:info.order_amount_5?true:false},
								{boxLabel: '产品', name: 'goods_5', checked:info.goods_5?true:false},
								{boxLabel: '货位', name: 'stock_place_5', checked:info.stock_place_5?true:false},
								{boxLabel: '物流', name: 'shipping_id_5', checked:info.shipping_id_5?true:false},
								{boxLabel: '追踪单号', name: 'track_no_5', checked:info.track_no_5?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_5', checked:info.eubpdf_5?true:false},
								{boxLabel: 'Buyer', name: 'userid_5', checked:info.userid_5?true:false},
								{boxLabel: '国家', name: 'country_5', checked:info.country_5?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_5', checked:info.Sales_channels_5?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_5', checked:info.Sales_account_id_5?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_5', checked:info.stockout_sn_5?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_5', checked:info.ShippingService_5?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '订单解除锁定',
							items: [
								{boxLabel: '打印状态', name: 'print_status_6', checked:info.print_status_6?true:false},
								{boxLabel: '订单状态', name: 'order_status_6',checked:info.order_status_6?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_6', checked:info.paid_time_6?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_6', checked:info.sellsrecord_6?true:false},
								{boxLabel: '订单号', name: 'order_sn_6', checked:info.order_sn_6?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_6', checked:info.paypalid_6?true:false},
								{boxLabel: '币种', name: 'currency_6', checked:info.currency_6?true:false},
								{boxLabel: '总金额', name: 'order_amount_6', checked:info.order_amount_6?true:false},
								{boxLabel: '产品', name: 'goods_6', checked:info.goods_6?true:false},
								{boxLabel: '货位', name: 'stock_place_6', checked:info.stock_place_6?true:false},
								{boxLabel: '物流', name: 'shipping_id_6', checked:info.shipping_id_6?true:false},
								{boxLabel: '追踪单号', name: 'track_no_6', checked:info.track_no_6?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_6', checked:info.eubpdf_6?true:false},
								{boxLabel: 'Buyer', name: 'userid_6', checked:info.userid_6?true:false},
								{boxLabel: '国家', name: 'country_6', checked:info.country_6?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_6', checked:info.Sales_channels_6?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_6', checked:info.Sales_account_id_6?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_6', checked:info.stockout_sn_6?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_6', checked:info.ShippingService_6?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '拣货订单',
							items: [
								{boxLabel: '打印状态', name: 'print_status_8', checked:info.print_status_8?true:false},
								{boxLabel: '订单状态', name: 'order_status_8',checked:info.order_status_8?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_8', checked:info.paid_time_8?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_8', checked:info.sellsrecord_8?true:false},
								{boxLabel: '订单号', name: 'order_sn_8', checked:info.order_sn_8?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_8', checked:info.paypalid_8?true:false},
								{boxLabel: '币种', name: 'currency_8', checked:info.currency_8?true:false},
								{boxLabel: '总金额', name: 'order_amount_8', checked:info.order_amount_8?true:false},
								{boxLabel: '产品', name: 'goods_8', checked:info.goods_8?true:false},
								{boxLabel: '货位', name: 'stock_place_8', checked:info.stock_place_8?true:false},
								{boxLabel: '物流', name: 'shipping_id_8', checked:info.shipping_id_8?true:false},
								{boxLabel: '追踪单号', name: 'track_no_8', checked:info.track_no_8?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_8', checked:info.eubpdf_8?true:false},
								{boxLabel: 'Buyer', name: 'userid_8', checked:info.userid_8?true:false},
								{boxLabel: '国家', name: 'country_8', checked:info.country_8?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_8', checked:info.Sales_channels_8?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_8', checked:info.Sales_account_id_8?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_8', checked:info.stockout_sn_8?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_8', checked:info.ShippingService_8?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '缺货订单',
							items: [
								{boxLabel: '打印状态', name: 'print_status_9', checked:info.print_status_9?true:false},
								{boxLabel: '订单状态', name: 'order_status_9',checked:info.order_status_9?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_9', checked:info.paid_time_9?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_9', checked:info.sellsrecord_9?true:false},
								{boxLabel: '订单号', name: 'order_sn_9', checked:info.order_sn_9?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_9', checked:info.paypalid_9?true:false},
								{boxLabel: '币种', name: 'currency_9', checked:info.currency_9?true:false},
								{boxLabel: '总金额', name: 'order_amount_9', checked:info.order_amount_9?true:false},
								{boxLabel: '产品', name: 'goods_9', checked:info.goods_9?true:false},
								{boxLabel: '货位', name: 'stock_place_9', checked:info.stock_place_9?true:false},
								{boxLabel: '物流', name: 'shipping_id_9', checked:info.shipping_id_9?true:false},
								{boxLabel: '追踪单号', name: 'track_no_9', checked:info.track_no_9?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_9', checked:info.eubpdf_9?true:false},
								{boxLabel: 'Buyer', name: 'userid_9', checked:info.userid_9?true:false},
								{boxLabel: '国家', name: 'country_9', checked:info.country_9?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_9', checked:info.Sales_channels_9?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_9', checked:info.Sales_account_id_9?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_9', checked:info.stockout_sn_9?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_9', checked:info.ShippingService_9?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '退款订单',
							items: [
								{boxLabel: '打印状态', name: 'print_status_10', checked:info.print_status_10?true:false},
								{boxLabel: '订单状态', name: 'order_status_10',checked:info.order_status_10?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_10', checked:info.paid_time_10?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_10', checked:info.sellsrecord_10?true:false},
								{boxLabel: '订单号', name: 'order_sn_10', checked:info.order_sn_10?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_10', checked:info.paypalid_10?true:false},
								{boxLabel: '币种', name: 'currency_10', checked:info.currency_10?true:false},
								{boxLabel: '总金额', name: 'order_amount_10', checked:info.order_amount_10?true:false},
								{boxLabel: '产品', name: 'goods_10', checked:info.goods_10?true:false},
								{boxLabel: '物流', name: 'shipping_id_10', checked:info.shipping_id_10?true:false},
								{boxLabel: '追踪单号', name: 'track_no_10', checked:info.track_no_10?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_10', checked:info.eubpdf_10?true:false},
								{boxLabel: 'Buyer', name: 'userid_10', checked:info.userid_10?true:false},
								{boxLabel: '国家', name: 'country_10', checked:info.country_10?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_10', checked:info.Sales_channels_10?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_10', checked:info.Sales_account_id_10?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_10', checked:info.stockout_sn_10?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_10', checked:info.ShippingService_10?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '到付收款订单',
							items: [
								{boxLabel: '打印状态', name: 'print_status_11', checked:info.print_status_11?true:false},
								{boxLabel: '订单状态', name: 'order_status_11',checked:info.order_status_11?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_11', checked:info.paid_time_11?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_11', checked:info.sellsrecord_11?true:false},
								{boxLabel: '订单号', name: 'order_sn_11', checked:info.order_sn_11?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_11', checked:info.paypalid_11?true:false},
								{boxLabel: '币种', name: 'currency_11', checked:info.currency_11?true:false},
								{boxLabel: '总金额', name: 'order_amount_11', checked:info.order_amount_11?true:false},
								{boxLabel: '产品', name: 'goods_11', checked:info.goods_11?true:false},
								{boxLabel: '物流', name: 'shipping_id_11', checked:info.shipping_id_11?true:false},
								{boxLabel: '追踪单号', name: 'track_no_11', checked:info.track_no_11?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_11', checked:info.eubpdf_11?true:false},
								{boxLabel: 'Buyer', name: 'userid_11', checked:info.userid_11?true:false},
								{boxLabel: '国家', name: 'country_11', checked:info.country_11?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_11', checked:info.Sales_channels_11?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_11', checked:info.Sales_account_id_11?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_11', checked:info.stockout_sn_11?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_11', checked:info.ShippingService_11?true:false}
							]
						},{
							xtype: 'checkboxgroup',
							fieldLabel: '所有订单',
							items: [
								{boxLabel: '打印状态', name: 'print_status_0', checked:info.print_status_0?true:false},
								{boxLabel: '订单状态', name: 'order_status_0',checked:info.order_status_0?true:false},
								{boxLabel: 'paidtime', name: 'paid_time_0', checked:info.paid_time_0?true:false},
								{boxLabel: 'Sellerrecord', name: 'sellsrecord_0', checked:info.sellsrecord_0?true:false},
								{boxLabel: '订单号', name: 'order_sn_0', checked:info.order_sn_0?true:false},
								{boxLabel: 'Paypalid', name: 'paypalid_0', checked:info.paypalid_0?true:false},
								{boxLabel: '币种', name: 'currency_0', checked:info.currency_0?true:false},
								{boxLabel: '总金额', name: 'order_amount_0', checked:info.order_amount_0?true:false},
								{boxLabel: '产品', name: 'goods_0', checked:info.goods_0?true:false},
								{boxLabel: '货位', name: 'stock_place_0', checked:info.stock_place_0?true:false},
								{boxLabel: '物流', name: 'shipping_id_0', checked:info.shipping_id_0?true:false},
								{boxLabel: '追踪单号', name: 'track_no_0', checked:info.track_no_0?true:false},
								{boxLabel: '打印文件', name: 'eubpdf_0', checked:info.eubpdf_0?true:false},
								{boxLabel: 'Buyer', name: 'userid_0', checked:info.userid_0?true:false},
								{boxLabel: '国家', name: 'country_0', checked:info.country_0?true:false},
								{boxLabel: '渠道', name: 'Sales_channels_0', checked:info.Sales_channels_0?true:false},
								{boxLabel: '账户', name: 'Sales_account_id_0', checked:info.Sales_account_id_0?true:false},
								{boxLabel: '出库单号', name: 'stockout_sn_0', checked:info.stockout_sn_0?true:false},
                                {boxLabel: '物流服务', name: 'ShippingService_0', checked:info.ShippingService_0?true:false}
							]
						}],
				buttons: [{
						text :'保存',
						type: 'submit', 
						handler:function(){
							Ext.getCmp('tab3').getForm().doAction('submit',{
									url:'index.php?model=system&action=savecolumn',
									method:'post',
									success:function(form,action){
											Ext.example.msg('MSG','保存成功');
										},
									failure:function(form,action){
											Ext.Msg.alert('Error',action.result.msg);
										}
								});
							}
					}]
			})
			];
	}

});
