<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = object_Array([<!--{$account}-->]);
    Ext.QuickTips.init();
    var top = Ext.create('Ext.form.Panel',{
		id:'loadform',
        buttonAlign:'center',
        align:'left',
		labelWidth:70,
        frame:false,
		border:false,
		renderTo:document.body,
		width:950,
        items: [{
				layout:'column',
				border:false,
				items:[
					{
			columnWidth:.18,
			border:false,
			id:'loadstatus',
			items:[{
				xtype:'checkbox',
				fieldLabel: '已上架销售中',
				checked:true,
				name:'onSelling',
				labelWidth:100,
				},{
				xtype:'checkbox',
				fieldLabel: '已下架产品',
				checked:true,
				name:'offline',
				labelWidth:100,
				},{
				xtype:'checkbox',
				fieldLabel: '审核中',
				name:'auditing',
				checked:true,
				labelWidth:100,
				},{
				xtype:'checkbox',
				fieldLabel: '审核不通过',
				checked:true,
				name:'editingRequired',
				labelWidth:100,
			}]
		},{
			columnWidth:.4,
			border:false,
			items:[{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "account_name"],
					 data: [<!--{$account}-->]
				}),
				valueField :"id",
				displayField: "account_name",
				labelWidth:100,
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'id',
				width:300,
				fieldLabel: 'Aliexpress账号',
				emptyText:'选择Aliexpress账号',
				name: 'id',
				allowBlank:false,
				blankText:'请选择'
			}
				]},{
			columnWidth:.42,
			border:false,
			id:'cleargoods',
			items:[/*{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					 fields: ["id", "account_name"],
					 data: [<!--{$account}-->]
				}),
				valueField :"id",
				displayField: "account_name",
				labelWidth:130,
				mode: 'local',
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'id',
				width:300,
				fieldLabel: '清空账号本地产品',
				emptyText:'选择Aliexpress账号',
				name: 'aid',
				id:'clearAccount',
				allowBlank:false,
				blankText:'请选择'
			},*/
			{
				xtype:'button',
				text:'清空本地产品',
				id:'clearbtn',
				hidden:true,
				handler:function(){
					//if(!Ext.getCmp('clearAccount').getValue()); return false;
					Ext.Msg.show({
						title:'Clear Products?',
						msg:'Are you sure to Clear this All Products?',
						buttons:Ext.Msg.YESNO,
						icon:Ext.MessageBox.ERROR,
						fn:function(btn){
							if (btn == 'yes') {
							var sb = Ext.getCmp('basic-statusbar');
							sb.showBusy();
							sb.setText('正在清空产品,可能需要花费数分钟时间,请耐心等候..');
							Ext.getCmp('clearbtn').disable();
							var str = '';
							Ext.Ajax.request({
								url:'index.php?model=aliexpress&action=clearGoods&id=0',	 
								params:'',       
                                timeout: 45000,
								success:function(response,opts){
									var res = Ext.decode(response.responseText);
									if(res.success){
										sb.setStatus({
											text: res.msg,
											iconCls: 'x-status-valid',
											clear: false
										});
										Ext.getCmp('clearbtn').enable();
									}else{
										sb.setStatus({
											text: res.msg,
											iconCls: 'x-status-error',
											clear: true
										});
										Ext.getCmp('clearbtn').enable();
									}
								},
								failure:function(response){
										Ext.getCmp('btn').enable();
										sb.setStatus({
											text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
											iconCls: 'x-status-error',
											clear: false
										});
									}
							})							}
									}
								});
				}
			}]}
		]}
		],
        buttons: [{
            text: '开始同步',
			id:'btn',
			handler:function(){
				if(top.form.isValid()){
					var account_name = account[top.getForm().getFieldValues().id];
					var sb = Ext.getCmp('basic-statusbar');
                    sb.showBusy();
					sb.setText('正在同步产品,若商品较多,可能需要花费数分钟时间,请耐心等候..');
					Ext.getCmp('btn').disable();
					var str = '';
					str += "&onSelling="+top.getForm().getFieldValues().onSelling;
					str += "&offline="+top.getForm().getFieldValues().offline;
					str += "&auditing="+top.getForm().getFieldValues().auditing;
					str += "&editingRequired="+top.getForm().getFieldValues().editingRequired;
					//alert(top.getForm().getFieldValues().loadgood);return;
					str += "&isload="+top.getForm().getFieldValues().loadgood;
					var id = top.getForm().getFieldValues().id;
					Ext.Ajax.request({
						url:'index.php?model=aliexpress&action=LoadGoods&id='+id+str,	 
						params:'',
						timeout: 300000,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
                           
							if(res.success){
								sb.setStatus({
									text: res.msg,
									iconCls: 'x-status-valid',
									clear: false
								});
								Ext.getCmp('btn').enable();
							}else{
								sb.setStatus({
									text: res.msg,
									iconCls: 'x-status-error',
									clear: true
								});
								Ext.getCmp('btn').enable();
							}
						},
						failure:function(response){
								Ext.getCmp('btn').enable();
								sb.setStatus({
									text: '可能因为网络繁忙,您的请求已超时...请稍后重试.',
									iconCls: 'x-status-error',
									clear: false
								});
							}
					})
				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }/*,{
        	text: '查看同步记录',
			handler:function(){top.form.reset();}
        }*/]
    });
	Ext.create('Ext.Panel', {
        title: 'Basic StatusBar',
		renderTo:document.body,
        width: 950,
        title: '同步产品',
		style:'margin:10px',
        manageHeight: false,
        bodyPadding: 10,
        items:[top],
        bbar: Ext.create('Ext.ux.StatusBar', {
            id: 'basic-statusbar',
			border:true,
			frame:true,
			//busyText:'',
            defaultText: 'Begin Loading',
            text: '',
            items: [
                /*{
                    xtype: 'button',
                    text: 'Show Warning & Clear',
                    handler: function (){
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.setStatus({
                            text: 'Oops!',
                            iconCls: 'x-status-error',
                            clear: true // auto-clear after a set interval
                        });
                    }
                },
                {
                    xtype: 'button',
                    text: 'Clear status',
                    handler: function (){
                        var sb = Ext.getCmp('basic-statusbar');
                        // once completed
                        sb.clearStatus(); 
                    }
                },
                '-',
                'Plain Text'*/
            ]
        })
    });
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
