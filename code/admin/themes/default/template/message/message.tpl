<!--{include file="header.tpl"}-->
<style>
.mail_item{ font-size:13px; font-weight:600; line-height:22px}
.mail_item2{ font-size:13px; color:#999999;font-weight:600;line-height:22px}

</style>
<script type="text/javascript" src="js/message/emailviewpoint.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
Ext.QuickTips.init();
	var viewport = new Ext.ux.MailView({
		headers:['发件人','主题','时间'],
		fields: ['email_msg_id','fromName','subject','date','uid','is_reply'],
		listURL:'index.php?model=message&action=list&box=inbox',
		windowWidth:320,
		windowHeight:330,
		pagesize:15
	});

	loadend();
});
</script>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->