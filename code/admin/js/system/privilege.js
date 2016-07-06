Ext.define('Ext.ux.PrivilegeGrid',{
	extend:'Ext.grid.Panel',
	initComponent: function() {
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.createTypeStore();
        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
        this.callParent();
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=privilege&action=list',
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		})
    },

    createTypeStore: function() {
		this.typestore = Ext.create('Ext.data.JsonStore', {
			fields:['id','action_type_name'],
			pageSize: this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=privilege&action=typelist',
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		})
		this.typestore.load();
    },
	createColumns: function() {
        var cols = [];
		cols.push({xtype: 'rownumberer'});
        for (var i = 1; i < this.fields.length -1; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
				flex:1,
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },

    createTbar: function() {
        this.tbar = Ext.create('Ext.toolbar.Toolbar', {
			items : [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            handler: this.updateRecord.bind(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            handler: this.removeRecord.bind(this)
        }, {
            text: '分类',
            iconCls: 'x-tbar-import',
            handler: function(){parent.openWindow('privilegetype','权限分类','index.php?model=privilege&action=type',400,240);}
        },'-','模块分类',{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: [['1','系统设置'],['2','产品管理'],['5','采购管理'],['6','仓储管理'],['3','销售管理'],['9','财务账款'],['10','统计报表'],['8','模板设置'],['7','售后服务'],['root','root']]
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:120,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					id:'action_type',
					name:'action_type',
					value:'root',
					allowBlank:false,
					listeners:{
					"select":{
						fn:function(e,rowindex,record){
							Ext.getCmp('ActionGrid').getStore().load({params:{start:0,limit:50,root:e.getValue()}});
						}
					}	
				}}]
		});
    },

    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = Ext.create('Ext.PagingToolbar',{
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    },

    createRecord: function() {
        this.showWindow();
        var form = this.getForm();
        form.baseParams = {
            create: true
        };
        form.setValues(this.getEmptyRecord());
    },

    updateRecord: function() {
        var r = this.getSelectedRecord();
        if (r != false) {
            this.showWindow();
            var form = this.getForm();
            form.baseParams = {
                create: false
            };
            form.loadRecord(r);
        }
    },

    removeRecord: function() {
        var r = this.getSelectedRecord();
		var ids = getIds(this);
        if (r != false) {
            Ext.Msg.confirm('Info', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: 'index.php?model=privilege&action=delete&ids='+ids,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('MSG',res.msg);
								}						
							}
						});
                    this.getStore().remove(r);
                }
            }, this);

        }
    },

    getSelectedRecord: function() {
        var sm = this.getSelectionModel();
        if (sm.getCount() == 0) {
            Ext.example.msg('Info', 'Please select one row.');
            return false;
        } else {
            return sm.getSelection()[0];
        }
    },

    getEmptyRecord: function() {
        var r = {};
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
            r[f] = '';
        }
        return r;
    },

    submitRecord: function() {
        var form = this.getForm();
        var values = form.getFieldValues();
        /*if (form.baseParams.create) {
            var data = [];
            for (var name in values) {
                data.push(values[name]);
            }
            this.store.loadData([data], true);
        } else {
            var r = this.getSelectedRecord();
            r.beginEdit();
            for (var name in values) {
                r.set(name, values[name]);
            }
            r.endEdit();
        }
        */
		var thiz = this.store;
					if(form.isValid()){
						form.doAction('submit',{
							 url:'index.php?model=privilege&action=update',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										thiz.reload();
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
							 		}
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
                      });
					}
		this.hideWindow();
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

    createForm: function() {
        var items = [];
		items.push({
				xtype:'hidden',
                name: this.fields[0]
            });
        for (var i = 1; i < this.fields.length-2; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            items.push({
                fieldLabel: h,
                name: f
            });
        }
		items.push({
			xtype:'combo',
			store: this.typestore,
			valueField :"id",
			displayField: "action_type_name",
			mode: 'local',
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'action_type',
			allowBlank:false,
			fieldLabel: '权限类别',
			emptyText:'Choose One',
			name: 'action_type'
		});
		var Employee = Ext.define('Employee', {
			extend: 'Ext.data.Model',
			fields: [{
					name: 'id'
				},{
					name: 'action_code'
				}, {
					name: 'action_name'
				},{
					name: 'action_name'
				},{
					name: 'action_type_name'
				},{
					name: 'action_type'
				}
		]
		});
		var myReader = new Ext.data.reader.Array({
			model: 'Employee'
		}, Employee);
        var form = Ext.create('Ext.form.FormPanel',{
            frame: false,
			border:false,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            trackResetOnLoad: true,
            reader: myReader,
            items: items,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.bind(this)
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

        var win = Ext.create('Ext.window.Window',{
            title: 'Info',
            closeAction: 'hide',
			padding:10,
			border:false,
			width:350,
			height:220,
            modal: true,
            items: [
                formPanel
            ]
        });

        return win;
    }
});
