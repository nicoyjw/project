Ext.define('Ext.ux.EbayGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'EbayGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			id:'EbayGrid_removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }, {
            text: '创建并授权',
            iconCls: 'x-tbar-add',
            handler: this.creatEbay.bind(this)
        }/*,
        {
            text: '创建并授权',
            iconCls: 'x-tbar-add',
            handler: this.creatEbay.bind(this)
        }*/
        ];
    },
	createColumns: function() {
		var paypallist = this.paypallist;
        var cols = [{xtype: 'rownumberer'},{
						header: 'Ebay账号',
						flex:1,
						dataIndex: 'account_name'
					}];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				hidden:true
            });
        }
        this.columns = cols;
    },

	creatEbay:function()
	{
		if(Ext.getCmp('Ebaywin')){ Ext.getCmp('Ebaywin').show();return;}
		var store = this.store;
		var win = Ext.create('Ext.Window',{
			layout:'fit',
			title:'Ebay账号授权',
			width:280,
			height:150,
			id:'Ebaywin',
			modal: true,
			closable:true,
			closeAction:'hide',
			constrainHeader:true,
			html:'账号:<input type=text id="Ebayid"><br>输入新建账号，点击开始授权登录EBAY进行授权操作,完成后点击完成授权，在账号编辑绑定的paypal账户',
			buttons:[{
				text:'开始授权',
				handler:function(){
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=ebayaccount&action=createbay',
					   loadMask:true,
					   params: { name: Ext.fly('Ebayid').getValue() },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								window.open(res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
					}
				},{
				text:'完成授权',
				handler:function(){
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=ebayaccount&action=completeEbay',
					   loadMask:true,
					   params: { name: Ext.fly('Ebayid').getValue() },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								Ext.example.msg('Success',res.msg);
								Ext.getCmp('Ebaywin').hide();
								store.reload();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
					}
				}]
			});
		win.show();
	},
	createFormtiems:function(){
		var paypallist = this.paypallist;
        var items = [{
					xtype:'hidden',
					name: 'id'
				},{
					xtype:'textfield',
					fieldLabel: 'Ebay账号',
					labelWidth:85,
					width:250,
					name: 'account_name',
					allowBlank:false
				},{
					xtype:'hidden',
					name:'type',
					value:1	
				}];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f,
				allowBlank:(i<6)?false:true,
				xtype:'textarea',
				labelWidth:85,
				width:280,
				height:55
            });
        }
		this.formitem = items;
	}
});
Ext.define('Ext.ux.TbGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'TbGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'TbGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }, {
            text: 'Taobao账户',
            iconCls: 'x-tbar-add',
            handler: this.creatTaobao.bind(this)
        }];
    },
	
	createColumns: function() {
		var paypallist = this.paypallist;
        var cols = [{xtype: 'rownumberer'},{
						header: '淘宝账号',
						flex:1,
						dataIndex: 'account_name'
					}];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				hidden:true
            });
        }
        this.columns = cols;
    },
	creatTaobao:function()
	{
		if(Ext.getCmp('Taobaowin')){ Ext.getCmp('Taobaowin').show();return;}
		var store = this.store;
		var win = Ext.create('Ext.Window',{
			layout:'fit',
			title:'Taobao账号授权',
			width:280,
			height:150,
			id:'Taobaowin',
			modal: true,
			closable:true,
			closeAction:'hide',
			constrainHeader:true,
			html:'账号:<input type=text id="Tbid"><br>输入新建账号名，点击开始授权登录淘宝进行授权操作,完成后点击完成授权',
			buttons:[{
				text:'开始授权',
				handler:function(){
					Ext.getBody().mask("正在提交数据.请稍等...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=ebayaccount&action=creatTaobao',
					   loadMask:true,
					   params: { name: Ext.fly('Tbid').getValue() },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								window.open(res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
					}
				},{
				text:'完成授权',
				handler:function(){
								Ext.getCmp('Taobaowin').hide();
								store.reload();
					}
				}]
			});
		win.show();
	},	
	createFormtiems:function(){
		var paypallist = this.paypallist;
        var items = [{
				xtype:'hidden',
                name: 'id'
					},{
                fieldLabel: '淘宝账号',
				xtype:'textfield',
                name: 'account_name',
				width:250,
				labelWidth:65,
				allowBlank:false
					},{
						xtype:'hidden',
						name:'type',
						value:3
					}];
        for (var i = 2; i < this.fields.length-3; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f,
				allowBlank:false,
				xtype:'textarea',
				width:250,
				height:40
            });
        }
		this.formitem = items;
	}
});
Ext.define('Ext.ux.ZcGrid',{
    extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
         this.store = Ext.create('Ext.data.JsonStore', {
            fields:this.fields,
            pageSize: this.pagesize,
            autoLoad:true,
            proxy: {
                type: 'ajax',
                url:this.listURL,
                actionMethods:{
                    read:'POST'
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
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            ref: '../editBtn',
            id:'ZcGrid_editBtn',
            disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id:'ZcGrid_removeBtn',
            ref: '../removeBtn',
            disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
    
    createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
                        header: 'Zencart账号',
                        flex:1,
                        dataIndex: 'account_name'
                    },{
                        header: '网址',
                        flex:1,
                        dataIndex: 'url'
                    }];
        for (var i = 3; i < this.fields.length; i++) {
            var f = this.fields[i];
            var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
                hidden:true
            });
        }
        this.columns = cols;
    },
    createFormtiems:function(){
        var paypallist = this.paypallist;
        var items = [{
                xtype:'hidden',
                name: 'id'
                    },{
                fieldLabel: 'Zencart账号',
                xtype:'textfield',
                width:250,
                labelWidth:85,
                name: 'account_name',
                allowBlank:false
                    },{
                        xtype:'hidden',
                        name:'type',
                        value:4
                    },{
                        fieldLabel: '网址',
                        xtype:'textfield',
                        width:250,
                        labelWidth:85,
                        name:'url',
                        allowBlank:false
                    }];
        this.formitem = items;
    }
});
Ext.define('Ext.ux.MgGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
		 this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'MgGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'MgGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
						header: 'Magento账号',
						flex:1,
						dataIndex: 'account_name'
					},{
						header: '网址',
						flex:1,
						dataIndex: 'url'
					}];
        for (var i = 3; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				hidden:true
            });
        }
        this.columns = cols;
    },
	createFormtiems:function(){
		var paypallist = this.paypallist;
        var items = [{
				xtype:'hidden',
                name: 'id'
					},{
                fieldLabel: 'Magento账号',
				xtype:'textfield',
				width:250,
				labelWidth:85,
                name: 'account_name',
				allowBlank:false
					},{
						xtype:'hidden',
						name:'type',
						value:5
					},{
                        fieldLabel: '网址',
                        xtype:'textfield',
                        width:250,
                        labelWidth:85,
                        name:'url',
                        allowBlank:false
                    },{
                        fieldLabel: 'api账号',
                        xtype:'textfield',
                        width:250,
                        labelWidth:85,
                        name:'APIDevUserID',
                        allowBlank:false
                    },{
						fieldLabel: 'api密码',
						xtype:'textfield',
						width:250,
						labelWidth:85,
						name:'APIPassword',
						allowBlank:false
					}];
		this.formitem = items;
	}
});
Ext.define('Ext.ux.AmzGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			id:'AmzGrid_editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'AmzGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
						header: 'Amazon账号',
						flex:1,
						allowBlank:false,
						dataIndex: 'account_name'
					}];
        for (var i = 3; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				hidden:true
            });
        }
        this.columns = cols;
    },
	createFormtiems:function(){
		var sitelist = this.sitelist;
		var paypallist = this.paypallist;
        var items = [{
				xtype:'hidden',
                name: 'id'
					},{
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "value"],
	             data: sitelist
	        }),
	        valueField :"id",
	        displayField: "value",
			width:250,
			labelWidth:85,
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'site',
	        fieldLabel: '站点',
	        name: 'site',
			allowBlank:false,
			blankText:'请选择'
	        },{
                fieldLabel: 'Amazon账号',
				xtype:'textfield',
				allowBlank:false,
				width:250,
				labelWidth:85,
                name: 'account_name'
					},{
						xtype:'hidden',
						name:'type',
						value:2	
					}];
        for (var i = 3; i < this.fields.length-3; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f,
				allowBlank:(i<5)?false:true,
				xtype:'textarea',
				labelWidth:85,
				width:250,
				height:40
            });
        }
        for (var i = this.fields.length-3; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f,
				allowBlank:(i<5)?false:true,
				xtype:'hidden',
				width:250,
				height:40
            });
        }
		this.formitem = items;
	}
});
Ext.define('Ext.ux.EzGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			id:'ezGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'ezGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    },
	
	createColumns: function() {
        var cols = [{xtype: 'rownumberer'},{
						header: '普通账号',
						allowBlank:false,
						flex:1,
						dataIndex: 'account_name'
					}];
        for (var i = 2; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				hidden:true
            });
        }
        this.columns = cols;
    },
	createFormtiems:function(){
		var sitelist = this.sitelist;
		var paypallist = this.paypallist;
        var items = [{
				xtype:'hidden',
                name: 'id'
					},{
                fieldLabel: '账号名',
				width:250,
				xtype:'textfield',
				labelWidth:65,
				allowBlank:false,
                name: 'account_name'
					},{
						xtype:'hidden',
						name:'type',
						value:0	
					}];
		this.formitem = items;
	}
});
Ext.define('Ext.ux.PaypalRootGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			id:'PaypalRootGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			id:'PaypalRootGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }, {
            text: '初始化全部',
            iconCls: 'x-tbar-add',
            handler: function(){
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=ebayaccount&action=autoptype',
					   loadMask:true,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
				}
        }];
	},
	createColumns: function() {
        var cols = [];
		cols.push({xtype: 'rownumberer'});
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
				flex:1,
                dataIndex: f
            });
        }
        this.columns = cols;
    },
	createFormtiems:function(){
		var sitelist = this.sitelist;
		var paypallist = this.paypallist;
        var items = [{
				xtype:'hidden',
                name: 'p_root_id'
				},{
				name:'paypal_account',
				fieldLabel:'主账号',
				xtype:'textfield',
				labelWidth:65,
				width:250,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'username',
				fieldLabel:'username',
				xtype:'textfield',
				width:250,
				labelWidth:65,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'password',
				fieldLabel:'password',
				width:250,
				xtype:'textfield',
				labelWidth:65,
				allowBlank:false,
				blankText:'此项必填'
				},{
				xtype:'textarea',
				name:'signature',
				width:250,
				labelWidth:65,
				fieldLabel:'signature',
				allowBlank:false,
				blankText:'此项必填'
				}];
		this.formitem = items;
	}

});
Ext.define('Ext.ux.AliGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
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
    createTbar: function() {
        this.tbar = [
        {
            text: '编辑',
            iconCls: 'x-tbar-update',
			id:'AliGrid_editBtn',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
			id:'AliGrid_removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(this)
        },
        {
            text: '创建并授权',
            iconCls: 'x-tbar-add',
            handler: this.creatAli.bind(this)
        }];
    },
    createColumns: function() {
        var paypallist = this.paypallist;
        var cols = [{xtype: 'rownumberer'}, {
			flex:1,
            header: '速卖通账号',
            dataIndex: 'account_name'
        }];
        this.columns = cols;
    },
    creatAli: function() {
		if(Ext.getCmp('aliauth')){ Ext.getCmp('aliauth').show();return;}
        var store = this.store;
        var win = Ext.create('Ext.Window',{
            layout: 'fit',
            title: '速卖通账号授权',
            width: 480,
			padding:10,
            height: 380,
            id: 'aliauth',
            modal: true,
            closable: true,
            closeAction: 'hide',
            constrainHeader: true,
            html: '<p>帐号名:&nbsp;&nbsp;<input type=text id="account_name"></p><p>1、请输入您的速卖通帐号名(也可以为任何名字).</p><p>2、点击开始授权,跳转到速卖通授权页面,输入您的速卖通账户名和密码.</p><p>3、授权成功后将Code复制到右下角的Code文本框内，点击完成授权即可完成速卖通帐号的授权操作.</p><p><font style="color:red"><p><b>温馨提示:</b></p><p>授权成功获得Code后，务必在两分钟内粘贴到Code处，并完成授权。否则Code将会失效!</p></font></p><br><p>Code:&nbsp;&nbsp;<input type=text id="alicode"></p>',
            buttons: [{
                text: '开始授权',
                handler: function() {
                    Ext.Ajax.request({
                        url: 'index.php?model=aliexpress&action=auth',
                        method: 'post',
                        params: {
                            account_name: Ext.fly('account_name').getValue()
                        },
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                window.open(res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            },
            {
                text: '完成授权',
                handler: function() {
                    Ext.Ajax.request({
                        url: 'index.php?model=aliexpress&action=overauth',
                        method: 'post',
                        params: {
                            alicode: Ext.fly('alicode').getValue(),account_name: Ext.fly('account_name').getValue()
                        },
                        success: function(response) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                Ext.Msg.alert('提示', res.msg+'<br>同步数据前要记得去【系统用户管理】给这个帐号的可控制权哦。');
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                    Ext.getCmp('aliauth').hide();
                    store.reload();
                }
            }]
        });
        win.show();
    },
    createFormtiems: function() {
        var paypallist = this.paypallist;
        var items = [{
            xtype:'hidden',
            name:'type',
            value:6
        },{
			xtype:'hidden',
			name:'id'
		},
        {
            fieldLabel: 'Aliexpress帐号名',
			width:250,
			xtype:'textfield',
			labelWidth:105,
            name: 'account_name',
            allowBlank: false
        },
        {
            fieldLabel: 'access_token',
			width:250,
			xtype:'textfield',
			labelWidth:105,
            name: 'ac_token',
            allowBlank: false
        },
        {
            fieldLabel: 'refresh_token',
			width:250,
			xtype:'textfield',
			labelWidth:105,
            name: 're_token',
            allowBlank: false
        }];
        this.formitem = items;
    }
});

Ext.define('Ext.ux.DHGrid',{
    extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent(this);
    },
    createStore: function() {
        this.store = Ext.create('Ext.data.JsonStore', {
            fields:this.fields,
            pageSize: this.pagesize,
            autoLoad:true,
            proxy: {
                type: 'ajax',
                url:this.listURL,
                actionMethods:{
                    read:'POST'
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
    createTbar: function() {
        this.tbar = [
        {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id:'DHGrid_editBtn',
            ref: '../editBtn',
            disabled: true,
            handler: this.updateRecord.bind(this)
        },
        {
            text: '删除',
            iconCls: 'x-tbar-del',
            ref: '../removeBtn',
            id:'DHGrid_removeBtn',
            disabled: true,
            handler: this.removeRecord.bind(this)
        },
        {
            text: '创建并授权',
            iconCls: 'x-tbar-add', 
            handler: this.creatDHgate.bind(this)
        }];
    },
    createColumns: function() {
        var paypallist = this.paypallist;
        var cols = [{xtype: 'rownumberer'}, {
            flex:1,
            header: 'DHgate账号',
            dataIndex: 'account_name'
        }];
        this.columns = cols;
    },
    creatDHgate: function() {
        
        var store = this.store;
        var win = Ext.create('Ext.Window',{
            layout: 'fit',
            title: 'DHgate账号授权',
            width: 480,
            padding:10,
            height: 220,
            id: 'dhauth',
            modal: true,
            closable: true,
            closeAction: 'hide',
            constrainHeader: true,
            html: '<p>帐号名:&nbsp;&nbsp;<input type=text id="dh_account_name"></p><p>1、请输入您的敦煌网帐号名(也可以为任何名字).</p><p>2、点击开始授权,跳转到敦煌网授权页面,输入您的敦煌网账户名和密码.</p></p>',
            buttons: [{
                text: '开始授权',
                handler: function() {
                    
                    if(Ext.fly('dh_account_name').getValue() == '')Ext.Msg.alert('ERROR', '请输入一个用户名');
                    Ext.Ajax.request({
                        url: 'index.php?model=DH&action=Auth',
                        method: 'post',
                        params: {
                            account_name: Ext.fly('dh_account_name').getValue()
                        },
                        success: function(response, opts) {
                            var res = Ext.decode(response.responseText);
                            if (res.success) {
                                window.open(res.msg);
                            } else {
                                Ext.Msg.alert('ERROR', res.msg);
                            }
                        }
                    });
                }
            },
            {
                text: '完成授权',
                handler: function() { 
                    Ext.Ajax.request({
                        url: 'index.php?model=DH&action=OverAuth',
                        method: 'post',
                        params: {
                            account_name: Ext.fly('dh_account_name').getValue()
                        },
                        success: function(response, opts) {
                            //var res = Ext.decode(response.responseText);
                            Ext.Msg.alert('MSG', response.responseText);
                            store.reload();
                        }
                    });
                }
            }]
        });
        win.show();
    },
    createFormtiems: function() {
        var paypallist = this.paypallist;
        var items = [{
            xtype:'hidden',
            name:'id'
        },{
            xtype:'hidden',
            name:'type',
            value:7
        },
        {
            fieldLabel: 'DHgate帐号名',
            width:250,
            xtype:'textfield',
            labelWidth:105,
            name: 'account_name',
            allowBlank: false
        },
        {
            fieldLabel: 'access_token',
            width:250,
            xtype:'textfield',
            labelWidth:105,
            name: 'ac_token',
            allowBlank: false
        },
        {
            fieldLabel: 'refresh_token',
            width:250,
            xtype:'textfield',
            labelWidth:105,
            name: 're_token',
            allowBlank: false
        }];
        this.formitem = items;
    }
});
