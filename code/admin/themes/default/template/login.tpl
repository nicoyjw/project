<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body onload="checkuserName()" style="margin:0;padding:0">   
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员登陆,贸易宝ERP系统 Aliexpress Amazon  EBay Magento Zencart 多平台一体化订单处理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" type="text/css" href="themes/default/css/loginStyle.css"/>
<script type="text/javascript" src="common/js/jquery-1.4a2.min.js"></script>
<script type="text/javascript" src="common/js/cookie.js"></script>


<table width="980px" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="229" valign="middle"><a href="http://www.cpowersoft.com/blog"><img style="margin-top:8px;" src="themes/default/images/LOGO.png" height="85px" border="0" /></a></td>
    <td width="229" style="cursor:pointer" valign="bottom" onclick="window.location.href='http://www.cpowersoft.com/blog'" class="enfont Size1 Font2" id="TopText" onmouseover="this.className='Size1 enfont'" onmouseout="this.className='enfont Size1 Font2'">&nbsp;</td>
    <td width="518">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" background="themes/default/images/topbg.jpg">

      <tr>
        <td height="35" align="right" class="cnfont Size1" style="padding-top:3px;">亚洲翘楚 　·   专注中国 　·   贯通全球</td>
      </tr>
      <tr>
        <td height="25" align="right" valign="bottom" class="Font2 Font5" style="padding-bottom:2px !important;padding-bottom:3px;">&nbsp;</td>
      </tr>
      <tr>
        <td height="35" align="right" class="enfont Font2"><a href="javascript:void(0)" class="link4">ENG</a> &nbsp;|&nbsp; <a href="javascript:void(0)" class="link4">繁</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a style="margin-right:20px" href="/index.html" target="_blank">官方首页</a><a style="background-color: rgb(255, 127, 0);color:#fff" href="">我的ERP</a>&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="/app/custom/index.php">我的应用</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="/blog/">客户服务</a>&nbsp;&nbsp;&nbsp;<a href="/blog/category/worldec">外贸咨询</a>&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="980" height="25px" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#9A9A9A;">
  <tr>
    
  </tr>
