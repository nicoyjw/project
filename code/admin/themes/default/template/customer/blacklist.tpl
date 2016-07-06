<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/customer/blacklist.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	/*var reason = <!--{$reason}-->;
	
	var arr = object_Array(reason);
	
	function showreason(val){
		return arr[val];
	}
	var reasonarr = object_Array(reason);*/
	var RmaGrid = new Ext.ux.RmaGrid({
		title: '域名黑名单_列表',
		headers:['序号','处理时间','域名'],
		fields: ['blacklist_id','addtime','domain_name','remark'],
		frame:true,
		autoWidth:true,
		listURL:'index.php?model=customer&action=blacklistlist',
		windowTitle:'编辑换货单据信息',
		windowWidth:500,
		windowHeight:320,
		renderTo: document.body
	});
	RmaGrid.getStore().load({
		params:{start:0,limit:RmaGrid.pagesize}
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->