
Ext.ux.PrivilegetypeGrid = Ext.extend(Ext.grid.EditorGridPanel, {
    initComponent: function() {
        this.autoHeight = true;
        this.viewConfig = {
            forceFit: true
        };

        this.createStore();
        this.createColumns();
        this.createTbar();
        this.createBbar();
		this.loaddata();
        Ext.ux.PrivilegetypeGrid.superclass.initComponent.call(this);
    },
    createStore: function() {
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:'index.php?model=privilege&action=typelist'}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: 'id'
			},this.fields)
    	});
    },
	
	loaddata:function(){
		this.store.load({
			params:{start:0,limit:10},
			scope:this.store
			})
		},
	
	createColumns: function() {
        var cols = [];
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < this.fields.length; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
            cols.push({
                header: h,
                dataIndex: f,
				editor:new Ext.grid.GridEditor(new Ext.form.TextField({
							allowBlank:false	
						}))
            });
        }
        this.columns = cols;
    },

    createTbar: function() {
        this.tbar = new Ext.Toolbar([{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '保存',
            iconCls: 'x-tbar-update',
            handler: this.updateRecord.createDelegate(this)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            handler: this.removeRecord.createDelegate(this)
        }]);
    },

    createBbar: function() {
        this.bbar = new Ext.PagingToolbar({
			pageSize: 10,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store
        });
    },

    createRecord: function() {
		var myrecord = Ext.data.Record.create([{name:'id',type:'string'},{name:'action_type_name',type:'string'}]);
		var p = new myrecord({id:'',action_type_name:''});
		this.stopEditing();
		this.store.insert(0,p);
		this.startEditing(0, 1)
    },

    updateRecord: function() {
		var m = this.store.modified.slice(0);
		var jsonArray = [];
		Ext.each(m,function(item){
			jsonArray.push(item.data);				
			});
		var thisstore = this.store;
		if(jsonArray.length > 0) {
			Ext.Ajax.request({
					url:'index.php?model=privilege&action=typeupdate',	 
					method:'POST',
					params:{'data':Ext.encode(jsonArray)},
					success:function(response,opts){
							var res = Ext.decode(response.responseText);
							if(res.success){
							Ext.example.msg('MSG',res.msg);
							thisstore.commitChanges();
							}else{
							Ext.Msg.alert('MSG',res.msg);
							}
						},
					failure:function(){
							Ext.example.msg('MSG','保存失败'),
							thisstore.rejectChanges();
						}
				})
			}		
	},

    removeRecord: function() {
		var sm = this.getSelectionModel();
		if(!sm.selection){
			Ext.example.msg('MSG','请选中需要删除的分类');
			return false;
		}
		var r = this.store.getAt(sm.getSelectedCell()[0]); 
		var thisstore = this.store;
        if (r != false) {
            Ext.Msg.confirm('Info', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
						Ext.Ajax.request({
								url:'index.php?model=privilege&action=Typedel',	 
								method:'POST',
								params:{'id':r.data.id},
								success:function(response,opts){
										var res = Ext.decode(response.responseText);
										if(res.success){
										Ext.example.msg('MSG',res.msg);
										thisstore.remove(r);
										}else{
										Ext.Msg.alert('MSG',res.msg);
										}
									},
								failure:function(){
										Ext.example.msg('MSG','保存失败'),
										thisstore.rejectChanges();
									}
							})
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
        if (form.baseParams.create) {
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
        for (var i = 0; i < this.fields.length; i++) {
            var f = this.fields[i];
            items.push({
                fieldLabel: f,
                name: f
            });
        }

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
            items: items,
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
            title: 'Info',
            closeAction: 'hide',
			width:300,
			height:180,
            modal: true,
            items: [
                formPanel
            ]
        });

        return win;
    }
});
