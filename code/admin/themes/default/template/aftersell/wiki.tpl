<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/Ext.FCKeditor.js"></script>
<script type="text/javascript" src="js/aftersell/wiki.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var wikitype = [<!--{$wikitype}-->];
	function showtype(v){
		return object_Array(wikitype)[v];
		}
	var WikiGrid = new Ext.ux.WikiGrid({
		id:'wikiGrid',
        title: '知识库列表',
		headers:['序号','标题','关键词','分类','添加人','添加时间','修改人','修改时间','描述','附件'],
        fields: ['id','title','sku','type','add_user','addtime','modified_user','modified_time','description','attachment'],
		autoWidth:true,
		frame:true,
		saveURL:'index.php?model=wiki&action=save',
		delURL:'index.php?model=wiki&action=delete',
		listURL:'index.php?model=wiki&action=list',
		windowTitle:'产品品牌',
		wikitype:wikitype,
		rend:showtype,
		windowWidth:800,
		windowHeight:500,
        renderTo: document.body
	})
	WikiGrid.getStore().load({
			params:{start:0,limit:WikiGrid.pagesize}
			});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
