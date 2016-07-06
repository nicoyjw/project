Ext.ux.NormalGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		//this.loadMask = true;
		this.getpagesize();
		//this.pagesize = 10,
        this.createStore();
		this.createTypeStore();
		this.createFormtiems();
        this.createTbar();
        this.createBbar();
        this.createColumns();
		this.getSelectionModel().on('selectionchange', function(sm){
			this.grid.removeBtn.setDisabled(sm.getCount() < 1);
			this.grid.editBtn.setDisabled(sm.getCount() < 1);
		});
        Ext.ux.NormalGrid.superclass.initComponent.call(this);
    },
	getpagesize:function()
	{
		if(!this.pagesize) this.pagesize =10;	
	},
	createTypeStore:function(){
	},
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pruneModifiedRecords:true,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields)
    	});
	},
	
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f
            });
        }
        this.columns = cols;
    },

	createFormtiems:function(){
		this.formitem = this.formitems;
	},

    createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        }];
    },

    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
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
	
	afterEdit:function(){
	},

	afterRemove:function(){
	},

    removeRecord: function() {
        var r = this.getSelectionModel().getSelections();
		var ids = getIds(this);
		var thiz = this.store;
		afterRemove = this.afterRemove;
        if (r != false) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.delURL+'&ids='+ids,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.remove(r);
								afterRemove();
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
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
        var values = form.getFieldValues();
		afterEdit = this.afterEdit;
		var thiz = this.store;
					if(form.isValid()){
						form.doAction('submit',{
							 url:this.saveURL,
							 method:'post',
							 params:'',
							 success:function(form,action){
							 		if (action.result.success) {
										thiz.reload();
										afterEdit();
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.example.msg('操作',action.result.msg);
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
        var form = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 70,
            trackResetOnLoad: true,
            reader: new Ext.data.ArrayReader({
                fields: this.fields
            }),
            items: this.formitem,
            buttons: [{
                text: 'submit',
                handler: this.submitRecord.createDelegate(this)
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
            title: this.windowTitle,
            closeAction: 'hide',
			constrainHeader:true,
			width:this.windowWidth,
			height:this.windowHeight,
            modal: true,
            items: [
                formPanel
            ]
        });

        return win;
    }
});

