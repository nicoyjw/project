<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	var xlstype=[['0','标准格式'],['1','Amazon普通订单'],['2','AmazonFBA订单'],['5','Amazon未发货订单'],['3','速卖通订单'],['4','Yahoo订单']];
    var simple = Ext.create('Ext.form.Panel',{
        labelWidth: 75,
        frame:true,
        title: '<a style="color:#fff" href="common/lib/download/orderimport.xls">点击此处下载导入示例文件<b>Click here</b></a>',
		fileUpload:true,
        bodyStyle:'padding:5px 5px 0',
        width: 350,
        defaults: {width: 150},
        defaultType: 'textfield',
		renderTo:document.body,
        items: [{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data:[<!--{$allaccount}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
			width:280,
	        fieldLabel: '账号',
	        emptyText:'选择账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
		},{
			xtype:'combo',
			store:Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data:[<!--{$Sales_channels}-->]
					}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:280,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'Sales_channels',
			name: 'Sales_channels',
			allowBlank:false,
			value:1,
			fieldLabel: '销售渠道'
		},{
			xtype:'combo',
			store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: [<!--{$payment}-->]
					}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:280,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'payment',
			name: 'payment',
			allowBlank:false,
			value:1,
			fieldLabel: '支付方式'
		},{
			xtype:'combo',
			store:  Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "key_type"],
					 data: xlstype
					}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:280,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'type',
			name: 'type',
			allowBlank:false,
			value:0,
			fieldLabel: '格式'
		},{
			fieldLabel: '订单文件',
			width:280,
			xtype: 'fileuploadfield',
			allowBlank:false,
			name:'file_path'
		}],

        buttons: [{
				text: '导入',
				type: 'submit',
				handler:function(){formsubmit();}
			}]
    });
	var formsubmit = function(){
		if(simple.getForm().isValid()){
			simple.getForm().submit({
				 url:'index.php?model=order&action=upload',
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
<p><b>温馨提示:导入订单前清选择对应的账号进行导入</b></p>
<!--{include file="footer.tpl"}-->
