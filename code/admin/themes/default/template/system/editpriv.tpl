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
		var privform =  Ext.create('Ext.FormPanel',{
			frame:false,
			border:false,
			id:'privform',
			buttonAlign:'center', 
			items:[{xtype:'hidden',name:'id',value:'<!--{$id}-->'},{xtype:'hidden',name:'type',value:'<!--{$type}-->'},
			{
			xtype:'checkboxgroup',
			fieldLabel:'账号管理',
			name:'account',
			id:'account',
			columns: 5,
			items:[
					<!--{foreach item=checkitem key=itemkey from=$acclist name=itemlist}-->{
					boxLabel:'<!--{$checkitem.name}-->',
					name:'item',
					inputValue:'<!--{$checkitem.code}-->',
					checked:<!--{if $checkitem.cando}-->true<!--{else}-->false<!--{/if}-->
					}<!--{if $smarty.foreach.itemlist.last}--><!--{else}-->,<!--{/if}--><!--{/foreach}--> ]
			},
			<!--{foreach item=item key=key from=$privlist name=list}-->{
			xtype:'checkboxgroup',
			fieldLabel:'<!--{$item.action_type_name}-->',
			name:'action<!--{$item.id}-->',
			id:'action<!--{$item.id}-->',
			<!--{if $smarty.foreach.list.index % 2 == 0}-->itemCls: 'x-check-group-alt',<!--{/if}-->
			columns: 5,
					 items: [
							<!--{foreach item=checkitem key=itemkey from=$item.action_list name=itemlist}-->{
							boxLabel:'<!--{$checkitem.name}-->',
							name:'item',
							inputValue:'<!--{$checkitem.code}-->',
							checked:<!--{if $checkitem.cando}-->true<!--{else}-->false<!--{/if}-->
							}<!--{if $smarty.foreach.itemlist.last}--><!--{else}-->,<!--{/if}--><!--{/foreach}-->
										 ]
							}<!--{if $smarty.foreach.list.last}--><!--{else}-->,<!--{/if}--><!--{/foreach}-->],
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
			var hobbys = '';var hobbys1 = '';
			<!--{foreach item=item key=key from=$privlist name=list}-->
			var ckd = Ext.getCmp('action<!--{$item.id}-->').getChecked(); //获取已经选取的checkbox
			for(var i=0; i< ckd.length; i++){
				hobbys += ','+ ckd[i].inputValue;  //遍历组合到数组中
			}
			 <!--{/foreach}-->
			 
			 var ckd2 = Ext.getCmp('account').getChecked();
			 for(var j=0; j< ckd2.length; j++){
				hobbys1 += ','+ ckd2[j].inputValue;  //遍历组合到数组中
			 }
			 var action = hobbys.substr(1);
			 var action1 = hobbys1.substr(1);
			 //alert(action); alert(action1);return;
			 var type = privform.form.findField('type').getValue();
			 var id = privform.form.findField('id').getValue();
			privform.form.doAction('submit',{
			 url:'index.php?model=privilege&action=savepriv',
			 method:'post',
			 params:{'actionlist':action,'account_list':action1},
			 success:function(form,action){
			  if (action.result.msg=='OK') {
			Ext.example.msg('编辑权限成功',action.result.msg);
			} else {
			Ext.Msg.alert('编辑权限失败',action.result.msg);
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
<div id="easyGrid" style="margin:20px;"></div>
<!--{include file="footer.tpl"}-->
 
