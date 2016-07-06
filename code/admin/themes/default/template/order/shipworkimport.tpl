<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var simple = Ext.create('Ext.form.Panel',{
        labelWidth: 75,
        frame:true,
        title: '导入shipworks处理后订单',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
			fieldLabel: '订单文件',
			width:280,
			xtype: 'fileuploadfield',
			allowBlank:false,
			name:'file_path'
		}],

        buttons: [{
				text: '导入',
				type: 'submit',
				handler:function(){formsubmit();}
			}]
    });
	var formsubmit = function(){
		if(simple.getForm().isValid()){
			simple.getForm().submit({
				 url:'index.php?model=order&action=handleshipwork',
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
