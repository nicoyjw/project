<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	var ds = Ext.create('Ext.data.JsonStore', {
			fields:['id','news_title','create_user_id','create_time','modify_user_id','modify_time','is_read'],
			pageSize: 10,
			autoLoad:true,
			proxy: {
				type: 'ajax',
				url:'index.php?model=news&action=list',
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
		 {header:'文章ID',width:50,align:'center',dataIndex:'id'},
		 {header:'是否已读',align:'center',dataIndex:'is_read',renderer:function(v){ return (v==1)?'<img src=themes/default/images/flag_green.gif>':'<img src=themes/default/images/flag_red.gif>';}},
		 {header:'标题', dataIndex:'news_title'},
		 {header:'添加人',align:'center',dataIndex:'create_user_id'},
		 {header:'添加时间',align:'center',dataIndex:'create_time'},
		 {header:'修改人',align:'center',dataIndex:'modify_user_id'},
		 {header:'修改时间',align:'center',dataIndex:'modify_time'}
		];

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
	var top = Ext.create('Ext.FormPanel',{
        buttonAlign:'right',
        items: [{
	            layout:'column',
	            items:[{
	                columnWidth:.3,
					layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '标题',
	                    id: 'news_title',
						name: 'news_title',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.3,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '创建人',
	                    name: 'cu',
						id: 'cu',
	                    anchor:'90%'
	                }]
	            },{
	                columnWidth:.3,
	                layout: 'form',
	                items: [{
	                    xtype:'textfield',
	                    fieldLabel: '修改人',
	                    name: 'mu',
						id: 'mu',
	                    anchor:'90%'
	                }]
	            },{
                    columnWidth:.3,
                    layout:'form',
                    items:[{
                        xtype:'datefield',
                        fieldLabel:'开始时间',
                        format:'Y-m-d',
						name: 'startDate',
						id: 'startDate',
                        anchor:'90%',
						listeners: {   
        					'select' : function() {
            					var start = Ext.getCmp('startDate').getValue();   
             					Ext.getCmp('endDate').setMinValue(start);   
           				 		var endDate = Ext.getCmp('endDate').getValue();   
								if(start > endDate){   
								 	Ext.getCmp('endDate').setValue(start);   
								} 
        					}
						}
                    }]
                },{
                    columnWidth:.3,
                    layout:'form',
                    items:[{
                        xtype:'datefield',
                        fieldLabel:'结束时间',
                        format:'Y-m-d',
						name: 'endDate',
						id: 'endDate',
                        anchor:'90%'
                    }]
                }]},
        ],
        buttons: [{
            text: '搜索',
			handler:function(){
				ds.load({params:{start:0, limit:20,
					news_title:Ext.get('news_title').dom.value,
					cu:Ext.get('cu').dom.value,
					mu:Ext.get('mu').dom.value,
					startDate:Ext.get('startDate').dom.value,
					endDate:Ext.get('endDate').dom.value
				}})
        	}
		},{
        	text: '重置',
			handler:function(){top.form.reset();}
        }]
    });
	
	var grid = Ext.create('Ext.grid.GridPanel',{
				border:false,
				renderTo:'center',
				store: ds,
				columns: colModel,
				autoScroll: true,
				//tbar:top,
				bbar: new Ext.PagingToolbar({
					pageSize: 20,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		})
            });
	grid.on("rowdblclick", function(g, rowindex, e) {
        var id = getId(grid);
		parent.openWindow('30001000', '查看新闻', 'index.php?model=news&action=show&id='+id,500,500);
    }); 
	
	var viewport =Ext.create('Ext.Viewport',{
        layout:'border',
        items:[{
			  border:false,
			  region:'north',
			  contentEl:'north-div',
			  tbar:tb,
			  height:26
			},grid
		]}
	);
	
	ds.load({params:{start:0, limit:20}});
	function addItem(action) {
		var id = 0;
		if (action=='edit') {
			var id = getId(grid);
			if (!id) {
				Ext.Msg.alert('出错啦','你还没有选择要操作的记录！');
				return;
			}
			parent.openWindow('30001001', '编辑新闻', 'index.php?model=news&action=add&id='+id,720,470);
		} else {
			parent.openWindow('300020', '添加新闻', 'index.php?model=news&action=add',720,470);
		}
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
						url: 'index.php?model=news&action=delete&ids='+ids,
						success: function(result){
							ds.reload();
						}
					});
				}
			});

		} else {
			Ext.Msg.alert('出错啦','你还没有选择要操作的记录！');
		}
	}
	//rid.getColumnModel().setHidden(0,true);
	//Ext.getCmp('startDate').setMaxValue(new Date());
	//Ext.getCmp('endDate').setMaxValue(new Date());
	loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>
<!--{include file="footer.tpl"}-->