Ext.ux.ReturnGrid = Ext.extend(Ext.grid.GridPanel, {
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		//this.loadMask = true;
		this.pagesize = 10,
        this.createStore();
		this.createFormtiems();
        this.createBbar();
        this.createColumns();
        Ext.ux.ReturnGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
	},
	createColumns: function() {
		var ds = this.store;
        var cols = [new Ext.grid.RowNumberer(),{
						header: '换货单据ID',
						dataIndex: 'return_sn',
						width:128,
					   renderer:function(val,x,rec){
							var str = (rec.get('remark'))?'<img src="themes/default/images/comment.gif" title="'+rec.get('remark') + '">':'';
							return '<b>'+val+'</b>' + str ;
						   }
					},{
					header: 'RMA单据ID',
					dataIndex: 'rma_sn'
					},{
						header: '原始订单号',
						dataIndex: 'order_sn'
					},{
						header: '新订单号',
						dataIndex: 'new_order_sn'
					},{
				  header:'操作',
				  width:20,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/drop-add.gif',	 
						tooltip: '增加订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'新建订单','index.php?model=order&action=add&id='+id,1000,680);						
						}
						 }],
			renderer:function(v,m,rec){
				if(rec.get('new_order_sn') != '') {
					this.items[0].iconCls ='hidden';
					}else{
					this.items[0].iconCls ='';
					}
				}
				  }];
        this.columns = cols;
    },
    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    },
	createFormtiems:function(){
		this.formitem = this.formitems;
	},
	change_status:function(id,status_num){
	var thiz = this;
	Ext.Ajax.request({
		url: 'index.php?model=rma&action=changestatus&id='+id+'&status='+status_num,
		success: function(response){
			var result =Ext.decode(response.responseText);
			if(result.success==true){
					  this.store.reload();
			 }
		}
	});
	}
});
//换货处理
Ext.ux.ReturnGrid.huanhuo=function(rec,yds){//$id,$status_num
	var win,huanhuo_form;
	huanhuo_form =new  Ext.FormPanel({
		labelWidth: 75,
		url:'index.php?model=rma&action=addHuanhuo',
		frame:false,
		bodyStyle:'padding:5 5 5 5',
		height:250,
		width: 400,
		defaultType: 'textfield',
		defaults:{
		width:'60%'
		},
		items: [{
				fieldLabel: '换货单据ID',
				name: 'huanhuo_sn',
				allowBlank:false
			},{
				fieldLabel: 'RMA单据ID',
				name: 'huanhuo_rma_sn',
				value:rec.get('rma_sn'),
				allowBlank:false
			}, {
				fieldLabel: '原始订单号',
				name: 'huanhuo_order_sn',
				value:rec.get('order_sn'),
				allowBlank:false
			}, {
				fieldLabel: '新订单号',
				name: 'new_order_sn'
			}
			, {
				fieldLabel: '处理时间',
				xtype:'datefield',
				name: 'deal_time',
				format:'Y-m-d',
				invalidText:'格式错误！'
			},{
				fieldLabel: '备注',
				xtype:'textarea',
				name: 'huanhuo_remark'
			}
		],

		buttons: [{
			text: '提交',
			handler: function() {
					
					  Ext.MessageBox.alert('提示', '操作成功！',function(){
					  huanhuo_form.getForm().submit({
					  success:function(){Ext.ux.RmaGrid.change_status(rec.get('id'),1);yds.reload();}
					  });
					  win.hide();
					  });
		   }//end handler
		},{
			text: '重设',
			handler:function(){
				huanhuo_form.getForm().reset();
			}
		}]
	});
	if(!win){
		win = new Ext.Window({
			title:'换货单据_添加',
			layout:'fit',
			width:500,
			height:330,
			closeAction:'hide',
			plain: true,
			collapsible:true,
			items:huanhuo_form
		});
	}
	win.show();
}
