<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	
	var Tree2 = Ext.tree;
    
    var tree = new Tree2.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
         buttons: [{
            text: '添加',
			handler:function(){
				var id = 0;
				var s = tree.getSelectionModel().getSelectedNode();
				if (s) {
					id = s.id;
				}
				Ext.fly('parent_id').dom.value = id;
				Ext.fly('id').dom.value = '';
				Ext.fly('dept_caption').dom.value = '';
				Ext.fly('note').dom.value = '';
			}
        },{
            text: '删除',
			handler:function(){
				var s = tree.getSelectionModel().getSelectedNode();
				if (s) {
					id = s.id;
					Ext.Msg.confirm('确认', '真的要删除吗？', function(btn){
						if (btn == 'yes'){
							Ext.Ajax.request({
							   url: 'index.php?model=dept&action=delete&ids='+id,
							   success: function(result){
									root.reload();
									}
							});
						}
					});		
				}
				
			}
        }],
        buttonAlign:'center',
        enableDD:true,
        containerScroll: true, 
        loader: new Tree2.TreeLoader({
            dataUrl:'index.php?model=dept&action=tree'
        })
    });
	tree.addListener('beforemove', function (treeobj,thisobj,oldp,newp) {
		Ext.Ajax.request({
			url: 'index.php?model=dept&action=changeParent&id='+thisobj.id+'&parent_id='+newp.id,
			success: function(result){
				
			}
		});
	});
    // set the root node
    var root = new Tree2.AsyncTreeNode({
        text: '公司',
        draggable:false,
        id:'0'
    });
    tree.setRootNode(root);

    // render the tree
    tree.render();
    root.expand();
    tree.on('click',treeClick);
    tree.expandAll();
    function treeClick(node,e) {
    	if (node.id!=0) {
    		Ext.fly('dept_caption').dom.value = node.text;
    		Ext.fly('note').dom.value = node.attributes.note;
    		Ext.fly('parent_id').dom.value = node.attributes.parent_id;
    		Ext.fly('id').dom.value = node.id;
    	}
    }

	Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
     var top=new Ext.FormPanel({
     	title:'部门信息',
		labelWidth:40,
        bodyStyle:'padding:5px 5px 0',
		frame:true,
		style:'margin:10%',
		defaults: {width: 175},
		defaultType: 'textfield',
        items: [{
        		id:'dept_caption',
                fieldLabel: '名称',
                allowBlank:false,
                name: 'dept_caption'
            },{
				xtype:'textarea',
                fieldLabel: '说明',
                id:'note',
                name: 'note'
            },{
				xtype:'hidden',
				name: 'id',
				id:'id',
				value: '<!--{$info.id}-->'
			},{
				xtype:'hidden',
				name: 'parent_id',
				id:'parent_id',
				value: '0'
			}],

        buttons: [{
            text: '保存',
				handler:function(){
					if(top.form.isValid()){
						top.form.doAction('submit',{
							 url:'index.php?model=dept&action=save',
							 method:'post',
							 params:'',
							 success:function(form,action){
							 	if (!Ext.fly('id').dom.value) top.form.reset();
							 	Ext.example.msg('操作','保存成功!');
							 	root.reload();
							 },
							 failure:function(){
									Ext.example.msg('操作','服务器出现错误请稍后再试！');
							 }
                      });
					}
					}
        },{
            text: '重置',
			handler:function(){top.form.reset();}
        }]
    }); 
    top.render(document.getElementById('form-div'));       
    
	loadend();
});
</script>
<div id="tree-div" style="overflow:auto; height:100%;width:200px;float:left;"></div>
<div id="form-div" style="overflow:auto; height:100%;width:360px;float:left;"></div>
<div id="tb_div"></div>
<!--{include file="footer.tpl"}-->
