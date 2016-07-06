<!--{include file="header.tpl"}-->
<style type="text/css">
#tab11_item .x-panel-body{
background: white;
font: 11px Arial, Helvetica, sans-serif;
}
#tab11_item .thumb{
background: #dddddd;
padding: 3px;
}
#tab11_item .thumb img{
height: 80px;
width: 80px;
}
#tab11_item .thumb-wrap{
float: left;
margin: 4px;
margin-right: 0;
padding: 5px;
}
#tab11_item .thumb-wrap span{
display: block;
overflow: hidden;
text-align: center;

}

#tab11_item .x-view-over{
border:1px solid #dddddd;
background: #efefef url(common/lib/ext/resources/images/default/grid/row-over.gif) repeat-x left top;
padding: 4px;
}

#tab11_item .x-view-selected{
background: #eff5fb url(themes/default/images/selected.gif) no-repeat right bottom;
border:1px solid #99bbe8;
padding: 4px;
}
#tab11_item .x-view-selected .thumb{
background:transparent;
}
.x-statusbar .x-status-busy {
    padding-left: 25px !important;
    background: transparent no-repeat 3px 0;
    background-image: url(themes/default/images/accept.png);
}
.x-status-valid{ background-image: url(themes/default/images/accept.png);}
</style>

<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    var account = object_Array([<!--{$account}-->]);
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
            value:'<!--{$today}-->',
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
            fieldLabel: 'Aliexpress账号',
            emptyText:'选择Aliexpress账号',
            name: 'account_id',
            id:'account_id',
            allowBlank:false,
            blankText:'请选择'
            }
        ],

        buttons: [{
            text: '加载Message',
            handler:function(){
                if(top.form.isValid()){
                        //msgWindow.show();
                        
                        var starttime=Ext.util.Format.date(top.getForm().getFieldValues().start,'Y-m-d');
                        var endtime = Ext.util.Format.date(top.getForm().getFieldValues().end,'Y-m-d');
                        if(Ext.getCmp('msgWindow')){
                           var msgWindow = Ext.getCmp('msgWindow');
                        }else{
                           var msgWindow = showWindow('同步aliexpress站内信',520,120);  
                        }
                        msgWindow.show();
                        msgWindow.body.dom.innerHTML = '';
                        var sb = Ext.getCmp('basic-statusbar');
                        sb.showBusy();
                        sb.setText('正在同步站内信,可能需要花费数分钟时间,请耐心等候..');
                       
                        var id = Ext.getCmp('account_id').getValue();
                        Ext.Ajax.request({
                            url:'index.php?model=aliexpress&action=loadmsg&id='+id+'&start='+starttime+'&end='+endtime,     
                            params:'',
                            timeout: 4500000,
                            success:function(response,opts){
                                var res = Ext.decode(response.responseText);
                                if(res.success){
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-valid',
                                        clear: false
                                    });
                                }else{
                                    
                                    sb.setStatus({
                                        text: res.msg,
                                        iconCls: 'x-status-error',
                                        clear: true
                                    });
                                }
                            },
                            failure:function(response){
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
        }]
    });
    
    
    top.render(document.body);
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
