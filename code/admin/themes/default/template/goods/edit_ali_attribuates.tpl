<!--{include file="header.tpl"}-->
<script type="text/javascript">
/*Ext.onReady(function(){
	Ext.QuickTips.init();
	var attribute = <!--{$attribute}-->;
	var tippanel =Ext.create('Ext.form.Panel',{
		buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:false,
		border:false,
		width:725,
		renderTo:document.body,
		items:[
			{xtype:'hidden',name:'attrlength',id:'attrlength',value:0},{
				xtype: 'fieldset',
				defaultType: 'textfield',
				id:'attributeset',
				hideLabel:true,
				width:720,
				autoScroll:true,
				padding:5,
				items:[]
			}
		
		],
		buttons:[{
			text: '保存',
			type: 'submit', 
			handler:function(){
				parent.window.location="javascript:location.reload()";
			}
		},{
			text: '取消',
			handler:function(){
				
			}
		}]		
	});
	var res = attribute;
	Ext.getCmp('attrlength').setValue(res.length);
	var aobt = Ext.getCmp('attributeset');
	for(var i = 0;i < res.length;i++){
		var datavalue = [];
		var valueID;
		var value;
		switch(res[i]['show_type']){
			case 'combo':
			for(var j = 0; j < res[i]['values'].length; j++){
				valueID = parseInt(res[i]['values'][j]['id']);
				value = res[i]['values'][j]['name'];
				datavalue.push([valueID,value]);
			}
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
				value:parseInt(res[i]['val'])
			}]
			
			aobt.add(addattr);
			break;
			case 'checkboxgroup':
			var checkitems = [];
			 for(var j = 0; j < res[i]['values'].length; j++){
				
				valueID = res[i]['values'][j]['id'];
				value = res[i]['values'][j]['name'];
				
				checkitems.push({
					boxLabel:value,
					name:valueID,
					checked:res[i]['values'][j]['ischeck']
				})
			}
			var checkGroup = {
				xtype: 'fieldset',
				frame:false,
				style:'margin-top:15px;',
				border:false,
				layout: 'anchor',
				width:700,
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
					columns: 2,
					vertical: true,
					cls: 'x-check-group-alt',
					items: checkitems	
				}]
			 }
			aobt.add(checkGroup);
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
				labelWidth:145,
				value:res[i]['val']
			}]
			aobt.add(addattr);
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
			   minValue:0,
			   value:res[i]['val']
			}]
			aobt.add(addattr);
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
				xtype:'textarea',
				value:res[i]['val']
			}]
			aobt.add(addattr);
			break;		
		}
	}
	aobt.doLayout(true);
	loadend();
});*/
</script>

<!--{$attribute}-->
<!--{include file="footer.tpl"}-->
