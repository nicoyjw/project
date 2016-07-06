<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext/ux/css/MultiSelect.css"/>
<script type="text/javascript" src="common/lib/ext/ux/MultiSelect.js"></script>
<script type="text/javascript" src="common/lib/ext/ux/ItemSelector.js"></script>
<script type="text/javascript" src="js/newProduct/addProduct.js"></script>
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var imgtype =[<!--{$typedata}-->
	];
	var top = new Ext.FormPanel({
		labelWidth: 70,
        frame:true,
		width: 250,
		defaults: {width: 420},
        items: [{
				xtype:'textfield',
                fieldLabel: '标　题',
				<!--{if $info.news_title}-->
				value: '<!--{$info.news_title}-->',
				<!--{/if}-->
                name: 'title'
            },{
				xtype: 'htmleditor',
				width:500,
				fieldLabel: '内　容',
				name: 'content',
				<!--{if $info.content}-->
				value: '<!--{$info.content}-->',
				<!--{/if}-->
				fontFamilies: ['宋体','黑体']
			},{
				xtype:'hidden',
				name: 'id',
				id:'id',
				value: '<!--{$info.id}-->'
			}],

        buttons: [{
            text: '确定',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=news&action=save',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		Ext.Msg.alert('操作','保存成功!');

									var n = top.tab.getComponent('300010');
									//parent.tab.setActiveTab(n);
									n.ds.reload();
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