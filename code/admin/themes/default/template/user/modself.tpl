<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){

    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var top = new Ext.FormPanel({
        buttonAlign:'right',
		labelWidth:70,
        frame:true,
        title: '个人信息',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
        items: [{
	            layout:'column',
	            items:[{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '电话',
	                    name: 'telephone',
						value: '<!--{$info.telephone}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '手机',
	                    name: 'mobile',
						value: '<!--{$info.mobile}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.33,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: 'Email',
	                    name: 'email',
	                    vtype:'email',
						value: '<!--{$info.email}-->',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.66,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '地址',
	                    name: 'address',
						value: '<!--{$info.address}-->',
	                    anchor:'90%'
	                }]
	            }]
        	}
        ],

        buttons: [{
            text: '保存',
			handler:function(){
				if(top.form.isValid()){
					top.form.doAction('submit',{
						url:'index.php?model=user&action=saveself',
						method:'post',
						params:'',
						success:function(form,action){
							Ext.Msg.alert('操作','保存成功!');
							
						},
						failure:function(){
							Ext.Msg.alert('操作','服务器出现错误请稍后再试！');
									
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
