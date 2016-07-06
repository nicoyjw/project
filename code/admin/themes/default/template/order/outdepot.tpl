<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/order/outdepot.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = [<!--{$allaccount}-->];
	var depot = [<!--{$depot}-->];
	account.push(['0','所有账户']);
    var OutdepotGrid = Ext.create('Ext.ux.OutdepotGrid',{
		id:'OutdepotGrid',
        title: '产品分类列表',
		headers:['id','产品图片','产品编码','产品名称','库存位置','申请出库量','实际库存量'],
        fields: ['id','goods_img','goods_sn','goods_name', 'stock_place','out_qty','goods_qty','is_control'],
		autoWidth:true,
		frame:true,
		accountdata:account,
		depot:depot,
		listURL:'index.php?model=order&action=getoutdepot',
		outdepotURL:'index.php?model=order&action=makeoutdepot',
        renderTo: document.body
    });
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
