<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var info = eval(<!--{$info}-->);
    var simple = new Ext.form.FormPanel({
        renderTo: document.body,
        title   : '热销产品分级',
		buttonAlign:'center',
		frame:true,
        autoHeight: true,
        width   : 600,
        bodyStyle: 'padding: 5px',
        defaults: {
            anchor: '0'
        },
		items   : [{
                xtype: 'compositefield',
                fieldLabel: '销售时间段',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [{xtype: 'displayfield', value: 'FROM:',width:45},
                    {
                        xtype: 'datefield',
						format:'Y-m-d',
						width:100,
						value:info.starttime,
                        name : 'starttime'
                    },{xtype: 'displayfield', value: 'TO:',width:25},
                    {
                        xtype: 'datefield',
						format:'Y-m-d',
						width:100,
						value:info.totime,
                        name : 'totime'
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'A',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'af',
						value:info.af,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'ae',
						value:info.ae,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'B',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'bf',
						value:info.bf,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'be',
						value:info.be,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'C',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'cf',
						value:info.cf,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'ce',
						value:info.ce,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'D',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'df',
						value:info.df,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'de',
						value:info.de,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'E',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'ef',
						value:info.ef,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'ee',
						value:info.ee,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'F',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'ff',
						value:info.ff,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'fe',
						value:info.fe,
						width:50
                    }
                ]
            },{
                xtype: 'compositefield',
                fieldLabel: 'G',
                msgTarget : 'side',
                anchor    : '-20',
                defaults: {
                    flex: 1
                },
                items: [
                    {
						xtype:'textfield',
                        name : 'gf',
						value:info.gf,
						width:50
                    },{xtype: 'displayfield', value: '-',width:5},
                    {
						xtype:'textfield',
                        name : 'ge',
						value:info.ge,
						width:50
                    }
                ]
            }],
	buttons: [{
				text: '启动分级',
				type: 'submit', 
				handler:function(){
					simple.form.submit({
					url:'index.php?model=goods&action=savegrade',
					waitMsg: '正在更新产品分级',
					method:'post',
					success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('MSG','产品分级成功');
									} else {
										Ext.Msg.alert('产品分级失败',action.result.msg);
							 		}
							 },
					failure:function(form,action){
									Ext.Msg.alert('产品分级失败',action.result.msg);
					}
				});
				}
			}]
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
