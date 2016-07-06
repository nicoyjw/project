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
			frame:false,
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
				  flex:1,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,680);
						}
						 }]
				  });
	},
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
					},'->',,account,'-',time_type,'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'starttime',
                        id:'starttime',
                        width:105,
                        allowBlank:false,
                        emptyText: 'From',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY, -7),"Y-m-d") 
                    },'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'totime',
                        id:'totime',
                        width:105,
                        emptyText: 'To',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY),"Y-m-d")   
                    },{
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
		var url = this.url;
		var	pagesize = this.pagesize;
       return Ext.create('Ext.toolbar.Paging',{
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:['-',{
					   text:'预报',
					   pressed:true,
					   handler:this.update4px.bind(this,['0'])
					   },' ',{
					   text:'下载CK1 label',
					   pressed:true,
					   handler:this.opentck1label.bind(this)
					   },'-',{
                                xtype:'combo',
                                id:'printsort',
                                mode:'local',
                                valueField: 'id',
                                width:75,
                                hideLabel:true,
                                emptyText:'排序',
                                displayField:'template',
                                editable: false,        
                                triggerAction:'all',
                                store:Ext.create('Ext.data.ArrayStore',{
                                    fields: ["id", "template"],
                                    data: [['goods_sn', 'SKU'], ['paypalid', '订单号'], ['order_sn', 'ERP单号']]                                                                                   })
                       },'-',{
					   text:'打印拣货单',
					   pressed:true,
					   handler:this.orderprint.bind(this,['166'])
					   },'-',{
                       text:'处理完成',
                       pressed:true,
                       handler:this.updatestatus.bind(this,['1'])
                       },'-','<a onclick="window.open(\''+url+'\')" href="#">官网</a>']				   
        });
    },
    orderprint:function(type){
        var ids = getIds(this.grid);
        if(!ids) return false;
        var printsort = Ext.getCmp('printsort').getValue();          
        openWindowWithPost('index.php?model=order&action=print&type='+type+'&printsort='+printsort,ids,'订单打印'+Math.floor(Math.random()*100));
    },
	update4px:function(type){
		var ids = getIds(this.grid);
		var handleurl = this.handleURL;
		var thiz = this.store;
		if(!ids) return false;
		var mk = new Ext.LoadMask(Ext.getBody(), {
			msg: '正在更新数据，请稍候！',
			removeMask: true //完成后移除
			});
		mk.show(); 
		Ext.Ajax.request({
			timeout:180000,
			url:handleurl,
			loadMask:true,
					success:function(response){
						Ext.Msg.alert('提示',response.responseText);
						thiz.load();
						mk.hide();
						},
					failure:function(response){
						var reqst=response.status;
						if(reqst=='-1'){ 
							thiz.load();
							Ext.example.msg('警告','交运超时退出');
						}else{
							Ext.example.msg('警告','交运失败');
						}
						mk.hide();
						},
			params:{id:ids,ispass:1}			 
		});
	},
	opentck1label:function(){
		var ids = getIds(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		var mk = new Ext.LoadMask(Ext.getBody(), {
			msg: '正在更新数据，请稍候！',
			removeMask: true //完成后移除
			});
		mk.show(); 
		Ext.Ajax.request({
			timeout:180000,
			url:'index.php?model=order&action=getck1_printlabel',
			loadMask:true,
					success:function(response){ 
						mk.hide();
                        window.open().location.href = response.responseText;
						},
					failure:function(response){
						var reqst=response.status;
						if(reqst=='-1'){ 
							thiz.load();
							Ext.example.msg('警告','交运超时退出');
						}else{
							Ext.example.msg('警告','交运失败');
						}
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