</table>
<script language="javascript">
function checkuserName(){
	var loginuser = getCookie('MYBUSERLOGIN');
	var logcompany = getCookie('MYBCOMPANYLOGIN');
	if(loginuser !== undefined) document.getElementById("username").value = loginuser;
	if(logcompany !== undefined) document.getElementById("company").value = logcompany;
	
}
function checkLog(){
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	var company = document.getElementById("company").value;
	
	var rm = document.getElementById("rm").checked;
	//alert(username + '<br>' +password);return;
	$.ajax({
	type: "post",
	dataType: "text",
	url: "index.php?action=login&username="+username+"&passwd="+password+'&company='+company,
	data: "",
	timeout: 5000,
	complete :function(){},
	success: function(xml)
		{
			if(rm == true) addCookie('MYBUSERLOGIN',username,180);
			if(rm == true) addCookie('MYBCOMPANYLOGIN',company,180);
			var dd=unescape(xml);
			var error = document.getElementById("logNotice");
			error.innerHTML=dd;
			setTimeout(document.location='index.php?model=main',1500);
		}
	})
}
function reloadpage(){
	history.go(-1);
  	history.go(0);
}
function eventkey(event,v){
	var e = event || window.event || arguments.callee.caller.arguments[0];
	if(e && e.keyCode==13){ // enter 键
		 if(v == 1){
			 document.getElementById("password").focus();
		 }else{
			 checkLog();
		 }
	}
}
</script>
<table width="980px" border="0" cellpadding="0" cellspacing="2" align="center" style="background-color:#9A9A9A">
	<tr height="455px">
    	<td valign="top" width="70%">
        <div style="width:100%; margin: 0 auto 0 auto; padding:5px;background-color:#9A9A9A">
            <div id="wrapper">
        
                <div id="details" class="base">	
        
                    <div id="photo" class="base">
        
                     <ul id="photos" style="margin:0;padding:0">
                        <li><a href="#1"><img src="themes/default/images/login/new_1.png" alt="Caption 1" width="678px" height="383px" /></a></li>
                        <li><a href="#2"><img src="http://www.cpowersoft.com/blog/wp-content/uploads/2014/01/6554.png" alt="Caption 2" width="678px" height="383px" /></a></li>
                        <li><a href="#3"><img src="http://www.cpowersoft.com/blog/wp-content/uploads/2014/01/432.png" alt="Caption 3" width="678px" height="383px" /></a></li>
                        <li><a href="#4"><img src="http://www.cpowersoft.com/blog/wp-content/uploads/2014/01/guanyu.png" alt="Caption 4" width="678px" height="383px" /></a></li>
                        <li><a href="#5"><img src="http://www.cpowersoft.com/erp/themes/default/images/aliexpress_erp.jpg" alt="Caption 5" width="678px" height="383px" /></a></li>
                        <li><a href="#6"><img src="http://www.cpowersoft.com/erp/themes/default/images/ebay_aliexpress_amazon.png" alt="Caption 6" width="678px" height="383px" /></a></li>
                    </ul>
        
                    </div><!-- photo ends -->
        
                    <div id="hover-box">
        
                        <div id="thumbs" class="base">
        
                        <ul>
                            <li><a href="#1" class="highlight"><img src="themes/default/images/login/1-.jpg" alt="Caption 1" width="74" height="41" /><span></span></a></li>
                            <li><a href="#2"><img src="http://www.cpowersoft.com/erp/themes/default/images/6554_1.png" alt="Caption 2" width="74" height="41" /></a></li>
                            <li><a href="#3"><img src="http://www.cpowersoft.com/erp/themes/default/images/432_1.png" alt="Caption 3" width="74" height="41" /></a></li>
                            <li><a href="#4"><img src="http://www.cpowersoft.com/erp/themes/default/images/guanyu_1.png" alt="Caption 4" width="74" height="41" /></a></li>
                            <li><a href="#5"><img src="http://www.cpowersoft.com/erp/themes/default/images/aliexpress_erp_1.jpg" alt="Caption 5" width="74" height="41" /></a></li>
                            <li><a href="#6"><img src="http://www.cpowersoft.com/erp/themes/default/images/ebay_aliexpress_amazon_1.png" alt="Caption 6" width="74" height="41" /></a></li>
                        </ul>
        
                        <p>Web Design appreciation-CSS website design-flash site www.u14.cc</p>
                        </div><!-- thumbs -->
            
                        <div id="navigation" class="base">
                        <a href="#" id="prev" class="prev-next"><span>&lt;&lt;</span> prev</a>
                        <a href="#" id="play-pause" class="play pause" title="Play or Pause the slider">Play/Pause</a>
                        <ul>
                            <li><a href="#1" class="highlight">Story 1</a></li>
                            <li><a href="#2">Story 2</a></li>
                            <li><a href="#3">Story 3</a></li>
                            <li><a href="#4">Story 4</a></li>
                            <li><a href="#5">Story 5</a></li>
                            <li><a href="#6">Story 6</a></li>
                        </ul>
                        <a href="#" id="next" class="prev-next">next <span>&gt;&gt;</span></a>
                        </div><!-- navigation -->
                    </div><!-- hover box -->
        
                    <div id="description" class="base">
        
                        <p id="small-caption">Roy Halladay struck out 11 Marlins batters and threw 115 pitches Saturday.</p>
        
                        <h1 id="title"><a href="#">Web Design appreciation-CSS website design-flash</a></h1>
        
                        <p id="long-desc">Web Design appreciation - CSS website design - flash site Web Design appreciation - CSS website design - flash site
        </p>
                        
                    </div><!-- description -->
        
                </div><!-- base -->
        
            </div><!-- mlb wrapper -->
        
        </div>
        </td>
        <td>
        	<DIV id="login">
            
            
            <P id='info'>请输入公司名与用户名与密码</P>
            <DIV class='control-group'><SPAN class=icon-user></SPAN><INPUT style="height:20px" onKeyDown="return eventkey(event,1)" type=text id="company" name='company' placeholder="公司名"></DIV>
            <DIV class='control-group'><SPAN class=icon-user></SPAN><INPUT style="height:20px" onKeyDown="return eventkey(event,1)" type=text id="username" name='username' placeholder="用户名"></DIV>
            <DIV class=control-group><SPAN class=icon-lock></SPAN><INPUT style="height:20px" onKeyDown="return eventkey(event)"  type=password id="password" name=password placeholder="密码"> </DIV>
            <DIV class="remember-me" style="text-align:right">记住我<INPUT id="rm" checked="checked" type="checkbox" name="remember"><LABEL for=rm>&nbsp;&nbsp;&nbsp;&nbsp;</LABEL></DIV>
            <DIV class=login-btn><INPUT id=login-btn value="登 录"  type=button onClick="checkLog()"></DIV>
            <p id="logNotice" style="font-size:12px"></p>
            <FORM id=forgotform class=hide method=post action="/">
            <P id=info2>请输入Email地址重设密码.</P>
            <DIV class=control-group><SPAN class=icon-mail></SPAN><INPUT type=text name=email placeholder="Email"> </DIV>
            <DIV class="login-btn forget-btn"><INPUT style="height:30px" value="提 交" type=button onClick="checkLog()"></DIV></FORM>
            <br />
            <br />
            <br />
            <br />	
            <br />
            <br /><br /><br /><br /><br /><br /><br /><br />
            </DIV>
        </td>
    </tr>
    <tr>
    	<td></td>
        <td></td>
    </tr>
</table>
<DIV id="nullLine">&nbsp;</DIV>

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody><tr>
    <td class="bgColor1" style="padding-left:10px;padding-top:5px;" align="left" height="30" width="200">
	</td>
    <td class="bgColor1 Font1 enfont" style="padding-right:12px;" align="right"><font style="font-size:12px;">© 粤ICP备13010532号-1  Copyright  2012-2013  CPowerSoft Inc.   Design by Nic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><a style="color:#fff" href="http://www.cpowersoft.com/blog/?page_id=65"> 关于我们</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a style="color:#fff" href="http://www.cpowersoft.com/blog/?page_id=13">加入我们</a></td>
  </tr>
</tbody></table>
<script type="text/javascript" src="js/login/data.js?v=2.0"></script>
<script type="text/javascript" src="js/login/general.js?v=2.0"></script>       
<div style="display: none;">
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F4cd4a67235aa9ecfa559f9e5401dfb1b' type='text/javascript'%3E%3C/script%3E"));
</script>
</div>
</body>
</html>