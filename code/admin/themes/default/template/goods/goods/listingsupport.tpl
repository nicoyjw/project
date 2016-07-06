<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/EnditemGrid.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = [<!--{$account}-->];
	account.push(['0','所有账户']);
	var EnditemGrid = new Ext.ux.EnditemGrid({
		id:'BrandGrid',
        title: '待下架产品列表',
        fields: ['rec_id','GalleryURL','ItemID', 'Title','SKU','StartPrice','Quantity','ViewItemURL','ListingType','account_id','is_need'],
		autoWidth:true,
		frame:true,
		accountdata:account,
		saveURL:'index.php?model=goods&action=updateListing',
		editURL:'index.php?model=goods&action=editListing',
		listURL:'index.php?model=goods&action=listingsupportList',
        renderTo: document.body
	})
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
