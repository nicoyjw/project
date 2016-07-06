Ext.define('Ext.ux.depotmanagerView',{
    extend:'Ext.ux.OrderView',
    initComponent: function() {
        this.callParent(this);
    },
    addcolumns:function(){
        var ds = this.store;
        this.columns.push({
            header:'操作',
            width:45,
            xtype: 'actioncolumn',
            items:[{
                icon   : 'themes/default/images/update.gif',     
                tooltip: '编辑订单',
                handler: function(grid, rowIndex, colIndex) {
                    var id = ds.getAt(rowIndex).get('order_id');
                    parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
                }
            }]
        });
    },
    creatBbar: function() {
        var    pagesize = this.pagesize;
        var templatelist = this.templatelist;
        var thiz = this;
       return Ext.create('Ext.toolbar.Paging',{
               plugins: new Ext.ui.plugins.ComboPageSize(),
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
            items:['-',{
               text:'收货完成',
               pressed:true,
               handler:this.completorder.bind(this,['0'])
           },'-',{
               text:'获取物流信息',
               pressed:true,
               handler:this.gettrackinfo.bind(this)
           },'-',{
                            xtype:'combo',
                            id:'printsort',
                            mode:'local',
                            valueField: 'id',
                            width:90,
                            hideLabel:true,
                            hidden:false,
                            emptyText:'打印排序',
                            displayField:'template',
                            editable: false,        
                            triggerAction:'all',
                            store:Ext.create('Ext.data.ArrayStore',{
                                fields: ["id", "template"],
                                data: [['goods_sn', 'SKU'], ['paypalid', '订单号']]                                                              })
                       },'-',{
                        hideLabel:true,
                        xtype:'combo',
                        mode:'local',
                        valueField: 'id',
                        id:'templatess',
                        width:125,
                        emptyText:'选择模板',
                        displayField:'template',
                        editable: false,        
                        triggerAction:'all',
                        store:Ext.create('Ext.data.ArrayStore',{
                            fields: ["id", "template"],
                            data: templatelist                                                                                               }),
                        listeners:{
                            'change':function(){
                                if(Ext.getCmp('templatess').getValue() !== null){
                                    thiz.orderprint(this.getValue());    
                                }
                                Ext.getCmp('templatess').setValue(null);
                            }
                        }
                       }]                   
        });
    },
    completorder:function(){
        var ids = getIds(this.grid);
        var thiz = this.store;
        if(!ids) return false;
        Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
        Ext.Ajax.request({
            url:'index.php?model=order&action=completeorder',
                    success:function(response){
                        var res = Ext.decode(response.responseText);
                        if(res.success){
                        Ext.example.msg('提示',res.msg);
                        thiz.load();
                                }else{
                                Ext.Msg.alert('ERROR',res.msg);
                                }                        
                        Ext.getBody().unmask();
                        },
                    failure:function(response){
                        Ext.example.msg('警告','订单流程审核失败');
                        Ext.getBody().unmask();
                        },
            params:{id:ids}             
        });
    },
    gettrackinfo:function(){
        var ids = getIds(this.grid);
        var thiz = this.store;
        if(!ids) return false;
        parent.newTab('ebayload','更新物流信息',"index.php?model=order&action=updatetrack&id="+ids);
    }
});

