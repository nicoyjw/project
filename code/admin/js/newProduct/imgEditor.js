Ext.ux.imgGrid=Ext.extend(Ext.ux.NormalGrid,{
	initComponent:function(){Ext.ux.imgGrid.superclass.initComponent.call(this);},
	createStore:function(){
		this.store=new Ext.data.Store({proxy:new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
		reader:new Ext.data.JsonReader({root:'topics',totalProperty:'totalCount',id:this.fields[0]},this.fields)});
		this.store.on('beforeload',function(){Ext.apply(this.baseParams);});},
	createTbar:function(){
		var store=this.store;var pagesize=this.pagesize;
		this.tbar=[{text:'创建',iconCls:'x-tbar-add',handler:this.createRecord.createDelegate(this)},
		{text:'编辑',iconCls:'x-tbar-update',ref:'../editBtn',disabled:true,handler:this.updateRecord.createDelegate(this)},
		{text:'删除',iconCls:'x-tbar-del',ref:'../removeBtn',disabled:true,handler:this.removeRecord.createDelegate(this)}];},
	createColumns:function(){
	 this.columns = [
	 		{header:'产品图片',dataIndex:'url',width:120,renderer:function(v){return'<img src='+v+' width=100 height=100>';}},
			{header:'图片类型',dataIndex:'img_assign'},
			{header:'图片地址',dataIndex:'url',width:200},
			{header:'操作员',dataIndex:'add_user'},
			{header:'更新时间',dataIndex:'add_time'}];}
		});
// JavaScript Document
Ext.ux.addimgForm=Ext.extend(Ext.FormPanel,{
		initComponent:function(){
			this.frame=true,
			this.autoHeight=true,
			this.buttonAlign='center',
			this.creatItems();
			this.creatButtons();
			Ext.ux.addimgForm.superclass.initComponent.call(this);
		},
		creatItems:function(){
			var imgGrid=this.imgGrid;
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
				{layout:'form',items:[imgGrid,{html:'<br />'},this.good.goods_audit?{fieldLabel:'已审意见',html:this.good.goods_audit}:{}]}];
		},
		creatButtons:function(){
			this.buttons=[{text:'提交审核',type:'submit',handler:this.formsubmit.createDelegate(this)}];},
		formreset:function(){
			this.form.reset();
		},
		formsubmit:function(){
			Ext.Ajax.request({
			url:'index.php?model=newProduct&action=updateStatusList',
			params:{
				goods_id:this.good.goods_id,
				action_type:this.action_type
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