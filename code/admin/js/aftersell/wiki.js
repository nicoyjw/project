Ext.ux.WikiGrid = Ext.extend(Ext.grid.GridPanel, {
	initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		//this.loadMask = true;
		this.pagesize = 10,
        this.createStore();
		this.createFormtiems();
        this.createTbar();
        this.createBbar();
        this.createColumns();
		this.getSelectionModel().on('selectionchange', function(sm){
			this.grid.removeBtn.setDisabled(sm.getCount() < 1);
			this.grid.editBtn.setDisabled(sm.getCount() < 1);
		});
		this.on('rowdblclick', this.onRowDblClick, this);
        Ext.ux.WikiGrid.superclass.initComponent.call(this);
    },
    onRowDblClick: function(grid, rowIndex, e) {
		var id = this.store.getAt(rowIndex).get('id');
		parent.openWindow(id,'查看百科明细','index.php?model=wiki&action=getdetail&id='+id,1000,700);
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
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				type:Ext.getCmp('wikitype').getValue(),
				keyword:Ext.fly('keyword').dom.value
			});
		});
	},
	
	createColumns: function() {
        var cols = [];
		var rend = this.rend;
		cols.push(new Ext.grid.RowNumberer());
        for (var i = 1; i < 8; i++) {
            var f = this.fields[i];
			var h = this.headers[i];
			if( i== 3){
				cols.push({
					header: h,
					dataIndex: f,
					renderer:rend
				});
			}else{
            cols.push({
                header: h,
                dataIndex: f
            });
			}
        }
        this.columns = cols;
    },

	createFormtiems:function(){
		var wikitype = this.wikitype;
		this.formitem = [{
				xtype:'hidden',
                name: this.fields[0]
			},{
				allowBlank:false,
				blankText:'此项必填',
				fieldLabel: '标题',
                name: 'title'
			},{
				fieldLabel: '关键词',
                name: 'sku'
			},{
					xtype:'combo',
					store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: wikitype
							}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:130,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'type',
					name: 'type',
					allowBlank:false,
					fieldLabel: '分类'
            },new Ext.ux.form.FCKeditor({
					name : "description", 
					width:400,
					height : 230, 
					fieldLabel : "描述", 
			}),{
				fieldLabel: '更新附件',
				inputType: 'file',
				xtype: 'textfield',
				name:'attachment'
			}];
	},

    createTbar: function() {
		var store = this.store;
		var pagesize = this.pagesize;
		var wikitype = this.wikitype;
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
        },'->',{
								xtype:'combo',
								store: new Ext.data.SimpleStore({
									 fields: ["id", "key_type"],
									 data: wikitype
								}),
								valueField :"id",
								displayField: "key_type",
								mode: 'local',
								editable: false,
								hiddenName:'wikitype',
								triggerAction: 'all',
								fieldLabel: '分类',
								pagesise:10,
								width:130,
								id:'wikitype'							
							},'-',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
								store.load({params:{start:0, limit:pagesize,
									type:Ext.getCmp('wikitype').getValue(),
									keyword:Ext.fly('keyword').dom.value
									}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{start:0, limit:pagesize,
								type:Ext.getCmp('wikitype').getValue(),
								keyword:Ext.fly('keyword').dom.value
								}});
							}
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
										Ext.example.msg('MSG',action.result.msg);
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
								 	console.log(action);
									Ext.example.msg('操作','错误:'+action.result.msg);
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
			fileUpload : true,
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

