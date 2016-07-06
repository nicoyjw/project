Ext.define('Ext.ux.goodsForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = false,
		this.fileUpload = true,
		this.autoHeight = true,
		this.opattrlen = 1;
		this.buttonAlign = 'center',
		this.creatItems();
        this.callParent(this);
    },
	afterselect:function(k,v){
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
		Ext.Ajax.request({ /*显示属性值*/
			url: 'index.php?model=aliexpress&action=showAttribute',
			params: {cateId:k},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				Ext.getCmp('attrlength').setValue(res.length);
				var aobt = Ext.getCmp('attributeset');
				for(var i = 0;i < res.length;i++){
					var datavalue = [];
					var valueID;
					var value;
					switch(res[i]['show_type']){
						case 'combo':
						for(var j = 0; j < res[i]['values'].length; j++){
							valueID = res[i]['values'][j]['id'];
							value = res[i]['values'][j]['names']['zh'];
							datavalue.push([valueID,value]);
						}
						datavalue.push([0,'---请选择---']);
						var addattr = 
						[
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
							xtype:'combo',
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data:datavalue
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							id:'cat_attribute_'+i,
							labelWidth:145,
							autoScroll:true,
							width:350,
							style:'margin-top:15px;',
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'cat_attribute_'+i,
							name:'cat_attribute_'+i,
							fieldLabel:res[i]['name'],
							value:0
						}]
						aobt.add(addattr);
						aobt.doLayout(true);
						break;
						case 'checkboxgroup':
						var checkitems = [];
						 for(var j = 0; j < res[i]['values'].length; j++){
							valueID = res[i]['values'][j]['id'];
							value = res[i]['values'][j]['names']['zh'];
							checkitems.push({    
								boxLabel: value, name: valueID
							})
						}
						var checkGroup = {
							xtype: 'fieldset',
							frame:false,
							style:'margin-top:15px;',
							border:false,
							layout: 'anchor',
							width:650,
							defaults: {
								anchor: '100%'
							},
							items: [
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},
							{
								xtype: 'checkboxgroup',
								fieldLabel: res[i]['name'],
								labelWidth:145,
								name:'cat_attribute_'+i,
								id:'cat_attribute_'+i,
								columns: 3,
								vertical: true,
								cls: 'x-check-group-alt',
								items: checkitems	
							}]
						 }
						aobt.add(checkGroup);
						aobt.doLayout(true);
						break;
						case 'radio':
						var radioitems = [];
						 for(var j = 0; j < res[i]['values'].length; j++){
							radioitems.push({ boxLabel:res[i]['values'][j]['id'], name:'rb_'+i , inputValue: res[i]['values'][j]['names']['zh']
							})
						}
						var radioGroup = {
						xtype: 'fieldset',
						frame:false,
						border:false,
						style:'margin-top:15px;',
						layout: 'form',
						width:650,
						items: [
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
							xtype: 'radiogroup',
							fieldLabel:res[i]['name'],
							cls: 'x-check-group-alt',
							labelWidth:145,
							name:'cat_attribute_'+i,
							id:'cat_attribute_'+i,
							columns: 3,
							vertical: true,
							items: radioitems
						}
						]}
						aobt.add(radioGroup);
						aobt.doLayout(true);
						break;
						case 'textfield':
						var addattr = 
						[
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
							fieldLabel:res[i]['name'],
							xtype:'textfield',
							id:'cat_attribute_'+i,
							style:'margin-top:15px;',
							name:'cat_attribute_'+i,
							width:350,
							labelWidth:145
						}]
						aobt.add(addattr);
						aobt.doLayout(true);
						break;
						case 'numberfield':
						var addattr = 
						[
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
						   fieldLabel:res[i]['name'],
						   labelWidth:145,
						   width:350,
						   style:'margin-top:15px;',
						   id:'cat_attribute_'+i,
						   name:'cat_attribute_'+i,
						   hideTrigger:true,
						   xtype:'numberfield',
						   minValue:0
						}]
						aobt.add(addattr);
						aobt.doLayout(true);
						break;
						case 'textarea':
						var addattr = 
						[
							{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
							fieldLabel:res[i]['name'],
							id:'cat_attribute_'+i,
							name:'cat_attribute_'+i,
							width:350,
							height:50,
							style:'margin-top:15px;',
							xtype:'textarea'
						}]
						aobt.add(addattr);
						aobt.doLayout(true);
						break;		
					}
				}	
			}
		});
	},
	creatItems:function(){
		var num = 0;
		var me = this;
		var afterselect = this.afterselect;
		this.items = [{
					layout:'column',
					buttonAlign:'center',
					style:'padding:5px;',
					items:[{
						columnWidth:.99,
						padding: '5px',
						items:[{
								xtype:'button',
								text:'保存',
								style:'margin-bottom:15px;',
								handler:function(){me.formsubmit(me)}
							},{
							xtype: 'fieldset',
							defaultType: 'textfield',
							padding: '10px',
							items:[{   
								xtype : 'displayfield',   
								value : '<b>产品基本信息</b>'
								},{xtype:'hidden',name:'cat_id',id:'cat_id'},{xtype:'hidden',name:'attrlength',id:'attrlength',value:0},{
								editable: false,
								fieldLabel:'<b style="color:red">*</b> 分类',
								xtype:'triggerfield',
								style:'margin-bottom:20px;',
								id:'cat_name',
								name:'cat_name',
								width:480,
								labelWidth: 85,
								onSelect: function(record){
								},
								onTriggerClick: function() {
									getCategoryFormTree('index.php?model=aliexpress&action=getAliCate&com=0',0,afterselect);
								}
							},{
									fieldLabel: '<b>&nbsp;&nbsp;</b>查看属性',
									xtype: 'checkbox',
									name: 'is_attrshow',
									labelWidth: 85,                       
									checked: false,
									listeners:{
										change:function(field,e){
											if(field.checked){Ext.getCmp('attributeset').expand();
											}else{Ext.getCmp('attributeset').collapse();}
										}
									}
								},{
								xtype: 'fieldset',
								defaultType: 'textfield',
								id:'attributeset',
								hideLabel:true,
								width:800,
								collapsible:true,
								collapsed:false,
								autoScroll:true,
								padding:5,
								items:[]
							},{
									xtype:'combo',
									store: Ext.create('Ext.data.ArrayStore',{
										 fields: ["id", "key_type"],
										 data: this.goods_data[4]
									}),
									valueField :"id",
									displayField: "key_type",
									mode: 'local',
									width:250,
									labelWidth: 85,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'account_id',
									style:'margin-bottom:20px;',
								    fieldLabel: '<b style="color:red">*</b> 帐号',
								    value:'0',
								    id:'account_id',
								    name:'account_id'
								},{
									fieldLabel : '<b style="color:red">*</b> 关键字',id:'keyword',name:'keyword',width:250,
									style:'margin-bottom:20px;',labelWidth: 85
								},{
									fieldLabel : '<b style="color:red">*</b> 标题',id:'goods_name',name:'goods_name',width:550,
									style:'margin-bottom:20px;',labelWidth: 85
								},{
									xtype:'combo',
									store: Ext.create('Ext.data.ArrayStore',{
										 fields: ["id", "key_type"],
										 data: this.goods_data[0]
									}),
									valueField :"id",
									displayField: "key_type",
									mode: 'local',
									width:250,
									style:'margin-bottom:20px;',
									labelWidth: 85,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'productUnit',
									fieldLabel: '<b style="color:red">*</b> 单位',
									id:'productUnit',
									name:'productUnit',
									value:'100000015',
									listeners : {
										"change" : function(c, r, i) {
											/*****获取选中com显示值******/
											var value = c.getValue();
											var valueField = c.valueField;
											var record;
											c.getStore().each(function(r){
												if(r.data[valueField] == value){
													record = r;
													return false;
												}
											});
											Ext.getCmp('packagetLabel').setValue('按'+record.get(c.displayField)+'出售');
										}
									}
								},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b style="color:red">*</b> 销售方式',
								labelWidth: 85,
									style:'margin-bottom:20px;',
								width:650,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
								{
									xtype:'radio',
									hideLabel:true,
									id:'package0',
									name:'packageType',
									inputValue : 0,
									checked : true,
									listeners : {
										"change" : function(el, checked) {
											if (checked) {
												Ext.getCmp('lotNum').hide();
											}
										}
									}
								},{   
									xtype : 'displayfield',   
									value : '按件/个 (piece/pieces)出售',
									style:'margin-left:5px;',
									id:'packagetLabel'
								},{
									xtype:'radio',
									style:'margin-left:25px;',
									hideLabel : true,
									name:'packageType',
									inputValue : 1,
									listeners : {
										"change" : function(el, checked) {
											if (checked) {
												Ext.getCmp('lotNum').show();
											}
										}
									}
								},{   
									xtype: 'label',   
									forId : 'package1', 
									id:'packagetype1value',
									style:'margin-left:5px;',  
									text: '打包出售'
								},
								{fieldLabel: '每包数量',style:'margin-left:25px;',labelWidth:65,id:'lotNum',name:'lotNum',value:1,width:150,hidden:true}
						]},
								{   
									xtype:'numberfield',
									id : 'productPrice',
									name:'productPrice',
									width:180,
									labelWidth: 85,
									fieldLabel: '<b style="color:red">*</b> 零售价',
									hideTrigger:true,
									style:'margin-bottom:20px;',
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:2
								},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b>&nbsp;&nbsp;</b>批发价',
								labelWidth: 85,
								style:'margin-bottom:20px;',
								width:850,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
										{   
											name:'bukkk',   
											id:'bukkk',
											xtype : 'checkbox',
											hideLabel:true,
											checked:false,
											listeners : {
												"change" : function(el, checked) {
													if (checked) {
														Ext.getCmp('bulkOrder').show();
														Ext.getCmp('bulk_1').show();
														Ext.getCmp('bulk_2').show();
														Ext.getCmp('bulk_3').show();
														Ext.getCmp('bulk_4').show();
														Ext.getCmp('bulkDiscount').show();
													}else{
														Ext.getCmp('bulkOrder').hide();
														Ext.getCmp('bulk_1').hide();
														Ext.getCmp('bulk_2').hide();
														Ext.getCmp('bulk_3').hide();
														Ext.getCmp('bulk_4').hide();
														Ext.getCmp('bulkDiscount').hide();
													}
												}
											}
										},{   
											xtype : 'displayfield',   
											value : '支持',
											style:'margin-left:5px;'
										},{   
											xtype : 'displayfield',   
											value : '当购买超过',
											id:'bulk_1',
											hidden:true,
											style:'margin-left:15px;'
										},{   
											name:'bulkOrder',   
											id:'bulkOrder',
											hideLabel:true,
											hideTrigger:true,
											xtype : 'numberfield',   
											width:45,
											hidden:true,
											style:'margin-left:5px;'
										},{   
											xtype : 'displayfield',   
											value : '包时，每包价格在零售价的基础上减免',
											hidden:true,
											id:'bulk_2',
											style:'margin-left:5px;'
										},{   
											name:'bulkDiscount',   
											id:'bulkDiscount',
											hideLabel:true,
											hideTrigger:true,
											xtype : 'numberfield',
											width:45,
											maxValue:99,
											hidden:true,
											style:'margin-left:5px;',
											listeners : {
												"blur" : function(el) {
													var va = 100-el.getValue();
													Ext.getCmp('bulk_3').setValue((va/10)+' 折');
												}
											}
										},{   
											xtype : 'displayfield',
											id:'bulk_4',
											hidden:true,
											value:'%,即',
											style:'margin-left:5px;'
										},{   
											xtype : 'displayfield',
											id:'bulk_3',
											hidden:true,
											value:'0 折',
											style:'margin-left:5px;'
										}
									]
								},
								{   
									xtype : 'numberfield',
									id : 'deliveryTime',
									name:'deliveryTime',
									width:180,
									labelWidth: 85,
									maxValue:60,
									style:'margin-bottom:20px;',
									fieldLabel: '<b style="color:red">*</b> 发货期'
								},{   
									xtype: 'fieldcontainer',   
									fieldLabel: '<b style="color:red">*</b> 产品图片',
									labelWidth: 85,
									style:'margin-bottom:20px;',
									width:850,  
									layout: {
										type: 'hbox',   
										align: 'middle'
									},   
									combineErrors : true,
									defaultType: 'textfield',
									items: [{
										   xtype: 'fileuploadfield',
										   hideLabel: true,
										   name:'photo_path',
										   id:'photo_path',
										   buttonText : '选择本地产品', 
										   width:250
										},{
											width:250,
											id: 'goods_img',
											labelWidth:85,
											style:'margin-left:20px;',
											height:25,
											fieldLabel: '或者图片路径',
											name : 'goods_img'
										}
									]
								},
								{fieldLabel: '<b>&nbsp;&nbsp;</b>商品编码',id:'skuCode',name:'skuCode',
									style:'margin-bottom:20px;',width:250,labelWidth: 85},
								{   
									xtype : 'displayfield',   
									style:'margin-bottom:10px;',
									value : '<b style="color:red">*</b> 产品描述'
								},Ext.create('Ext.ux.form.field.CKEditor',{
								id:'detail',
								name:'detail',
								style:'margin-top:5px;',
								autoScroll:true,
								width:900,
								height:530,
								coreStyles_bold:{element:'span',attributes:{'class': 'Bold'} },
								coreStyles_italic:{element:'span',attributes:{'class': 'Italic'}},
								coreStyles_underline:{element:'span',attributes:{'class': 'Underline'}},
								coreStyles_strike:{element:'span',attributes:{'class':'StrikeThrough'},overrides:'strike'},
								coreStyles_subscript:{element:'span',attributes:{'class': 'Subscript'},overrides:'sub'},
								coreStyles_superscript : { element : 'span',attributes:{'class':'Superscript'},overrides:'sup'},
								font_names: 'Comic Sans MS/FontComic;Courier New/FontCourier;Times New Roman/FontTimes',
								font_style:{
										element:'span',
										attributes:{'class':'#(family)'},
										overrides:[{element:'span',attributes:{'class':/^Font(?:Comic|Courier|Times)$/ }}]
								},
								fontSize_sizes:'Smaller/FontSmaller;Larger/FontLarger;8pt/FontSmall;14pt/FontBig;Double Size/FontDouble',
								fontSize_style:{
								element:'span',
								attributes:{'class':'#(size)'},
								overrides:[{element:'span',attributes:{'class':/^Font(?:Smaller|Larger|Small|Big|Double)$/} }]
								},
								colorButton_enableMore : false,
								colorButton_colors:'FontColor1/FF9900,FontColor2/0066CC,FontColor3/F00',
								colorButton_foreStyle :{
									element : 'span',
									attributes : {'class':'#(color)'},
									overrides	: [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
								},
							colorButton_backStyle:{
									element : 'span',
									attributes : {'class':'#(color)BG'},
									overrides	: [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
								},
							indentClasses : ['Indent1', 'Indent2', 'Indent3'],
							justifyClasses : [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull' ],
							stylesSet:[
								{name:'Strong Emphasis',element:'strong'},
								{name:'Emphasis',element:'em'},
								{name:'Computer Code',element:'code'},
								{name:'Keyboard Phrase',element:'kbd'},
								{name:'Sample Text',element:'samp'},
								{name:'Variable',element:'var'},
								{name:'Deleted Text',element:'del'},
								{name:'Inserted Text',element:'ins'},
								{name:'Cited Work',element:'cite'},
								{name:'Inline Quotation',element:'q' }
							]
							})
								
								]
						}]
					},{
						columnWidth:.99,
						padding: '5px',
						defaultType: 'textfield',
						items:[{
						xtype: 'fieldset',
						padding: '10px',
						defaultType: 'textfield',
						items:[{   
								xtype : 'displayfield',   
								value : '<b>包装信息</b>'
								},{
								fieldLabel: '<b style="color:red">*</b> 产品包装后的重量(KG)',
								xtype:'numberfield',
								width:220,
								maxValue: 100,
								labelWidth: 155,
								style:'margin-bottom:20px;',
								allowDecimals:true,
								allowNegative:false,
							 	  	hideTrigger:true,
								decimalPrecision:2,
								id:'grossWeight',
								name:'grossWeight'
							},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b style="color:red">*</b> 产品包装后的尺寸(CM)', 
								style:'margin-bottom:20px;',  
								labelWidth: 155,
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [{ 
									name:'packageLength',   
									xtype : 'numberfield',   
									inputId : 'l',
									hideLabel : true,
									maxValue: 100,
									allowDecimals:true,
							 	  	hideTrigger:true,
									allowNegative:false,
									decimalPrecision:1,
									width:60 
								},{   
									xtype: 'label',   
									forId : 'l', 
									style:'margin-left:5px;',  
									text: '长*'  
								},{   
									name:'packageWidth',   
									xtype : 'numberfield',   
									inputId : 'w',   
									maxValue: 100,
									allowDecimals:true,
							 	  	hideTrigger:true,
									allowNegative:false,
									decimalPrecision:1,
									hideLabel : true,  
									width:60,
									style:'margin-left:10px;'
								},{   
									xtype: 'label',   
									forId : 'w',
									style:'margin-left:5px;',  
									text: '宽*'  
								},{   
									name:'packageHeight',   
									xtype : 'numberfield',
									hideLabel : true,  
									maxValue: 100,
							 	  	hideTrigger:true,
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:1,
									width:60,
									style:'margin-left:10px;'
								},{   
									xtype: 'label',   
									forId : 'h',
									style:'margin-left:5px;',
									text: '高'  
								}]   
            				}]
						}]
					},{
						columnWidth:.99,
						padding:5,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							padding:10,
							labelWidth: 120,
							autoScroll:true,
							items:[
							{   
								xtype : 'displayfield',   
								value : '<b>其他信息</b>'
							}
							,{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b style="color:red">*</b> 有效天数',
								labelWidth: 85,
									style:'margin-bottom:20px;',
								width:650,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
								{
									xtype:'radio',
									hideLabel:true,
									id:'wsValidNum0',
									name:'wsValidNum',
									inputValue : 14,
									checked : true
								},{   
									xtype : 'displayfield',   
									value : '14天',
									style:'margin-left:5px;',
								},{
									xtype:'radio',
									value:1,
									style:'margin-left:25px;',
									hideLabel : true,
									name:'wsValidNum',
									inputValue : 30
								},{   
									xtype : 'displayfield',   
									value : '30天',
									style:'margin-left:5px;',
								}
						]},
							{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: []
							}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:220,labelWidth: 85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'freightTemplateId',
								fieldLabel: '运费模板',
								id:'freightTemplateId',
								name:'freightTemplateId'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: []
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:220,labelWidth: 85,
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'groupId',
								fieldLabel: '产品组',
								id:'groupId',
								name:'groupId'
								}
							
							]
						}]
					}],
					buttons:[{
						text: '保存',
						type: 'submit', 
						handler:me.formsubmit.bind(me)
					},{
						text: '取消',
						handler:me.formreset.bind(me)
					}]
				}];
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
			var jsonArray = [];
			for(var i = 0 ; i < Ext.getCmp('attrlength').getValue(); i++){
				filed = 'cat_attribute_'+i;
				labelfieldd = 'attr_keyid_'+i;
				if(Ext.getCmp(filed).getXType() == 'combobox'   || Ext.getCmp(filed).getXType() == 'radio' ){
					/*var value = Ext.getCmp(filed).getValue();
					var valueField = Ext.getCmp(filed).valueField;
					var record;
					Ext.getCmp(filed).getStore().each(function(r){
						if(r.data[valueField] == value){
							record = r;
							return false;
						}
					});*/
					var attr = {"attrValueId":Ext.getCmp(filed).getValue(),"attrNameId":Ext.getCmp(labelfieldd).getValue()};
					jsonArray.push(attr);
					//record.get(Ext.getCmp(filed).displayField);
				}
				if(Ext.getCmp(filed).getXType() == 'checkboxgroup'){
					var items = Ext.getCmp(filed).items;
					var array=[];
					if(items.length > 0){
						for(var i = 0; i< items.length; i++){
							var _item = items[i];
							
							if( _item && _item.getValue()){
								var attr = {"attrValueId":_item.getValue(),"attrNameId":Ext.getCmp(labelfieldd).getValue()};
								jsonArray.push(attr);
							}	
						}
					}
				}
				if(Ext.getCmp(filed).getXType() == 'textfield' || Ext.getCmp(filed).getXType() == 'textarea'){
					var attr = {"attrValue":Ext.getCmp(filed).getValue(),"attrNameId":Ext.getCmp(labelfieldd).getValue()};
					jsonArray.push(attr);
				}
			}

			this.getForm().submit({
				url:'index.php?model=goods&action=saveAligoods',
				waitMsg: '正在更新产品资料',
				params:{'attribute':Ext.encode(jsonArray)},
				method:'post',
				success:function(form,action){
					if (action.result.success) {
						Ext.Msg.alert('新增产品成功','请返回未刊登上传产品处刷新。');
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
	formreset:function(){
		this.form.reset();
	},
	addprice:function(fh){
		var price = parseFloat(Ext.getCmp('StartPrice').getValue());
		if(fh == '+'){
			price = price + 0.1;
		}else{
			price = price - 0.1;
		}
		if(price.toFixed){ 
    		price = price.toFixed(2); 
		}else{
			var div = Math.pow(10,2);
			price = Math.round(price * div) / div;
		} 
		Ext.getCmp('StartPrice').setValue(price);
	}
});

