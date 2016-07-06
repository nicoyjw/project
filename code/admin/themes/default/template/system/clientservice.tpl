<!--{include file="header.tpl"}-->
<script type="text/javascript">
loadend();
</script>
<style type="text/css">
body{font-size:12px;}
input, button, textarea, select {
    font-family: inherit;
}
td{font-size:12px;font-family:arial,宋体,sans-serif;}
.memberRight{width:792px; padding-bottom:20px;color:#626262;margin:0 auto}
.memberRight .topText{height:59px; line-height:59px; font-weight:bold}
.memberRight .topText .awoke{float:right; height:39px;  font-weight:normal;}
.memberRight .topText .awoke img{ vertical-align:middle; margin-bottom:3px}
.memberRight .Content{width:100%; float:left; border:1px solid #dedede; position:relative}
.memberRight .liheight li{height:118px;}
.memberRight .liheight table th{ vertical-align:top; height:20px;}
.memberRight .topText2{height:59px; margin-top:12px; padding-left:20px; font-weight:bold; *margin-bottom:15px}
.borderandradius{border:1px solid #D7D7D7;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;behavior: url(/js/PIE.htc);}
.memberRight .imgHei {
    margin-bottom: -2px;
}
.memberRight .E-ds {
    position: relative;
}
input {
    margin-bottom: 2px;
    vertical-align: middle;
}
.memberRight .E-ds table td {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-color: #D7D7D7 #D7D7D7 -moz-use-text-color -moz-use-text-color;
    border-image: none;
    border-style: solid solid none none;
    border-width: 1px 1px medium medium;
    z-index: 1;
}
.memberRight .E-ds .AlignCenter {
    text-align: center;
}
.memberRight .E-ds .titHead {
    background: url("themes/default/images/mbTabTit.jpg") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    border: 1px solid #D7D7D7;
    font-weight: bold;
    height: 28px;
}
.memberRight .E-ds .titHead img {
    cursor: pointer;
}
.memberRight .E-ds .titHead2 {
    background: url("themes/default/images/mbTabTit.jpg") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    font-weight: bold;
    height: 28px;
}
.memberRight .E-ds .titHead2 td {
    border-left: medium none;
    border-right: medium none;
}
.memberRight .E-ds .titHead2 img {
    margin-bottom: -1px;
}
.memberRight .E-ds .titHead td {
    border-left: medium none;
    border-right: medium none;
}
.memberRight .E-ds .titHead img {
    margin-bottom: -1px;
}
.memberRight .E-ds .pen {
    height: 59px;
}
.mbFontColor1{color:#ff6300;}
.memberRight .awokBody{ padding:30px 0 0 0; }
.memberRight .awokBody table td{ border:none; padding:3px; vertical-align:top; line-height:18px; color:#494949}
.memberRight .duty label{ margin-right:20px;}
.memberRight .duty img{ vertical-align:middle;}
.memberRight .awokBtnOk{ background:url(../images/member/other/re-x.gif) no-repeat; width:73px; height:22px; text-align:center; line-height:22px; color:#494949; font-weight:bold; display:block; margin-top:8px}
.memberRight .TextareaWidt{width:403px; height:65px; border:1px solid #DCE3EA; background:url(../images/member/other/input_bg.jpg) repeat-x top; padding:10px;}
.memberComplaintsStar .memberCommonBtnLeft{margin:0 20px 0 30px}
.memberCommonBtnLeft{background: url("themes/default/images/linkBtnLeft.jpg") left center no-repeat;padding-left:2px;cursor:pointer;display: inline-block;height: 21px;}
.memberCommonBtnRight{background: url("themes/default/images/linkBtnRight.jpg") right center no-repeat;padding-right:2px;cursor:pointer;display: inline-block;height: 21px;}
.borderandradius{border:1px solid #D7D7D7;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;behavior: url(/js/PIE.htc);}
.memberCommonBtn{background: url("themes/default/images/linkBtn.jpg") repeat-x;color: #522201;display: inline-block;
	font-weight: bold;height: 21px;line-height: 21px;text-align: center; padding:0 10px;cursor:pointer}
</style>
<div class="memberRight">
<div class="topText"><span class="awoke"><img src="themes/default/images/awoke.jpg" width="17" height="18" alt="友情提醒" />
    <label class="mbFontColor1">友情提醒：</label>
    留下您的建议，帮助我们更好的为您服务</span>提点建议 </div>
<div class="Content E-ds" style="border:none;">
    <div class="borderandradius">
   <table width="100%" style="border-collapse:collapse;table-layout: fixed;margin:0;padding:0;">
      <tr>
        <td colspan="5" class="awokBody" style="padding:5px;border:none;">
        <table width="100%" cellspacing="0" cellpadding="0">
            <tr>
              <td width="19%" align="right">建议类型： </td>
              <td class="duty">
              <select name="suggest_type" id="suggest_type">
              <option value="">请选择</option>
              <option value="物流建议">物流建议</option>
              <option value="平台建议">平台建议</option>
              <option value="客服建议">客服建议</option>
              </select>
              </td>
            </tr>
            <tr>
              <td align="right">建议内容：</td>
              <td>
              <textarea name="description" style="width:465px; height:67px" class="TextareaWidt" id="description" cols="45" rows="5"></textarea></td>
            </tr>
            <tr>
              <td align="right">&nbsp;</td>
              <td><span class="memberCommonBtnLeft"><span class="memberCommonBtnRight">
              
              <input type="submit" name="ctl00$ContentPlaceHolder1$btnSubmit" value="提交" id="ctl00_ContentPlaceHolder1_btnSubmit" class="memberCommonBtn" style="border-style:None;" />
              </span></span></td>
            </tr>
          </table></td>
      </tr>
    </table>
    </div>
    <br />  
    <div class="borderandradius">
        <table width="100%">
      <thead>
        <tr class="titHead2 AlignCenter">
          <td style="width:20%; text-align:center;border-top:none;">建议时间</td>
          <td style="width:15%;border-top:none;">建议类型</td>
          <td style="width:30%;border-top:none;">建议内容</td>
          <td style="width:45%;border-top:none;">操作</td>
        </tr>
      </thead>
      <tbody id="BindDataArea" class="bindTableClass">  
      </tbody>
    </table>
    </div>    
  </div>
  
<!--{include file="footer.tpl"}-->