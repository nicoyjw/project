<!--{include file="header.tpl"}-->
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var fee_type = [<!--{$fee_type}-->];
	var powerBank =[<!--{$powerBank}-->];
	var info =  eval(<!--{$order}-->);
     var feeform = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
			renderTo: document.body,
		    labelWidth: 70,
            items:[{xtype:'combo',
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
					fieldLabel: '账户',
					emptyText:'选择账户',
					id:'account_id',
					width: 145,
					value:info.account_id
	                },{
				xtype:'hidden',
                name: 'rec_id',
				value:info.rec_id
					},{
				xtype:'numberfield',
				decimalPrecision:4,
				allowDecimals:true,
                fieldLabel: '总金额',
                name: 'amt',
				width: 145,
				value:info.amt
					},{
				fieldLabel: '币种',
				name: 'currency',
				width: 145,
				value:info.currency?info.currency:'CNY'
					},{
	                    xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: fee_type
						}),
	                    valueField :"id",
	                    displayField: "key_type",
						width: 145,
	                    mode: 'local',
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'fee_type',
	                    fieldLabel: '费用类型',
	                    emptyText:'费用类型',
						value:info.fee_type,
						id:'fee_type'
	                },{
				xtype:'textarea',
				width:160,
                fieldLabel: '备注',
                name: 'comment',
				value:info.comment
					}],
            buttons: [{
                text: '保存',
              	handler:function(){
					if(feeform.form.isValid()){
						feeform.form.doAction('submit',{
							 url:'index.php?model=finance&action=savefee',
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
                    feeform.getForm().reset();
                }
            }]
        });
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
