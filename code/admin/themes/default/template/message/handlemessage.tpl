<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><!--{$cfg.page.title}--></title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/ext-all.css"/>
<link rel="stylesheet" type="text/css" href="common/lib/ext/resources/css/xtheme-gray.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javascript" src="common/lib/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="common/lib/ext/ext-all.js"></script>
<!--<script type="text/javascript" src="common/lib/ext/ext-all-debug.js"></script>-->
<script type="text/javascript" src="common/js/common1.js"></script>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '<!--{$smarty.const.CFG_PATH_IMAGES}-->s.gif';
</script>
</head>
<body>
<script type="text/javascript" src="js/message/messagelist-ext.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    var account = [<!--{$account}-->];
    var template = [<!--{$template}-->];
    var msg_type = [<!--{$msg_type}-->];
    account.push(['0','所有账户']);
    var viewport = new Ext.ux.MessageView({
        arrdata:[account,template,msg_type],
        listURL:'index.php?model=message&action=getmessagelist',
        accountTreeURL:'index.php?model=ebayaccount&action=getaccounttree',
        orderURL:'index.php?model=message&action=getallorder',
        lookReplyUrl:'index.php?model=message&action=lookmessage',
        editMsgUrl:'index.php?model=message&action=ToPartner',
        editMsgWinId:500033,
        windowTitle:'高级搜索',
        windowWidth:320,
        windowHeight:300,
        pagesize:15
    });
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
