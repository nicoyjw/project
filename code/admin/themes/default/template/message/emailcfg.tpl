<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/message/emailcfg_form.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();

    Ext.form.Field.prototype.msgTarget = 'side';

	var ds = new Ext.data.Store({
		autoLoad:true,
		proxy : new Ext.data.HttpProxy({url:'index.php?model=message&action=emaillist'}),
		reader: new Ext.data.JsonReader({
			//root: 'topics',
			id: 'emailcfg_id'
			},['emailcfg_id','email','in_server_addr','in_port','in_protocol','out_server_addr','out_port','out_protocol','addtime','remark']
			)
	});
	

	function render_email(value, metaData, record){
		if(record.get('remark')!='')
		return value+'<img src="themes/default/images/comment.gif" title="'+record.get('remark')+'" style="cursor:pointer"/>';
		else 
		return value;
	}
    var colModel = new Ext.grid.ColumnModel([
        {id:'email_fld',header: "邮箱", width: 160, sortable: true, locked:false, dataIndex: 'email',renderer:render_email},
        {header: "收件服务器", width: 150, dataIndex: 'in_server_addr'},
        {header: "发件服务器", width: 150, dataIndex: 'out_server_addr'},
		{header: '操作',width:56,xtype: 'actioncolumn',sortable: false,items:[{
						icon   : 'themes/default/images/drop-add.gif',
						tooltip: '加载邮件',
						handler: function(grid, rowIndex, colIndex) {
							var rec = ds.getAt(rowIndex);
							gridForm.loadEmailHeader(rec.get('email'));
						}}
						]}
    ]);

    var gridForm = new Ext.FormPanel({
        id: 'email_form',
		url:'index.php?model=message&action=addmodemail',
		region:'center',
        frame: true,
        labelAlign: 'left',
        title: '<b>邮箱(列表/设置)</b>',
        bodyStyle:'padding:5px',
        layout: 'column',   
        items: [{
            columnWidth: 0.60,
            layout: 'fit',
            items: {
				id: 'email_grid',
                xtype: 'grid',
                ds: ds,
                cm: colModel,
                sm: new Ext.grid.RowSelectionModel({
                    singleSelect: true,
                    listeners: {
                        rowselect: function(sm, row, rec) {
                            Ext.getCmp("email_form").getForm().loadRecord(rec);
							Ext.getCmp("email_form").getForm().findField('password').setValue('');
                        }
                    }
                }),
                autoExpandColumn: 'email_fld',
                height: 520,
                //title:'邮箱(列表)',
                border: true,
                listeners: {
                    viewready: function(g) {
                        g.getSelectionModel().selectRow(0);
                    }
                }
            }
        },{
            columnWidth: 0.4,
            xtype: 'fieldset',
            labelWidth: 60,
            title:'邮箱(修改/添加)',
            defaults: {width: 160, border:false},    
            defaultType: 'textfield',
            autoHeight: true,
            bodyStyle: Ext.isIE ? 'padding:0 0 5px 15px;' : 'padding:10px 15px;',
            border: false,
            style: {
                "margin-left": "10px", 
                "margin-right": Ext.isIE6 ? (Ext.isStrict ? "-10px" : "-13px") : "0"  
            },
            items: [{//form items
				name: 'emailcfg_id',
				xtype: 'numberfield',
				style:'display:none'
				},{
                fieldLabel: '邮箱',
                name: 'email',
				allowBlank:false,
				blankText:'不能为空',
				vtype:'email',
				vtypeText:'邮箱格式不正确！',
				listeners: {
					change:function(field,e){
						if(ds.find('email',field.getValue())==-1){
							Ext.getCmp("email_form").getForm().findField('emailcfg_id').setDisabled(true);
						}
						else{
							Ext.getCmp("email_form").getForm().findField('emailcfg_id').setDisabled(false);
						}
						
					}
				}				
            },{
                fieldLabel: '密码',
				inputType:'password',
                name: 'password'
            },{
				xtype: 'fieldset',
				labelWidth: 50,
				width:300,
				title: '收件服务器设置',
				border:true,
				collapsible: true,
				items: [
					{
						fieldLabel: '地址',
						xtype: 'textfield',
						name: 'in_server_addr'
					},{
						fieldLabel: '端口',
						value:143,
						xtype: 'numberfield',
						name: 'in_port',
					},new Ext.form.ComboBox({
				  store: new Ext.data.SimpleStore({
						fields: ["protocol_value", "protocol_name"],
						data: [['0','pop3'],['1','imap']]
						}),
				  width:143,
				  valueField :"protocol_value",
				  displayField: "protocol_name",
				  mode: 'local',
				  allowBlank:false,
				  blankText:'不能为空',
				  editable: false,
				  forceSelection: true,
				  triggerAction: 'all',
				  hiddenName:'in_protocol',
				  fieldLabel: '协议',
				  emptyText:'选择',
				  name: 'in_protocol'
				}),{
						fieldLabel: '&nbsp;SSL',
						//value:1,
						xtype: 'checkbox',
						name: 'in_ssl',
					},{
					text:'测试',
					width:30,
					style:'margin-top:10px;margin-left:56px',
					xtype:'button',
					handler: function() {
							if(Ext.getCmp("email_form").getForm().isValid()) {
									Ext.getCmp("email_form").getForm().submit({
										url: 'index.php?model=message&action=testinserver',
										success:function(form,action){
											if(action.result.success==true){
												  Ext.example.msg('提示',action.result.msg);
											 }
										}
									});						
							}
						}
				}
				]
			},{
				xtype: 'fieldset',
				labelWidth: 50,
				width:300,
				title: '发件服务器设置',
				border:true,
				collapsible: true,
				items: [
					{
						fieldLabel: '地址',
						xtype: 'textfield',
						name: 'out_server_addr'
					},{
						fieldLabel: '端口',
						value:25,
						xtype: 'numberfield',
						name: 'out_port'
					},new Ext.form.ComboBox({
				  store: new Ext.data.SimpleStore({
						fields: ["protocol_value", "protocol_name"],
						data: [['0','smtp']]
						}),
				  width:143,
				  valueField :"protocol_value",
				  displayField: "protocol_name",
				  mode: 'local',
				  allowBlank:false,
				  blankText:'不能为空',
				  editable: false,
				  forceSelection: true,
				  triggerAction: 'all',
				  hiddenName:'out_protocol',
				  fieldLabel: '协议',
				  emptyText:'选择',
				  name: 'out_protocol'
				}),{
					text:'测试',
					width:30,
					style:'margin-top:10px;margin-left:56px',
					xtype:'button',
					handler: function() {
							if(Ext.getCmp("email_form").getForm().isValid()) {
									Ext.getCmp("email_form").getForm().submit({
										url: 'index.php?model=message&action=testoutserver',
										success:function(form,action){
											if(action.result.success==true){
												  Ext.example.msg('提示',action.result.msg);
											 }
										}
									});						
							}
						}
				}
				]
			},{
				fieldLabel: '备注',
				xtype:'textarea',
				width:235,
				name: 'remark'
			},{
				xtype: 'fieldset',
				border:false,
				width:300,
				layout: 'column',
				columns:2,
				items:[
					{
					text:'修改',
					width:30,
					style:'margin-top:10px; margin-right:30px;margin-left:100px',
					xtype:'button',
					handler: function() {
							if(Ext.getCmp("email_form").getForm().isValid()) {
									Ext.getCmp("email_form").getForm().submit({
										success:function(form,action){
											if(action.result.success==true){
												  Ext.example.msg('提示','更新成功！');
												  form.findField('password').setValue('');
												  ds.reload()
											 }
										}
									});						
							}
						}
					},
					{
					text:'添加',
					width:30,
					style:'margin-top:10px',
					xtype:'button',
					handler: function() {
					//Ext.getCmp("email_form").getForm().findField('emailcfg_id')
							var form=Ext.getCmp("email_form").getForm();
							if (form.isValid()) {
								if(form.findField('emailcfg_id').disabled==true){
									form.submit({
										success:function(form,action){
											if(action.result.success==true){
												  Ext.example.msg('提示','添加成功！');
												  form.findField('password').setValue('');
												  ds.reload();
											 }
										}
									});						
								}
								else{
									Ext.example.msg('提示','该邮箱已存在！');
								}
							}
						}					
					}
				]
			}
			]//end form tiems
        }]
    });
	
	var viewport = new Ext.Viewport({
        layout:'border',
        items:[gridForm]
	});
	loadend();
	gridForm.loadEmailHeader=function(email){
		gridForm.cueinfo=Ext.MessageBox.progress('提示信息','正在加载……');
		Ext.Ajax.request({
			url: 'index.php?model=message&action=loademailheader&email='+email,
			success: function(response){
				var result =Ext.decode(response.responseText);
				if(result.success==true){
					gridForm.cueinfo.updateText(result.msg);
					setTimeout(gridForm.msg_hide, 2000)
				 }
			}
		});
	}
	gridForm.msg_hide=function(){
		gridForm.cueinfo.hide();
	}


	
});
</script>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->