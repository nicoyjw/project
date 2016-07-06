<!--{include file="header.tpl"}-->
<style type="text/css">
#tab11_item .x-panel-body{
background: white;
font: 11px Arial, Helvetica, sans-serif;
}
#tab11_item .thumb{
background: #dddddd;
padding: 3px;
}
#tab11_item .thumb img{
height: 80px;
width: 80px;
}
#tab11_item .thumb-wrap{
float: left;
margin: 4px;
margin-right: 0;
padding: 5px;
}
#tab11_item .thumb-wrap span{
display: block;
overflow: hidden;
text-align: center;

}

#tab11_item .x-view-over{
border:1px solid #dddddd;
background: #efefef url(common/lib/ext/resources/images/default/grid/row-over.gif) repeat-x left top;
padding: 4px;
}

#tab11_item .x-view-selected{
background: #eff5fb url(themes/default/images/selected.gif) no-repeat right bottom;
border:1px solid #99bbe8;
padding: 4px;
}
#tab11_item .x-view-selected .thumb{
background:transparent;
}
.x-statusbar .x-status-busy {
    padding-left: 25px !important;
    background: transparent no-repeat 3px 0;
	background-image: url(themes/default/images/accept.png);
}
.x-status-valid{ background-image: url(themes/default/images/accept.png);}
</style>

<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript" src="js/aliexpress/ali_goods.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = [<!--{$account}-->];
	account.push(['0','所有帐号']);
	var goodstatus = [['onSelling','上架销售中'],['waitUpload','待发布<font style="color:red">(ERP状态)</font>'],['offline','已下架'],['auditing','审核中'],['editingRequired','审核不通过'],['expire_offline','到期下架'],['user_offline','手动下架']];
	var viewport = Ext.create('Ext.ux.GoodsView',{
        fields: ['id','goods_img','skuCode','goods_name','lotNum','packageType','keyword','ItemID','productPrice','goods_status','wsOfflineDate','packageLength','packageWidth','packageHeight','grossWeight','account_id','bulkOrder','bulkDiscount','account_name','Propertys_qty','SKUs_qty','ProductViewed','SalesInfo'],
		listURL:'index.php?model=aliexpress&action=listingList',
		catTreeURL:'index.php?model=aliexpress&action=getAccount',
		windowTitle:'高级搜索',
        goodstatus:goodstatus,
		windowWidth:320,
		accountdata:account,
		windowHeight:300,
		pagesize:50
	});
	
	
	/*var accarr = object_Array(account);
	var goodstatus = [['1','已上架销售'],['2','已下架'],['3','审核中'],['4','审核不通过'],['0','所有状态']];
	var EnditemGrid = Ext.create('Ext.ux.GoodsView',{
		id:'aliGrid',
        fields: ['id','goods_id','goods_img','skuCode','goods_name','lotNum','packageType','keyword','ItemID','productPrice','goods_status','wsOfflineDate','packageLength','packageWidth','packageHeight','grossWeight','account_id','bulkOrder','bulkDiscount','account_name','ali_good_id'],
		autoWidth:true,
		frame:true,
		accountdata:account,
		goodstatus:goodstatus,
		accarr:accarr,
		status:0,
		saveURL:'index.php?model=aliexpress&action=updateListing',
		editURL:'index.php?model=goods&action=editListing',
		listURL:'index.php?model=aliexpress&action=listingList&status=0',
		catTreeURL:'index.php?model=aliexpress&action=getAccount',
        renderTo: document.body
	})
	var viewport = Ext.create('Ext.Viewport',{
        layout:'fit',
        items:[
			EnditemGrid
		]}
	);*/
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
