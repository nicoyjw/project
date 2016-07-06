<!--{include file="header.tpl"}-->
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	var powerBank =[<!--{$powerBank}-->];
	var info =  eval(<!--{$order}-->);
        var rfform = Ext.create('Ext.form.FormPanel',{
            frame: false,
			border:false,
            defaultType: 'textfield',
            buttonAlign: 'center',
			autoHeight:true,
			padding:5,
			autoWidth:true,
            labelAlign: 'right',
			renderTo: document.body,
            items: [{
				xtype:'hidden',
                name: 'rec_id',
				value:info.rec_id
					},{
						fieldLabel: '关联单号',
						name: 'relate_order_sn',
           				labelWidth: 70,
						width:250,
						value:info.relate_order_sn,
						allowBlank:false
					},{
						fieldLabel: '流水号',
						name: 'paypalid',
           				labelWidth: 70,
						width:250,
						value:info.paypalid
					},{xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: powerBank
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'account_id',
					fieldLabel: '付款账户',
					emptyText:'选择账户',
					id:'account_id',
					name:'account_id',
					allowBlank:false,
					labelWidth: 70,
					width:200,
					value:info.account_id
	             },{
						fieldLabel: '币种',
						name: 'currency',
           				labelWidth: 70,
						width:150,
						value:info.CURRENCYCODE?info.CURRENCYCODE:'CNY'
					},{
					xtype:'numberfield',
					decimalPrecision:4,
           				labelWidth: 70,
						width:120,
					allowDecimals:true,
					fieldLabel: '总金额',
					name: 'amt',
					value:info.AMT
				},{
						fieldLabel: '付款时间',
						xtype:'datefield',
						format:'Y-m-d',
						name: 'paid_time',
           				labelWidth: 70,
						width:200,
						value:info.ORDERTIME
					},{
	                    xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: [<!--{$payment}-->]
						}),
	                    valueField :"id",
	                    displayField: "key_type",
	                    mode: 'local',
	                    editable: false,
           				labelWidth: 70,
						width:200,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'payment_id',
	                    fieldLabel: '付款方式',
	                    emptyText:'root',
						value:'1',
						id:'fee_type'
	                },{
				xtype:'textarea',
				labelWidth: 70,
				width:250,
                fieldLabel: '备注',
                name: 'comment',
				value:info.note
					}],
            buttons: [{
                text: '保存',
              	handler:function(){
					if(rfform.form.isValid()){
						rfform.form.doAction('submit',{
							 url:'index.php?model=finance&action=savegf',
							 method:'post',
							 success:function(form,action){
									if (action.result.success) {
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
									}
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
					  });
					}					
				}
            }, {
                text: '重置',
                handler: function() {
                    rfform.getForm().reset();
                }
            }]
        });
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
