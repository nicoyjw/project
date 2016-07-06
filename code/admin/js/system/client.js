Ext.define('Ext.ux.PrivilegeGrid',{
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
			pageSize: this.pagesize,
			proxy: {
				type: 'ajax',
				url:'index.php?model=system&action=Clientlist',
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'user_id',
					root: 'topics'
				}
			}
		})
    },
	createColumns: function() {
        var cols = [];
		var ve = this.ve;
		cols.push({xtype: 'rownumberer'});
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
			if(f == 'versions'){
				cols.push({
					flex:1,
					header: h,
					dataIndex: f,
				    renderer:function(v,x,rec){
					   var str = comrender(v,ve);
					   return str;
				    }
				});
			}else{
				cols.push({
					flex:1,
					header: h,
					dataIndex: f
				});
			} 
        }
        this.columns = cols;
    },
    createTbar: function() {
        this.tbar = Ext.create('Ext.toolbar.Toolbar',{items:
			[{
				text: '添加客户',
				iconCls: 'x-tbar-add',
				handler: this.createRecord.bind(this)
			}, {
				text: '删除',
				iconCls: 'x-tbar-del',
				handler: this.removeRecord.bind(this)
			}]
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
					   url: 'index.php?model=system&action=deleteclient&ids='+ids,
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
            return sm.getSelections()[0];
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
        //var values = form.getFieldValues();
		//alert(values);return;
		var thiz = this.store;
		var name = form.getFieldValues().name;
		var qq = form.getFieldValues().qq;
		var qqname = form.getFieldValues().qqname;
		var tel = form.getFieldValues().tel;
		var versions = form.getFieldValues().versions;
		var company = form.getFieldValues().company;
		parent.newTab('ebayload','新增客户','index.php?model=system&action=createclient&company='+company+'&name='+name+'&qq='+qq+'&qqname='+qqname+'&tel='+tel+'&versions='+versions);
    },
	addclient:function(){
		
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
		var ve = this.ve;
		items.push({
				xtype:'hidden',
                name: this.fields[0]
            });
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
			if((i >= 4) && (f !== 'countorder') && (f !== 'versions')){
				items.push({
					fieldLabel: h,
					name: f
				});
			}
        }
		items.push({
	        xtype:'combo',
	        store: Ext.create('Ext.data.ArrayStore',{
	             fields: ["id", "value"],
	             data: ve
	        }),
	        valueField :"id",
	        displayField: "value",
	        mode: 'local',
	        editable: false,
	        forceSelection: true,
	        triggerAction: 'all',
	        hiddenName:'versions',
	        fieldLabel: '版本',
	        name: 'versions',
			allowBlank:false,
			blankText:'请选择版本'
	        });
        var form = Ext.create('Ext.form.FormPanel',{
            frame: false,
			border:false,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
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

        var win = new Ext.Window({
            title: '新增客户',
            closeAction: 'hide',
			border:false,
			padding:15,
			width:350,
			height:280,
            modal: true,
            items: [
                formPanel
            ]
        });

        return win;
    }
});
