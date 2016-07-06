<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){

    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var top = new Ext.FormPanel({
        buttonAlign:'right',
		labelWidth:0,
        frame:true,
        title: '系统设置',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		autoScroll:true,
		width:500,
		defaultType: 'checkbox',
        items: [{
        	xtype:'hidden',
            fieldLabel: '',
            labelSeparator:'',
            name: 'tmp'
            }
<!--{foreach item=item key=key from=$tree}-->
			,{labelSeparator:'',
                boxLabel: '<!--{$item.text}-->',
                labelSeparator:'',
                value: '<!--{$item.id}-->',
                checked:<!--{$item.right}-->,
                name: 'right[<!--{$item.id}-->]'}
	<!--{foreach item=item2 key=key2 from=$trees[$item.id]}-->
		,{labelSeparator:'',
                boxLabel: '&nbsp;&nbsp;&nbsp;&nbsp;<!--{$item2.text}-->',
                value: '<!--{$item2.id}-->',
                checked:<!--{$item2.right}-->,
                name: 'right[<!--{$item2.id}-->]'}
		<!--{foreach item=item3 key=key3 from=$trees[$item2.id]}-->
			            ,{labelSeparator:'',
                boxLabel: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--{$item3.text}-->',
                value: '<!--{$item3.id}-->',
                checked:<!--{$item3.right}-->,
                name: 'right[<!--{$item3.id}-->]'}
		<!--{/foreach}-->

	<!--{/foreach}-->
<!--{/foreach}-->            

            ],

        buttons: [{
            text: '保存',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=user&action=saveright',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		Ext.example.msg('操作','保存成功!');
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