Ext.define('Ext.ux.goodsForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = false,
		this.fileUpload = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatChildGridcm();
		this.creatChildGoodsstore();
		this.creatChildGoodsgrid();
		this.getTab();
		this.creatItems();
		this.creatButtons();
        this.callParent(this);
    },
	creatChildGoodsstore:function(){//子产品明细store
		this.childgoodsstore = Ext.create('Ext.data.JsonStore', {
			fields:['child_sn','color','size','price','stock'],
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					root: 'topics'
				}
			}
		});
	},	

	creatChildGridcm:function(){
		var thiz =this;
		this.childcmlist = [{
			  header:'自动编码',
			  flex:0.6,
			  xtype: 'actioncolumn',
			  items:[{
					icon   : 'themes/default/images/update.gif',	 
					tooltip: '自动生成子产品编码',
					handler: function(grid, rowIndex, colIndex) {
						return false;
						if(!Ext.getCmp('cat_id').getValue()){
							Ext.example.msg('MSG','请先选择一个分类');
							return;
						}
						var id = thiz.childgoodsstore.getAt(rowIndex).get('color');
						if(!id){
							Ext.example.msg('MSG','请先选择颜色');
							return;
						}
						var price = thiz.childgoodsstore.getAt(rowIndex).get('price');
						var stock = thiz.childgoodsstore.getAt(rowIndex).get('stock');
						var size = thiz.childgoodsstore.getAt(rowIndex).get('size');
						var str = Ext.getCmp('goods_sn').getValue();
						if(thiz.childgoodsstore.getAt(rowIndex).get('child_sn') == str+'-'+id) return;
						var rowEditing = Ext.getCmp('chlidgoodpanel').editingPlugin; 
						var data = Ext.getCmp("chlidgoodpanel").getSelectionModel().getSelection(); 
						thiz.childgoodsstore.remove(data[0]);
						var p = Ext.create(this.model,{child_sn:str+'-'+id,size:size,color:id,price:price,stock:stock});
						thiz.childgoodsstore.insert(rowIndex, p);
						thiz.childgoodsGrid.plugins[0].startEditByPosition({row:rowIndex,column:1});
						}
					 }]
		  },{
						header : '子产品编码<font color=red>*</font>',
						dataIndex:'child_sn',
			 			width:250,
						align : 'left',
						editor:new Ext.form.TextField({
								allowBlank:true,
								hideLabel:true
						})
					}, {
						header:'颜色',
			 			width:250,
						dataIndex:'color',
						align:'left',
						renderer: this.rendererlist[1],
						editor:this.combolist[1]
						/*editor:new Ext.form.TextField({
								allowBlank:false,
								hideLabel:true
						})*/
					}, {
						header:'尺寸',
			 			width:250,
						dataIndex:'size',
						align:'left',
						renderer:  this.rendererlist[0],
						editor:this.combolist[0]
						/*editor:new Ext.form.TextField({
								allowBlank:false,
								hideLabel:true
						})*/
					}, {
						header:'价格<font color=red>*</font>',
			 			width:250,
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
					}];
	},
	creatChildGoodsgrid:function(){//创建子产品明细
		this.childgoodsGrid = Ext.create('Ext.grid.Panel', {
					frame:false,
					title:'子产品明细',
					id:'chlidgoodpanel',
					height : 300,
					autoWidth : true,
					columns : this.childcmlist,
					store : this.childgoodsstore,
					selModel:  Ext.create('Ext.selection.CheckboxModel',{
								listeners: {
									select:function(field,e){
										Ext.getCmp('childremoveBtn').setDisabled(false);
									}
								}}),
					plugins:[Ext.create('Ext.grid.plugin.CellEditing',{
						clicksToEdit: 1
					})],
					viewConfig : {
						stripeRows : true, // 让基数行和偶数行的颜色不一样
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
							handler:this.addChilditem.bind(this)
						},{
							xtype:'button',
							text: '删除',
							iconCls: 'x-tbar-del',
							id: 'childremoveBtn',
							handler: this.removeChildItem.bind(this),
							disabled:true
						}]
					})
				});
	},
	afterselect:function(k,v){
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
		var mk = new Ext.LoadMask(Ext.getBody(), {
			msg: '载入分类信息，请稍候！',
			removeMask: true //完成后移除
			});
		mk.show();
		Ext.Ajax.request({
			url: 'index.php?model=goods&action=getgoodscode',
			params: {cat_id:k},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
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
			params: {id:k,language_id:1},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				
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
								xtype:'textfield',
								width:250
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
								xtype:'textfield',
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
								 var radioitems = [];
								 for(var j = 0; j < res[i]['attribute_value'].length; j++){
									valueID = res[i]['attribute_value'][j]['value_id'];
									value = res[i]['attribute_value'][j]['value'];
									radioitems.push({ boxLabel: value, name:'rb_'+i , inputValue: valueID
									})
								}
								var radioGroup = {
								xtype: 'fieldset',
								frame:false,
								border:false,
								layout: 'form',
								width:650,
								items: [{
										xtype:'hidden',
										labelWidth: 80,
										width:110,
										value:res[i]['attribute_id'],
										name:'attrID_'+i,
										id:'attrID_'+i
								},{
									xtype: 'radiogroup',
									fieldLabel: label,
									cls: 'x-check-group-alt',
									name:'cat_attribute_'+i,
									id:'cat_attribute_'+i,
									columns: 3,
									vertical: true,
									items: radioitems
								}
								]}
								aobt.add(radioGroup);
								aobt.doLayout(true);
							 }
							 
						break;
						case '4':
							/**
							 * 复选框
							 */
							 if(res[i]['attribute_value'].length > 0){
								 var checkitems = [];
								 for(var j = 0; j < res[i]['attribute_value'].length; j++){
									valueID = res[i]['attribute_value'][j]['value_id'];
									value = res[i]['attribute_value'][j]['value'];
									checkitems.push({    
										boxLabel: value, name: valueID
									})
								}
								var checkGroup = {
									xtype: 'fieldset',
									frame:false,
									border:false,
									layout: 'anchor',
									width:650,
									defaults: {
										anchor: '100%'
									},
									items: [{
										xtype:'hidden',
										value:res[i]['attribute_id'],
										name:'attrID_'+i,
										labelWidth: 0,
										id:'attrID_'+i
									},{
										xtype: 'checkboxgroup',
										fieldLabel: label,
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
							 }
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
								store: Ext.create('Ext.data.ArrayStore',{
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
							   hideTrigger:true,
							   xtype:res[i]['entity_type_name'],
							   minValue:0
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
							   width:250,
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
								store: Ext.create('Ext.data.ArrayStore',{
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
			params: {cat_id:k},
			success:function(response,opts){
				Ext.getBody().unmask();
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
				mk.hide();					
			}
		});
	},
	creatTab:function(){
		var afterselect = this.afterselect;
		var num = 0;
		var tab = Ext.create('Ext.tab.Panel',{
			plain:false,
			activeTab: 0,
			defaults:{autoScroll: true,autoHeight:true},
			items:[{
			    id:'tab1',
                title: '基本信息',
				autoScroll:true,
                items:[{
					layout:'column',
					items:[{
						columnWidth:.99,
						frame:false,
						border:false,
						title: '基本信息',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							labelWidth: 80,
							margin: '10px',
							border:false,
							items:[{
								editable: false,
								fieldLabel:'所属分类',
								xtype:'triggerfield',
								id:'cat_name',name:'cat_name',
								width:380,
								onSelect: function(record){
								},
								onTriggerClick: function() {
									getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',0,afterselect);
								}
							},{
								xtype:'hidden',id:'cat_id',name:'cat_id'
							},{
								fieldLabel: '产品编码',id:'goods_sn',width:250,name:'goods_sn'
							},{
								fieldLabel: 'SKU',width:250,name:'SKU',id:'SKU'
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
								editable: false,
								forceSelection: true,
								triggerAction: 'all',
								hiddenName:'status',
								name: 'status',
							   fieldLabel: '产品状态',
							   value:1,
							   id:'status_id',
							   name:'status_id'
							},{fieldLabel: '产品标题',id:'goods_name',name:'goods_name',allowBlank:false,width:350},{
								fieldLabel: '产品链接',name:'goods_url',width:350
							},{
								fieldLabel: '保质期',
								width:250,
								name:'keeptime',
								format:'Y-m-d',
								value:'2037-12-31',
								xtype:'datefield'
							}]
						}]
					},{
						columnWidth:.99,
						frame:false,
						title:'属性信息',
						border:false,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							margin: '0px 10px 10px 10px',
							labelWidth: 120,
							autoScroll:true,
							border:false,
							items:[{
								xtype: 'fieldset',
								defaultType: 'textfield',
								id:'opattrset',
								layout:'column',
								width:350,
								autoScroll:true,
								border:false,
								items:[]
							},{
								xtype: 'fieldset',
								defaultType: 'textfield',
								id:'attributeset',
								labelWidth: 120,
								autoScroll:true,
								border:false,
								items:[{xtype:'panel',border:false,width:250,html:'<p style="color:red">请选择一个选择分类</p>'}]
							},{
								xtype: 'fieldset',
								defaultType: 'textfield',
								layout:'column',
								width:350,
								autoScroll:true,
								border:false,
								items:[{
									columnWidth:.33,
									xtype: 'button',
									text: '添加自定义属性',
									style:'margin:20px 0 10px 0;',
									handler:function(){
										var opatlen = Ext.getCmp('opattrset').items.length+1;
										var aobt = Ext.getCmp('opattrset');
										var addattr = 
										[{ 
											columnWidth:.45,
											style:'align:center;margin:10px 10px 0 0;',
											name:'opID_'+opatlen,
											id:'opID_'+opatlen,
											value:'属性名称(例如:颜色)',
											listeners:{
											   'focus':function(){
												 this.setValue('');
											   }
											}
										 },{
											columnWidth:.45,
											style:'align:center;margin:10px 10px 0 0',
											name:'opValue_'+opatlen,
											id:'opValue_'+opatlen,
											value:'属性值(例如黑色)',
											listeners:{
											   'focus':function(){
												   this.setValue('');
											   }
											}
										 }]
										aobt.add(addattr);
										aobt.doLayout(true);
									}
								},{
									xtype: 'button',
									columnWidth:.33,
									text: '重置属性',
									style:'margin:20px 0 10px 15px;',
									handler:this.resetattr.bind(this)
								}/*,{
									xtype: 'button',
									columnWidth:.33,
									text: '生成描述',
									style:'margin:20px 0 10px 15px;',
									handler:function(){
										var cid = Ext.getCmp('cat_id').getValue();
										if(cid){
											var labelvalue = '';
											var attvalue = '';
											var attarr = [];
											var form_length = Ext.getCmp('goodsForm').items.items.length;
											var filed = ''; //找到所有属性
											var idset = '';
											for(var i = 0 ; i < form_length ; i++){
												filed = 'cat_attribute_'+i;
												if(Ext.getCmp(filed)){
													attID_field = 'attrID_'+i;
													idset += (idset == '') ? Ext.getCmp(attID_field).getValue() : ','+Ext.getCmp(attID_field).getValue();
													if(Ext.getCmp(filed).getXType() == 'radiogroup' ){
														alert(Ext.getCmp(filed).getXType());
														var items = Ext.getCmp(filed).items;
														var array;
														if(items.length > 0){
															for(var i = 0; i< len; i++){
																var _item = items[i];
																if(_item.getValue()){
																	array = _item.getBoxLabel();
																	break;
																}
															}
														}
														attarr.push(array);
													}else if(Ext.getCmp(filed).getXType() == 'checkboxgroup'){
														alert(Ext.getCmp(filed).getXType());
														var items = Ext.getCmp(filed).items;
														var array=[];
														if(items.length > 0){
															for(var i = 0; i< len; i++){
																var _item = items[i];
																if(_item.getValue()){
																	array.push(_item.getBoxLabel());
																}
															}
														}
														attarr.push(array.join(','));
													}else if(Ext.getCmp(filed).getXType() == 'combo'){
														alert(Ext.getCmp(filed).getXType());
														attvalue = Ext.getCmp(filed).getValue();
														attarr.push(attvalue);
													}else if(Ext.getCmp(filed).getXType() == 'textfield'){
														alert(Ext.getCmp(filed).getXType());
														attvalue =Ext.getCmp(filed).getValue();
														attarr.push(attvalue);
													}else if(Ext.getCmp(filed).getXType() == 'datefield'){
														alert(Ext.getCmp(filed).getXType());
														attvalue = Ext.getCmp(filed).getValue();
														attarr.push(attvalue);
													}else if(Ext.getCmp(filed).getXType() == 'textarea'){
														alert(Ext.getCmp(filed).getXType());
														attvalue =Ext.getCmp(filed).getValue();
														attarr.push(attvalue);
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
													var opatlen = (Ext.getCmp('opattrset').items.length -1 );
													opatlen = opatlen/2;
													var llid = 1;
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
								}*/]
							}]
						}]
					}/*,{
						columnWidth:.99,
						layout: 'fit',
						frame:false,
						title: '描述模板',
						border:false,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							labelWidth: 80,
							margin: '0px 10px 10px 10px',
							border:false,
							items:[{
									xtype:'displayfield',
									fieldLabel:'详细描述'
								},
								Ext.create('Ext.ux.form.FCKeditor',{
									name : "des_cn", 
									width:'90%',
									height:430, 
									id : "des_cn"
								})
							]}
						]
					}*/,{
						columnWidth:.99,
						title: '物流属性',
						border:false,
						frame:false,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							labelWidth: 80,
							border:false,
							margin: '0px 10px 10px 10px',
							items:[{
								fieldLabel: '净重',
								xtype:'numberfield',
								hideTrigger:true,
								width:220,
								id:'grossweight',name:'grossweight',xtype: 'textfield'
							},{
								fieldLabel: '重量',
								xtype:'numberfield',
								width:220,
								id:'weight',
								hideTrigger:true,
								value:0,
								allowBlank:false,name:'weight'
							},{
								fieldLabel: '长',
								name:'l', 
								xtype:'numberfield',
								hideTrigger:true,
								width:220,
								id:'l',name:'l'
							},{
								fieldLabel: '宽',
								xtype:'numberfield',
								hideTrigger:true,
								width:220,
								name:'w', 
								id:'w',name:'w'
							},{
								fieldLabel:'高',
								xtype:'numberfield',
								hideTrigger:true,
								width:220,
								name:'h', 
								id:'h',name:'h'
							},{
							   fieldLabel: '申报重量kg',width:220,
							   id:'Declared_weight',
							   xtype:'numberfield',
							   hideTrigger:true,
							   minValue:0,name:'Declared_weight'
							},{
							   fieldLabel: '申报价值',width:220,
							   id:'Declared_value',
							   xtype:'numberfield',
							   hideTrigger:true,
							   minValue:0,name:'Declared_value'
							},{
							   fieldLabel: '报关名英文',width:220,
							   id:'dec_name',name:'dec_name',xtype: 'textfield'
							},{
							   fieldLabel: '报关名中文',width:220,
							   id:'dec_name_cn',name:'dec_name_cn',xtype: 'textfield'
							}]
						}]
					},{
						columnWidth:.99,
						border:false,
						title: '图片信息',
						layout: 'hbox',
						width:800,
						id:'imgform',
						frame:false,
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							labelWidth: 80,
							id:'imgitem',
							style:'padding:10px',
							width:480,
							border:false,
							items:[{
							   xtype: 'fileuploadfield',
							   fieldLabel: '产品主图片',
							   name:'photo_path',
							   id:'new_img',
							   labelWidth:100,
							   width:350
							}]
						}]
					},{
						columnWidth:.99,
						frame:false,
						border:false,
						title: '其他信息',
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							margin: '0px 0px 10px 10px',
							defaultType: 'textfield',
							labelWidth: 80,
							border:false,
							items:[{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								id:'product_purchaser',
								triggerAction: 'all',
								hiddenName:'product_purchaser',
								emptyText:'请选择',
								name: 'product_purchaser',
								fieldLabel: '采购员'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								id:'products_developers',
								triggerAction: 'all',
								hiddenName:'products_developers',
								name: 'products_developers',
								emptyText:'请选择',
								fieldLabel: '产品开发员'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								id:'product_operation',
								triggerAction: 'all',
								hiddenName:'product_operation',
								name: 'product_operation',
								emptyText:'请选择',
								fieldLabel: '产品运营员'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								id:'product_quality_inspector',
								triggerAction: 'all',
								hiddenName:'product_quality_inspector',
								name: 'product_quality_inspector',
								emptyText:'请选择',
								fieldLabel: '产品质检员'
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: account
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								width:300,
								editable: false,
								forceSelection: true,
								id:'product_rights_checker',
								triggerAction: 'all',
								hiddenName:'product_rights_checker',
								name: 'product_rights_checker',
								emptyText:'请选择',
								fieldLabel: '产品侵权审核员'
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
							   change:function(){
								  Ext.getCmp('childaddBtn').setDisabled(!this.checked);
								}
							   }
							 },{
									fieldLabel: 'UPC',width:250,
									id:'upc',name:'upc'
							},{
									fieldLabel: '产品备注',
									id:'comment',
									width:500,
									height:60,
									xtype:'textarea',name:'comment'

							}]
						}]
					},
                    {
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '美国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[
                            {
                                
                            fieldLabel: '美国销售价格',
                            width: 220,
                            id: 'price_us',
                            name : 'price_us'
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_en',
                            id:'des_en',
                            autoScroll:true,
                            width:900,
                            height:300,
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
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
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
                            })]
                    }]},
                    {
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '德国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[ 
                            {   
                            fieldLabel: '德国销售价格',
                            width: 220,
                            id: 'price_de',
                            name : 'price_de'
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_de',
                            id:'des_de',
                            autoScroll:true,
                            width:900,
                            height:300,
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
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
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
                            })]
                    }]},
                    {
                        columnWidth:.99,
                        frame:false,
                        border:false,
                        height:600,
                        title: '法国刊登',
                        defaultType: 'textfield',
                        items:[{
                            xtype: 'fieldset',
                            margin: '0px 0px 10px 10px',
                            defaultType: 'textfield',
                            labelWidth: 80,
                            border:false,
                            items:[
                        {   
                            fieldLabel: '法国销售价格',
                            width: 220,
                            id: 'price_fr',
                            name : 'price_fr'
                        },Ext.create('Ext.ux.form.field.CKEditor',{
                            name:'des_fr',
                            id:'des_fr',
                            autoScroll:true,
                            width:900,
                            height:300,
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
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)$/ } } ]
                            },
                            colorButton_backStyle:{
                                element : 'span',
                                attributes : {'class':'#(color)BG'},
                                overrides    : [ { element : 'span',attributes:{'class':/^FontColor(?:1|2|3)BG$/ } } ]
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
                            })]
                    }]}
                    
                    ]
				}]
            },{
				id:'tab2',
                title: '产品价格',
				autoScroll:true,
                defaultType: 'textfield',
                items: [{
					margin: '10px 0px 0px 0px',
                    fieldLabel: '成本价',
					width:250,
                    name: 'cost',
					value:0,
					hideTrigger:true,
					xtype:'numberfield'
                },{
                    fieldLabel: '价格1',
					width:250,
                    name: 'price1',
					hideTrigger:true,
					xtype:'numberfield'
                },{
                    fieldLabel: '价格2',
					width:250,
                    name: 'price2',
					hideTrigger:true,
					xtype:'numberfield'
                },{
                    fieldLabel: '价格3',
					width:250,
                    name: 'price3',
					hideTrigger:true,
					xtype:'numberfield'
                }]
            }]
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
	resetattr:function(){
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
		aobt.add([{xtype:'panel',border:false,width:250,html:'<p style="color:red">请选择一个选择分类</p>'}]);
		opaobt.doLayout(true);
	},

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.bind(this)
			},{
					text: '取消',
					handler:this.formreset.bind(this)
			}];		
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
			//var att = '';
			//var form_length = this.getForm().items.length;
			/*var filed = ''; //找到所有属性
			for(var i = 0 ; i < form_length ; i++){
				filed = 'cat_attribute_'+i; 
				if(this.getForm().findField(filed)){
					alert(this.getForm().findField(filed).getXType())
					alert(this.getForm().findField(filed).getValue())
				}
			}*/
			var jsonArray = [];
			var m = this.childgoodsstore.getModifiedRecords().slice(0);
			Ext.each(m,function(item){
				jsonArray.push(item.data);
			});
				this.getForm().submit({
					url:'index.php?model=goods&action=save',
					waitMsg: '正在更新产品资料',
					params:{'childdata':Ext.encode(jsonArray),'data':''},
					method:'post',
					success:function(form,action){
						//alert(action.result.msg);return;
						if (action.result.success) {
							Ext.MessageBox.show({
								title: '请选择去向',
								msg: '添加产品成功!请选择?',
								buttons: Ext.MessageBox.YESNO,
								buttonText:{ 
									yes: "继续添加", 
									no: "查看产品" 
								},
								fn: function(btn){
									if(btn == 'yes'){
										window.location="javascript:location.reload()";
									}else{
										//parent.window.newTab(action.result.msg,'产品管理','index.php?model=goods');
										window.location.href = 'index.php?model=goods';
									}
								}
							});
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
		var s = this.childgoodsGrid.getSelectionModel().getSelection()[0];
		if(s){
			this.childgoodsstore.remove(s);
		}
		
	},
	addChilditem: function() {
		var p = Ext.create(this.model,{child_sn:'',size:'',color:'',price:0,stock:0});
		this.childgoodsstore.insert(0, p);
		this.childgoodsGrid.plugins[0].startEditByPosition({row:0,column:0});
	}
});

