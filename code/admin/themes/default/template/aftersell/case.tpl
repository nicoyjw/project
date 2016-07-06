<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/aftersell/case.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

    var CaseGrid = new Ext.ux.CaseGrid({
		id:'CaseGrid',
        title: '投诉管理列表',
		headers:['序号','Caseid','类型','关联单号','客户','发货方式','Tracking','投诉状态','所属账户','更新时间'],
        fields: ['id','caseid','casetype','order_sn','userId','shipping','track_no','status', 'Sales_account_id','lastmodifieddate'],
		width:900,
		frame:true,
		saveURL:'index.php?model=case&action=update',
		delURL:'index.php?model=case&action=del',
		listURL:'index.php?model=ecase&action=List',
		windowTitle:'投诉管理',
		windowWidth:300,
		windowHeight:160,
        renderTo: document.body
    });
	CaseGrid.getStore().load({
			params:{start:0,limit:CaseGrid.pagesize}
			});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
