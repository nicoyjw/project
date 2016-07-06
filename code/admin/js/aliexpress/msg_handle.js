Ext.define('Ext.ux.GoodsView', {
    extend: 'Ext.Viewport',
    initComponent: function() {
        this.layout = 'border';
        this.selectid = '';
        this.creatselectionmodel();
        this.getTab();
        this.creatTree();
        this.createStore();
        this.creatgrid();
        this.creatitems();
        this.callParent()
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
            fields:this.fields,
            remoteSort: true,
            autoLoad: true,
            pageSize: this.pagesize,
            proxy: {
                type: 'ajax',
                url: this.listURL,
                actionMethods: {
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0],
                    root: 'topics'
                }
            }
        })
    },
    setid: function(str) {
        this.selectid = str
    },
    getid: function() {
        return this.selectid
    },
    creatTree: function() {
        var me = this;
        var Tree = Ext.tree;
        var pagesize = this.pagesize;
        var acco = Ext.create('Ext.tree.Panel', {
            border: true,
            id:'account_tree',
            width:220,
            store: Ext.create('Ext.data.TreeStore', {
                autoLoad: true,
                proxy: {
                    type: 'ajax',
                    url: this.catTreeURL
                },
                root: {
                    text: '总类',
                    draggable: false,
                    id: 'root'
                }
            }),
            layoutConfig: {
                animate: true
            },
            rootVisible: false,
            autoScroll: true
        });
        acco.on('itemclick', treeClick);
        function treeClick(view, node, item, index, e) {
            if (node.isLeaf()) {
                e.stopEvent();
                var new_params = {   
                    account:node.data.id,
                    status:Ext.getCmp('status').getValue()
                };
                Ext.apply(me.store.proxy.extraParams, new_params);
                
                me.store.load({
                    params: {start: 0, limit: pagesize }
                })     
            }
        };
        
         var tree = Ext.create('Ext.tab.Panel', {
            activeTab: 0,
            region: 'west',
            id: 'west-panel',
            width: 240,
            minSize: 55,
            maxSize: 300,
            margins: '0 0 0 0',
            split: true,
            layoutConfig: {
                animate: true
            },
            autoScroll: true,
            items: [{
                id: 'tab2_1',
                title: '帐号',
                autoScroll: true,
                items:[acco]
            }]
        });
        
        this.tree = tree
    },
    creatgrid: function() {
        var cm = this.creatcolumns();
        var bbar = this.creatBbar();
        var tbar = this.creatTbar();
        this.grid = Ext.create('Ext.grid.Panel', {
            loadMask: true,
            id: 'aliGrid',
            height: 500,
            viewConfig: {
                forceFit: true,
            },
            region: 'center',
            store: this.store,
            columns: cm,
            selModel: this.sm,
            tbar: tbar,
            bbar: bbar
        })
    },
    creatselectionmodel: function() {
        var setid = this.setid;
        var action = this.action;
        doSelect = this.doSelect;
        var sm = Ext.create('Ext.selection.CheckboxModel', {
            //mode: 'SINGLE',
            listeners: {
                "select": function(e, record, rowindex) {
                    setid(record.data);
                    Ext.getDom("detailtrack").innerHTML = '';
                    Ext.getDom("detailtrack").innerHTML = "<b>运单轨迹明细：</b>   "+record.data.text;
                }
            }
        });
        this.sm = sm
    },
    doSelect: function(id, info, action) {
        
        var tpl1 = new Ext.Template('<div style="width:40%;float:left;padding:5px;"><div><b>运单轨迹明细：</b><br/>{text}</div></div>');
        tpl1.overwrite(Ext.getCmp("detailtrack").body, info);
        Ext.getCmp("detailtrack").body.highlight('#c3daf9', {block: true});
    },
    creatcolumns: function() {
        var pstore = this.store;
        var ds = this.store;
        var sm = this.sm;
        cols = [{
            header: 'order_id',
            hidden:true,
            dataIndex: 'order_id'
        },{
            header: '订单号',
            sortable:true,
            flex:1.8,           
            dataIndex: 'order_sn',
            renderer:function(val,x,rec){
               return  '<br/><font style="color:#666;margin-left:8px">'+val + '</font> <font style="color:#157FCC;margin-left:20px">'+rec.get('track_no')+'</font>';
           }
        },{
            header: '最后邮包事件',
            flex:2.2,        
            dataIndex: 'last_info',
            renderer:function(val,x,rec){
               return  '<br/>'+val;
           }
        },{
            header: '发货时间', 
            flex:1,       
            dataIndex: 'end_time'
        },{
            header: '收件人',
            flex:1,      
            dataIndex: 'consignee'
        }
        ] ;
        //'order_id','','','','','','','paypalid','','Sales_account_id','userid','shipping_id','Sales_channels','email','city','street1','street2','state','country','zipcode','tel','ShippingService'
        return cols
    },
    creatTbar: function() {
        var pagesize = this.pagesize;
        var store = this.store;
        var saveURL=this.saveURL;
        var account = this.accountdata;
        var status = this.status;
        var me = this;
        var accstore = Ext.create('Ext.data.ArrayStore', {
            fields: ['id', 'name'],
            data : account
        });
        return Ext.create('Ext.toolbar.Toolbar', {
            items: ['->',/*{
                xtype:'datefield',
                hideLabel:true,
                name:'starttime',
                id:'starttime',
                width:105,
                allowBlank:false,
                emptyText: 'From',
                format:'Y-m-d'
            },'-',{
                xtype:'datefield',
                hideLabel:true,
                name:'totime',
                id:'totime',
                width:105,
                emptyText: 'To',
                format:'Y-m-d'
            },*/{
            xtype:'combo',
            hideLabel: true,
            store: Ext.create('Ext.data.ArrayStore',{
                 fields: ["id", "key_type"],
                 data: status
            }),
            valueField :"id",
            displayField: "key_type",
            mode: 'local',     
            forceSelection: true,
            triggerAction: 'all',
            queryMode: 'local', 
            emptyText: '选择状态',
            selectOnFocus: true,
            width: 105,
            hiddenName:'status',
            name: 'status',
            id:'status',
            value:'all',
        },'-','模糊搜索',{
            id:'keyword',
            name:'keyword',
            width:205,
            xtype:'textfield',
            enableKeyEvents: true,
            listeners: {
                scope: this,
                keypress: function(field, e){
                    if (e.getKey() == 13) {      
                        var new_params = {   
                            account:Ext.getCmp('account_id').getValue(),
                            status:Ext.getCmp('status').getValue(),
                            keyword:Ext.getCmp('keyword').getValue()
                        };
                        Ext.apply(me.store.proxy.extraParams, new_params);
                        
                        me.store.load({
                            params: {start: 0, limit: 25 }
                        })  
                    }
                }
            }
        },'-',{
            xtype:'button',
            text:'搜索',
            iconCls:'x-tbar-search',
            handler:function(){
                //alert(Ext.getCmp('status').getValue());return;
                var new_params = {   
                    //account:Ext.getCmp('ali_goods_account_id').getValue(),
                    status:Ext.getCmp('status').getValue(),
                    keyword:Ext.getCmp('keyword').getValue()
                };
                Ext.apply(me.store.proxy.extraParams, new_params);
                
                store.load({
                    params: {start: 0, limit: 25 }
                })    
            }
        }]
        })
        
        
    },
    creatBbar: function() {
        var pagesize = this.pagesize;
        return Ext.create('Ext.toolbar.Paging', {
            plugins: new Ext.ui.plugins.ComboPageSize(),
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
            
        })
          
    },
    creatTab: function() {
        var store = this.store;
        var getid = this.getid;
        var action = this.action;
        var rendererlist = this.rendererlist;
        doSelect = this.doSelect;
        
        var tab = Ext.create('Ext.panel.Panel', { 
            autoWidth: true,   
            height: 500,
            defaults: {
                autoScroll: true
            },
            items: [{
                id: 'detailtrack', 
                height:500,        
                autoScroll: true,
                html: ''
            }]
        });
        return tab
    },
    getTab: function() {
        if (!this.tab) {
            this.tab = this.creatTab()
        }
        return this.tab
    },
    creatitems: function() {
        return this.items = [this.tree, this.grid, {
            title: '详情',
            region: 'south',
            height: 200,
            collapsible: true,
            autoScroll: true,
            split: true,
            items: [this.tab]
        }]
    },
    showWindow: function() {
        this.getWindow().show()
    },
    hideWindow: function() {
        this.getWindow().hide()
    },
    getWindow: function() {
        if (!this.gridWindow) {
            this.gridWindow = this.createWindow()
        }
        return this.gridWindow
    },
    createWindow: function() {
        var formPanel = this.getFormPanel();
        var win = Ext.create('Ext.window.Window', {
            id: 'searchwin',
            title: this.windowTitle,
            closeAction: 'destroy',
            width: this.windowWidth,
            height: this.windowHeight,
            modal: true,
            items: [formPanel]
        });
        return win
    },
    startonline:function(id,account_id,skuCode,win){
        var sb = Ext.getCmp('basic-statusbar');
        var me = this;
        Ext.Ajax.request({
            url: 'index.php?model=aliexpress&action=onlineshelf',
            params: {account_id:account_id,id:id},
            success:function(response,opts){
                var res = Ext.decode(response.responseText);
                if(res.success){
                    Ext.defer(function(){
                        sb.setStatus({
                            iconCls: 'x-status-valid',
                            text: skuCode+'&nbsp;&nbsp;'+res.msg + '&nbsp;&nbsp;'+ Ext.Date.format(new Date(), 'G:i:s')
                        });
                    }, 1000);
                    win.body.dom.innerHTML = win.body.dom.innerHTML+skuCode+'&nbsp;&nbsp;'+res.msg;
                }
            }
        });
    }
});

