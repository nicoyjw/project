Ext.ux.MessageView = Ext.extend(Ext.Viewport, {
    initComponent: function() {
        this.layout = 'border';
        this.selectid = '';
        this.createStore();
        this.creatForm();
        this.createForm();
        this.creatselectionmodel();
        this.creatTree();
        this.creatgrid();
        this.creatitems();
        Ext.ux.MessageView.superclass.initComponent.call(this);
    },

    createStore: function() {
        this.store = new Ext.data.Store({
        proxy : new Ext.data.HttpProxy({url:this.listURL}),
        reader: new Ext.data.JsonReader({
            root: 'topics',
            totalProperty: 'totalCount',
            id: 'id'
            },['id','FeedbackID','CommentingUser','CommentType','CommentText','ItemTitle','ItemID','FeedbackResponse','CommentTime','ViewItemURL','answer','Sales_account_id','endtime','answerstatus','order_sn'])
        });            
        this.store.on('beforeload',function(){
            var values = Ext.getCmp('searchform').getForm().getFieldValues();
            Ext.apply(
            this.baseParams,
            {
                keyword:Ext.fly('keyword').dom.value,
                starttime:values.starttime,
                totime:values.totime,
                fbtype:values.fbtype,
                answerstatus:values.answerstatus,
                accountid:values.accountid,
                key:values.key
            });
        });
    },

    setid:function(str){
            this.selectid = str;
    },

    getid:function(){
            return this.selectid;
    },

    creatTree:function(){
        var pagesize = this.pagesize;
        var store = this.store;
        var Tree = Ext.tree;
        var root = new Tree.AsyncTreeNode({
            text: '总类',
            draggable:false,
            id:'root'
        });
        var tree = new Tree.TreePanel({
            border:true,
            root:root,
            region:'west',
            id:'west-panel',
            width: 200,
            minSize: 175,
            maxSize: 400,
            margins:'0 0 0 0',
            layout:'accordion',
            title:'选择账号',
            collapsible :true,
            layoutConfig:{
                animate:true
                },
            rootVisible:false,
            autoScroll:true,
            loader: new Tree.TreeLoader({
                dataUrl:this.accountTreeURL
                })
            });
        tree.on('click',treeClick);
        function treeClick(node,e) {
             if(node.isLeaf()){
                e.stopEvent();
                Ext.getCmp('accountid').setValue(node.id);
                store.load({
                    params:{start:0,accountid:node.id,limit:pagesize},
                    scope:this.store
                    });
             }
        };
        this.tree = tree;
    },

    creatgrid:function(){
        var cm = this.creatcolumns();
        var bbar = this.creatBbar();
        var tbar = this.creatTbar();
        this.grid = new Ext.grid.GridPanel({
            loadMask:true,
            frame:true,
            height: 500,
            viewConfig:{
                forceFit: true
                },
            region:'center',
            store: this.store,
            cm: cm,
            sm:this.sm,
            tbar:tbar,
            bbar:bbar
            });
    },

    creatselectionmodel:function(){
        var setid = this.setid;
        doSelect = this.doSelect;
            var sm = new Ext.grid.RowSelectionModel({
                        singleSelect:true,
                        listeners:{
                            "rowselect":{
                                fn:function(e,rowindex,record){
                                    setid(record.data.id);
                                    doSelect(record.data);
                                    }
                                }
                            }                                 
                        });
            this.sm = sm;
    },

    doSelect:function(info){
        if(!info){
                return false;
            }
        Ext.getCmp('buyerid').setText(info.CommentingUser);
        Ext.getCmp('creatdate').setText(info.CommentTime);
        Ext.getCmp('messagebody').setText(info.CommentText,false);
        Ext.getCmp('answer').setValue(info.FeedbackResponse);
        Ext.getCmp('template').setValue(0);
        Ext.getCmp('title').setText('<a href="http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&item='+info.ItemID+'" target="_blank">'+info.ItemTitle+'</a>',false);    
    },
    creatcolumns:function(){
        var ds = this.store;
        var sm = this.sm;
        var thiz = this;
        var cols =[{
                   header:'回复状态',
                   width:80,
                   dataIndex : 'answerstatus',
                   renderer:function(v){ return (v==1)?'<img src=themes/default/images/flag_green.gif>':'<img src=themes/default/images/flag_red.gif>';},
                    listeners:{
                            "dblclick":{
                                fn:function(t,g,r){
                                                    Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
                                                    Ext.Ajax.request({
                                                       url: 'index.php?model=ecase&action=changefbstatus',
                                                       loadMask:true,
                                                       params: { value:ds.getAt(r).data.answerstatus,id:ds.getAt(r).data.id },
                                                        success:function(response,opts){
                                                            var res = Ext.decode(response.responseText);
                                                            Ext.getBody().unmask();
                                                                if(res.success){
                                                                Ext.example.msg('MSG',res.msg);
                                                                ds.reload();
                                                                }else{
                                                                Ext.Msg.alert('ERROR',res.msg);
                                                                }                        
                                                            }
                                                        });
                                    }
                                }
                            }    
                   },{
                   header:'FROM',
                   width:80,
                   dataIndex : 'CommentingUser'
                   },{
                   header:'分类',
                   width:60,
                   dataIndex : 'CommentType'
                   },{
                   header:'订单号',
                   width:230,
                   dataIndex : 'order_sn'
                   },{
                   header:'Date',
                   width:80,
                   dataIndex : 'CommentTime'
                   }];
        return new Ext.grid.ColumnModel(cols);
    },
    creatTbar:function(){
        var store = this.store;
        var pagesize = this.pagesize;
        return new Ext.Toolbar({
            items:['<b>Feedback列表</b>',
                   '->','Buyer:',{
                        xtype:'textfield',
                        id:'keyword',
                        name:'keyword'
                    },'-',{
                        xtype:'button',
                        text:'搜索',
                        iconCls:'x-tbar-search',
                        handler:function(){
                            store.load({params:{start:0, limit:pagesize,
                                keyword:Ext.fly('keyword').dom.value
                                }});
                            }
                    },'-',{
                        xtype:'button',
                        text:'高级搜索',
                        iconCls:'x-tbar-advsearch',
                        handler:this.showWindow.createDelegate(this)
                    }
                ]                                  
        });    
    },
    
    creatBbar: function() {
        var    pagesize = this.pagesize;
       return new Ext.PagingToolbar({
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store           
        });
    },
    creatForm:function(){
        var store1 = this.store;
        var getid = this.getid;
        var temp = this.arrdata[1];
        doSelect = this.doSelect;
        this.form = new  Ext.form.FormPanel({
                labelAlign: 'right',
                labelWidth: 50,
                autoWidth: true,
                autoScroll:true,
                frame: true,
                items: [{
                    layout: 'column',
                    items:[{
                        columnWidth:.4,
                        layout: 'form',
                        items:[{
                            xtype:'label',
                            id:'buyerid',
                            height:50,
                            fieldLabel: 'Buyerid',
                            html:''
                        }]},{
                        columnWidth:.4,
                        layout: 'form',
                        items:[{
                            xtype:'label',
                            id:'creatdate',
                            fieldLabel: 'Date',
                            html:''
                        }]
                        }
                        ]
                    },{
                        xtype:'combo',
                        fieldLabel: '模板',
                        store: new Ext.data.SimpleStore({
                             fields: ["id", "key_type"],
                             data: temp
                        }),
                        valueField :"id",
                        displayField: "key_type",
                        mode: 'local',
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'template',
                        id: 'template',
                        listeners: {
                            change:function(field,e){
                                Ext.getBody().mask("正在获取模板数据.请稍等...","x-mask-loading");
                                Ext.Ajax.request({
                                   url: 'index.php?model=template&action=getcontent&rec_id='+field.getValue(),
                                   loadMask:true,
                                    success:function(response,opts){
                                        Ext.getBody().unmask();
                                            Ext.getCmp('answer').setValue(response.responseText);
                                        }
                                    });                                    
                            }
                        }
                    },{
                        layout: 'column',
                        items:[{
                            columnWidth:.7,
                            layout: 'form',
                            items:[{
                                fieldLabel: 'Answer',
                                id:'answer',
                                width:500,
                                xtype:'textarea'
                                }]
                            },{
                            columnWidth:.3,
                            layout: 'form',
                            items:[{
                                width:50,
                                height:30,
                                text:'Reply',
                                xtype:'button',
                                listeners: {
                                    click:function(){
                                        var mid = getid();
                                        if(!mid){
                                                Ext.example.msg('请先选中需要回复的Feedback');
                                                return false;
                                                };
                                         var answervalue = Ext.getCmp('answer').getValue();
                                         if(answervalue == ''){
                                                Ext.example.msg('回复内容不能为空');
                                                return false;
                                                };
                                                    Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
                                                    Ext.Ajax.request({
                                                       url: 'index.php?model=ecase&action=replyfb',
                                                       loadMask:true,
                                                       params: { value:answervalue,id:mid },
                                                        success:function(response,opts){
                                                            var res = Ext.decode(response.responseText);
                                                            Ext.getBody().unmask();
                                                                if(res.success){
                                                                Ext.example.msg('MSG',res.msg);
                                                                store1.reload();
                                                                }else{
                                                                Ext.Msg.alert('ERROR',res.msg);
                                                                }                        
                                                            }
                                                        });
                                        }
                                    }
                                }]
                            }
                        ]
                    },{
                        xtype:'label',
                        id:'messagebody',
                        fieldLabel: 'Comment',
                        html:''
                    },{
                        xtype:'label',
                        id:'title',
                        fieldLabel: 'Title',
                        html:''
                    }]            
            });
    },

    creatitems:function(){
        return this.items = [this.tree,this.grid,{
                             title:'Feedback详情',
                             region:'south',
                             collapsed:false,
                             height:250,
                             autoScroll:true,
                             collapsible: true,
                             items:[this.form]
                             }];    
    },
    getForm: function() {
        return this.getFormPanel().getForm();
    },

    getFormPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createForm();
        }
        return this.gridForm;
    },

    getKeytype:function(){
            if(!this.keytype) this.keytype = [['0','未回复'],['1','已回复'],['2',' 所有状态']];
            return this.keytype;
    },

    createForm: function() {
        var store = this.store;
        var pagesize = this.pagesize;
        var keytype = this.getKeytype();
        var cat = this.arrdata[0];
        var fbtype = this.arrdata[2];
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            id:'searchform',
            trackResetOnLoad: true,
            items: [{
                        xtype:'datefield',
                        name:'starttime',
                        format:'Y-m-d',
                        fieldLabel:'From'
                    },{
                        xtype:'datefield',
                        name:'totime',
                        format:'Y-m-d',
                        fieldLabel:'To'
                    },{
                        name:'key',
                        fieldLabel: '关键词',
                        value:''
                    },{
                        xtype:'combo',
                        store: new Ext.data.SimpleStore({
                             fields: ["id", "key_type"],
                             data: cat
                        }),
                        valueField :"id",
                        displayField: "key_type",
                        mode: 'local',
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'accountid',
                        fieldLabel: '账户',
                        id:'accountid',
                        value:0
                    },{
                        xtype:'combo',
                        store: new Ext.data.SimpleStore({
                             fields: ["id", "key_type"],
                             data: fbtype
                        }),
                        valueField :"id",
                        displayField: "key_type",
                        mode: 'local',
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'fbtype',
                        fieldLabel: '类型',
                        id:'fbtype',
                        value:0
                    },{
                        xtype:'combo',
                        store: new Ext.data.SimpleStore({
                             fields: ["id", "key_type"],
                             data: keytype
                        }),
                        valueField :"id",
                        displayField: "key_type",
                        mode: 'local',
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'answerstatus',
                        fieldLabel: '是否回复',
                        name: 'answerstatus',
                        value:2
                    }],
            buttons: [{
                text: 'submit',
                handler:function(){
                        Ext.fly('keyword').dom.value = '';
                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                            store.load({params:{start:0, limit:pagesize,
                                        keyword:Ext.fly('keyword').dom.value,
                                        starttime:values.starttime,
                                        totime:values.totime,
                                        keytype:values.keytype,
                                        brand_id:values.brand_id,
                                        accountid:values.accountid,
                                        fbtype:values.fbtype,
                                        status:values.status,
                                        key:values.key                                
                                        }});
                            Ext.getCmp('searchwin').hide();
                        }
            }, {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
        return form;
    },

    showWindow: function() {
        this.getWindow().show();
    },

    hideWindow: function() {
        this.getWindow().hide();
    },

    getWindow: function() {
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow();
        }
        return this.gridWindow;
    },

    createWindow: function() {
        var formPanel = this.getFormPanel();
        var win = new Ext.Window({
            id:'searchwin',
            title: this.windowTitle,
            closeAction: 'hide',
            width:this.windowWidth,
            height:this.windowHeight,
            modal: true,
            items: [
                formPanel
            ]
        });
        return win;
    }
});

