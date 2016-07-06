<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/reportforms/comlgrid.js"></script>
<script type="text/javascript" src="js/reportforms/goodstypesale.js"></script>
<script type="text/javascript">
var goodscatalog= <!--{$goodscatalog}-->;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';	
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '商品分类销售',
		headers:['日期','销售量','销售额'],
		fields: ['addtime','goods_sale','goods_price'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=reportforms&action=getgoodstypesale',
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->