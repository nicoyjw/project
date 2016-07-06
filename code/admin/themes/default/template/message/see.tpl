<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	loadend();
});
</script>
<div id="center" style="width:100%; height:100%; background-color:#FFFFFF; font-size:14px;"><div align="center" style="font-weight:bold; padding:10px;">标题:<!--{$info.message_title}--></div><br />
<div style="padding:10px;">发送人：<!--{$info.send_user_id}-->时间：<!--{$info.send_time}--><br />
内容：<!--{$info.content}--></div></div>
<!--{include file="footer.tpl"}-->