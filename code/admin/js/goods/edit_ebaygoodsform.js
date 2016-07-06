Ext.define('Ext.ux.editgoodsForm',{
	extend:'Ext.form.Panel',
    initComponent: function() {
        this.frame = true,
        this.fileUpload = true,
        this.autoHeight = true,
        this.buttonAlign = 'center',
        this.creatItems();
        
        this.callParent();
    },
    afterselect: function(k, v) {
        Ext.getCmp('cat_name').setValue(v);
        modifymodel(Ext.getCmp('goods_id').getValue(), 'cat_id', k, 'goods');
    },

    creatItems: function() {
        var num = 0;
		var me = this;
		this.items = [{
					layout:'column',
					buttonAlign:'center',
					style:'padding:5px;',
					items:[{
						columnWidth:.99,
						padding: '5px',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							padding: '10px',
							items:[{
								xtype:'button',
								text:'保存',
								style:'margin-bottom:15px;',
								handler:function(){me.formsubmit(me)}
							},{
								xtype:'hidden',
								name:'id',
								value:me.good.id
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
									labelWidth: 65,
									editable: false,
									forceSelection: true,
									triggerAction: 'all',
									hiddenName:'ebay_account',
								    fieldLabel: '帐号',
								    value:me.good.ebay_account,
								    id:'ebay_account',
								    name:'ebay_account'
								},{   
								xtype: 'fieldcontainer',   
								fieldLabel: '货号',labelWidth: 65,   
								layout: {
									type: 'hbox',   
									align: 'middle'
								},   
								combineErrors : true,
								defaultType: 'textfield',
								items: [
									{
										hideLabel:true,
										id:'SKU',
										name:'SKU',
										width:180,
										labelWidth: 65,
										value:me.good.SKU
									},
									{
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: this.goods_data[3]
										}),
										style:'margin-left:45px;',
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										labelWidth: 45,
										width:240,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'ConditionID',
									    fieldLabel: '条件',
									    id:'ConditionID',
									    name:'ConditionID',
										value:me.good.ConditionID
									}
								]},{
										fieldLabel : '标题',id:'Title',name:'Title',width:550,
							labelWidth: 65,
										value:me.good.Title
									}	,{   
										xtype: 'fieldcontainer',
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
										width:250,
										labelWidth: 65,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'CategoryID',
									   fieldLabel: 'eBay分类',
									   value:me.good.CategoryID,
									   id:'CategoryID',
									   name:'CategoryID'
									}
										]   
									},{   
										xtype: 'fieldcontainer',
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
										width:250,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										labelWidth: 65,
										hiddenName:'StoreCategoryID',
									   fieldLabel: '店铺分类',
									   value:me.good.StoreCategoryID,
									   id:'StoreCategoryID',
									   name:'StoreCategoryID'
									}
								]   
							}]
						}]
					},{
						columnWidth:.99,
						padding: '5px',
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							defaultType: 'textfield',
							padding: '10px',
							items:[{   
								xtype: 'fieldcontainer',
								layout: {
									type: 'hbox',   
									align: 'middle'
								},
								combineErrors : true,
								defaultType: 'textfield',
								items: [{
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: this.goods_data[2]
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										width:220,
										editable: false,labelWidth: 65,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'ListingType',
									    fieldLabel: '拍卖类型',
									    id:'ListingType',
									    name:'ListingType',
									   value:me.good.ListingType,
									},{   
									xtype : 'numberfield',
									id : 'StartPrice',
									name:'StartPrice',
									width:150,
									labelWidth: 45,
									fieldLabel: '起步价',
									style:'margin-left:40px;',
									maxValue: 99999,
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:2,
									value:me.good.StartPrice,
								},{
									xtype:'button',
									text:'<b>-</b>',
									style:'margin-left:10px;text-align:center;',
									width:30,
									handler:function(){me.addprice('-')}
								},{
									xtype:'button',
									text:'<b>+</b>',
									style:'margin-left:10px;text-align:center;',
									width:30,
									handler:function(){me.addprice('+')}
								},{   
									name:'Quantity',   
									id:'Quantity',
									fieldLabel: '数量',
									xtype : 'numberfield',   
									maxValue: 100,
									width:140,
									labelWidth: 45,
									value:me.good.Quantity,
									style:'margin-left:55px;'
								}
								]   
            				},{   
								xtype: 'fieldcontainer',
								layout: {
									type: 'hbox',   
									align: 'middle'
								},
								combineErrors : true,
								defaultType: 'textfield',
								items: [{   
									xtype : 'numberfield',
									id : 'BuyItNowPrice',
									name:'BuyItNowPrice',
									width:180,labelWidth: 65,
									fieldLabel: '一口价',
									maxValue: 99999,
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:2,
									value:me.good.BuyItNowPrice,
								},{   
									xtype : 'numberfield',
									id : 'ReservePrice',
									name:'ReservePrice',
									width:180,labelWidth: 65,
									fieldLabel: '保底价',
									style:'margin-left:40px;',
									maxValue: 99999,
									allowDecimals:true,
									allowNegative:false,
									decimalPrecision:2,
									value:me.good.ReservePrice,
								}
								]   
            				}]
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
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: []
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										width:220,labelWidth: 65,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'ebay_listingshippingmethodid',
									    fieldLabel: '运费模板',
									    id:'ebay_listingshippingmethodid',
									value:me.good.ebay_listingshippingmethodid,
									    name:'ebay_listingshippingmethodid'
									},{
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: []
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										width:220,labelWidth: 65,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
									value:me.good.ebay_listingreturnmethodid,
										hiddenName:'ebay_listingreturnmethodid',
									    fieldLabel: '退换政策',
									    id:'ebay_listingreturnmethodid',
									    name:'ebay_listingreturnmethodid'
									},{
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: this.goods_data[0]
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										width:220,labelWidth: 65,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'DispatchTimeMax',
									    fieldLabel: '处理天数',
									    id:'DispatchTimeMax',
										value:me.good.DispatchTimeMax,
									    name:'DispatchTimeMax'
									},{
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: this.goods_data[1]
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										width:220,labelWidth: 65,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'ListingDuration',
										name: 'ListingDuration',
									    fieldLabel: '在线天数',
									    id:'ListingDuration',
										value:me.good.ListingDuration,
									    name:'ListingDuration'
									}]
						}]
					},{
						columnWidth:.99,
						layout: 'hbox',
						padding: '5px',
						id:'imgform',
						defaultType: 'textfield',
						items:[{
							xtype: 'fieldset',
							padding: '10px',
							defaultType: 'textfield',
							labelWidth: 65,
							autoHeight:true,
							width:700,
							id:'imgitem',
							style:'padding:10px',
							items:[{   
								xtype : 'displayfield',   
								value : '<b>产品图片</b>'
							}
							,{
								   xtype: 'fileuploadfield',
								   fieldLabel: '图片',
								   name:'ViewItemURL',
								   id:'ViewItemURL',
								   style:'margin:15px 0',
								   labelWidth: 65,
								   width:350,
								},{
								   xtype: 'fileuploadfield',
								   fieldLabel: '图片1',
								   name:'PictureURL01',
								   id:'PictureURL01',
								   style:'margin:10px 0',
								   labelWidth: 65,
								   width:350,
								},{
								   xtype: 'fileuploadfield',
								   fieldLabel: '图片2',
								   name:'PictureURL02',
								   style:'margin-bottom:10px',
								   id:'PictureURL02',
								   labelWidth: 65,
								   width:350,
								},{
								   xtype: 'fileuploadfield',
								   fieldLabel: '图片3',
								   name:'PictureURL03',
								   id:'PictureURL03',
								   style:'margin-bottom:10px',
								   labelWidth: 65,
								   width:350,
								},{
								   xtype: 'fileuploadfield',
								   fieldLabel: '图片4',
								   name:'PictureURL04',
								   id:'PictureURL04',
								   labelWidth: 65,
								   style:'margin-bottom:10px',
								   width:350,
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
								value : '<b>产品描述</b>'
							}
							,Ext.create('Ext.ux.form.field.CKEditor',{
								id:'Description',
								name:'Description',
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
							})]
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
		Ext.onReady(function(){Ext.getCmp('Description').setValue(me.good.Description);});
			
		
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
			
				this.getForm().submit({
					url:'index.php?model=goods&action=saveebay',
					waitMsg: '正在更新产品资料',
					//params:{'Description':Ext.getCmp('Description').getValue()},
					method:'post',
					success:function(form,action){
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
										/*parent.window.newTab(action.result.msg,'产品管理','index.php?model=goods');*/
										window.location.href = 'index.php?model=goods&action=edit&goods_id='+action.result.msg;
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