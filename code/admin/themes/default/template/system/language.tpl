<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 10px;
        }
    </style>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/system/language.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
    var Language = Ext.create('Ext.ux.LanguageGrid',{
		id:'languid',
        title: '语言管理列表',
		headers:['序号','name','编码','排序','是否活动'],
        fields: ['id','name','code','sort_order','is_active'],
		width:600,
		frame:true,
		saveURL:'index.php?model=language&action=Update',
		delURL:'index.php?model=language&action=delete',
		listURL:'index.php?model=language&action=List',
		ajaxURL:'index.php?model=language&action=ajax',
		windowTitle:'语言管理',
		windowWidth:350,
		windowHeight:180,
        renderTo: document.body
    });
	var detailpanel = Ext.create('Ext.Panel',{
		width:600,
		frame:true,
		title:'语言管理说明',
		html:'<div style="font-size:11px">温馨提示：<br>1、目前最多只支持添加10种语言。<br>2、语言对应的语言编码请参照<a href="javascript:void(0)" onclick="openWindowWithPost(\'index.php?model=language&action=Openwin\', null) ">语言编码对照表</a>进行设置</div>',
		renderTo: document.body
	});
	Language.getStore().load({
			params:{start:0,limit:Language.pagesize}
			});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
