// JavaScript Document
Ext.ux.addProductForm=Ext.extend(Ext.FormPanel,{
		initComponent:function(){
			this.frame=true,
			this.autoHeight=true,
			this.buttonAlign='center',
			this.creatItems();
			this.creatButtons();
			Ext.ux.addProductForm.superclass.initComponent.call(this);
		},
		creatItems:function(){
			var afterselect=this.afterselect;
			var depict=new Ext.ux.form.FCKeditor({width:600,height:400,id:'depict',fieldLabel:'产品描述',value:this.good.depict});
			this.items=[{
			layout:'column',items:[
				{columnWidth:.33,layout:'form',defaultType:'textfield',
					items:[
						{xtype:'hidden',id:'goods_id',value:this.good.goods_id},
						{fieldLabel:'产品名称',
						id:'goods_name', 
						width:200,
						allowBlank:false,
						value:this.good.goods_name
						},
						{fieldLabel:'SKU',
						id:'sku', 
						width:200,
						allowBlank:false,
						value:this.good.sku
						},
						{xtype:'hidden',id:'status',value:this.good.status},
						{fieldLabel:'长',width:200,xtype:'numberfield',decimalPrecision:4,allowDecimals:true,value:this.good.l,id:'l'}				
					]},
				{columnWidth:.33,layout:'form',defaultType:'textfield', 
					items:[
						{xtype:'combo',
						store:new Ext.data.SimpleStore({fields:["id","key_type"],data:this.goods_data[2]}),
						valueField:"id",
						displayField:"key_type",mode:'local',
						width:200,
						editable:false,
						forceSelection:true,
						triggerAction:'all',
						hiddenName:'brand_id',
						name:'brand',
						value:this.good.brand_id,
						allowBlank:false,
						fieldLabel:'品牌'},
						{fieldLabel:'产品链接',width:200,id:'goods_url',allowBlank:false,value:this.good.goods_url},
						{fieldLabel:'宽',xtype:'numberfield',decimalPrecision:4,allowDecimals:true,width:200,value:this.good.w,id:'w'}
					]},
				{columnWidth:.33,layout:'form',
					items:[
						new Ext.form.TriggerField({
							editable:false,
							fieldLabel:'所属分类',
							xtype:'trigger',
							id:'cat_name',
							width:220,
							allowBlank:false,
							value:this.good.cat_name,
							onSelect:function(record){},
							onTriggerClick:function(){
								getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',0,afterselect);
							}}),
						{xtype:'hidden',id:'cat_id',value:this.good.cat_id},
						{fieldLabel:'图片链接',width:220,id:'goods_img',xtype:'textfield',value:this.good.goods_img},
						{fieldLabel:'高',width:220,xtype:'numberfield',decimalPrecision:4,allowDecimals:true,value:this.good.h,id:'h'}
					]}
			]},
			{layout:'column',items:[
				{columnWidth:.66,layout:'form',defaultType:'textfield',items:[
					{fieldLabel:'产品标题',id:'goods_title',width:542,height:25,xtype:'textarea',value:this.good.goods_title},
					{fieldLabel:'产品属性',id:'goods_attribute',width:542,height:50,xtype:'textarea',value:this.good.goods_attribute},
					{fieldLabel:'产品简述',id:'resume',width:542,height:50,xtype:'textarea',value:this.good.resume},
					{fieldLabel:'备注',id:'comment',width:542,height:50,xtype:'textarea',value:this.good.comment}
				]},
				{columnWidth:.33,layout:'form',items:[
					{layout:'column',items:[
							{columnWidth:.50,layout:'form',items:[
							{fieldLabel:'净重',id:'suttle',width:88,xtype:'numberfield',decimalPrecision:4,allowDecimals:true,value:this.good.suttle}]},
							{columnWidth:.50,labelWidth: 30,layout:'form',items:[
							{fieldLabel:'重量',id:'weight',width:87,xtype:'numberfield',decimalPrecision:4,allowDecimals:true,value:this.good.weight}]}
						]},
					{fieldLabel: '尺码选择',
					xtype: 'itemselector',
					id: 'size',
					name:'size',
					imagePath: 'common/lib/ext/ux/images/',
					multiselects: [{
						legend: '未选择尺码',
						width: 100,
						height: 120,
						store: this.sizeData,
						displayField: 'text',
						valueField: 'value'
					},{
						legend: '已经选择尺码',
						width: 100,
						height: 120,
						displayField: 'text',
						valueField: 'value',
						store: this.setSizeData
					}]
					},{fieldLabel: '产品颜色',
					xtype: 'itemselector',
					id: 'color',
					name:'color',
					imagePath: 'common/lib/ext/ux/images/',
					multiselects: [{
						legend: '未选择颜色',
						width: 100,
						height: 120,
						store: this.colorData,
						displayField: 'text',
						valueField: 'value'
					},{
						legend: '已经选择颜色',
						width: 100,
						height: 120,
						displayField: 'text',
						valueField: 'value',
						store: this.setColorData
					}]
					}
				]},
			]},{layout:'form',items:[this.good.goods_audit?{fieldLabel:'产品审核意见',xtype:'label',value:this.good.goods_audit}:{},
			depict]}]
		},
		creatButtons:function(){
			this.buttons=[{text:'提交审核',type:'submit',handler:this.formsubmit.createDelegate(this)},
						  {text:'保存',type:'submit',handler:this.formsave.createDelegate(this)},
						  {text:'取消',handler:this.formreset.createDelegate(this)}];},
		formsave:function(){
			if(this.getForm().isValid()){
				this.getForm().submit({
					url:'index.php?model=newProduct&action=save',
					waitMsg:'正在更新产品资料',
					params:'',
					method:'post',success:function(form,action){
						if(action.result.success){
							Ext.example.msg('MSG','新增产品成功');
							window.location.href='index.php?model=newProduct&action=addProduct&goods_id='+action.result.msg;
						}else{
							Ext.Msg.alert('新增产品失败',action.result.msg);
						}
					},
					failure:function(form,action){
						Ext.Msg.alert('新增产品失败',action.result.msg);
					}});
			}else{
				Ext.example.msg('ERROR','请正确完成表单内容');
			}
		},
		formreset:function(){
			this.form.reset();
		},
		formsubmit:function(){
			Ext.fly('status').dom.value=2;
			this.formsave();
		},
		afterselect:function(k,v){
			Ext.getCmp('cat_name').setValue(v);
			Ext.getCmp('cat_id').setValue(k);
		}
});