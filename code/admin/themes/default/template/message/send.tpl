<!--{include file="header.tpl"}-->
<script type="text/javascript">

Ext.onReady(function(){
	   Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
     var top=new Ext.FormPanel({
		labelWidth:80,
        bodyStyle:'padding:5px 5px 0;background-color: #d2e0f2;',
		frame:false,
		border:false,
		defaults: {width: 175},
		defaultType: 'textfield',
        items: [{
        		id:'receive_user',
                fieldLabel: '收件人',
                allowBlank:false,
				value: '<!--{$info.send_user_id}-->',
                name: 'receive_user'
            },{
                fieldLabel: '标题',
                id:'message_title',
                allowBlank:false,
				value: '<!--{$info.message_title}-->',
                name: 'message_title'
            },{
				xtype:'htmleditor',
                fieldLabel: '内容',
                id:'content',
				value: '<!--{$info.content}-->',
				height:280,
				width: 'auto',
                name: 'content'
            },{
				xtype:'checkbox',
				boxLabel:'保存到发件箱',
                fieldLabel: '选项',
                id:'save_send_box',
                name: 'save_send_box'
            },{
				xtype:'hidden',
				name: 'id',
				id:'id',
				value: '<!--{$info.id}-->'
			}],

        buttons: [{
            text: '发送',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=message&action=save',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 	if (action.result.msg=='OK') {
							 		if (!Ext.fly('id').dom.value) top.form.reset();
							 		Ext.example.msg('操作','消息发送成功!');
							 	} else {
							 		Ext.example.msg('出错',action.result.msg);
							 	}
							 		
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
                      });
					}
					}
        },{
            text: '保存草稿',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=message&action=save&type=draft',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 	Ext.example.msg('操作','已保存草稿!');
							 },
							 failure:function(){
								Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
                      });
					}
					}
        }]
    }); 
    top.render(document.body);       
	loadend();
});</script>

<!--{include file="footer.tpl"}-->