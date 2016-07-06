<!--{include file="header.tpl"}-->
<style type="text/css">

.x-statusbar .x-status-busy {
    padding-left: 25px !important;
    background: transparent no-repeat 3px 0;
	background-image: url(themes/default/images/accept.png);
}
.x-status-valid{ background-image: url(themes/default/images/accept.png);}
</style>
<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript" src="js/goods/ebay_endlisting.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var viewport = Ext.create('Ext.ux.GoodsView',{
        fields: ['rec_id','GalleryURL','ItemID', 'Title','SKU','StartPrice','Quantity','ViewItemURL','ListingType','account_id'],
		listURL:'index.php?model=goods&action=GetActivelisting&status=1',
		windowTitle:'高级搜索',
		windowWidth:320,
		windowHeight:300,
		pagesize:25
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
