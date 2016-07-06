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
<script type="text/javascript" src="js/goods/aliexpresswaitupload.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	var account = [<!--{$account}-->];
	account.push(['0','选择Aliexpress帐号']);
	var viewport = Ext.create('Ext.ux.GoodsView',{
        fields: ['id','goods_id','goods_img','skuCode','goods_name','lotNum','packageType','keyword','ItemID','productPrice','goods_status','wsOfflineDate','packageLength','packageWidth','packageHeight','grossWeight','account_id','bulkOrder','bulkDiscount','account_name'],
		listURL:'index.php?model=aliexpress&action=getWaitlisting',
		catTreeURL:'index.php?model=aliexpress&action=getAccount',
		windowTitle:'高级搜索',
		windowWidth:320,
		accountdata:account,
		windowHeight:300,
		pagesize:25
	});
	loadend();
});
</script>
<!--{include file="footer.tpl"}-->
