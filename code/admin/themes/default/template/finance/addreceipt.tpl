<!--{include file="header.tpl"}-->
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var powerBank =[<!--{$powerBank}-->];
	var info =  eval(<!--{$order}-->);
	info=info?info:{};
	var rfform = new Ext.form.FormPanel({
		frame: true,
		defaultType: 'textfield',
		buttonAlign: 'center',
		labelAlign: 'right',
		labelWidth: 100,
		renderTo: document.body,
		items: [{
			xtype:'hidden',
			name: 'rec_id',
			value:info.rec_id
				},{
					fieldLabel: '关联单号',
					name: 'relate_order_sn',
					value:info.relate_order_sn,
					allowBlank:false
				},{
					fieldLabel: '流水号',
					name: 'paypalid',
					value:info.paypalid,
				},{xtype:'combo',
					store: new Ext.data.SimpleStore({
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
					fieldLabel: '收款账户',
					emptyText:'选择账户',
					id:'account_id',
					allowBlank:false,
					width: 135,
					value:info.account_id
	             },{
					fieldLabel: '币种',
					name: 'currency',
					value:info.CURRENCYCODE?info.CURRENCYCODE:'CNY'
				},{
					xtype:'numberfield',
					decimalPrecision:4,
					allowDecimals:true,
					fieldLabel: '手续费',
					name: 'feeamt',
					value:info.FEEAMT
				},{
					xtype:'numberfield',
					decimalPrecision:4,
					allowDecimals:true,
					fieldLabel: '总金额',
					name: 'amt',
					value:info.AMT
				},{
					xtype:'numberfield',
					decimalPrecision:4,
					allowDecimals:true,
					fieldLabel: '实收金额',
					name: 'paid_money',
					value:info.paid_money
				},{
					fieldLabel: '收款时间',
					xtype:'datefield',
					format:'Y-m-d',
					name: 'paid_time',
					width: 135,
					value:info.ORDERTIME
				},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
						 fields: ["id", "key_type"],
						 data: [<!--{$payment}-->]
					}),
					width: 135,
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'payment_id',
					fieldLabel: '收款方式',
					emptyText:'收款方式',
					value:info.payment_id,
					id:'fee_type'
				},{
			xtype:'textarea',
			width:135,
			fieldLabel: '备注',
			name: 'comment',
			value:info.note
				}],
		  buttons: [{
                text: '保存',
              	handler:function(){
					if(rfform.form.isValid()){
						rfform.form.doAction('submit',{
							 url:'index.php?model=finance&action=saverf',
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
