Ext.define('Ext.ux.ExpressRuleGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },		
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},
		
					{
						header: '序号',
						hidden:true,
						dataIndex: 'rule_id',
						renderer:this.renderers[1]
					},{
						header: '规则',
						flex:1,
						dataIndex: 'rule',
                            renderer: function (value, meta, record) {
                                if(record.get("is_action")==0 || !record.get("is_action"))
                                    return '<font style="color:#00F00F;">'+value+'</font>';
                                else
                                    return value;             
                        } 
					},{
						header: '值(括号内为值)',
						flex:2,
						dataIndex: 'value'
					},{
					header: '快递方式',
					flex:1,
					dataIndex: 'express_id',
					renderer:this.renderers[0]
					},{
					header: '先后顺序(数字大的优先)',
					width:180,
					dataIndex: 'order_by'
					}
                    ,{
                        header: '状态',
                        flex:0.4,
                        dataIndex: 'is_action',
                            renderer: function (value, meta, record) {
                                
                                if(value==0 || !value)
                                    return '<font style="color:#00F00F;">stop</font>';
                                else
                                    return 'start';             
                        } 
                    },{
                  header:'启用/停用',
                  flex:0.6,
                  xtype: 'actioncolumn',
                  items:[{                                          
                        icon   : 'themes/default/images/update.gif',
                        tooltip: '启用',
                        iconCls:'iconpadding',
                        handler: function(grid, rowIndex, colIndex) {
                            var id = ds.getAt(rowIndex).get('order_id');
                            parent.openWindow(id,'编辑订单','index.php?model=order&action=edit&id='+id,1000,500);
                        }
                         },{                                          
                        icon   : 'themes/default/images/update.gif',
                        tooltip: '停用',
                        iconCls:'iconpadding',
                        handler: function(grid, rowIndex, colIndex) {
                            var id = ds.getAt(rowIndex).get('order_id');
                            parent.openWindow(id,'paypal信息比对','index.php?model=order&action=readpaypal&id='+id,1000,500);
                        }
                         }]
                  }
                    ];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'ExpressRuleGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: function() {
                var r = Ext.getCmp('ExpressRuleGrid').getSelectedRecord();
                if (r != false) {
                    me.showWindow();
                    var form = me.getForm();
                    form.baseParams = {
                        create: false
                    };   
                    form.loadRecord(r)
                }   
                var rulestr = r.get('rule_id');
                var strs= new Array();
                strs = rulestr.split(","); 
                Ext.getBody().mask("正在加载数据.请稍等...","x-mask-loading");             
                for (i=0;i<strs.length ;i++ ){
                   
                    if(strs[i] == 31){  /* 国家 */
                        Ext.getCmp('countrySet').show();
                        Ext.getCmp('ExpressCountry').setValue(true);                     
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == 'in'){
                                    Ext.getCmp('countryText').setValue(res.value);
                                    Ext.getCmp('country_if_rule_in').setValue(true);         
                                }
                                if(res.if_rule == 'not in'){
                                    Ext.getCmp('countryText').setValue(res.value);
                                    Ext.getCmp('country_if_rule_notin').setValue(true);    
                                }
                            }
                        });     
                    }else if(strs[i] == 32){
                        
                    }else if(strs[i] == 33){ /* 费用 */  
                        Ext.getCmp('orderFeeSet').show();                    
                        Ext.getCmp('ExpressFee').setValue(true);
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == '>'){
                                    Ext.getCmp('feeRuleValue').setValue(res.value);
                                    Ext.getCmp('fee_if_rule_d').setValue(true);         
                                }
                                if(res.if_rule == '<'){
                                    Ext.getCmp('feeRuleValue').setValue(res.value);
                                    Ext.getCmp('fee_if_rule_x').setValue(true);    
                                }                                 
                                if(res.if_rule == '><'){
                                    var strs= new Array();
                                    strs = res.value.split(","); 
                                    Ext.getCmp('startFee').setValue(strs[0]);
                                    Ext.getCmp('endFee').setValue(strs[1]);
                                }                                 
                            }
                        });            
                    }else if(strs[i] == 34){
                        Ext.getCmp('orderWeigthSet').show();                    
                        Ext.getCmp('ExpressWeigth').setValue(true);
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == '>'){
                                    Ext.getCmp('WeigthRuleValue').setValue(res.value);
                                    Ext.getCmp('weight_if_rule_d').setValue(true);         
                                }
                                if(res.if_rule == '<'){
                                    Ext.getCmp('WeigthRuleValue').setValue(res.value);
                                    Ext.getCmp('weight_if_rule_x').setValue(true);    
                                }                                 
                                if(res.if_rule == '><'){
                                    var strs= new Array();
                                    strs = res.value.split(","); 
                                    Ext.getCmp('startWeigth').setValue(strs[0]);
                                    Ext.getCmp('endWeigth').setValue(strs[1]);
                                }                                 
                            }
                        });    
                    }else if(strs[i] == 37){
                        Ext.getCmp('goodsQtySet').show();                    
                        Ext.getCmp('ExpressGoodqty').setValue(true);
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == '>'){
                                    Ext.getCmp('GoodqtyRuleValue').setValue(res.value);
                                    Ext.getCmp('goodqty_if_rule_d').setValue(true);         
                                }
                                if(res.if_rule == '<'){
                                    Ext.getCmp('GoodqtyRuleValue').setValue(res.value);
                                    Ext.getCmp('goodqty_if_rule_x').setValue(true);    
                                }                                 
                                if(res.if_rule == '><'){
                                    var strs= new Array();
                                    strs = res.value.split(","); 
                                    Ext.getCmp('startGoodqty').setValue(strs[0]);
                                    Ext.getCmp('endGoodqty').setValue(strs[1]);
                                }                                 
                            }
                        });
                    }else if(strs[i] == 38){
                        Ext.getCmp('salesAccountSet').show();
                        Ext.getCmp('ExpressSalesaccount').setValue(true);                     
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == 'in'){
                                    Ext.getCmp('salesAccountText').setValue(res.value);
                                    Ext.getCmp('account_if_rule_in').setValue(true);         
                                }
                                if(res.if_rule == 'not in'){
                                    Ext.getCmp('salesAccountText').setValue(res.value);
                                    Ext.getCmp('account_if_rule_notin').setValue(true);    
                                }
                            }
                        });
                    }else if(strs[i] == 35){
                        Ext.getCmp('goodSkuSet').show();                    
                        Ext.getCmp('ExpressSku').setValue(true);
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                if(res.if_rule == 'like'){
                                    Ext.getCmp('Skusn').setValue(res.value);              
                                }
                                if(res.if_rule == '$'){
                                    Ext.getCmp('endSkusn').setValue(res.value);        
                                }                                 
                                if(res.if_rule == '><'){
                                    var strs= new Array();
                                    strs = res.value.split(","); 
                                    Ext.getCmp('startSkuQty').setValue(strs[0]);
                                    Ext.getCmp('endSkuQty').setValue(strs[1]);
                                }
                                if(res.if_rule == '&&'){
                                    Ext.getCmp('Skusns').setValue(res.value);         
                                }                                 
                            }
                        });        
                    }else if(strs[i] == 41){
                        Ext.getCmp('shippingServiceSet').show();
                        Ext.getCmp('ExpressShipping').setValue(true);                     
                        Ext.Ajax.request({
                            url: 'index.php?model=express&action=getExpressOption&rule_id='+strs[i]+'&express_rule_id='+r.get('id'),                             
                            success:function(response,opt){
                                var res = Ext.decode(response.responseText);
                                Ext.getCmp('ShippingText').setValue(res.value);
                            }
                        });    
                    }else if(strs[i] == 0){
                        Ext.getCmp('ExpressDefault').show();       
                    }
                }
                Ext.getBody().unmask(); 
            }
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'ExpressRuleGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
		var country = this.country;
		var area = this.area;
		var eren = this.renderers[2];
		var currency_ren = this.renderers[3];
		var allaccount_ren = this.renderers[4];
		var individual = {
			xtype: 'container',
			layout: 'hbox',
			autoScroll: true,
			margin: '0 0 10',
			items: [{
            xtype: 'fieldset',
			width:260,
            title: '基础选项',
            defaultType: 'checkbox', // each item will be a checkbox
            layout: 'anchor',
            defaults: {
                anchor: '100%',
                hideEmptyLabel: false,
				padding:5
            },
            items: [
                    {
                        xtype:'hidden',
                        name:'id',
                        id:'id'
                    },
                    {
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata[0]
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,   
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'express_id',
	                    fieldLabel: '快递方式',
	                    emptyText:'选择',
	                    name: 'express_id',
						id:'express_id',
						allowBlank:false
					},{
						fieldLabel: '排序大小',
	                    emptyText:'数字越大优先级越高',
						xtype:'numberfield',
						allowNegative:false,
						labelWidth:75,
						minValue:0,
						maxValue:999,
						allowDecimals:false,
						allowBlank:false,
						name:'order_by',
						id:'order_by'
					},
					{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata[4]
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'currency',
	                    fieldLabel: '币种',
	                    emptyText:'使用金额相关此项必填',
	                    name: 'currency',
						id:'currency',
						listeners: {
							change: function(field, e) {
								Ext.getCmp('showcurrcny').setValue(currency_ren(e));
							}
						}
					},
					{
            xtype: 'checkboxgroup',
            fieldLabel: '匹配规则',
			name:'expressGroup',
            // Put all controls in a single column with width 100%
			id:'expressGroup',
            columns: 1,
            items: [
                {
                boxLabel: '默认',
                id:'ExpressDefault'
                },{
				boxLabel: '国家',
				id:'ExpressCountry',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('countrySet').show();
						else Ext.getCmp('countrySet').hide();
					}
				}},
                {
				boxLabel: '订单金额',
				id:'ExpressFee',
				//disabled:true,
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('orderFeeSet').show();
						else Ext.getCmp('orderFeeSet').hide();
						var v = Ext.getCmp('currency').getValue();
						if(!v)Ext.getCmp('showcurrcny').setValue('<font style="color:red">请选择左侧货币类型</font>');
						else Ext.getCmp('showcurrcny').setValue(currency_ren(v));
						
					}
				}},
				{
				boxLabel: '产品SKU',
				id:'ExpressSku',
				//disabled:true,
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('goodSkuSet').show();
						else Ext.getCmp('goodSkuSet').hide();
					}
				}},
				{
				boxLabel: '订单重量',
				//disabled:true,
				id:'ExpressWeigth',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('orderWeigthSet').show();
						else Ext.getCmp('orderWeigthSet').hide();
					}
				}},
				{
				boxLabel: '销售帐号',
				//disabled:true,
				id:'ExpressSalesaccount',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('salesAccountSet').show();
						else Ext.getCmp('salesAccountSet').hide();
					}
				}},
				{
				boxLabel: '产品总数',
				//disabled:true,
				id:'ExpressGoodqty',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('goodsQtySet').show();
						else Ext.getCmp('goodsQtySet').hide();
					}
				}},
                {
                boxLabel: '客选物流',
                //disabled:true,
                id:'ExpressShipping',
                listeners: {
                    change: function(field, e) {
                        if(e) Ext.getCmp('shippingServiceSet').show();
                        else Ext.getCmp('shippingServiceSet').hide();
                    }
                }},
                
				{
				boxLabel: '订单运费',
				id:'ExpressShipfee',
				disabled:true,
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('orderShippingFeeSet').show();
						else Ext.getCmp('orderShippingFeeSet').hide();
					}
				}},
                {
                boxLabel: '国家区域',
                id:'ExpressArea',
                disabled:true,
                listeners: {
                    change: function(field, e) {
                        if(e) Ext.getCmp('areaSetSet').show();
                        else Ext.getCmp('areaSetSet').hide();
                    }
                }},
				{
				boxLabel: '销售站点',
				disabled:true,
				id:'ExpressSalessite',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('salesSiteSet').show();
						else Ext.getCmp('salesSiteSet').hide();
					}
				}},
				{
				boxLabel: '销售渠道',
				disabled:true,
				id:'ExpressSalesChannels',
				listeners: {
					change: function(field, e) {
						if(e) Ext.getCmp('salesChannelsSet').show();
						else Ext.getCmp('salesChannelsSet').hide();
					}
				}}
            ]
        }]
        }, {
            xtype: 'component',
            width: 10
        },{
            xtype: 'fieldset',
            flex: 1,
            title: '匹配选项',
			frame:false,
			border:false,
            layout: 'form',
            defaults: {
                hideEmptyLabel: false,
				padding:5,
            },
			items:[
				{
            xtype: 'fieldset',
            flex: 1,
            title: '国家',
			id:'countrySet',
            defaultType: 'radio', // each item will be a radio button
			hidden:true,
			collapsible:true,
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false,
				padding:5
            },
            items: [
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '匹配规则',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'radio',
				items: [
					{
						boxLabel: '包括以下国家',
                        name: 'countryRule', 
                        id: 'country_if_rule_in', 
						inputValue: 'in',
						checked: true,
					}, {
						boxLabel: '不包括以下国家',
						style:'margin-left:35px;',
                        id: 'country_if_rule_notin', 
						name: 'countryRule',
						inputValue: 'not in'
					}
				]},{
                xtype: 'hidden',
                name: 'countryID',
				id:'countryID'
            },{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '选择国家',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'radio',
				items: [
					{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					fields: ["retrunValue", "displayText"],
					data: country
				}),
				valueField :"retrunValue",
				displayField: "displayText",
				mode: 'local',   
				width:255,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'country',
                queryMode: 'local',
				emptyText:'选中国家,确定按钮加入',
				name: 'country',
				id:'country'
			},
			{
				xtype:'button',
				style:'margin-left:25px;', 
				text:'确定',
				allowDepress: true,     //是否允许按钮被按下的状态
				//enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
				handler: function () {
					
					var v = Ext.getCmp('country').getValue();
					var values = country[(v-1)];
					var str = values[1].split('(');
					if(Ext.getCmp('countryText').getValue() == '') Ext.getCmp('countryText').setValue(str[0]);
					else Ext.getCmp('countryText').setValue(Ext.getCmp('countryText').getValue()+','+str[0]);
					if(Ext.getCmp('countryID').getValue() == '') Ext.getCmp('country').setValue(v);
					else + Ext.getCmp('countryID').setValue(Ext.getCmp('countryID').getValue()+','+v);
					Ext.getCmp('country').setValue('');
				}
			}
				]},
			{
                xtype: 'textarea',
                name: 'countryText',
				id:'countryText',
				height:55,
                fieldLabel:'<font style="color:#ccc">已选</font>',
				labelWidth:75
            }]
        },{
            xtype: 'fieldset',
            flex: 1,
            title: '订单金额',
			id:'orderFeeSet',
			collapsible:true,
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [
			{   
				xtype : 'displayfield',
				fieldLabel: '货币',
				labelWidth: 75,
				id:'showcurrcny'
			},
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '金额区间',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [
					{   
						name:'startFee',
						id:'startFee',
						hideLabel:true,
						emptyText:'起始金额',
						hideTrigger:true,
						minValue:0,
						maxValue:99999,
						xtype : 'numberfield',   
						width:125,
					},
					{   
						xtype : 'displayfield',   
						value : '&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;',
					},
					{   
						name:'endFee',
						id:'endFee',
						hideLabel:true,
						hideTrigger:true,
						emptyText:'结束金额',
						minValue:0,
						maxValue:99999,
						xtype : 'numberfield',   
						width:125,
					}
				
				]
			},
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '订单金额',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [,{
						boxLabel: '>',
						labelWidth:65,
						xtype:'radio',
                        id:'fee_if_rule_d',
						name: 'feeRule',
						inputValue: '>',
						checked: true,
					}, {
						boxLabel: '<',
						labelWidth:65,
						style:'margin-left:25px;',
						xtype:'radio',
                        id:'fee_if_rule_x',
						name: 'feeRule',
						inputValue: '<'
					},
					{
						xtype: 'numberfield',
						name: 'feeRuleValue',
						id:'feeRuleValue',
						style:'margin-left:25px;',
						width:125,
						minValue:0,
						maxValue:99999,
						emptyText:'金额',
						hideLabel:true,
						
					}
				]
			}]
        },{
            xtype: 'fieldset',
            flex: 1,
            title: '产品SKU',
			id:'goodSkuSet',
			collapsible:true,
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '100%',
                hideEmptyLabel: false
            },
            items: [{
                xtype: 'textfield',
                name: 'Skusn',
                id: 'Skusn',
				labelWidth: 75,
				emptyText:'SKU任意位置包含',
                fieldLabel: 'SKU包含'
            }, {
                xtype: 'textfield',
				labelWidth: 75,
                name: 'endSkusn',
                id: 'endSkusn',
				emptyText:'单个SKU结尾包含',
                fieldLabel: 'SKU结尾'
            },{
                xtype: 'textfield',
                name: 'Skusns',
                id: 'Skusns',
				labelWidth: 75,
				emptyText:'多个包含请用英文半角逗号隔开。例:SKU1,SKU2',
                fieldLabel: 'SKU集合'
            },{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: 'SKU长度',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [
					{   
						name:'startSkuQty',
						id:'startSkuQty',
						hideLabel:true,
						emptyText:'起始长度',
						minValue:0,
						maxValue:20,
						hideTrigger:true,
						xtype : 'numberfield'
					},
					{   
						xtype : 'displayfield',   
						value : '&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;',
					},
					{   
						name:'endSkuQty',
						id:'endSkuQty',
						hideLabel:true,
						hideTrigger:true,
						minValue:0,
						maxValue:30,
						emptyText:'结束长度',
						xtype : 'numberfield',
					}
				
				]
			}]
        }, {
            xtype: 'fieldset',
            flex: 1,
            title: '重量',
			id:'orderWeigthSet',
			hidden:true,
			collapsible:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},                             
				fieldLabel: '重量区间',
				labelWidth: 75,       
				combineErrors : true,
				defaultType: 'textfield',
				items: [
					{   
						name:'startWeigth',
						id:'startWeigth',
						hideLabel:true,
						emptyText:'起始重量(KG)',  
						minValue:0,  
						maxValue:500,    
						hideTrigger:true,   
						xtype : 'numberfield',   
						width:125,
					},
					{   
						xtype : 'displayfield',   
						value : '&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;',
					},
					{   
						name:'endWeigth',
						id:'endWeigth',
						hideLabel:true,
						hideTrigger:true,
						minValue:0,
						maxValue:500,
						emptyText:'结束重量(KG)',
						xtype : 'numberfield',   
						width:125,
					}
				
				]
			},
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '订单重量',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [,{
						boxLabel: '>',
						labelWidth:65,
						xtype:'radio',
                        name: 'WeigthRule',
						id: 'weight_if_rule_d',
						inputValue: '>',
						checked: true,
					}, {
						boxLabel: '<',
						labelWidth:65,
						style:'margin-left:25px;',
						xtype:'radio',
						name: 'WeigthRule',
                        id: 'weight_if_rule_x',
						inputValue: '<'
					},
					{
						xtype: 'numberfield',
						name: 'WeigthRuleValue',
						id: 'WeigthRuleValue',
						style:'margin-left:25px;',
						width:125,
						minValue:0,
						maxValue:500,
						emptyText:'重量(KG)',
						hideLabel:true,
						
					}
				]
			}]
        },  {
            xtype: 'fieldset',
            flex: 1,
            title: '订单运费',
			collapsible:true,
			id:'orderShippingFeeSet',
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '运费区间',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [
					{   
						name:'startShipingFee',
						id:'startShipingFee',
						hideLabel:true,
						emptyText:'起始运费',
						hideTrigger:true,
						minValue:0,
						maxValue:99999,
						xtype : 'numberfield',   
						width:125,
					},
					{   
						xtype : 'displayfield',   
						value : '&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;',
					},
					{   
						name:'endShipingFee',
						id:'endShipingFee',
						hideLabel:true,
						hideTrigger:true,
						emptyText:'结束运费',
						minValue:0,
						maxValue:99999,
						xtype : 'numberfield',   
						width:125,
					}
				
				]
			},
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '订单运费',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [,{
						boxLabel: '>',
						labelWidth:65,
						xtype:'radio',
						name: 'ShippingFeeRule',
						inputValue: '>',
						checked: true,
					}, {
						boxLabel: '<',
						labelWidth:65,
						style:'margin-left:25px;',
						xtype:'radio',
						name: 'ShippingFeeRule',
						inputValue: '<'
					},
					{
						xtype: 'numberfield',
						name: 'ShippingFeeRuleValue',
						id:'ShippingFeeRuleValue',
						style:'margin-left:25px;',
						width:125,
						minValue:0,
						maxValue:99999,
						emptyText:'运费金额',
						hideLabel:true,
						
					}
				]
			}]
        },{
            xtype: 'fieldset',
            flex: 1,
            title: '产品总数',
			collapsible:true,
			id:'goodsQtySet',
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '数量区间',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [
					{   
						name:'startGoodqty',
						id:'startGoodqty',
						hideLabel:true,
						emptyText:'起始数量',
						hideTrigger:true,
						minValue:0,
						maxValue:999,
						xtype : 'numberfield',   
						width:125,
					},
					{   
						xtype : 'displayfield',   
						value : '&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;',
					},
					{   
						name:'endGoodqty',
						id:'endGoodqty',
						hideLabel:true,
						hideTrigger:true,
						emptyText:'结束数量',
						minValue:0,
						maxValue:999,
						xtype : 'numberfield',   
						width:125,
					}
				
				]
			},
			{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '总数',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'textfield',
				items: [,{
						boxLabel: '>',
						labelWidth:65,
						xtype:'radio',
                        name: 'GoodqtyRule',
						id:'goodqty_if_rule_d',
						inputValue: '>',
						checked: true,
					}, {
						boxLabel: '<',
						labelWidth:65,
						style:'margin-left:25px;',
						xtype:'radio',
						name: 'GoodqtyRule',
                        id:'goodqty_if_rule_x',
						inputValue: '<'
					},
					{
						xtype: 'numberfield',
						name: 'GoodqtyRuleValue',
						id: 'GoodqtyRuleValue',
						style:'margin-left:25px;',
						width:125,
						minValue:0,
						maxValue:999,
						emptyText:'产品数量',
						hideLabel:true,
						
					}
				]
			}]
        }, {
            xtype: 'fieldset',                    
            flex: 1,
            title: '客选物流',
            id:'shippingServiceSet',
            collapsible:true,
            hidden:true,                                              
            layout: 'anchor', 
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [
            {   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: 'eBay',
                labelWidth: 75,
                combineErrors : true, 
                items: [
                    {
                xtype:'combo',  
                store: Ext.create('Ext.data.ArrayStore',{
                    fields: ["retrunValue", "displayText"],
                    data: [
                        ["USPSFirstClass","USPSFirstClass"],
                        ["ePacketChina","ePacketChina"],
                        ["ePacketHongKong","ePacketHongKong"],
                        ["OtherInternational","OtherInternational"],
                        ["StandardInternational","StandardInternational"],
                        ["ExpeditedInternational","ExpeditedInternational"],
                        ["EconomyShippingFromOutsideUS","EconomyShippingFromOutsideUS"],
                        ["StandardShippingFromOutsideUS","StandardShippingFromOutsideUS"],
                        ["ExpeditedShippingFromOutsideUS","ExpeditedShippingFromOutsideUS"],
                        ["AU_EconomyDeliveryFromOutsideAU","AU_EconomyDeliveryFromOutsideAU"],
                        ["AU_StandardDeliveryFromOutsideAU","AU_StandardDeliveryFromOutsideAU"],
                        ["AU_ExpeditedDeliveryFromOutsideAU","AU_ExpeditedDeliveryFromOutsideAU"],
                        ["AU_AirMailInternational","AU_AirMailInternational"],
                        ["AU_StandardInternational","AU_StandardInternational"],
                        ["AU_ExpeditedInternational","AU_ExpeditedInternational"],
                        ["UK_EconomyShippingFromOutside","UK_EconomyShippingFromOutside"],
                        ["UK_StandardShippingFromOutside","UK_StandardShippingFromOutside"],
                        ["UK_ExpeditedShippingFromOutside","UK_ExpeditedShippingFromOutside"],
                        ["UK_OtherCourierOrDeliveryInternational","UK_OtherCourierOrDeliveryInternational"],
                        ["UK_SellersStandardInternationalRate","UK_SellersStandardInternationalRate"],
                        ["UK_CollectInPersonInternational","UK_CollectInPersonInternational"],
                        ["UK_RoyalMailFirstClassStandard","UK_RoyalMailFirstClassStandard"],
                        ["UK_RoyalMailFirstClassRecorded","UK_RoyalMailFirstClassRecorded"],
                        ["UK_RoyalMailSpecialDeliveryNextDay","UK_RoyalMailSpecialDeliveryNextDay"],
                        ["UK_RoyalMailAirmailInternational","UK_RoyalMailAirmailInternational"],
                        ["UK_RoyalMailInternationalSignedFor","UK_RoyalMailInternationalSignedFor"]
                    ]
                }),
                valueField :"retrunValue",
                displayField: "displayText",
                mode: 'local',
                editable: false,
                width:255,        
                forceSelection: true,
                triggerAction: 'all',
                hiddenName:'ebayservice',
                emptyText:'选中,确定按钮加入',
                name: 'ebayservice',
                id:'ebayservice'
            },
            {
                xtype:'button',
                style:'margin-left:25px;', 
                text:'确定',
                allowDepress: true,     //是否允许按钮被按下的状态
                //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                handler: function () { 
                    var v = Ext.getCmp('ebayservice').getValue();
                    if(Ext.getCmp('ShippingText').getValue() == '') Ext.getCmp('ShippingText').setValue(v);
                    else Ext.getCmp('ShippingText').setValue(Ext.getCmp('ShippingText').getValue()+','+v);
                    Ext.getCmp('ebayservice').setValue('');
                }
            }
            ]}
            
             ,{   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: 'Amazon',
                labelWidth: 75,
                combineErrors : true,
                defaultType: 'radio',
                items: [
                    {
                xtype:'combo',  
                store: Ext.create('Ext.data.ArrayStore',{
                    fields: ["retrunValue", "displayText"],
                    data: [
                          ["AFN","AFN"],
                          ["MFN","MFN"],
                          ["Standard","Standard"],
                          ["DHL","DHL"],
                          ["USPS","USPS"],
                    ]
                }),
                valueField :"retrunValue",
                displayField: "displayText",
                mode: 'local',
                editable: false,
                width:255,       
                forceSelection: true,
                triggerAction: 'all',
                hiddenName:'amazonservice',
                emptyText:'选中,确定按钮加入',
                name: 'amazonservice',
                id:'amazonservice'
            },
            {
                xtype:'button',
                style:'margin-left:25px;', 
                text:'确定',
                allowDepress: true,     //是否允许按钮被按下的状态
                //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                handler: function () {
                    var v = Ext.getCmp('amazonservice').getValue();
                    if(Ext.getCmp('ShippingText').getValue() == '') Ext.getCmp('ShippingText').setValue(v);
                    else Ext.getCmp('ShippingText').setValue(Ext.getCmp('ShippingText').getValue()+','+v);
                    Ext.getCmp('amazonservice').setValue('');
                }
            }
            ]} 
             ,{   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: 'Aliexpress',
                labelWidth: 75,
                combineErrors : true,
                defaultType: 'radio',
                items: [
                    {
                xtype:'combo',       
                store: Ext.create('Ext.data.ArrayStore',{
                    fields: ["retrunValue", "displayText"],
                    data: [
                      ["AUSPOST","AUSPOST"],
                        ["CORREOS","Correos"],
                        ["ROYAL_MAIL","Royal Mail"],
                        ["DEUTSCHE_POST","Deutsche Post"],
                        ["RUSSIAN_POST","Russian Post"],
                        ["LAPOSTE","LAPOSTE"],
                        ["POSTEITALIANE","Posteitaliane"],
                        ["USPS","USPS"],
                        ["UPS_US","UPS"],
                        ["UPS","UPS Express Saver"],
                        ["JNE","JNE"],
                        ["ACOMMERCE","aCommerce"],
                        ["UPSE","UPS Expedited"],
                        ["DHL_UK","DHL_UK"],
                        ["DHL_ES","DHL_ES"],
                        ["DHL_IT","DHL_IT"],
                        ["DHL_DE","DHL_DE"],
                        ["ENVIALIA","Envialia"],
                        ["DHL_FR","DHL_FR"],
                        ["DHL","DHL"],
                        ["FEDEX","Fedex IP"],
                        ["FEDEX_IE","Fedex IE"],
                        ["TNT","TNT"],
                        ["SF","SF Express"],
                        ["EMS","EMS"],
                        ["EMS_ZX_ZX_US","ePacket"],
                        ["E_EMS","e-EMS"],
                        ["EMS_SH_ZX_US","DHL Global Mail"],
                        ["ITELLA_PY","Posti Finland Economy"],
                        ["ITELLA","Posti Finland"],
                        ["CPAM","China Post Registered Air Mail"],
                        ["YANWEN_JYT","China Post Ordinary Small Packet Plus"],
                        ["CPAP","China Post Air Parcel"],
                        ["TOLL","TOLL"],
                        ["HKPAM","HongKong Post Air Mail"],
                        ["HKPAP","HongKong Post Air Parcel"],
                        ["SGP","Singapore Post"],
                        ["CHP","Swiss Post"],
                        ["SEP","Sweden Post"],
                        ["ARAMEX","Aramex"],
                        ["ZTORU","ZTO Express to Russia"],
                        ["ECONOMIC139","139 ECONOMIC Package"],
                        ["SPSR_RU","SPSR_RU"],
                        ["SPSR","SPSR"],
                        ["YANWEN_AM","Special Line"],
                        ["CPAM_HRB","Russian Air"],
                        ["CTR_LAND_PICKUP","CTR-LAND PICKUP"],
                        ["SPSR_CN","Russia Express-SPSR"],
                        ["OTHER_ES","Seller's Shipping Method - ES"],
                        ["OTHER_IT","Seller's Shipping Method - IT"],
                        ["OTHER_FR","Seller's Shipping Method - FR"],
                        ["OTHER_US","Seller's Shipping Method - US"],
                        ["OTHER_UK","Seller's Shipping Method - UK"],
                        ["OTHER_RU","Seller's Shipping Method - RU"],
                        ["OTHER_DE","Seller's Shipping Method - DE"],
                        ["OTHER_AU","Seller's Shipping Method - AU"],
                        ["Other","Seller's Shipping Method"]
                    ]
                }),
                valueField :"displayText",
                displayField: "displayText",
                mode: 'local',   
                queryMode: 'local',
                width:255,
                forceSelection: true,
                triggerAction: 'all',
                hideLabel:true,
                hiddenName:'aliservice',
                emptyText:'选中,确定按钮加入',
                name: 'aliservice',
                id:'aliservice'
            },
            {
                xtype:'button',
                style:'margin-left:25px;', 
                text:'确定',
                allowDepress: true,     //是否允许按钮被按下的状态
                //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                handler: function () {
                    var v = Ext.getCmp('aliservice').getValue();
                    if(Ext.getCmp('ShippingText').getValue() == '') Ext.getCmp('ShippingText').setValue(v);
                    else Ext.getCmp('ShippingText').setValue(Ext.getCmp('ShippingText').getValue()+','+v);
                    Ext.getCmp('aliservice').setValue('');
                }
            }
            ]},{   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: 'DHgate',
                labelWidth: 75,
                combineErrors : true,
                defaultType: 'radio',
                items: [
                    {
                xtype:'combo',       
                store: Ext.create('Ext.data.ArrayStore',{
                    fields: ["retrunValue", "displayText"],
                    data: [
                      ["ePacket","ePacket"],
                      ["e-ulink","e-ulink"],
                      ["JCEX","JCEX"],
                      ["JILLION","JILLION"],
                      ["Euro Business Parcel","Euro Business Parcel"],
                      ["China Post Air Mail","China Post Air Mail"],
                      ["Exclusive Lane-Russia","Exclusive Lane-Russia"],
                      ["CNE","CNE"],
                      ["UPS","UPS"],
                      ["DHL","DHL"],
                      ["FEDEX","FEDEX"],
                      ["TNT","TNT"],
                      ["DNJ","DNJ"],
                      ["China Post Air","CHINAPOSTAIR"],
                      ["China Post SAL","CHINAPOSTSAL"],
                      ["Hongkong Post","HONGKONGPOST"],
                      ["Singapore post","SINGAPOREPOST"],
                      ["DHL-Online Shipping","DHL-Online Shipping"]
                    ]
                }),
                valueField :"retrunValue",
                displayField: "displayText",
                mode: 'local',   
                queryMode: 'local',
                width:255,
                forceSelection: true,
                triggerAction: 'all',
                hideLabel:true,
                hiddenName:'aliservice',
                emptyText:'选中,确定按钮加入',
                name: 'dhservice',
                id:'dhservice'
            },
            {
                xtype:'button',
                style:'margin-left:25px;', 
                text:'确定',
                allowDepress: true,     //是否允许按钮被按下的状态
                //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                handler: function () {
                    var v = Ext.getCmp('dhservice').getValue();
                    if(Ext.getCmp('ShippingText').getValue() == '') Ext.getCmp('ShippingText').setValue(v);
                    else Ext.getCmp('ShippingText').setValue(Ext.getCmp('ShippingText').getValue()+','+v);
                    Ext.getCmp('dhservice').setValue('');
                }
            }
            ]},
            {   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: '自定义',
                labelWidth: 75,
                combineErrors : true,  
                items: [
                    {
                        xtype:'textfield',
                        name:'Shiping',
                        id:'Shiping',
                        hideLabel:true,  
                        width:255,
                    },
                    {
                        xtype:'button',
                        style:'margin-left:25px;', 
                        text:'确定',
                        allowDepress: true,     //是否允许按钮被按下的状态
                        //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                        handler: function () {
                             var v = Ext.getCmp('Shiping').getValue();
                            if(Ext.getCmp('ShippingText').getValue() == '') Ext.getCmp('ShippingText').setValue(v);
                            else Ext.getCmp('ShippingText').setValue(Ext.getCmp('ShippingText').getValue()+','+v);
                            Ext.getCmp('Shiping').setValue('');
                        }
                    }
                ]},
            {
                xtype: 'textarea',
                name: 'ShippingText',
                id:'ShippingText',
                height:55,
                fieldLabel:'<font style="color:#ccc">已选</font>',
                labelWidth:75
            }]
        }, {
            xtype: 'fieldset',
            flex: 1,
            title: '销售帐号',
			collapsible:true,
			id:'salesAccountSet',
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '匹配规则',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'radio',
				items: [
					{
						boxLabel: '包括以下帐号',
						name: 'accountRule',
                        id:'account_if_rule_in',
						inputValue: 'in',
						checked: true,
					}, {
						boxLabel: '不包括以下帐号',
						style:'margin-left:35px;',
						name: 'accountRule',
                        id:'account_if_rule_notin',
						inputValue: 'not in'
					}
				]},{   
				xtype: 'fieldcontainer',
				layout: {
					type: 'hbox',
				},   
				fieldLabel: '选择帐号',
				labelWidth: 75,
				combineErrors : true,
				defaultType: 'radio',
				items: [
					{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					fields: ["retrunValue", "displayText"],
					data: this.arrdata[2]
				}),
				valueField :"retrunValue",
				displayField: "displayText",
				mode: 'local',
				editable: false,
				width:255,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'salesAccount',
				emptyText:'选中帐号,确定按钮加入',
				name: 'salesAccount',
				id:'salesAccount'
			},
			{
				xtype:'button',
				style:'margin-left:25px;', 
				text:'确定',
				allowDepress: true,     //是否允许按钮被按下的状态
				//enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
				handler: function () {
					if(Ext.getCmp('salesAccountText').getValue() == '') Ext.getCmp('salesAccountText').setValue(allaccount_ren(Ext.getCmp('salesAccount').getValue()));
					else Ext.getCmp('salesAccountText').setValue(Ext.getCmp('salesAccountText').getValue()+','+allaccount_ren(Ext.getCmp('salesAccount').getValue()));
					Ext.getCmp('salesAccount').setValue('');
				}
			}
				]},
			{
                xtype: 'textarea',
                name: 'salesAccountText',
				id:'salesAccountText',
				height:55,
                fieldLabel:'<font style="color:#ccc">已选</font>',
				labelWidth:75
            }]
        },{
            xtype: 'fieldset',
            flex: 1,
            title: '区域',
            id:'areaSetSet',
            collapsible:true,
            hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [
            {   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: '匹配规则',
                labelWidth: 75,
                combineErrors : true,
                defaultType: 'radio',
                items: [
                    {
                        boxLabel: '包括以下区域',
                        name: 'fav-color',
                        inputValue: 'blue',
                        checked: true,
                    }, {
                        boxLabel: '不包括以下区域',
                        style:'margin-left:35px;',
                        name: 'fav-color',
                        inputValue: 'green'
                    }
                ]},{   
                xtype: 'fieldcontainer',
                layout: {
                    type: 'hbox',
                },   
                fieldLabel: '选择区域',
                labelWidth: 75,
                combineErrors : true,
                defaultType: 'radio',
                items: [
                    {
                xtype:'combo',
                store: Ext.create('Ext.data.ArrayStore',{
                    fields: ["retrunValue", "displayText"],
                    data: area
                }),
                valueField :"retrunValue",
                displayField: "displayText",
                mode: 'local',
                editable: false,
                width:255,
                forceSelection: true,
                triggerAction: 'all',
                hiddenName:'area',
                emptyText:'选中区域,确定按钮加入',
                name: 'area',
                id:'area'
            },
            {
                xtype:'button',
                style:'margin-left:25px;', 
                text:'确定',
                allowDepress: true,     //是否允许按钮被按下的状态
                //enableToggle: true,     //是否允许按钮在弹起和按下两种状态中切换
                handler: function () {
                    
                    var v = Ext.getCmp('area').getValue();
                    var value = eren(v);
                    if(Ext.getCmp('areaText').getValue() == '') Ext.getCmp('areaText').setValue(value);
                    else Ext.getCmp('areaText').setValue(Ext.getCmp('areaText').getValue()+','+value);
                    
                }
            }
                ]},
            {
                xtype: 'textarea',
                name: 'areaText',
                id:'areaText',
                height:55,
                fieldLabel:'<font style="color:#ccc">已选</font>',
                labelWidth:75
            }]
        },  {
            xtype: 'fieldset',
            flex: 1,
            title: '销售站点',
			id:'salesSiteSet',
			collapsible:true,
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{
                xtype: 'textfield',
                name: 'txt-test2',
                fieldLabel:'已选',
				labelWidth:35,
				readOnly:true,
				disabled:true
            }]
        }, {
            xtype: 'fieldset',
            flex: 1,
            title: '销售渠道',
			collapsible:true,
			id:'salesChannelsSet',
			hidden:true,
            defaultType: 'radio', // each item will be a radio button
            layout: 'anchor',
            defaults: {
                anchor: '95%',
                hideEmptyLabel: false
            },
            items: [{
				xtype:'combo',
				store: Ext.create('Ext.data.ArrayStore',{
					fields: ["retrunValue", "displayText"],
					data: this.arrdata[3]
				}),
				valueField :"retrunValue",
				displayField: "displayText",
				mode: 'local',
				labelWidth:75,
				editable: false,
				forceSelection: true,
				triggerAction: 'all',
				hiddenName:'express_id',
				fieldLabel: '渠道',
				emptyText:'选择渠道',
				name: 'express_id',
				allowBlank:false
			},{
                xtype: 'textfield',
                name: 'txt-test2',
                fieldLabel:'已选',
				labelWidth:35,
				readOnly:true,
				disabled:true
            }]
        }
			
			]
        }]
    };
        var items = [individual];	
		this.formitem = items;
	},
	submitRecord: function() {
        var form = this.getForm();
        var values = form.getFieldValues();
		var checkValue = Ext.getCmp('expressGroup').getChecked();
		var jsonArray = [];
		if(Ext.getCmp('express_id').getValue() == null || Ext.getCmp('order_by').getValue() == null){
			Ext.Msg.alert('警告', '请选择快递方式或排序');
			return;
		}
		Ext.Array.each(checkValue, function(item){
			if(item.id == 'ExpressCountry'){
				jsonArray.push({
					rule_id : 31,
					rule : values.countryRule,
					value: values.countryText
				});
			}else if(item.id == 'ExpressArea'){
				jsonArray.push({
					rule_id : 32,
					rule : values.countryRule,
					value: values.countryText
				});
			}else if(item.id == 'ExpressFee'){
				var feev = '';
				var feerule = '';
				if(values.startFee && values.endFee){
					feev = values.startFee + ',' + values.endFee;
					feerule = '><';
				}else if(values.feeRuleValue){
					feev = values.feeRuleValue;
					feerule = values.feeRule;
				}
				jsonArray.push({
					rule_id : 33,
					rule : feerule,
					value: feev
				});
			}else if(item.id == 'ExpressWeigth'){
				var weigthv = '';
				var weigthrule = '';
				if(values.startWeigth && values.endWeigth){
					weigthv = values.startWeigth + ',' + values.endWeigth;
					weigthrule = '><';
				}else if(values.WeigthRuleValue){
					weigthv = values.WeigthRuleValue;
					weigthrule = values.WeigthRule;
				}
				jsonArray.push({
					rule_id : 34,
					rule : weigthrule,
					value: weigthv
				});
			}else if(item.id == 'ExpressGoodqty'){
				var goodsqtyv = '';
				var goodsqtyrule = '';
				if(values.startGoodqty && values.endGoodqty){
					goodsqtyv = values.startGoodqty + ',' + values.endGoodqty;
					goodsqtyrule = '><';
				}else if(values.GoodqtyRuleValue){
					goodsqtyv = values.GoodqtyRuleValue;
					goodsqtyrule = values.GoodqtyRule;
				}
				jsonArray.push({
					rule_id : 37,
					rule : goodsqtyrule,
					value: goodsqtyv
				});
			}else if(item.id == 'ExpressSalesaccount'){
				jsonArray.push({
					rule_id : 38,
					rule : values.accountRule,
					value: Ext.getCmp('salesAccountText').getValue()
				});
			}else if(item.id == 'ExpressSku'){
                if(values.Skusn){     
                    var goodsskuqtyv = values.Skusn;
                    var goodsskuqtyrule = 'like';
                    jsonArray.push({
                        rule_id : 35,
                        rule : goodsskuqtyrule,
                        value: goodsskuqtyv
                    });         
                }  
                if(values.endSkusn){     
                    var goodsskuqtyv = values.endSkusn;
                    var goodsskuqtyrule = '$';     
                    jsonArray.push({
                        rule_id : 35,
                        rule : goodsskuqtyrule,
                        value: goodsskuqtyv
                    }); 
                }
                if( values.startSkuQty && values.endSkuQty ){     
                    var goodsskuqtyv = values.startSkuQty+ ',' + values.endSkuQty;   
                    var goodsskuqtyrule = '><';   
                    jsonArray.push({
                        rule_id : 35,
                        rule : goodsskuqtyrule,
                        value: goodsskuqtyv
                    }); 
                } 
                if(values.Skusns){     
                    var goodsskuqtyv = values.Skusns; 
                    var goodsskuqtyrule = '&&';
                    jsonArray.push({
                        rule_id : 35,
                        rule : goodsskuqtyrule,
                        value: goodsskuqtyv
                    }); 
                }      
            }else if(item.id == 'ExpressShipping'){
                          
                if(values.serShipping == ''){     
                    Ext.Msg.alert('MSG','ShippingService未填写');           
                }else{
                    var ShgText = values.ShippingText;
                    jsonArray.push({
                        rule_id : 41,
                        rule : 'in',
                        value: ShgText
                    });
                }      
            }else if(item.id == 'ExpressDefault'){
				jsonArray.push({
					rule_id : 0,
					rule : '',
					value: ''
				});
			}  
		});
        
        var type = 'add';
        if(Ext.getCmp('id').getValue() !== '' && Ext.getCmp('id').getValue()){
            type = 'update';     
        }
		var thiz = this.store;
		Ext.getBody().mask("正在保存数据.请稍等...","x-mask-loading");
        Ext.Ajax.request({
			url: this.saveURL,
			method: 'post',
			params:{'ruledata':Ext.encode(jsonArray),'express_id':Ext.getCmp('express_id').getValue(),'order_by':Ext.getCmp('order_by').getValue(),id:Ext.getCmp('id').getValue(),type:type},
			success:function(response,opt){
				var res = Ext.decode(response.responseText);
				Ext.getBody().unmask();
				if (res.success) {
					Ext.Msg.alert('MSG', res.msg);
                    Ext.getCmp('id').setValue('');   
					thiz.load(); 
				} else {
					Ext.Msg.alert('修改失败', res.msg)
				}
			},
			failure: function() {
				Ext.getBody().unmask();
				Ext.Msg.alert('操作', '服务器出现错误');
			}
		});
    }
});
/**
 * ebay标记列表
 */
