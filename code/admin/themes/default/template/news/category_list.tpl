<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:'index.php?model=category&action=list'}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: 'id'
			},[
			'id','nc_caption','note','parent_id'
      	])
    });
	var colModel = new Ext.grid.ColumnModel([
		 {header:'ID',width:50,sortable:true,dataIndex:'id'},
		 {header:'分类名', width:100,sortable:true,dataIndex:'nc_caption'},
		 {header:'说明',width:150,sortable:true,dataIndex:'note'},
		 {header:'父类',width:100,sortable:true,dataIndex:'parent_id'}
		]);

	var tb = new Ext.Toolbar('north-div');//创建一个工具条
	tb.add({
		text: '添加',
        handler: addItem
		},{
		text: '编辑',
        handler: editItem
		},{
        text: '删除',
        handler: delItem
	});

	var grid = new Ext.grid.GridPanel({
				border:false,
				region:'center',
				loadMask: true,
				el:'center',
				title:'条目列表',
				store: ds,
				cm: colModel,

				autoScroll: true,
				bbar: new Ext.PagingToolbar({
					pageSize: 30,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		})
            });
	var viewport = new Ext.Viewport({
        layout:'border',
        items:[{
			  border:false,
			  region:'north',
			  contentEl:'north-div',
			  tbar:tb,
			  height:26
			},
			grid
		]}
	);
	ds.load({params:{start:0, limit:30, forumId: 4}});
	function addItem(action) {
		var id = 0;
		if (action=='edit') {
			var id = getId(grid);
			if (!id) {
				Ext.example.msg('出错啦','你还没有选择要操作的记录！');
				return;
			}
		}
		parent.openWindow('40002301','添加分类','index.php?model=category&action=add&id='+id, 300, 200);
	}
	function editItem() {
		addItem('edit');
	}
	function delItem() {
		var ids = getIds(grid);
		if (ids) {
			Ext.Msg.confirm('确认', '真的要删除吗？', function(btn){
				if (btn == 'yes'){
					Ext.Ajax.request({
					   url: 'index.php?model=category&action=delete&ids='+ids,
					   success: function(result){
							ds.reload();
							}
					});
				}
			});

		} else {
			Ext.example.msg('出错啦','你还没有选择要操作的记录！');
		}
	}
	loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->