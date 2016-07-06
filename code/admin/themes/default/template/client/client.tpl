<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var ds = new Ext.data.Store({
		proxy : new Ext.data.HttpProxy({url:'index.php?model=client&action=list&'}),
        reader: new Ext.data.JsonReader({
			root: 'topics',
            totalProperty: 'totalCount',
            id: 'id'
			},[
			'id','real_name','sex','works','is_bool','create_time'
      	])
    });
    

	var colModel = new Ext.grid.ColumnModel([
		 {header:'ID',width:50,sortable:true,dataIndex:'id'},
		 {id:'title',header:'姓名', width:100,sortable:true,dataIndex:'real_name'},
		 {header:'性别',width:100,sortable:true,dataIndex:'sex'},
		 {header:'职业',width:100,sortable:true,dataIndex:'works'},
		 {header:'是否投资客',width:100,sortable:true,dataIndex:'is_bool'},
		 {header:'创建时间',width:150,sortable:true,dataIndex:'create_time'}
		]);
	var tb = new Ext.Toolbar('north-div');//创建一个工具条
	
	tb.add({
		text: '添加',
        handler: newclient
		},{
        text: '编辑',
        handler: editclient
		},{
        text: '删除',
        handler: delclient
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
	ds.load({params:{start:0, limit:30}});
	function newclient() {
		parent.newTab('200042','添加用户','index.php?model=client&action=add');
	}
	function editclient() {
		var s = grid.getSelectionModel().getSelections();
		if (s.length==0) {
			Ext.example.msg('出错啦','你还没有选择要操作的记录！');
		}
		for (i=0;i<s.length;i++) {
			var id = s[i].id;
			parent.newTab('200042'+id,'编辑用户','index.php?model=client&action=add&client_id='+id);
		}
	}
	function delclient() {
		var ids = getId(grid);
		if (ids) {
			Ext.Msg.confirm('确认', '真的要删除吗？', function(btn){
				if (btn == 'yes'){
					Ext.Ajax.request({
					   url: 'index.php?model=client&action=delete&ids='+ids,
					   success: function(result){
							json = Ext.util.JSON.decode(result.responseText);
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