Ext.define('Ext.ux.ExpressMarkGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'ExpressMarkGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'ExpressMarkGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '快递方式',
						dataIndex: 'express_id',
						flex:1,
						renderer:this.renderers
					},{
						header: 'Carrier Name',
						flex:1,
						dataIndex: 'value'
					},{
                        header: '标记名',
                        flex:1,
                        dataIndex: 'name'
                    },{
						header: '标记查询链接',
						flex:1,
						dataIndex: 'url'
					}];
        this.columns = cols;
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:105,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'express_id',
	                    fieldLabel: '规则',
	                    emptyText:'选择',
	                    name: 'express_id',
						allowBlank:false,
						blankText:'请选择'
					},{
						fieldLabel: 'Carrier Name',
						xtype:'textfield',
						labelWidth:105,
						width:250,
						name:'value'
					},{
                        fieldLabel: '标记名',
                        xtype:'textfield',
                        labelWidth:105,
                        width:250,
                        name:'name'
                    },{
						fieldLabel: '标记查询链接',
						xtype:'textfield',
						labelWidth:105,
						width:250,
						name:'url'
					}];	
		this.formitem = items;
	}
});
Ext.define('Ext.ux.UnMarkGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },	
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '快递方式',
						flex:1,
						dataIndex: 'express_id',
						renderer:this.renderers
					}];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'UnMarkGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'UnMarkGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'express_id',
	                    fieldLabel: '规则',
	                    emptyText:'选择',
	                    name: 'express_id',
						allowBlank:false,
						blankText:'请选择'
					}];	
		this.formitem = items;
	}
});
Ext.define('Ext.ux.NtMarkGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '快递方式',
						flex:1,
						dataIndex: 'express_id',
						renderer:this.renderers
					}];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'NtMarkGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'NtMarkGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'express_id',
	                    fieldLabel: '规则',
	                    emptyText:'选择',
	                    name: 'express_id',
						allowBlank:false,
						blankText:'请选择'
					}];	
		this.formitem = items;
	}
});
Ext.define('Ext.ux.ExpressDepotGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '快递方式',
						flex:1,
						dataIndex: 'shipping_id',
						renderer:this.renderers
					},{
						header: '发货仓库',
						flex:1,
						dataIndex: 'depot'
					}];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'ExpressDepotGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'ExpressDepotGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'shipping_id',
	                    fieldLabel: '规则',
	                    emptyText:'选择',
	                    name: 'shipping_id',
						allowBlank:false,
						blankText:'请选择'
					},{
	                    xtype:'combo',
						store: Ext.create('Ext.data.ArrayStore',{
									 fields: ["id", "key_type"],
									 data: this.depot
							}),
	                    valueField :"id",
	                    displayField: "key_type",
	                    mode: 'local',
						labelWidth:75,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'depot_id',
	                    fieldLabel: '所属仓库',
	                    emptyText:'选择',
	                    name: 'depot_id',
						allowBlank:false,
						blankText:'请选择'
					}];	
		this.formitem = items;
	}
});
Ext.define('Ext.ux.ExpressCostGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '快递方式',
						flex:1,
						dataIndex: 'express_id',
						renderer:this.renderers
					},{
						header: 'Shipping Formula',
						flex:1,
						dataIndex: 'value'
					}];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'ExpressCostGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'ExpressCostGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
	                    xtype:'combo',
	            		store: Ext.create('Ext.data.ArrayStore',{
							fields: ["retrunValue", "displayText"],
							data: this.arrdata
	                    }),
						valueField :"retrunValue",
	                    displayField: "displayText",
	                    mode: 'local',
						labelWidth:75,
						width:250,
	                    editable: false,
	                    forceSelection: true,
	                    triggerAction: 'all',
	                    hiddenName:'express_id',
	                    fieldLabel: '快递方式',
	                    emptyText:'选择',
	                    name: 'express_id',
						allowBlank:false,
						blankText:'请选择'
					},{
						fieldLabel: '计算公式',
						xtype:'textfield',
						labelWidth:75,
						width:450,
						allowBlank:false,
						name:'value'
					}];	
		this.formitem = items;
	}
});
Ext.define('Ext.ux.UnMarkGrid',{
    extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent(this);
    },    
    createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
                        header: '快递方式',
                        flex:1,
                        dataIndex: 'express_id',
                        renderer:this.renderers
                    }];
        this.columns = cols;
    },
    createTbar: function() {
        var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'UnMarkGrid_editBtn',
            ref: '../editBtn',
            disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'UnMarkGrid_removeBtn',
            ref: '../removeBtn',
            disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
    createFormtiems:function(){
        var items = [{
                        xtype:'hidden',
                        name: this.fields[0]
                    },{
                        xtype:'combo',
                        store: Ext.create('Ext.data.ArrayStore',{
                            fields: ["retrunValue", "displayText"],
                            data: this.arrdata
                        }),
                        valueField :"retrunValue",
                        displayField: "displayText",
                        mode: 'local',
                        labelWidth:75,
                        width:250,
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'express_id',
                        fieldLabel: '规则',
                        emptyText:'选择',
                        name: 'express_id',
                        allowBlank:false,
                        blankText:'请选择'
                    }];    
        this.formitem = items;
    }
});
Ext.define('Ext.ux.NtMarkGrid',{
    extend:'Ext.ux.NormalGrid',
    initComponent: function() {
        this.callParent(this);
    },
    createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
                        header: '快递方式',
                        flex:1,
                        dataIndex: 'express_id',
                        renderer:this.renderers
                    }];
        this.columns = cols;
    },
    createTbar: function() {
        var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'NtMarkGrid_editBtn',
            ref: '../editBtn',
            disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'NtMarkGrid_removeBtn',
            ref: '../removeBtn',
            disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
    createFormtiems:function(){
        var items = [{
                        xtype:'hidden',
                        name: this.fields[0]
                    },{
                        xtype:'combo',
                        store: Ext.create('Ext.data.ArrayStore',{
                            fields: ["retrunValue", "displayText"],
                            data: this.arrdata
                        }),
                        valueField :"retrunValue",
                        displayField: "displayText",
                        mode: 'local',
                        labelWidth:75,
                        width:250,
                        editable: false,
                        forceSelection: true,
                        triggerAction: 'all',
                        hiddenName:'express_id',
                        fieldLabel: '规则',
                        emptyText:'选择',
                        name: 'express_id',
                        allowBlank:false,
                        blankText:'请选择'
                    }];    
        this.formitem = items;
    }
});
Ext.define('Ext.ux.ExpressAreaGrid',{
	extend:'Ext.ux.NormalGrid',
	initComponent: function() {
        this.callParent(this);
    },
	createColumns: function() {
        var cols = [{xtype:'rownumberer'},{
						header: '区域',
						flex:1,
						dataIndex: 'area'
					}];
        this.columns = cols;
    },
    createTbar: function() {
    	var me = this;
        this.tbar = [{
            text: '创建',
            iconCls: 'x-tbar-add',
            handler: this.createRecord.bind(me)
        }, {
            text: '编辑',
            iconCls: 'x-tbar-update',
            id: 'ExpressAreaGrid_editBtn',
			ref: '../editBtn',
			disabled:true,
            handler: this.updateRecord.bind(me)
        }, {
            text: '删除',
            iconCls: 'x-tbar-del',
            id: 'ExpressAreaGrid_removeBtn',
			ref: '../removeBtn',
			disabled:true,
            handler: this.removeRecord.bind(me)
        }];
    },
	createFormtiems:function(){
        var items = [{
						xtype:'hidden',
						name: this.fields[0]
            		},{
						fieldLabel: '区域',
						xtype:'textfield',
						labelWidth:75,
						width:250,
						allowBlank:false,
						name: this.fields[1]
					},{
						fieldLabel: '国家集合',
						xtype:'textarea',
						width:280,
						labelWidth:75,
						allowBlank:false,
						name: this.fields[2]
					}];	
		this.formitem = items;
	}
});