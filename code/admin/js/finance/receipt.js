Ext.define('Ext.ux.ReceiptGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createTbar:function(){
		var listURL=this.listURL;
		var store=this.store;var pagesize=this.pagesize;
		this.tbar=[{text:'创建',iconCls:'x-tbar-add',handler:this.addItem.bind(this)},
		{text:'编辑',iconCls:'x-tbar-update',id:'editBtn',ref:'../editBtn',disabled:true,handler:this.addItem.bind(this,['edit'])},
		{text:'删除',iconCls:'x-tbar-del',id:'removeBtn',ref:'../removeBtn',disabled:true,handler:this.removeRecord.bind(this)},
		{text:'确认账单',iconCls:'x-tbar-accept',handler:this.confirms.bind(this,['1'])},
		{text:'付款完成',iconCls:'x-tbar-accept',handler:this.confirms.bind(this,['2'])},
		'->',{
						xtype:'datefield',
						id:'starttime',
						format:'Y-m-d',
						width:150,
						labelWidth:35,
						fieldLabel:'From',
						invalidText:'格式错误！'
					},'-',{
						xtype:'datefield',
						id:'totime',
						width:150,
						labelWidth:35,
						format:'Y-m-d',
						fieldLabel:'To',
						invalidText:'格式错误！'
					},'-', {
            xtype: 'button',
            text: '搜索',
            iconCls: 'x-tbar-search',
            handler: function() {
                store.load({
                    params: {
                        start: 0,
                        limit: pagesize,
						starttime:Ext.fly('starttime').dom.value,
						totime:Ext.fly('totime').dom.value
                    }
                });
            }
        },
		'-',{
			text:'导出',
			xtype:'button',
			iconCls:'x-tbar-import',
			handler:function(){
				window.open().location.href=listURL+'&type=export&starttime='+Ext.fly('starttime').dom.value+'&totime='+Ext.fly('totime').dom.value;
			}
		}];},
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
						header: '收款单号',
						dataIndex: 'order_sn',
						width:120,
					    renderer:function(val,x,rec){
					   	var str = (rec.get('comment'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('comment') + '">':'';
					   	return '<b>'+val+'</b>' + str ;
					   }
					},{
						header: '关联单号',
				   		flex:1,
						dataIndex: 'relate_order_sn'
					},{
						header: '账号',
				   		flex:1,
						dataIndex: 'account_id'
					},{
						header: '付款方式',
				   		flex:1,
						dataIndex: 'payment'
					},{
						header: '流水号',
				   		flex:1,
						dataIndex: 'paypalid'
					},{
						header: '币种',
				   		flex:1,
						dataIndex: 'currency'
					},{
						header: '手续费',
				   		flex:1,
						dataIndex: 'feeamt'
					},{
						header: '总金额',
				   		flex:1,
						dataIndex: 'amt'
					},{
						header: '实收金额',
				   		flex:1,
						dataIndex: 'paid_money'
					},{
						header: '收款时间',
				   		flex:1,
						dataIndex: 'paid_time'
					},{
						header: '状态',
				   		flex:1,
						dataIndex: 'status'
					},{
						header: '创建人',
				   		flex:1,
						dataIndex: 'add_user'
					},{
						header: '创建时间',
				   		flex:1,
						dataIndex: 'add_time'
					},{
						header: '收款人',
				   		flex:1,
						dataIndex: 'confirm_user'
					},{
						header: '收款完成时间',
				   		flex:1,
						dataIndex: 'confirm_time'
					}];
        this.columns = cols;
    },
    addItem:function (action) {
		if (action=='edit') {
			var id = getId(this);
			if (!id) {
				Ext.Msg.alert('出错啦','你还没有选择要操作的记录！');
				return;
			}
			var r = this.getSelectionModel().getSelection();
			if(r.data.status&&r.data.status!=''&&r.data.status!='未确认款项'){
				Ext.example.msg('提示','该单据已确认完成！');
				return false;
			}
			parent.openWindow(id, '编辑收款单', this.addURL+'&id='+id,300,380);
		} else {
			parent.openWindow(id, '添加收款单', this.addURL,300,380);
		}
	},
	confirms:function(status){
		var ids=getIds(this);
		if(ids==null)return false;
		var store=this.store;
		var r = this.getSelectionModel().getSelection();
		Ext.Msg.confirm('提示!','是否确定?',function(btn){
			if(btn=='yes'){
				Ext.Ajax.request({
					url:'index.php?model=finance&action=updateConfirm&id='+r.data.rec_id+'&status='+status+'&deal_type='+0,
					success:function(response,opts){
						var res=Ext.decode(response.responseText);
						if(res.success){
							Ext.example.msg('MSG',res.msg);store.reload();
						}else{
							Ext.Msg.alert('ERROR',res.msg);
						}
					}});
			}
		},this);
	}
});

