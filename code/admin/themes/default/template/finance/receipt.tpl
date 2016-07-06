<!--{include file="header.tpl"}-->
    <style type="text/css">
        body .x-panel {
            margin:0 0 20px 0;
        }
    </style>
<script type="text/javascript" src="js/normalgrid.js"></script>
<script type="text/javascript" src="js/finance/receipt.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
    var ReceiptGrid = Ext.create('Ext.ux.ReceiptGrid',{
		id:'receiptGrid',
        title: '收款单列表',
		headers:['序号','收款单号','关联单号','付款方式','流水号','币种','手续费','应收金额','实收金额','付款时间','状态','创建时间','创建人','收款人','收款时间'],
        fields: ['rec_id','order_sn','relate_order_sn','payment_id','paypalid', 'currency','feeamt','amt','paid_time','add_time','add_user','comment','payment','confirm_time','confirm_user','account_id','paid_money','status'],
		frame:true,
		addURL:'index.php?model=finance&action=addrf',
		delURL:'index.php?model=finance&action=delrf',
		listURL:'index.php?model=finance&action=rfList',
		windowTitle:'编辑收款单',
        renderTo: document.body
    });
	ReceiptGrid.getStore().load({
			params:{start:0,limit:ReceiptGrid.pagesize}
			});
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
