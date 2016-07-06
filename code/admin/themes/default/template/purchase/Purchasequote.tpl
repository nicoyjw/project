<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/purchase/Purchasequote.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var QuoteGrid = new Ext.ux.QuoteGrid({
		headers:['序号','销售商','联系人','电话','产品','价格','备注','询价人','询价时间'],
        fields: ['id','supplier', 'contact','phone','product','price','remark','operator','add_time'],
		formitems:[{
				xtype:'hidden',
                name: 'id'
				},{
				name:'supplier',
				fieldLabel:'公司名',
				xtype:'textfield',
				labelWidth:65,
				width:350,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'contact',
				fieldLabel:'联系人',
				xtype:'textfield',
				labelWidth:65,
				width:350,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'phone',
				fieldLabel:'电话',
				xtype:'textfield',
				labelWidth:65,
				width:350,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'product',
				fieldLabel:'产品',
				allowBlank:false,
				xtype:'textfield',
				labelWidth:65,
				width:350,
				},{
				name:'price',
				fieldLabel:'价格',
				xtype:'numberfield',
				labelWidth:65,
				width:350,
				},{
				name:'operator',
				fieldLabel:'询价人',
				xtype:'textfield',
				labelWidth:65,
				width:350,
				},{
				name:'remark',
				xtype:'textarea',
				fieldLabel:'备注',
				xtype:'textfield',
				labelWidth:65,
				width:350,
				}],
		frame:true,
		autoWidth:true,
		saveURL:'index.php?model=Purchasequote&action=update',
		delURL:'index.php?model=Purchasequote&action=delete',
		listURL:'index.php?model=Purchasequote&action=list',
		windowTitle:'采购询价信息',
		windowWidth:400,
		windowHeight:320,
        renderTo: document.body
    });
	var SupplierGoodsGrid = new Ext.ux.SupplierGoodsGrid({
		id:'SupplierGoodsGrid',
        title: '供应商产品列表',
		headers:['供应商ID','供应商名称','产品编码','供应商编码','供应商名称','供应商价格','备注'],
        fields: ['supplier_id','supplier_name','goods_sn','supplier_goods_sn','supplier_goods_name','supplier_goods_price','supplier_goods_remark'],
		listURL:'index.php?model=supplier&action=supplierGoods',
        renderTo: document.body
    });
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
