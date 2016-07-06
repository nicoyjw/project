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
<script type="text/javascript" src="js/aftersell/feedback.js"></script>
<script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    var account = [<!--{$account}-->];
    var fbtype = [<!--{$fbtype}-->];
    var template = [<!--{$template}-->];
    fbtype.push(['0','所有类型']);
    account.push(['0','所有账户']);
    var viewport = new Ext.ux.MessageView({
        arrdata:[account,template,fbtype],
        listURL:'index.php?model=ecase&action=getfblist',
        accountTreeURL:'index.php?model=ebayaccount&action=getaccounttree',
        windowTitle:'高级搜索',
        windowWidth:320,
        windowHeight:300,
        pagesize:15
    });
    loadend();
});
</script>
<!--{include file="footer.tpl"}-->
