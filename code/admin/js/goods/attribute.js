Ext.define('Ext.ux.AttributeGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
		this.creatselectionmodel();
        this.callParent();
    },
    createStore: function() {
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			pageSize:  this.pagesize,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read:'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			}
		});
		this.store.on('beforeload',function(){
			Ext.apply(
				this.baseParams,{
					keyword:Ext.getCmp('keyword').getValue(),
					entity_type_id:Ext.getCmp('entity_type_id').getValue(),
					is_required:Ext.getCmp('is_required').getValue(),
					is_unique:Ext.getCmp('is_unique').getValue(),
					is_update_notice:Ext.getCmp('is_update_notice').getValue()
			});
		});
	},
	//创建列
	createColumns: function() {
        var cols = [{
			xtype: 'rownumberer'
		},{
			header: '属性内部编码',
			flex:2,
			dataIndex: 'attribute_code'
		},{
			header: '是否必填',
			dataIndex: 'is_required',
			flex:1,
			renderer:function(v){return (v == 0)?'否':'是';}
		},{
			header: '是否唯一',
			dataIndex: 'is_unique',
			flex:1,
			renderer:function(v){return (v == 0)?'否':'是';}
		},{
			header: '提示更新',
			dataIndex: 'is_update_notice',
			flex:1,
			renderer:function(v){return (v == 0)?'否':'是';}
		},{
			header: '属性标签',
			flex:1,
			dataIndex: 'attribute_label'
		},{
			header: '属性备注',
			flex:1,
			dataIndex: 'note'
		}];
        this.columns = cols;
    },
	//创建工具栏
    createTbar: function() {
		var store = this.store;
		var pagesize= this.pagesize;
		var gridId = this.id;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(this)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: gridId+'_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this),
			
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: gridId+'_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        },'->','标签类型',
		{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
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
			value:'0',
			allowBlank:false
		},'-','必填',
		{
			xtype:'combo',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: [['-1','所有类型'],['0','否'],['1','是']]
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:100,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			id:'is_required',
			value:'-1',
			allowBlank:false
		},'-','唯一',
		{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: [['-1','所有类型'],['0','否'],['1','是']]
			}),
			valueField :"id",
			displayField: "key_type",
			queryMode: 'local',
			width:100,
			editable: false,
			//forceSelection: true,
			triggerAction: 'all',
			id:'is_unique',
			value:'-1',
			allowBlank:false
		},'-','提示更新',
		{
			xtype:'combo',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: [['-1','所有类型'],['0','否'],['1','是']]
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:100,
			//editable: false,
			//forceSelection: true,
			//triggerAction: 'all',
			id:'is_update_notice',
			value:'-1',
			allowBlank:false
			},'-','关键词:',
		{
			xtype:'textfield',
			id:'keyword',
			name:'keyword',
			enableKeyEvents:true,
			listeners:{
				scope:this,
				keypress:function(field,e){
					if(e.getKey()==13){
						store.load({
							params:{
								start:0, 
								limit:pagesize,
								keyword:field.getValue()
							}
						});
					}
				}
			}
		},'-',{
			xtype:'button',
			text:'搜索',
			iconCls:'x-tbar-search',
			handler:function(){
				store.load({
					params:{
						start:0,
						limit:pagesize,
						keyword:Ext.getCmp('keyword').getValue(),
						entity_type_id:Ext.getCmp('entity_type_id').getValue(),
						is_required:Ext.getCmp('is_required').getValue(),
						is_unique:Ext.getCmp('is_unique').getValue(),
						is_update_notice:Ext.getCmp('is_update_notice').getValue()
					}
				});
			}
		}];
    },
	creatselectionmodel:function(){
    	var gridId = this.id;
		var sm =  Ext.create('Ext.selection.RowModel',{
			mode: 'SINGLE',
			listeners:{
				"select":function(e,record,rowindex){
					if(record.data.entity_type_id ==3 || record.data.entity_type_id ==4 || record.data.entity_type_id  == 5){
						Ext.getCmp('addBtn').setDisabled(false);
						Ext.getCmp('delBtn').setDisabled(false);
						Ext.getCmp('AttributeValueGrid').setid(record.data.attribute_id);
						Ext.getCmp('AttributeValueGrid').setTitle("编辑属性"+record.data.attribute_code+"属性值列表");
					}else{
						Ext.getCmp('addBtn').setDisabled(true);
						Ext.getCmp('delBtn').setDisabled(true);
					}
					Ext.getCmp(gridId+'_editBtn').setDisabled(false);
					Ext.getCmp(gridId+'_removeBtn').setDisabled(false);
					Ext.getCmp('AttributeValueGrid').getStore().load({
						params:{start:0,limit:10,attribute_id:record.data.attribute_id,entity_type_id:record.data.entity_type_id}
					});
					Ext.getCmp('AttributeValueGrid').calculate();
				}
			}								 
		});
		this.selModel = sm;
	},
	createFormtiems:function(){
		var sst = this.getSelectionModel().getSelection();
		var tagg = new Array();
		var tvalue = '';
		for (var i = 1; i < languages.length; i++) { 
			tvalue = (sst.length > 0) ? sst[0].get(language_tag(i)) : '';
			var padding = (i==1)? '10px 0px 0px 0p':'0px';
			var isblank = (i == 1) ? false : true;
			tagg.push({
				fieldLabel : language_value(i),
				name:language_tag(i),
				id:language_tag(i),
				padding:padding,
				allowBlank:isblank,
				xtype: 'textfield',
				width:250,
				value: tvalue
			});
		}
		if(sst.length > 0){
			var is_required = sst[0].get('is_required');
			var is_unique = sst[0].get('is_unique');
			var entity_type_id = sst[0].get('entity_type_id');
			var is_update_notice = sst[0].get('is_update_notice');
		}
		tagg.push({
			text:'自动翻译',
			width:80,
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
							for (var key in res){
								if (key == 1) continue;
								Ext.getCmp(key + '_tag').setValue(HtmlDecode(res[key]));
							}
						 }
					});	
				}else{
					Ext.example.msg('MSG','请先填入中文');
				}
			}
		});
		this.formitem = [{
			xtype:'hidden',
			name: 'attribute_id'
			},{
				xtype: 'fieldset',
				labelWidth: 80,
				width:380,
				margin: '0px 0px 0px 10px',
				title: '属性基础信息',
				border:true,
				collapsible: true,
				items: [{
					name:'attribute_code',
					fieldLabel:'属性内部编码',
					allowBlank:false,
					xtype: 'textfield',
					width:250
				},{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: option_value
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:250,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'is_required',
					name: 'is_required',
					value:is_required,
					fieldLabel: '是否必填'
				},{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: option_value
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:250,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					hiddenName:'is_unique',
					name: 'is_unique',
					value:is_unique,
					fieldLabel: '是否唯一'
				},{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: en_type
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:250,
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
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: option_value
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:250,
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
					width:250,
					fieldLabel:'属性备注'
				}]
			},{
				xtype: 'fieldset',
				labelWidth: 80,
				width:380,
				title: '属性标签多语言',
				margin: '0px 0px 0px 10px',
				border:true,
				collapsible: true,
				items: tagg
			}
		];
	}
});
Ext.define('Ext.ux.AttributeValueGrid',{
	extend:'Ext.grid.Panel',
    initComponent: function() {
        this.autoHeight = true;
        this.stripeRows = true;
        this.viewConfig = {
            forceFit: true
        };
		this.selModel = Ext.create('Ext.selection.RowModel',{mode: 'SINGLE'});
		this.plugins=[Ext.create('Ext.grid.plugin.CellEditing', {
	        clicksToEdit: 1
	    })],
        this.createStore();
        this.createColumns();  
		this.createTbar();
		this.createBbar();
		this.getSelectionModel().on('selectionchange', function(sm){
			
			Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
			Ext.getCmp('addBtn').setDisabled(sm.getCount() < 1);
			//this.removeBtn.setDisabled(sm.getCount() < 1);
			//this.editBtn.setDisabled(sm.getCount() < 1);
		});
		this.callParent();
    },
	setid:function(id){
		this.attribute_id = id;
	},
	getid:function(){
		return this.attribute_id;
	},
    createStore: function() {
		var thiz = this;
		this.store = Ext.create('Ext.data.JsonStore', {
			fields:this.fields,
			autoLoad:true,
			pageSize: this.pagesize,
			proxy: {
				type: 'ajax',
				url:this.listURL,
				actionMethods:{
					read: 'POST'
				},
				reader:{
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:this.fields[0],
					root: 'topics'
				}
			},
			listeners : {
				'load' : this.calculate.bind(this),
				'add' : this.calculate.bind(this),
				'remove' : this.calculate.bind(this),
				'update' : this.calculate.bind(this)
			}
		});
       
		this.store.on('beforeload',function(){
			Ext.apply(this.baseParams,{
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
		var cols = [{
			xtype: 'rownumberer'
		},{
			header : '中文<font color=red>*</font>',
			dataIndex:'value',
			flex:1,
			width:100,
			align : 'left',
			editor:{
                allowBlank: false,
				hideLabel:true
            },
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
				flex:1,
				align : 'left',
				editor:{
					allowBlank: false,
					hideLabel:true
				}
			});			
		}
    },
    createTbar: function() {
		var getid = this.getid;
		var store = this.store;
        this.tbar = [{
				xtype:'button',
				text:'新增属性值',
				id: 'addBtn',
				disabled:true,
				ref: '../addBtn',
				iconCls: 'x-tbar-add',
				handler:this.createWindow.bind(this,['0'])
			},{
				text: '删除属性值',
				iconCls: 'x-tbar-del',
				id: 'removeBtn',
				ref: '../removeBtn',
				handler: this.removeItem.bind(this),
				disabled:true
			},{
				text: '保存属性值列表',
				iconCls: 'x-tbar-save',
				ref: '../saveBtn',
				id: 'saveBtn',
				handler: this.saveItem.bind(this),
				disabled:true
			},{
				text: '清空此属性值列表',
				iconCls: 'x-tbar-del',
				id: 'delBtn',
				ref: '../delBtn',
				disabled:true,
				handler: this.delItem.bind(this)
			},{
				text: '设为默认值',
				iconCls: 'x-tbar-save',
				id: 'defauleBtn',
				ref: '../saveBtn',
				disabled:true,
				handler: this.setDefault.bind(this)
			},'(复选类型可设多个默认，下拉、单选只能设一个默认值)'];
    },
    createBbar: function() {
		var pagesize = this.pagesize;
		this.dockedItems = [{
        	xtype: 'pagingtoolbar',
	        pageSize: pagesize,
			plugins: new Ext.ui.plugins.ComboPageSize(),
			displayInfo: true,
			displayMsg: '第{0} 到 {1} 条数据 共{2}条',
			emptyMsg: "没有数据",
			dock: 'bottom',
	        store: this.store
        }];
    },
    createWindow: function(num) {
		var taggg = new Array();
		for (var i = 1; i < languages.length; i++) { 
			var isblank = (i == 1) ? false : true;
			var padding = (i==1)? '10px 0px 0px 0p':'0px';
			taggg.push({
				fieldLabel : language_value(i),
				name:language_tag(i),
				id:language_tag(i)+'2',
				allowBlank:isblank,
				padding: padding,
				width:250,
				xtype: 'textfield',
				value: ''
			});
					
		}
		taggg.push({
			text:'自动翻译',
			width:80,
			style:'margin-top:10px;margin-left:56px;margin-bottom:10px',
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
		})
		var formitem1 = [taggg];
		var newform = Ext.create('Ext.form.Panel',{
            frame: false,
			border:false,
			bodyStyle:'padding:10px',
            defaultType: 'textfield',
			id:'newform',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 80,
            items:taggg,
            buttons: [{
                text: '提交',
                handler: function(){
					var grid11 = Ext.getCmp("attrgrid").getSelectionModel().getSelection();
					var aid = grid11[0].get('attribute_id');
					var form = newform.getForm();
					var thiz = Ext.getCmp('AttributeValueGrid').store;
					if(form.isValid()){
						form.submit({
							 url:'index.php?model=attribute&action=valueupdate',
							 method:'post',
							 params:{attribute_id:aid},
							 success:function(form,action){
								if (action.result.success) {
									Ext.example.msg('MSG',action.result.msg);
									window.location="javascript:location.reload()";
									
									thiz.load();
								} else {
									Ext.Msg.alert('修改失败',action.result.msg);
								}
							 },
							 failure:function(form,action){
									Ext.example.msg('操作',action.result.msg);
							 }
							
						})
						win.hide();
					}
				}
            }, {
                text: '重置',
                handler: function() {
                    newform.getForm().reset();
                }
            }]
        });
        var win = Ext.create('Ext.window.Window',{
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
		var data = this.getSelectionModel().getSelection();
		var index = this.store.findBy(function(record,id){
				return record.get('value') == data[0].get('value');									
		});
		var id = data[0].get('value_id');
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
								thiz.load();
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
		var m = this.store.getModifiedRecords().slice(0);
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
							thiz.load();
						}else{
							Ext.Msg.alert('ERROR',res.msg);
						}						
					}
				});
			}
		}, this);
	},
	setDefault:function(){
		if(this.store.getCount() == 0) {
			Ext.example.msg('错误','属性值数据不能为空');
			return false;
		}
		var data = this.getSelectionModel().getSelection();
		var index = this.store.findBy(function(record,id){
				return record.get('value') == data[0].get('value');									
		});
		var value_id = data[0].get('value_id');
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
					thiz.load();
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