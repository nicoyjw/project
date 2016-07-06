<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var depot = [<!--{$depot}-->];
	var first_shipping = [<!--{$first_shipping}-->];
	var db_shipping = [<!--{$db_shipping}-->];
    var simple = Ext.create('Ext.form.Panel',{
        labelWidth: 75,
        frame:true,
        title: '调拨单导入',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: depot
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								hiddenName:'depot_id_from',
								triggerAction: 'all',
								fieldLabel: '调出仓库',
								allowBlank:false,
								pagesise:10,
								labelWidth:85,
								width:220,
								value:0,
								id:'depot_from'							
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: depot
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								hiddenName:'depot_id_to',
								triggerAction: 'all',
								fieldLabel: '调入仓库',
								allowBlank:false,
								pagesise:10,
								labelWidth:85,
								width:220,
								value:0,
								id:'depot_to'							
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: first_shipping
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								hiddenName:'first_shipping',
								triggerAction: 'all',
								fieldLabel: '头程渠道',
								allowBlank:false,
								pagesise:10,
								labelWidth:85,
								width:220,
								value:1,
								id:'first_shipping_id'							
							},{
								xtype:'combo',
								store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: db_shipping
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								forceSelection: true,
								hiddenName:'db_shipping',
								triggerAction: 'all',
								fieldLabel: '货运方式',
								allowBlank:false,
								pagesise:10,
								labelWidth:85,
								width:220,
								value:0,
								id:'db_shipping_id'							
							},{
								xtype:'textfield',
								labelWidth:85,
								width:220,
								fieldLabel: '箱数',
								id:'count'	
							},{
								xtype:'textfield',
								labelWidth:85,
								width:220,
								fieldLabel: '追踪号',
								id:'track_no'	
							},{
								xtype:'textfield',
								labelWidth:85,
								width:220,
								fieldLabel: '重量',
								id:'weight'	
							},{
								xtype:'textfield',
								labelWidth:85,
								width:220,
								fieldLabel: '订单备注',
								id:'comment'	
							},{
				fieldLabel: 'xls文件',
				labelWidth:85,
				width:290,
				xtype: 'fileuploadfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '导入',
				type: 'submit',
				handler:function(){formsubmit();}
			}]
    });
	var formsubmit = function(){
					  if(simple.form.isValid()){
						simple.form.doAction('submit',{
							 url:'index.php?model=inventory&action=upload',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('导入成功',action.result.msg);
									} else {
										Ext.Msg.alert('导入错误',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.Msg.alert('操作',action.result.msg);
							 }
                      });
					}
				}
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
