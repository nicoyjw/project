<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	   Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
     var top=new Ext.FormPanel({
		labelWidth:40,
        bodyStyle:'padding:5px 5px 0',
		frame:true,
		defaults: {width: 175},
		defaultType: 'textfield',
        items: [{
        		id:'agent_name',
                fieldLabel: '名称',
                allowBlank:false,
				value: '<!--{$info.agent_name}-->',
                name: 'agent_name'
            },{
                fieldLabel: '电话',
                id:'telephone',
                allowBlank:false,
				value: '<!--{$info.telephone}-->',
                name: 'telephone'
            },{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					fields: ["retrunValue", "displayText"],
					data: [<!--{$tel_type}-->]
				}),
				valueField :"retrunValue",
				displayField: "displayText",
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'tel_type',
				fieldLabel: '类型',
				emptyText:'选择',
				name: 'tel_type',
				value: '<!--{$info.tel_type}-->'
            },{
				xtype:'textarea',
                fieldLabel: '名称',
                id:'note',
				value: '<!--{$info.note}-->',
                name: 'note'
            },{
				xtype:'hidden',
				name: 'id',
				id:'id',
				value: '<!--{$info.id}-->'
			}],

        buttons: [{
            text: '保存',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=telephone&action=save',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 	if (!Ext.fly('id').dom.value) top.form.reset();
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
});</script>

<!--{include file="footer.tpl"}-->