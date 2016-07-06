<!--{include file="header.tpl"}-->
    <style type="text/css">
        .x-check-group-alt {
            background: #D1DDEF;
            border-top:1px dotted #B5B8C8;
            border-bottom:1px dotted #B5B8C8;
        }
    </style>
    <script type="text/javascript">
Ext.onReady(function() {
	var privform = new Ext.FormPanel({
		frame:true,
		buttonAlign:'center',
		autoScroll:true,
		items:[{xtype:'hidden',name:'group_id',value:'<!--{$group_id}-->'},
				{
					layout:'column',
					fieldLabel:'选择属性',
					
					items:[{
						xtype:'checkboxgroup',
						columnWidth:.5,
						name:'group',
						widht:150,
						columns: 1,
						items: [
						<!--{foreach item=checkitem key=itemkey from=$privlist name=itemlist}-->{
							boxLabel:'<!--{$checkitem.attribute_code}-->',
							name:'item<!--{$checkitem.attribute_id}-->',
							height:25,
							inputValue:'<!--{$checkitem.attribute_id}-->',
							checked:<!--{if $checkitem.cando}-->true<!--{else}-->false<!--{/if}-->
							}
						<!--{if $smarty.foreach.itemlist.last}--><!--{else}-->,<!--{/if}-->
						<!--{/foreach}-->]
						}
					]}
				],
				/**/
        buttons: [{
				text: '保存',
				type: 'submit', 
				handler:function(){formsubmit();}
			},{
					text: '取消',
					handler:function(){privform.form.reset();}
			}],
		renderTo:document.body	
	});
	var formsubmit = function(){
		var hobbys = '';
		var sort_order = '';
		<!--{foreach item=item key=key from=$privlist name=list}-->
			var FileItype = privform.form.findField('item<!--{$item.attribute_id}-->').getValue();
			if(FileItype){
				hobbys += ','+privform.form.findField('item<!--{$item.attribute_id}-->').inputValue ;
			}
           // hobbys += ','+ FileItype[].inputValue;  //遍历组合到数组中
		 <!--{/foreach}-->
		 var action = hobbys.substr(1);
		 var order  = sort_order.substr(1);
		 //alert(order);return;
		 var id = privform.form.findField('group_id').getValue();
						privform.form.doAction('submit',{
							 url:'index.php?model=attribute&action=savegroupattr',
							 method:'post',
							 params:{'itemlist':action,'sort_order':order},
							 success:function(form,action){
							 		if (action.result.msg=='OK') {
										Ext.example.msg('编辑属性成功',action.result.msg);
									} else {
										Ext.Msg.alert('编辑属性失败',action.result.msg);
							 		}
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
                      });
	}
	loadend();
});
</script>
<div id="easyGrid" style="margin:5px;"></div>
<!--{include file="footer.tpl"}-->
