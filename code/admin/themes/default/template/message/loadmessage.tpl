<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var account = object_Array([<!--{$account}-->]);
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';	
    var top = new Ext.FormPanel({
		id:'loadform',
        buttonAlign:'center',
        align:'center',
		labelWidth:70,
        frame:true,
        title: 'Message加载',
        bodyStyle:'padding:5px 5px 0',
		style:'margin:10px',
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
	        store: new Ext.data.SimpleStore({
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
            text: '加载Message',
			handler:function(){
				if(top.form.isValid()){
						//msgWindow.show();
						var id = top.getForm().getFieldValues().id;
						var starttime=Ext.util.Format.date(top.getForm().getFieldValues().start,'Y-m-d');
						var endtime = Ext.util.Format.date(top.getForm().getFieldValues().end,'Y-m-d');
						parent.newTab('messageload','加载Message','index.php?model=message&action=loadebay&id='+id+'&start='+starttime+'&end='+endtime);

				}
			}
        },{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
	
	
	top.render(document.body);
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
