Ext.define('Ext.ux.OutdepotGrid',{
    extend:'Ext.grid.Panel',
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
        this.callParent(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
            fields:this.fields,
            proxy: {
                type: 'ajax',
                url:this.listURL,
                actionMethods:{
                    read: 'POST'
                },
                reader: {
                    type: 'json',
                    totalProperty: 'totalCount',
                    idProperty:this.fields[0],
                    root: 'topics'
                }
            }
        })
    },
    createColumns: function() {
        var cols = [{
            xtype: 'rownumberer'
        },{
            header: '产品图片',
            dataIndex: 'goods_img',
            flex:1.5,
            renderer:function(v){ return (v)?"<a href='"+v+"' target=_blank><img src='"+v+"' width=100></a>":'';}
        },{
                header: '产品编码',
                flex:1,
                dataIndex: 'goods_sn'
            },{
                header: '产品数量',
                flex:1,
                dataIndex: 'out_qty'
            },{
                header: '产品名',
                flex:2,
                dataIndex: 'goods_name',
                renderer:function(val,x,rec){
                    return '<a target="_blank" href="'+rec.get('url')+'">'+val+'</a>';
                }
            },{
                header: '订单金额',
                flex:1,
                dataIndex: 'order_amount'
            },{
                header: '账号',
                flex:1,
                dataIndex: 'sellerID'
            },{
                header: '付款时间',
                flex:1,
                dataIndex: 'paid_time'
            },{
                header: '发货方式',
                flex:1,
                dataIndex: 'shipping'
            },{
                header: '已核数量',
                flex:1,
                dataIndex: 'goods_qty',
                renderer:function(val,x,rec){
                    return (rec.get('goods_qty') < rec.get('out_qty'))?'<b><font color=red>'+val+'</font></b>':val;
                }
            }];
        this.columns = cols;
    },
    createTbar: function() {
            var ds = this.store;
            var plays = this.plays;
            var thiz = this;
            this.tbar = ['订单号或产品编码:',{
                        xtype:'textfield',
                        id:'key',
                        name:'key',
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                var keyword = field.getValue();
                                if(e.getKey()==13 && keyword.length > 0){
                                    keyword = keyword.replace(/#/,'%23');
                                        Ext.Ajax.request({
                                               url: this.checkURL+'&key='+keyword+'&qty='+Ext.getCmp('qty').getValue(),
                                                success:function(response,opts){
                                                    var res = Ext.decode(response.responseText);
                                                        if(res.success){
                                                            if(res.type == 'order'){
                                                                Ext.getCmp('qty').setVisible(true);
                                                                Ext.getCmp('weight').setVisible(false);
                                                                Ext.getCmp('cost').setVisible(false);
                                                                Ext.getCmp('track').setVisible(false);
                                                                Ext.getCmp('dismsg').setVisible(false);
                                                                Ext.getCmp('weight').setValue('0');
                                                                Ext.getCmp('cost').setValue('0');
                                                                Ext.getCmp('track').setValue('');
                                                                //Ext.getCmp('note').update(res.note);
                                                                thiz.setTitle('订单核对-----'+keyword);
                                                            }
                                                            if(res.type == 'complete'){
                                                                plays(1);
                                                                Ext.getCmp('qty').setVisible(false);
                                                                Ext.getCmp('weight').setVisible(true);
                                                                Ext.getCmp('cost').setVisible(true);
                                                                Ext.getCmp('track').setVisible(true);
                                                                Ext.getCmp('dismsg').setVisible(true);
                                                                //Ext.getCmp('note').update('');
                                                            }
                                                            if(res.type == 'sncheck'){
                                                                thiz.showWindow();
                                                                Ext.getCmp('sn_hidden').setValue(res.key);
                                                                Ext.getCmp('sn').focus();
                                                            }
                                                                field.setValue('');
                                                                field.focus();
                                                                ds.load();
                                                        }else{
                                                            plays(0);
                                                            Ext.Msg.alert('ERROR',res.msg);
                                                            field.setValue('');
                                                            field.focus();
                                                        }                        
                                                    }
                                                });
                                    }
                                if(e.getKey()==32){
                                        Ext.Ajax.request({
                                               url: this.checkURL+'&complete=1'+'&track='+Ext.getCmp('track').getValue()+'&weight='+Ext.getCmp('weight').getValue()+'&cost='+Ext.getCmp('cost').getValue(),
                                                success:function(response,opts){
                                                    var res = Ext.decode(response.responseText);
                                                        if(res.success){
                                                            Ext.example.msg('OK','订单核对完成');
                                                                Ext.getCmp('qty').setVisible(false);
                                                                Ext.getCmp('track').setVisible(false);
                                                                Ext.getCmp('weight').setVisible(false);
                                                                Ext.getCmp('cost').setVisible(false);
                                                                field.setValue('');
                                                                Ext.getCmp('track').setValue('');
                                                                Ext.getCmp('weight').setValue(0);
                                                                Ext.getCmp('cost').setValue(0);
                                                                Ext.getCmp('dismsg').setVisible(false);
                                                                plays(1);
                                                                field.focus();
                                                                ds.load();
                                                        }else{
                                                            plays(0);
                                                            Ext.example.msg('ERROR',res.msg);
                                                            field.setValue('');
                                                            field.focus();
                                                        }                        
                                                    }
                                                });
                                        }
                            }
                        }
                         },'-','数量:',{
                        xtype:'textfield',
                        id:'qty',
                        name:'qty',
                        width:60,
                        hidden:true,
                        hideMode:'visibility',
                        value:1,
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                    if(e.getKey()==13){
                                        Ext.getCmp('key').focus();
                                    }
                                }
                        }
                        },'-','重量:',{
                        xtype:'textfield',
                        id:'weight',
                        name:'weight',
                        width:60,
                        hidden:true,
                        hideMode:'visibility',
                        value:0,
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                if(e.getKey()==13){
                                        Ext.Ajax.request({
                                               url: thiz.costURL+'&value='+field.getValue(),
                                                success:function(response,opts){
                                                    var res = Ext.decode(response.responseText);
                                                        if(res.success){
                                                            Ext.getCmp('cost').setValue(res.msg);
                                                        }else{
                                                            Ext.example.msg('ERROR',res.msg);
                                                        }                        
                                                    }
                                                });
                                                Ext.getCmp('key').focus();
                                }
                                }
                        }
                        },'-','运费:',{
                        xtype:'textfield',
                        id:'cost',
                        name:'cost',
                        width:60,
                        hidden:true,
                        hideMode:'visibility',
                        value:0,
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                    if(e.getKey()==13){
                                        Ext.getCmp('key').focus();
                                    }
                                }
                        }
                        },'-','追踪单号:',{
                        xtype:'textfield',
                        id:'track',
                        name:'track',
                        width:120,
                        hidden:true,
                        hideMode:'visibility',
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                    if(e.getKey()==13){
                                        //Ext.getCmp('key').focus();
                                        Ext.Ajax.request({
                                               url: this.checkURL+'&complete=1'+'&track='+Ext.getCmp('track').getValue()+'&weight='+Ext.getCmp('weight').getValue()+'&cost='+Ext.getCmp('cost').getValue(),
                                                success:function(response,opts){
                                                    var res = Ext.decode(response.responseText);
                                                        if(res.success){
                                                            Ext.example.msg('OK','订单核对完成');
                                                                Ext.getCmp('qty').setVisible(false);
                                                                Ext.getCmp('track').setVisible(false);
                                                                Ext.getCmp('weight').setVisible(false);
                                                                Ext.getCmp('cost').setVisible(false);
                                                                field.setValue('');
                                                                Ext.getCmp('track').setValue('');
                                                                Ext.getCmp('weight').setValue(0);
                                                                Ext.getCmp('cost').setValue(0);
                                                                Ext.getCmp('dismsg').setVisible(false);
                                                                plays(1);
                                                                field.focus();
                                                                ds.load();
                                                        }else{
                                                            plays(0);
                                                            Ext.example.msg('ERROR',res.msg);
                                                            field.setValue('');
                                                            field.focus();
                                                        }                        
                                                    }
                                                });
                                    }
                                }
                        }
                        },'-',{
                        xtype:'displayfield',
                        id:'dismsg',
                        name:'dismsg',
                        hidden:true,
                        hideMode:'visibility',
                        html:'<font color=red>订单产品核对完成</font>'
                        }];
    },
    getGridPanel: function() {
        if (!this.gridForm) {
            this.gridForm = this.createGrid();
        }
        return this.gridForm;
    },
    createGrid: function() {
        var thiz =this;
        var store = new Ext.data.ArrayStore({
            fields: [{name: 'sn'}]
           });
        var grid = Ext.create('Ext.grid.Panel',{
                border:false,
                closable:true,
                store: store,
                height:450,
                selModel: Ext.create('Ext.selection.RowModel',{mode:'SINGLE'}),
                columns:[{xtype: 'rownumberer'},{header:'序列号',dataIndex:'SN'}],
                autoScroll: true,
                tbar:['序列号','-',{
                    xtype:'hidden',
                    id:'sn_hidden'
                    },{
                        xtype:'textfield',
                        id:'sn',
                        width:100,
                        enableKeyEvents:true,
                        listeners:{
                            scope:this,
                            keypress:function(field,e){
                                    if(e.getKey()==13){
                                        var value =field.getValue();
                                        //添加record,删除record
                                        var Item = Ext.data.Record.create([{name:'SN'}]);
                                        var p = new Item({SN:value});
                                        var index = store.findBy(function(record,id){
                                                return record.get('SN') == value;                                    
                                        });
                                        if(index >= 0){Ext.example.msg('ERROR','该序列号已扫描');field.setValue('');return}
                                        store.add(p);
                                        field.setValue('');
                                    }
                                }
                        }
                        },'-',{
                            text: '删除',
                            iconCls: 'x-tbar-del',
                            id:'removeBtn',
                            ref: '../removeBtn',
                            handler: this.removeRecord.bind(this)
                        },'-',{
                            text: '提交',
                            iconCls: 'x-tbar-update',
                            id:'editBtn',
                            ref: '../editBtn',
                            handler: this.updateRecord.bind(this)
                        }]
            });    
        return grid;
    },
    updateRecord:function(){//保存序列号
                var m = this.gridForm.getStore().getModifiedRecords().slice(0);
                var store = this.gridForm.getStore();
                var thiz = this;
                var jsonArray = [];
                store.each(function(record) {
                    jsonArray.push(record.data);    
                });
                    if(jsonArray.length==0) {Ext.example.msg('ERROR','请输入序列号');return;}
                    Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
                    Ext.Ajax.request({
                       url: 'index.php?model=order&action=collationsn',
                       loadMask:true,
                       params:{'data':Ext.encode(jsonArray),'goods_sn':Ext.getCmp('sn_hidden').getValue()},
                        success:function(response,opts){
                            var res = Ext.decode(response.responseText);
                            Ext.getBody().unmask();
                                if(res.success){
                                Ext.example.msg('MSG',res.msg);
                                if(res.type == 1){
                                        Ext.getCmp('qty').setVisible(false);
                                        Ext.getCmp('weight').setVisible(true);
                                        Ext.getCmp('cost').setVisible(true);
                                        Ext.getCmp('track').setVisible(true);
                                        Ext.getCmp('dismsg').setVisible(true);
                                        Ext.getCmp('note').update('');
                                        }
                                thiz.store.load();
                                }else{
                                Ext.Msg.alert('ERROR',res.msg);
                                }
                                thiz.hideWindow();                        
                            }
                        });
            store.removeAll();
    },
    removeRecord:function(){
        var data = this.gridForm.getSelectionModel().getSelection()[0].data;
        var index = this.gridForm.getStore().findBy(function(record,id){
                return record.get('SN') == data.SN;                                    
            });
        this.gridForm.getStore().remove(this.gridForm.getStore().getAt(index));
        return;
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
        var gridPanel = this.getGridPanel();
        var win = Ext.create('Ext.grid.Panel',{
            id:'searchwin',
            title: 'Serial number',
            closeAction: 'hide',
            width:300,
            height:500,
            modal: true,
            items: [
                gridPanel
            ]
        });
        return win;
    },    
    createBbar: function() {
            this.bbar = Ext.create('Ext.toolbar.Paging',{
                pageSize: 15,
                displayInfo: true,
                displayMsg: '第{0} 到 {1} 条数据 共{2}条',
                emptyMsg: "没有数据",
                store: this.store
            });
    },
    plays:function(id)
    {
        (id == 1)?document.getElementById("sound1").play():document.getElementById("sound2").play();
    }
});
