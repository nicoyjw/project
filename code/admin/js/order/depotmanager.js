Ext.define('Ext.ux.depotmanagerView',{
	extend:'Ext.ux.OrderView',
	initComponent: function() {
		//this.getTab();
		//this.tab.items.items[0].setDisabled(true);
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
				  width:45,
				  xtype: 'actioncolumn',
				  items:[{
						icon   : 'themes/default/images/update.gif',	 
						tooltip: '编辑订单',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
						}
						 },{
						icon   : 'themes/default/images/mail.png',	 
						tooltip: '发送Message',
						handler: function(grid, rowIndex, colIndex) {
							var id = ds.getAt(rowIndex).get('order_id');
							parent.openWindow(id,'联系客户','index.php?model=message&action=toPartner&order_id='+id+'&type=0',500,400);
						}
						 }]
				  });
	},
	creatTbar:function(){
        var store = this.store;
        var pagesize = this.pagesize;
        var step = this.step;
        var data = this.arrdata;
        var keytype = this.getKeytype();
        var notetype = this.getnotetype();
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
                    width:140,      
                    forceSelection: true,
                    triggerAction: 'all',
                    queryMode: 'local', 
                    name: 'ship',
                    id:'ship',
                    allowBlank:true,
                    emptyText: '批量改物流方式',
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
						text:'保存追踪单号',
						iconCls:'x-tbar-update',
						handler:this.updatetrack.bind(this)
					},'->',account,'-',time_type,'-<u></u>',{
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
                                keyword:Ext.getCmp('keyword').getValue(),
                                timetype:Ext.getCmp('timetype').getValue()
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
		var thiz = this;
		var	pagesize = this.pagesize;
		var tempdata = this.arrdata[4];
       return Ext.create('Ext.toolbar.Paging',{
		   	plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '{0} - {2}  Total : {2} ',
            emptyMsg: "empty",
            store: this.store,
			items:['-',{
					   text:'审核通过',
					   pressed:true,
					   handler:this.updatestatus.bind(this,['1'])
					   },'-',{
					   text:'拆分订单',
					   pressed:true,
					   handler:this.divide.bind(this)
					   },'-',{
                       text:'合并订单',
                       pressed:true,
                       handler:this.combine.bind(this)
                       },'-',{
					   text:'缺货到货通过',
					   pressed:true,
					   handler:function(){window.open().location.href = 'index.php?model=order&action=CheckDepotComplete'}
					   },'-',{
						xtype:'button',
						text:'导出缺货产品',
						iconCls:'x-tbar-import',
						handler:function(){window.open().location.href = 'index.php?model=Purchaseorder&action=planlist&type=export&sid=order'}
					}]				   
        });
    },
	combine:function(){
		var s = this.grid.getSelectionModel().getSelection();
		if(s.length<2) {
			Ext.example.msg('错误提示','至少选择两个或以上的订单才能进行合并');
			return false;
			}
		var buyerid = s.get('userid');
		var ids = [];
		ids.push(s.get('id'));
		for (i=1;i<s.length;i++) {
			var s = this.grid.getSelectionModel().getSelection()[i];
			newbuyer = s.get('userid');
			if(newbuyer != buyerid){
					Ext.example.msg('错误提示','Buyerid不相同，请确认后修改再进行合并');
					return false;
				}
			ids.push(s.get('id'));
		}
		ids = ids.join(',');
		var thiz = this.store;
		Ext.getBody().mask("正在合并订单.请稍等...","x-mask-loading");
		Ext.Ajax.request({
			url:'index.php?model=order&action=combineorder',
					success:function(response){
						Ext.getBody().unmask();
						Ext.example.msg('提示',response.responseText);
						thiz.load();
						},
					failure:function(response){
						Ext.getBody().unmask();
						Ext.example.msg('警告','订单流程审核失败');
						},
			params:{ids:ids}			 
		});
	},
	divide:function()
	{
		var ids = getIds(this.grid);
		var thiz = this.store;
		Ext.getBody().mask("正在分拆订单.请稍等...","x-mask-loading");
		Ext.Ajax.request({
			url:'index.php?model=order&action=divideorder',
					success:function(response){
						Ext.getBody().unmask();
						Ext.example.msg('提示',response.responseText);
						thiz.load();
						},
					failure:function(response){
						Ext.getBody().unmask();
						Ext.example.msg('警告','订单分拆失败');
						},
			params:{ids:ids}			 
		});
	},
	orderprint:function(type){
		var ids = getIds(this.grid);
		if(!ids) return false;
		var printsort = Ext.getCmp('printsort').getValue();
		openWindowWithPost('index.php?model=order&action=print&type='+type+'&printsort='+printsort,ids,'订单打印'+Math.floor(Math.random()*100));

/*		var ids = getIds(this.grid);
		if(!ids) return false;
		openWindowWithPost('index.php?model=order&action=print&type='+type,ids,'订单打印'+Math.floor(Math.random()*100));//window.open('index.php?model=order&action=print&type='+type+'&ids='+ids);
*/	},
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
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
							if(res.success){
							Ext.example.msg('MSG',res.msg);
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

