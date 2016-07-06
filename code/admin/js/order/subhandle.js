Ext.define('Ext.ux.depotmanagerView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
        this.callParent(this);
    },
	creatgrid:function(){
		var cm =this.columns;
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
				  width:50,
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
            items:['Shipping:','-',{
                    xtype:'combo',
                    store: Ext.create('Ext.data.ArrayStore',{
                             fields: ["id", "key_type"],
                             data: data[1]
                            }),
                    valueField :"id",
                    displayField: "key_type",
                    mode: 'local',
                    width:105,      
                    forceSelection: true,
                    triggerAction: 'all',
                    queryMode: 'local', 
                    name: 'ship',
                    id:'ship',
                    allowBlank:true,
                    emptyText: '更改物流',
                    hideLabel:true,
                    listeners: {
                        scope:this,
                        select: function(c, r, i) {
                            Ext.Msg.show({
                                title:'更改订单物流方式?',
                                msg:'您将改变订单的物流方式，确定吗?',
                                buttons:Ext.Msg.YESNO,
                                icon: Ext.MessageBox.QUESTION,
                                fn:function(btn){
                                    if (btn == 'yes') {
                                        Ext.getBody().mask("正在更新订单.请稍等...","x-mask-loading");
                                        var ids = getIds(me.grid);
                                        if(!ids) return false;
                                        Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
                                        Ext.Ajax.request({
                                            url:'index.php?model=order&action=updateshipping',
                                            success:function(response){
                                            Ext.getCmp('ship').setValue(null);        
                                            var res = Ext.decode(response.responseText);
                                            Ext.getBody().unmask();
                                                if(res.success){
                                                    store.load();
                                                    Ext.getBody().unmask();
                                                    Ext.example.msg('MSG',res.msg);
                                                }else{
                                                    Ext.getBody().unmask();
                                                    Ext.example.msg('ERROR',res.msg);
                                                }
                                                },
                                            failure:function(response){
                                                Ext.getCmp('ship').setValue(null);
                                                Ext.example.msg('警告','更新失败');
                                                Ext.getBody().unmask();
                                                },
                                            params:{id:ids,shipping_id:c.getValue()}             
                                        });
                                        }
                                    }
                                });           
                            }
                        }
                    },
                   '-',{
                        xtype:'button',
                        text:'保存单号',
                        iconCls:'x-tbar-update',
                        handler:this.updatetrack.bind(this)
                    },'->',account,'-',time_type,
                    {
                        xtype:'textfield',
                        id:'keyword',
                        name:'keyword',
                        width:85,      
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
                        width:100,
                        allowBlank:false,
                        emptyText: 'From',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY, -7),"Y-m-d") 
                    },'-',{
                        xtype:'datefield',
                        hideLabel:true,
                        name:'totime',
                        id:'totime',
                        width:100,
                        emptyText: 'To',
                        format:'Y-m-d',
                        value:Ext.util.Format.date(Ext.Date.add(new Date(),Ext.Date.DAY),"Y-m-d")   
                    },'-',{
                        xtype:'button',
                        text:'查询',
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
                        text:'条件',
                        iconCls:'x-tbar-advsearch',
                        handler:this.showWindow.bind(this)
                    },'-',{
                        text: '导出',
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
                                },{
                                    width: '100%',
                                    text: '拣货清单',
                                    scale: 'small',
                                    width: Ext.themeName === 'neptune' ? 175 : 140,
                                    handler:function(){
                                        var values = Ext.getCmp('searchform').getForm().getFieldValues();
                                        //if(values.totime) values.totime = values.totime.format('Y-m-d');
                                        //if(values.starttime) values.starttime = values.starttime.format('Y-m-d');
                                    window.open().location.href = 'index.php?model=order&action=exportPicklist&keyword='+Ext.getCmp('keyword').getValue()+'&starttime='+Ext.Date.dateFormat(Ext.getCmp('starttime').getValue(), 'Y-m-d')+'&totime='+Ext.Date.dateFormat(Ext.getCmp('totime').getValue(), 'Y-m-d')+'&keytype='+Ext.getCmp('keytype').getValue()+'&notetype='+Ext.getCmp('notetype').getValue()+'&shipping='+Ext.getCmp('shipping').getValue()+'&account='+Ext.getCmp('account').getValue()+'&status='+Ext.getCmp('status').getValue()+'&salechannel='+Ext.getCmp('salechannel').getValue()+'&key='+Ext.getCmp('keywords').getValue()+'&step='+step+'&timetype='+Ext.getCmp('timetype').getValue();
                                    }
                                }]
                            }
                        }
                    }
                ]                                  
        });	 
	},
	creatBbar: function() {
		var	pagesize = this.pagesize; 
        var templatelist = this.templatelist;
		var thiz = this;
       return Ext.create('Ext.toolbar.Paging',{
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store,
			items:['-',' ',{
					   text:'创建线上订单',
					   pressed:true,
					   handler:this.update4px.bind(this,['1'])
					   },'-',{
					   text:'批量更新运单号',
					   pressed:true,
					   handler:this.update4px.bind(this,['2'])
					   },'-',{
                                xtype:'combo',
                                id:'printsort',
                                mode:'local',
                                valueField: 'id',
                                width:90,
                                hideLabel:true,
                                emptyText:'打印排序',
                                displayField:'template',
                                editable: false,        
                                triggerAction:'all',
                                store:Ext.create('Ext.data.ArrayStore',{
                                    fields: ["id", "template"],
                                    data: [['goods_sn', 'SKU'], ['paypalid', '订单号']]                                                                                   })
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
                            data: templatelist                                                                                                                                  }),
                        listeners:{
                            'change':function(){
                                if(Ext.getCmp('templatess').getValue() !== null){
                                    thiz.orderprint(this.getValue());    
                                }
                                Ext.getCmp('templatess').setValue(null);
                            }
                        }
                       },'-',{
			   text:'处理完成',
			   pressed:true,
			   handler:this.updatestatus.bind(this,['1'])
			   }]				   
        });
    },orderprint:function(type){
		var ids = getIds(this.grid);
		if(!ids) return false;
		openWindowWithPost('index.php?model=order&action=print&type='+type,ids,'订单打印'+Math.floor(Math.random()*100));
	},
	update4px:function(type){
		var ids = getIds(this.grid);
		var thiz = this.store;
		if(!ids) return false;
		var mk = new Ext.LoadMask(Ext.getBody(), {
			msg: '正在更新数据，请稍候！',
			removeMask: true //完成后移除
			});
		mk.show(); 

		
		if(type==1){
			Ext.Ajax.request({
			timeout:900000,
			url:'index.php?model=aliexpress&action=uporder',
			loadMask:true,
					success:function(response){
						var res = Ext.decode(response.responseText);
						Ext.Msg.show({
                           title: '提示 ',
                           msg: '<div style="overflow: scroll;height:350px;"> '+res.msg+'</div>',
                           buttons: Ext.MessageBox.OK,
                           autoHeight:true,
                           height: 350,
                           autoScroll :true,
                           style:'overflow: scroll;'
                        }); 
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
			params:{id:ids}
			});	
		}else{
			Ext.Ajax.request({
			timeout:900000,
			url:'index.php?model=order&action=Getsubalitracking',
			loadMask:true,
					success:function(response){
						var res = Ext.decode(response.responseText);
						  Ext.Msg.show({
                           title: '提示 ',
                           msg: '<div style="overflow: scroll;height:350px;"> '+res.msg+'</div>',
                           buttons: Ext.MessageBox.OK,
                           autoHeight:true,
                           height: 350,
                           autoScroll :true,
                           style:'overflow: scroll;'
                        }); 
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
			params:{id:ids}
			});	
		}
		
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

