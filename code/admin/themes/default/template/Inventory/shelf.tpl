<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/inventory/shelf.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var depot = [<!--{$depot}-->];
     var detailpanel = Ext.create('Ext.Panel',{
        width:600,
        frame:true,
        title:'温馨提示',
        html:'<p> 1、<font style="color:red">亲请不要删除主仓库与主仓库的拣货货架哦，不然库存会不见哦。</font> </p>',
        renderTo: document.body
    });
    var DepotGrid = Ext.create('Ext.ux.test.inventory.depot', {
        title: '仓库',
        headers: ['id', '仓库名','仓库值'],
        fields: ['id', 'di_caption','di_value'],
        pagesize: 15,
        style:'margin-top:25px;',
        depot: depot,
        id:'DepotGrid',
        width:600,
        frame: true,    
        autoHeight: true,
        listURL: 'index.php?model=Inventory&action=Depotlist',
        saveURL: 'index.php?model=Inventory&action=depotsave',
        delURL: 'index.php?model=Inventory&action=depotdelete',
        windowTitle: '编辑仓库信息',
        windowWidth: 320,
        windowHeight: 180,
        renderTo: document.body
    });
    var ShelfGrid = Ext.create('Ext.ux.test.inventory.shelf', {
		title: '货架',
		headers: ['shelf_id', '货架名', '所属仓库', '发货货架'],
		fields: ['shelf_id', 'name', 'depot', 'is_main', 'depot_id'],
		pagesize: 15,
        style:'margin-top:25px;',
        id:'ShelfGrid', 
		depot: depot,
        width:600,
		frame: true,    
		autoHeight: true,
		listURL: 'index.php?model=Inventory&action=shelflist',
		saveURL: 'index.php?model=Inventory&action=shelfsave',
		delURL: 'index.php?model=Inventory&action=shelfdelete',
		windowTitle: '编辑货架信息',
		windowWidth: 320,
		windowHeight: 180,
		renderTo: document.body
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
