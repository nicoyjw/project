<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	var account  = [<!--{$account}-->];
	account.push(['0','所有账户']);
    var simple =Ext.create('Ext.form.Panel',{
        frame:true,
        title: '订单批量更新',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 450,
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
			  fieldLabel: '账号',
			  xtype:'combo',
			  store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["key", "key_account"],
					 data: account
				}),
				valueField :"key",
				displayField: "key_account",
				mode: 'local',
				editable: false,
      		  	labelWidth: 75,
				width:300,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'accounttype',
				name:'account',
				value:'0'	//默认设置
		 
		 },{
				fieldLabel: 'excel文件',
				xtype: 'fileuploadfield',
      		  	labelWidth: 75,
				width:300,
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
					if(simple.getForm().isValid()){
						simple.getForm().submit({
							 url:'index.php?model=order&action=UpLoadupdate',
							 method:'post',
							 params:'',
							 success:function(form,action){
								if (action.result.success) {
									Ext.example.msg('导入成功',action.result.msg);
								} else {
									Ext.example.msg('导入错误',action.result.msg);
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
