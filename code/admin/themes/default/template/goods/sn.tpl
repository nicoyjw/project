<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/goods/sn.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

	var SnGrid = Ext.create('Ext.ux.SnGrid',{
		id:'BrandGrid',
        title: '产品序列号列表',
		headers:['序号','sku','序列号','订单号','入库单号','出库单号'],
        fields: ['id','sku','sn','order_sn','in_sn','out_sn'],
		autowidth:true,
		frame:true,
		saveURL:'index.php?model=goods&action=snupdate',
		delURL:'index.php?model=goods&action=sndel',
		listURL:'index.php?model=goods&action=snList',
		formitems:[{
				xtype:'hidden',
                name: 'id'
				},{
				name:'sku',
				fieldLabel:'产品编码',
				allowBlank:false,
				width:250,
				blankText:'此项必填'
				},{
				name:'sn',
				fieldLabel:'序列号',
				width:250,
				allowBlank:false,
				blankText:'此项必填'
				},{
				name:'order_sn',
				width:250,
				fieldLabel:'订单号'
				},{
				name:'in_sn',
				width:250,
				fieldLabel:'入库单'
				},{
				name:'out_sn',
				width:250,
				fieldLabel:'出库库单'
				}],
		windowTitle:'编辑外部SKU',
		windowWidth:300,
		windowHeight:220,
        renderTo: document.body
	})
	SnGrid.getStore().load({
			params:{start:0,limit:SnGrid.pagesize}
			});	
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
