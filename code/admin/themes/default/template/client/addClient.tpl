<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var top = new Ext.FormPanel({	
		buttonAlign:'right',
		labelWidth:70,
        frame:true,
        title: '客户管理',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		
		items:[{
			xtype:'fieldset',
			title:'基本信息',
			autoHeight:true,
			
			items:[{
				layout:'column',
				items:[{
					columnWidth:.33,
					layout:'form',
					items:[{
						xtype:'textfield',
						fieldLabel:'姓名',
						allowBlank:false,
						name:'real_name',
						value:'<!--{$info.real_name}-->',
						anchor:'90%'
					}]
				},{
					columnWidth:.33,
					layout:'form',
					items:[{
						xtype:'combo',
					       	store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$sex}-->]
	                    }),
						
	                    valueField :"retrunValue",
	                    displayField:"displayText",
	                    mode:'local',
	                    editable: false,                
	                    forceSelection: true,
	                    triggerAction: 'all',	
	                    hiddenName:'sex',
	                    fieldLabel:'性　别',
	                    emptyText:'选择',
	                    name :'sex',
	                    value:'<!--{$info.sex}-->',
	                    anchor:'90%'				
						}]
					},{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '年　龄',
							name:'age',
							value:'<!--{$info.age}-->',
							anchor:'90%'
						}]
					},{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '生　日',
							name:'birthday',
							value:'<!--{$info.birthday}-->',
							anchor:'90%'	
						}]
					},{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '身份证',
							name:'id_card',
							value:'<!--{$info.id_card}-->',
							anchor:'90%'	
						}]
					},{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'combo',
					       	store: new Ext.data.SimpleStore({
	                    	fields: ["retrunValue", "displayText"],
	                    	data: [<!--{$is_married}-->]
	                    }),
						
		                    valueField :"retrunValue",
		                    displayField:"displayText",
		                    mode:'local',
		                    editable: false,                
		                    forceSelection: true,
		                    triggerAction: 'all',	
		                    hiddenName:'is_married',
		                    fieldLabel:'婚姻状况',
		                    emptyText:'选择',
		                    name :'is_married',
		                    value:'<!--{$info.is_married}-->',
		                    anchor:'90%'				
						}]
					},{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '工作地址',
							name:'workplace',
							value:'<!--{$info.workplace}-->',
							anchor:'90%'	
						}]
					},{
						columnWidth:.33,
						layout:'form',
			
						items:[{
							xtype:'combo',
						       	store: new Ext.data.SimpleStore({
		                    	fields: ["retrunValue", "displayText"],
		                    	data: [<!--{$education}-->]
		                    }),
						
		                    valueField :"retrunValue",
		                    displayField:"displayText",
		                    mode:'local',
		                    editable: false,                
		                    forceSelection: true,
		                    triggerAction: 'all',	
		                    hiddenName:'education',
		                    fieldLabel:'教育程度',
		                    emptyText:'选择',
		                    name :'education',
		                    value:'<!--{$info.sex}-->',
		                    anchor:'90%'				
						}]			
					},{
						columnWidth:.33,
						layout:'form',				
						items:[{
							xtype:'combo',
						       	store: new Ext.data.SimpleStore({
		                    	fields: ["retrunValue", "displayText"],
		                    	data: [<!--{$works}-->]
		                    }),
						
		                    valueField :"retrunValue",
		                    displayField:"displayText",
		                    mode:'local',
		                    editable: false,                
		                    forceSelection: true,
		                    triggerAction: 'all',	
		                    hiddenName:'works',
		                    fieldLabel:'职业',
		                    emptyText:'选择',
		                    name :'works',
		                    value:'<!--{$info.sex}-->',
		                    anchor:'90%'				
						}]			
						
					},{
						//columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '地址',
							name:'address',
							value:'<!--{$info.address}-->',
							anchor:'90%'	
						}]

					},{
						//columnWidth:.33
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '联系备注',
							name:'contact_note',
							value:'<!--{$info.contact_note}-->',
							anchor:'90%'	
						}]
					}]
				}]	
				
		},{
			xtype:'fieldset',
			title:'客户资料',
			autoHeight:true,
			items:[{
				layout:'column',
					items:[{
					    columnWidth:.33,
					    layout: 'form',
					    items: [{
					    xtype:'textfield',
						    fieldLabel: '月收入',
						    name:'month_earn',
							value: '<!--{$info.month_earn}-->',
						    anchor:'90%'
					    }]
					   },{
						columnWidth:.33,
						layout:'form',
						items:[{
							xtype:'textfield',
							fieldLabel: '购买能力',
							name:'buy_ability',
							value:'<!--{$info.buy_ability}-->',
							anchor:'90%'	
						}]
					 },{
						 columnWidth:.33,
						 layout:'form',
						 items:[{
							xtype:'textfield',
							fieldLabel: '购买计划',
							name:'buy_plan',
							value:'<!--{$info.buy_plan}-->',
							anchor:'90%'	
						 }]	 
					 },{
						 columnWidth:.33,
						 layout:'form',
						 items:[{
							xtype:'textfield',
							fieldLabel: '最低价格',
							name:'min_price',
							value:'<!--{$info.min_price}-->',
							anchor:'90%'	
						 }]	 		 
					　 },{
							columnWidth:.33,
							layout:'form',
							items:[{
								xtype:'textfield',
								fieldLabel: '最高价格',
								name:'max_price',
								value:'<!--{$info.max_price}-->',
								anchor:'90%'	
							}]	
						 },{
							columnWidth:.33,
							layout:'form',
							items:[{
								xtype:'combo',
							       	store: new Ext.data.SimpleStore({
			                    	fields: ["retrunValue", "displayText"],
			                    	data: [<!--{$is_bool}-->]
			                    }),
			                    valueField :"retrunValue",
			                    displayField:"displayText",
			                    mode:'local',
			                    editable: false,                
			                    forceSelection: true,
			                    triggerAction: 'all',	
			                    hiddenName:'is_bool',
			                    fieldLabel:'是否投资者',
			                    emptyText:'选择',
			                    name :'is_bool',
			                    value:'<!--{$info.sex}-->',
			                    anchor:'90%'				
							}]			
						　 },{
							columnWidth:.33,
							layout:'form',
							items:[{
								xtype:'textfield',
								fieldLabel: '代理人',
								name:'agent_name',
								value:'<!--{$info.agent_name}-->',
								anchor:'90%'	
							}]	
						},{
							columnWidth:.33,
							layout:'form',
							items:[{
								xtype:'textfield',
								fieldLabel: '身份证',
								name:'agent_id_card',
								value:'<!--{$info.agent_id_card}-->',
								anchor:'90%'	
							}]
						},{
							columnWidth:1,
							layout:'form',
							items:[{
								xtype:'textfield',
								fieldLabel: '备注',
								name:'note',
								value:'<!--{$info.note}-->',
								anchor:'90%'	
							}]
						}]
					}]
			},{
				xtype:'fieldset',
				title: '联系信息',
				autoHeight:true,
					items:[{
						layout:'column',
					    	items:[{
					        	columnWidth:.33,
					            layout: 'form',
					            items: [{
					            	xtype:'textfield',
					            	fieldLabel: '电　话',
					                name:'telephone',
									value: '<!--{$info.telephone}-->',
					                anchor:'90%'
					              }]
					           },{
									columnWidth:.33,
									layout:'form',
									items:[{
										xtype:'textfield',
										fieldLabel: '手机',
										name:'mobile',
										value:'<!--{$info.mobile}-->',
										anchor:'90%'	
									}]
								},{
									columnWidth:.33,
									layout:'form',
									items:[{
										xtype:'textfield',
										fieldLabel: 'Email',
										name:'email',
										value:'<!--{$info.email}-->',
										anchor:'90%'	
									}]
								}]
							}]
				},{
					xtype:'fieldset',
					title:'系统信息',
					autoHeight:true,
					items:[{
						layout:'column',
							items:[{
							    columnWidth:.33,
							    layout: 'form',
							    items: [{
							    xtype:'textfield',
								    fieldLabel: '跟单人',
								    name:'follow_user_id',
									value: '<!--{$info.follow_user_id}-->',
								    anchor:'90%'
							    }]
							},{
								columnWidth:.33,
								layout:'form',
								items: [{
				                    xtype:'combo',
				                    store: new Ext.data.SimpleStore({
				                    	fields: ["retrunValue", "displayText"],
				                    	data: [<!--{$depts}-->]
				                    }),
				                    valueField :"retrunValue",
				                    displayField: "displayText",
				                    mode: 'local',
				                    editable: false,
				                    forceSelection: true,
				                    triggerAction: 'all',
				                    hiddenName:'dept_id',
				                    fieldLabel: '所属部门',
				                    emptyText:'选择',
				                    name: 'dept_id',
									value: '<!--{$info.dept_id}-->',
				                    anchor:'90%'
				                }]
						    },{
								columnWidth:.33,
								layout:'form',
								items:[{
									xtype:'textfield',
									fieldLabel: '创建人',
									name:'create_user_id',
									value:'<!--{$info.create_user_id}-->',
									//disabled :true,
									anchor:'90%'	
								}]
							},{
								columnWidth:.33,
								layout:'form',
								items:[{
									xtype:'textfield',
									fieldLabel: '创建时间',
									name:'create_time',
									value:'<!--{$create_time}-->',
									disabled :true,
									anchor:'90%'	
								}]	
							},{
								columnWidth:.33,
								layout:'form',
								items:[{
									xtype:'textfield',
									fieldLabel: '修改人',
									name:'modify_user_id',
									value:'<!--{$info.modify_user_id}-->',
									disabled :true,
									anchor:'90%'	
								}]
							},{
								columnWidth:.33,
								layout:'form',
								items:[{
									xtype:'textfield',
									fieldLabel: '修改时间',
									name:'modify_time',
									value:'<!--{$modify_time}-->',
									disabled :true,
									anchor:'90%'	
								}]
							},{
								//columnWidth:.33,
								layout:'form',
								items:[{
									xtype:'hidden',
									//fieldLabel: '修改时间',
									name:'client_id',
									value:'<!--{$info.id}-->',
									anchor:'90%'	
								}]
							}]
						}]
					}],	
							
				  buttons: [{
			            text: '保存',
						handler:function(){
							if(top.form.isValid()){
								top.form.doAction('submit',{
									url:'index.php?model=client&action=save',
									method:'post',
									params:'',
									success:function(form,action){
										Ext.example.msg('操作','保存成功!');
										if (Ext.fly('client_id').dom.value=='') {
											top.form.reset();
										}
									},
									failure:function(){
										Ext.example.msg('操作','服务器出现错误请稍后再试！');
												
									}
			                    });
							}
						}
			        },{
			        	text: '重置',
						handler:function(){top.form.reset();}
			        }]

	});
	
	top.render(document.body);
	loadend();
});
</script>

<!--{include file="footer.tpl"}-->