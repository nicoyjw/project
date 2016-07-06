<!--{include file="header.tpl"}-->
<script type="text/javascript" src="common/lib/ext-4/ux/RowEditor.js"></script>
<link rel="stylesheet" type="text/css" href="common/lib/ext-4/ux/css/RowEditor.css" />
<script type="text/javascript">
Ext.onReady(function(){
var rootdata = [<!--{$root_type}-->];
var fm = Ext.form;
var rootcombo = newcombo(rootdata);
var rootingdata=object_Array(rootdata);
    function rooting(v) {
		return rootingdata[v];
    }
function newcombo(sdata){
	return Ext.create('Ext.form.field.ComboBox',{
		typeAhead: true,
		triggerAction: 'all',
		mode: 'local',
		store: Ext.create('Ext.data.ArrayStore',{
			id: 0,
			fields: ['myId','displayText'],
			data: sdata
		}),
		valueField: 'myId',
		displayField: 'displayText',
		lazyRender: true,
		listClass: 'x-combo-list-small'
	});
}
    var editor = Ext.create('Ext.grid.plugin.RowEditing', {
		saveText: 'Update',
		clicksToEdit: 1
	})
	var Menu = Ext.define('CombineGood', {
		extend: 'Ext.data.Model',
		fields: [{
					name: 'text',type:'string'
				},{
					name: 'model',type:'string'
				}, {
					name: 'action',type:'string'
				},{
					name: 'code',type:'string'
				},{
					name: 'sortnum',type:'int'
				},{
					name: 'root',type:'string'
				}
		]
	}); 
	var ds = Ext.create('Ext.data.Store',{
		fields:['id','text','model','action','code','sortnum','root'],
		proxy: {
			type: 'ajax',
			url : 'index.php?model=menu&action=list',
			actionMethods:{
				read: 'POST'
			},
			reader:{
				type: 'json',
				totalProperty: 'totalCount',
				idProperty:'id',
				root: 'topics'
			}
		},
		listeners:{
			'update':function(thiz,record,operation){
				var newmenu = record.data;
				if(operation == Ext.data.Record.EDIT){
					Ext.Ajax.request({
						url:'index.php?model=menu&action=update',
						params:{'id':newmenu.id,
								'act':newmenu.action,
								'code':newmenu.code,
								'sortnum':newmenu.sortnum,
								'model':newmenu.model,
								'root':newmenu.root,
								'text':newmenu.text},
						method:'POST',
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							if(res.success){
							Ext.example.msg('MSG',res.msg);
							thiz.reload();
							}else{
							Ext.Msg.alert('MSG',res.msg);
							}
						},
						failure:function(){
							Ext.example.msg('MSG','更新失败'),
							thiz.rejectChanges();
						}
					})
				}
			}			
		}
    });

	var colModel = [ 
		 {header:'页面说明', flex:1,sortable:true,dataIndex:'text',editor: {
                xtype: 'textfield',
                allowBlank: false
            }},
		{header:'模块',flex:1,sortable:true,dataIndex:'model',editor: {
                xtype: 'textfield',
                allowBlank: true
            }},
		 {header:'功能',flex:1,sortable:true,dataIndex:'action',editor: {
                xtype: 'textfield',
                allowBlank: true
            }},
		 {header:'权限',flex:1,sortable:true,dataIndex:'code',editor: {
                xtype: 'textfield',
                allowBlank: true
            }},
		 {header:'排序',flex:1,sortable:true,dataIndex:'sortnum',editor: {
                xtype: 'numberfield',
				allowNegative:false,
                allowBlank: false
            }},
		 {header:'所属',sortable:true,dataIndex:'root',renderer: rooting,editor: rootcombo}
		];

	var grid = Ext.create('Ext.grid.Panel',{
				border:false,
				region:'center',
				title:'页面列表',
				store: ds,
				columns: colModel,
				selModel: Ext.create('Ext.selection.RowModel',{
					mode: 'SINGLE'
				}),
				plugins: [editor],
				autoScroll: true,
				tbar:[{
					text: '添加',
					handler: function(){
						var e = new Menu({
							id:'',
							text: '',
							model: '',
							action: '',
							code: '',
							sortnum:0,
							root:'root'
						});
						editor.stopEditing();
						ds.insert(0, e);
						grid.getView().refresh();
						grid.getSelectionModel().selectRow(0);
						editor.startEditing(0);
						}
					},'-',{
					ref: '../removeBtn',
					id : 'removeBtn',
					disabled: true,
					text: '删除',
					handler: delMenu
					},'-','模块分类',{
					xtype:'combo',
					store: Ext.create('Ext.data.ArrayStore',{
						 fields: ["id", "key_type"],
						 data: [['400078','系统设置'],['400079','产品管理'],['400080','采购管理'],['400081','仓储管理'],['400082','销售管理'],['400083','客户'],['400084','财务账款'],['400085','统计报表'],['400086','分析'],['400087','模板设置'],['400123','售后服务'],['root','root']]
					}),
					valueField :"id",
					displayField: "key_type",
					mode: 'local',
					width:120,
					editable: false,
					forceSelection: true,
					triggerAction: 'all',
					id:'entity_type_id',
					value:'root',
					allowBlank:false,
					listeners:{
					"select":{
						fn:function(e,rowindex,record){
							ds.load({params:{start:0, limit:50,id:e.getValue()}});
							//alert(e.getValue())
						}
					}	
				}}],
				bbar:{
					xtype: 'pagingtoolbar',
					pageSize: 50,
					store: ds,
					displayInfo: true,
					displayMsg: '第{0} 到 {1} 条数据 共{2}条',
					emptyMsg: "没有数据"
        		}
            });
	var viewport = Ext.create('Ext.Viewport',{
        layout:'border',
        items:[
			grid
		]}
	);
	ds.load({params:{start:0, limit:20}});
	function delMenu() {
		var ids = getIds(grid);
		if (ids) {
			Ext.Msg.confirm('确认', '真的要删除吗？', function(btn){
				if (btn == 'yes'){
					Ext.Ajax.request({
					   url: 'index.php?model=menu&action=delete&ids='+ids,
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								ds.reload();
								}else{
								Ext.Msg.alert('MSG',res.msg);
								}						
							}
					});
				}
			});		
		
		} else {
			Ext.example.msg('出错啦','你还没有选择要操作的记录！');
		}		//console.log(listView.getSelectedRecords()[0].data["id"]);
	}
    grid.getSelectionModel().on('selectionchange', function(sm){
        Ext.getCmp('removeBtn').setDisabled(sm.getCount() < 1);
    });
	loadend();
});
</script>
  <div id="north-div"></div>
  <div id="center"></div>

<!--{include file="footer.tpl"}-->