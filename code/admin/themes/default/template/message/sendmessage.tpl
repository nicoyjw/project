<!--{include file="header.tpl"}-->

<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
	var template = [<!--{$template}-->];
	
    Ext.form.Field.prototype.msgTarget = 'side';	
    var top = new Ext.FormPanel({
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:false,
		border:false,
		autoWidth:true,
		autoHeight:true,
		bodyStyle:'padding:15px',
        items: [{
			name:'subject',
			xtype:'textfield',
			labelWidth:70,
			width:380,
			fieldLabel: '主题'
			},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "temp_name"],
	             data: template
	        }),
	        valueField :"id",
	        displayField: "temp_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: '模板',
	        emptyText:'选择模板',
			labelWidth:70,
			width:380,
	        name: 'id',
	        id: 'id',
			blankText:'请选择',
				listeners: {
					change:function(field,e){
						Ext.getBody().mask("正在获取模板数据.请稍等...","x-mask-loading");
						Ext.Ajax.request({
						   url: 'index.php?model=template&action=getcontent&rec_id='+field.getValue()+'&order_id='+0,
						   loadMask:true,
							success:function(response,opts){
								Ext.getBody().unmask();
								Ext.getCmp('answer').setValue(response.responseText);
								}
							});									
					}
				}
	        },{
			xtype:'textarea',
			fieldLabel: '回复内容',
			labelWidth:70,
			width:380,
			height:200,
			id:'answer',
			name:'answer'
			},{
			xtype:'hidden',
			id:'order_id',
			name:'order_id',
			value:'<!--{$order_id}-->'
			},{
			xtype:'hidden',
			id:'type',
			name:'type',
			value:<!--{$type}-->
			},{
			xtype:'hidden',
			id:'ids',
			name:'ids',
			value:'<!--{$ids}-->'
			}
        ],

        buttons: [{
            text: '发送',
			handler:function(){
				if(top.form.isValid()){
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
								top.form.doAction('submit',{
								   url: 'index.php?model=message&action=sendmessage',
								 method:'post',
								 timeout:600000,
								 params:'',
								   loadMask:true,
									success:function(form,action){
										Ext.getBody().unmask();
											if(action.result.success){
											Ext.example.msg('MSG',action.result.msg);
											}else{
											Ext.Msg.alert('ERROR',action.result.msg);
											}						
										},
									 failure:function(form,action){
										 Ext.getBody().unmask();
										 Ext.Msg.alert('ERROR',action.result.msg);
									 }
									});									
				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
	
	
	top.render(document.body);
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
