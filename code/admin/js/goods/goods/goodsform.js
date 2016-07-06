Ext.ux.goodsForm = Ext.extend(Ext.FormPanel, {
	initComponent: function() {
		this.frame = true,
		this.fileUpload = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatChildGridcm();
		this.creatChildGoodsstore();
		this.creatChildGoodsgrid();
		this.getTab();
		this.creatItems();
		this.creatButtons();
        Ext.ux.goodsForm.superclass.initComponent.call(this);
    },
	creatChildGoodsstore:function(){//子产品明细store
		this.childgoodsstore = new Ext.data.Store({
			url : this.listURL,
			pruneModifiedRecords:true,
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalCount',
				root : 'topics',
				id:'rec_id'
			}, ['child_sn','color','size','price','stock'])
			});
	},	

	creatChildGridcm:function(){
		var thiz =this;
		this.childcmlist = new Ext.grid.ColumnModel([{
						header : '子产品编码<font color=red>*</font>',
						dataIndex:'child_sn',
						width:100,
						align : 'left',
						editor:new Ext.form.TextField({
								allowBlank:false,
								hideLabel:true
						})
					}, {
						header:'颜色',
						width:150,
						dataIndex:'color',
						align:'left',
						renderer: this.rendererlist[1],
						editor:this.combolist[1]
					}, {
						header:'尺寸',
						width:150,
						dataIndex:'size',
						align:'left',
						renderer:  this.rendererlist[0],
						editor:this.combolist[0]
					}, {
						header:'价格<font color=red>*</font>',
						width:150,
						dataIndex:'price',
						align:'left',
						editor:new Ext.form.NumberField({
								allowNegative:false,
								hideLabel:true
						})
					}, {
						header:'库存数量<font color=red>*</font>',
						dataIndex:'stock',
						align:'right',
						editor:new Ext.form.NumberField({
							allowBlank:false,
							allowNegative:false,
							allowDecimals:false,
							style:'text-align:left'
						})
					}]);
	},
	creatChildGoodsgrid:function(){//创建子产品明细
		this.childgoodsGrid =new Ext.grid.EditorGridPanel({
					frame:true,
					title:'子产品明细',
					width:700,
					height : 300,
					autoWidth : true,
					cm : this.childcmlist,
					ds : this.childgoodsstore,
					sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
					clicksToEdit : 1,
					stripeRows : true, // 让基数行和偶数行的颜色不一样
					viewConfig : {
						forceFit : true
					},
					iconCls : 'icon-grid',
					tbar : new Ext.Toolbar({
						items : [{
							xtype:'button',
							text:'新增子产品',
							id: 'childaddBtn',
							disabled:true,
							iconCls: 'x-tbar-add',
							handler:this.addChilditem.createDelegate(this)
						},{
							text: '删除',
							iconCls: 'x-tbar-del',
							id: 'childremoveBtn',
							handler: this.removeChildItem.createDelegate(this),
							disabled:true
						}]
					})
				});
	},
	afterselect:function(k,v)
	{
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
		Ext.getBody().mask("正在获取数据.请稍等...","x-mask-loading");
		Ext.Ajax.request({
			url: 'index.php?model=goods&action=getgoodscode',
			loadMask:true,
			params: {cat_id:k},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				Ext.getBody().unmask();
				if(res.success){
					if(res.msg) Ext.getCmp('goods_sn').setValue(res.msg);
				}else{
					Ext.Msg.alert('ERROR',res.msg);
				}						
			}
		});
		var aobt = Ext.getCmp('attributeset');
		if(Ext.getCmp('cat_id').getValue()){
			var attlength = Ext.getCmp('attributeset').items.length;
			for(var i = 0;i<attlength;i++){
				var x=aobt.items.get(0);
				 var array=Ext.query("*[for='"+x.id+"']");
				 Ext.removeNode(array[0]);
				aobt.remove(x,true);
			}
		}
		Ext.Ajax.request({ /*显示属性值*/
			url: 'index.php?model=attribute&action=showAttribute',
			loadMask:true,
			params: {id:k,language_id:1},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				Ext.getBody().unmask();
				
				for(var i = 0; i < res.length; i++){
					var datavalue = [];
					var valueID;
					var value;
					var label = (res[i]['attribute_label']) ? res[i]['attribute_label'] : '';
					var is_re = (res[i]['is_required']) ? true : false;
					switch(res[i]['entity_type_id']){
						case '1':
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
								fieldLabel:label,
								xtype:res[i]['entity_type_name'],
								allowBlank:is_re,
								id:'cat_attribute_'+i,
								name:'cat_attribute_'+i,
								width:180
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						case '2':
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
								fieldLabel:label,
								id:'cat_attribute_'+i,
								name:'cat_attribute_'+i,
								width:250,
								height:50,
								xtype:res[i]['entity_type_name'],
								allowBlank:is_re
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						case '3':
							/**
							 * 单选类型
							 */
							 if(res[i]['attribute_value'].length > 0){
								 var addattr = [];
								 for(var j = 0; j < res[i]['attribute_value'].length; j++){
									valueID = res[i]['attribute_value'][j]['value_id'];
									value = res[i]['attribute_value'][j]['value'];
									addattr.push({  
										name:'cat_attribute_'+i,
										boxLabel:value,
										value:valueID,
										xtype:res[i]['entity_type_name'],
									})
									
								}
								var disModel=new Ext.form.RadioGroup({
								   fieldLabel :label,
								   id:'cat_attribute_'+i,
								   items : [{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},addattr]
								 });
							 }
							aobt.add(disModel);
							aobt.doLayout(true);
						break;
						case '4':
							/**
							 * 复选框
							 */
							 if(res[i]['attribute_value'].length > 0){
								 var addattr = [];
								 for(var j = 0; j < res[i]['attribute_value'].length; j++){
									valueID = res[i]['attribute_value'][j]['value_id'];
									value = res[i]['attribute_value'][j]['value'];
									addattr.push({     
										boxLabel:value,
										name:'cat_attribute_'+i,
										value:valueID
									})
								}
								var disModel=new Ext.form.CheckboxGroup({
									id:'cat_attribute_'+i,
									fieldLabel:label,
									itemCls: 'x-check-group-alt',     
									columns: 3,   
								   items : [{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},addattr]
								 });
							 }
							aobt.add(disModel);
							aobt.doLayout(true);
						break;
						case '5':
							/**
							 * 下拉类型属性
							 */
							for(var j = 0; j < res[i]['attribute_value'].length; j++){
								valueID = res[i]['attribute_value'][j]['value_id'];
								value = res[i]['attribute_value'][j]['value'];
								datavalue.push([res[i]['attribute_value'][j]['value_id'],res[i]['attribute_value'][j]['value']]);
							}
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
								xtype:res[i]['entity_type_name'],
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data:datavalue
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								id:'cat_attribute_'+i,
								width:250,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'cat_attribute_'+i,
								name:'cat_attribute_'+i,
								allowBlank:is_re,
								fieldLabel:label
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						case '6':
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
							   fieldLabel:label,
							   width:80,
							   id:'cat_attribute_'+i,
							   name:'cat_attribute_'+i,
							   allowBlank:is_re,
							   xtype:res[i]['entity_type_name'],
							   allowNegative:false
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						case '7':
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
							   fieldLabel:label,
							   width:180,
							   allowBlank:is_re,
							   id:'cat_attribute_'+i,
							   name:'cat_attribute_'+i,
							   format:'Y-m-d',
							   value:'2037-12-31',
							   xtype:res[i]['entity_type_name'],
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						case '8':
							var addattr = 
							[{
								xtype:'hidden',
								value:res[i]['attribute_id'],
								name:'attrID_'+i,
								id:'attrID_'+i
							},{
								xtype:res[i]['entity_type_name'],
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data:[['1','是'],['0','否']]
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:250,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								id:'cat_attribute_'+i,
								hiddenName:'cat_attribute_'+i,
								name:'cat_attribute_'+i,
								allowBlank:is_re,
								fieldLabel:label
							}]
							aobt.add(addattr);
							aobt.doLayout(true);
						break;
						default:
						break;
					}
				}				
			}
		});
		Ext.Ajax.request({
			url: 'index.php?model=goods&action=getCatActionUser',
			loadMask:true,
			params: {cat_id:k},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					if(res.msg){								
						Ext.getCmp('product_purchaser').setValue(res.msg.product_purchaser);
						Ext.getCmp('products_developers').setValue(res.msg.products_developers);
						Ext.getCmp('product_operation').setValue(res.msg.product_operation);
						Ext.getCmp('product_quality_inspector').setValue(res.msg.product_quality_inspector);
						Ext.getCmp('product_rights_checker').setValue(res.msg.product_rights_checker);
					}
				}else{
					Ext.Msg.alert('ERROR',res.msg);
				}						
			}
		});
	},
	creatTab:function(){
		var afterselect = this.afterselect;
		var goodsgrid = this.goodsGrid;
		var num = 0;
		var tab = new Ext.TabPanel({
		plain:true,
        activeTab: 0,
        defaults:{autoScroll: true,autoHeight:true},
        items:[{
			    id:'tab1',
                title: '基本信息',
				layout:'form',
				autoScroll:true,
                items:[
					   {
						   layout:'column',
						   items:[
									{
									columnWidth:.99,
									layout: 'form',
									frame:false,
									defaultType: 'textfield',
									items:[{
											xtype: 'fieldset',
											defaultType: 'textfield',
											labelWidth: 80,
											border:true,
											title: '基本信息',
											items:[new Ext.form.TriggerField({
											editable: false,
											fieldLabel:'所属分类',
											xtype:'trigger',
											id:'cat_name',
											width:250,
											onSelect: function(record){
											},
											onTriggerClick: function() {
												getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',0,afterselect);
											}
											}),
											{xtype:'hidden',id:'cat_id'},
											{fieldLabel: '产品编码',id:'goods_sn',width:200},
										    {fieldLabel: 'SKU',id:'SKU',width:200},
										   {
												xtype:'combo',
												store: new Ext.data.SimpleStore({
													 fields: ["id", "key_type"],
													 data: this.goods_data[0]
												}),
												valueField :"id",
												displayField: "key_type",
												mode: 'local',
												width:250,
												editable: false,
												forceSelection: true,
												triggerAction: 'all',
												hiddenName:'status',
												name: 'status',
												allowBlank:false,
											   fieldLabel: '产品状态',
											   value:1,
											   id:'status_id'
											}, 
											{fieldLabel: '产品标题',id:'goods_name',allowBlank:false,width:350},
											{fieldLabel: '产品链接',id:'goods_url',width:350},
											{
											   fieldLabel: '保质期',
											   width:250,
											   id:'keeptime',
											   format:'Y-m-d',
											   value:'2037-12-31',
											   xtype:'datefield'
										    }
											]}]
									},{
										columnWidth:.99,
										layout: 'form',
										frame:false,
										defaultType: 'textfield',
										items:[
										{
											xtype: 'fieldset',
											defaultType: 'textfield',
											labelWidth: 120,
											autoScroll:true,
											border:true,
											items:[
												{
													xtype: 'fieldset',
													title: '分类属性',
													defaultType: 'textfield',
													id:'attributeset',
													labelWidth: 120,
													autoScroll:true,
													border:true,
													items:[]
												},{
													xtype: 'fieldset',
													title: '自定义属性',
													defaultType: 'textfield',
													id:'opattrset',
													layout:'column',
													width:350,
													autoScroll:true,
													border:true,
													items:[
															{
																xtype:'panel',
																columnWidth:.5,
																style:'align:center;margin:10px',
																html:'属性名'
															},
															{
																xtype:'panel',
																columnWidth:.5,
																style:'align:center;margin:10px',
																html:'属性值'
															}
													]
												},{
													xtype: 'fieldset',
													defaultType: 'textfield',
													layout:'column',
													width:350,
													autoScroll:true,
													border:false,
													items:[
															{
																columnWidth:.3,
																xtype: 'button',
																text: '添加自定义属性',
																style:'margin:20px 0 10px 0;',
																handler:function(){
																	var opatlen = Ext.getCmp('opattrset').items.length+1;
																	var aobt = Ext.getCmp('opattrset');
																	var addattr = 
																	[{ 
																		columnWidth:.45,
																		style:'align:center;margin:10px',
																		name:'opID_'+opatlen,
																		id:'opID_'+opatlen
																	 },{
																		columnWidth:.45,
																		style:'align:center;margin:10px',
																		name:'opValue_'+opatlen,
																		id:'opValue_'+opatlen
																	 }]
																		aobt.add(addattr);
																		aobt.doLayout(true);
																	}
															},
															{
																xtype: 'button',
																columnWidth:.3,
																text: '重置属性',
																style:'margin:20px 0 10px 15px;',
																handler:function(){
																	var opatlen = Ext.getCmp('opattrset').items.length;
																	var atlen = Ext.getCmp('attributeset').items.length;
																	var aobt = Ext.getCmp('attributeset');
																	var opaobt = Ext.getCmp('opattrset'); 
																	for(var i = 0;i<opatlen;i++){
																		var x=opaobt.items.get(0);
																		 var array=Ext.query("*[for='"+x.id+"']");
																		 Ext.removeNode(array[0]);
																		 opaobt.remove(x,true);
																	}
																	for(var i = 0;i<atlen;i++){
																		var x=aobt.items.get(0);
																		 var array=Ext.query("*[for='"+x.id+"']");
																		 Ext.removeNode(array[0]);
																		 aobt.remove(x,true);
																	}
																	opaobt.add(
																		{
																			xtype:'panel',
																			columnWidth:.5,
																			html:'属性名'
																		},
																		{
																			xtype:'panel',
																			columnWidth:.5,
																			html:'属性值'
																		}
																	);
																	opaobt.doLayout(true);
																	}
															},
															{
																xtype: 'button',
																columnWidth:.3,
																text: '生成描述',
																style:'margin:20px 0 10px 15px;',
																handler:function(){
																	var cid = Ext.getCmp('cat_id').getValue();
																	if(cid){
																		var labelvalue = '';
																		var attvalue = '';
																		var attarr = [];
																		var form_length = Ext.getCmp('goodsForm').getForm().items.length;
																		var filed = ''; //找到所有属性
																		var idset = '';
																		for(var i = 0 ; i < form_length ; i++){
																			filed = 'cat_attribute_'+i;
																			if(Ext.getCmp('goodsForm').getForm().findField(filed)){
																				attID_field = 'attrID_'+i;
																				idset += (idset == '') ? Ext.getCmp(attID_field).getValue() : ','+Ext.getCmp(attID_field).getValue();
																				if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'radiogroup' ){
																					var len = Ext.getCmp('goodsForm').getForm().findField(filed).items.length-1;
																					//for(var j = 0; j < len;j++){
																						//Ext.getCmp('goodsForm').getForm().findField(filed).getValues()[filed]
																					//}
																					attarr.push(len);
																				}else if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'checkboxgroup'){
																					var len = Ext.getCmp(filed).items.length;
																					attarr.push(len);
																				}else if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'combo'){
																					attvalue = Ext.get(filed).dom.value;
																					attarr.push(attvalue);
																				}else if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'textfield'){
																					attvalue = Ext.get(filed).dom.value;
																					attarr.push(attvalue);
																				}else if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'datefield'){
																					attvalue = Ext.get(filed).dom.value;
																					attarr.push(attvalue);
																				}else if(Ext.getCmp('goodsForm').getForm().findField(filed).getXType() == 'textarea'){
																					attvalue = Ext.get(filed).dom.value;
																					attarr.push(attvalue);
																				}else{
																					var len = Ext.getCmp(filed).items.length;
																					attarr.push(len);
																				}
																			}
																		}
																		Ext.Ajax.request({
																			url: 'index.php?model=attribute&action=getattributefield',
																			params: {id:idset},
																			success:function(response,opt){
																				var res = Ext.decode(response.responseText);
																				var htmltext = '<h2 style="background:#efefef;height:35px">产品详细描述</h2><table border=0 width="650px" style="font-size:12px;">';
																				for (var key in res){
																					if (key == 'remove') continue;
																					htmltext += '<tr><td width="25%">'+res[key]+'</td><td>'+attarr[key]+'</td></tr>';
																				}
																				var opatlen = (Ext.getCmp('opattrset').items.length -3 );
																				opatlen = opatlen/2;
																				var llid = 3;
																				for(var i = 0 ; i <= opatlen ; i++){
																					var idfield = 'opID_'+llid;
																					var valuefield = 'opValue_'+llid;
																					llid += 2;
																					htmltext += '<tr><td>'+Ext.getCmp('goodsForm').getForm().findField(idfield).getValue()+'</td><td>'+Ext.getCmp('goodsForm').getForm().findField(valuefield).getValue()+'</td></tr>';
																				}
																				Ext.getCmp('des_cn').setValue(htmltext+'</table>');
																			}
																		});
																	}else{
																		Ext.Msg.alert('info','请先选择分类');
																	}
																}
															}
														]
													}
												]
											}]
									},{
									columnWidth:.99,
									layout: 'form',
									frame:false,
									defaultType: 'textfield',
									items:[
										{
											xtype: 'fieldset',
											defaultType: 'textfield',
											labelWidth: 80,
											border:true,
											title: '描述模板',
											items:[
												new Ext.ux.form.FCKeditor({
													name : "des_cn", 
													width:380,
													height:430, 
													id : "des_cn", 
													fieldLabel : "详细描述"
												})
											]}
									]
									},{
									columnWidth:.99,
									layout: 'form',
									frame:false,
									defaultType: 'textfield',
									items:[
										{
											xtype: 'fieldset',
											defaultType: 'textfield',
											labelWidth: 80,
											border:true,
											title: '物流属性',
											items:[
												{
												   fieldLabel: '净重',
											   		xtype:'numberfield',
												   width:80,
												   id:'grossweight'
												},
											   {
												   fieldLabel: '重量',
											    xtype:'numberfield',
												   width:80,
												   id:'weight',
												   value:0,
												   allowBlank:false
												},
												{
												fieldLabel: '长',
												name:'l', 
											    xtype:'numberfield',
												width:80,
												id:'l'
												},{
												fieldLabel: '宽',
											    xtype:'numberfield',
												width:80,
												name:'w', 
												id:'w'
												},{
												fieldLabel:'高',
											    xtype:'numberfield',
												width:80,
												name:'h', 
												id:'h'
												},
											{
											   fieldLabel: '申报重量kg',width:80,
											   id:'Declared_weight',
											   xtype:'numberfield',
											   allowNegative:false
											},{
											   fieldLabel: '申报价值',width:80,
											   id:'Declared_value',
											   xtype:'numberfield',
											   allowNegative:false
											},
											{
											   fieldLabel: '报关名英文',width:150,
											   id:'dec_name'
										   	},{
											   fieldLabel: '报关名中文',width:150,
											   id:'dec_name_cn'
											 }
											]}
									]
									},{
											columnWidth:.99,
											border:true,
											layout: 'column',
											width:800,
											id:'imgform',
											frame:false,
											defaultType: 'textfield',
											items:[
											   {
												xtype: 'fieldset',
												columnWidth:.55,
												defaultType: 'textfield',
												labelWidth: 80,
												id:'imgitem',
												style:'padding:30px',
												width:400,
												height:300,
												border:true,
												title: '图片信息',
												items:[
												{
												   inputType: 'file',
												   xtype: 'textfield',
												   fieldLabel: '产品主图片',
													style:'margin:0px 0 110px 0;',
												   name:'photo_path',
												   id:'new_img',
												   listeners: {
													change: function(n) {
													var url = Ext.get('new_img').dom.value;
													var lid = Ext.getCmp('showimg').items.length;
													var addshow = 
													{
													columnWidth:.4,
													xtype : 'box', 
													id : 'browseImage'+lid,
													name:'browseImage'+lid,
													border:true,
													autoEl : 
														{
															tag:'div',
															id:'did'+lid,
															cls:'thumb-wrap',
															onMouseOver:"Ext.fly('did"+lid+"').addClass('x-view-over');",
															onMouseOut:"Ext.fly('did"+lid+"').removeClass('x-view-over');",
															onClick:"Ext.fly('did"+lid+"').toggleClass('x-view-selected');",
															children:[{
																tag:'div',
																cls:'thumb',
																children:[{
																	tag: 'img',
																	src : Ext.BLANK_IMAGE_URL,
																	style : 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);',
																	id: 'imageBrowse'+lid
																},{
																	tag: 'hidden',
																	id: 'goodimg'+lid,
																	value:url
																	}
																
																
																]
															}]
														}
													}
													Ext.getCmp('showimg').add(addshow);
													Ext.getCmp('showimg').doLayout(); 
													url += 'file://'+ url; 
													if (Ext.isIE) {  
														var image = Ext.get('imageBrowse'+lid).dom;  
														image.src = Ext.BLANK_IMAGE_URL;
														image.filters  
																.item("DXImageTransform.Microsoft.AlphaImageLoader").src = url;  
				  
													}
													else {
														var file=Ext.get('new_img').dom;
														var objectURL = window.URL.createObjectURL(file.files[0]);
														Ext.get('imageBrowse'+lid).dom.src = objectURL;  
														num++;
													} 
														
													}
													}
												}/*,{
												xtype: 'button',
												text: '添加图片',
												style:'margin:20px 0 40px 80px;',
												iconCls:'x-tbar-add',
												handler:function(){
													
													//alert(document.getElementById('new_img').);return;
													
										
													}
												}*/,{
													fieldLabel: '图片链接(多张;号分割)',
													id:'goods_img',
													name:'goods_img',
													width:190,
													height:80,
													xtype:'textarea'
												}
												]},
												{
												xtype: 'fieldset',
												defaultType: 'box',
												labelWidth: 80,
												layout: 'form',
												style:'margin-left:5px',
												id:'showimg',
												width:300,
												autoScroll:true,
												border:false,
												title: '预览图片',
												items:[]},{
													xtype: 'button',
													text: '删除图片',
													style:'margin:20px 0 40px 80px;',
													handler:function(){
														var showlen = Ext.getCmp('showimg').items.length;
														var showob = Ext.getCmp('showimg');
														for(var i = 0;i<showlen;i++){
															var x=showob.items.get(0);
															 var array=Ext.query("*[for='"+x.id+"']");
															 Ext.removeNode(array[0]);
															 showob.remove(x,true);
														}
														Ext.get('new_img').dom.value = '';
														showob.doLayout(true);
													}
												}
											   ]
											},{
											columnWidth:.99,
											layout: 'form',
											frame:false,
											defaultType: 'textfield',
											items:[
												{
													xtype: 'fieldset',
													defaultType: 'textfield',
													labelWidth: 80,
													border:true,
													title: '其他信息',
													items:[{
														xtype:'combo',
														store: new Ext.data.SimpleStore({
															 fields: ["id", "key_type"],
															 data: account
														}),
														valueField :"id",
														displayField: "key_type",
														mode: 'local',
														width:220,
														editable: false,
														forceSelection: true,
														id:'product_purchaser',
														triggerAction: 'all',
														hiddenName:'product_purchaser',
														allowBlank:false,
														emptyText:'请选择',
														name: 'product_purchaser',
														fieldLabel: '采购员'
														},{
														xtype:'combo',
														store: new Ext.data.SimpleStore({
															 fields: ["id", "key_type"],
															 data: account
														}),
														valueField :"id",
														displayField: "key_type",
														mode: 'local',
														width:220,
														editable: false,
														forceSelection: true,
														id:'products_developers',
														triggerAction: 'all',
														hiddenName:'products_developers',
														allowBlank:false,
														name: 'products_developers',
														emptyText:'请选择',
														fieldLabel: '产品开发员'
														},{
														xtype:'combo',
														store: new Ext.data.SimpleStore({
															 fields: ["id", "key_type"],
															 data: account
														}),
														valueField :"id",
														displayField: "key_type",
														mode: 'local',
														width:220,
														editable: false,
														forceSelection: true,
														id:'product_operation',
														triggerAction: 'all',
														hiddenName:'product_operation',
														allowBlank:false,
														name: 'product_operation',
														emptyText:'请选择',
														fieldLabel: '产品运营员'
														},{
														xtype:'combo',
														store: new Ext.data.SimpleStore({
															 fields: ["id", "key_type"],
															 data: account
														}),
														valueField :"id",
														displayField: "key_type",
														mode: 'local',
														width:220,
														editable: false,
														forceSelection: true,
														id:'product_quality_inspector',
														triggerAction: 'all',
														hiddenName:'product_quality_inspector',
														allowBlank:false,
														name: 'product_quality_inspector',
														emptyText:'请选择',
														fieldLabel: '产品质检员'
														},{
														xtype:'combo',
														store: new Ext.data.SimpleStore({
															 fields: ["id", "key_type"],
															 data: account
														}),
														valueField :"id",
														displayField: "key_type",
														mode: 'local',
														width:220,
														editable: false,
														forceSelection: true,
														id:'product_rights_checker',
														triggerAction: 'all',
														hiddenName:'product_rights_checker',
														allowBlank:false,
														name: 'product_rights_checker',
														emptyText:'请选择',
														fieldLabel: '产品侵权审核员'
														},{
												   fieldLabel: '管理序列号',
												   xtype:'checkbox',
												   id:'sn_control',
												   checked:false,
												   value:0
												 },{
												   fieldLabel: '组合产品',
												   xtype:'checkbox',
												   id:'is_group',
												   checked:false,
												   disabled : true
												 },{
											   fieldLabel: '管理库存',
											   xtype:'checkbox',
											   name:'is_control',
											   checked:true,
											   value:1
										   },{
											   fieldLabel: '有无子产品',
											   xtype:'checkbox',
											   name:'has_child',
											   checked:false,
											   value:0,
											   listeners:{
												   'check':function(){
													  Ext.getCmp('childaddBtn').setDisabled(!this.checked);
													   }
												   }
											 },{
												   fieldLabel: '自编码',width:150,
												   id:'code'
												},{
												   fieldLabel: 'UPC',width:150,
											   id:'upc'
												},
												 {
													fieldLabel: '产品备注',
													id:'comment',
													width:500,
													height:60,
													xtype:'textarea'
	
												}
											]}
									]
									}
								]
						},
						this.childgoodsGrid]
            },{
				id:'tab2',
                title: '费用相关',
				layout:'form',
				autoScroll:true,
                defaultType: 'textfield',
                items: [{
                    fieldLabel: '成本价',
					width:200,
                    name: 'cost',
					value:0,
					xtype:'numberfield'
                },{
                    fieldLabel: '价格1',
					width:200,
                    name: 'price1',
					xtype:'numberfield'
                },{
                    fieldLabel: '价格2',
					width:200,
                    name: 'price2',
					xtype:'numberfield'
                },{
                    fieldLabel: '价格3',
					width:200,
                    name: 'price3',
					xtype:'numberfield'
                }]
            }/*,{
				id:'tab3',
                title: '中国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_CN',
					width:200,
                    name: 'Grade_cn',
					tabTip:'test'
                },{
                    fieldLabel: 'Plan_cn',
					width:200,
                    name: 'plan_cn'
                },{
                    fieldLabel: 'Price_cn',
					width:200,
                    name: 'price_cn',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_cn", 
					width:380,
					height:430, 
					id : "des_cn", 
					fieldLabel : "中文描述"
					})
				]
			}*/,{
				id:'tab4',
                title: '美国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_US',
					width:200,
                    name: 'Grade_us'
                },{
                    fieldLabel: 'Plan_US',
					width:200,
                    name: 'plan_us'
                },{
                    fieldLabel: 'Price_US',
					width:200,
                    name: 'price_us',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_en", 
					width:380,
					height:430, 
					id : "des_en", 
					fieldLabel : "英文描述"
					})
 				]
            },{
				id:'tab5',
                title: '澳大利亚刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_AU',
					width:200,
                    name: 'Grade_au'
                },{
                    fieldLabel: 'Price_AU',
					width:200,
                    name: 'price_au',
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_AU',
					width:200,
                    name: 'plan_au'
                }]
            },{
				id:'tab6',
                title: '英国刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_UK',
					width:200,
                    name: 'Grade_uk',
					value:this.good
                },{
                    fieldLabel: 'Price_UK',
					width:200,
                    name: 'price_uk',
					xtype: 'numberfield'
                },{
                    fieldLabel: 'Plan_UK',
					width:200,
                    name: 'plan_uk'
                }]
            },{
				id:'tab7',
                title: '德文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_DE',
					width:200,
                    name: 'Grade_de'
                },{
                    fieldLabel: 'Plan_DE',
					width:200,
                    name: 'plan_de'
                },{
                    fieldLabel: 'Price_DE',
					width:200,
                    name: 'price_de',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_de", 
					width:380,
					height:430, 
					id : "des_de", 
					fieldLabel : "德文描述"
					})
 				]
			},{
				id:'tab8',
                title: '法文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_FR',
					width:200,
                    name: 'Grade_fr'
                },{
                    fieldLabel: 'Plan_FR',
					width:200,
                    name: 'plan_fr'
                },{
                    fieldLabel: 'Price_FR',
					width:200,
                    name: 'price_fr',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_fr", 
					width:380,
					height:430, 
					id : "des_fr", 
					fieldLabel : "法文描述"
					})
				]
			},{
				id:'tab9',
                title: '西班牙文刊登',
                layout:'form',
                defaultType: 'textfield',
                items: [{
                    fieldLabel: 'Grade_SP',
					width:200,
                    name: 'Grade_sp'
                },{
                    fieldLabel: 'Plan_SP',
					width:200,
                    name: 'plan_sp'
                },{
                    fieldLabel: 'Price_SP',
					width:200,
                    name: 'price_sp',
					xtype: 'numberfield'
                },new Ext.ux.form.FCKeditor({
					name : "des_sp", 
					width:380,
					height:430, 
					id : "des_sp", 
					fieldLabel : "西班牙文描述"
					})
				]
			}
			]
		});		
		return tab;
	},

	getTab:function(){
        if (!this.tab) {
            this.tab = this.creatTab();
        }
        return this.tab;
	},

	creatItems:function(){
		this.items = [this.tab];
	},

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.createDelegate(this)
			},{
					text: '取消',
					handler:this.formreset.createDelegate(this)
			}];		
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
			/*var att = '';
			var form_length = this.getForm().items.length;
			var filed = ''; //找到所有属性
			for(var i = 0 ; i < form_length ; i++){
				filed = 'cat_attribute_'+i; 
				if(this.getForm().findField(filed)){
					alert(this.getForm().findField(filed).getXType())
					alert(this.getForm().findField(filed).getValue())
				}
			}*/
			var jsonArray1 = [];
			if(this.getForm().getFieldValues().has_child){	
				var n = this.childgoodsstore.modified.slice(0);
				Ext.each(n,function(item){
					jsonArray1.push(item.data);
				});
			}
				this.getForm().submit({
					url:'index.php?model=goods&action=save',
					waitMsg: '正在更新产品资料',
					params:{'childdata':Ext.encode(jsonArray1),'data':''},
					method:'post',
					success:function(form,action){
						if (action.result.success) {
							
							Ext.example.msg('MSG',action.result.msg);
							window.location.href = 'index.php?model=goods&action=edit&goods_id='+action.result.msg;
						} else {
							Ext.Msg.alert('新增产品失败',action.result.msg);
						}
					},
					failure:function(form,action){
									Ext.Msg.alert('新增产品失败',action.result.msg);
					}
				});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
		}
	},
	formreset:function(){//表单重置
		this.form.reset();
	},

	removeChildItem:function(){//移除子物品
		var data = this.ChildgoodsGrid.getSelectionModel().getSelected().data;
		var index = this.Childgoodsstore.findBy(function(record,id){
				return record.get('child_sn') == data.child_sn;									
													});
		thiz.remove(this.Childgoodsstore.getAt(index));
	},
	addChilditem: function() {
		var Item = Ext.data.Record.create([{
			name:'child_sn',
			type:'string'
		}, {
			name : 'color',
			type:'int'
		},{
			name : 'size',
			type:'int'
		}, {
			name : 'price',
			type:'float'
		}, {
			name : 'stock',
			type : 'float'
		}]);
		var p = new Item({child_sn:'',size:'0',color:'0',price:0,stock:0});
		this.childgoodsstore.insert(0, p);
		this.childgoodsGrid.startEditing(0, 0); // 光标停留在第几行几列
	}
});

