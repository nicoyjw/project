Ext.ux.PlanGrid = Ext.extend(Ext.grid.GridPanel, {
    initComponent: function() {
        this.stripeRows = true;
        this.autoWidth = true;
        this.viewConfig = {
            forceFit: true
        };
        this.loadMask=true,
        this.createStore();
        this.createTbar();
        this.createBbar();
        this.createColumns();
        Ext.ux.PlanGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.Store', {
            fields: this.fields,
            pageSize: this.pagesize,
            remoteSort:true,
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: this.listURL,
                actionMethods:{
                    read:'POST'
                },
                reader: {
                    type: 'json',
                    root: 'topics',
                    totalProperty: 'totalCount',
                    idProperty: this.fields[0]
                }
            }
        });
    },

    createTbar: function() {
        var store = this.store;
        var depot = this.depot;
        var listURL =this.listURL;
        var planBySupplierURL=this.planBySupplierURL;
        var DepotPlanByAllURL=this.DepotPlanByAllURL;
        this.tbar = [{
                                xtype:'combo',
                                store: Ext.create('Ext.data.ArrayStore',{
                                     fields: ["id", "key_type"],
                                     data: depot
                                }),
                                valueField :"id",
                                displayField: "key_type",
                                mode: 'local',
                                editable: false,
                                forceSelection: true,
                                hiddenName:'depot_id',
                                name:'depot_id',
                                triggerAction: 'all',
                                fieldLabel: '仓库',
                                allowBlank:false,
                                labelWidth:35,
                                pagesise:10,
                                width:150,
                                value:'999',
                                id:'depot'                            
                            },'SKU:',{
                        xtype:'textfield',
                        id:'SKU',
                        name:'SKU',
                        labelWidth:35,
                        width:120,
                        enableKeyEvents:true,
                        listeners:{
                        scope:this,
                        keypress:function(field,e){
                            if(e.getKey()==13){
                            store.reload({params:{start:0, limit:15,
                                SKU:field.getValue()
                                }});
                                }
                            }
                        }
                    },'-',{
                text:'查找',
                iconCls:'x-tbar-search',
                handler:function(){
                    
                    store.reload({params:{start:0, limit:15,
                            SKU:Ext.getCmp('SKU').getValue()
                    }});
                    }
                
                }
            ,{
            text: '导出',
            iconCls: 'x-tbar-add',
            handler: function(){
                window.open(listURL+'&type=export');
                }
        },{
            text: '导出待采购',
            iconCls: 'x-tbar-add',
            handler: function(){
                window.open(listURL+'&type=export&qty=1');
                }
        },'-',{text:'生成采购单',
        iconCls:'x-tbar-save',
        handler:function(){
            parent.newTab('DepotPlanByAll','生成采购单',DepotPlanByAllURL);
        }},'-',{text:'按供应商采购',
        iconCls:'x-tbar-save',
        handler:function(){
            parent.newTab('planBySupplier','供应商采购',planBySupplierURL);
        }}];
    },
    
    createColumns: function() {
        var cols = [];
        cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                header: h,
                sortable: true,
                dataIndex: f,
                flex:1
            });
        }
        this.columns = cols;
    },

    createBbar: function() {
        var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
            pageSize: pagesize,
            displayInfo: true,
            displayMsg: '第{0} 到 {1} 条数据 共{2}条',
            emptyMsg: "没有数据",
            store: this.store,
            items:[
            ]
        });
    },

    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelections()[0];
        }
    }
});

