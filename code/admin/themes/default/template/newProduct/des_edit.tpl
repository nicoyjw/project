<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/newProduct/desEditor.js"></script>
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	var action_type = '<!--{$action_type}-->';
	var type = '<!--{$type}-->';//新增描述类型
	var goodsinfo = eval(<!--{$good}-->
	);
	goodsinfo=goodsinfo?goodsinfo:{};
	var depict=new Ext.ux.form.FCKeditor({width:600,height:300,id:'des_text',fieldLabel:type+'描述',value:goodsinfo.des_text});
	var adddesForm = new Ext.ux.adddesForm({
		title:'产品信息',
		border:true,
		region:'center',
		labelAlign: 'right',
        labelWidth: 75,
		good:goodsinfo,
		depict:depict,
		type:type,
		action_type:parseInt(action_type),
        autoWidth: true,
		autoHeight:true,
		renderTo:document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->