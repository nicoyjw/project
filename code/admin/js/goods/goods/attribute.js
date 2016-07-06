Ext.ux.AttributeGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
		this.creatselectionmodel();
        Ext.ux.AttributeGrid.superclass.initComponent.call(this);
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
				keyword:Ext.fly('keyword').dom.value,
				entity_type_id:Ext.getCmp('entity_type_id').value,
				is_required:Ext.getCmp('is_required').value,
				is_unique:Ext.getCmp('is_unique').value,
				is_update_notice:Ext.getCmp('is_update_notice').value
			});
		});
	},
	createColumns: function() {
        var cols = [new Ext.grid.RowNumberer(),{
						header: '属性内部编码',
						dataIndex: 'attribute_code'
					},{
						header: '是否必填',
						dataIndex: 'is_required',
						width:80,
				  		renderer:function(v){return (v == 0)?'否':'是';}
					},{
						header: '是否唯一',
						dataIndex: 'is_unique',
						width:80,
				  		renderer:function(v){return (v == 0)?'否':'是';}
					},{
						header: '提示更新',
						dataIndex: 'is_update_notice',
						width:80,
				  		renderer:function(v){return (v == 0)?'否':'是';}
					},{
						header: '属性标签',
						dataIndex: 'attribute_label'
					},{
						header: '属性备注',
						dataIndex: 'note'
					}];
        this.columns = cols;
    },
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.createDelegate(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this),
			
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        },'->','标签类型',{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: en_type_all
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:120,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				id:'entity_type_id',
				value:0,
				allowBlank:false,
				},'-','必填',{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: [['-1','所有类型'],['0','否'],['1','是']]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:80,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				id:'is_required',
				value:-1,
				allowBlank:false,
				},'-','唯一',{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: [['-1','所有类型'],['0','否'],['1','是']]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:80,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				id:'is_unique',
				value:-1,
				allowBlank:false,
				},'-','提示更新',{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: [['-1','所有类型'],['0','否'],['1','是']]
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:80,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				id:'is_update_notice',
				value:-1,
				allowBlank:false,
				},'-','关键词:',{
						xtype:'textfield',
						id:'keyword',
					    name:'keyword',
						enableKeyEvents:true,
						listeners:{
						scope:this,
						keypress:function(field,e){
							if(e.getKey()==13){
							store.load({params:{start:0, limit:pagesize,
								keyword:field.getValue()
								}});
								}
							}
						}
					},'-',{
						xtype:'button',
						text:'搜索',
						iconCls:'x-tbar-search',
						handler:function(){
							store.load({params:{
								start:0,
								limit:pagesize,
								keyword:Ext.fly('keyword').dom.value,
								entity_type_id:Ext.getCmp('entity_type_id').value,
								is_required:Ext.getCmp('is_required').value,
								is_unique:Ext.getCmp('is_unique').value,
								is_update_notice:Ext.getCmp('is_update_notice').value
								}});
							}
					}];
    },
	creatselectionmodel:function(){
		var sm = new Ext.grid.RowSelectionModel({
						singleSelect:true,
						listeners:{
							"rowselect":{
								fn:function(e,rowindex,record){
									if(record.data.entity_type_id ==3 || record.data.entity_type_id ==4 || record.data.entity_type_id  == 5){
										Ext.getCmp('addBtn').setDisabled(false);
										Ext.getCmp('delBtn').setDisabled(false);
										Ext.getCmp('AttributeValueGrid').setid(record.data.attribute_id);
										Ext.getCmp('AttributeValueGrid').setTitle("编辑属性"+record.data.attribute_code+"属性值列表");
									}else{
										Ext.getCmp('addBtn').setDisabled(true);
										Ext.getCmp('delBtn').setDisabled(true);
									}
									this.grid.removeBtn.setDisabled(false);
									this.grid.editBtn.setDisabled(false);
									Ext.getCmp('AttributeValueGrid').getStore().load({
									params:{start:0,limit:10,attribute_id:record.data.attribute_id,entity_type_id:record.data.entity_type_id}
									});
									Ext.getCmp('AttributeValueGrid').calculate();
								}
								}
							}								 
						});
			this.sm = sm;
	},
	createFormtiems:function(){
		var sst = Ext.getCmp("attrgrid").getSelectionModel().getSelected();
		var tagg = new Array();
		var tvalue = '';
		for (var i = 1; i < languages.length; i++) { 
			tvalue = (sst) ? sst.get(language_tag(i)) : '';
			var isblank = (i == 1) ? false : true;
			tagg.push({
				fieldLabel : language_value(i),
				name:language_tag(i),
				id:language_tag(i),
				allowBlank:isblank,
				xtype: 'textfield',
				value: tvalue
			});
					
		}
		if(sst){
			var is_required = sst.get('is_required');
			var is_unique = sst.get('is_unique');
			var entity_type_id = sst.get('entity_type_id');
			var is_update_notice = sst.get('is_update_notice');
		}
		this.formitem = [{
				xtype:'hidden',
                name: 'attribute_id'
				},{
				xtype: 'fieldset',
				labelWidth: 80,
				width:380,
				title: '属性基础信息',
				border:true,
				collapsible: true,
				items: [
					{
				name:'attribute_code',
				fieldLabel:'属性内部编码',
				allowBlank:false,
				xtype: 'textfield',
				width:150
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: option_value
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:150,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'is_required',
				name: 'is_required',
				value:is_required,
				fieldLabel: '是否必填'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: option_value
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:150,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'is_unique',
				name: 'is_unique',
				value:is_unique,
				fieldLabel: '是否唯一'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: en_type
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:150,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'entity_type_id',
				name: 'entity_type_id',
				allowBlank:false,
				value:entity_type_id,
				fieldLabel: '属性标签类型'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: option_value
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:150,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'is_update_notice',
				name: 'is_update_notice',
				value:is_update_notice,
				fieldLabel: '提示更新'
				},{
				xtype:'textarea',
				name:'note',
				width:180,
				fieldLabel:'属性备注'
				}
				]
			},{
				xtype: 'fieldset',
				labelWidth: 80,
				width:380,
				title: '属性标签多语言',
				border:true,
				collapsible: true,
				items: [
					tagg,{
					text:'自动翻译',
					width:30,
					style:'margin-top:10px;margin-left:56px',
					xtype:'button',
					handler: function() {
						if(Ext.getCmp('1_tag').getValue()){
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							Ext.Ajax.request({
							    url: '?model=attribute&action=translateword',
							    params:{'value_cn':Ext.getCmp('1_tag').getValue()},
								success:function(response,opts){
									Ext.getBody().unmask();
									var res = Ext.decode(response.responseText);
									for (var key in res)
									{
										if (key == 1) continue;
										Ext.getCmp(key + '_tag').setValue(HtmlDecode(res[key]));
									}
								 }
							});	
						}else{
							Ext.example.msg('MSG','请先填入中文');
						}
					}
				}
				]
			}];
		
	},

});
Ext.ux.AttributeValueGrid = Ext.extend(Ext.grid.EditorGridPanel, {
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.clicksToEdit = 1,
		this.sm = new Ext.grid.RowSelectionModel({singleSelect:true});
        this.createStore();
        this.createColumns();  
		this.createTbar();
		this.createBbar();
		this.getSelectionModel().on('selectionchange', function(sm){
			this.removeBtn.setDisabled(sm.getCount() < 1);
			this.editBtn.setDisabled(sm.getCount() < 1);
		});
		Ext.ux.AttributeValueGrid .superclass.initComponent.call(this);
    },
	setid:function(id){
		this.attribute_id = id;
	},
	getid:function(){
		return this.attribute_id;
	},
    createStore: function() {
		var thiz = this;
        this.store = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:this.listURL}),
		pageSize: this.pagesize,
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: this.fields[0]
			},this.fields),
			listeners : {
				'load' : this.calculate.createDelegate(this),
				'add' : this.calculate.createDelegate(this),
				'remove' : this.calculate.createDelegate(this),
				'update' : this.calculate.createDelegate(this)
			}
    	});
		this.store.on('beforeload',function(){
			Ext.apply(
			this.baseParams,
			{
				attribute_id:thiz.getid()
			});
		});
    },
	calculate:function(){
		if(this.store.getCount() > 0) {
			Ext.getCmp('saveBtn').setDisabled(false);
			Ext.getCmp('removeBtn').setDisabled(false);
			Ext.getCmp('delBtn').setDisabled(false);
			Ext.getCmp('defauleBtn').setDisabled(false);
		}else{
			Ext.getCmp('saveBtn').setDisabled(true);
			Ext.getCmp('removeBtn').setDisabled(true);
			Ext.getCmp('delBtn').setDisabled(true);
			Ext.getCmp('defauleBtn').setDisabled(true);
		}
	},
	createColumns: function() {
		var cols = [new Ext.grid.RowNumberer(),{
						header : '中文<font color=red>*</font>',
						dataIndex:'value',
						width:30,
						align : 'left',
						editor:new Ext.form.TextField({
								allowBlank:false,
								hideLabel:true
						}),
						renderer:function(val,x,rec){
							var html = '';
							if(rec.get('is_default') == 'yes'){
								html = val+'&nbsp;&nbsp;<img src="themes/default/images/icon_accept.gif" width="12px"/>';
							}else{
								html = val;
							}
					   		return html;
					   }
					}];
        this.columns = cols;
		for (var i = 2; i < languages.length; i++) {
			cols.push({
				header : language_value(i),
				dataIndex:language_option(i),
				width:30,
				align : 'left',
				editor:new Ext.form.TextField({
						allowBlank:false,
						hideLabel:true
				})
			});			
		}
    },
    createTbar: function() {
		var getid = this.getid;
		var store = this.store;
        this.tbar = new Ext.Toolbar({
						items : [{
							xtype:'button',
							text:'新增属性值',
							id: 'addBtn',
							disabled:true,
							ref: '../addBtn',
							iconCls: 'x-tbar-add',
							handler:this.createWindow.createDelegate(this,['0'])
						},{
							text: '删除属性值',
							iconCls: 'x-tbar-del',
							id: 'removeBtn',
							ref: '../removeBtn',
							handler: this.removeItem.createDelegate(this),
							disabled:true
						},{
							text: '保存属性值列表',
							iconCls: 'x-tbar-save',
							ref: '../saveBtn',
							id: 'saveBtn',
							handler: this.saveItem.createDelegate(this),
							disabled:true
						},{
							text: '清空此属性值列表',
							iconCls: 'x-tbar-del',
							id: 'delBtn',
							ref: '../delBtn',
							disabled:true,
							handler: this.delItem.createDelegate(this)
						},{
							text: '设为默认值',
							iconCls: 'x-tbar-save',
							id: 'defauleBtn',
							ref: '../saveBtn',
							disabled:true,
							handler: this.setDefault.createDelegate(this)
						},'(复选类型可设多个默认，下拉、单选只能设一个默认值)']
					});
    },
    createBbar: function() {
		var pagesize = this.pagesize;
        this.bbar = new Ext.PagingToolbar({
			plugins: new Ext.ui.plugins.ComboPageSize(),
			pageSize: pagesize,
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
            store: this.store			   
        });
    },
    createWindow: function(num) {
		var taggg = new Array();
		for (var i = 1; i < languages.length; i++) { 
		var isblank = (i == 1) ? false : true;
			taggg.push({
				fieldLabel : language_value(i),
				name:language_tag(i),
				id:language_tag(i)+'2',
				allowBlank:isblank,
				xtype: 'textfield',
				value: ''
			});
					
		}
		var formitem1 = [taggg];
		var newform = new Ext.form.FormPanel({
            frame: true,
            defaultType: 'textfield',
			id:'newform',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 80,
            items: [formitem1,{
					text:'自动翻译',
					width:30,
					style:'margin-top:10px;margin-left:56px',
					xtype:'button',
					handler: function() {
						if(Ext.getCmp('1_tag2').getValue()){
							Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
							Ext.Ajax.request({
							    url: '?model=attribute&action=translateword&id='+i,
							    params:{'value_cn':Ext.getCmp('1_tag2').getValue()},
								success:function(response,opts){
									Ext.getBody().unmask();
									var res = Ext.decode(response.responseText);
									for (var key in res)
									{
										if (key == 1) continue;
										Ext.getCmp(key + '_tag2').setValue(HtmlDecode(res[key]));
									}
								 }
							});	
						}else{
							Ext.example.msg('MSG','请先填入中文');
						}
					}
				}],
            buttons: [{
                text: '提交',
                handler: function(){
					var grid11 = Ext.getCmp("attrgrid").getSelectionModel().getSelected();
					var aid = grid11.get('attribute_id');
					var form = newform.getForm();
					var thiz = Ext.getCmp('AttributeValueGrid').store;
					if(form.isValid()){
						form.doAction('submit',{
							 url:'index.php?model=attribute&action=valueupdate',
							 method:'post',
							 params:{attribute_id:aid},
							 success:function(form,action){
							 		if (action.result.success) {
										Ext.example.msg('MSG',action.result.msg);
										window.location="javascript:location.reload()";
										
										thiz.reload();
									} else {
										Ext.Msg.alert('修改失败',action.result.msg);
							 		}
							 },
							 failure:function(form,action){
									Ext.example.msg('操作',action.result.msg);
							 }
                      });
					}
				win.hide();
				}
            }, {
                text: '重置',
                handler: function() {
                    newform.getForm().reset();
                }
            }]
        });
        var win = new Ext.Window({
            title: '新增属性值',
			closable:true,
			width:350,
			autoHeight:true,
			autoScroll:true,
            modal: true,
            items: [newform]
        });
		win.show();
    },
	removeItem:function(){
		
		if(this.store.getCount() == 0) {
				Ext.example.msg('错误','属性值数据不能为空');
				return false;
				}
		var data = this.getSelectionModel().getSelected();
		var index = this.store.findBy(function(record,id){
				return record.get('value') == data.get('value');									
													});
		var id = data.get('value_id');
		if(id ==0){
			this.store.remove(this.store.getAt(index));return;
		}
		var thiz = this.store;
		var delURL = this.delURL;
        if (id) {
            Ext.Msg.confirm('Delete Alert!', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: delURL+'&id='+id,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								thiz.reload();
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
	saveItem:function(){
			var thiz = this.store;
			if(thiz.getCount() == 0) {
				Ext.example.msg('错误','属性值数据不能为空');
				return false;
				}
			var jsonArray = [];
				var m = this.store.modified.slice(0);
				Ext.each(m,function(item){
					jsonArray.push(item.data);
				});
            Ext.Msg.confirm('保存数据', '确定提交?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.saveURL,
					   params:{'data':Ext.encode(jsonArray)},
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								thiz.commitChanges();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
	},
	translation_value:function(){
		alert();
	},
	delItem:function(){
		var id = this.getid();
		if(!id) return false;
		var thiz = this.store;
            Ext.Msg.confirm('确定清空此属性值', '确定提交?', function(btn) {
                if (btn == 'yes') {
					Ext.Ajax.request({
					   url: this.clearURL,
					   params:{'id':id},
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								thiz.reload();
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
                }
            }, this);
	},setDefault:function(){
		if(this.store.getCount() == 0) {
				Ext.example.msg('错误','属性值数据不能为空');
				return false;
				}
		var data = this.getSelectionModel().getSelected();
		var index = this.store.findBy(function(record,id){
				return record.get('value') == data.get('value');									
		});
		var value_id = data.get('value_id');
		//alert(value_id);return;
		var thiz = this.store;
		var id = this.getid();
		if(!id) return false;
		var thiz = this.store;
		Ext.Ajax.request({
		   url: this.setURL,
		   params:{'id':id,'value_id':value_id},
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
					if(res.success){
					Ext.example.msg('MSG',res.msg);
					thiz.reload();
					}else{
					Ext.Msg.alert('ERROR',res.msg);
					}						
				}
			});
	}
});

var HtmlDecode = function(str) {
	var t = document.createElement("div");
	t.innerHTML = str;
	return t.textContent || t.innerText;
}