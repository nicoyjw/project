<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 0;
        }
    </style>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/finance/refund.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
    var RefundGrid = Ext.create('Ext.ux.RefundGrid',{
		id:'RefundGrid',
        title: '付款单列表',
		headers:['序号','付款单号','关联单号','付款方式','流水号','币种','总金额','付款时间','状态','创建时间','创建人','付款人','付款时间','备注'],
        fields: ['rec_id','order_sn','relate_order_sn','payment_id','paypalid', 'currency','amt','paid_time','add_time','add_user','comment','payment','confirm_time','confirm_user','account_id','paid_money','status'],
		autoWidth:true,
		frame:true,
		addURL:'index.php?model=finance&action=addgf',
		delURL:'index.php?model=finance&action=delgf',
		listURL:'index.php?model=finance&action=gfList',
		windowTitle:'编辑付款单',
        renderTo: document.body
    });
	RefundGrid.getStore().load({
			params:{start:0,limit:RefundGrid.pagesize}
			});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
