<!--{include file="header.tpl"}-->

<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var cat_id = '<!--{$cat_id}-->';
	var cat_name = '<!--{$cat_name}-->';
	
	
	if(cat_id){
		 var form1 = new Ext.FormPanel({
			frame: false,
			style:'background-color:#FFF',
			renderTo: Ext.getBody(),
			style: 'margin-left:auto;margin-right:auto;width:500px;margin-top:8px;',
			labelAlign: 'right',
			labelWidth: 170,
			buttonAlign:'center',
			items: [{   
					xtype: 'fieldcontainer',
					style:'margin-bottom:20px;',
					labelWidth: 85, 
					layout: {
						type: 'hbox',   
						align: 'middle'
					},   
					combineErrors : true,
					defaultType: 'textfield',
					items: [{   
								xtype : 'displayfield',   
								value :'匹配的分类:',
								style:'margin-left:5px;'
							},{
								xtype:'button',
								text:cat_name,
								style:'margin-left:25px',
								handler:function(){
									parent.Ext.getCmp('cat_name').setValue('<!--{$cat_name}-->');
									parent.Ext.getCmp('ebaygoodform').afterselect('<!--{$cat_id}-->');
									parent.Ext.getCmp('<!--{$id}-->').hide();
								}
							},{   
								xtype : 'displayfield',   
								value :'点击按钮使用该分类',
								style:'margin-left:35px;'
							}
					]
					
			}]
		});	
	}else{
		var form1 = new Ext.FormPanel({
			frame: false,
			renderTo: Ext.getBody(),
			style: 'margin-left:auto;margin-right:auto;width:500px;margin-top:8px;',
			labelAlign: 'right',
			labelWidth: 170,
			buttonAlign:'center',
			items: [{   
					xtype: 'fieldcontainer',
					style:'margin-bottom:20px;',
					labelWidth: 85, 
					layout: {
						type: 'hbox',   
						align: 'middle'
					},   
					combineErrors : true,
					defaultType: 'textfield',
					items: [{   
								xtype : 'displayfield',   
								value :'没有匹配到任何分类，请检查关键字',
								id:'cat_name',
								style:'margin-left:5px;'
							}
					]
					
			}]
		});	
	}
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
