Ext.ux.CategoryGrid = Ext.extend(Ext.ux.NormalGrid, {
    initComponent: function() {
        Ext.ux.CategoryGrid.superclass.initComponent.call(this);
    },
	createColumns: function() {
		var data = this.arr_data;
        var cols = [new Ext.grid.RowNumberer(),{
						header: '分类代码',
						dataIndex: 'code'
					},{
						header: '分类名',
						dataIndex: 'cat_name'
					},{
						header: '运费',
						dataIndex: 'shipping_fee'
					},{
						header: '包装',
						dataIndex: 'package_fee'
					},{
						header: '申报价值',
						dataIndex: 'Declared_value'
					},{
						header: '申报英文名称',
						dataIndex: 'dec_en_name'
					},{
						header: '申报中文名称',
						dataIndex: 'dec_cn_name'
					},{
						header: '海关编码',
						dataIndex: 'customs_code'
					},{
						header: '采购员',
						dataIndex: 'product_purchaser',
						renderer:function(val,x,rec){
					   		return comrender(val,data[0]);
					   }
					},{
						header: '产品开发员',
						dataIndex: 'products_developers',
						renderer:function(val,x,rec){
					   		return comrender(val,data[0]);
					   }
					},{
						header: '产品运营员',
						dataIndex: 'product_operation',
						renderer:function(val,x,rec){
					   		return comrender(val,data[0]);
					   }
					},{
						header: '产品质检员',
						dataIndex: 'product_quality_inspector',
						renderer:function(val,x,rec){
					   		return comrender(val,data[0]);
					   }
					},{
						header: '产品侵权审核员',
						dataIndex: 'product_rights_checker',
						renderer:function(val,x,rec){
					   		return comrender(val,data[0]);
					   }
					},{
					header: '所属分类',
					dataIndex: 'parent_name'
					},{
					header: '所属分类id',
					dataIndex: 'parent_id',
					hidden:true
					}];
        this.columns = cols;
    },

	afterEdit:function(){
		if(Ext.getCmp('cattree')) Ext.getCmp('cattree').load();
	},

	afterRemove:function(){
		if(Ext.getCmp('cattree')) Ext.getCmp('cattree').load();
	},
    removeRecord: function() {
        var r = this.getSelectionModel().getSelections();
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
		if(k == Ext.getCmp('cat_id').getValue()){
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
		var sst = Ext.getCmp("CategoryGrid").getSelectionModel().getSelected();
		if(sst){
			var product_purchaser = sst.get('product_purchaser');
			var products_developers = sst.get('products_developers');
			var product_operation = sst.get('product_operation');
			var product_quality_inspector = sst.get('product_quality_inspector');
			var product_rights_checker = sst.get('product_rights_checker');
		}
        var items = [{
				xtype:'hidden',
                id: 'cat_id'
					},new Ext.form.TriggerField({
					editable: false,
					fieldLabel:'所属分类',
					width:220,
					xtype:'trigger',
					id:'parent_name',
					value:'顶级分类',
					onSelect: function(record){
					},
					onTriggerClick: function() {
						getCategoryFormTree('index.php?model=goods&action=getcattree&com=0',1,afterselect);
					}
					}),{
                fieldLabel: '分类代码',
				enableKeyEvents:true,
				width:220,
				allowBlank:false,
				id:'code',
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
                fieldLabel: '分类代码',
				enableKeyEvents:true,
				width:220,
				allowBlank:false,
				id:'code',
				listeners: {
					keyup:function(field,e){
							field.setValue(field.getValue().toUpperCase());
						}
				}
					},{
                fieldLabel: '分类名',
                name: 'cat_name',
				width:220,
				allowBlank:false
					},{
					xtype: 'fieldset',
					labelWidth: 80,
					width:580,
					defaultType: 'textfield',
					id:'attrset',
					layout:'column',
					style:'padding:3px 5px 0 20px',
					autoScroll:true,
					border:false,
					items:[
						{
							xtype:'label',
							text:'选择属性:',
							style:'padding:3px;font-size:11px;color:red',
							columnWidth:.14,
						},
						{
						columnWidth:.40,
						xtype:'combo',
						store: new Ext.data.SimpleStore({
							 fields: ["id", "key_type"],
							 data: group
						}),
						valueField :"id",
						id:'selattr',
						displayField: "key_type",
						mode: 'local',
						width:220,
						editable: false,
						forceSelection: true,
						triggerAction: 'all',
						emptyText:'请选择'
						},{
							columnWidth:.18,
							style:'margin:0 15px',
							xtype:'button',
							text:'添加属性',
							handler:function(){
								var dellen = Ext.getCmp('selattribute').items.length;
								var opatlen = Ext.getCmp('selattribute').items.length+1;
								var aobt = Ext.getCmp('selattribute');
								var comvalue = Ext.getCmp('selattr').getValue();
								var addattr = 
								[
								{
								columnWidth:.58,
								xtype:'combo',
								store: new Ext.data.SimpleStore({
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
								value:comvalue
								}]
								aobt.add(addattr);
								aobt.doLayout(true);
							}
							
						},{
							columnWidth:.18,
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
						}
					]},{
					xtype: 'fieldset',
					labelWidth: 100,
					width:480,
					defaultType: 'textfield',
					layout:'form',
					id:'sela',
					style:'padding:10px',
					autoScroll:true,
					border:true,
					title: '已选择的属性',
					items:[
						{
						xtype: 'fieldset',
						labelWidth: 100,
						defaultType: 'textfield',
						layout:'column',
						id:'selattribute',
						style:'padding:10px',
						autoScroll:true,
						border:false,
						items:[]
						},
						{
						id:'savebtn',
						style:'margin:0 15px',
						xtype:'button',
						text:'保存属性',
						handler:function(){
							var category_id = Ext.getCmp('cat_id').getValue();
							if(!category_id) return false; 	
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
						}
					]},{
				xtype:'numberfield',
                fieldLabel: '运费',
				width:80,
                name: 'shipping_fee',
				allowNegative:false,
				decimalPercision:4,
				value:0
					},{
				xtype:'numberfield',
                fieldLabel: '包装费',
				width:80,
                name: 'package_fee',
				allowNegative:false,
				decimalPercision:4,
				value:0
					},{
				xtype:'numberfield',
                fieldLabel: '申报价值',
				width:80,
                name: 'Declared_value',
				allowNegative:false,
				decimalPercision:4,
				value:0
					},{
                fieldLabel: '中文报关名',
				width:220,
                name: 'dec_cn_name',
				allowNegative:false
					},{
                fieldLabel: '英文报关名',
				width:220,
                name: 'dec_en_name',
				allowNegative:false,
					},{
                fieldLabel: '海关编码',
				width:220,
                name: 'customs_code',
				allowNegative:false,
					},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:220,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'product_purchaser',
				name: 'product_purchaser',
				value:product_purchaser,
				fieldLabel: '采购员'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:220,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'products_developers',
				name: 'products_developers',
				value:products_developers,
				fieldLabel: '产品开发员'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:220,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'product_operation',
				name: 'product_operation',
				value:product_operation,
				fieldLabel: '产品运营员'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:220,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'product_quality_inspector',
				name: 'product_quality_inspector',
				value:product_quality_inspector,
				fieldLabel: '产品质检员'
				},{
				xtype:'combo',
				store: new Ext.data.SimpleStore({
					 fields: ["id", "key_type"],
					 data: account
				}),
				valueField :"id",
				displayField: "key_type",
				mode: 'local',
				width:220,
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
					value:0
					}];
		this.formitem = items;
	},
    createForm: function() {
		var thiz = this.store;
        var form = new Ext.form.FormPanel({
            frame: true,
			id:'form',
            defaultType: 'textfield',
            buttonAlign: 'center',
            labelAlign: 'right',
            labelWidth: 90,
            trackResetOnLoad: true,
			height:500,
			layout:'form',
			autoScroll:true,
            reader: new Ext.data.ArrayReader({
                fields: this.fields,
            }),
            items: this.formitem,
            buttons: [{
				id:'subID',
                text: 'submit',
                handler:this.submitRecord.createDelegate(this)
            }, {
                text: 'reset',
                handler: function() {
                    form.getForm().reset();
                }
            }]
        });
			form.on('render',function(){
				
				var aobt = Ext.getCmp('selattribute');
				var sst = Ext.getCmp("CategoryGrid").getSelectionModel().getSelected();
				var idarr = [];
				if(sst){
					var idset = sst.get('attribute_group_id');
					idarr = idset.split(',');
					if(idarr[0] !== ''){
					var addattr = [];
					for (var j = 0; j < idarr.length; j++) {
						addattr = 
							[{
							columnWidth:.58,
							xtype:'combo',
							store: new Ext.data.SimpleStore({
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
							hiddenName:'attgroup'+j,
							name:'attgroup'+j,
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
            handler:this.createRecord.createDelegate(this),
			listeners: {
				click:function(field,e){
					Ext.getCmp("CategoryGrid").getSelectionModel().clearSelections();
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
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.createDelegate(this),
			listeners: {
				click:function(field,e){
					var sst = Ext.getCmp("CategoryGrid").getSelectionModel().getSelected();
					if(Ext.getCmp('selattribute')){
						var sellen = Ext.getCmp('selattribute').items.length;
						var aobt = Ext.getCmp('selattribute');
						for(var i = 0;i<sellen;i++){
							var x=aobt.items.get(0);
							var array=Ext.query("*[for='"+x.id+"']");
							Ext.removeNode(array[0]);
							aobt.remove(x,true);
						}
						if(sst){
							var idset = sst.get('attribute_group_id');
							var idarr = [];
							idarr = idset.split(',');
							if(idarr[0] !== ''){
								var addattr = [];
								for (var j = 0; j < idarr.length; j++) {
									addattr = 
										[{
										columnWidth:.58,
										xtype:'combo',
										store: new Ext.data.SimpleStore({
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
										hiddenName:'attgroup'+j,
										name:'attgroup'+j,
										value:idarr[j]
										}]
									aobt.add(addattr);
									aobt.doLayout(true);
								}
								Ext.getCmp('savebtn').enable();
							}		
						}
					}	
				}
			}
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.createDelegate(this)
        }];
    }
});
