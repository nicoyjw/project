<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/goods/product_sync.js"></script>
<script type="text/javascript">
var languages = object_Array([<!--{$languages}-->]);
Ext.onReady(function(){
	Ext.QuickTips.init();
    var SyncGrid = new Ext.ux.SyncGrid({
        title: '产品同步列表',
	test_attr : 'test',
	id:'attrgrid',
	headers: true,
        fields: ['product_sync_list_id','product_id','product_sku','website_id','website_name','language_id', 'language_code','product_title','sync_status','sync_status_remark','sync_response_remark','add_data'],
	autoWidht:true,
	frame:true,
	saveURL:'index.php?model=attribute&action=update',
	delURL:'index.php?model=attribute&action=delete',
	listURL:'index.php?model=productsync&action=list',
	pagesize:10,
	windowTitle:'产品属性',
	windowWidth:420,
	autoHeight:true,
        renderTo: document.body
    });
	SyncGrid.getStore().load({
			params:{start:0,limit:SyncGrid.pagesize}
			});	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->