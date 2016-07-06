Ext.define('Ext.ux.depotmanagerView',{
    extend:'Ext.ux.OrderView',
    initComponent: function() {
        this.callParent(this);
    },
    creatgrid:function(){
        var cm = this.columns;
        var bbar = this.creatBbar();
        var tbar = this.creatTbar();
        this.grid = Ext.create('Ext.grid.Panel',{
            loadMask:true,
            height: 400,
            viewConfig:{
                forceFit: true
            },
            plugins:[Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1
            })],
            region:'center',
            store: this.store,
            columns: cm,
            selModel:this.sm,
            tbar:tbar,
            bbar:bbar
            });
    },
    addcolumns:function(){
        var ds = this.store;
        this.columns.push({
                  header:'操作',
                  width:70,
                  xtype: 'actioncolumn',
                  items:[{
                        icon   : 'themes/default/images/update.gif',     
                        tooltip: '编辑订单',
                        handler: function(grid, rowIndex, colIndex) {
                            var id = ds.getAt(rowIndex).get('order_id');
                            parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
                        }
                         },{
                        icon   : 'themes/default/images/del.gif',     
                        tooltip: '删除订单',
                        iconCls:'iconpadding',
                        handler: function(grid, rowIndex, colIndex) {
                            Ext.Msg.show({
                                title:'Delete order?',
                                msg:'Are you sure to delete this order?',
                                buttons:Ext.Msg.YESNO,
                                icon:Ext.MessageBox.ERROR,
                                fn:function(btn){
                                    if (btn == 'yes') {
                                        Ext.getBody().mask("正在删除订单.请稍等...","x-mask-loading");
                                        var id = ds.getAt(rowIndex).get('order_id');
                                    Ext.Ajax.request({
                                       url: 'index.php?model=order&action=delorder&id='+id,
                                        success:function(response,opts){
                                            var res = Ext.decode(response.responseText);
                                            Ext.getBody().unmask();
                                                if(res.success){
                                                ds.load();
                                                Ext.example.msg('MSG',res.msg);
                                                }else{
                                                Ext.example.msg('ERROR',res.msg);
                                                }                        
                                            }
                                        });
                                    }
                                    }
                                });
                        }
                        },{
                        icon   : 'themes/default/images/editcopy.png',     
                        tooltip: '复制订单',
                        iconCls:'iconpadding',
                        handler: function(grid, rowIndex, colIndex) {
                            var id = ds.getAt(rowIndex).get('order_id');
                            parent.openWindow(id,'新建订单','index.php?model=order&action=add&id='+id,1000,500);
                        }
                         }]
                  });
    } ,
    creatTbar:function(){
        var store = this.store;
        var pagesize = this.pagesize;
        var step = this.step;
        var data = this.arrdata;
        var me = this;
        var time_type = Ext.create('Ext.form.field.ComboBox', {                 
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: [['1','Paid time'],['2','Shipping time'],['3','Add time']]
            }),
            valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '时间类型...',
            selectOnFocus: true,
            width: 105,
            hideLabel: true,  
            hiddenName:'timetype', 
            name: 'timetype',
            id:'timetype',
            value:'1'
       });
        var account = Ext.create('Ext.form.field.ComboBox', {
            hideLabel: true,
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: data[3]
            }),
             valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '选择账号...',
            selectOnFocus: true,
            width: 135,
            hiddenName:'account',
            name: 'account',
            id:'account',
            value:'0'
        });
        return Ext.create('Ext.toolbar.Toolbar',{
            items:['<b>订单列表</b>',
                   '-',{
                        xtype:'button',
                        text:'保存追踪单号',
                        iconCls:'x-tbar-update',
                        handler:this.updatetrack.bind(this)
                    },'->',account,'-',time_type,
                    {
                        xtype:'textfield',
                        id:'keyword',
                        name:'keyword',
                        width:105,      
                        emptyText: '订单号&回车',
                        hideLabel:true,
                        enableKeyEvents:true,
                        listeners:{
                        scope:this,
                        keypress:function(field,e){
                            if(e.getKey()==13){
                                alert(Ext.getCmp('totime').getValue());
                                store.load({params:{start:0, limit:pagesize,
                                    keyword:Ext.getCmp('keyword').getValue()
                                    }});
                                }
                            }
                        }
                    },'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'starttime',
                        id:'starttime',
                        width:125,
                        allowBlank:false,
                        emptyText: 'From',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY, -7),"Y-m-d") 
                    },'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'totime',
                        id:'totime',
                        width:125,
                        emptyText: 'To',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY),"Y-m-d")   
                    },'-',{
                        xtype:'button',
                        text:'提交查询',
                        iconCls:'x-tbar-search',
                        handler:function(){
                            store.on('beforeload', function (store, options) {
                            var new_params = {
                                starttime:Ext.getCmp('starttime').getValue(),
                                totime:Ext.getCmp('totime').getValue(),      
                                timetype:Ext.getCmp('timetype').getValue(),
                                keyword:Ext.getCmp('keyword').getValue()
                                };
                            Ext.apply(store.proxy.extraParams, new_params);
                            });
                            store.load({params:{start:0, limit:pagesize}});
                            }
                    },'-',{
                        xtype:'button',
                        text:'高级搜索',
                        iconCls:'x-tbar-advsearch',
                        handler:this.showWindow.bind(this)
                    },'-',{
                        text: '导出订单',
                        iconCls:'x-tbar-import',
                        menu: {
                            xtype: 'menu',
                            plain: true,
                            items: {
                                xtype: 'buttongroup',
                                title: '选择格式', 
                                defaults: {
                                    xtype: 'button',
                                    scale: 'small',
                                    iconAlign: 'left',   
                                    handler: function(){}
                                },
                                items: [{
                                    width: '100%',
                                    text: 'ERP格式',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportorder&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                },{
                                    width: '100%',
                                    text: 'eBay格式',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportebay&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                }]
                            }
                        }
                    }
                ]                                  
        });     
    },
    creatBbar: function() {
        var    pagesize = this.pagesize;
        
       return Ext.create('Ext.toolbar.Paging',{
               plugins: new Ext.ui.plugins.ComboPageSize(),
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0}到{1}条 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
            items:[
                       {
                       text:'提交预报',
                       pressed:true,
                       handler:this.eubprint.bind(this,['0'])
                       },'-',{
                       text:'打印标签',
                       pressed:true,
                       handler:this.handlerzip.bind(this,['1'])
                       },'-',{
                       text:'处理完成',
                       pressed:true,
                       handler:this.updatestatus.bind(this,['1'])
                       },'-','<a onclick="window.open(\'#\')" href="#">俄速通登录</a>']                   
        });
    },
    geteubtrack:function(type){   
        var ids = getIds(this.grid);
        var thiz = this.store;
        if(!ids) return false;         
        var mk = new Ext.LoadMask(Ext.getBody(), {
            msg: '正在获取数据，请稍候！',
            removeMask: true //完成后移除
            });
        mk.show(); 
        Ext.Ajax.request({
            url:'index.php?model=order&action=PreAlertEstOrder',
            timeout:300000,
            loadMask:true,        
            success:function(response){
                mk.hide();
                var res = Ext.decode(response.responseText);
                if(res.success){
                    Ext.Msg.alert('MSG',res.msg);
                    thiz.load();
                }else{
                    Ext.Msg.alert('MSG',res.msg);
                }
            },
            failure:function(response){
                if(reqst=='-1'){ 
                    thiz.load();
                    Ext.example.msg('警告','预报超时退出');
                }else{
                    Ext.example.msg('警告','预报失败');
                }
                mk.hide();
                },
            params:{id:ids}             
        });
    },
    geteubapply:function(){
        window.open('index.php?model=order&action=geteubapply');
        },
    geteubpdf:function(num){
        var ids = getIds(this.grid);
        var local = Ext.getCmp('local').getValue();
        var thiz = this.store;
        if(!ids) return false;
        var mk = new Ext.LoadMask(Ext.getBody(), {
            msg: '正在获取压缩包....正在解压....请稍候！',
            removeMask: true //完成后移除
            });
        mk.show(); 
        Ext.Ajax.request({
            url:'index.php?model=order&action=geteubzip',
            timeout:180000,
            loadMask:true,
            success:function(response){
                mk.hide(); 
                thiz.load();            
                Ext.Msg.alert('提示',response.responseText);   
            },
        failure:function(response){
            mk.hide();
            if(reqst=='-1'){ 
                thiz.load();
                Ext.example.msg('警告','获取pdf超时退出');
            }else{
                Ext.example.msg('警告','获取e邮宝pdf失败');
            }
            },
            params:{id:ids,type:num,local:local}             
        });
    },
    handlerzip:function(num){
        var thiz = this.store;
        Ext.Msg.alert('提示','由于条码扫描原因，近期修复后重启开启!');return;
        var ids = getIds(this.grid);
        if(!ids) return false;
        Ext.getBody().mask("正在处理.请稍等...","x-mask-loading"); 
        Ext.Ajax.request({
            url:'index.php?model=order&action=handlerzip',
            timeout:180000,
            success:function(response){
                Ext.getBody().unmask(); 
                 Ext.define('PdfModel', {
                    extend: 'Ext.data.Model',
                    fields: ['order_sn', 'track_no','url','label_type']
                });
                var data = Ext.decode(response.responseText); 
                var pdfstore = Ext.create('Ext.data.Store', {
                    model: 'PdfModel',
                    data:data,
                    autoLoad:true
                });
                var Tbar = Ext.create('Ext.toolbar.Toolbar',{
                items:[
                    {
                    xtype:'button',
                    text:'打开合并后的图片',
                    disabled: false,   
                    handler:function(){                     
                        
                        var jsonArray = [];  
                        for(var i=0;i<pdfstore.getCount();i++)
                        {
                            
                           var attr = {"track_no":pdfstore.getAt(i).data.track_no,"url":pdfstore.getAt(i).data.url,"label_type":pdfstore.getAt(i).data.label_type};
                           jsonArray.push(attr);
                        }
                        
                        openWindowWithPost('index.php?model=order&action=bulkpdf',Ext.encode(jsonArray),'订单打印'+Math.floor(Math.random()*100));
                       
                        //alert(Ext.encode(jsonArray));return;
                        /*Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
                        Ext.Ajax.request({
                            method:'post',
                            url:'index.php?model=order&action=bulkpdf',
                            timeout: 180000,
                            success:function(response){
                                Ext.example.msg('提示',response.responseText);
                                
                                Ext.getBody().unmask();
                                },
                            failure:function(response){
                                Ext.example.msg('警告','订单自动合并失败');
                                Ext.getBody().unmask();
                            },
                            params:{data:Ext.encode(jsonArray)}             
                        });*/     
                    }
                    }
                   ]                                  
                });          
                var listView = Ext.create('Ext.grid.Panel', {
                        width:425,
                        height:250,        
                        store: pdfstore,
                        multiSelect: true,
                        viewConfig: {
                            emptyText: 'No data to display'
                        },
                        columns: [{
                            text: '订单号',
                            flex: 0.7,
                            dataIndex: 'order_sn'
                        },{
                            text: '追踪号',      
                            flex: 0.7,
                            dataIndex: 'track_no'
                        },{
                            text: '标签链接(点击打开)',      
                            flex: 2.5,
                            dataIndex: 'url',
                            renderer:function(v){
                                return '<a style="text-decoration:underline;padding:3px 0;color:#0000d0" href="'+v+'" target="_blank">'+v+'</a>';
                            }
                        },{
                            text: '类型',
                            dataIndex: 'label_type',
                            flex: 0.4,               
                        }],
                        tbar:Tbar,
                    });
                    win = Ext.create('Ext.window.Window',{ 
                        layout:'fit',
                        width:750,
                        title:'标签处理 ',
                        height:420,
                        closeAction:'destroy',
                        collapsible:true,    
                        autoScroll:true ,
                        modal: true,
                        items:[
                           listView 
                        ]
                        
                    });
                   win.show();
                //Ext.Msg.alert('提示',response.responseText);return; 
            },
            params:{id:ids}             
        });
    }, 
    eubprint:function(){
        
        var ids = getIds(this.grid);
        var thiz = this.store;
        if(!ids) return false;
        var mk = new Ext.LoadMask(Ext.getBody(), {
            msg: '正在获取单号，请稍候！',
            removeMask: true //完成后移除
            });
        mk.show(); 
        Ext.Ajax.request({
            url:'index.php?model=order&action=GetESTtracking',
            timeout:300000,
            loadMask:true,
            success:function(response){
                mk.hide();
                var res = Ext.decode(response.responseText);
                    if(res.success){
                        Ext.Msg.alert('MSG',res.msg);
                    }else{
                        Ext.Msg.alert('MSG',res.msg);
                    }
                thiz.load();
                
                },
            failure:function(response){
                thiz.load();
                Ext.example.msg('警告','获取追踪单号超时退出');
                
                mk.hide();
                },
            params:{id:ids}             
        });
        
        
        
    },
    updatetrack:function(){
        var m = this.store.getModifiedRecords().slice(0);
        if(m.length==0) return false;
        var jsonArray = [];
        Ext.each(m,function(item){
            var moddata =new Object();
            moddata.order_id = item.data.order_id;
            moddata.track_no = item.data.track_no;
            jsonArray.push(moddata);                
            });
        var thiz = this.store;
        Ext.getBody().mask("正在保存追踪单号.请稍等...","x-mask-loading");
        Ext.Ajax.request({
                    url:'index.php?model=order&action=updatetrackno',     
                    method:'POST',
                    params:{'data':Ext.encode(jsonArray)},
                    success:function(response,opts){
                        Ext.getBody().unmask();
                            var res = Ext.decode(response.responseText);
                            if(res.success){
                            Ext.Msg.alert('MSG',res.msg);
                            thiz.commitChanges();
                            }else{
                            Ext.Msg.alert('MSG',res.msg);
                            }
                            
                        },
                    failure:function(){
                            Ext.example.msg('MSG','保存失败'),
                            thize.rejectChanges();
                        }
                })    
    }
});

