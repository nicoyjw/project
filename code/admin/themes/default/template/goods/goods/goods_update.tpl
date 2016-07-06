<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 10px;
        }
    </style>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	
    var simple = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
		fileUpload:true,
        title: '产品信息批量更新',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 500,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
				fieldLabel: '选择文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){formsubmit('index.php?model=goods&action=Updategoods',simple);}
			}]
    });
	var simple4 = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
		fileUpload:true,
        title: '从产品库批量标记产品为速卖通产品',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 500,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [
				new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'所属分类',
					xtype:'trigger',
					id:'cat_name',
					value:'请选择速卖通分类',
					onSelect: function(record){},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=aliexpress&action=getcattree&com=0',0,afterselect);
					}
				}),{
				xtype:'hidden',id:'cat_id',name:'cat_id'
				},{
				fieldLabel: '选择文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
           	 }
        ],
        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){formsubmit('index.php?model=aliexpress&action=UpdategoodsAli&type=import',simple4);}
			}]
    });
    var simple1 = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
		fileUpload:true,
        title: '产品库存批量更新',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 500,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
				xtype:'fieldset',  //清空库存记录
				width: 300,
				title:'清空库存记录',
				autoHeight:true,
				autoWidth:true,
				defaultType:'textfield',
				items:[{
					fieldLabel:'产品sku',
					width:120,
					id:'goods_sku'
				},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
						 fields: ["id", "key_type"],
						 data: [<!--{$shelf}-->]
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:120,
					editable: false,
					value:0,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'shelf_id2',
					allowBlank:false,
					fieldLabel: '货架',
					id:'shelf_id2'
				},{
					xtype:'button',
					text:'删除记录',
					handler:function(){
						Ext.Msg.confirm('提示!','是否删除记录?',function(btn){
						if(btn=='yes'){
						var sku=Ext.getCmp('goods_sku').getValue();
						var depo=Ext.getCmp('shelf_id2').getValue();
						Ext.Ajax.request({
							url:'index.php?model=goods&action=delDeopRecord&sku='+sku+'&depo='+depo,
							success:function(response,opts){
								var res=Ext.decode(response.responseText);
								if(res.success){
									Ext.example.msg('MSG',res.msg);
								}else{
									Ext.Msg.alert('ERROR',res.msg);
								}
							}});
							}
						},this);}
				}]
			},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: [<!--{$shelf}-->]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:130,
				editable: false,
				value:0,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'shelf_id',
				allowBlank:false,
				fieldLabel: '货架',
				id:'shelf_id'
				},{
				fieldLabel: '选择文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){formsubmit('index.php?model=goods&action=Updatestock',simple1);}
			}]
    });
    var simple2 = new Ext.FormPanel({
        labelWidth: 75,
        frame:true,
		fileUpload:true,
        title: '产品图库批量更新',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 500,
        defaults: {width: 150},
		renderTo:document.body,
        items: [    //清空图库和导出图库
			{
				xtype:'button',
				text:'清空图库',
				width:75,
				handler:function(){
						Ext.Msg.confirm('提示!','是否确定清空图库?',function(btn){
						if(btn=='yes'){
						Ext.Ajax.request({
							url:'index.php?model=goods&action=Emptyegallery',
							success:function(response,opts){
								var res=Ext.decode(response.responseText);
								if(res.success){
									Ext.example.msg('MSG',res.msg);
								}else{
									Ext.Msg.alert('ERROR',res.msg);
								}
							}});
							}
						},this);}
			},{
				xtype:'button',
				text:'导出图库',
				width:75,
				style:'margin:10px 0',
				handler:function(){
						window.open().location.href = 'index.php?model=goods&action=Exportgallery'}
			},
			{
				
				fieldLabel: '选择xls文件',
				inputType: 'file',
				xtype: 'textfield',
				allowBlank:false,
				name:'file_path'
            }
        ],

        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){formsubmit('index.php?model=goods&action=Updategallery',simple2);}
			}]
    });
	var formsubmit = function(url,form){
					form.form.doAction('submit',{
					   url: url,
					   method:'post',
					   timeout: 600000,
					   waitMsg: '正在更新产品资料',
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('ERROR',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.Msg.alert('操作',action.result.msg);
							 }
						});
					}
					
    var simple3 = new Ext.FormPanel({
        labelWidth: 100,
        frame:true,
		fileUpload:true,
        title: '产品图库外链批量更新',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 500,
        defaults: {width: 200},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
						xtype:'textfield',
						id:'img_src',
						fieldLabel:'匹配公式'
					},{
						xtype:'textfield',
						id:'SKU',
						fieldLabel:'SKU起始'
					},{
						xtype:'textfield',
						id:'num_s',
						fieldLabel:'序号开始'
					},{
						xtype:'textfield',
						id:'num_e',
						fieldLabel:'序号结束'
					},{
						xtype:'checkbox',
						id:'is_replace',
						checked:false,
						fieldLabel:'自动替换主图片'
					},{
						xtype:'displayfield',
						fieldLabel:'说明:',
						value:'匹配公式如data/foldername/{SKU}_{num}.jpg,SKU为空则匹配所有产品'
					}
        ],

        buttons: [{
				text: '查询',
				type: 'submit',
				handler:function(){formsubmit('index.php?model=goods&action=Upgallery',simple3);}
			}]
    });
	loadend();
});
function afterselect(k,v){
	Ext.getCmp('cat_name').setValue(v);
	Ext.getCmp('cat_id').setValue(k);
}
</script>
<!--{include file="footer.tpl"}-->
