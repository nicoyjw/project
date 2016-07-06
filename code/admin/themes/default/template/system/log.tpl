<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var ds = Ext.create('Ext.data.JsonStore', {
			fields:['id','user_id','log_time','module_name','log_object','log_ip','content'],
			pageSize: 50,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=log&action=list',
				actionMethods:{
					read:'POST'
				},
				reader: {
					type: 'json',
					totalProperty: 'totalCount',
					idProperty:'id',
					root: 'topics'
				}
			}
		})
	var colModel = [
		 {header:'用户ID',sortable:true,dataIndex:'user_id',flex:1},
		 {header:'时间',sortable:true,dataIndex:'log_time',flex:1},
		 {header:'模块名',sortable:true,dataIndex:'module_name',flex:1},
		 {header:'对象ID',sortable:true,dataIndex:'log_object',flex:1},
		 {header:'IP',sortable:true,dataIndex:'log_ip',flex:1},
		 {header:'内容',sortable:true,dataIndex:'content',flex:1}
		];
	//var tb = new Ext.Toolbar('north-div');//创建一个工具条
	
	var grid = Ext.create('Ext.grid.Panel',{
				border:false,
				region:'center',
				loadMask: true,
				title:'条目列表',
				store: ds,
				columns: colModel,
				autoScroll: true,
				bbar: {
					xtype: 'pagingtoolbar',
					plugins: new Ext.ui.plugins.ComboPageSize(),
					pageSize: 50,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		}
            });
	var viewport =  Ext.create('Ext.Viewport',{
        layout:'border',
        items:[
			grid
		]}
	);
	ds.load({params:{start:0, limit:20,ff:6}});

	loadend();
});
</script>
  
  <div id="center"></div>
<!--{include file="footer.tpl"}-->