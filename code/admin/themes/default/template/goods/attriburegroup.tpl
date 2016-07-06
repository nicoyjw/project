<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/goods/attributegroup.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
    var AttrGroupGrid = Ext.create('Ext.ux.AttrGroupGrid',{
        title: '属性组列表',
		id:'attrgrid',
		headers:['序号','属性组名称'],
        fields: ['attribute_group_set_id','attribute_set_id','attribute_group_name'],
		width:600,
		frame:false,
		saveURL:'index.php?model=attribute&action=groupupdate',
		delURL:'index.php?model=attribute&action=groupdelete',
		listURL:'index.php?model=attribute&action=grouplist',
		windowTitle:'产品属性',
		windowWidth:420,
		autoHeight:true,
        renderTo: document.body
    });
	AttrGroupGrid.getStore().load({
			params:{start:0,limit:AttrGroupGrid.pagesize}
			});	
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
<!--// 使用一个Json数据结构作为tree的本地数据源  
// 参考"http://ccmv.iteye.com/admin/blogs/154049"  
Ext.onReady(function(){
	Ext.QuickTips.init();
	
	var nodes = [    
    {'text' : 'SY0706', 'id' : 1, 'leaf' : false, 'cls' : 'folder', 'children' : [    
        {'text' : '1', 'id' : 11, 'leaf' : false, 'cls' : 'folder', 'children' : [  
            {'text' : '01', 'id' : 111, 'leaf' : true, 'cls' : 'file'},  
            {'text' : '02', 'id' : 112, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '03', 'id' : 113, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '04', 'id' : 114, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '05', 'id' : 115, 'leaf' : true, 'cls' : 'file'}    
        ]},   
        {'text' : '2', 'id' : 12, 'leaf' : false, 'cls' : 'folder', 'children' : [   
            {'text' : '06', 'id' : 121, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '07', 'id' : 122, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '08', 'id' : 123, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '09', 'id' : 124, 'leaf' : true, 'cls' : 'file'},    
            {'text' : '10', 'id' : 125, 'leaf' : true, 'cls' : 'file'}    
        ]}  
    ]}   
]; 	
var Tree = Ext.tree;    
  
var tree = new Tree.TreePanel({  
   // renderTo: 'tree',  
    animate: true,    
    loader: new Tree.TreeLoader(),  
    lines: true, 
	id:'ttree',   
    selModel: new Ext.tree.MultiSelectionModel(),    
    containerScroll: false,  
    autoHeight: true,  
    root: new Tree.AsyncTreeNode({    
        text: 'BUAA',    
        draggable: false,    
        id: 0,    
        children: nodes,  
        expanded: true  
    }),  
    enableDD: true,  
    ddGroup: "tgDD",  
    listeners: {  
        // 监听beforenodedrop事件，主要就是在这里工作  
        // 参考"http://www.iteye.com/topic/155272"中的讨论  
        beforenodedrop: function(dropEvent) {  
            var node = dropEvent.target;    // 目标结点  
            var data = dropEvent.data;      // 拖拽的数据  
            var point = dropEvent.point;    // 拖拽到目标结点的位置  
            // 如果data.node为空，则不是tree本身的拖拽，而是从grid到tree的拖拽，需要处理
			
            if(!data.node) {  
                switch(point) {  
                    case 'append':  
                        // 添加时，目标结点为node，子结点设为空  
                        ddFunction(node, null, data.selections);  
                        break;  
                    case 'above': 
                        // 插入到node之上，目标结点为node的parentNode，子结点为node  
                        ddFunction(node.parentNode, node, data.selections);  
                        break;  
                    case 'below': 
                        // 插入到node之下，目标结点为node的parentNode，子结点为node的nextSibling  
                        ddFunction(node.parentNode, node.nextSibling, data.selections);  
                        break;  
                }  
            }  
        }  
    }  
});  
	/*var Tree = new Ext.tree.TreePanel({
		title: '属性组',
		width: 250,
		animate: true,  
		autoScroll: true,
		lines: true,    
		selModel: new Ext.tree.MultiSelectionModel(),    
		containerScroll: false, 
		split: false,
		id:'cattree',
		loader: new Ext.tree.TreeLoader(),
		root: new Ext.tree.AsyncTreeNode({
			text: 'Root',
			draggable:false,
			id:'root'
		}),
		enableDD: true,  
    	ddGroup: "tgDD",  
		rootVisible: false,
		loader: new Ext.tree.TreeLoader({
		dataUrl:'index.php?model=goods&action=getcattree',
		}),
		listeners: {
			// 监听beforenodedrop事件，主要就是在这里工作  
       	 // 参考"http://www.iteye.com/topic/155272"中的讨论  
      	  beforenodedrop: function(dropEvent) {  
				var node = dropEvent.target;    // 目标结点  
				var data = dropEvent.data;      // 拖拽的数据  
				var point = dropEvent.point;    // 拖拽到目标结点的位置  
				// 如果data.node为空，则不是tree本身的拖拽，而是从grid到tree的拖拽，需要处理  
				if(!data.node) {  
					switch(point) {  
						case 'append':  
							// 添加时，目标结点为node，子结点设为空  
							ddFunction(node, null, data.selections);  
							break;  
						case 'above':  
							// 插入到node之上，目标结点为node的parentNode，子结点为node  
							ddFunction(node.parentNode, node, data.selections);  
							break;  
						case 'below':  
							// 插入到node之下，目标结点为node的parentNode，子结点为node的nextSibling  
							ddFunction(node.parentNode, node.nextSibling, data.selections);  
							break;  
					}  
				}  
			}  ,
			click: function(n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				
		alert(Tree.getSelectionModel().getSelectedNode());
				//fn(n.attributes.id,n.attributes.text);
			}
		}})*/
	var ddFunction = function(node, refNode, selections) {  
	/*	Ext.getCmp('ttree').eachChild(function(){
			alert(node.id);
		});*/
		for(var i = 0; i < selections.length; i ++) {  
			var record = selections[i];  
			node.insertBefore(new Tree.TreeNode({
				text: record.get('attribute_code'),  
				id: record.get('attribute_id'),  
				leaf: true,  
				cls: 'file' 
			}), refNode);
				alert(node.id);  
		}  
	} 


	 var AttrGroupGrid = new Ext.ux.AttrGroupGrid({
        title: '产品属性列表',
		id:'attrgrid',
		headers:['序号','属性编码','属性标签','是否必填','是否唯一','属性标签类型','提示更新','属性备注'],
        fields: ['attribute_id','attribute_code','attribute_label','default_value','is_required','is_unique','type_name','is_update_notice','note','entity_type_id','1_tag','2_tag','3_tag','4_tag','5_tag','6_tag','7_tag','8_tag','9_tag','10_tag'],
		frame:true,
		saveURL:'index.php?model=attribute&action=update',
		delURL:'index.php?model=attribute&action=delete',
		listURL:'index.php?model=attribute&action=list',
		windowTitle:'产品属性',
		windowWidth:420,
		autoHeight:true,
		enableDragDrop: true,  
    	ddGroup: "tgDD",
        //renderTo: document.body
    });
		//定义一个Panel
	var nav =new Ext.Panel({
		region: 'west', //放在西边，即左侧
		width: 250,
		margins: '3 0 3 3',
		cmargins: '3 3 3 3',
		items:[tree]
	});
		//定义一个Panel
	var grrid =new Ext.Panel({
		region: 'center',
		margins: '3 0 3 3',
		cmargins: '3 3 3 3',
		items:[AttrGroupGrid]
	});
	var viewport = new Ext.Viewport({
		layout:'border',
		border : false,
		plain: true,
		width: 600,
		height: 350,
		items:[
			nav,
			grrid
		 ]
	});
	AttrGroupGrid.getStore().load({
		params:{start:0,limit:AttrGroupGrid.pagesize}
	});	
/*	var Tree = new Ext.tree.TreePanel({
		title: '属性组',
		width: 250,
		animate: true,  
		autoScroll: true,
		lines: true,    
		selModel: new Ext.tree.MultiSelectionModel(),    
		containerScroll: false, 
		split: false,
		id:'cattree',
		loader: new Ext.tree.TreeLoader(),
		root: new Ext.tree.AsyncTreeNode({
			text: 'Root',
			draggable:false,
			id:'root'
		}),
		enableDD: true,  
    	ddGroup: "tgDD",  
		rootVisible: false,
		loader: new Ext.tree.TreeLoader({
		dataUrl:'index.php?model=goods&action=getcattree',
		}),
		listeners: {
			// 监听beforenodedrop事件，主要就是在这里工作  
       	 // 参考"http://www.iteye.com/topic/155272"中的讨论  
      	  beforenodedrop: function(dropEvent) {  
				var node = dropEvent.target;    // 目标结点  
				var data = dropEvent.data;      // 拖拽的数据  
				var point = dropEvent.point;    // 拖拽到目标结点的位置  
				// 如果data.node为空，则不是tree本身的拖拽，而是从grid到tree的拖拽，需要处理  
				if(!data.node) {  
					switch(point) {  
						case 'append':  
							// 添加时，目标结点为node，子结点设为空  
							ddFunction(node, null, data.selections);  
							break;  
						case 'above':  
							// 插入到node之上，目标结点为node的parentNode，子结点为node  
							ddFunction(node.parentNode, node, data.selections);  
							break;  
						case 'below':  
							// 插入到node之下，目标结点为node的parentNode，子结点为node的nextSibling  
							ddFunction(node.parentNode, node.nextSibling, data.selections);  
							break;  
					}  
				}  
			}  ,
			click: function(n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				//fn(n.attributes.id,n.attributes.text);
			}
		}})*/
/*var panel = new Ext.Window({
	title:'SELECT Category',
	id:'cattreepanel',
	width:450,
	height:500,
	autoScroll:true,
	modal: false,
	closable:false,
	constrainHeader:true,
	items:[{
		title: '属性组',
		xtype: 'treepanel',
		width: 400,
		animate: true,  
		autoScroll: true,
		lines: true,    
		selModel: new Ext.tree.MultiSelectionModel(),    
		containerScroll: false, 
		split: false,
		id:'cattree',
		loader: new Ext.tree.TreeLoader(),
		root: new Ext.tree.AsyncTreeNode({
			text: 'Root',
			draggable:false,
			id:'root'
		}),
		enableDD: true,  
    	ddGroup: "tgDD",  
		rootVisible: false,
		loader: new Ext.tree.TreeLoader({
		dataUrl:'index.php?model=goods&action=getcattree',
		}),
		listeners: {
			// 监听beforenodedrop事件，主要就是在这里工作  
       	 // 参考"http://www.iteye.com/topic/155272"中的讨论  
      	  beforenodedrop: function(dropEvent) {  
				var node = dropEvent.target;    // 目标结点  
				var data = dropEvent.data;      // 拖拽的数据  
				var point = dropEvent.point;    // 拖拽到目标结点的位置  
				// 如果data.node为空，则不是tree本身的拖拽，而是从grid到tree的拖拽，需要处理  
				if(!data.node) {  
					switch(point) {  
						case 'append':  
							// 添加时，目标结点为node，子结点设为空  
							ddFunction(node, null, data.selections);  
							break;  
						case 'above':  
							// 插入到node之上，目标结点为node的parentNode，子结点为node  
							ddFunction(node.parentNode, node, data.selections);  
							break;  
						case 'below':  
							// 插入到node之下，目标结点为node的parentNode，子结点为node的nextSibling  
							ddFunction(node.parentNode, node.nextSibling, data.selections);  
							break;  
					}  
				}  
			}  ,
			click: function(n) {
				if(n.hasChildNodes()&& !show) {
						Ext.example.msg('Error','Can not be choosed');
						return false;
				}
				Ext.getCmp('cattreepanel').hide();
				//fn(n.attributes.id,n.attributes.text);
			}
		}}]
	});
	panel.show(); */ 
	/*    var AttrGroupGrid = new Ext.ux.AttrGroupGrid({
        title: '产品属性列表',
		id:'attrgrid',
		headers:['序号','属性编码','属性标签','是否必填','是否唯一','属性标签类型','提示更新','属性备注'],
        fields: ['attribute_id','attribute_code','attribute_label','default_value','is_required','is_unique','type_name','is_update_notice','note','entity_type_id','1_tag','2_tag','3_tag','4_tag','5_tag','6_tag','7_tag','8_tag','9_tag','10_tag'],
		frame:true,
		saveURL:'index.php?model=attribute&action=update',
		delURL:'index.php?model=attribute&action=delete',
		listURL:'index.php?model=attribute&action=list',
		windowTitle:'产品属性',
		windowWidth:420,
		autoHeight:true,
		enableDragDrop: true,  
    	ddGroup: "tgDD",
        //renderTo: document.body
    });*/
// 拖拽时需要用到的函数，用来处理添加树结点  
/* 
 * TreeNode     node        :   tree上的目标结点 
 * TreeNode     refNode     :   目标结点的子结点，用于定位新添加的结点 
 * Record Array selections  :   从grid中选取的记录数组    
 */  
 /*var data = [    
    ['11', 211, true, 'file'],  
    ['12', 212, true, 'file'],  
    ['13', 213, true, 'file'],  
    ['14', 214, true, 'file'],  
    ['15', 215, true, 'file'],  
    ['16', 221, true, 'file'],  
    ['17', 222, true, 'file'],  
    ['18', 223, true, 'file'],  
    ['19', 224, true, 'file'],  
    ['20', 225, true, 'file']  
];  
  
var store = new Ext.data.Store({  
    reader: new Ext.data.ArrayReader({}, [  
       {name: 'text'},  
       {name: 'id'},  
       {name: 'leaf'},  
       {name: 'cls'}  
    ])  
});  
store.loadData(data);  
  
// 建一个grid，并设置到tgDD拖拽组中  
var Grid = Ext.grid;  
  
var model = new Grid.ColumnModel([  
    {header: "text", width: 50, sortable: true, dataIndex: 'text'},  
    {id:'id', header: "id", width: 50, sortable: true, dataIndex: 'id'},  
    {header: "leaf", width: 50, sortable: true, dataIndex: 'leaf'},  
    {header: "cls", width: 50, sortable: true, dataIndex: 'cls'}  
]);  
  
  
  
var grid = new Grid.GridPanel({  
    ds: store,  
    cm: model,  
    sm: new Grid.RowSelectionModel(),  
    autoHeight: true,  
    enableDragDrop: true,  
    ddGroup: "tgDD"  
});*/

	


});


  
// 建一棵树，并将其设置到tgDD拖动组中  

  
// grid的数据源  
-->