<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/system/privilege.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
    var EasyGrid = Ext.create('Ext.ux.PrivilegeGrid',{
        title: '权限列表',
		id:'ActionGrid',
		headers:['序号','action_code','action_name','描述','类别','类别id'],
        fields: ['id','action_code', 'action_name', 'action_des','action_type_name', 'action_type'],
		pagesize:15,
        renderTo: 'easyGrid'
    });
	EasyGrid.getStore().load({
			params:{start:0,limit:15}
			});
	loadend();
});
    </script>
    <div id="easyGrid" style="margin:20px;"></div>
<!--{include file="footer.tpl"}-->
