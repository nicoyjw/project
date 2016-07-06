Ext.define('Ext.chooser.Window', {
    extend: 'Ext.window.Window',
    height: 450,
    width : 950,
    title : '图片银行',
    layout: 'border',
	closeAction : 'destory',
    border: false,
    bodyBorder: false,
    initComponent: function() {
		var account = this.account;
		var tree = Ext.create('Ext.tree.Panel', {
            border: true,
            store: account,
            region: 'west',
            id: 'west-panel',
            width: 200,
            minSize: 175,
            maxSize: 400,
            margins: '0 0 0 0',
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true
        });
        tree.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e) {
			 Ext.getCmp('img-chooser-view').getStore().load({
				params: {
					group: node.data.id
				}
			})
        };
        this.items = [
            {
                xtype: 'panel',
                region: 'center',
                layout: 'fit',
                items: {
                    xtype: 'iconbrowser',
                    autoScroll: true,
                    id: 'img-chooser-view',
                    listeners: {
                        scope: this,
                        selectionchange: this.onIconSelect,
                        itemdblclick: this.fireImageSelected
                    }
                },
                
                tbar: [
                    {
                        xtype: 'textfield',
                        name : 'filter',
                        fieldLabel: '搜索',
                        labelWidth: 35,
						width:145,
                        listeners: {
                            scope : this,
                            buffer: 50,
                            change: this.filter
                        }
                    },
                    {
                        xtype: 'combo',
                        fieldLabel: '排序',
                        labelWidth:35,
						width:145,
                        valueField: 'field',
                        displayField: 'label',
                        value: 'Type',
                        editable: false,
                        store: Ext.create('Ext.data.Store', {
                            fields: ['field', 'label'],
                            sorters: 'type',
                            proxy : {
                                type: 'memory',
                                data  : [{label: 'Name', field: 'name'}, {label: 'Type', field: 'type'}]
                            }
                        }),
                        listeners: {
                            scope : this,
                            select: this.sort
                        }
                    },
					Ext.create('Ext.form.Panel',{
					id:'imgform',
					items:[
						{   
						xtype: 'fieldcontainer',
						layout: {
							type: 'hbox',   
							align: 'middle'
						},   
						combineErrors : true,
						style:'margin:0 0 0 15px',
						defaultType: 'textfield',
						items: [
						{
						   xtype: 'fileuploadfield',
						   hideLabel: true,
							name:'photo_path',
							id:'photo_path',
						   buttonText : '选择文件',
						   width:140,
							   
						},{
							xtype:'button',
							text:'上传',
							style:'margin-left:15px',
							handler:function(){
								var form = this.up("form").getForm();
								//alert(form);return;
								if (form.isValid()) {
									form.submit({
										url: "index.php?model=aliexpress&action=UploadImageBank",
										waitMsg: "Uploading your Image...",
										params:{'id':Ext.getCmp('account_id').getValue()},
										method:'post',
										success: function (form,action) {
											if (action.result.success) {
												Ext.example.msg('MSG',action.result.msg);
												Ext.getCmp('img-chooser-view').getStore().load({
													params: {}
												})
											} else {
												Ext.Msg.alert('ERROR',action.result.msg);
											}
										},
										failure:function(form,action){
												Ext.Msg.alert('ERROR',action.result.msg);
										}
									});
								}
							}
						}
						]}]
					})
				]
            },
            {
                xtype: 'infopanel',
                region: 'east',
                split: true
            },tree
        ];
        
        this.buttons = [
            {
                text: 'OK',
                scope: this,
                handler: this.fireImageSelected
            },
            {
                text: 'Cancel',
                scope: this,
                handler: function() {
                    this.hide();
                }
            }
        ];
        
        this.callParent(arguments);
        this.addEvents(
            'selected'
        );
    },
    filter: function(field, newValue) {
        var store = this.down('iconbrowser').store,
            view = this.down('dataview'),
            selModel = view.getSelectionModel(),
            selection = selModel.getSelection()[0];
        
        store.suspendEvents();
        store.clearFilter();
        store.filter({
            property: 'name',
            anyMatch: true,
            value   : newValue
        });
        store.resumeEvents();
        if (selection && store.indexOf(selection) === -1) {
            selModel.clearSelections();
            this.down('infopanel').clear();
        }
        view.refresh();
        
    },
    sort: function() {
        var field = this.down('combobox').getValue();
        
        this.down('dataview').store.sort(field);
    },
    onIconSelect: function(dataview, selections) {
        var selected = selections[0];
        
        if (selected) {
            this.down('infopanel').loadRecord(selected);
        }
    },
    fireImageSelected: function() {
        var selectedImage = this.down('iconbrowser').selModel.getSelection()[0];
        
        if (selectedImage) {
            this.fireEvent('selected', selectedImage);
            this.hide();
        }
    }
});
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
		var aobt = Ext.getCmp('attributeset');
		var atlen = Ext.getCmp('attributeset').items.length;
		for(var i = 0;i<atlen;i++){
			var x=aobt.items.get(0);
			 var array=Ext.query("*[for='"+x.id+"']");
			 Ext.removeNode(array[0]);
			 aobt.remove(x,true);
		}
		Ext.getCmp('attrdisplay').setValue('');
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
						[{
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
							items: [{
								xtype:'hidden',
								id:'attr_keyid_'+i,
								name:'attr_keyid_'+i,
								value:res[i]['id'],
							},{
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
						items: [{
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
						[{
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
						[{
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
						[{
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
		var treestore;
		var win = this.win;
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
								xtype:'button',
								text:'保存并发布到Aliexpress',
								style:'margin-bottom:15px;margin-left:25px;',
								hidden: me.status==0 ? false : true,
								handler:function(){me.formsubmit(me)}
							},{
							xtype: 'fieldset',
							defaultType: 'textfield',
							padding: '10px',
							items:[{   
								xtype : 'displayfield',   
								value : '<b>产品基本信息</b>'
								},{xtype:'hidden',name:'cat_id',id:'cat_id',value:me.good.categoryId},{xtype:'hidden',name:'id',id:'id',value:me.good.id},{xtype:'hidden',name:'attrlength',id:'attrlength',value:0},{
								editable: false,
								fieldLabel:'<b style="color:red">*</b> 分类',
								xtype:'triggerfield',
								style:'margin-bottom:55px;',
								id:'cat_name',
								name:'cat_name',
								width:480,
								labelWidth: 85,
								onSelect: function(record){
								},
								onTriggerClick: function() {
									 Ext.Msg.confirm('提示!', '原分类属性将会丢失，要继续吗?',
										function(btn) {
											if (btn == 'yes') {
												getCategoryFormTree('index.php?model=aliexpress&action=getAliCate&com=0',0,afterselect);
											}
										},
										this)
									
								},
								value:me.good.cat_name
							},/*{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b>&nbsp;&nbsp;</b>属性信息',
								style:'margin-bottom:15px;',
								labelWidth: 85,
								width:850,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [{   
											xtype : 'displayfield',
											id:'attrdisplay',
											value : me.good.attrString,
											width:800,  
											style:'margin-left:5px;'
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
										}
								]
								
								},{
								xtype:'button',
								text:'修改属性',
								style:'margin-left:95px;margin-bottom:45px;',
								handler:function(){
									var id = Ext.getCmp('keyword').getValue();
									openWindow(me.good.id,'属性编辑','index.php?model=aliexpress&action=Edit_Ali_Attributes&id='+me.good.id,770,550,0);
									}
							},*/{
									xtype:'combo',
									store: Ext.create('Ext.data.ArrayStore',{
										 fields: ["id", "key_type"],
										 data: this.goods_data[4]
									}),
									valueField :"id",
									displayField: "key_type",
									mode: 'local',
									width:320,
									labelWidth: 85,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'account_id',
									style:'margin-bottom:55px;',
								    fieldLabel: '<b style="color:red">*</b> 帐号',
								    value:me.good.account_id,
								    id:'account_id',
								    name:'account_id'
								},{   
								    xtype: 'fieldcontainer',   
								    fieldLabel: '<b style="color:red">*</b> 关键字',
								    style:'margin-bottom:55px;',
								    labelWidth: 85,
								    width:650,  
								    layout: {
									    type: 'hbox',   
									    align: 'middle'
								    },   
								combineErrors : true,
								defaultType: 'textfield',
								items: [{
											hideLabel :true,id:'keyword',name:'keyword',width:250,labelWidth: 85,value:me.good.keyword
										},{
											xtype:'button',
											text:'关键字推荐分类',
											style:'margin-left:25px',
											handler:function(){
												var keyword = Ext.getCmp('keyword').getValue();
												openWindow(me.good.account_id,'获取推荐分类','index.php?model=aliexpress&action=getCatByKyeword&keyword='+keyword+'&account_id='+me.good.account_id,550,250,1);
												}
										}
								]
								
								},{
									fieldLabel : '<b style="color:red">*</b> 标题',id:'goods_name',name:'goods_name',width:750,
									style:'margin-bottom:55px;',labelWidth: 85,value:me.good.goods_name
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
									style:'margin-bottom:55px;',
									labelWidth: 85,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'productUnit',
									fieldLabel: '<b style="color:red">*</b> 单位',
									id:'productUnit',
									name:'productUnit',
									value:me.good.productUnit,
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
									style:'margin-bottom:55px;',
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
									inputValue : 1,
									checked : me.good.packageType == 0 ? true : false,
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
									checked : me.good.packageType>0 ? true : false,
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
								{fieldLabel: '每包数量',style:'margin-left:25px;',labelWidth:65,id:'lotNum',name:'lotNum',width:150,hidden:me.good.packageType==0 ? true : false,value:me.good.lotNum}
						]},
								{   
									xtype:'numberfield',
									id : 'productPrice',
									name:'productPrice',
									width:180,
									labelWidth: 85,
									fieldLabel: '<b style="color:red">*</b> 零售价',
									hideTrigger:true,
									style:'margin-bottom:55px;',
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:2,
									value:me.good.productPrice
								},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b>&nbsp;&nbsp;</b>批发价',
								labelWidth: 85,
								style:'margin-bottom:55px;',
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
											checked:me.good.bulkOrder > 0 ? true : false,
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
											hidden:me.good.bulkOrder==0? true : false,
											style:'margin-left:15px;'
										},{   
											name:'bulkOrder',   
											id:'bulkOrder',
											hideLabel:true,
											hideTrigger:true,
											xtype : 'numberfield',   
											width:45,
											hidden:me.good.bulkOrder==0? true : false,
											style:'margin-left:5px;',
											value:me.good.bulkOrder
										},{   
											xtype : 'displayfield',   
											value : '包时，每包价格在零售价的基础上减免',
											hidden:me.good.bulkOrder==0? true : false,
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
											hidden:me.good.bulkOrder==0? true : false,
											style:'margin-left:5px;',
											listeners : {
												"blur" : function(el) {
													var va = 100-el.getValue();
													Ext.getCmp('bulk_3').setValue((va/10)+' 折');
												}
											},
											value:me.good.bulkDiscount
										},{   
											xtype : 'displayfield',
											id:'bulk_4',
											hidden:me.good.bulkOrder==0? true : false,
											value:'%,即',
											style:'margin-left:5px;'
										},{   
											xtype : 'displayfield',
											id:'bulk_3',
											hidden:me.good.bulkOrder==0? true : false,
											value:'0 折',
											style:'margin-left:5px;',
											listeners : {
												"load" : function(el) {
													var va = 100-el.getValue();
													Ext.getCmp('bulk_3').setValue((va/10)+' 折');
												}
											},
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
									style:'margin-bottom:55px;',
									fieldLabel: '<b style="color:red">*</b> 发货期',
									value:me.good.deliveryTime
								}/*,{   
								xtype : 'displayfield',   
								value : '<b style="color:red">*</b> 产品图片'
								},{   
								xtype : 'fieldset',
								id:'moreImg',
								padding:15,
								width:850,
								border:true,
								items:[
									me.bbtn,{xtype:'hidden',id:'changeImg',value:0},{
									xtype:'panel',
									style:'margin-left:5px;',
									html:'<div id="images"style="width:800px;height:150px;"><div class="thumb-wrap"><div class="thumb"><img id="img_0"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(0);document.getElementById(\'btnbank\').click()">替换</a></span></div></div><div class="thumb-wrap"><div class="thumb"><img id="img_1"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="alert(Ext.getCmp(\'btnbank\'))">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(1);document.getElementById(\'btnbank\').click()">替换</a></span></div></div><div class="thumb-wrap"><div class="thumb"><img id="img_2"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(2);document.getElementById(\'btnbank\').click()">替换</a></span></div></div><div class="thumb-wrap"><div class="thumb"><img id="img_3"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(3);document.getElementById(\'btnbank\').click()">替换</a></span></div></div><div class="thumb-wrap"><div class="thumb"><img id="img_4"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(4);document.getElementById(\'btnbank\').click()">替换</a></span></div></div><div class="thumb-wrap"><div class="thumb"><img id="img_5"height="100px"width="100px"src="data/upload/no_picture.gif"/><span style="line-height:25px"><a href="javascript:void(0)"onclick="">删除</a>&nbsp;&nbsp;<a href="javascript:void(0)"onclick="Ext.getCmp(\'changeImg\').setValue(5);document.getElementById(\'btnbank\').click()">替换</a></span></div></div></div>'
									}
								]
							}*/,
								{fieldLabel: '<b>&nbsp;&nbsp;</b>商品编码',id:'skuCode',name:'skuCode',
									style:'margin-bottom:55px;',width:250,labelWidth: 85},
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
								style:'margin-bottom:55px;',
								allowDecimals:true,
								allowNegative:false,
							 	  	hideTrigger:true,
								decimalPrecision:2,
								id:'grossWeight',
								name:'grossWeight',
								value:me.good.grossWeight
							},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b style="color:red">*</b> 产品包装后的尺寸(CM)', 
								style:'margin-bottom:55px;',  
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
									width:60,
									value:me.good.packageLength
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
									style:'margin-left:10px;',
									value:me.good.packageWidth
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
									style:'margin-left:10px;',
									value:me.good.packageHeight
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
									style:'margin-bottom:55px;',
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
									checked : me.good.wsValidNum==14 ? true : false
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
									inputValue : 30,
									checked : me.good.wsValidNum==30 ? true : false
								},{   
									xtype : 'displayfield',   
									value : '30天',
									style:'margin-left:5px;',
								}
						]},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b style="color:red">*</b> 运费模板',
								labelWidth: 85,
									style:'margin-bottom:55px;',
								width:650,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
								{
									xtype:'combo',
									store: Ext.create('Ext.data.ArrayStore',{
										 fields: ["id", "key_type"],
										 data: []
								}),
									valueField :"id",
									displayField: "key_type",
									mode: 'local',
									width:200,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'freightTemplateId',
									hideLabel:true,
									id:'freightTemplateId',
									name:'freightTemplateId'
								},{   
									xtype : 'displayfield',   
									value : '<a href="javascript:void(0)">重新同步模版</a>',
									style:'margin-left:15px;',
								}
						]},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '<b>&nbsp;&nbsp;</b>产品组',
								labelWidth: 85,
									style:'margin-bottom:55px;',
								width:650,  
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
								{
									xtype:'combo',
									store: Ext.create('Ext.data.ArrayStore',{
										 fields: ["id", "key_type"],
										 data: []
									}),
									valueField :"id",
									displayField: "key_type",
									mode: 'local',
									width:200,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'groupId',
									hideLabel:true,
									id:'groupId',
									name:'groupId'
								},{   
									xtype : 'displayfield',   
									value : '<a href="javascript:void(0)">重新同步产品组</a>',
									style:'margin-left:15px;',
								}
						]}
							
							]
						}]
					}],
					buttons:[{
						text: '保存',
						type: 'submit', 
						handler:me.formsubmit.bind(me)
					},{
								xtype:'button',
								text:'保存并发布到Aliexpress',
								style:'margin-bottom:15px;margin-left:25px;',
								hidden: me.status==0 ? false : true,
								handler:function(){me.formsubmit(me)}
							},{
						text: '取消',
						handler:me.formreset.bind(me)
					}]
				}];
		Ext.onReady(function(){
			/*var imgs = me.good.imageURLs.split(";"); 
			for(var i=0;i<imgs.length;i++){
				document.getElementById("img_"+i).src = imgs[i]; 
				Ext.fly('images').createChild({
					tag: 'img',
					height:100,
					width:100,
					style:'border:1px solid #ccc',
					src: imgs[i],
					id:'img_'+i
				});
				
			}*/
			var va = 100-Ext.getCmp('bulkDiscount').getValue();
			Ext.getCmp('bulk_3').setValue((va/10)+' 折');
		 	Ext.getCmp('detail').setValue(me.good.detail);	
	});
	},

	formsubmit:function(){
		//alert(Ext.getCmp('detail').getValue());return;
		if(this.getForm().isValid()){
			/*var jsonArray = [];
			var len = Ext.getCmp('attrlength').getValue();
			//alert(len);return;
			var imgstr = '';
			for(var i=0;i<6;i++){
				if(document.getElementById("img_"+i).src !== 'data/upload/no_picture.gif'){
					imgstr += (i==0) ? document.getElementById("img_"+i).src : ';'+document.getElementById("img_"+i).src;
				}
			}
			//alert(imgstr);return;
			for(var i = 0 ; i < len; i++){
				filed = 'cat_attribute_'+i;
				labelfieldd = 'attr_keyid_'+i;
				if(Ext.getCmp(filed).getXType() == 'combobox'){
					if(Ext.getCmp(filed).getValue() !== null){
						var attr = {"attrValueId":Ext.getCmp(filed).getValue(),"attrNameId":Ext.getCmp(labelfieldd).getValue()};
						jsonArray.push(attr);
					}
				}
				if(Ext.getCmp(filed).getXType() == 'checkboxgroup'){
					var items = Ext.getCmp(filed).items;
					var array=[];
					var hobbyValue = Ext.getCmp(filed).getChecked();
					Ext.Array.each(hobbyValue, function(item){
						var attr = {"attrValueId":item.name,"attrNameId":Ext.getCmp(labelfieldd).getValue()};
						jsonArray.push(attr);
					})
				}
				if(Ext.getCmp(filed).getXType() == 'textfield' || Ext.getCmp(filed).getXType() == 'numberfield' ||  Ext.getCmp(filed).getXType() == 'textarea'){
					if(Ext.getCmp(filed).getValue()  !== null){
						var attr = {"attrValue":Ext.getCmp(filed).getValue(),"attrNameId":Ext.getCmp(labelfieldd).getValue()};
						jsonArray.push(attr);
					}
				}
			}*/
			//alert(Ext.encode(jsonArray));return;
				this.getForm().submit({
					url:'index.php?model=goods&action=saveAligoods',
					waitMsg: '正在更新产品资料',
					params:'',
					method:'post',
					success:function(form,action){
						if (action.result.success) {
							Ext.Msg.alert('提示','更新产品成功');
							window.location="javascript:location.reload()";
						} else {
							Ext.Msg.alert('更新产品失败',action.result.msg);
						}
					},
					failure:function(form,action){
							Ext.Msg.alert('更新产品失败',action.result.msg);
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
	},
	keywordgetCat:function(word){
		var me = this;
		Ext.Ajax.request({ /*显示属性值*/
			url: 'index.php?model=aliexpress&action=getCatByKyeword',
			params: {keyword:word,account_id:me.good.account_id},
			method:'post',
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				if(res.success){
					return res.cat_id;
				}else{
					Ext.Msg.alert('ERROR','未找到匹配的分类，请检查关键字');
				}
			}
		})
	}
});

