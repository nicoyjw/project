<!--{include file="header.tpl"}-->
<script type="text/javascript">
//Ext.util.CSS.swapStyleSheet("theme", "ext/resources/css/xtheme-" + themeName + ".css");

Ext.onReady(function(){
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	var one_rma_info;
	var reason=['Customer Error','Quality Error'];
	Ext.Ajax.request({
		url: 'index.php?model=rma&action=GetInfo&id='+'<!--{$smarty.get.id}-->',
		success: function(response){
			one_rma_info =Ext.decode(response.responseText);
			//alert(one_rma_info.order_id)
			rma_form.getForm().setValues({
			order_id : one_rma_info.order_id,
			country  : one_rma_info.country,
			reason   : reason[one_rma_info.reason],
			tracking : one_rma_info.tracking,
			return_form : one_rma_info.return_form,
			return_time :  one_rma_info.return_time,
			remark : one_rma_info.remark
			});
		}
	});
    var rma_form =new  Ext.FormPanel({
        labelWidth: 75, // label settings here cascade unless overridden
        url:'index.php?model=rma&action=save',
        frame:false,
        bodyStyle:'padding:5 5 5 5',
		border:false,
        defaultType: 'textfield',
		defaults:{
		width:'60%'
		},
        items: [{
                fieldLabel: '订单号',
                name: 'order_id',
                allowBlank:false/*,
				value:one_rma_info.order_id*/
            },{
                fieldLabel: '国家',
                name: 'country'
            },{
				xtype:'combo',
				mode:'local',
				triggerAction:'all',
				forceSelection: true,
				editable: false,
                fieldLabel: 'Reason',
				valueField: 'reason',
				displayField:'name',
				hiddenName:'reason',
				value:'0',
                name: 'reason',
				store: new Ext.data.JsonStore({
                                    fields : ['name', 'reason'],
                                    data   : [
                                        {name : 'Customer Error', reason: '0'},
                                        {name : 'Quality Error',  reason: '1'}
                                    ]
                })
            }, {
                fieldLabel: 'return_form',
                name: 'return_form'
            }, {
                fieldLabel: 'Rracking',
                name: 'tracking'
            }
			, {
                fieldLabel: '退回时间',
				xtype:'datefield',
                name: 'return_time',
				format:'Y-m-d',
				invalidText:'格式错误！'
            },{
                fieldLabel: '备注',
				xtype:'textarea',
                name: 'remark'
			},
			{
				xtype:'hidden',
				name: 'id',
				value: '<!--{$smarty.get.id}-->'
			}
        ],

        buttons: [{
            text: '提交',
			handler: function() {
                    
					  Ext.MessageBox.alert('提示', '修改成功！',function(){
					  rma_form.getForm().submit({
					  	success:function(){}
					  });
					  });
           }//end handler
        },{
            text: '重设',
			handler:function(){
				rma_form.getForm().reset();
			}
        }]
    });
	var viewport = new Ext.Viewport({
        layout:'border',
        items:[
			{
			region:'center',
			border:false,
			items:rma_form
			}
		]
		});
		loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->