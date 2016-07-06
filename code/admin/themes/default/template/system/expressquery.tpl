<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var queryForm = new Ext.FormPanel({
        id: 'query_form_id',
		url:'index.php?model=system&action=trackquery',
		region:'center',
		border:false,
		autoScroll:true,
        labelAlign: 'left',
        bodyStyle:'padding:5px',
        items: [
			{
				xtype: 'fieldset',
				border:false,
				layout: 'column',
				columns:3,
				items:[
					{
						name: 'keyword',
						xtype:'textfield',
						allowBlank:false,
						blankText:'不能为空',
						emptyText:'请输入快递号',
						style:'margin-left:5px;text-indent:5px;'				
					},
					{
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: [['0','自动选择'],['DHL','DHL'],['UPS','UPS'],['DHL','DHL'],['USPS','USPS'],['FEDEX','FEDEX'],['Yanwen','Yanwen'],['TNT','TNT'],['4PX','4PX'],['HKMail','HKMail']]
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'type',
						fieldLabel: '方式',
						name: 'type',
						value:0
					},
					{
					text:'查询',
					width:40,
					style:'margin-left:20px',
					xtype:'button',
					handler: function() {
							if(queryForm.form.isValid()) {
									Ext.getBody().mask("Checking Data .waiting...","x-mask-loading");
									queryForm.form.submit({
										success:function(form,action){
											Ext.getBody().unmask();
											if(action.result.success){
												Ext.getCmp("tracking_result").update(action.result.msg);
											 }
										}
									});						
							}
						}
					}
				]
			},
			{
				xtype:'container',
				html:'',
				style:'padding-left:10px',
				autoHeight:true,
				title:'Result',
				autoScroll:true,
				id:'tracking_result'
			}
		]
    });
	
	var viewport = new Ext.Viewport({
        layout:'border',
        items:[queryForm]
	});
	loadend();
});
</script>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->