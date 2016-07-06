<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/system/system.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var info = eval(<!--{$info}-->);
	Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
	var systemForm = new Ext.ux.systemForm({
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 145,
		info:info,
		saveURL:'index.php?model=system&action=save',
        autoWidth: true,
		autoHeight:true,
		renderTo:'fordiv'
	});
	loadend();
});
</script>
<div id='fordiv'></div>
<!--{include file="footer.tpl"}-->
