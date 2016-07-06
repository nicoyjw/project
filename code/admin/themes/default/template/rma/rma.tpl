<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/rma/rma.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
var reason = [<!--{$reason}-->];
reason.push(['','所有原因'])
var sales_account = [<!--{$sales_account}-->];
sales_account.push(['0','所有帐户'])
	var arr = object_Array(reason);
	function showreason(val){
		return arr[val];
	}
	var RmaGrid = Ext.create('Ext.ux.RmaGrid',{
		title: 'RMA单据_列表',
		border:false,
		region:'center',
		loadMask: true,
		headers:['序号','RMA单据ID','订单号','重发订单号','账号','buyerID','原始订单发货日期','问题产品','数量','Reason','国家','退回方式','tracking','状态','退回时间','快递方式','追踪单号','实际重量','实际运费','订单总金额','退款金额','添加人','添加时间'],
		fields: ['id','rma_sn','order_sn','new_order_sn','Sales_account_id','userid','end_time','goods_sn','quantity','reason','country','return_form','tracking','rma_status','return_time','track_no','shipping_id','weight','shipping_cost','order_amount','refund','admin_id','remark','order_id','realstatus','addtime'],
		formitems:[{
				xtype:'hidden',
				name: 'id'
				},{
				name:'order_sn',
				fieldLabel:'订单号',
				width:'60%',
				allowBlank:false,
				blankText:'此项必填',
				listeners:{
					change:function(field,e){
						Ext.Ajax.request({
							url: 'index.php?model=rma&action=ckordersn&order_sn='+field.getValue(),
							success: function(response){
								var result =Ext.decode(response.responseText);
								if(result.success==false){
									Ext.example.msg('提示',result.msg);
									Ext.getCmp('country').setValue('');
									field.setValue('');
								 }else{
									Ext.getCmp('country').setValue(result.msg); 
								}
							}
						});
					}
				}
				},
				{
				name:'country',
				id:'country',
				fieldLabel:'国家',
				readOnly:true,
				allowBlank:false,
				width:'60%'
				},{
				name:'goods_sn',
				fieldLabel:'SKU',
				width:'60%'
				},Ext.create('Ext.form.field.ComboBox',{
				store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						data: reason
						}),
					valueField :"id",
					displayField: "key_type",
				  mode: 'local',
				  allowBlank:false,
				  blankText:'不能为空',
				  editable: false,
				  forceSelection: true,
				  triggerAction: 'all',
				  hiddenName:'reason',
				  fieldLabel: 'Reason',
				  emptyText:'选择',
				  name: 'reason_id'
			}),
			{
			name:'quantity',
			xtype:'numberfield',
			minText:'数量不能小于1',
			minValue:1,
			fieldLabel:'数量',
			width:'60%'
			},			
			{
			name:'return_form',
			fieldLabel:'退回方式',
			width:'60%'
			},
			{
			name:'Tracking',
			fieldLabel:'tracking',
			width:'60%'
			},
			{
			name:'return_time',
			fieldLabel:'退回时间',
			xtype:'datefield',
			format:'Y-m-d',
			invalidText:'格式错误！',
			width:'60%'
			},
			{
			name:'remark',
			fieldLabel:'备注',
			xtype:'textarea',
			width:'60%'
			}
			],
		renderers:showreason,
		saveURL:'index.php?model=rma&action=save',
		delURL:'index.php?model=rma&action=Delete',
		listURL:'index.php?model=rma&action=list',
		windowTitle:'编辑RMA信息',
		sales_account:sales_account,
		reason:reason,
		pagesize:15,
		windowWidth:500,
		windowHeight:350,
	});
	var viewport =  Ext.create('Ext.Viewport',{
        layout:'border',
        items:[
			RmaGrid
		]}
	);
	RmaGrid.getStore().load({
		params:{start:0,limit:RmaGrid.pagesize}
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->