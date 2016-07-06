<!--{include file="header.tpl"}-->
<script type="text/javascript" src="js/order/amazonreport.js"></script>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	var account = [<!--{$allaccount}-->];
    var AmzreportGrid = Ext.create('Ext.ux.AmzreportGrid',{
		id:'AmzreportGrid',
        title: 'Amazon产品Report',
		headers:['id','账号','ReportId','ReportType','生效时间','操作'],
        fields: ['id','account_id','ReportId','ReportType', 'AvailableDate','status'],
		frame:true,
		accountdata:account,
		listURL:'index.php?model=amazon&action=getreportlist&type=2',
		outdepotURL:'index.php?model=amazon&action=requestreport',
        renderTo: document.body
    });
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
