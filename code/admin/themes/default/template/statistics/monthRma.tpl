<!--{include file="header-3.3.tpl"}-->
<script type="text/javascript" src="js/statistics/monthrma.js"></script>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
    var monthrmaGrid = new Ext.ux.monthrmaGrid({
		id:'monthrmaGrid',
        title: 'RMA按月统计列表',
		headers:['月份','问题及问题产品数量'],
        fields: ['month','error'],
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=monthRmaList',
        renderTo: document.body
    });
	monthrmaGrid.on("rowdblclick", function(g, rowindex, e) {
		var month=monthrmaGrid.getSelectionModel().getSelected().get("month");
		Ext.getCmp('rmaGrid').setTitle(month+"产品统计列表");
		Ext.getCmp('rmaGrid').getStore().load({params:{starttime:month}});
    }); 
	var rmaGrid =new Ext.ux.rmaGrid({
		id:'rmaGrid',
        title: '产品统计列表',
		headers:['产品编码','产品名称','问题及问题产品不良率'],
        fields: ['goods_sn','goods_name','error'],
		autoWidth:true,
		loadMask:true,
		frame:true,
		listURL:'index.php?model=statistics&action=rmaList',
        renderTo: document.body
    });
	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->