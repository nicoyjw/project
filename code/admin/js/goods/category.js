Ext.define('Ext.ux.CategoryGrid',{
	extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent();
    },
	createColumns: function() {
		var data = this.arr_data;
        var cols = [{
			xtype: 'rownumberer'
		},{
			header: '分类代码',
			flex:1,
			dataIndex: 'code'
		},{
			header: '分类名',
			flex:1,
			dataIndex: 'cat_name'
		},{
			header: '运费',
			flex:1,
			dataIndex: 'shipping_fee'
		},{
			header: '包装',
			flex:1,
			dataIndex: 'package_fee'
		},{
			header: '申报价值',
			flex:1,
			dataIndex: 'Declared_value'
		},{
			header: '申报英文名称',
			flex:1,
			dataIndex: 'dec_en_name'
		},{
			header: '申报中文名称',
			flex:1,
			dataIndex: 'dec_cn_name'
		},{
			header: '海关编码',
			flex:1,
			dataIndex: 'customs_code'
		},{
			header: '采购员',
			dataIndex: 'product_purchaser',
			flex:1,
			renderer:function(val,x,rec){
				return comrender(val,data[0]);
			}
		},{
			header: '产品开发员',
			dataIndex: 'products_developers',
			flex:1,
			renderer:function(val,x,rec){
				return comrender(val,data[0]);
			}
		},{
			header: '产品运营员',
			dataIndex: 'product_operation',
			flex:1,
			renderer:function(val,x,rec){
				return comrender(val,data[0]);
			}
		},{
			header: '产品质检员',
			dataIndex: 'product_quality_inspector',
			flex:1,
			renderer:function(val,x,rec){
				return comrender(val,data[0]);
			}
		},{
			header: '产品侵权审核员',
			dataIndex: 'product_rights_checker',
			flex:1,
			renderer:function(val,x,rec){
				return comrender(val,data[0]);
			}
		},{
			header: '所属分类',
			flex:1,
			dataIndex: 'parent_name'
		},{
			header: '所属分类id',
			dataIndex: 'parent_id',
			hidden:true
		}];
        this.columns = cols;
    },

	afterEdit:function(){
		if(Ext.getCmp('cattree')) Ext.getCmp('cattree').getStore().load();
	},

	afterRemove:function(){
		if(Ext.getCmp('cattree')) Ext.getCmp('cattree').getStore().load();
	},
    removeRecord: function() {
        var r = this.getSelectionModel().getSelection();
		if(r[0].data.haschild>0){
			Ext.example.msg('错误','该分类拥有子类，请先删除子类');
			return false;
		}
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
	afterselect:function(k,v){
		if(k == Ext.getCmp('parent_id').getValue()){
			Ext.example.msg('错误','分类不能属于自身');
			return false;
		}
		if(k == 'root') k=0;
		Ext.getCmp('parent_name').setValue(v);
		Ext.getCmp('parent_id').setValue(k);
		Ext.getBody().mask("正在获取数据.请稍等...","x-mask-loading");
		Ext.Ajax.request({
			url: 'index.php?model=goods&action=getcatcode',
			loadMask:true,
			params: { cat_id: k },
			success:function(response,opts){
				var res = Ext.decode(response.responseText);
				Ext.getBody().unmask();
				if(res.success){
					if(res.msg!='') Ext.getCmp('code').setValue(res.msg);
				}else{
					Ext.Msg.alert('ERROR',res.msg);
				}						
			}
		});
	},
	afterselect_ali:function(k,v){
		if(k == Ext.getCmp('ali_cat_id').getValue()){
			Ext.example.msg('错误','分类不能属于自身');
			return false;
		}
		if(k == 'root') k=0;
		Ext.getCmp('ali_parent_name').setValue(v);
		Ext.getCmp('ali_cat_id').setValue(v);
	},
	createFormtiems:function(){
		var thiz = this.typestore;
		var afterselect =this.afterselect;
		var afterselect_ali = this.afterselect_ali;
		var sst = this.getSelectionModel().getSelection();
		var product_purchaser;
		var products_developers;
		var product_operation;
		var product_quality_inspector;
		var product_rights_checker;
		if(sst.length > 0){
			product_purchaser = sst[0].get('product_purchaser');
			products_developers = sst[0].get('products_developers');
			product_operation = sst[0].get('product_operation');
			product_quality_inspector = sst[0].get('product_quality_inspector');
			product_rights_checker = sst[0].get('product_rights_checker');
		}
        var items = [{
			xtype:'hidden',
			id: 'cat_id',
			name:'cat_id'
		},{
			xtype:'triggerfield',
			editable: false,
			fieldLabel:'所属分类',
			width:450,
			labelWidth: 90,
			id:'parent_name',
			name:'parent_name',
			value:'顶级分类',
			onSelect: function(record){
			},
			onTriggerClick: function() {
				getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',1,afterselect);
			}
		},{
			xtype:'textfield',
			fieldLabel: '分类代码',
			enableKeyEvents:true,
			width:300,
			labelWidth: 90,
			allowBlank:false,
			id:'code',
			name:'code',
			listeners: {
				keyup:function(field,e){
					field.setValue(field.getValue().toUpperCase());
				}
			}
		}/*,{
				xtype:'hidden',
                id: 'ali_cat_id'
					},new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'Aliexpress分类',	
					width:220,		
					xtype:'trigger',
					id:'ali_parent_name',
					value:'请选择分类',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getAliCategoryFormTree('index.php?model=aliexpress&action=getcattree&com=0',1,afterselect_ali);
					}
		})*/,{
			xtype:'textfield',
			fieldLabel: '分类名',
			name: 'cat_name',
			id:'cat_name',
			labelWidth: 90,
			width:300,
			allowBlank:false
		},{
			xtype: 'fieldset',
			labelWidth: 100,
			width:480,
			id:'sela',
			style:'padding:10px',
			autoScroll:true,
			border:true,
			title: '属性信息',
			items:[{
			xtype: 'fieldset',
			labelWidth: 80,
			width:450,
			defaultType: 'textfield',
			id:'attrset',
			layout:'column',
			style:'padding:3px 5px 0 5px',
			autoScroll:true,
			border:false,
			items:[{
				columnWidth:.23,
				style:'margin:0 15px',
				id:'addattr',
				xtype:'button',
				text:'添加属性组',
				handler:function(){
					var dellen = Ext.getCmp('selattribute').items.length;
					var opatlen = Ext.getCmp('selattribute').items.length+1;
					var aobt = Ext.getCmp('selattribute');
					var addattr = [{
						columnWidth:.58,
						xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
							 fields: ["id", "key_type"],
							 data: group
						}),
						valueField :"id",
						displayField: "key_type",
						mode: 'local',
						id:'com_'+dellen,
						width:150,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						hiddenName:'att_group_'+dellen,
						name:'att_group_'+dellen,
						value:'请选择'
					}]
					aobt.add(addattr);
					aobt.doLayout(true);
				}
			},{
				columnWidth:.23,
				style:'margin:0 15px',
				xtype:'button',
				text:'清空属性',
				handler:function(){
					var sellen = Ext.getCmp('selattribute').items.length;
					var selob = Ext.getCmp('selattribute');
					for(var i = 0;i<sellen;i++){
						var x=selob.items.get(0);
						var array=Ext.query("*[for='"+x.id+"']");
						Ext.removeNode(array[0]);
						selob.remove(x,true);
					}
					selob.doLayout(true);
				}
			}]
		},{
				xtype: 'fieldset',
				labelWidth: 100,
				defaultType: 'textfield',
				layout:'column',
				id:'selattribute',
				style:'padding:10px',
				autoScroll:true,
				border:false,
				items:[]
			}/*,{
				id:'savebtn',
				style:'margin-left:350px;',
				width: 80,
				xtype:'button',
				text:'保存属性',
				handler:function(){
					var category_id = Ext.getCmp('cat_id').getValue();
					if(!category_id) alert(this); return; 	
					var sellen = Ext.getCmp('selattribute').items.length;
					var selob = Ext.getCmp('selattribute');
					var str = '';
					for(var i = 0;i<sellen;i++){
						var x=selob.items.get(i)
						str += (!str) ? Ext.getCmp(x.id).getValue() : ','+Ext.getCmp(x.id).getValue();
					}
					Ext.Ajax.request({
					   url: 'index.php?model=goods&action=savecatattr',
					   loadMask:true,
					   params: { set_id: str,cat_id:category_id },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
					});
				}
			}*/]
		},{
			xtype:'numberfield',
			fieldLabel: '运费',
			value:0,
			hideTrigger:true,
			width:220,
			name: 'shipping_fee',
			decimalPercision:4,
			minValue:0
			
		},{
			xtype:'numberfield',
			fieldLabel: '包装费',
			width:220,
			hideTrigger:true,
			name: 'package_fee',
			minValue:0,
			decimalPercision:4,
			value:0
		},{
			xtype:'numberfield',
			fieldLabel: '申报价值',
			width:220,
			hideTrigger:true,
			name: 'Declared_value',
			minValue:0,
			decimalPercision:4,
			value:0
		},{
			xtype:'textfield',
			fieldLabel: '中文报关名',
			width:320,
			name: 'dec_cn_name'
		},{
			xtype:'textfield',
			fieldLabel: '英文报关名',
			width:320,
			name: 'dec_en_name'
		},{
			xtype:'textfield',
			fieldLabel: '海关编码',
			width:320,
			name: 'customs_code'
		},{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:320,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'product_purchaser',
			name: 'product_purchaser',
			value:product_purchaser,
			fieldLabel: '采购员'
		},{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:320,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'products_developers',
			name: 'products_developers',
			value:products_developers,
			fieldLabel: '产品开发员'
		},{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:320,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'product_operation',
			name: 'product_operation',
			value:product_operation,
			fieldLabel: '产品运营员'
		},{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:320,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'product_quality_inspector',
			name: 'product_quality_inspector',
			value:product_quality_inspector,
			fieldLabel: '产品质检员'
		},{
			xtype:'combobox',
			store: Ext.create('Ext.data.ArrayStore',{
				 fields: ["id", "key_type"],
				 data: account
			}),
			valueField :"id",
			displayField: "key_type",
			mode: 'local',
			width:320,
			editable: false,
			forceSelection: true,
			triggerAction: 'all',
			hiddenName:'product_rights_checker',
			name: 'product_rights_checker',
			value:product_rights_checker,
			fieldLabel: '产品侵权审核员'
		},{
			xtype:'hidden',
			id:'parent_id',
			name:'parent_id',
			value:0
		}];
		this.formitem = items;
	},
    createForm: function() {
		var thiz = this.store;
        var form = Ext.create('Ext.form.Panel',{
            frame: false,
			id:'form',
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 90,
            trackResetOnLoad: true,
			height:350,
			autoScroll:true,
            border:false,
			bodyStyle:'padding:10px',
            items: this.formitem,
            buttons: [{
				id:'subID',
                text: 'submit',
                handler:this.submitRecord.bind(this)
            }, {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
		form.on('afterrender',function(){
			var aobt = Ext.getCmp('selattribute');
			var sst = Ext.getCmp("CategoryGrid").getSelectionModel().getSelection();
			var idarr = [];
			if(sst.length >0){
				var idset = sst[0].get('attribute_group_id');
				idarr = idset.split(',');
				if(idarr[0] !== ''){
					var addattr = [];
					for (var j = 0; j < idarr.length; j++) {
						addattr = [{
							columnWidth:.58,
							xtype:'combo',
							store: Ext.create('Ext.data.ArrayStore',{
								 fields: ["id", "key_type"],
								 data: group
							}),
							valueField :"id",
							displayField: "key_type",
							mode: 'local',
							id:'a'+j,
							width:150,
							editable: false,
							forceSelection: true,
							triggerAction: 'all',
							hiddenName:'att_group_'+j,
							name:'att_group_'+j,
							value:idarr[j]
						}]
						aobt.add(addattr);
						aobt.doLayout(true);
					}
				}
			}
		},this);
		return form;
    },
	createTbar: function() {
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler:this.createRecord.bind(this),
			listeners: {
				click:function(field,e){
					Ext.getCmp("CategoryGrid").getSelectionModel().deselectAll();
					if(Ext.getCmp('selattribute')){
						var sellen = Ext.getCmp('selattribute').items.length;
						var selob = Ext.getCmp('selattribute');
						for(var i = 0;i<sellen;i++){
							var x=selob.items.get(0);
							var array=Ext.query("*[for='"+x.id+"']");
							Ext.removeNode(array[0]);
							selob.remove(x,true);
						}
						selob.doLayout(true);
					}
				}
			}   
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id:'editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(this),
			listeners: {
				click:function(field,e){
					var sst = Ext.getCmp("CategoryGrid").getSelectionModel().getSelection();
					if(Ext.getCmp('selattribute')){
						var sellen = Ext.getCmp('selattribute').items.length;
						var aobt = Ext.getCmp('selattribute');
						for(var i = 0;i<sellen;i++){
							var x=aobt.items.get(0);
							var array=Ext.query("*[for='"+x.id+"']");
							Ext.removeNode(array[0]);
							aobt.remove(x,true);
						}
						if(sst.length > 0){
							var idset = sst[0].get('attribute_group_id');
							var idarr = [];
							idarr = idset.split(',');
							if(idarr[0] !== ''){
								var addattr = [];
								for (var j = 0; j < idarr.length; j++) {
									addattr = [{
										columnWidth:.58,
										xtype:'combo',
										store: Ext.create('Ext.data.ArrayStore',{
											 fields: ["id", "key_type"],
											 data: group
										}),
										valueField :"id",
										displayField: "key_type",
										mode: 'local',
										id:'a'+j,
										width:150,
										editable: false,
										forceSelection: true,
										triggerAction: 'all',
										hiddenName:'att_group_'+j,
										name:'att_group_'+j,
										value:idarr[j]
									}]
									aobt.add(addattr);
									aobt.doLayout(true);
								}
							}		
						}
					}	
				}
			}
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id:'removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(this)
        }];
    }
});
