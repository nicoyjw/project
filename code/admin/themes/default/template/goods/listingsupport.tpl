<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/EnditemGrid.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	var account = [<!--{$account}-->];
	account.push(['0','所有账户']);
	var EnditemGrid = Ext.create('Ext.ux.EnditemGrid',{
		id:'BrandGrid',
        fields: ['rec_id','GalleryURL','ItemID', 'Title','SKU','StartPrice','Quantity','ViewItemURL','ListingType','account_id','is_need'],
		autoWidth:true,
		frame:true,
		accountdata:account,
		saveURL:'index.php?model=goods&action=updateListing',
		editURL:'index.php?model=goods&action=editListing',
		listURL:'index.php?model=goods&action=listinglist',
        renderTo: document.body
	});
	var viewport =Ext.create('Ext.Viewport',{
        layout:'fit',
        items:[
			EnditemGrid
		]
		});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
