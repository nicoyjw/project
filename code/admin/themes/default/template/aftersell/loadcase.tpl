<!--{include file="header.tpl"}-->
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = object_Array([<!--{$account}-->]);
    Ext.QuickTips.init();
	var msgWindow = Ext.create('Ext.window.Window',{
		id:'msgWindow',
		title:'Case加载中...',
		modal:true,
		closeAction:'hide',
		height:300,
		width:300,
		autoScroll:true,
		html:'Case加载中..',
		constrainHeader:true,
        bbar: Ext.create('Ext.ux.StatusBar', {
            id: 'basic-statusbar',
            defaultText: 'Ready',
            text: 'Ready',
            iconCls: 'x-status-valid'
        })
	});
	
	var sb = Ext.getCmp('basic-statusbar');
    var top = Ext.create('Ext.form.Panel',{
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'Case加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		renderTo:document.body,
		width:300,
        items: [{
	    	xtype:'datefield',
	        fieldLabel: '开始时间',
	        name: 'start',
	        allowBlank:false,
			format:'Y-m-d',
			value:'<!--{$yesterday}-->',//'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->',
	        anchor:'90%'
	        },{
	    	xtype:'datefield',
	        fieldLabel: '结束时间',
	        name: 'end',
			format:'Y-m-d',
	        allowBlank:false,
			value:'<!--{$yesterday}-->',
			maxValue:'<!--{$today}-->',
	        anchor:'90%'
	        },{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: [<!--{$account}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载Case',
			handler:function(){
				if(top.form.isValid()){
						msgWindow.show();
							var account_name = account[top.getForm().getFieldValues().id];
							addText('<br><br>开始加载'+account_name+'账号Case');
						sb.showBusy();
					top.form.doAction('submit',{
						url:'index.php?model=Ecase&action=loadcase',
						method:'post',
						params:'',
						success:function(form,action){
							var str = action.result.msg.split("|");
							addText('<br>共有'+str[1]+'页共'+str[2]+'条记录');
							msgWindow.show();
							if(str[1] == 0) {
								addText('<br>加载完成');
								Ext.getCmp('basic-statusbar').clearStatus();
							}else{							
								for(var i=1;i<=str[1];i++){
									Ext.Ajax.request({
										url:'index.php?model=Ecase&action=loadxml',
										success:function(response){
										   addText(response.responseText);
										},
										failure:function(response){
												addText(response.responseText);
												sb.setStatus({
													text: 'Oops!',
													iconCls: 'x-status-error',
													clear: true 
												});
												},
										params:{id:str[0],page:i}
										});
								}
								addText("<br>case加载完成");
								sb.clearStatus();
							}
						},
						failure:function(form,action){
							sb.setStatus({
								text: '加载失败，请联系管理员!',
								iconCls: 'x-status-error',
								clear: true 
							});
							//msgWindow.hide();
							//Ext.Msg.alert('操作',action.result.msg);
						}
                    });
				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
	
    var top1 = Ext.create('Ext.form.Panel',{
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'Feedback加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
		renderTo:document.body,
		width:300,
        items: [{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "account_name"],
	             data: [<!--{$account}-->]
	        }),
	        valueField :"id",
	        displayField: "account_name",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'id',
	        fieldLabel: 'Ebay账号',
	        emptyText:'选择Ebay账号',
	        name: 'id',
			allowBlank:false,
			blankText:'请选择'
	        }
        ],

        buttons: [{
            text: '加载feedback',
			handler:function(){
				if(top1.form.isValid()){
						//msgWindow.show();
						var id = top1.getForm().getFieldValues().id;
						parent.newTab('fbload','加载feedback','index.php?model=ecase&action=LoadFB&id='+id);

				}
			}
        }]
    });
    loadend();
	function addText(str){
			msgWindow.body.dom.innerHTML = msgWindow.body.dom.innerHTML+str;
	}
});
</script>
<!--{include file="footer.tpl"}-->
