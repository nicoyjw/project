<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var simple = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
        title: '产品批量查询',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
											    xtype:'combo',
												store: new Ext.data.SimpleStore({
													 fields: ["id", "key_type"],
													 data: [<!--{$depot}-->]
												}),
												valueField :"id",
												displayField: "key_type",
												mode: 'local',
												width:130,
												editable: false,
												value:0,
												forceSelection: true,
												triggerAction: 'all',
												hiddenName:'depot_id',
												allowBlank:false,
										   		fieldLabel: '仓库',
												id:'depot_id'
												},{
				fieldLabel: 'xls文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){
					simple.getForm().getEl().dom.action = "index.php?model=goods&action=advresult";
					simple.getForm().getEl().dom.submit();
					}
			}]
    });
    var simple1 = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
        title: '产品SKU批量生成器',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
				fieldLabel: 'xls文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '自动生成',
				type: 'submit',
				handler:function(){
					simple1.getForm().getEl().dom.action = "index.php?model=goods&action=generatesku";
					simple1.getForm().getEl().dom.submit();
					}
			}]
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
