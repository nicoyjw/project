<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript" src="js/goods/goodsform.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var freighttemplate = new Ext.data.SimpleStore({fields: ['value', 'text'], data: [<!--{$freightTemplate}-->] });
	var goodsunit = new Ext.data.SimpleStore({fields: ['value1', 'text1'],data:[<!--{$goodsunit}-->]});	
	var deliveryTime = new Ext.data.SimpleStore({fields: ['value2', 'text2'],data:[<!--{$deliveryTime}-->]});	
	var form = new Ext.form.FieldSet({
		buttonAlign: 'center',labelAlign: 'right',labelWidth: 90,frame:true,
        items: [
				{xtype:'menu',},
					{layout:'column',
					items: [
				{ columnWidth:.33,layout: 'form', defaultType: 'textfield',
                items:[
                    {	fieldLabel: '产品一口价',
						allowBlank:false,
						name:'productPrice',
						blankText:'价格不能为空',value:'<!--{$goodinfo.productPrice}-->'},
					{
						xtype:"combo",
						fieldLabel: '交货时间',
						name: 'deliveryTime',
						store: deliveryTime,
						displayField: 'text2', 
						valueField: 'value2',
						triggerAction: 'all',
						labelWidth: 80, 
						width:120,
						mode:'local',
						emptyText:'请选择'},
					{fieldLabel: '商品关键字',name:'keyword',value:'<!--{$goodinfo.keyword}-->'},
					{fieldLabel: '包装长度',name:'packageLength',value:'<!--{$goodinfo.packageLength}-->'},
					
					
			]
            },{ columnWidth:.33,layout: 'form',defaultType: 'textfield',
                items:[
					{
						xtype:"combo",
						fieldLabel: '商品单位',
						name: 'UnitName',
						store: goodsunit,
						hiddenName:'productUnit',
						displayField: 'text1', 
						valueField: 'value1',
						triggerAction: 'all',
						labelWidth: 80, 
						width:120,
						mode:'local',
						emptyText:'请选择',
						allowBlank:false,
						blankText:'商品单位不能为空'},
                    {
						xtype:"combo",
						fieldLabel: '运费模版',
						name:'freightName',
						hiddenName:'freightTemplateId',
						id:'freight',
						triggerAction: 'all',
						store: freighttemplate,
						displayField: 'text', 
						valueField: 'value',
						labelWidth: 80, 
						width:120,
						mode: 'local',
						emptyText:'请选择'},
						{fieldLabel: '更多关键字',name:'productMoreKeywords1',value:'<!--{$goodinfo.productMoreKeywords1}-->'},
						{fieldLabel: '包装宽度',name:'packageWidth',value:'<!--{$goodinfo.packageWidth}-->'},
						]
            },{
                columnWidth:.33,
                layout: 'form',
                defaultType: 'textfield',
                items:[
					{xtype:'radio',fieldLabel:'商品有效天数',boxLabel:'14',inputValue:'14',name:'wsValidNum'},
					{xtype:'radio',boxLabel:'30',inputValue:'30',name:'wsValidNum'},
					{fieldLabel: '更多关键字',name:'productMoreKeywords2',value:'<!--{$goodinfo.productMoreKeywords2}-->'},
					{fieldLabel: '包装高度',name:'packageHeight',value:'<!--{$goodinfo.packageHeight}-->'},
					{fieldLabel: '商品净重',name:'grossWeight',value:'<!--{$goodinfo.grossWeight}-->'},
					{fieldLabel:'图片链接',name:'imageURLs',value:'<!--{$goodinfo.imageURLs}-->'}
					]
            }]
        },
		{xtype:'textarea',fieldLabel: '产品标题/简述',name:'subject',width:440,height:23,value:'<!--{$goodinfo.subject}-->'},
		new Ext.form.HtmlEditor({
        fieldLabel: '商品详情',
		width:730,
        enableAlignments: true,
        enableColors: true,
        enableFont: true,
        enableFontSize: true,
        enableFormat: true,
        enableLinks: true,
        enableLists: true,
        enableSourceEdit: true,
        fontFamilies: ['宋体', '黑体']
		,value:'<!--{$goodinfo.detail}-->',
		name:'detail'
    })
		]
    });
	var setform = new Ext.form.FormPanel({
		buttonAlign: 'center',
		autoHeight: true,
		labelWidth:60,
		labelAlign:'right', 
		frame:true,
		items:[form],
	});
		
	var attrform = new Ext.form.FormPanel({
		id:'attrform',
        defaultType: 'textfield',
        frame:true,
		items:[]           
    });
	
	
	
	<!--{foreach from =$attrinput item = v name=attr}-->
		var inputvalue;
			<!--{foreach from =$attrArr key=key item = attr name=attrname}-->
					if(<!--{$attr.attrNameId}--> == <!--{$v.id}-->){
						inputvalue = '<!--{$attr.attrValue}-->' ;
					}
			<!--{/foreach}-->
		attrform.add(new Ext.form.TextField({
					fieldLabel: '<!--{$v.name}-->', 
					name: 'inputValue-<!--{$v.id}-->',
					value: inputvalue,
					labelWidth:350,
					width:150,
				}));
	<!--{/foreach}-->
	<!--{foreach from =$countrys item = v2 name=country}-->
		
		attrform.add(new Ext.form.ComboBox({
			store : 
			new Ext.data.SimpleStore({
				fields: ['countryvalue','countrytext'],
				data:[<!--{$v2.values}-->]
			}),
			fieldLabel: '<!--{$v2.name}-->', 
			emptyText:'请选择',
			name:'country',
			triggerAction: 'all',
			displayField: 'countrytext', 
			valueField: 'countryvalue',
			labelWidth: 170, 
			mode: 'local',
		}));
	<!--{/foreach}-->
	<!--{foreach from=$attrlistbox item=v1 name=listbox}-->
		var comboboxValue;
				<!--{foreach from=$comArr item=comvalue name=comname}-->
					if(<!--{$v1.id}--> == <!--{$comvalue.attrNameId}-->){						
						<!--{foreach from=$combovalue item=value name=comboname}-->
							if(<!--{$comvalue.attrValueId}--> == <!--{$value.attrValueId}-->){
								comboboxValue = '<!--{$value.name}-->';
							}
						<!--{/foreach}-->
					}
				<!--{/foreach}-->
				/*[{"attrNameId":"2","attrValue":"i am pinpai"},{"attrNameId":"3","attrValue":"n89"},{"attrNameId":"200000492","attrValue":"250"},{"attrNameId":"200000650","attrValue":"1.5*2.3*4"},{"attrNameId":"200000649","attrValueId":"360543"},{"attrNameId":"200000791","attrValueId":"200003798"},{"attrNameId":"190","attrValueId":"361828"},{"attrNameId":"20303","attrValueId":"361808"},{"attrNameId":"14","attrValueId":"193"},{"attrNameId":"188","attrValueId":"361821"},{"attrNameId":"200000233","attrValueId":"200002868"},{"attrNameId":"276","attrValueId":"200003414"},{"attrNameId":"200000631","attrValueId":"349907"}]*/
		attrform.add(new Ext.form.ComboBox({
			store : 
			new Ext.data.SimpleStore({
				fields: ['value<!--{$smarty.foreach.listbox.index}-->','text<!--{$smarty.foreach.listbox.index}-->'],
				data:[<!--{$v1.values}-->]
			}),
			fieldLabel: '<!--{$v1.name}-->', 
			emptyText:'请选择',
			value:comboboxValue,
			name:'listbox<!--{$smarty.foreach.listbox.index}-->',
			hiddenName:'comboValueId-<!--{$v1.id}-->',
			triggerAction: 'all',
			displayField: 'text<!--{$smarty.foreach.listbox.index}-->', 
			valueField: 'value<!--{$smarty.foreach.listbox.index}-->',
			labelWidth: 170, 
			mode: 'local',
		}));
	<!--{/foreach}-->
	var packageform = new Ext.form.FormPanel({
		id:'packageform',
        defaultType: 'textfield',
        frame:true,
		items:[
		{fieldLabel: '商品净重',name:'grossWeight',value:'123123'},
		{fieldLabel: '包装长度',name:'packageLength'},
		{fieldLabel: '包装宽度',name:'packageWidth'},
		{fieldLabel: '包装高度',name:'packageHeight'},
		{xtype:'checkbox',fieldLabel:'自定义计重',disabled:true,}
		]           
    });
	var tabs = new Ext.TabPanel({
    renderTo: document.body,
    autoHeight:true,
    });
    tabs.add({
        title: '基本信息',
       items: [setform]
    });
	tabs.add({
        title: '产品属性',
        items: [attrform]	
    });
	tabs.add({
        id: Ext.id(),
        title: '图片银行',
		items: [
		{fieldLabel:'图片链接',name:'imageURLs'}
		]	
    });
	tabs.add({
        title: '包装信息',
        items: [packageform],
		disabled:true,	
    });
    tabs.activate(0);
    panel = new Ext.Panel({
		renderTo:document.body,
        buttonAlign:'center',
		autoHeight: true,
        layout:'fit',
		pageX:5,
		pageY:5,
        items: [tabs],
		 buttons: [{
            text: '保存',
            handler:  function(){
						var attrform = Ext.getCmp('attrform');
						var packageform = Ext.getCmp('packageform');
						setform.form.doAction('submit',{
							 url:'index.php?model=aliapi&action=save&catId=<!--{$catId}-->&catName=<!--{$catName}-->',
							 method:'post',
							 params:attrform.getForm().getValues(),
							 success:function(form,action){
							 		if (action.result.msg=='OK') {
										Ext.example.msg('保存成功',action.result.msg);
									} else {
										Ext.example.msg('保存失败',action.result.msg);
							 		}
							 },
							 failure:function(){
									Ext.example.msg('操作','信息不完整！');
							 }
                      });}
        },{
			text: '取消'
		}]
    });	
	var tippanel = new Ext.Panel({
				style:'margin-top:5px;',
				autoHeight:true,
				renderTo:document.body,
				html:'状态说明:<br>1.选择速卖通账户自动加载运费模版.<br>2.选择产品分类自动加载该分类下的产品属性.<br><br><br><br><br>'			
	});
});
</script>