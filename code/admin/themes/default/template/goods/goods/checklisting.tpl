<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/goods/checklisting.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = object_Array([<!--{$account}-->]);
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var ListingGrid = new Ext.ux.ListingGrid({
		region:'center',
		loadMask: true,
		height:600,
		autoScroll: true,
		accountarr:[<!--{$account}-->,['0','所有账号']],
		el:'center',
        title: 'Listing产品列表',
        fields: ['id','GalleryURL','ItemID', 'Title','SKU','buyitnowprice','startprice','Quantity','ListingDuration','starttime','endtime','bidcount','ViewItemURL','ListingType','account_id'],
		frame:true,
		listURL:'index.php?model=goods&action=listinglist',
        renderTo: document.body
	});
	var viewport = new Ext.Viewport({
        layout:'fit',
        items:[
			ListingGrid
		]}
	);
    loadend();
});
</script>
<div id="center"></div>
<!--{include file="footer.tpl"}-->
