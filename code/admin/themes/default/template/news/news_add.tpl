<!--{include file="header.tpl"}-->
    <link rel="stylesheet" type="text/css" href="common/lib/ext/ux/css/MultiSelect.css"/>
    <script type="text/javascript" src="common/lib/ext/ux/MultiSelect.js"></script>
    <script type="text/javascript" src="common/lib/ext/ux/ItemSelector.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	var ds1 = new Ext.data.ArrayStore({
        data: [<!--{$info.ds1}-->],
        fields: ['value','text']
    });
	var ds = new Ext.data.ArrayStore({
		data: [<!--{$info.ds}-->],
        fields: ['value','text']
    });
    var top = new Ext.FormPanel({
		labelWidth: 70,
        frame:true,
		width: 700,
		buttonAlign:'center',
		defaults: {width: 420},
        items: [{
				xtype:'textfield',
                fieldLabel: '标　题',
				value: '<!--{$info.news_title}-->',
				allowBlank:false,
                name: 'title'
            },{
				xtype: 'compositefield',
                fieldLabel: '查看人员',
				width:700,
				items: [{
						fieldLabel: '查看人员',
						width: 500,
						xtype: 'itemselector',
						id: 'set_user_id',
						name:'set_user_id',
						imagePath: 'common/lib/ext/ux/images/',
						multiselects: [{
							legend: '未选择的用户',
							width: 150,
							height: 150,
							store: ds,
							displayField: 'text',
							valueField: 'value'
						},{
							legend: '已经选择的用户',
							width: 150,
							height: 150,
							name:'set_user_id',
							displayField: 'text',
							valueField: 'value',
							store: ds1
						}]
						}]
            },{
				xtype: 'htmleditor',
				width:500,
				fieldLabel: '内　容',
				name: 'content',
				value: '<!--{$info.content}-->',
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
<!--
{
							xtype:'combo',
							store: new Ext.data.SimpleStore({
								 fields: ["id", "account_name"],
								 data: []
							}),
							valueField :"id",
							displayField: "account_name",
							mode: 'local',
							width:100,
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'id',
							fieldLabel: '角色',
							emptyText:'选择角色',
							name: 'id',
							blankText:'请选择',
							listeners: {
								change:function(field,e){
									console.log(Ext.get('set_user_id'));
									//modifymodel(thiz.order.order_id,field.getName(),field.getValue(),'order');
								}
							}
						},
-->
<!--{include file="footer.tpl"}-->