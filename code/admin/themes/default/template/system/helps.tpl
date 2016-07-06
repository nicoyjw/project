<!--{include file="header.tpl"}-->
<style type="text/css">
.newslist {
	padding:0;
	margin:0;
    padding-bottom: 2px;
	width: 695px;
}
.helpFAQ{padding:25px 25px 50px; }
.helpFAQInfo {
    background: url("themes/default/images/iconQA.jpg") no-repeat scroll left 5px rgba(0, 0, 0, 0);
    border-bottom: 1px dashed #A3A3A3;
    padding-left: 20px;
    width: 703px;
	font-family: arial,宋体,sans-serif;
    font-size: 12px;
}
.helpFAQInfo h4{color:#535353; line-height:20px; margin-bottom:5px;margin-top:15px}
h4.innerRightTitle{padding:5px 0 10px 0; color:#626262; font-weight:bold}
h4 a{float:right; color:#ff8400; padding-right:10px;}
h4.innerRightTitle2{padding:15px 0; color:#0088CC; font-weight:bold; font-size:14px}
.helpFAQInfo p{margin:0;padding:0;color:#535353;line-height: 22px;padding-bottom: 15px;}
.notopradius{border:1px solid #ccc;background-color:White;-webkit-border-radius:0 5px 5px 5px;-moz-border-radius:0 5px 5px 5px;border-radius:0 5px 5px 5px;-webkit-box-shadow: #bbb 0 1px 0.2px;-moz-box-shadow: #bbb 0 1px 0.2px;box-shadow: #bbb 0 1px 0.2px;behavior: url(/js/PIE.htc);border-top-color: #fff;}
#BindDataArea{
	
}
h1, h2, h3, h4, h5, h6 {
    font-size: 100%;
    font-weight: normal;
    margin: 0;
    padding: 0;
}
</style>
    <script type="text/javascript">
Ext.onReady(function() {
	Ext.QuickTips.init();
	
	
	var panel_3 = Ext.create('Ext.panel.Panel', {
	style:'background-color:#666;border-left:1px solid #CCC;border-right:1px solid #CCC;border-bottom:1px solid #CCC;border-radius:8px 0 0 0;',
	id:'panel_3',
	collapsible: false,
	html:"<div class='helpFAQ notopradius'><h4 class='innerRightTitle2'></h4><!--{foreach from =$content_2 item = content2 name=content2item}--><ul class='newslist'><div class='helpFAQInfo'><h4><strong>问：</strong><!--{$content2.FAQ}--></h4><p><strong style='color:#0088CC;'>答：</strong>  <!--{$content2.answer}--></p></div></ul><!--{/foreach}--></div>"
	});
	var panel_4 = Ext.create('Ext.panel.Panel', {
	style:'background-color:#666;border-left:1px solid #CCC;border-right:1px solid #CCC;border-bottom:1px solid #CCC;border-radius:8px 0 0 0;',
	id:'panel_1',
	collapsible: false,
	html:"<div class='helpFAQ notopradius'><h4 class='innerRightTitle2'></h4><ul class='newslist'>  <div class='helpFAQInfo'><h4><strong>问：</strong>我要如何获得帮助?</h4><p><strong style='color:#0088CC;'>答：</strong>可以通过 <a style='color:orange;font-size:14px;font-weight:bold;' onclick=\"parent.newTab('2007','客户中心','http://www.cpowersoft.com/blog/?page_id=2007')\" href='javascript:void(0)'>客户中心</a>提交问题给我们，或者<a style='color:orange;font-size:14px;font-weight:bold;' onclick=\"parent.newTab('contact_us','联系我们','http://www.cpowersoft.com/blog/contact_us.html')\" href='javascript:void(0)'>联系我们</a></p></div></ul></div>"
	});	
	
	var tab = new Ext.TabPanel({
        activeTab: <!--{$page}-->,
		width:750,
		deferredRender:false,
		style:'border-radius:8px 8px 0 0;',
        defaults:{autoHeight:true,autoScroll:false},
        items:[{
			    id:'tab1',
                title: '物流发货',
				defaultType: 'textfield',
                disabled:true,
				//autoScroll:true,
                
				layout:'column',
                items:[]
				},
				{
			    id:'tab2',
                title: '产品业务',
				defaultType: 'textfield',
                disabled:true,
				//autoScroll:true,
                items:[]
				},
				{
			    id:'tab7',
                title: 'Amazon相关',
				defaultType: 'textfield',
				autoScroll:true,
                items:[panel_3]
				},{
			    id:'tab5',
                title: '客户服务',
				defaultType: 'textfield',
				autoScroll:true,
                items:[panel_4]
				},
				{
			    id:'tab4',
                title: 'Aliexpress相关',
				defaultType: 'textfield',
				autoScroll:true,
                items:[]
				},
				{
			    id:'tab3',
                title: '投诉建议',
				defaultType: 'textfield',
				autoScroll:true,
                disabled:true,
                items:[]
				},
				{
			    id:'tab6',
                title: 'EBay相关',
				defaultType: 'textfield',
                disabled:true,
				autoScroll:true,
                items:[]
				},
				{
			    id:'tab8',
                title: '系统知识',
                disabled:true,
				defaultType: 'textfield',
				autoScroll:true,
                items:[]
				}
				]
	});
	tab.render(document.body);
	
	loadend();
});
    </script>
<!--{include file="footer.tpl"}-->
