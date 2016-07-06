Ext.ux.adddesForm=Ext.extend(Ext.FormPanel,{
		initComponent:function(){
			this.frame=true,
			this.autoHeight=true,
			this.buttonAlign='center',
			this.creatItems();
			this.creatButtons();
			Ext.ux.adddesForm.superclass.initComponent.call(this);
		},
		creatItems:function(){
			var depict=this.depict;
			this.items=[
				{layout:'column',items:[
					{xtype:'hidden',id:'goods_id',value:this.good.goods_id},
					{columnWidth:.33,layout:'form',defaultType:'textfield',
					items:[ 
						{xtype:'label', height:200,html:'<div style="width:100%;vertical-align:middle" align="center" height="200"><img width="150" height="150" src="'+(this.good.goods_img?this.good.goods_img:'')+'"/></div>'}]},
					{columnWidth:.66,layout:'form',defaultType:'label',
					items:[
						{fieldLabel:'sku',text:this.good.sku},
						{fieldLabel:'产品名称',text:this.good.goods_name},
						{fieldLabel:'产品连接',html:this.good.goods_url?'<a target="_blank" href="'+this.good.goods_url+'" >'+this.good.goods_url+'</a>':''},
						{fieldLabel:'产品品牌',text:this.good.brand_name},
						{fieldLabel:'所属分类',text:this.good.cat_name},
						{fieldLabel:'产品价格',text:this.good.price},
						{fieldLabel:'产品规格',html:'长：'+this.good.l+'&nbsp;&nbsp;宽：'+this.good.w+'&nbsp;&nbsp;高：'+this.good.h},
						{fieldLabel:'产品重量',html:'净重：'+this.good.suttle+'&nbsp;&nbsp;毛重：'+this.good.weight},
						{fieldLabel:'产品颜色',text:this.good.colors},
						{fieldLabel:'尺码选择',text:this.good.sizes}
						]}
					]},
				{layout:'form',defaultType:'label',items:[{html:'<hr style="color:#FFF">'}]},
				{layout:'form',defaultType:'label',items:[
					{fieldLabel:'产品标题',text:this.good.goods_title},
					{fieldLabel:'产品属性',text:this.good.goods_attribute},
					{fieldLabel:'产品简述',text:this.good.resume},
					{fieldLabel:'产品描述',html:this.good.depict},
					{fieldLabel:'备注',text:this.good.comment},
					]},
				{layout:'form',items:[depict,{html:'<br />'},this.good.goods_audit?{fieldLabel:'已审意见',html:this.good.goods_audit}:{}]}];
		},
		creatButtons:function(){
			this.buttons=[{text:'保存',type:'submit',handler:this.formsave.createDelegate(this)},{text:'提交审核',type:'submit',handler:this.formsubmit.createDelegate(this)}];},
		formsave:function(){
			var depict=this.depict;
			var type=this.type;
			Ext.Ajax.request({
			url:'index.php?model=newProduct&action=saveDes',
			params:{
				des_text:depict.getValue(),
				goods_id:this.good.goods_id,
				action_type:this.action_type,
				type:type
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','提交审核失败');
				Ext.getBody().unmask();
				}		 
			});
		},
		formsubmit:function(){
			var depict=this.depict;
			if(depict.getValue()=='' || depict.getValue()==null){
				Ext.example.msg('提示:','未添加描述不得进行提交!');
				return;
			}
			Ext.Ajax.request({
			url:'index.php?model=newProduct&action=auditGoods',
			params:{
				goods_id:this.good.goods_id,
				action_type:this.action_type,
				des_text:depict.getValue(),
				type:this.type
				},
			success:function(response){
				Ext.example.msg('提示',response.responseText);
				Ext.getBody().unmask();
				},
			failure:function(response){
				Ext.example.msg('警告','提交审核失败');
				Ext.getBody().unmask();
				}		 
			});
		}
});