<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/ali/userauth.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
     var AliGrid = new Ext.ux.AliGrid({
		id:'TbGrid',
        title: '速卖通账号列表',
		headers:['序号','apikey','apiSecret','速卖通账号','速卖通密码'],
        fields: ['id','appkey','appSecret','username','password'],
		width:600,
		style: 'margin:0 0 15 15',
		renderTo: document.body,
		frame:true,
		saveURL:'index.php?model=aliapi&action=Update',
		delURL:'index.php?model=aliapi&action=delete',
		listURL:'index.php?model=aliapi&action=List',
		windowTitle:'Ali Account',
		windowWidth:350,
		windowHeight:300
    });
	
	var detailpanel = new Ext.Panel({
		width:600,
		style: 'margin:15 15',
		frame:true,
		title:'速卖通授权说明:',
		html:'<p>授权过程中,会跳转到速卖api通授权页面,需要用户手动输入速卖通账号和密码。</p>',
		renderTo: document.body
	});
	AliGrid.getStore().load({
			params:{start:0,limit:AliGrid.pagesize}
			});
	loadend();

});
</script>
<!--{include file="footer.tpl"}-->
