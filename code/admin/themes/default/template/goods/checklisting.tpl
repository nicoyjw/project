<!--{include file="header.tpl"}-->

<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript" src="js/goods/checklisting.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var account = object_Array([<!--{$account}-->]);
    Ext.QuickTips.init();
    var ListingGrid = Ext.create('Ext.ux.ListingGrid',{
		region:'center',
		loadMask: true,
		height:600,
		autoScroll: false,
		accountarr:[<!--{$account}-->,['0','所有账号']],
		el:'center',
        fields: ['id','GalleryURL','ItemID', 'Title','SKU','BuyItNowPrice','StartPrice','Quantity','ListingDuration','starttime','endtime','BidCount','HitCount','ViewItemURL','QuantitySold','ListingType','account_name','ebay_account'],
		frame:false,
		listURL:'index.php?model=goods&action=GetActivelisting&status=0',
        renderTo: document.body
	});
	var viewport =Ext.create('Ext.Viewport',{
        layout:'fit',
        items:[
			ListingGrid
		]
		});
    loadend();
});
</script>
<div id="center"></div>
<!--{include file="footer.tpl"}-->
