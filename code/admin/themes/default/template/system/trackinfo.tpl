<!--{include file="header.tpl"}-->
<style type="text/css"> 
.x-statusbar .x-status-busy {
    padding-left: 25px !important;
    background: transparent no-repeat 3px 0;
    background-image: url(themes/default/images/accept.png);
}
.x-status-valid{ background-image: url(themes/default/images/accept.png);}
</style>

<link rel="stylesheet" type="text/css" href="js/statusbar/css/statusbar.css" />
<script type="text/javascript" src="js/statusbar/StatusBar.js"></script>
<script type="text/javascript" src="js/system/trackinfo.js"></script>
<script type="text/javascript" src="js/celltooltip.js"></script>
<script type="text/javascript">
Ext.onReady(function() {
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = 'side';
    var account = [<!--{$account}-->];
    var status = [<!--{$status}-->];
    account.push(['0','所有帐号']);
    status.push(['all','所有状态']);
    var viewport = Ext.create('Ext.ux.GoodsView',{               
        fields: ['order_id','text','status','update_time','last_info','order_sn','track_no','end_time','paypalid','consignee','Sales_account_id','userid','shipping_id','Sales_channels','email','city','street1','street2','state','country','zipcode','tel','ShippingService'],
        listURL:'index.php?model=main&action=getTrackingInfo',
        catTreeURL:'index.php?model=aliexpress&action=getAccount',
        windowTitle:'高级搜索', 
        windowWidth:320,
        accountdata:account,
        status:status,
        windowHeight:300,
        pagesize:25
    });  
    loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
