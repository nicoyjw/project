<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><!--{$cfg.page.title}--></title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/ext-all.css"/>
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/xtheme-gray.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javascript" src="common/lib/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="common/lib/ext/ext-all.js"></script>
<!--<script type="text/javascript" src="common/lib/ext/ext-all-debug.js"></script>-->
<script type="text/javascript" src="common/js/common1.js"></script>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '<!--{$smarty.const.CFG_PATH_IMAGES}-->s.gif';
</script>
</head>
<body>
<script type="text/javascript" src="js/normalgrid-ext.js"></script>
<script type="text/javascript" src="js/purchase/supplier-ext.js"></script>
<script type="text/javascript">
//供应商列表
Ext.onReady(function(){
	Ext.QuickTips.init();
    var SupplierGrid = new Ext.ux.SupplierGrid({
        title: '供应商列表',
		headers:['序号','代码','公司名','联系人','地址','电话','邮编','Email','Skype','QQ','备注','采购周期','管理员'],
        fields: ['id','sn','name', 'contact','address','tel','zip','Email','skype','qq','comment','period','user_id'],
		formitems:[{
				xtype:'hidden',
                name: 'id'
				},{
				name:'sn',
				fieldLabel:'代码',
				width:180
				},{
				name:'name',
				fieldLabel:'公司名',
				width:180,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'contact',
				fieldLabel:'联系人',
				width:120,
				allowBlank:false
				},{
				name:'address',
				fieldLabel:'地址',
				width:280
				},{
				name:'tel',
				fieldLabel:'电话',
				width:120,
				allowBlank:false
				},{
				name:'zip',
				fieldLabel:'邮编',
				width:120
				},{
				name:'Email',
				fieldLabel:'Email',
				vtype:'email',
				width:180
				},{
				name:'skype',
				fieldLabel:'Skype',
				width:180
				},{
				name:'qq',
				fieldLabel:'QQ',
				width:120
				},{
                name:'period',
                width:120,
                fieldLabel:'采购周期'
                },{
                    xtype:'combo',
                    store: new Ext.data.Store({
                        proxy : new Ext.data.HttpProxy({url:'index.php?model=User&action=UserList'}),
                        reader: new Ext.data.JsonReader({
                                root: 'topics',
                                totalProperty: 'totalCount',
                                id: 'user_id'
                                },['user_id','user_name'])
                    }),
                    valueField :"user_id",
                    displayField: "user_name",
                    mode: 'remote',
                    width:100,
                    forceSelection: true,
                    triggerAction: 'all',
                    hiddenName:'user_id',
                    fieldLabel: '管理员',
                    allowBlank:false,
                    pageSize:30,
                    minListWidth:220, 
                    name:'user_id',
                    listeners:{
                        load: function(v){
                            alert(v);
                        }
                    }
                },{
				xtype:'textarea',
				name:'comment',
				width:180,
				fieldLabel:'备注'
				}],
		autoWidht:true,
		frame:true,
		saveURL:'index.php?model=supplier&action=update',
		delURL:'index.php?model=supplier&action=delete',
		listURL:'index.php?model=supplier&action=list',
		windowTitle:'供应商信息',
		windowWidth:420,
		windowHeight:420,
        renderTo: document.body
    });
	//供应商产品管理
    var SupplierGoodsGrid = new Ext.ux.SupplierGoodsGrid({
		id:'SupplierGoodsGrid',
        title: '供应商产品',
		headers:['序号','产品编码','产品名称','供应商编码','供应商产品名','供应商价格','采购链接','备注'],
        fields: ['rec_id','goods_sn', 'supplier_goods_sn','supplier_goods_name','supplier_goods_price','url','supplier_goods_remark','goods_id','supplier_id'],
		frame:true,
		autoExpandColumn:'supplier_goods_name',
		saveURL:'index.php?model=supplier&action=goodsupdate',
		delURL:'index.php?model=supplier&action=goodsdelete',
		clearURL:'index.php?model=supplier&action=goodsclear',
		listURL:'index.php?model=supplier&action=goodslist',
		goodsURL:'index.php?model=goods&action=getgoodslist',
		catTreeURL:'index.php?model=goods&action=getcattree',
        renderTo: document.body
    });
	SupplierGrid.getStore().load({
			params:{start:0,limit:SupplierGrid.pagesize}
			});	
});
</script>

