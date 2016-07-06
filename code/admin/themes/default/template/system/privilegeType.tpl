<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/system/privilegetype.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
    var EasyGrid = new Ext.ux.PrivilegetypeGrid({
        title: '权限列表',
		headers:['序号','分类名'],
        fields: ['id','action_type_name'],
        renderTo: document.body
    });
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
