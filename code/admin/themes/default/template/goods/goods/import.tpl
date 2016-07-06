<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var goods_brand = [<!--{$goods_brand}-->];
	var xlstype=[['0','普通产品'],['1','组合产品']];
    var simple = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
        title: '产品批量导入',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'分类',
					xtype:'trigger',
					id:'cat_name',
					value:'All',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=goods&action=getcattree&com=1',0,afterselect);
					}
					}),{xtype:'hidden',id:'cat_id',value:0},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: goods_brand
							}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:130,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'brand_id',
					name: 'brand_id',
					allowBlank:false,
					fieldLabel: '产品品牌'
            },{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: xlstype
							}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:130,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'type',
					name: 'type',
					allowBlank:false,
					value:0,
					fieldLabel: '格式'
            },{
				fieldLabel: 'xls文件',
				inputType: 'file',
				xtype: 'textfield',
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
	
    var simple1 = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
        title: '产品序列号批量导入',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
				fieldLabel: 'xls文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path1'
            }
        ],

        buttons: [{
				text: '导入',
				type: 'submit',
				handler:function(){formsubmit1();}
			}]
    });
	
	var afterselect = function(k,v){
		Ext.getCmp('cat_name').setValue(v);
		Ext.getCmp('cat_id').setValue(k);
		}
	var formsubmit = function(){
		if(Ext.getCmp('cat_id').getValue() ==0){Ext.example.msg('Error','请选择对应导入分类');return false;}
					if(simple.form.isValid()){
						simple.form.doAction('submit',{
							 url:'index.php?model=goods&action=upload',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('导入成功',action.result.msg);
									} else {
										Ext.Msg.alert('导入错误',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.Msg.alert('操作',action.result.msg);
							 }
                      });
					}
				}
	var formsubmit1 = function(){
					if(simple1.form.isValid()){
						simple1.form.doAction('submit',{
							 url:'index.php?model=goods&action=uploadSN',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('导入成功',action.result.msg);
									} else {
										Ext.Msg.alert('导入错误',action.result.msg);
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
