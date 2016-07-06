Ext.define('Ext.ux.systemForm',{
	extend:'Ext.form.Panel',
	initComponent: function() {
		this.frame = true,
		this.autoHeight = true,
		this.buttonAlign = 'center',
		this.creatTab();
		this.creatItems();
		this.creatButtons();
		this.tab.deferredRender = false;
        Ext.ux.systemForm.superclass.initComponent.call(this);
    },
	creatTab:function(){
		var info = this.info;
		this.tab = Ext.create('Ext.TabPanel',{
        activeTab: 0,
		deferredRender:false,
        defaults:{autoScroll: true,autoHeight:true},
        items:[{
			    id:'tab1',
                title: '基本信息',
				padding:5,
				defaultType: 'textfield',
				autoScroll:true,
                items:[
					   {
                fieldLabel: '公司名称',
				width:550,
                value: info.com_name,
                name: 'com_name'
				},{
					fieldLabel: 'EUB标记发货',
					xtype:'checkbox',
					name:'CFG_EUB_MARK',
					checked:info.CFG_EUB_MARK?true:false,
					value:info.CFG_EUB_MARK
				},{
					fieldLabel: '无需Paypal校对',
					xtype:'checkbox',
					name:'CFG_CHECK_PAYPAL',
					checked:info.CFG_CHECK_PAYPAL?true:false,
					value:info.CFG_CHECK_PAYPAL
				},{
					fieldLabel: '加载Ebay转账订单',
					xtype:'checkbox',
					name:'CFG_CHECK_SIS',
					checked:info.CFG_CHECK_SIS?true:false,
					value:info.CFG_CHECK_SIS
				},{
					fieldLabel: '自动物流选择',
					xtype:'checkbox',
					name:'CFG_EXPRESS_RULE',
					checked:info.CFG_EXPRESS_RULE?true:false,
					value:info.CFG_EXPRESS_RULE
				},{
					fieldLabel: '自动库存判断',
					xtype:'checkbox',
					name:'CFG_GOODS_CHECK',
					checked:info.CFG_GOODS_CHECK?true:false,
					value:info.CFG_GOODS_CHECK
				},{
					fieldLabel: '自动组合分拆',
					xtype:'checkbox',
					name:'CFG_GOODS_SPLIT',
					checked:info.CFG_GOODS_SPLIT?true:false,
					value:info.CFG_GOODS_SPLIT
				},{
					fieldLabel: '配货校对产品',
					xtype:'checkbox',
					name:'CFG_GOODS_COLLATION',
					checked:info.CFG_GOODS_COLLATION?true:false,
					value:info.CFG_GOODS_COLLATION
				},{
					fieldLabel: '未锁定减库存',
					xtype:'checkbox',
					name:'CFG_REDUCE_QTY',
					checked:info.CFG_REDUCE_QTY?true:false,
					value:info.CFG_REDUCE_QTY
				},{
					fieldLabel: 'FBA仓库出库',
					xtype:'checkbox',
					name:'CFG_AUTO_FBA',
					checked:info.CFG_AUTO_FBA?true:false,
					value:info.CFG_AUTO_FBA
				},{
					fieldLabel: '不加载发货订单',
					xtype:'checkbox',
					name:'CFG_IGONRE_ORDER',
					checked:info.CFG_IGONRE_ORDER?true:false,
					value:info.CFG_IGONRE_ORDER
				},{
					fieldLabel: '更新发货信息',
					xtype:'checkbox',
					name:'CFG_UPDATE_ORDER',
					checked:info.CFG_UPDATE_ORDER?true:false,
					value:info.CFG_UPDATE_ORDER
				},{
					fieldLabel: '多SKU支持',
					xtype:'checkbox',
					name:'CFG_OTHER_SKU',
					checked:info.CFG_OTHER_SKU?true:false,
					value:info.CFG_OTHER_SKU
				},{
                    fieldLabel: '自动生成编码',
                    xtype:'checkbox',
                    name:'CFG_AUTOCREAT_SN',
                    checked:info.CFG_AUTOCREAT_SN?true:false,
                    value:info.CFG_AUTOCREAT_SN
                },{
					fieldLabel: '使用多物流账号',
					xtype:'checkbox',
					name:'CFG_MORE_SHIPPINGS',
					checked:info.CFG_MORE_SHIPPINGS?true:false,
					value:info.CFG_MORE_SHIPPINGS
				},{
					fieldLabel: '使用Paypal地址',
					xtype:'checkbox',
					name:'CFG_REPLACE_ADD',
					checked:info.CFG_REPLACE_ADD?true:false,
					value:info.CFG_REPLACE_ADD
				},{
					fieldLabel: '入库更新库存',
					xtype:'checkbox',
					name:'CFG_GOODS_UPDATEQTY',
					checked:info.CFG_GOODS_UPDATEQTY?true:false,
					value:info.CFG_GOODS_UPDATEQTY
				},{
					fieldLabel: '采购更新成本',
					xtype:'checkbox',
					name:'CFG_GOODS_UPDATECOST',
					checked:info.CFG_GOODS_UPDATECOST?true:false,
					value:info.CFG_GOODS_UPDATECOST
				},{
					fieldLabel: '默认币种',
					name:'CFG_CURRENCY',
					value:info.CFG_CURRENCY
				},{
					fieldLabel: '固定价计算公式',
					name:'CFG_CAL_PRICE',
					width:850,
					value:info.CFG_CAL_PRICE
				},{
					fieldLabel: '公式变量',
					xtype:'displayfield',
					value:'成本价:{$cost}<br>包装费:{$package_fee}<br>运费:{$shipping_fee}<br>汇率:{$rate}'
				}]
            },{
				id:'tab2',
                title: '单据相关',
				padding:5,
                defaultType: 'textfield',
                items: [{
					fieldLabel: '销售订单前缀',
					name:'CFG_ORDER_PREFIX',
					value:info.CFG_ORDER_PREFIX
				},{
					fieldLabel: '采购订单前缀',
					name:'CFG_P_ORDER_PREFIX',
					value:info.CFG_P_ORDER_PREFIX
				},{
					fieldLabel: '采购退货前缀',
					name:'CFG_P_RETURN_PREFIX',
					value:info.CFG_P_RETURN_PREFIX
				},{
					fieldLabel: '入库单前缀',
					name:'CFG_IN_ORDER_PREFIX',
					value:info.CFG_IN_ORDER_PREFIX
				},{
					fieldLabel: '出库单前缀',
					name:'CFG_OUT_ORDER_PREFIX',
					value:info.CFG_OUT_ORDER_PREFIX
				},{
					fieldLabel: '调拨单前缀',
					name:'CFG_DB_ORDER_PREFIX',
					value:info.CFG_DB_ORDER_PREFIX
				},{
					fieldLabel: '盘点单前缀',
					name:'CFG_CHECK_ORDER_PREFIX',
					value:info.CFG_CHECK_ORDER_PREFIX
				},{
					fieldLabel: 'RMA单前缀',
					name:'CFG_RMA_ORDER_PREFIX',
					value:info.CFG_RMA_ORDER_PREFIX
				},{
					fieldLabel: '退换货单前缀',
					name:'CFG_RETURN_ORDER_PREFIX',
					value:info.CFG_RETURN_ORDER_PREFIX
				},{
					fieldLabel: '付款单前缀',
					name:'CFG_RF_ORDER_PREFIX',
					value:info.CFG_RF_ORDER_PREFIX
				},{
					fieldLabel: '收款单前缀',
					name:'CFG_GF_ORDER_PREFIX',
					value:info.CFG_GF_ORDER_PREFIX
				},{
					fieldLabel: '费用单前缀',
					name:'CFG_CF_ORDER_PREFIX',
					value:info.CFG_CF_ORDER_PREFIX
				},{
					fieldLabel: 'sku无效前缀长度',
					name:'CFG_PREFIX_GOODSSN',
					value:info.CFG_PREFIX_GOODSSN,
					xtype:'numberfield',
					maxValue:6,
					allowNegative:false,
					allowDecimals:false
				},{
					fieldLabel: 'SKU无效分隔符',
					name:'CFG_GOODSSN_SPLIT',
					value:info.CFG_GOODSSN_SPLIT
				},{
					xtype: 'fieldset',
					layout:'column',
					width:350,
					padding:8,
					title: '强制SKU长度',
					items: [{
							columnWidth:.35,
							boxLabel:'是否打开',
							xtype:'checkbox',
							name:'CFG_GOODSSN_AUTOLENGTH',
							checked:info.CFG_GOODSSN_AUTOLENGTH?true:false,
							value:info.CFG_GOODSSN_AUTOLENGTH
						},
						{
							columnWidth:.6,
							fieldLabel: 'SKU长度',
							labelWidth:70,
							width:200,
							name:'CFG_GOODSSN_LENGTH',
							value:info.CFG_GOODSSN_LENGTH,
							xtype:'numberfield',
							allowNegative:false,
							allowDecimals:false,
						}
					]
				},{
					xtype: 'fieldset',
					layout:'column',
					width:500,
					padding:8,
					labelWidth:85,
					title: '组合SKU分拆',
					items: [
						{
							columnWidth:.99,
							boxLabel:'是否打开',
							labelWidth:70,
							width:150,
							xtype:'checkbox',
							name:'CFG_GOODS_COMBSPLIT',
							checked:info.CFG_GOODS_COMBSPLIT?true:false,
							value:info.CFG_GOODS_COMBSPLIT
						},{
							columnWidth:.25,
							labelWidth:70,
							width:150,
							xtype:'displayfield',
							value:'组合连接符号:'
						},{
							columnWidth:.2,
							xtype: 'textfield',
							name:'CFG_GOODS_CONCAT',
							labelWidth:70,
							width:150,
							value:info.CFG_GOODS_CONCAT
						},{
							columnWidth:.25,
							xtype:'displayfield',
							labelWidth:70,
							width:150,
							value:'数量连接符号:'
						},{
							columnWidth:.2,
							xtype: 'textfield',
							name:'CFG_GOODS_QTYSIGN',
							labelWidth:70,
							width:150,
							value:info.CFG_GOODS_QTYSIGN
						}
					]
				},{
					fieldLabel: '持续采购产品状态',
					name:'CFG_GOODS_STATUS',
					value:info.CFG_GOODS_STATUS
				},{
					fieldLabel: '采购日均销量周期',
					name:'CFG_SALES_CIRCLE',
					value:info.CFG_SALES_CIRCLE,
					xtype:'numberfield',
					allowNegative:false,
					allowDecimals:false
				},{
					fieldLabel: '采购排除批发',
					name:'CFG_WHOLE_SALE',
					value:info.CFG_WHOLE_SALE,
					xtype:'numberfield',
					allowNegative:false,
					allowDecimals:false
				},{
					fieldLabel: '业务提成代码长度',
					name:'CFG_GOODSSN_PREFIX',
					value:info.CFG_GOODSSN_PREFIX,
					xtype:'numberfield',
					allowNegative:false,
					allowDecimals:false,
				}]
            },{
				id:'tab3',
                title: '报关信息',
				padding:5,
                defaultType: 'textfield',
                items: [{
					fieldLabel: '报关英文简称',
					name:'CFG_DEC_NAME',
					value:info.CFG_DEC_NAME
				},{
					fieldLabel: '报关中文简称',
					name:'CFG_DEC_NAME_CN',
					value:info.CFG_DEC_NAME_CN
				},{
					fieldLabel: '默认申报价值',
					name:'CFG_DECLARED_VALUE',
					value:info.CFG_DECLARED_VALUE,
					allowNegative:false,
					allowDecimals:false
				},{
					fieldLabel: '申报重量(kg)',
					name:'CFG_DECLARED_WEIGHT',
					value:info.CFG_DECLARED_WEIGHT,
					allowNegative:false,
					allowDecimals:false
				},{
					fieldLabel: '订单申报上限',
					name:'CFG_DECLARED_MAX',
					value:info.CFG_DECLARED_MAX,
					allowNegative:false,
					allowDecimals:false
				},{
                    boxLabel: '申报订单全部默认一个产品',
                    xtype:'checkbox',
                    name:'CFG_DECLARED_ORDER_QTY_1',
                    checked:info.CFG_DECLARED_ORDER_QTY_1?true:false,
                    value:info.CFG_DECLARED_ORDER_QTY_1
                },{
					boxLabel: '优先使用导入的产品资料作为报关资料',
					xtype:'checkbox',
					name:'CFG_IMPORT_CUSTOMS',
					checked:info.CFG_IMPORT_CUSTOMS?true:false,
					value:info.CFG_IMPORT_CUSTOMS
				}]
			},{
				id:'tab4',
                title: '物流接口信息',
				//disabled:true,
				padding:5,
                items: [
				{
				layout:'column',
				xtype:'panel',
				style:'margin-top:20px;',
                items:[{
					columnWidth:.3,
					layout:'form',
					xtype:'fieldset',
					title:'三态接口',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
						fieldLabel: 'UserId',
						name:'CFG_SFC_ID',
						value:info.CFG_SFC_ID
					},{
						fieldLabel: 'APIkey',
						name:'CFG_SFC_KEY',
						value:info.CFG_SFC_KEY
					},{
						fieldLabel: 'TOKEN',
						name:'CFG_SFC_TOKEN',
						value:info.CFG_SFC_TOKEN
					},{
					fieldLabel: '启用三态接口',
					xtype:'checkbox',
					name:'CFG_ENABLE_SFC',
					checked:info.CFG_ENABLE_SFC?true:false,
					value:info.CFG_ENABLE_SFC
					}]},{
					columnWidth:.3,
					layout:'form',
					xtype:'fieldset',
					title:'线下EUB接口',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
						fieldLabel: '校验码',
						name:'CFG_EUB_TOKEN',
						value:info.CFG_EUB_TOKEN
					},{
					fieldLabel: '启用线下EUB接口',
					xtype:'checkbox',
					name:'CFG_ENABLE_EUB',
					checked:info.CFG_ENABLE_EUB?true:false,
					value:info.CFG_ENABLE_EUB
					},{
                        boxLabel: '获取A4标签',
                        xtype:'checkbox',
                        name:'CFG_EUB1_A4LABEL',
                        checked:info.CFG_EUB1_A4LABEL?true:false,
                        value:info.CFG_EUB1_A4LABEL
                    }]},{
					columnWidth:.3,
					layout:'form',
					xtype:'fieldset',
					title:'出口易接口',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
						fieldLabel: 'APIkey',
						name:'CFG_CK1_KEY',
						value:info.CFG_CK1_KEY
					},{
						fieldLabel: 'TOKEN',
						name:'CFG_CK1_TOKEN',
						value:info.CFG_CK1_TOKEN
					},{
					fieldLabel: '启用出口易接口',
					xtype:'checkbox',
					name:'CFG_ENABLE_CK1',
					checked:info.CFG_ENABLE_CK1?true:false,
					value:info.CFG_ENABLE_CK1
					},{
                    boxLabel: '获取A4标签',
                    xtype:'checkbox',
                    name:'CFG_CK1_A4LABEL',
                    checked:info.CFG_CK1_A4LABEL?true:false,
                    value:info.CFG_CK1_A4LABEL
                },{
                    boxLabel: '获取报关单',
                    xtype:'checkbox',
                    name:'CFG_CK1_LABELDEC',
                    checked:info.CFG_CK1_LABELDEC?true:false,
                    value:info.CFG_CK1_LABELDEC
                }]}]
				},{
                layout:'column',
				xtype:'panel',
				style:'margin-top:20px;',
                items:[{
					columnWidth:.3,
					layout:'form',
					xtype:'fieldset',
					title:'4PX接口',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
                    fieldLabel: '4PXtoken',
                    name:'CFG_4PX_TOKEN',
                    value:info.CFG_4PX_TOKEN
                },{
					fieldLabel: '4PXtoken2',
					name:'CFG_4PX_TOKEN2',
					value:info.CFG_4PX_TOKEN2
				},{
					fieldLabel: '小包要求退回',
					xtype:'checkbox',
					name:'CFG_RETURN_4PX',
					checked:info.CFG_RETURN_4PX?true:false,
					value:info.CFG_RETURN_4PX
				},{
					fieldLabel: '启用4PX接口',
					xtype:'checkbox',
					name:'CFG_ENABLE_4PX',
					checked:info.CFG_ENABLE_4PX?true:false,
					value:info.CFG_ENABLE_4PX
				}]},{
					columnWidth:.3,
					layout:'form',
					xtype:'fieldset',
					title:'互联易接口',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
                    fieldLabel: 'ICEtoken',
                    name:'CFG_TOKEN_ICE',
                    value:info.CFG_TOKEN_ICE
                },{
					fieldLabel: 'ICEtoken2',
					name:'CFG_TOKEN_ICE2',
					value:info.CFG_TOKEN_ICE2
				},{
					fieldLabel: '启用互联易接口',
					xtype:'checkbox',
					name:'CFG_ENABLE_ICE',
					checked:info.CFG_ENABLE_ICE?true:false,
					value:info.CFG_ENABLE_ICE
				}]},{
                    columnWidth:.3,
                    layout:'form',
                    xtype:'fieldset',
                    title:'俄速通接口',
                    style:'margin:10px 20px',
                    defaultType: 'textfield',
                    width:300,
                    autoHeight:true,
                    items:[{
                    fieldLabel: 'token',
                    name:'CFG_EST_TOKEN',
                    value:info.CFG_TOKEN_EST
                },{
                    fieldLabel: '启用俄速通接口',
                    xtype:'checkbox',
                    name:'CFG_ENABLE_EST',
                    checked:info.CFG_ENABLE_EST?true:false,
                    value:info.CFG_ENABLE_EST
                }]}]
				},{
                layout:'column',
                xtype:'panel',
                style:'margin-top:20px;',
                items:[{
                    columnWidth:.3,
                    layout:'form',
                    xtype:'fieldset',
                    title:'中环运接口',
                    style:'margin:10px 20px',
                    defaultType: 'textfield',
                    width:300,
                    autoHeight:true,
                    items:[{
                    fieldLabel: 'token',
                    name:'CFG_TOKEN_ZHY',
                    value:info.CFG_TOKEN_ZHY
                },{
                    fieldLabel: '启用中环运接口',
                    xtype:'checkbox',
                    name:'CFG_ENABLE_ZHY',
                    checked:info.CFG_ENABLE_ZHY?true:false,
                    value:info.CFG_ENABLE_ZHY
                },{
                    boxLabel: '获取A4标签',
                    xtype:'checkbox',
                    name:'CFG_ZHY_A4LABEL',
                    checked:info.CFG_ZHY_A4LABEL?true:false,
                    value:info.CFG_ZHY_A4LABEL
                },{
                    boxLabel: '获取报关单',
                    xtype:'checkbox',
                    name:'CFG_ZHY_LABELDEC',
                    checked:info.CFG_ZHY_LABELDEC?true:false,
                    value:info.CFG_ZHY_LABELDEC
                }]},{
                    columnWidth:.3,
                    layout:'form',
                    xtype:'fieldset',
                    title:'贝邮宝接口',
                    style:'margin:10px 20px',
                    defaultType: 'textfield',
                    width:300,
                    autoHeight:true,
                    items:[{
                    fieldLabel: 'api_key',
                    name:'CFG_PYB_TOKEN',
                    value:info.CFG_PYB_TOKEN
                },{
                    fieldLabel: 'api_key2',
                    name:'CFG_PYB_TOKEN2',
                    value:info.CFG_PYB_TOKEN2
                },{
                    fieldLabel: '启用贝邮宝接口',
                    xtype:'checkbox',
                    name:'CFG_ENABLE_PYB',
                    checked:info.CFG_ENABLE_PYB?true:false,
                    value:info.CFG_ENABLE_PYB
                }]},{
                    columnWidth:.3,
                    layout:'form',
                    xtype:'fieldset',
                    title:'燕文接口',
                    style:'margin:10px 20px',
                    defaultType: 'textfield',
                    width:300,
                    autoHeight:true,
                    items:[{
                    fieldLabel: 'UserID',
                    name:'CFG_YW_KEY',
                    value:info.CFG_YW_KEY
                },{
                    fieldLabel: 'UserID2',
                    name:'CFG_YW_KEY2',
                    value:info.CFG_YW_KEY2
                },{
                    fieldLabel: 'api_key',
                    name:'CFG_YW_TOKEN',
                    value:info.CFG_YW_TOKEN
                },{
                    fieldLabel: 'api_key2',
                    name:'CFG_YW_TOKEN2',
                    value:info.CFG_YW_TOKEN2
                },{
                    fieldLabel: '启用燕文接口',
                    xtype:'checkbox',
                    name:'CFG_ENABLE_YW',
                    checked:info.CFG_ENABLE_YW?true:false,
                    value:info.CFG_ENABLE_YW
                }]}]
                },{
                layout:'column',
                xtype:'panel',
                style:'margin-top:20px;',
                items:[{
                    columnWidth:.3,
                    layout:'form',
                    xtype:'fieldset',
                    title:'顺友接口',
                    style:'margin:10px 20px',
                    defaultType: 'textfield',
                    width:300,
                    autoHeight:true,
                    items:[{
                    fieldLabel: 'token',
                    name:'CFG_TOKEN_SY',
                    value:info.CFG_TOKEN_SY
                },{
                    fieldLabel: '启用顺友接口',
                    xtype:'checkbox',
                    name:'CFG_ENABLE_SY',
                    checked:info.CFG_ENABLE_SY?true:false,
                    value:info.CFG_ENABLE_SY
                }]}]
                },
				{
                layout:'column',
				xtype:'panel',
				style:'margin-top:20px;',
                items:[
					{
					columnWidth:.33,
					layout:'form',
					xtype:'fieldset',
					title:'揽件信息(中文)',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
					xtype:'displayfield',
					value:'<font color=red>揽件地址中省市区必须填写页面下方对应的编码</font>'
					},{
					fieldLabel: 'Email',
					name:'EUB_Email',
					vtype:'email',
					value:info.EUB_Email
				},{
					fieldLabel: '公司名',
					name:'EUB_Company',
					value:info.EUB_Company
				},{
					fieldLabel: '国家',
					name:'EUB_Country',
					value:info.EUB_Country
				},{
					fieldLabel: '省份',
					name:'EUB_Province',
					xtype:'numberfield',
					value:info.EUB_Province
				},{
					fieldLabel: '城市',
					name:'EUB_City',
					xtype:'numberfield',
					value:info.EUB_City
				},{
					fieldLabel: '区',
					name:'EUB_District',
					xtype:'numberfield',
					value:info.EUB_District
				},{
					fieldLabel: '街',
					name:'EUB_Street',
					value:info.EUB_Street
				},{
					fieldLabel: '邮编',
					name:'EUB_Postcode',
					value:info.EUB_Postcode
				},{
					fieldLabel: '联系人',
					name:'EUB_Contact',
					value:info.EUB_Contact
				},{
					fieldLabel: '手机',
					name:'EUB_Mobile',
					value:info.EUB_Mobile
				},{
					fieldLabel: '电话',
					name:'EUB_Phone',
					value:info.EUB_Phone
				}]
					},{
					columnWidth:.33,
					layout:'form',
					xtype:'fieldset',
					title:'寄件信息(英文)',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
					fieldLabel: 'Email',
					name:'EUB_EN_Email',
					vtype:'email',
					value:info.EUB_EN_Email
				},{
					fieldLabel: 'Company',
					name:'EUB_EN_Company',
					value:info.EUB_EN_Company
				},{
					fieldLabel: 'Country',
					name:'EUB_EN_Country',
					readOnly:true,
					value:'CHINA'
				},{
					fieldLabel: 'Province',
					name:'EUB_EN_Province',
					value:info.EUB_EN_Province
				},{
					fieldLabel: 'City',
					name:'EUB_EN_City',
					value:info.EUB_EN_City
				},{
					fieldLabel: 'District',
					name:'EUB_EN_District',
					value:info.EUB_EN_District
				},{
					fieldLabel: 'Street',
					name:'EUB_EN_Street',
					value:info.EUB_EN_Street
				},{
					fieldLabel: 'Postcode',
					name:'EUB_EN_Postcode',
					value:info.EUB_EN_Postcode
				},{
					fieldLabel: 'Contact',
					name:'EUB_EN_Contact',
					value:info.EUB_EN_Contact
				},{
					fieldLabel: 'Mobile',
					name:'EUB_EN_Mobile',
					value:info.EUB_EN_Mobile
				},{
					fieldLabel: 'Phone',
					name:'EUB_EN_Phone',
					value:info.EUB_EN_Phone
				}]
					},{
					columnWidth:.33,
					layout:'form',
					xtype:'fieldset',
					title:'退件信息(要求编码格式且与寄件地址一直必须中文)',
					style:'margin:10px 20px',
					defaultType: 'textfield',
					width:300,
					autoHeight:true,
					items:[{
					fieldLabel: 'Email',
					name:'EUB_CN_Email',
					vtype:'email',
					value:info.EUB_CN_Email
				},{
					fieldLabel: 'Company',
					name:'EUB_CN_Company',
					value:info.EUB_CN_Company
				},{
					fieldLabel: 'Country',
					name:'EUB_CN_Country',
					readOnly:true,
					value:'中国'
				},{
					fieldLabel: 'Province',
					name:'EUB_CN_Province',
					value:info.EUB_CN_Province
				},{
					fieldLabel: 'City',
					name:'EUB_CN_City',
					value:info.EUB_CN_City
				},{
					fieldLabel: 'District',
					name:'EUB_CN_District',
					value:info.EUB_CN_District
				},{
					fieldLabel: 'Street',
					name:'EUB_CN_Street',
					value:info.EUB_CN_Street
				},{
					fieldLabel: 'Postcode',
					name:'EUB_CN_Postcode',
					value:info.EUB_CN_Postcode
				},{
					fieldLabel: 'Contact',
					name:'EUB_CN_Contact',
					value:info.EUB_CN_Contact
				},{
					fieldLabel: 'Mobile',
					name:'EUB_CN_Mobile',
					value:info.EUB_CN_Mobile
				},{
					fieldLabel: 'Phone',
					name:'EUB_CN_Phone',
					value:info.EUB_CN_Phone
				}]
					}
			]}]
			},{
				id:'tab6',
                title: '订单处理流程',
				padding:5,
                defaultType: 'textfield',
                items: [{
					fieldLabel: '待客服审核',
					name:'CFG_ORDER_1',
					width:550,
					value:info.CFG_ORDER_1
				},{
					fieldLabel: '待库管审核',
					name:'CFG_ORDER_2',
					width:550,
					value:info.CFG_ORDER_2
				},{
					fieldLabel: '待处理订单',
					name:'CFG_ORDER_3',
					width:550,
					value:info.CFG_ORDER_3
				},{
					fieldLabel: '订单配货校对',
					name:'CFG_ORDER_4',
					width:550,
					value:info.CFG_ORDER_4
				},{
					fieldLabel: '出库开单',
					name:'CFG_ORDER_5',
					width:550,
					value:info.CFG_ORDER_5
				},{
					fieldLabel: '标记发货',
					name:'CFG_ORDER_6',
					width:550,
					value:info.CFG_ORDER_6
				},{
					fieldLabel: '待拣货订单',
					name:'CFG_ORDER_8',
					width:550,
					value:info.CFG_ORDER_8
				},{
					fieldLabel: '缺货订单',
					name:'CFG_ORDER_9',
					width:550,
					value:info.CFG_ORDER_9
				},{
					fieldLabel: '退款订单',
					name:'CFG_ORDER_10',
					width:550,
					value:info.CFG_ORDER_10
				},{
					fieldLabel: '到付收款订单',
					name:'CFG_ORDER_11',
					width:550,
					value:info.CFG_ORDER_11
				},{
					fieldLabel: '导入订单状态',
					name:'CFG_ORDER_12',
					width:550,
					value:info.CFG_ORDER_12
				},{
					fieldLabel: '锁定库存步骤',
					name:'CFG_ORDER_15',
					width:550,
					value:info.CFG_ORDER_15
				},{
					fieldLabel: '快递规则步骤',
					name:'CFG_ORDER_16',
					width:550,
					value:info.CFG_ORDER_16
				},{
					fieldLabel: '已发货订单',
					name:'CFG_ORDER_17',
					width:550,
					value:info.CFG_ORDER_17
				},{
                    fieldLabel: '未付款订单',
                    name:'CFG_ORDER_18',
                    width:550,
                    value:info.CFG_ORDER_18
                },{
                    fieldLabel: '待打印订单',
                    name:'CFG_ORDER_19',
                    width:550,
                    value:info.CFG_ORDER_19
                }]
			},{
			    id:'tab7',
                title: '速卖通设置',
				padding:5,
				
				defaultType: 'textfield',
				autoScroll:true,
                items:[
					   {
                fieldLabel: 'appkey',
				hidden:true,
                value: info.CFG_ALI_APPKEY,
                name: 'CFG_ALI_APPKEY'
				},{
                fieldLabel: 'appSecret',
				hidden:true,
                value: info.CFG_ALI_APPSECRET,
                name: 'CFG_ALI_APPSECRET'
				},{
                    fieldLabel: '加载订单分拆产品Lot数量',
                    xtype:'checkbox',           
                    name: 'CFG_ALI_SPLITGOODS', 
                    checked:info.CFG_ALI_SPLITGOODS?true:false,
                    value:info.CFG_ALI_SPLITGOODS
                    
                                              
                },{
                    fieldLabel: '使用关键字作为商品报关名',
                    xtype:'checkbox',           
                    name: 'CFG_ALI_KEYWORDTODEC', 
                    checked:info.CFG_ALI_KEYWORDTODEC?true:false,
                    value:info.CFG_ALI_KEYWORDTODEC
                    
                                              
                }]
            }
			]
		});		
	},


	creatItems:function(){
		this.items = [this.tab];
	},

	creatButtons:function(){
		this.buttons = [{
				text: '保存',
				type: 'submit', 
				handler:this.formsubmit.bind(this)
			},{
					text: '取消',
					handler:this.formreset.bind(this)
			}];		
	},

	formsubmit:function(){
		if(this.getForm().isValid()){
				this.getForm().submit({
					url:this.saveURL,
					waitMsg: '正在更新系统配置',
					params:'',
					method:'post',
					success:function(form,action){
							Ext.example.msg('操作','保存成功!');
							 },
					failure:function(form,action){
							Ext.example.msg('操作','服务器出现错误请稍后再试！');
					}
				});
		}else{
			Ext.example.msg('ERROR','请正确完成表单内容');
			}
	},

	formreset:function(){//表单重置
		this.form.reset();
	}
});