<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){

    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var top = new Ext.FormPanel({
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: '修改密码',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		width:300,
        items: [{
	    	xtype:'textfield',
	    	inputType:'password',
	        fieldLabel: '原密码',
	        name: 'oldpasswd',
	        allowBlank:false,
	        anchor:'90%'
	        },{
	    	xtype:'textfield',
	    	inputType:'password',
	        fieldLabel: '新密码',
	        name: 'passwd',
	        allowBlank:false,
	        anchor:'90%'
	        },{
	    	xtype:'textfield',
	    	inputType:'password',
	        fieldLabel: '重复密码',
	        name: 'passwd2',
	        allowBlank:false,
	        anchor:'90%'
	        }
        ],

        buttons: [{
            text: '保存',
			handler:function(){
				if(top.form.isValid()){
					top.form.doAction('submit',{
						url:'index.php?model=user&action=savepass',
						method:'post',
						params:'',
						success:function(form,action){
							Ext.example.msg('操作',action.result.msg);
							
						},
						failure:function(){
							Ext.example.msg('操作','服务器出现错误请稍后再试！');
									
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
