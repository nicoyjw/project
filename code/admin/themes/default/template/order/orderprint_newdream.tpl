<!--
<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=28"></li>
-->
<style type="text/css">
<!--
@media print
{
body{
    margin:0;
    padding:0
    }
.noprint { display: none } 
.STYLE1 {
    font-family: C39HrP24DhTt;
    font-size: 40px;
}
.pagebreak{
page-break-after:always;
clear:both;
}
li{
list-style:none;
word-warp:break-all;
}
}
body{
    margin:0;
    padding:0
    }
.STYLE1 {
    font-family: C39HrP24DhTt;
    font-size: 40px;
}
.pagebreak{
page-break-after:always;
clear:both;
}
.bbb{border-top: #000 1px solid;border-width:1px 0;}
ul{
    margin:0;
    padding:0;
    }
li{
    margin:0;
    padding:0;
word-break:break-all;
word-wrap:normal;
list-style:none;
}

.STYLE4 {font-size: 14px; font-weight: bold;}
.STYLE5 {font-family: Arial, Helvetica, sans-serif}
/*Customs Declaration*/


</style>
<OBJECT classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=10 id=WB width=10></OBJECT> 
<script language="JavaScript">
function doPrintSetup(){ 
//打印设置 
WB.ExecWB(8,1) 
} 
function doPrintPreview(){ 
//打印预览 
    try{
        WB.ExecWB(7,1);
    }catch(e){
        var errorMsg = e.message+"\r"+"请设置:IE选项->安全->Internet->"+"ActiveX控件和插件"+"\r"+"对未标记为可安全执行脚本的ActiveX的控件初始化并执行脚本->允许/提示";
        Ext.example.msg(errorMsg);
        return;
    }
} 
function doprint(){ 
//直接打印
    try{ 
    WB.ExecWB(6,6)
    }catch(e){
    window.print();
    } 
}
</script>
<body style="margin:0;padding:0">
<div class=noprint> 
  <div align="center">
  <input id="idPrint1" type="button" value="打印本页" 
onclick="doprint();">
  <input id="idPrint3" type="button" value="打印预览" 
onclick="doPrintPreview();">
    </div>
</div> 
<!--{if $type eq 1}--><!-打印地址->
<div style="width:240mm;float:left;">
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:110mm ;border:#000 1px solid;float:left;">
   <div style="position:relative;left: 28px;top: 27px;">
        SZ-ETC
    </div>
    <div style="position:relative; width:175px;height:60px; left: 196px;top: 0px;">
        <table width="100%" height="100%" border="0px" cellspacing="0" cellpadding="0">
            <tr>
                <td rowspan="3" width="87" align="left" valign="top" style="font-size:12px;border:1px solid #000;">
                    AAA
                </td>
                <td height="8" width="87" align="left" valign="top" style="font-size:12px; border-top:1px solid #000; border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;CCC
                </td>
            </tr>
            <tr>
                <td height="8" align="left" valign="top" style="font-size:12px;border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;BBB
                </td>
            </tr>
            <tr>
                <td height="30" align="left" valign="top" style="font-size:12px;border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;DD
                </td>
            </tr>
        </table>
    </div>
    <div style="position:relative;left:28px;top:-8px; width:300px;height:140px; line-height:120%">
        <ul style="width:300px; font-size:16px">
            <li>
                <b>
                    Deliver TO:
                </b>
            </li>
            <li>
                <!--{$order.consignee}-->
            </li>
            <li>
                <!--{$order.street1}-->
                &nbsp;
                <!--{$order.street2}-->
            </li>
            <li>
                <!--{$order.city}-->
                ,
                <!--{$order.state}-->
                ,
                <!--{$order.zipcode}-->
            </li>
            <li>
                <!--{$order.country}-->
            </li>
            <li>
                <!--{$order.tel}-->
            </li>
        </ul>
    </div>
    <div style="position:relative;left: 0px;top: -5px;width:100%" align="center">
        <table height="200" width="100%" border="0px" cellspacing="0" cellpadding="0">
            <tr>
                <td height="150" >
                    <table height="150" width="335px" border="0px" cellspacing="0" cellpadding="0" style="border-top:#000 3px solid;padding:0px;margin:0px;margin-left:28px;">
                        <tr>
                            <td width="265" height="150" valign="top">
                                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.1cm;height:45px;">
                                    <tr style="padding:0px;margin:0px;border:1px solid;font-size:10px;">
                                        <td align="left" height="20" style="padding:2px;border-bottom:2px solid #000;border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;font-size:9px" colspan="4">
                                            <ul style="padding:0px;margin:0px;float:left;width:5.5cm;font-weight:700;line-height:10pt;">
                                                <li style="padding:0px;margin:0px;float:left;font-size:9pt;text-align:left;width:5.5cm;line-height:80%;">
                                                    <b>
                                                        CUSTOMS&nbsp;DECLARATION
                                                    </b>
                                                </li>
                                                <li style="padding:0px;margin:0px;float:left;font-size:7pt;text-align:left;width:5.5cm;">
                                                    <b>
                                                        Postal administration(May be opened officially)
                                                    </b>
                                                </li>
                                            </ul>
                                            <ul style="padding:0px;margin:0px;float:left;width:1.5cm;line-height:10pt;">
                                                <li style="padding:0px;margin:0px;float:left;font-size:11pt;text-align:left;width:1.5cm;font-weight:700;">
                                                    CN22
                                                </li>
                                                <li style="padding:0px;margin:0px;float:left;font-size:7pt;text-align:left;width:1.5cm">
                                                    Important!
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="23" height="11" style="padding:2px; border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;padding:0;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;overflow:hidden;width:10px;"
                                            />
                                        </td>
                                        <td width="55" style="padding:2px;  border-collapse:collapse;
                                        overflow:hidden;padding:0px;margin:0px;font-size:6pt;" valign="top">
                                            Gift
                                        </td>
                                        <td align="right" width="10" style="padding:0px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;width:10px;overflow:hidden;"
                                            />
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Commercial&nbsp;sample
                                        </td>
                                    </tr>
                                    <tr style="padding:0px;margin:0px;" valign="top">
                                        <td height="11" align="right" width="23" style="padding:0px;overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;width:10px;overflow:hidden;"
                                            />
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Documents
                                        </td>
                                        <td align="right" width="10" style="padding:0px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;overflow:hidden;width:10px;"
                                            checked/>
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Other(Tick as appropriate)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="border-top:2px solid #000;">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left"
                                            style="font-size:11px">
                                                <tr>
                                                    <th scope="col" colspan="2" align="left" width="197" style="border-bottom:2px solid #000; border-right:2px solid #000;">
                                                        &nbsp;&nbsp;Detailed description of contents
                                                    </th>
                                                    <th scope="col" align="left" width="68" style="border-bottom:2px solid #000;">
                                                        &nbsp;&nbsp;Value
                                                    </th>
                                                </tr>
                                                <!--{assign var="x" value="0"}-->
                                                <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                                                <!--{assign var="x" value=$x+$goods.Declared_value}-->
                                                <tr>
                                                    <td colspan="2" height="20" style="border-right:2px solid #000;">&nbsp;
                                                        <span  contenteditable = "true"><!--{$goods.goods_qty}-->&nbsp;X&nbsp;<!--{$goods.dec_name}--></span>
                                                    </td>
                                                    <td align="center"><span  contenteditable = "true">$
<!--{$goods.Declared_value|string_format:"%.2f"}--></span>
                                                    </td>
                                                </tr>
                                                <!--{/foreach}-->
                                                <tr>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000; border-right:2px solid #000;">
                                                        Origin:
                                                        <span contenteditable="true">
                                                            China
                                                        </span>
                                                    </td>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000; border-right:2px solid #000;"
                                                    align="center">
                                                        Total Weight(Kg)
                                                        <br/>
                                                        <span contenteditable="true">
                                                            0.200
                                                        </span>
                                                    </td>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000;" align="center">
                                                        Total Value
                                                        <br/>
                                                        <span contenteditable="true">
                                                            $<!--{$x|string_format:"%.2f"}-->
                                                        </span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-size:11px; line-height:90%;border-bottom:2px solid #000;"
                                        colspan="4">
                                            I, the undersigned,whose name and address are given on the item, certify
                                            that the particulars given in this declaration are correct and that this
                                            item dose not contain any dangerous article or articles prohibited by legislation
                                            or by customs regulations.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="font-size:11px;">
                                              <tr>
                                                <td>Date and Sender's Signature</td>
                                                <td rowspan="3" style="font-size:24px" valign="bottom"><img src="/themes/default/template/order/jacky.png"></td>
                                              </tr>
                                               <tr>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td><!--{$today}--></td>
                                              </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" valign="top">
                               <div style="-webkit-transform: rotate(-90deg); 
-moz-transform: rotate(-90deg); 
filter: progidXImageTransform.Microsoft.BasicImage(rotation=3);
-ms-filter: progidXImageTransform.Microsoft.BasicImage(rotation=3);
width:30px;"><img style="filter:progid:DXImageTransform.Microsoft.BasicImage(Rotation=3)" src="index.php?model=login&action=Barcode&number=RX00000000000&type=1&height=34"></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2" style="border-top:2px solid #000;">
                    <span style="padding:0px;margin:0px;margin-left: 65px; float: left; margin-top: 10px;font-size:45pt; height:80px">
                        R
                    </span>
                    <span style="padding:0px;margin:0px;margin-left: -38px; float: left; margin-top: 73px;font-size:10pt; ">
                        <b>EINSCREIBEN</b>
                    </span>
                    <div style="position:relative; width:210px; top:13px; left:-40px; line-height:80%">           
                        <center style="font-size:13px;"><b>RX&nbsp;00&nbsp;000&nbsp;000&nbsp;000</b></center>
                        <li  style="border-top:2px solid #000;"><center><img src="index.php?model=login&action=Barcode&number=RX00000000000&height=34"></center></li>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2" style="border-top:1px solid #000;font-size:12px">
                <br>&nbsp;&nbsp;&nbsp;Figure 2 Sample Integrated for Registered mail to all destinaction excep <br>&nbsp;&nbsp;&nbsp;(Note:Illustraction not drawn to scale;for sample purposes only.)
                </td>
            </tr>
        </table>
    </div>
</div>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 4 == 0}-->class="pagebreak"<!--{/if}-->></div>
<!--{/foreach}-->
</div>

    
<!--{elseif $type eq 224}--><!--递四方的 10*10-->    
    
<style>
*{
    margin:0;
    padding:0;
}
body {
    color:#1C1C1C;
}
#box {
    width:380px;
    border:2px solid #8A8B8D;
    margin-bottom:10px;
    padding:2px;
    border-radius:2px;
    box-shadow:0 0 3px 2px #ccc;

}
#box .first-row {
    height:50px;
    border-bottom:2px solid #8A8B8D;
}
#box .first-row span {
    display:inline-block;
    float:right;
    height:50px;
}
#box .first-row span:nth-child(2) {
    margin:0 32px 0 12px;
    line-height:50px;
    font-weight:bold;
    color:black;
}
#box .first-row span p {
    text-align:center;
    font-size:12px;
}
#box .first-row span p:nth-child(1) {
    color:#292929;
    font-weight:bold;
}
#box .order-num,
#box .bounce {
    height:18px;
    line-height:18px;
    border-bottom:2px solid #8A8B8D;
    padding:1px 0 1px 2px;
    font-size:13px;
}
#box .main-info {
    height:144px;
    border-bottom:2px solid #8A8B8D;
}
#box .main-info table {
    width:100%;
}
#box .main-info .tab1 {
    height:120px;
}
#box .main-info table td{
    vertical-align: top;
}
#box .main-info .tab1 p,
#box .main-info .tab2 td{
    font-size:18px;
    line-height:16px;
    font-weight:bold;
}
#box .bar-code {
    text-align:center;
    border-bottom:2px solid #8A8B8D;
    height:50px;
}

#box .bar-code{position:relative;}
#box .bar-code b{position:absolute;left:20px;top:10px;font-size:24px;}
#box .date {
    line-height:20px;
    font-size:16px;
    border-bottom:2px solid #8A8B8D;
    padding-left:4px;
}
#box .coding {
    height:18px;
    line-height:18px;
    font-size:12px;
    padding-left:3px;
}
#box .coding span{
    display:inline-block;
    text-align:right;
    float:right;
    clear:both;
    margin-right:5px;
}
.coding_s {
    font-size:12px;
    line-height:14px;
    border-top:2px solid #8A8B8D;
    padding:2px 4px;
}
</style>
    
    <!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div id="box"  class="pagebreak">
        <div class="first-row">
            <img src="themes/default/images/express/ccpost.jpg" />
            <span class="country">
                 <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> PE <!--{/if}--> &nbsp;<!--{$order.Cncountry}-->
            </span>
            <span class="center-content">
                <p>航&nbsp;&nbsp;空</p>
                <p>Small&nbsp;&nbsp;packet</p>
                <p>BY&nbsp;&nbsp;AIR</p>
            </span>
        </div>
        <div class="order-num"><strong>华南小包挂号 :</strong> 44190002159000</div>
        <div class="main-info">
            <table border="0" cellpadding="5" cellspacing="0" class="tab1">
                <tr>
                    <td style="width:42px;"><strong>To</strong></td>
                    <td>
                        <p><b><!--{$order.consignee}--></b><br/>
                        <!--{$order.street1}-->  <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}--><br/>
                        <b><!--{$order.country}--></b>
                        </p>
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="5" cellspacing="0" class="tab2">
                <tr>
                    <td width="37px">Zip:</td>
                    <td width="110px"><!--{$order.zipcode}--></td>
                    <td width="50px">Tel :</td>
                    <td><!--{$order.tel}--></td>
                </tr>
            </table>
        </div>
        <div class="bounce"><strong>退件单位 :</strong></div>
        <div class="bar-code">
            <b>R</b>
            <div style="text-align:center;"><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"></div>
        </div>
        <div class="date"><b>[</b>7552200<b>]</b>&nbsp;Ref No：AVIPADMIN1659610&nbsp;</div>
        <div class="coding">CS:S4087&nbsp;&nbsp;SD:S2308(X009)<span><!--{$smarty.now|date_format:'%m-%d %H:%M:%S'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> </span>  </div>
        <div class="coding_s">
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}--> 
        </div>
    </div>
<!--{/foreach}-->

<!--{elseif $type eq 225}--><!--递四方的2 10*10-->    

<style>
*{
    margin:0;
    padding:0;
}
body {
    color:#1C1C1C;
}
#box {
    width:380px;
    border:2px solid #8A8B8D;
    margin-bottom:10px;
    border-radius:2px;
    box-shadow:0 0 3px 2px #ccc;
    padding:2px;

}
#box .first-row {
    height:50px;
    border-bottom:2px solid #8A8B8D;
}
#box .first-row span {
    display:inline-block;
    float:right;
    height:50px;
}
#box .first-row span:nth-child(2) {
    margin:0 32px 0 12px;
    line-height:50px;
    font-weight:bold;
    color:black;
}
#box .first-row span p {
    text-align:center;
    font-size:12px;
}
#box .first-row span p:nth-child(1) {
    color:#292929;
    font-weight:bold;
}
#box .order-num,
#box .bounce {
    height:18px;
    line-height:18px;
    border-bottom:2px solid #8A8B8D;
    padding:1px 0 1px 2px;
    font-size:13px;
}
#box .main-info {
    height:134px;
    border-bottom:2px solid #8A8B8D;
}
#box .main-info table {
    width:100%;
}
#box .main-info .tab1 {
    height:110px;       
}
#box .main-info table td{
    vertical-align: top;
}
#box .main-info .tab1 p,
#box .main-info .tab2 td{
    font-size:18px;
    font-weight:bold;
    line-height:16px;
    padding-top:2px;
}
#box .bar-code {
    text-align:center;
    border-bottom:2px solid #8A8B8D;
    height:50px;
}

#box .date {
    height:20px;
    line-height:20px;
    text-align:center;
    font-size:14px;
    border-bottom:2px solid #8A8B8D;
}
#box .coding {
    line-height:14px;
    font-size:14px;
    padding:2px 4px;
}
</style>

        <!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div id="box"  class="pagebreak">
        <div class="first-row">
            <img src="themes/default/images/express/ccpost.jpg" />
            <span class="country">
                 <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> FR <!--{/if}-->  &nbsp;<!--{$order.Cncountry}-->
            </span>
            <span class="center-content">
                <p>航&nbsp;空</p>
                <p>Small&nbsp;packet</p>
                <p>BY&nbsp;AIR</p>
            </span>
        </div>
        <div class="order-num"><strong>华南小包挂号 :</strong>  44190002159000</div>
        <div class="main-info">
            <table border="0" cellpadding="5" cellspacing="0" class="tab1">
                <tr>
                    <td style="width:42px;"><strong>To</strong></td>
                    <td>
                        <p><!--{$order.consignee}--><br/>
                        <!--{$order.street1}-->  <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}--></p>
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="5" cellspacing="0" class="tab2">
                <tr>
                    <td width="37px">Zip:</td>
                    <td width="110px"><!--{$order.zipcode}--></td>
                    <td width="50px">Tel :</td>
                    <td><!--{$order.tel}--></td>
                </tr>
            </table>
        </div>
        <div class="bounce"><strong>退件单位 :</strong></div>
        <div class="bar-code">
            <div style="text-align:center;margin-top:10px;"><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"></div>
        </div>
        <div class="date">[7551614]&nbsp;&nbsp;<!--{$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}-->&nbsp;&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> </div>
        <div class="coding">
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}-->
        </div>
    </div>
<!--{/foreach}-->

<!--{elseif $type eq 226}--><!--燕邮宝(平邮)10*10-->
    <style>
* {
    margin:0;
    padding:0;
}
body {
    color:#1C1C1C;
}
#box {
    width:380px;
    border:2px solid #8A8B8D;
    padding:2px;
    border-radius:2px;
    box-shadow:0 0 3px 2px #ccc;
    margin-bottom:10px;
}
#box .first-row {
    height:20px;
}
#box .first-row span {
    float:left;
    height:20px;
    font-size:16px;
}
#box .order-num,
#box .bounce {
    height:18px;
    line-height:18px;
    border-bottom:2px solid #8A8B8D;
    padding:1px 0 1px 2px;
    font-size:13px;
}
#box .main-info {
    border-bottom:2px solid #8A8B8D;
}
#box .main-info div{
    text-align:right;
    padding-right:20px;font-size:14px;
    margin-bottom:3px;
}
#box .main-info table {
    width:100%;
}
#box .main-info .tab1 {
    padding-bottom:4px;
}
#box .main-info table td{
    vertical-align: top;
}
#box .main-info .tab1 p,
#box .main-info .tab2 td{
    font-size:20px;
    line-height:18px;
    font-weight:bold;
    padding-top:2px;
}
#box .bar-code b{position:absolute;right:15px;top:0;font-size:28px;}
#box .bar-code {
    text-align:center;
    border-bottom:2px solid #8A8B8D;
    position:relative;
    height:50px;
}
#box .date {
    height:24px;
    line-height:24px;
    font-size:14px;
    border-bottom:2px solid #8A8B8D;
    padding-left:3px;
    text-align:center;
}
#box .coding {
    line-height:14px;
    font-size:14px;
    padding:2px 4px;
    min-height:60px;
}

</style>

        <!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div id="box" class="pagebreak">
        <div class="first-row">
            <span>YAN WEN</span>
        </div>
        <div class="bar-code">
            <b>2</b>
             <div style="text-align:center;margin-top:10px;"><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"></div> 
        </div>
        <div class="date">Y-POST-<!--{$order.Cncountry}--></div>
        
        <div class="main-info">
            <table border="0" cellpadding="0" cellspacing="0" class="tab1">
                <tr>
                    <td style="width:42px;"><strong>To</strong></td>
                    <td>
                        <p><!--{$order.consignee}--><br/>
                        <!--{$order.street1}-->  <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}-->
                        </p>
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="5" cellspacing="0" class="tab2">
                <tr>
                    <td width="37px">Zip:</td>
                    <td width="110px"><!--{$order.zipcode}--></td>
                    <td width="50px">Tel:</td>
                    <td><!--{$order.tel}--> </td>
                </tr>
            </table>
            <div style='font-size:14px;line-height:14px;'><!--{$order.yw_logistic_no}--></div>
            <div><!--{$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}-->&nbsp;&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> </div>
        </div>
        <div class="coding">
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}--> 
        </div>
    </div>
<!--{/foreach}-->

<!--{elseif $type eq 227}--><!--燕邮宝挂号 10*10-->
<style>
* {
    margin:0;
    padding:0;
}
body {
    color:#1C1C1C;
}
#box {
    width:380px;
    border:2px solid #8A8B8D;
    padding:2px;
    border-radius:2px;
    box-shadow:0 0 3px 2px #ccc;
    margin-bottom:10px;
}
#box .first-row {
    height:20px;
}
#box .first-row span {
    float:left;
    height:20px;
    font-size:16px;
}
#box .order-num,
#box .bounce {
    height:18px;
    line-height:18px;
    border-bottom:2px solid #8A8B8D;
    padding:1px 0 1px 2px;
    font-size:13px;
}
#box .main-info {
    border-bottom:2px solid #8A8B8D;
}
#box .main-info div{
    text-align:right;
    padding-right:20px;font-size:14px;
    margin-bottom:3px;
}
#box .main-info table {
    width:100%;
}
#box .main-info .tab1 {
    padding-bottom:4px;
}
#box .main-info table td{
    vertical-align: top;
}
#box .main-info .tab1 p,
#box .main-info .tab2 td{
    font-size:20px;
    line-height:18px;
    font-weight:bold;
    padding-top:2px;
}
#box .bar-code b{position:absolute;right:15px;top:0;font-size:28px;}
#box .bar-code {
    text-align:center;
    border-bottom:2px solid #8A8B8D;
    position:relative;
    height:50px;
}
#box .date {
    height:24px;
    line-height:24px;
    font-size:14px;
    border-bottom:2px solid #8A8B8D;
    padding-left:3px;
    text-align:center;
}
#box .coding {
    line-height:14px;
    font-size:14px;
    padding:2px 4px;
    min-height:60px;
}

</style>

        <!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div id="box" class="pagebreak">
        <div class="first-row">
            <span>YAN WEN</span>
        </div>
        <div class="bar-code">
            <b>1</b>
             <div style="text-align:center;margin-top:10px;"><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"></div> 
        </div>
        <div class="date">Y-POST-<!--{$order.Cncountry}--></div>
        
        <div class="main-info">
            <table border="0" cellpadding="0" cellspacing="0" class="tab1">
                <tr>
                    <td style="width:42px;"><strong>To</strong></td>
                    <td>
                        <p><!--{$order.consignee}--><br/>
                        <!--{$order.street1}-->  <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}-->
                        </p>
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="5" cellspacing="0" class="tab2">
                <tr>
                    <td width="37px">Zip:</td>
                    <td width="110px"><!--{$order.zipcode}--></td>
                    <td width="50px">Tel:</td>
                    <td><!--{$order.tel}--> </td>
                </tr>
            </table>
            <div><!--{$order.yw_logistic_no}--></div>
            <div><!--{$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}-->&nbsp;&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> </div>
        </div>
        <div class="coding">
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}-->
        </div>
    </div>
<!--{/foreach}-->


<!--{elseif $type eq 222}--><!--燕文北京(平邮)10*10-->
         <style style='text/css'>
            *{margin:0;padding:0;}
            .clear:after{content:".";height : 0;display:block;visibility:hidden;clear:both;}
            .clear{zoom:1;}
            .con_title{width:380px;height:200px;border:1px solid black;border-bottom:none;overflow:hidden;padding:2px;overflow:hidden;}
            .con_left{width:130px;float:left;height:170px;}
            .con_right{width:249px;float:left;border-left:1px solid black;height:170px;}
            
            .con_foot{width:380px;border:1px solid black;padding:2px;margin-bottom:10px;}
            .down div{float:left;padding:1px 2px;font-size:12px;overflow:hidden;}
            .down .foot_s1{width:190px;}
            .down .foot_s{width:88px;}
            .down .foot_w{border-right:1px solid black;border-bottom:1px solid black;}
            .down .foot_q{border-bottom:1px solid black;}
            .down_s2 div{font-size:12px;line-height:12px;text-align:center;}
            .con_foot_down p{padding:1px 3px;}
            .con_foot_down .p1{font-size:8px;line-height:8px;}
            .con_foot_down .p2{font-size:12px;line-height:14px;}
            .con_foot .down_s div{font-size:12px;line-height:12px;text-align:center;}
            
            .con_title_s{height:34px;border-bottom:1px solid black;}
            .con_title_s img{height:30px;float:left;padding:2px 2px;margin-left:16px;}
            .con_title_s span{line-height:34px;display:block;float:left;padding:0 5px;}
            .con_title_s .spans{border-right:1px solid black;margin-left:40px;padding:0 8px;padding-right:8px;font-size:12px;}
            .con_title_s .spans_1{border-right:1px solid black;text-align:center;width:40px;height:36px;padding:0;}
            .con_left .p1{border-bottom:1px solid black;}
            .con_left .p2{border-bottom:1px solid black;}
            .con_left p{font-size:12px;padding:2px 4px;line-height:16px;}
            .con_right p{font-size:16px;line-height:14px;font-weight:bold;padding:2px 0 2px 4px;}
            .con_right .p2{font-size:16px;line-height:16px;height:16px;}
            
            .con_center{width:380px;height:45px;border:1px solid black;border-bottom:none;padding:2px;overflow:hidden;}
            .con_center div{float:left;}
            .con_center .cen_s1{text-align:center;width:140px;}
            .coding {line-height:14px;font-size:12px;border-top:1px solid #000;}
            .coding p{width:380px;padding:2px;}
        </style>
        
        <!--{foreach from =$orders item = order name=orderitem key=key}-->
<div class="pagebreak">
        <div class='con_title clear'>
            <div class='con_title_s clear'>
                <img src='themes/default/images/express/ccpost.jpg'/>
                <span class='spans'><b>Small Packet By AIR</b></span>
                <span class='spans_1'>  <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> US <!--{/if}-->  </span>
                <span class='spans_2'>&nbsp;</span>
                
            </div>
            <div class='con_left clear'>
    
                    <p class='p1'>
                        FRom:<br/>
                        &nbsp;&nbsp;北京市朝阳区万红
                        路5号蓝涛中心A101<br/>
                        &nbsp;&nbsp;北京国际邮电局集
                        中收寄网店<br/>
                    </p>
                    <p class='p2'>
                        北京燕文物流有限公<br/>
                        司(11010502740000)<br/>
                    </p>
                    <p class='p3'>
                        自编号：<br/>
                        &nbsp;&nbsp;<!--{$smarty.now|date_format:'%Y-%m-%d'}-->&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> <br/>
                    </p>
            
            </div>
            
            <div class='con_right clear' >
        
                    <p class='p1'>
                        SHIP TO:<br/>
                        <!--{$order.consignee}--><br/>
                        <!--{$order.street1}-->  <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}--><br/>
                    </p>
                    <p class='p2' >
                        phone:<!--{$order.tel}--> &nbsp;<!--{$order.Cncountry}-->
                    </p>
            </div>
        </div>
        
        <div class='con_center clear'>
                <div class='cen_s1'>untracked</div>
                <div class='cen_s2'>
                    <div style="text-align:center;">
                    <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"/>
                    </div>
                </div>
        </div>
        
        <div class='con_foot clear'>
            <div class='down_s clear down'>
                <div class='foot_s1 foot_w'>
                    <p>description of contents</p>
                </div>
                <div class='foot_s foot_w'>
                    <p>kg</p>
                </div>
                <div class='foot_s foot_q'>
                    <p>vals(USD $)</p>
                </div>
            </div>
            
            <div class='down_s2 clear down'>
                <div class='foot_s1 foot_w'>
                    <p>
                        CASE
                    </p>
                </div>
                <div class='foot_s foot_w'>
                    <p>0.05</p>
                </div>
                <div class='foot_s foot_q'>
                    <p>3</p>
                </div>
            </div>

            
            <div class='down_s clear down'>
                <div class='foot_s1 foot_w'>
                    <p>Total Gross Weight(Kg)</p>
                </div>
                <div class='foot_s foot_w'>
                    <p>0.05</p>
                </div>
                <div class='foot_s foot_q'>
                    <p>3</p>
                </div>
            </div>
            <div class='con_foot_down'>
                <p class='p1'>
                    I certify that particulars given in this declaration are correct and this item does not contain any dangerous articles prohi bited by legislation or by postal or customers regulations. 
                </p>
                <p class='p2'>
                    Sender`s signiture& Data Signed: 100000  <b><!--{$order.yw_no}--></b> <b>CN22</b>
                </P>
                <div class="coding" >
                <p><!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                <!--{/foreach}--> 
                </p>
                </div>
            </div>

        </div>
            
</div>
<!--{/foreach}-->


<!--{elseif $type eq 223}--><!--中国邮政平常小包10*10-->
<style>
    .clear:after{content:'.';display:block;height:0;visibility:hidden;clear:both;}
    .clear{zoom:1;}
    *{padding:0;margin:0;font-size:12px;}
    img,td{border:0;}
    table.table{width:380px;border:2px solid #000;}
    tr.header{height:230px;}
    td.header_left{width:146px;word-break:break-all;word-wrap:break-word;overflow:hidden;}
    div.header_left_top{height:193px;border-bottom:2px solid #000;margin-top:2px;}
    div.header_left_top_title{height:14px;font-weight:bold;padding-left:12px;}
    div.header_left_top_country{width:43px;height:20px;border:2px solid #000;margin:2px auto auto 46px;text-align:center;line-height:20px;font-size:20px;}
    div.header_left_top_from{padding:0 5px;line-height:10px;font-size:10px;}
    div.header_left_top_from_content{padding-left:2px;}
    div.header_left_top_phone{padding-left:2px;font-size:12px;line-height:14px;font-weight:bold;height:30px;}
    div.header_left_bottom{height:34px;padding-bottom:1px;border-bottom:2px solid #000;font-size:12px;padding-left:5px;}
    td.header_right{width:230px;word-break:break-all;word-wrap:break-word;overflow:hidden;}
    div.header_right_top{height:65px;border-bottom:2px solid #000;line-height:12px;width:230px;}

    div.header_right_top_type{font-weight:bold;}
    div.header_right_bottom{height:156px;border-bottom:2px solid #000;border-left:2px solid #000;padding:5px 2px 0;}
    div.header_right_bottom_ship{}
    div.header_right_bottom_ship_content{font-size:16px;line-height:14px;font-weight:bold;padding:2px 4px 2px 2px;}
    div.header_right_bottom_phoneaddr_phone{float:left;font-size:14px;line-height:16px;font-weight:bold;}
    div.header_right_bottom_phoneaddr_addr{float:right;font-size:14px;line-height:16px;font-weight:bold;}
    span.header_right_bottom_phoneaddr_phone_content{font-size:10px;}
    tr.content_top{height:16px;line-height:16px;text-align:center;}
    
    tr.content_center{height:16px;line-height:16px;text-align:center;}
    tr.content_bottom{height:16px;line-height:16px;text-align:center;}
    .content_bottom div{padding-left:5px;}
    td.left{width:242px;border-bottom:2px solid #000;}
    td.center{width:64px;border-bottom:2px solid #000;border-left:2px solid #000;}
    td.right{width:66px;border-bottom:2px solid #000;border-left:2px solid #000;}
    div.footer_top{line-height:10px;font-size:10px;padding:2px;vertical-align:top;}
    
    div.footer_bottom{font-weight:bold;font-size:12px;line-height:14px;}
    div.footer_bottom_left{float:left;padding-left:2px;}
    div.footer_bottom_right{float:right;font-size:16px;margin-right:60px;}
    .coding {line-height:12px;font-size:12px;padding:3px;border-top:2px solid #000;}
</style>

        <!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div style='margin-bottom:10px;' class="pagebreak">
    <table class="table" cellpadding='0' cellspacing='0' >
        <tr class='header'>
            <td class="header_left">
                <div class="header_left_top">
                    <div class="header_left_top_logo"><img src="themes/default/images/express/ccpost.jpg" alt="" /></div>
                    <div class="header_left_top_title" style='font-size:10px;'>Small Packet BY AIR</div>
                    <div class="header_left_top_country"> <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> CA <!--{/if}--> </div>
                    <div class="header_left_top_from">
                        From:
                        <div class="header_left_top_from_content" style='font-size:10px;line-height:9px;'>
                            ROOM 409,4TH FLOOR,<br/>
                            YAXING BUILDING,<br/>
                            MINLE SCIENCE PARK,<br/>
                            MINZHI STREET,<br/>
                            LONGHUA NEW DISTRICT,<br/>
                            SHENZHEN CITY,<br/>
                            GUANGDONG PROVINCE,<br/>
                            518000 CHINA
                        </div>
                    </div>    
                    <div class="header_left_top_phone">
                        Phone:<span>86-8618688751614</span>
                    </div>                        
                </div>
                <div class="header_left_bottom">中邮深圳仓<br/><!--{$smarty.now|date_format:'%Y-%m-%d'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></div>
            </td>
            <td class="header_right" colspan="3">
                <div class="header_right_top">
                    <div style="text-align:center;margin-top:4px;height:50px;"> <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"/> </div>
                    <div class="header_right_top_type" style='margin:2px 0 0;padding:0;'>untracked 平小包</div>
                </div>
                <div class="header_right_bottom" >
                    <div class="header_right_bottom_ship" >
                        <b>Ship to:</b>
                        <div class="header_right_bottom_ship_content">
                        <!--{$order.consignee}--><br/>
                        <!--{$order.street1}--> <!--{$order.street2}--><br/>
                        <!--{$order.city}-->,<!--{$order.state}--><br/>
                        <!--{$order.zipcode}--><br/>
                        <!--{$order.country}-->
                        </div>
                    </div>
                    <div class="header_right_bottom_phoneaddr clear" >
                        <div class="header_right_bottom_phoneaddr_phone">
                            Phone:<span class="header_right_bottom_phoneaddr_phone_content" style='font-size:14px;'> <!--{$order.tel}--> </span>
                        </div>
                        <div class="header_right_bottom_phoneaddr_addr"><!--{$order.Cncountry}--> 5</div>
                    </div>
                </div>
            </td>
        </tr>
        <tr class="content_top">
            <td class="left" colspan="2">
                <div class="content_top_left">Description Of Contents</div>
            </td>
            <td class="center">
                <div class="content_top_center">kg.</div>
            </td>
            <td class="right">
                <div class="content_top_right" style='font-size:10px;'>Vals(USD $)</div>
            </td>
        </tr>
        
        <tr class="content_center">
            <td class="left" colspan="2">
                <div class="content_center_left">                        
                    CASE
                </div>
            </td>
            <td class="center">
                <div class="content_center_center">0.05</div>
            </td>
            <td class="right">
                <div class="content_center_right">3</div>
            </td>
        </tr>
        
        <tr class="content_bottom">
            <td class="left" colspan="2">
                <div class="content_bottom_left">Total Gross Weight(Kg)</div>
            </td>
            <td class="center">
                <div class="content_bottom_center">0.05</div>
            </td>
            <td class="right">
                <div class="content_bottom_right">3</div>
            </td>
        </tr>
        <tr class="footer" style='height:40px;'>
            <td colspan="4">
                <div class="footer_top">
                    I certify that the particulars given in this declaration are correct and this item does not contain any dangerous articles prohibited by legislation or by postal or customers regulations.
                </div>
                <div class="footer_bottom clear">
                    <div class="footer_bottom_left">Sender's signitured Date Signed:</div>
                    <div class="footer_bottom_right">CN22</div>
                </div>
            </td>
        </tr>
        <tr><td colspan='4'>
                <div class="coding" >
                    <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                    <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                    <!--{/foreach}--> 
                </div>
        </td></tr>
    </table>
    </div>
    <!--{/foreach}-->
 
 <!--{elseif $type eq 230}--><!--DHL小包（10*10）-->
 
         <style>
            *{margin:0;padding:0;}
            .clear:after{height:0;content:'.';visibility:hidden;clear:both;display:block;}
            .clear{zoom:1;}
            
            /* 1 */
            #order_1{width:380px;border:2px solid #231916;margin-bottom:6px;}
            #order_1 .header{width:340px;height:110px;border:1px solid #231916;margin:5px auto;}
            #order_1 .header .header_h{border-bottom:1px solid #231916;font-size:16px;font-weight:bold;height:26px;line-height:26px;text-align:center;}
            #order_1 .header .header_t_l,#order_1 .header_t_r{float:left;width:169px;height:84px;}
            #order_1 .header .header_t_l{border-right:1px solid #231916;}
            #order_1 .header .header_t_l .p1,.header .header_t_l .p2{font-size:14px;line-height:15px;padding-left:4px;}
            #order_1 .header .header_t_l .p2{font-weight:bold;}
            #order_1 .header .header_t_r .p3{border-bottom:1px solid #231916;font-size:12px;font-weight:bold;padding-left:4px;line-height:14px;}
            #order_1 .header .header_t_r .p4{border-bottom:1px solid #231916;font-size:14px;padding-left:4px;line-height:14px;}
            
            #order_1 .center{height:90px;width:340px;margin:0 auto;}
            #order_1 .center .center_h p{font-size:14px;}
            
            #order_1 .footer{width:340px;margin:0 auto;min-height:150px;}
            #order_1 .footer .p1{font-size:18px;font-weight:bold;line-height:16px;}
            #order_1 .footer .p2{font-size:14px;padding-top:4px;}
            
            /* 2 */
            #order_2{width:380px;height:370px;border:2px solid #231916;overflow:hidden;margin-bottom:6px;}
            #order_2 .header_1{height:30px;padding:5px 2px;border-bottom:1px solid #231916;}
            #order_2 .header_1 .h{font-size:14px;font-weight:bold;}    
            #order_2 .header_1 .t{font-size:11px;}
            #order_2 .header_2{border-bottom:1px solid #231916;height:52px;}
            #order_2 .header_2 .h,#order_2 .header_2 .t{height:26px;line-height:26px;font-size:12px;}
            #order_2 .header_2 span{display:inline-block;}
            #order_2 .header_2 .span1{width:130px;padding-left:10px;}
            
            #order_2 .tab{width:380px;height:282px;}
            #order_2 .tr1{font-size:12px;}
            #order_2 .tr2 td{font-size:18px;font-weight:bold;border-bottom:1px solid #231916;height:60px;vertical-align:Top;}
            #order_2 .tr3 td,#order_2 .tr4 td{font-size:14px;border-bottom:1px solid #231916;border-right:1px solid #231916;text-align:center;}
            #order_2 .tr4 td{font-weight:bold;}
            #order_2 .tr5 td{border-bottom:1px solid #231916;font-size:14px;line-height:14px;}
            #order_2 .tr6 td{font-size:14px;}
            
        </style>
        
                <!--{foreach from =$orders item = order name=orderitem key=key}-->
        <div id='order_1'>
            <div class='header'>
                <div class='header_h'>PRIORITAIRE</div>
                <div class='header_t clear'>
                    <div class='header_t_l'>
                        <p class='p1'>
                            En cas de non remise<br/>
                            priere de retoumer a
                        </p>
                        <p class='p2'>
                            Postfach 2007<br/>
                            36243 Niedraula<br/>
                            ALLEMAGNE
                        </p>
                    </div>
                    <div class='header_t_r'>
                        <p class='p3'>Deutsche Post</P>
                        <p class='p4'>
                            <b>Port pave</b><br/>
                            60544 Frankfurt<br/>
                            Allemaqne            
                        </p>
                        <p class='p5' style='font-size:12px;padding-left:4px;line-height:14px;'>Lutpost/Prioritaire</p>
                    </div>
                </div>
            </div>
            
            <div class='center'>
                <div class='center_h'>
                    <p>PACKET PLUS</p>
                    <p>STANDARD</p>
                </div>
                <div class='center_t' style='position:relative;'>
                    <b style='font-size:38px;position:absolute;top:0;left:20px;'>R</b> 
                    <div style='text-align:center;'>
                        <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"/>
                    </div>
                    
                </div>
            </div>
            
            <div class='footer'>
                <p class='p1'>
                    <!--{$order.tel}--><br/>
                    <!--{$order.consignee}--><br/>
                    <!--{$order.street1}--> <!--{$order.street2}--><br/>
                    <!--{$order.city}-->,<!--{$order.state}--><br/>
                    <!--{$order.zipcode}--><br/>
                    <!--{$order.country}-->
                </p>
                <br>
                <hr>
                
                <p class='p2'>
                    <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                    <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                    <!--{/foreach}-->
                </p>
            </div>
            
        </div>
      <div class="pagebreak"></div>
        <div id='order_2' >
            <div class='header_1'>
                <div class='h'>
                    <span>CUSTOMS DECLARATION</span>
                    <span style='margin-left:100px;'>CN22</span>
                </div>
                <div class='t'>
                    <span>Postal Administration(May be opened officially)</span>
                    <span >important</span>
                </div>
            </div>
            <div class='header_2'>
                <div class='h'>
                    <span class='span1'><input type='checkbox' value=''/> Gift</span>
                    <span><input type='checkbox' value=''/> Sample</span>
                </div>
                <div class='t'>
                    <span class='span1'><input type='checkbox' value=''/> Printed Matter</span>
                    <span><input type='checkbox' checked='checked' value=''/> Other(Tick as appropriate)</span>
                </div>
            </div>
            
            <table cellspacing='0' cellpadding='0' class='tab' style='overflow:hidden;'>
                <tr class='tr1'>
                    <td colspan='2' style='border-right:1px solid #231916;'>
                        Detailed description of contents
                    </td>
                    <td style='width:80px;text-align:center;'>
                        Value
                    </td>
                </tr>
                <tr class='tr2'>
                    <td colspan='2' style='border-right:1px solid #231916'>
                            Case * 1
                    </td>
                    <td style='text-align:center;'>
                        USD $1
                    </td>
                </tr>
                <tr class='tr3'>
                    <td>Origin countery</td>
                    <td>Total Weight(kg)</td>
                    <td style='border-right:none;'>Total Value</td>
                </tr>
                <tr class='tr4'>
                    <td>CN</td>
                    <td>0.03</td>
                    <td style='border-right:none;'>USD $1</td>
                </tr>
                <tr class='tr5'>
                    <td colspan='3'>
                        I,ter undersigned,certify that the particulars given in this declaraation are correct and this item does not containay dangerous articles prohibited by legislation or by postal or customers requlations,
                    </td>
                </tr>
                <tr class='tr6'>
                    <td colspan='2'>
                        Date and Sender`s signiture:<br/>
                        <b><!--{$smarty.now|date_format:'%m-%d-%Y'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></b>
                    </td>
                    <td><b>DZMY</b></td>
                </tr>
            </table>       
        </div>
     <div class="pagebreak"></div>
    <!--{/foreach}-->

  <!--{elseif $type eq 231}--><!--DHL小包2（10*10）-->
 
         <style>
            *{margin:0;padding:0;}
            .clear:after{height:0;content:'.';visibility:hidden;clear:both;display:block;}
            .clear{zoom:1;}
            
            /* 1 */
            #order_1{width:380px;border:2px solid #231916;}
            #order_1 .header{width:340px;height:110px;border:1px solid #231916;margin:5px auto;text-align:center;}
            #order_1 .header .header_h{border-bottom:1px solid #231916;font-size:16px;font-weight:bold;height:26px;line-height:26px;}
            #order_1 .header .header_t_l,#order_1 .header_t_r{float:left;width:169px;height:84px;}
            #order_1 .header .header_t_l{border-right:1px solid #231916;}
            #order_1 .header .header_t_l .p1,.header .header_t_l .p2{font-size:14px;}
            #order_1 .header .header_t_l .p2{font-weight:bold;}
            #order_1 .header .header_t_r .p3{border-bottom:1px solid #231916;font-size:12px;font-weight:bold;height:28px;}
            #order_1 .header .header_t_r .p4{font-size:14px;}
            
            #order_1 .center{height:40px;width:340px;margin:0 auto;}
            #order_1 .center .center_h p{font-size:14px;}
            
            #order_1 .footer{width:340px;margin:0 auto;min-height:150px;}
            #order_1 .footer .p1{font-size:18px;font-weight:bold;line-height:16px;}
            #order_1 .footer .p2{font-size:14px;padding-top:4px;}
            
            /* 2 */
            #order_2{width:360px;height:310px;border:2px solid #231916;overflow:hidden;margin-top:4px;}
            #order_2 .header_1{height:30px;padding:5px 2px;border-bottom:1px solid #231916;}
            #order_2 .header_1 .h{font-size:14px;font-weight:bold;}    
            #order_2 .header_1 .t{font-size:10px;}
            #order_2 .header_2{border-bottom:1px solid #231916;height:52px;}
            #order_2 .header_2 .h,#order_2 .header_2 .t{height:26px;line-height:26px;font-size:12px;}
            #order_2 .header_2 span{display:inline-block;}
            #order_2 .header_2 .span1{width:130px;padding-left:10px;}
            
            #order_2 .tab{width:360px;height:210px;}
            #order_2 .tr1{font-size:12px;}
            #order_2 .tr2 td{font-size:18px;font-weight:bold;border-bottom:1px solid #231916;height:20px;vertical-align:Top;}
            #order_2 .tr3 td,#order_2 .tr4 td{font-size:14px;border-bottom:1px solid #231916;border-right:1px solid #231916;text-align:center;}
            #order_2 .tr4 td{font-weight:bold;}
            #order_2 .tr5 td{border-bottom:1px solid #231916;font-size:12px;line-height:10px;height:60px;}
            #order_2 .tr6 td{font-size:14px;}
            
        </style>
        
    <!--{foreach from =$orders item = order name=orderitem key=key}-->
         <div style='margin-bottom:10px;' class="pagebreak">
        <div id='order_1'>
            <div class='header'>
                <div class='header_h'>PRIORITAIRE</div>
                <div class='header_t clear'>
                    <div class='header_t_l'>
                        <p class='p1'>
                            Wenn unzustellbar,<br/>
                            zuruck an
                        </p>
                        <p class='p2'>
                            Postfach 2007<br/>
                            36243 Niedraula<br/>
                        </p>
                    </div>
                    <div class='header_t_r'>
                        <p class='p3'>Deutsche Post</P>
                        <p class='p4'>
                            <b>Entgelt bezahlt</b><br/>
                            60544 Frankfurt<br/>
                            (2378)           
                        </p>
                    </div>
                </div>
            </div>
            
            <div class='center'>
                <div class='center_h'>
                    <p>PACKET PLUS</p>
                    <p>STANDARD</p>
                </div>

            </div>
            
            <div class='footer'>
                <p class='p1'>
                    <!--{$order.tel}--><br/>
                    <!--{$order.consignee}--><br/>
                    <!--{$order.street1}--> <!--{$order.street2}--><br/>
                    <!--{$order.city}-->,<!--{$order.state}--><br/>
                    <!--{$order.zipcode}--><br/>
                    <!--{$order.country}-->
                </p>
                
                <br>
                <hr>
                
                <p class='p2'>
                    <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                    <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                    <!--{/foreach}-->
                </p>
            </div>
            
        </div>
        </div>

<div style='margin-bottom:10px;border:2px solid #666;height:374px;width:370px;padding:0 5px;' class="pagebreak">
    
    
<div class='code_sn' style='padding:5px;'>
                <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"/>
</div>
<div id='order_2'>        
    <div class='header_1'>
        <div class='h'>
            <span>CUSTOMS DECLARATION</span>
            <span style='margin-left:100px;'>CN22</span>
        </div>
        <div class='t'>
            <span>Postal Administration(May be opened officially)</span>
            <span>important</span>
        </div>
    </div>
    <div class='header_2'>
        <div class='h'>
            <span class='span1'><input type='checkbox' value=''/> Gift</span>
            <span><input type='checkbox' value=''/> Sample</span>
        </div>
        <div class='t'>
            <span class='span1'><input type='checkbox' value=''/> Printed Matter</span>
            <span><input type='checkbox' checked='checked' value=''/> Other(Tick as appropriate)</span>
        </div>
    </div>
    
    <table cellspacing='0' cellpadding='0' class='tab'>
        <tr class='tr1'>
            <td colspan='2' style='border-right:1px solid #231916;'>
                Detailed description of contents
            </td>
            <td style='width:80px;text-align:center;'>
                Value
            </td>
        </tr>
        <tr class='tr2'>
            <td colspan='2' style='border-right:1px solid #231916;text-align:center;'>
                    Case 
            </td>
            <td style='text-align:center;'>
                USD $1
            </td>
        </tr>
        <tr class='tr3'>
            <td>Origin countery</td>
            <td>Total Weight(kg)</td>
            <td style='border-right:none;'>Total Value</td>
        </tr>
        <tr class='tr4'>
            <td>CN</td>
            <td>0.03</td>
            <td style='border-right:none;'>USD $1</td>
        </tr>
        <tr class='tr5'>
            <td colspan='3'>
                I,ter undersigned,certify that the particulars given in this declaraation are correct and this item does not containay dangerous articles prohibited by legislation or by postal or customers requlations,
            </td>
        </tr>
        <tr class='tr6'>
            <td colspan='2'>
                Date and Sender`s signiture:<br/>
                <b><!--{$smarty.now|date_format:'%m-%d-%Y'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--> </b>
            </td>
            <td><b>ICE(GD)</b></td>
        </tr>
    </table>
    
</div>
</div>   

    <!--{/foreach}-->
    
 <!--{elseif $type eq 232}--><!--贝邮宝平邮（10*10）-->
        <style>
            *{margin:0;padding:0;}
        </style>
        
    <!--{foreach from =$orders item = order name=orderitem key=key}-->
        <div style='width:370px;border:2px solid #7E7E7E;margin-bottom:10px;' class="pagebreak">
            <div style='height:44px;padding:2px;border-bottom:2px solid #7E7E7E;'>
                <div style='float:left;width:156px;'>
                    <img src='themes/default/images/shell.png' style='width:120px;height:40px;'/>
                </div>
                <div style='float:left;width:110px;font-size:12px;line-height:13px;padding-top:1px;'>
                    <p style='text-indent:2em;'><strong>航&nbsp;空</strong></p>
                    <p><strong>Small&nbsp;Packet</strong></p>
                    <p style='text-indent:2em;'>BY&nbsp;ALR</p>
                </div>
                <div style='float:left;width:96px;text-align:right;font-size:14px;line-height:44px;padding-right:4px;'>
                    <p><strong>  <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> DK <!--{/if}-->  <!--{$order.Cncountry}--></strong></p>
                </div>
            </div>
            
            <table cellpadding='0' cellspacing='0' style='width:370px;height:320px;'>
                <tr>
                    <td style='width:64px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;'>协 &nbsp;客户:</td>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;line-height:14px;padding-left:2px'>
                    <strong>北京京腾</strong>
                    一诺科技有限公司(11010503959000)
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:12px;line-height:12px;padding-left:4px;height:50px;'><strong>From:</strong></td>
                    <td style='font-size:12px;border-bottom:2px solid #7E7E7E;line-height:12px;padding:2px 2px 2px 4px;height:50px;'>
                        <strong>
                            Liuyuanzhi<br/>
                            ROOM 409,4TH FLOOR,YAXING BUILDING,MINLE SCIENCE PARK,MINZHI STREET,LO
                            NGHUA NEW DISTRICT,Shenzhen,Guangdongddd,China
                        </strong>
                    </td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;height:14px;'><b>Zip:</b></td>
                    <td>
                        <span style='display:block;width:118px;height:14px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;float:left;'></span>
                        <span style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;height:14px;line-height:14px;width:64px;padding-left:4px;display:block;float:left;'><b>Tel:</b></span>
                        <span style='width:106px;padding-left:4px;display:block;border-bottom:2px solid #7E7E7E;float:left;height:14px;line-height:14px;font-size:10px;'><b>30116962</b></span>
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:12px;line-height:12px;padding-left:4px;height:80px;'><strong>TO:</strong></td>
                    <td style='font-size:15px;border-bottom:2px solid #7E7E7E;line-height:12px;padding:2px 2px 2px 4px;height:80px;line-height:16px;'>
                        <strong>

                            <!--{$order.consignee}--><br/>
                            <!--{$order.street1}--> <!--{$order.street2}--><br/>
                            <!--{$order.city}-->,<!--{$order.state}--><br/>

                            <!--{$order.country}-->
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;height:14px;'><b>Zip:</b></td>
                    <td>
                        <span style='display:block;width:114px;height:14px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;float:left;font-size:10px;padding-left:4px;line-height:14px;'><b> <!--{$order.zipcode}--></b></span>
                        <span style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;height:14px;line-height:14px;width:64px;padding-left:4px;display:block;float:left;'><b>Tel:</b></span>
                        <span style='width:106px;padding-left:4px;display:block;border-bottom:2px solid #7E7E7E;float:left;height:14px;line-height:14px;font-size:10px;'><b><!--{$order.tel}--></b></span>
                    </td>
                </tr>
                <tr>
                    <td style='width:64px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;'>退件单位:</td>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;line-height:14px;padding-left:2px'>
                    <strong>北京国际</strong>
                    邮电局集中收集网点
                    </td>
                </tr>
                <tr>
                    <td colspan='2' style='height:50px;border-bottom:2px solid #7E7E7E;'>
                        <div style='float:left;width:100px;text-align:center;'>
                            <p style='font-size:14px;'>
                                NO<br/>
                                TRACKING
                            </p>
                        </div>
                        <div style='float:left;text-align:center;'>
                            <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=2&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=15&start=NULL&code=BCGcode128"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style='width:64px;border-right:2px solid #7E7E7E;font-size:10px;line-height:12px;padding-left:4px;height:36px;'>客户自编号:</td>
                    <td style='font-size:10px;line-height:12px;padding-left:2px;min-height:60px;'>
                        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                        <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        <!--{/foreach}-->
                    </td>
                </tr>
            </table>
                
        </div>
        
    
        <div style='width:370px;height:370px;border:2px solid #7E7E7E;margin-bottom:10px;overflow:hidden;' class="pagebreak">
            <div style='height:44px;padding:2px;border-bottom:2px solid #7E7E7E;'>
                <div style='float:left;width:116px;'>
                    <img src='themes/default/images/express/ccpost.jpg' style='width:100px;height:40px;'/>
                </div>
                <div style='float:left;width:150px;text-align:center;'>
                    <p style='font-size:16px;line-height:30px;'><strong>报关签条</strong></p>
                    <p style='font-size:10px;line-height:14px;'><strong>CUSTOMS DECLARATION</strong></p>
                </div>
                <div style='float:left;width:96px;text-align:right;font-size:11px;font-weight:bold;padding-right:4px;'>
                    <p style='height:30px;'><strong>邮 &nbsp;2113</strong></p>
                    <p style='height:14px;'><strong>CN22</strong></p>
                </div>
            </div>
            
            <table cellspacing='0' cellpadding='0' style='width:370px;height:320px;' border='0'>
                <tr>
                    <td style='border-right:2px solid #7E7E7E;font-size:12px;line-height:14px;padding-left:2px'>可以径行开</td>
                    <td style='font-size:10px;line-height:14px;padding-left:4px;font-weight:bold;'>May be opened officially</td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:50px;'>
                        <p style='width:150px;font-size:10px;text-align:center;float:left;line-height:16px;'>
                            邮件种类<br/>
                            Calegory of item<br/>
                            (在适当的文字前划"×")<br/>
                        </p>
                        <div style='height:50px;float:left;border-left:2px solid #7E7E7E;'>
                            <p style='border-bottom:2px solid #7E7E7E;height:24px;width:31px;font-size:10px;color:#666;line-height:24px;text-align:center;'>×</p>
                            <p></p>
                        </div>
                    </td>
                    <td style='width:185px;'>
                        <table style='width:185px;text-align:center;height:52px;'  cellspacing='0' cellpadding='0'>
                            <tr>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;border-top:2px solid #7E7E7E;height:26px;width:80px;'>
                                    <p>礼品</p>
                                    <p><b>Gift</b></p>
                                </td>
                                <td style='border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;border-right:2px solid #7E7E7E;'></td>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;padding:0px 10px;height:24px;'>
                                    <p>商品货样</p>
                                    <p><b>Commercial</b></p>
                                </td>
                            </tr>
                            <tr>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:26px;'>
                                    <p>文件</p>
                                    <p><b>Documents</b></p>
                                </td>
                                <td style='width:24px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;'></td>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;'>
                                    <p>其他</p>
                                    <p><b>Other</b></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style='overflow:hidden;'>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:10px;height:30px;padding:2px 2px 2px 4px;'>
                        <p>内件详细名称和数量</p>
                        <p>Quantity and detailed detailed description of</p>
                    </td>
                    <td style='height:34px;'>
                        <div style='float:left;font-size:10px;line-height:15px;border-right:2px solid #7E7E7E;border-bottom:2px solid #7E7E7E;height:34px;width:79px;text-align:center;'>
                            <p>重量(千克)</p>
                            <p>Weight（KG）</p>
                        </div>
                        <div style='float:left;font-size:10px;line-height:15px;border-bottom:2px solid #7E7E7E;height:34px;width:104px;text-align:center;'>
                            <p>价值</p>
                            <p>Value</p>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;text-align:center;vertical-align:top;font-size:18px;height:62px;'>
                        <p><strong>Case * 1</strong></p>
                    </td>
                    <td style='width:185px;height:62px;'>
                        <table style='width:185px;height:62px;'
                             cellspacing='0' cellpadding='0' border='0'>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:14px;font-size:12px;text-align:center;width:79px;'>1.000</td>
                                <td style='border-bottom:2px solid #7E7E7E;height:14px;font-size:12px;text-align:center;'>1.00</td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:10px;height:40px;padding:2px 2px 2px 4px;'>
                        <p>
                            协调系统税则号列和货物原产国(只对商品邮件填写)
                            HS tariff number and country of origin of goods(Fro commercial ite
                            ms only)
                        </p>
                        
                    </td>
                    <td style='height:44px;'>
                        <div style='float:left;font-size:10px;border-right:2px solid #7E7E7E;border-bottom:2px solid #7E7E7E;height:44px;width:79px;text-align:center;line-height:14px;'>
                            <p>重量(千克)</p>
                            <p>Total </p>
                            <p>weight（KG）</p>
                        </div>
                        <div style='float:left;font-size:10px;border-bottom:2px solid #7E7E7E;height:44px;line-height:20px;width:104px;text-align:center;'>
                            <p>总价值</p>
                            <p>Total value</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style='font-size:12px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:18px;padding-left:4px;height:20px;'>
                        China
                    </td>
                    <td style='border-bottom:2px solid #7E7E7E;height:20px;'>
                        <div style='float:left;font-size:12px;border-right:2px solid #7E7E7E;width:79px;text-align:center;line-height:20px;height:20px;'>
                            <p>1.000</p>
                        
                        </div>
                        <div style='float:left;font-size:12px;width:104px;text-align:center;line-height:20px;height:20px;'>
                            <p>1.00</p>
                        
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan='2' style='font-size:10px;line-height:10px;border-bottom:2px solid #7E7E7E;padding:2px 2px 2px 4px;height:54px;'>
                        我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品
                        I,the undersigned,certify that the particulars given in this declaraton are correct and this item does not contain any dangerous articles prohibited by lagislation or by postal or custome regulations.
                        寄件人签字 Sender′s signature_____________
                    </td>
                    
                </tr>
                <tr>
                    <td  style='font-size:10px;line-height:12px;border-right:2px solid #7E7E7E;padding-left:4px;;height:28px;vertical-align:top;'>
                        <p>Label Creation Date</p>
                        <p><b><!--{$smarty.now|date_format:'%m-%d-%Y'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></b></p>
                    </td>
                    <td  style='font-size:8px;line-height:12px;padding-left:2px;heigh:28px;vertical-align:top;'>
                        <p>货物已寄递标识</p>
                        <p>Goods Delivery Concerns Identified</p>
                    </td>
                </tr>
            </table>
        </div>
    <!--{/foreach}-->        

  <!--{elseif $type eq 233}--><!--贝邮宝挂号（10*10）-->
        <style>
            *{margin:0;padding:0;}
        </style>
        
    <!--{foreach from =$orders item = order name=orderitem key=key}-->
        <div style='width:370px;border:2px solid #7E7E7E;margin-bottom:10px;' class="pagebreak">
            <div style='height:44px;padding:2px;border-bottom:2px solid #7E7E7E;'>
                <div style='float:left;width:146px;'>
                    <img src='themes/default/images/shell.png' style='width:120px;height:40px;'/>
                </div>
                <div style='float:left;width:90px;font-size:12px;line-height:13px;padding-top:1px;'>
                    <p style='text-indent:2em;'><strong>航&nbsp;空</strong></p>
                    <p><strong>Small&nbsp;Packet</strong></p>
                    <p style='text-indent:2em;'>BY&nbsp;ALR</p>
                </div>
                <div style='float:left;width:126px;text-align:right;font-size:12px;line-height:44px;padding-right:4px;'>
                    <p><strong>  <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> DK <!--{/if}-->  <!--{$order.Cncountry}-->(EKA大)</strong></p>
                </div>
            </div>
            
            <table cellpadding='0' cellspacing='0' style='width:370px;height:320px;'>
                <tr>
                    <td style='width:64px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;'>协 &nbsp;客户:</td>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;line-height:14px;padding-left:2px'>
                    <strong>北京京腾</strong>
                    一诺科技有限公司(11010503959000)
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:12px;line-height:12px;padding-left:4px;height:50px;'><strong>From:</strong></td>
                    <td style='font-size:12px;border-bottom:2px solid #7E7E7E;line-height:12px;padding:2px 2px 2px 4px;height:50px;'>
                        <strong>
                            Liuyuanzhi<br/>
                            ROOM 409,4TH FLOOR,YAXING BUILDING,MINLE SCIENCE PARK,MINZHI STREET,LO
                            NGHUA NEW DISTRICT,Shenzhen,Guangdongddd,China
                        </strong>
                    </td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;height:14px;'><b>Zip:</b></td>
                    <td>
                        <span style='display:block;width:118px;height:14px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;float:left;'></span>
                        <span style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;height:14px;line-height:14px;width:64px;padding-left:4px;display:block;float:left;'><b>Tel:</b></span>
                        <span style='width:106px;padding-left:4px;display:block;border-bottom:2px solid #7E7E7E;float:left;height:14px;line-height:14px;font-size:10px;'><b>86-18688751614</b></span>
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:12px;line-height:12px;padding-left:4px;height:80px;'><strong>TO:</strong></td>
                    <td style='font-size:15px;border-bottom:2px solid #7E7E7E;line-height:12px;padding:2px 2px 2px 4px;height:80px;line-height:16px;'>
                        <strong>

                            <!--{$order.consignee}--><br/>
                            <!--{$order.street1}--> <!--{$order.street2}--><br/>
                            <!--{$order.city}-->,<!--{$order.state}--><br/>

                            <!--{$order.country}-->
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;height:14px;'><b>Zip:</b></td>
                    <td>
                        <span style='display:block;width:114px;height:14px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;float:left;font-size:10px;padding-left:4px;line-height:14px;'><b> <!--{$order.zipcode}--></b></span>
                        <span style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;height:14px;line-height:14px;width:64px;padding-left:4px;display:block;float:left;'><b>Tel:</b></span>
                        <span style='width:106px;padding-left:4px;display:block;border-bottom:2px solid #7E7E7E;float:left;height:14px;line-height:14px;font-size:10px;'><b><!--{$order.tel}--></b></span>
                    </td>
                </tr>
                <tr>
                    <td style='width:64px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;font-size:10px;line-height:14px;padding-left:4px;'>退件单位:</td>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;line-height:14px;padding-left:2px'>
                    <strong>北京国际</strong>
                    邮电局集中收集网点
                    </td>
                </tr>
                <tr>
                    <td colspan='2' style='height:50px;border-bottom:2px solid #7E7E7E;'>
                        <div style='float:left;text-align:center;'>
                            <p style='font-size:26px;border:3px solid #000;border-radius:50%;width:28px;height:28px;font-weight:bold;margin-left:55px;margin-top:2px;margin-right:12px;line-height:30px;'>
                                R
                            </p>
                        </div>
                        <div style='float:left;text-align:center;'>
                            <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=2&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=15&start=NULL&code=BCGcode128"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style='width:64px;border-right:2px solid #7E7E7E;font-size:10px;line-height:12px;padding-left:4px;height:36px;'>客户自编号:</td>
                    <td style='font-size:10px;line-height:12px;padding-left:2px;min-height:60px;'>
                        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                        <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        <!--{/foreach}-->
                    </td>
                </tr>
            </table>
                
        </div>
        
    
        <div style='width:370px;height:370px;border:2px solid #7E7E7E;margin-bottom:10px;overflow:hidden;' class="pagebreak">
            <div style='height:44px;padding:2px;border-bottom:2px solid #7E7E7E;'>
                <div style='float:left;width:116px;'>
                    <img src='themes/default/images/express/ccpost.jpg' style='width:100px;height:40px;'/>
                </div>
                <div style='float:left;width:150px;text-align:center;'>
                    <p style='font-size:16px;line-height:30px;'><strong>报关签条</strong></p>
                    <p style='font-size:10px;line-height:14px;'><strong>CUSTOMS DECLARATION</strong></p>
                </div>
                <div style='float:left;width:96px;text-align:right;font-size:11px;font-weight:bold;padding-right:4px;'>
                    <p style='height:30px;'><strong>邮 &nbsp;2113</strong></p>
                    <p style='height:14px;'><strong>CN22</strong></p>
                </div>
            </div>
            
            <table cellspacing='0' cellpadding='0' style='width:370px;height:320px;' border='0'>
                <tr>
                    <td style='border-right:2px solid #7E7E7E;font-size:12px;line-height:14px;padding-left:2px'>可以径行开</td>
                    <td style='font-size:10px;line-height:14px;padding-left:4px;font-weight:bold;'>May be opened officially</td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:50px;'>
                        <p style='width:150px;font-size:10px;text-align:center;float:left;line-height:16px;'>
                            邮件种类<br/>
                            Calegory of item<br/>
                            (在适当的文字前划"×")<br/>
                        </p>
                        <div style='height:50px;float:left;border-left:2px solid #7E7E7E;'>
                            <p style='border-bottom:2px solid #7E7E7E;height:24px;width:31px;font-size:10px;color:#666;line-height:24px;text-align:center;'>×</p>
                            <p></p>
                        </div>
                    </td>
                    <td style='width:185px;'>
                        <table style='width:185px;text-align:center;height:52px;'  cellspacing='0' cellpadding='0'>
                            <tr>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;border-top:2px solid #7E7E7E;width:80px;height:26px;'>
                                    <p>礼品</p>
                                    <p><b>Gift</b></p>
                                </td>
                                <td style='border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;border-right:2px solid #7E7E7E;'></td>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-top:2px solid #7E7E7E;padding:0px 10px;height:24px;'>
                                    <p>商品货样</p>
                                    <p><b>Commercial</b></p>
                                </td>
                            </tr>
                            <tr>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:26px;'>
                                    <p>文件</p>
                                    <p><b>Documents</b></p>
                                </td>
                                <td style='width:24px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;'></td>
                                <td style='font-size:10px;border-bottom:2px solid #7E7E7E;'>
                                    <p>其他</p>
                                    <p><b>Other</b></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style='overflow:hidden;'>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:10px;height:30px;padding:2px 2px 2px 4px;'>
                        <p>内件详细名称和数量</p>
                        <p>Quantity and detailed detailed description of</p>
                    </td>
                    <td style='height:34px;'>
                        <div style='float:left;font-size:10px;line-height:15px;border-right:2px solid #7E7E7E;border-bottom:2px solid #7E7E7E;height:34px;width:79px;text-align:center;'>
                            <p>重量(千克)</p>
                            <p>Weight（KG）</p>
                        </div>
                        <div style='float:left;font-size:10px;line-height:15px;border-bottom:2px solid #7E7E7E;height:34px;width:104px;text-align:center;'>
                            <p>价值</p>
                            <p>Value</p>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;text-align:center;vertical-align:top;font-size:18px;height:62px;'>
                        <p><strong>Case * 1</strong></p>
                    </td>
                    <td style='width:185px;height:62px;'>
                        <table style='width:185px;height:62px;'
                             cellspacing='0' cellpadding='0' border='0'>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:14px;font-size:12px;text-align:center;width:79px;'>1.000</td>
                                <td style='border-bottom:2px solid #7E7E7E;height:14px;font-size:12px;text-align:center;'>1.00</td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                            <tr>
                                <td style='border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;height:10px;'></td>
                                <td style='border-bottom:2px solid #7E7E7E;height:10px;'></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td style='font-size:10px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:10px;height:40px;padding:2px 2px 2px 4px;'>
                        <p>
                            协调系统税则号列和货物原产国(只对商品邮件填写)
                            HS tariff number and country of origin of goods(Fro commercial ite
                            ms only)
                        </p>
                        
                    </td>
                    <td style='height:44px;'>
                        <div style='float:left;font-size:10px;border-right:2px solid #7E7E7E;border-bottom:2px solid #7E7E7E;height:44px;width:79px;text-align:center;line-height:14px;'>
                            <p>重量(千克)</p>
                            <p>Total </p>
                            <p>weight（KG）</p>
                        </div>
                        <div style='float:left;font-size:10px;border-bottom:2px solid #7E7E7E;height:44px;line-height:20px;width:104px;text-align:center;'>
                            <p>总价值</p>
                            <p>Total value</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style='font-size:12px;border-bottom:2px solid #7E7E7E;border-right:2px solid #7E7E7E;line-height:18px;padding-left:4px;height:20px;'>
                        China
                    </td>
                    <td style='border-bottom:2px solid #7E7E7E;height:20px;'>
                        <div style='float:left;font-size:12px;border-right:2px solid #7E7E7E;width:79px;text-align:center;line-height:20px;height:20px;'>
                            <p>1.000</p>
                        
                        </div>
                        <div style='float:left;font-size:12px;width:104px;text-align:center;line-height:20px;height:20px;'>
                            <p>1.00</p>
                        
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan='2' style='font-size:10px;line-height:10px;border-bottom:2px solid #7E7E7E;padding:2px 2px 2px 4px;height:54px;'>
                        我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品
                        I,the undersigned,certify that the particulars given in this declaraton are correct and this item does not contain any dangerous articles prohibited by lagislation or by postal or custome regulations.
                        寄件人签字 Sender′s signature_____________
                    </td>
                    
                </tr>
                <tr>
                    <td  style='font-size:10px;line-height:12px;border-right:2px solid #7E7E7E;padding-left:4px;;height:28px;vertical-align:top;'>
                        <p>Label Creation Date</p>
                        <p><b> <!--{$smarty.now|date_format:'%m-%d-%Y'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></b></p>
                    </td>
                    <td  style='font-size:8px;line-height:12px;padding-left:2px;height:28px;vertical-align:top;'>
                        <p>货物已寄递标识</p>
                        <p>Goods Delivery Concerns Identified</p>
                    </td>
                </tr>
            </table>
        </div>
    <!--{/foreach}-->  
 
        
<!--{elseif $type eq 234}--><!--芬兰邮政经济小包10*10-->
<!--{foreach from =$orders item = order name=orderitem key=key}-->
        <style>
            *{margin:0;padding:0;}
        </style>
            <div style='width:372px;border:2px solid #666;margin-bottom:10px;' class="pagebreak">
            <div style='position:relative;height:80px;border-bottom:2px solid #666;'>
                <span style='position:absolute;left:10px;top:4px;font-size:18px;font-weight:bold;'>发货标签</span>
                <div style='position:absolute;left:50px;top:25px;'>
                    <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=2&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=15&start=NULL&code=BCGcode128"/>
                </div>
            </div>
            
            <div style='height:170px;position:relative;border-bottom:2px solid #666;'>
                <span style='position:absolute;right:10px;top:2px;font-size:18px;font-weight:bold;'>  <!--{if $order.CountryCode}--> <!--{$order.CountryCode}--> <!--{else}--> BY <!--{/if}-->  </span>
                <div>
                    <p style='font-size:16px;font-weight:bold;padding:2px 4px;line-height:16px;'>
                        To: <!--{$order.consignee}--><br/>
                         <!--{$order.street1}--> <!--{$order.street2}--><br/>
                         <!--{$order.city}-->,<!--{$order.state}--><br/>
                         <!--{$order.country}--><br/>
                         Zip:<!--{$order.zipcode}-->
                         Tel:<!--{$order.tel}-->
                    </p>
                </div>
                <div>
                    <p style='font-size:12px;line-height:14px;font-weight:bold;padding:2px;'>
                        Shipping:芬兰邮政经济小包<br/>
                        Form:liuyuanzhi<br/>
                        Tel:0086-8618688751614
                    </p>
                </div>
            </div>
            
            <div style='position:relative;padding:2px 4px;'>
                <p style='font-size:12px;line-height:14px;'>
                    <strong>是否带电池:</strong>否<br/>
                    <strong>仓库:</strong>深圳市宝安区西乡街道水库路111号星宏科技园D栋一层（燕文深圳仓-itella平邮）
                </p>
                <span style='position:absolute;right:10px;top:2px;font-size:12px;'> <!--{$key+1}-->/<!--{$orders|@count}--></span>
                <p style='font-size:12px;line-height:12px;padding:2px 0px;min-height:36px;'>
                        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                        <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        <!--{/foreach}-->
                </p>
            </div>
        
        </div>
    
<!--{/foreach}-->  
 
 
 <!--{elseif $type eq 235}--><!--E特快10*10-->
<!--{foreach from =$orders item = order name=orderitem key=key}-->
        <style>
            *{margin:0;padding:0;}
        </style>
        <div style='width:370px;height:370px;border:2px solid #666;margin-bottom:10px;' class="pagebreak">
            <div style='position:relative;height:78px;border-bottom:2px solid #666;'>
                <span style='position:absolute;left:10px;top:4px;'>
                    <img src="themes/default/images/express.png"/ >
                    <p style='font-size:14px;margin-top:-4px;padding-left:5px;font-weight:bold;'>From</p>
                </span>
                <span style='position:absolute;left:85px;top:4px;'>
                    <img src="themes/default/images/middle.png"/>
                </span>
                <span style='width:90px;position:absolute;right:10px;top:10px;font-size:12px;line-height:12px;border:2px solid #666;padding:2px 0px 2px 8px;'>
                    Express Mail<br/>
                    Postage Paid<br/>
                    China Post
                </span>
            </div>
            
            <div style='height:72px;'>
                <div style='height:66px;width:192px;border-right:2px solid #666;border-bottom:2px solid #666;font-size:12px;line-height:13px;padding:2px 4px;float:left;'>
                    Zhang Sheng<br/>
                    ..<br/>
                    No3 Langshan 2nd Road, High-<br/>
                    SHENZHEN GUANGDONG<br/>
                    CHINA    <span style='float:right;'><!--{$key+1}-->/<!--{$orders|@count}--><span>
                </div>
                
                
                <div style="height:70px;width:168px;float:left;font-weight:bold;text-align:center;border-bottom:2px solid #666;">
                    <p style='font-size:14px;line-height:18px;border-bottom:2px solid #666;'>邮政互换局专栏
                    </p>
                    <p style="font-size:18px;line-height:24px;">
                    澳大利亚 2065 <br/>
                    参照EMS封发
                    </p>
                </div>
            </div>
            
            <table style="width:370px;height:218px;" border='0' cellpadding='0' cellspacing='0'>
                <tr>
                    <td style='border-right:2px solid #666;width:50px;font-size:18px;font-weight:bold;text-align:center;height:110px;'>TO:</td>
                    <td style="font-size:16px;line-height:16px;font-weight:bold;vertical-align:top;padding:2px 4px;height:116px;">
                       <!--{$order.consignee}--><br/>
                         <!--{$order.street1}--> <!--{$order.street2}--><br/>
                         <!--{$order.city}-->,<!--{$order.state}--><br/>
                         <!--{$order.country}--><br/>
                         Zip:<!--{$order.zipcode}-->
                         Tel:<!--{$order.tel}-->
                    </td>
                </tr>
                <tr>
                    <td colspan='2' style='height:50px;border-top:2px solid #666;text-align:center;'>
                        <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=2&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=15&start=NULL&code=BCGcode128"/>
                    </td>
                </tr>
                <tr>
                    <td colspan='2' style='min-height:36px;font-size:12px;line-height:12px;border-top:2px solid #666;'>
                         <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                        <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        <!--{/foreach}-->
                    </td>
                </tr>
            </table>
            
        </div>    
    
<!--{/foreach}-->  
 
 
 
  <!--{elseif $type eq 236}--><!--邮件详情单-->
<!--{foreach from =$orders item = order name=orderitem key=key}-->
        <style>
            *{margin:0;padding:0;}
            .tab1 td{border-right:1px solid #000;border-bottom:1px solid #000;padding:1px 3px;}
        </style>
       <div style='margin-left:20px;float:left;'>
        <table class='tab1' style='width:370px;height:160px;border-top:2px solid #666;border-left:2px solid #666;' cellpadding='0' cellspacing='0' border='0'>
            <tr>
                <td style='font-size:10px;line-height:10px;'>用户编码/<br/>
                    ACCOUNT    
                </td>
                <td style='font-size:12px;'>qyczmy</td>
                <td style='font-size:12px;'>日期/DATE</td>
                <td style='font-size:12px;'> <!--{$smarty.now|date_format:'%m-%d-%Y'}--> </td>
            </tr>
            <tr>
                <td style='font-size:12px;'>寄件人/FROM</td>
                <td style='font-size:12px;'>Zhang Sheng</td>
                <td style='font-size:12px;'>电话/PHONE</td>
                <td style='font-size:12px;'>&nbsp;</td>
            </tr>
            <tr>
                <td colspan='4' style='font-size:11px;line-height:12px;'>
                    地址/ADDRESS:<br/>
                    ..
                    <div style='font-size:14px;font-weight:bold;line-height:14px;'>
                        No3 Langshan 2nd Road, High-Tech<br/>
                        SHENZHEN GUANGDONG 440300<br/>
                        CHINA
                    </div>
                    邮政编码/POST CODE:<span style='font-size:14px;font-weight:bold;'>440300</span>
                    &nbsp;&nbsp;&nbsp;&nbsp;    
                    Email:
                </td>
            </tr>
            <tr>
                <td style='font-size:8px;line-height:8px;border-right:0;'>如邮件无法投送,我选择<br/>
                    IF SHIPMENT IS UNDELIVERABLE<br/>
                    I AGREE THAT IT SHOULD BE
                </td>
                <td style='font-size:10px;line-height:10px;border-right:0;'>
                    <input type='checkbox' value='' checked='checked'/>
                    退回<br/>
                    &nbsp;&nbsp; RETURNED
                </td>
                <td style='font-size:8px;line-height:8px;border-right:0;'>
                    我保证承担退回的费用<br/>
                    AND I ASSURE TO PAY FOR<br/>
                    THE CHARGE OF RETURN
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    <input type='checkbox' value='' />
                    放弃<br/>
                    &nbsp;&nbsp; ABANDONED
                </td>
            </tr>
        </table>
        
        <table class='tab1' style='width:370px;height:194px;border-left:2px solid #666;' cellpadding='0' cellspacing='0' border='0'>
            <tr>
                <td style='width:170px; height:20px;'>
                    <div style='position:relative;width:170px; height:20px;'>
                    <span style='font-size:14px;font-weight:bold;position:absolute;left:2px ;top:2px;z-index:1;'> CN22 </span>
                    <span style='border-left:1px solid #000;font-size:8px;line-height:10px;position:absolute;left:38px ;top:0px;padding-left:4px;'>
                        内件品名及详情说明<br/>
                        NAME & DESCRIPTION OF CONTENTS
                    </span>
                    </div>
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    税则号<br/>
                    HS CODE
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    件数<br/>
                    PCS
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    重量<br/>
                    WEIGHT
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    申报价值<br/>
                    VALUE
                </td>
                <td style='font-size:10px;line-height:10px;'>
                    原产地<br/>
                    ORIGIN
                </td>
            </tr>
            <tr>
                <td style='font-size:12px;line-height:12px;height:15px;'>T-Shirts 短袖</td>
                <td style='font-size:12px;line-height:12px;'>&nbsp;</td>
                <td style='font-size:12px;line-height:12px;'>1</td>
                <td style='font-size:12px;line-height:12px;'>0.2</td>
                <td style='font-size:12px;line-height:12px;'>6.64</td>
                <td style='font-size:12px;line-height:12px;'>CN</td>
            </tr>
            <tr style='height:13px;'>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
            </tr>
            <tr style='height:13px;'>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
            </tr>
            <tr style='height:13px;'>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
                <td style='height:13px;'></td>
            </tr>
            <tr>
                <td colspan='6' style='font-size:10px;line-height:18px;height:19px;'>
                    <div style='position:relative;height:16px;'>
                    <span style='position:absolute;left:150px;top:0;'>0.2 千克/KG</span>
                    <span style='position:absolute;right:20px;top:0;;'>6.64 美元/USD</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td style='font-size:8px;line-height:10px;height:50px;'>
                    我保证上述申报内容真实及本邮件内未夹寄禁寄和危险物品
                    I ASSURE THE TRUTH OF THE ABOVE DECLARATION AND
                    I GUARANTEE THAT THE SHIPMENT DOES NOT CONTAIN ANY
                    DANGEROUS AND PROHIBITHE GOODS.
                </td>
                <td colspan='5' style='font-size:12px;line-height:12px;vertical-align:top;'>
                    交寄人签名/SENDER'S SIGNATURE
                </td>
            </tr>
            <tr>
                <td style='font-size:12px;line-height:12px;vertical-align:top;border-bottom:2px solid #666;'>
                    服务电话/Hotline:11183<br/>
                    www.ems.com.cn
                </td>
                <td colspan='5' style='font-size:12px;line-height:12px;vertical-align:top;border-bottom:2px solid #666;'>
                    收寄局/ORIGIN OFFICE
                </td>
            </tr>
            
        </table>
    </div>
        
    <div style='float:left;width:370px;height:350px;border:2px solid #666;border-left:1px solid #ccc;'>
        <div style='height:23px;font-size:14px;line-height:23px;text-align:center;border-bottom:1px solid #000;'>
            <p style='float:left;width:100px;border-right:1px solid #000;'>收件人/TO</p>
            <p style='float:left;padding-left:6px;font-weight:bold;'> <!--{$order.consignee}--> </p>
        </div>
        <div style='height:17px;font-size:14px;line-height:17px;text-align:center;border-bottom:1px solid #000;'>
            <p style='float:left;width:100px;border-right:1px solid #000;'>电话/PHONE</p>
            <p style='float:left;padding-left:6px;'> <!--{$order.tel}--> </p>
        </div>
        
        <div style='height:113px;border-bottom:1px solid #000;font-size:11px;line-height:12px;padding:1px 4px;'>
            地址/ADDRESS:
            <p style='font-size:16px;line-height:16px;font-weight:bold;height:86px;'>
                <!--{$order.consignee}--><br/>
                         <!--{$order.street1}--> <!--{$order.street2}--><br/>
                         <!--{$order.city}-->,<!--{$order.state}--><br/>
                         <!--{$order.country}--><br/>
            </p>
            邮政编码/POST CODE:<span style='font-size:14px;font-weight:bold;'> <!--{$order.zipcode}--> </span>
            &nbsp;&nbsp;&nbsp;&nbsp;    
            Email:
        </div>
        <p style='font-size:10px;line-height:12px;height:37px;border-bottom:1px solid #000;padding-left:4px;position:relative;'>
            总重量/TOTAL WEIGHT <br/> <span style='position:absolute;top:0px;right:100px;'>0.2千克/KG</span>
            体积重量/VOLUMETRIC WEIGHT<br/>
            长L &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 高H &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 宽W &nbsp;&nbsp;&nbsp; = &nbsp;&nbsp;&nbsp; 立方厘米/CM³
        </p>
        
        <div style='height:25px;border-bottom:1px solid #000;'>
            <p style='float:left;width:118px;border-right:1px solid #000;font-size:10px;height:25px;line-height:12px;padding-left:4px;'>资费/CHARGE</p>
            <p style='float:left;width:118px;border-right:1px solid #000;font-size:10px;height:25px;line-height:12px;padding-left:4px;'>其他费用/OTHER CHARGE</p>
            <p style='float:left;width:120px;font-size:10px;height:25px;line-height:12px;padding-left:4px;'>费用总计/TOTAL CHARGE</p>
        </div>
        <div style='height:31px;border-bottom:1px solid #000;'>
            <p style='font-size:10px;line-height:16px;float:left;width:195px;border-right:1px solid #000;padding-left:4px;'>
                收寄人员签名/ACCEPTED BY (SIGNATURE)<br/>
                <span style='float:right;margin-right:10px;'>Y年 &nbsp; M月 &nbsp; D日</span>
            </p>
            <p style='font-size:11px;line-height:16px;float:left;padding-left:4px;width:166px'>
                收件人签名/RECEIVER NAME<br/>
                <span style='float:right;margin-right:10px;'>Y年 &nbsp; M月 &nbsp; D日</span>
            </p>
        </div>
        <div style=' height:96px;display:table-cell;vertical-align: middle;text-align:center;width:370px;'>
             <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=2&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=15&start=NULL&code=BCGcode128"/>
        </div>
    </div>
    
    <div  style='height:10px;width:100%;clear:both;'<!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>
    
<!--{/foreach}-->  
 
 
 
<!--{elseif $type eq 228}--><!--香港小包（10*10）-->
<style>
*{margin:0;padding:0;}
.clear:after{content:".";height : 0;display:block;visibility:hidden;clear:both;}
.clear{zoom:1;}
</style>
<!--{foreach from =$orders item = order name=orderitem key=key}-->
<div style="padding:0px;margin:0px;float:left;width:8.5cm;line-height:16px;font:12pt Verdana;" class="pagebreak">
    <div style="padding:0px;margin:0px;float:left;height:1.9cm;width:9.5cm;border:1px dotted #000;margin-left:2px;display:inline;">
        <table style="padding:0px;margin:0px;border-collapse:collapse;width:9.4cm;height:1.7cm;border:0px solid #000;margin:auto;margin-top:3px" align="center"  >
            <tr >
                <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:7.5cm;"   align="center" rowspan='2'>
                <span style="padding:0px;margin:0px;font-size:9px;">
                If UNDELIVERED PLEASE<br/>
                RETURN TO P.O. BOX<br/>
                NO.87341,TO KWA WAN<br/>
                Post Office,HongKong
                </span>
                </td>
                <td width="5px" style="padding:0px;margin:0px;border:0px solid #000;"></td>
                <td   style="padding:0px;margin:0px;text-align:center; font-size:10px;line-height:10px;border:1px solid #000; border-collapse:collapse;height:0.6cm;font-weight:500; width:2.8cm;">POSTAGE PAID<br />HONG KONG<br />PORT PAYE</td>
                <td style="padding:0px;margin:0px;width:1.2cm; font-size:10px; line-height:10px;border:1px solid #000" align="center">PERMIT<br />No.<br />T0238</td>
             </tr>
            <tr>
                <td></td>
                <td style="padding:0px;margin:0px;font-size:10px;height:0.5cm">AIR MAIL</td>
            </tr>
        </table>     
    </div>
<!--地址标签-->
    <div style="padding:0px;margin:0px;float:left;width:9.5cm;margin-left:2px;margin-top:5px;border:1px dashed #000;margin-bottom:10px;">
     <div style="padding:0px;margin:0px;height:0.2cm;width:8.8cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:none;">&nbsp; </div>
        <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;">
        <span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;"><!--{$order.order_sn}--></span>
            From: DZMY 
        </p>
       <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;"></p>
       <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">Send To: <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;"><!--{$order.consignee}--></span></p>
        
        <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">
            Company: <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;"></span>
        </p>
        

        <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
        <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt;"><!--{$order.street1}-->&nbsp; <!--{$order.street2}--> </p>
        <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;"> <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></p>
        <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
              <!--{$order.country}-->
            <span style="padding:0px;margin:0px;font-size:10pt">(<!--{$order.Cncountry}-->)</span>
            <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;"></span>
        </p>
        <p style="padding:0px;margin:0px;font-size:9pt;">Tel: <!--{$order.tel}--></p>
        <p><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.track_no}-->&thickness=30&start=NULL&code=BCGcode128"></p>
        <span style="padding:0px;margin:0px;margin-right: 0.8cm; float: right; margin-top: -1.16cm;font-size:12pt;font-weight:bold;"> ①</span>                
        <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-15px;margin-right:20px;font-size:10pt"> HKBAM</p>
        <div  style='font-size:12px;text-align:right;'> <!--{$smarty.now|date_format:'%Y-%m-%d'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></div>
    </div>
           
        <div style='font-size:14px;line-height:14px;padding:2px;min-height:42px;' >
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}-->
        </div>     
            
    </div>  
</div>
<div style="clear: both;" class="pagebreak"></div> 
<!--{/foreach}-->  
  

 
 
 <!--{elseif $type eq 229}--><!--香港小包2（10*10）-->
<!--{foreach from =$orders item = order name=orderitem key=key}-->
    <div style="padding:0px;margin:0px;float:left;width:8.5cm;line-height:16px;font:12pt Verdana;" class="pagebreak">
    <div style="padding:0px;margin:0px;float:left;height:1.9cm;width:9.5cm;border:1px dotted #000;margin-left:2px;">
        <table style="padding:0px;margin:0px;border-collapse:collapse;width:9.4cm;height:1.7cm;border:0px solid #000;margin:auto;margin-top:3px" align="center"  >
        <tr >
            <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:7.5cm;"   align="center" rowspan='2'>
            <span style="padding:0px;margin:0px;font-size:9px;">
            If UNDELIVERED PLEASE<br/>
            RETURN TO P.O. BOX<br/>
            NO.87341,TO KWA WAN<br/>
            Post Office,HongKong
            </span>
            </td>
            <td width="5px" style="padding:0px;margin:0px;border:0px solid #000;"></td>
            <td   style="padding:0px;margin:0px;text-align:center; font-size:10px;line-height:10px;border:1px solid #000; border-collapse:collapse;height:0.6cm;font-weight:500; width:2.8cm;">POSTAGE PAID<br />HONG KONG<br />PORT PAYE</td>
            <td style="padding:0px;margin:0px;width:1.2cm; font-size:10px; line-height:10px;border:1px solid #000" align="center">PERMIT<br />No.<br />T0238</td>
        </tr>
        <tr>
            <td></td>
            <td style="padding:0px;margin:0px;font-size:10px;height:0.5cm">AIR MAIL</td>
        </tr>
        </table>     
    </div>
<!--地址标签-->
    <div style="padding:0px;margin:0px;float:left;width:9.5cm;margin-left:2px;margin-top:5px;border:1px dashed #000;margin-bottom:10px;" class='clear'>
         <div style="padding:0px;margin:0px;height:0.2cm;width:8.8cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:none;">&nbsp; </div>
         <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;"><span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;"><img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=8&text=<!--{$order.order_sn}-->&thickness=30&start=NULL&code=BCGcode128"></span>From: DZMY </p>
         <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;"></p>
         <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">Send To: <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;"><!--{$order.consignee}--></span></p>

         <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">
        Company: <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;"></span>
    </p>


        <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
            <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt;">
            <!--{$order.street1}-->&nbsp; <!--{$order.street2}--> 
            </p>
            <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;"> <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></p>
            <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
                  <!--{$order.country}-->
                    <span style="padding:0px;margin:0px;font-size:10pt">(<!--{$order.Cncountry}-->)</span>
                    <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;"></span>
            </p>
            <p style="padding:0px;margin:0px;font-size:9pt;">Tel: <!--{$order.tel}--></p>
            <p>   </p>
            <span style="padding:0px;margin:0px;margin-right: 0.8cm; float: right; margin-top: -1.16cm;font-size:12pt;font-weight:bold;"> ①</span>                
            <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-15px;margin-right:20px;font-size:10pt">    HKBAM</p>
            <div style='font-size:12px;text-align:right;'> <!--{$smarty.now|date_format:'%Y-%m-%d'}-->&nbsp;&nbsp;<!--{$key+1}-->/<!--{$orders|@count}--></div>
        </div>
         <div style='font-size:14px;line-height:14px;padding:2px;margin-top:40px;min-height:28px;' >
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
            <!--{$goods.goods_sn}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
            <!--{/foreach}-->
        </div>     
    </div>  
</div>
<div style="clear: both;" class="pagebreak"></div> 
<!--{/foreach}-->  
    
    
<!--{elseif $type eq 131}--><!--香港邮政小包(平邮)10*10-->
<!--{foreach from =$orders item = order name=orderitem}-->
  <div style="padding:0px;margin:0px;width: 9.7cm;" class="pagebreak">
<div style="width:95mm" class="pagebreak">
<div style="padding:0px;margin:0px;height:1.9cm;width:8.4cm;border:1px dotted #000;margin-left:2px;">
            <table style="padding:0px;margin:0px;border-collapse:collapse;width:7.4cm;height:1.7cm;border:0px solid #000;margin:auto;margin-top:3px" align="center"  >
                                         <tr >
                <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:5.5cm;"   align="center" rowspan='2'>
                <span style="padding:0px;margin:0px;font-size:8px;">
               If UNDELIVERED PLEASE<br/>
               RETRUN TO P.O.BOX<BR>
               NO.87341,TO KWA WAN<br>
               Post Office,HongKong
                </span>
                </td>
                <td width="5px" style="padding:0px;margin:0px;border:0px solid #000;"></td>
                <td   style="padding:0px;margin:0px;text-align:center; font-size:10px;line-height:10px;border:1px solid #000; border-collapse:collapse;height:0.6cm;font-weight:500; width:2.8cm;">POSTAGE PAID<br />HONG KONG<br />PORT PAYE</td>
                <td style="padding:0px;margin:0px;width:1.2cm; font-size:8px; line-height:10px;border:1px solid #000" align="center">PERMIT<br />No.<br />T0238</td>
                 </tr>
                                <tr>
             <td></td>
             <td style="padding:0px;margin:0px;font-size:10px;height:0.5cm">AIR MAIL</td>
             </tr>
            </table>     
</div>
<!--地址标签-->
<div style="padding:0px;margin:0px;height:6.76cm;width:8.4cm;margin-left:2px;margin-top:5px;overflow:hidden;border:1px dashed #000;">
                 <div style="padding:0px;margin:0px;height:0.1cm;width:8.8cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:0;">&nbsp; </div>
    <p style="padding:0px;margin:0px;font-size:8pt;line-height:5px;"></p>
    <div >
        <ul style="padding:2px">
        <li style="clear:left;font-size:18px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
        <li style="font-size:16px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
        <li style="font-size:16px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
        <li style="font-size:16px;">
        <b><!--{$order.country}--></b><br>
        <b><!--{$order.tel}--></b></li>
        <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=50&type=0"></li>
        <li style="font-size:12px;margin-top:-20px;letter-spacing:4px;width:210px"><center>*<!--{$order.order_sn}-->*</center><br/></li>
        <li><span style="font-size:12px;"><!--{$order.total}-->---
        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
        <!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
        <!--{/foreach}--></span>
        <!--{if $order.note}--><br><!--{$order.note}--><!--{/if}-->
        </li>
        </ul>
        </div>
    </div>
</div>
<div style="height:10px"></div>
<div style="padding:0px;margin:0px;float:left;margin-top:0cm; position:relative;left:0.2cm;width:7.6cm;height:9.1cm;border:0px solid #000;overflow:hidden;font-family:arial;" >
<div style="padding:0px;margin:0px;margin-top:0cm;width:7.4cm;height:8.8cm;border:1px solid #000;overflow:hidden">
    <div style="padding:0px;margin:0px; padding:2px 3px;">
        <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px dotted #000000; height:0.8cm;">
        <ul style="padding:0px;margin:0px;float:left;width:5cm;font-weight:700;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:left;width:5cm">報關單 CUSTOMS DECLARATION<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:5cm;font-weight:500">(本件得由海關開拆 May be opened officially)</li>
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:2cm;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:11pt;text-align:right;width:2cm;font-weight:700;">CN 22<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:right;width:2cm">Pos401G(3/05)</li>
          
     
        </ul>
        </div>
        
          <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px solid #000000; height:0.8cm; margin-top:0px;">
        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:0.7cm;line-height:9pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm">Postal administration</li>
            <li style="padding:0px;margin:0px;float:left;font-size:8pt;text-align:left;width:4cm;font-weight:650; word-spacing:0px;">香港郵政 HONGKONG POST</li>
                <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:4cm;font-weight:500"> </li>
            
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.7cm;line-height:8pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:right;width:3cm;font-weight:700;">重要Important!<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">請參閱背頁說明</li>
          
        <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">See instructions on the back</li>
         
        </ul>
        </div>
        
        <div style="padding:0px;margin:0px;width:7.2cm; margin-top:0px; ">
         <table style="padding:0px;margin:0px;width:100%;border:0;font-size:8pt;height:0.9cm;border:0px;    border-collapse:collapse;    overflow:hidden;">
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm"><td  ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>禮物 Gift</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"  /></td><td>商用樣本 Commercial sample</td>
           </tr>
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm" valign="bottom"><td ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>文件 Documents</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" checked  /></td><td><div style="padding:0px;margin:0px;word-wrap:normal;" ><span style="padding:0px;margin:0px;float:left;">其他 Other</span><span style="padding:0px;margin:0px;float:right;font-weight:400;font-size:5pt;font-style: italic">(在過當方格內劃上"√"號)<br />(Tick as appropriate)</span></div></td>
           </tr>
         </table>

         <table style="padding:0px;margin:0px;width:100%; font-size:5pt;height:3.5cm;" cellpadding="0" cellspacing="0" >
            <tr  style="padding:0px;margin:0px;height:0.8cm:"><td style="padding:0px;margin:0px;width:4cm;border:1px solid #000; border-right:0;">
                                    (1)內載物品詳情及數量
                                    <br />
                                    Quantity and detailed
                                    <br />
                                    description of contents
                                </td>
                                <td align="center" style="border:1px solid #000; padding:0px;margin:0px;width:1.4cm;">
                                    (2)重量
                                    <br />
                                    Weight
                                    <br />
                                    (公斤 kg)
                                </td>
                                <td align="center" style="border:1px solid #000; border-left:0;">
                                    (3)價值
                                    <br />
                                    Value
                                </td>
           </tr>   
           <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;border-left:0;border-right:0;">
<td valign="middle" align="center" style="border:1px solid #000;border-top:0;border-bottom:0; border-right:0;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;">
<font style="padding:0px;margin:0px;font-size:8pt; ">
<!--{$goods.dec_name}-->&nbsp;&nbsp;<!--{$goods.goods_qty}-->
</font></td>
<td valign="middle" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-top:0;border-bottom:0">
<font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true"></span>
</font>
</td>
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px; border:1px solid #000;border-top:0;border-bottom:0; border-left:0">
<font style="padding:0px;margin:0px;font-size:8pt;"><span  contenteditable = "true"></span>
</font>
</td>
</tr>
<!--{/foreach}--> 
           <tr style="padding:0px;margin:0px;height:1.3cm;"><td  valign="top" style="border:1px solid #000;padding:0px;margin:0px;width:4cm;"  ><div style="padding:0px;margin:0px;width:100%;border:1px solid #000;height:1.3cm;"> <div style="padding:0px;margin:0px;width:100%; height:0.3cm; font-size:6pt; border-bottom:1px solid #000;">只適用於商品For commercial items only</div>
              <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin-top:0;">(4)協制編號及(5)物品原産地(如有)</span><br />
           <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin:0;padding:0;"><br/>CN中国</span></div></td>
           
           <td  valign="top" align="center" style="border:1px solid #000;padding:0px;margin:0px;width:1.4cm;">(6)總重量
<br />Total weight<br />(公斤 kg)<br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true"></span></font></td><td  valign="top" align="center" style="border:1px solid #000;border-left:0;">(7)總共價值<br />Total Value<br /><br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true"></span></font></td>
    </tr>
      </tr>
    </table>
           <div style="padding:0px;margin:0px;font-size:6pt;margin-top:6px; width:7.2cm">
           在下面簽署，以證明此報關單上列資料全屬正確，及此郵件並不載有任何法例或郵政規例或海關條例所禁寄的危險物品。本人的姓名及地址已載於郵件上。<br />
            I, the undersigned,whose name and address are given on the item,certify that the particulars given in this declaration are correct and that this item dose not contain any dangerous article or articles prohibited by legislation or by customs regulations.
           </div>
           <div style="padding:0px;margin:0px;border-bottom:1px solid #000000;width:7.2cm;height:1px;margin-top:1px; font-size:0px;">&nbsp;</div>
            <div  style="padding:0px;margin:0px;width:7.2cm;font-size:6pt;margin-top:2px; ">
                <table border="0" style="padding:0px;margin:0px;width:100%;font-size:6pt;border:0;"><tr style="padding:0px;margin:0px;border:0;"><td style="padding:0px;margin:0px;border:0;width:3.5cm;">(8)日期及寄件人簽署<br />Date and sender's signature</td><td style="padding:0px;margin:0px;border:0;"><font style="padding:0px;margin:0px;font-size:8pt">JR Chenhuangsheng</font></td></tr></table>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div>
</div>
<div style="height:15px"></div>
<!--{/foreach}-->
<!--{elseif $type eq 154}--><!--香港邮政小包(平邮)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
  <div style="padding:0px;margin:0px;width: 9.7cm;"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style='height:0.1cm;*height:0;overflow:hidden;font-size:0;width:20cm'></div>
<div  style="padding:0px;margin:0px;width:20cm;height:8.9cm;float:left;margin-top:0px;overflow:hidden;">
    <div style="padding:0px;margin:0px;float:left;height:8.8cm;width:8.5cm;line-height:16px;font:12pt Verdana;">
        <div style="padding:0px;margin:0px;float:left;height:1.9cm;width:8.4cm;border:1px dotted #000;margin-left:2px;display:inline;">
            <table style="padding:0px;margin:0px;border-collapse:collapse;width:7.4cm;height:1.7cm;border:0px solid #000;margin:auto;margin-top:3px" align="center"  >
                                         <tr >
                <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:5.5cm;"   align="center" rowspan='2'>
                <span style="padding:0px;margin:0px;font-size:9px;">
               If UNDELIVERED PLEASE<br/>
               RETURN TO P.O. BOX<br/>
               NO.87341,TO KWA WAN<br/>
               Post Office,HongKong
                </span>
                </td>
                <td width="5px" style="padding:0px;margin:0px;border:0px solid #000;"></td>
                <td   style="padding:0px;margin:0px;text-align:center; font-size:10px;line-height:10px;border:1px solid #000; border-collapse:collapse;height:0.6cm;font-weight:500; width:2.8cm;">POSTAGE PAID<br />HONG KONG<br />PORT PAYE</td>
                <td style="padding:0px;margin:0px;width:1.2cm; font-size:10px; line-height:10px;border:1px solid #000" align="center">PERMIT<br />No.<br />T0238</td>
                 </tr>
                                <tr>
             <td></td>
             <td style="padding:0px;margin:0px;font-size:10px;height:0.5cm">AIR MAIL</td>
             </tr>
            </table>     
</div>
<!--地址标签-->
<div style="padding:0px;margin:0px;float:left;height:6.76cm;width:8.4cm;margin-left:2px;margin-top:5px;display:inline;overflow:hidden;border:1px dashed #000;">
                 <div style="padding:0px;margin:0px;height:0.2cm;width:8.8cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:0;">&nbsp; </div>
                     <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;"><span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;"><!--{$order.order_sn}--></span>From: <!--{$params.Contact}--> </p>
                                       <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;"></p>
                                       <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">Send To: <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;"><!--{$order.consignee}--></span></p>
                
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">Company: <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;"></span></p>
            
       
        <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
                <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt;">
<!--{$order.street1}-->&nbsp; <!--{$order.street2}--> 
</p>
                <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;"> <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></p>
                <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
                      <!--{$order.country}-->
                                        <span style="padding:0px;margin:0px;font-size:10pt">(<!--{$order.Cncountry}-->)</span>
                                        <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;">
                                                                          </span></span>
                </p>
                <p style="padding:0px;margin:0px;font-size:9pt;">Tel: <!--{$order.tel}--></p>
                <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=40"></li>
    <center style="font-size:13px;margin-top:-20px;" >*<!--{$order.track_no}-->*</center>
                 <span style="padding:0px;margin:0px;margin-right: 0.8cm; float: right; margin-top: -1.16cm;font-size:12pt;font-weight:bold;"> ①</span>                <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-15px;margin-right:20px;font-size:10pt">
                                         
                        HKBAM
                </p></div>
    </div>
</div>
<!--地址标签-->
<div style="padding:0px;margin:0px;float:left;margin-top:0cm; position:relative;left:0.2cm;width:7.6cm;height:8.9cm;border:0px solid #000;overflow:hidden;font-family:arial;" >
<div style="padding:0px;margin:0px;margin-top:0cm;width:7.4cm;height:8.8cm;border:1px solid #000;overflow:hidden">
    <div style="padding:0px;margin:0px; padding:2px 3px;">
        <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px dotted #000000; height:0.8cm;">
        <ul style="padding:0px;margin:0px;float:left;width:5cm;font-weight:700;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:left;width:5cm">報關單 CUSTOMS DECLARATION<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:5cm;font-weight:500">(本件得由海關開拆 May be opened officially)</li>
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:2cm;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:11pt;text-align:right;width:2cm;font-weight:700;">CN 22<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:right;width:2cm">Pos401G(3/05)</li>
          
     
        </ul>
        </div>
        
          <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px solid #000000; height:0.8cm; margin-top:0px;">
        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:0.7cm;line-height:9pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm">Postal administration</li>
            <li style="padding:0px;margin:0px;float:left;font-size:8pt;text-align:left;width:4cm;font-weight:650; word-spacing:0px;">香港郵政 HONGKONG POST</li>
                <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:4cm;font-weight:500"> </li>
            
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.7cm;line-height:8pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:right;width:3cm;font-weight:700;">重要Important!<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">請參閱背頁說明</li>
          
        <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">See instructions on the back</li>
         
        </ul>
        </div>
        
        <div style="padding:0px;margin:0px;width:7.2cm; margin-top:0px; ">
         <table style="padding:0px;margin:0px;width:100%;border:0;font-size:8pt;height:0.9cm;border:0px;    border-collapse:collapse;    overflow:hidden;">
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm"><td  ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>禮物 Gift</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"  /></td><td>商用樣本 Commercial sample</td>
           </tr>
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm" valign="bottom"><td ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>文件 Documents</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" checked  /></td><td><div style="padding:0px;margin:0px;word-wrap:normal;" ><span style="padding:0px;margin:0px;float:left;">其他 Other</span><span style="padding:0px;margin:0px;float:right;font-weight:400;font-size:5pt;font-style: italic">(在過當方格內劃上"√"號)<br />(Tick as appropriate)</span></div></td>
           </tr>
         </table>

         <table style="padding:0px;margin:0px;width:100%; font-size:5pt;height:3.5cm;" cellpadding="0" cellspacing="0" >
            <tr  style="padding:0px;margin:0px;height:0.8cm:"><td style="padding:0px;margin:0px;width:4cm;border:1px solid #000; border-right:0;">
                                    (1)內載物品詳情及數量
                                    <br />
                                    Quantity and detailed
                                    <br />
                                    description of contents
                                </td>
                                <td align="center" style="border:1px solid #000; padding:0px;margin:0px;width:1.4cm;">
                                    (2)重量
                                    <br />
                                    Weight
                                    <br />
                                    (公斤 kg)
                                </td>
                                <td align="center" style="border:1px solid #000; border-left:0;">
                                    (3)價值
                                    <br />
                                    Value
                                </td>
           </tr>   
           <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;border-left:0;border-right:0;">
<td valign="middle" align="center" style="border:1px solid #000;border-top:0;border-bottom:0; border-right:0;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;">
<font style="padding:0px;margin:0px;font-size:8pt; ">
toy 玩具&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
</font></td>
<td valign="middle" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-top:0;border-bottom:0">
<font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">0.1</span>
</font>
</td>
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px; border:1px solid #000;border-top:0;border-bottom:0; border-left:0">
<font style="padding:0px;margin:0px;font-size:8pt;"><span  contenteditable = "true">$10</span>
</font>
</td>
</tr>
<!--{/foreach}-->
              
           <tr style="padding:0px;margin:0px;height:1.3cm;"><td  valign="top" style="border:1px solid #000;padding:0px;margin:0px;width:4cm;"  ><div style="padding:0px;margin:0px;width:100%;border:1px solid #000;height:1.3cm;"> <div style="padding:0px;margin:0px;width:100%; height:0.3cm; font-size:6pt; border-bottom:1px solid #000;">只適用於商品For commercial items only</div>
              <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin-top:0;">(4)協制編號及(5)物品原産地(如有)</span><br />
           <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin:0;padding:0;"><br/>CN中国</span></div></td>
           
           <td  valign="top" align="center" style="border:1px solid #000;padding:0px;margin:0px;width:1.4cm;">(6)總重量
<br />Total weight<br />(公斤 kg)<br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">0.1</span></font></td><td  valign="top" align="center" style="border:1px solid #000;border-left:0;">(7)總共價值<br />Total Value<br /><br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">$10</span></font></td>
           </tr>
            
           </tr>
         </table>

           <div style="padding:0px;margin:0px;font-size:6pt;margin-top:6px; width:7.2cm">
           在下面簽署，以證明此報關單上列資料全屬正確，及此郵件並不載有任何法例或郵政規例或海關條例所禁寄的危險物品。本人的姓名及地址已載於郵件上。<br />
            I, the undersigned,whose name and address are given on the item,certify that the particulars given in this declaration are correct and that this item dose not contain any dangerous article or articles prohibited by legislation or by customs regulations.

           </div>
           <div style="padding:0px;margin:0px;border-bottom:1px solid #000000;width:7.2cm;height:1px;margin-top:2px; font-size:0px;">&nbsp;</div>
            <div  style="padding:0px;margin:0px;width:7.2cm;font-size:6pt;margin-top:2px; ">
                <table border="0" style="padding:0px;margin:0px;width:100%;font-size:6pt;border:0;"><tr style="padding:0px;margin:0px;border:0;"><td style="padding:0px;margin:0px;border:0;width:3.5cm;">(8)日期及寄件人簽署<br />Date and sender's signature</td><td style="padding:0px;margin:0px;border:0;"><font style="padding:0px;margin:0px;font-size:8pt">JR 陈皇胜</font></td></tr></table>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 153}--><!--香港邮政小包(挂号)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <td valign="top" align="left"
                    style="border: 0px; font-size: 8px; padding: 0; width: 3.0cm; font-style: italic">
                <b>FROM:&nbsp;</b> <B>JRFWLCC</B><br>
                P.O.BOX NO.87346,TO KWA WAN POST OFFICE, HONGKONG
<br>
              </td>
                <td align="right" valign="top"
                    style="width: 4.5cm; margin-right: 1cm;">
                <img src="themes/default/images/HLY-YXJ-1358749628187-c.jpg"/></td>
            </tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <U>SHIP TO:&nbsp;</U> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->
<br><!--{$order.city}-->, <!--{$order.state}-->, <!--{$order.zipcode}-->
<br><!--{$order.country}--><br>
      </font>
        <!--{$order.country}-->&nbsp;(<!--{$order.Cncountry}-->)<br>
        <!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                <table
                    style="font-size: 8px; border-collapse: collapse; border: none; width: 1.5cm">
                 <tr>
                            <td style="border: solid #000 1px; font-size: 6px; line-height: 10px;" align="center">
                      <img src="themes/default/images/HLY-YXJ-1358759297937-S.jpg"  height="52" width="52"/>
                 </td>
                         </tr>
                    <tr>
                        <td style="border: solid #000 1px; font-size: 10px;"
                            align="center"><b>zone</b></td>
                    </tr>
                    <tr>
                        <td style="border: solid #000 1px; font-size: 20px;height:28;"
                            align="center"> 
                        </td>
                    </tr>
                </table>
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="1" cellspacing="1"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm">
                    <tr>
                        <td colspan="2"
                            style="border: solid #000 1px; width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             *<!--{$order.order_sn}-->*
                         </b></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=35">
                                
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 8px" colspan="2">
                        HKPOSTP
                        &nbsp;&nbsp;&nbsp;&nbsp; [  
                            <!--{$order.order_sn}-->
                         ]&nbsp;Ref No: 
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C>
<DIV id=C1>
<DIV id=C11><span class=cn1>
 CUSTOMS DECLARATION</span><BR><span class=cn2>(May be opened officially)</span></DIV>
<DIV id=C12><span class=cn1>CN 22</span><BR><span class=cn2>Pos 401G(4/08)</span></DIV>
<DIV id=C13><span class=cn2>Postal administration</span></DIV>
</DIV>
<DIV id=C2>
<div id=C21><IMG src="themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div id=C22><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div id=C23><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div id=C24><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
<span class=cn2><BR>(15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">JRFWLCC</div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>
<!--{/foreach}-->
<!--{elseif $type eq 132}--><!--香港邮政小包(挂号)10*10-->
<!--{foreach from =$orders item = order name=orderitem}-->
  <div style="padding:0px;margin:0px;width: 9.7cm;"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style='height:0.1cm;*height:0;overflow:hidden;font-size:0;width:20cm'></div>
<div  style="padding:0px;margin:0px;width:20cm;height:8.9cm;float:left;margin-top:0px;overflow:hidden;">
    <div style="padding:0px;margin:0px;float:left;height:8.8cm;width:8.5cm;line-height:16px;font:12pt Verdana;">
        <div style="padding:0px;margin:0px;float:left;height:1.9cm;width:8.4cm;border:1px dotted #000;margin-left:2px;display:inline;">
            <table style="padding:0px;margin:0px;border-collapse:collapse;width:7.4cm;height:1.7cm;border:0px solid #000;margin:auto;margin-top:3px" align="center"  >
                                         <tr >
                <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:5.5cm;"   align="center" rowspan='2'>
                <span style="padding:0px;margin:0px;font-size:9px;">
               If UNDELIVERED PLEASE<br/>
               RETURN TO P.O. BOX<br/>
               NO.87341,TO KWA WAN<br/>
               Post Office,HongKong
                </span>
                </td>
                <td width="5px" style="padding:0px;margin:0px;border:0px solid #000;"></td>
                <td   style="padding:0px;margin:0px;text-align:center; font-size:10px;line-height:10px;border:1px solid #000; border-collapse:collapse;height:0.6cm;font-weight:500; width:2.8cm;">POSTAGE PAID<br />HONG KONG<br />PORT PAYE</td>
                <td style="padding:0px;margin:0px;width:1.2cm; font-size:10px; line-height:10px;border:1px solid #000" align="center">PERMIT<br />No.<br />T0238</td>
                 </tr>
                                <tr>
             <td></td>
             <td style="padding:0px;margin:0px;font-size:10px;height:0.5cm">AIR MAIL</td>
             </tr>
            </table>     
</div>
<!--地址标签-->
<div style="padding:0px;margin:0px;float:left;height:6.76cm;width:8.4cm;margin-left:2px;margin-top:5px;display:inline;overflow:hidden;border:1px dashed #000;">
                 <div style="padding:0px;margin:0px;height:0.2cm;width:8.8cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:0;">&nbsp; </div>
                     <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;"><span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;"><!--{$order.order_sn}--></span>From: <!--{$params.Contact}--> </p>
                                       <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;"></p>
                                       <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">Send To: <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;"><!--{$order.consignee}--></span></p>
                
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">Company: <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;"></span></p>
            
       
        <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
                <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt;">
<!--{$order.street1}-->&nbsp; <!--{$order.street2}--> 
</p>
                <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;"> <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></p>
                <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
                      <!--{$order.country}-->
                                        <span style="padding:0px;margin:0px;font-size:10pt">(<!--{$order.Cncountry}-->)</span>
                                        <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;">
                                                                          </span></span>
                </p>
                <p style="padding:0px;margin:0px;font-size:9pt;">Tel: <!--{$order.tel}--></p>
                <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=40"></li>
    <center style="font-size:13px;margin-top:-20px;" >*<!--{$order.track_no}-->*</center>
                 <span style="padding:0px;margin:0px;margin-right: 0.8cm; float: right; margin-top: -1.16cm;font-size:12pt;font-weight:bold;"> ①</span>                <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-15px;margin-right:20px;font-size:10pt">               
                        HKBAM
                </p></div>
    </div>
</div>
<!--地址标签-->
<div style="padding:0px;margin:0px;float:left;margin-top:0cm; position:relative;left:0.2cm;width:7.6cm;height:8.9cm;border:0px solid #000;overflow:hidden;font-family:arial;" >
<div style="padding:0px;margin:0px;margin-top:0cm;width:7.4cm;height:8.8cm;border:1px solid #000;overflow:hidden">
    <div style="padding:0px;margin:0px; padding:2px 3px;">
        <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px dotted #000000; height:0.8cm;">
        <ul style="padding:0px;margin:0px;float:left;width:5cm;font-weight:700;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:left;width:5cm">報關單 CUSTOMS DECLARATION<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:5cm;font-weight:500">(本件得由海關開拆 May be opened officially)</li>
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:2cm;height:0.8cm;line-height:10pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:11pt;text-align:right;width:2cm;font-weight:700;">CN 22<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:right;width:2cm">Pos401G(3/05)</li>
          
     
        </ul>
        </div>
        
          <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px solid #000000; height:0.8cm; margin-top:0px;">
        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:0.7cm;line-height:9pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm">Postal administration</li>
            <li style="padding:0px;margin:0px;float:left;font-size:8pt;text-align:left;width:4cm;font-weight:650; word-spacing:0px;">香港郵政 HONGKONG POST</li>
                <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:center;width:4cm;font-weight:500"> </li>
            
           
        </ul> 
        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.7cm;line-height:8pt;">
            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:right;width:3cm;font-weight:700;">重要Important!<br /></li>
            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">請參閱背頁說明</li>
          
        <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">See instructions on the back</li>
         
        </ul>
        </div>
        
        <div style="padding:0px;margin:0px;width:7.2cm; margin-top:0px; ">
         <table style="padding:0px;margin:0px;width:100%;border:0;font-size:8pt;height:0.9cm;border:0px;    border-collapse:collapse;    overflow:hidden;">
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm"><td  ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>禮物 Gift</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"  /></td><td>商用樣本 Commercial sample</td>
           </tr>
            <tr style="padding:0px;margin:0px;border:0;height:0.45cm" valign="bottom"><td ><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" /></td><td>文件 Documents</td><td><input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;" checked  /></td><td><div style="padding:0px;margin:0px;word-wrap:normal;" ><span style="padding:0px;margin:0px;float:left;">其他 Other</span><span style="padding:0px;margin:0px;float:right;font-weight:400;font-size:5pt;font-style: italic">(在過當方格內劃上"√"號)<br />(Tick as appropriate)</span></div></td>
           </tr>
         </table>

         <table style="padding:0px;margin:0px;width:100%; font-size:5pt;height:3.5cm;" cellpadding="0" cellspacing="0" >
            <tr  style="padding:0px;margin:0px;height:0.8cm:"><td style="padding:0px;margin:0px;width:4cm;border:1px solid #000; border-right:0;">
                                    (1)內載物品詳情及數量
                                    <br />
                                    Quantity and detailed
                                    <br />
                                    description of contents
                                </td>
                                <td align="center" style="border:1px solid #000; padding:0px;margin:0px;width:1.4cm;">
                                    (2)重量
                                    <br />
                                    Weight
                                    <br />
                                    (公斤 kg)
                                </td>
                                <td align="center" style="border:1px solid #000; border-left:0;">
                                    (3)價值
                                    <br />
                                    Value
                                </td>
           </tr>   
           <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;border-left:0;border-right:0;">
<td valign="middle" align="center" style="border:1px solid #000;border-top:0;border-bottom:0; border-right:0;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;">
<font style="padding:0px;margin:0px;font-size:8pt; "><!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}--></font></td>
<td valign="middle" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-top:0;border-bottom:0">
<font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true"></span>
</font>
</td>
<td valign="middle" align="center" style="border-collapse:collapse;overflow:hidden;font-family:arial;padding:0px;margin:0px; border:1px solid #000;border-top:0;border-bottom:0; border-left:0"><font style="padding:0px;margin:0px;font-size:8pt;"><span  contenteditable = "true"><!--{$goods.Declared_value}--></span>
</font>
</td>
</tr>
<!--{/foreach}-->
              
           <tr style="padding:0px;margin:0px;height:1.3cm;"><td  valign="top" style="border:1px solid #000;padding:0px;margin:0px;width:4cm;"  ><div style="padding:0px;margin:0px;width:100%;border:1px solid #000;height:1.3cm;"> <div style="padding:0px;margin:0px;width:100%; height:0.3cm; font-size:6pt; border-bottom:1px solid #000;">只適用於商品For commercial items only</div>
              <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin-top:0;">(4)協制編號及(5)物品原産地(如有)</span><br />
           <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin:0;padding:0;"><br/>CN中国</span></div></td>
           
           <td  valign="top" align="center" style="border:1px solid #000;padding:0px;margin:0px;width:1.4cm;">(6)總重量
<br />Total weight<br />(公斤 kg)<br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">0.1</span></font></td><td  valign="top" align="center" style="border:1px solid #000;border-left:0;">(7)總共價值<br />Total Value<br /><br /><br /><font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true"><!--{$order.vartotalprice}--></span></font></td>
           </tr>
            
           </tr>
         </table>

           <div style="padding:0px;margin:0px;font-size:6pt;margin-top:6px; width:7.2cm">
           在下面簽署，以證明此報關單上列資料全屬正確，及此郵件並不載有任何法例或郵政規例或海關條例所禁寄的危險物品。本人的姓名及地址已載於郵件上。<br />
            I, the undersigned,whose name and address are given on the item,certify that the particulars given in this declaration are correct and that this item dose not contain any dangerous article or articles prohibited by legislation or by customs regulations.

           </div>
           <div style="padding:0px;margin:0px;border-bottom:1px solid #000000;width:7.2cm;height:1px;margin-top:2px; font-size:0px;">&nbsp;</div>
            <div  style="padding:0px;margin:0px;width:7.2cm;font-size:6pt;margin-top:2px; ">
                <table border="0" style="padding:0px;margin:0px;width:100%;font-size:6pt;border:0;"><tr style="padding:0px;margin:0px;border:0;"><td style="padding:0px;margin:0px;border:0;width:3.5cm;">(8)日期及寄件人簽署<br />Date and sender's signature</td><td style="padding:0px;margin:0px;border:0;"><font style="padding:0px;margin:0px;font-size:8pt">JR 陈皇胜</font></td></tr></table>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 158}--><!-- 中国邮政小包（挂号）10*10 -->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="clear:both;" class="pagebreak">
<!--地址标签-->
<div style="height:8.9cm;width:8.9cm;">
<div style="height:10px"></div>
<ul>
<li style="font-size:20;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:20px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:20px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:20px;">
<b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b>
</li>
<li>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<b style="font-size:14px"><!--{$goods.goods_sn}--></b>&nbsp;&nbsp;&nbsp;&nbsp;
 <!--{/foreach}-->
</li>
</ul>
</div>
</div>
<!--地址标签-->
<div style="padding:0px;margin-left:10px;position:relative;top:0.3cm;width:7.2cm;height:8.9cm;border:1px solid #000;font-family:arial;font-size:12px;" class="pagebreak">
            <div style="padding:0px;margin:0px;width:6.5cm;position:absolute;height:1.8cm;left:0.1cm;text-align:center;margin:0px auto;">
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.02cm;border:0px;height:1cm;">
                    <tr style="padding:0px;margin:0px;border:0px;font-size:9px;height:0.3cm">
                        <td align="left" style="padding:0px;margin:0px;font-weight:bold;padding:2px;     border-collapse:collapse;
                        overflow:hidden;font-family:arial;font-size:12px;">
                            报关签条
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm">
                        <td align="left" style="padding:2px;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-family:arial;font-size:10px;" height="0.2cm">
                            <b>
                                CUSTOMS DECLARATION
                            </b>
                        </td>
                        <td align="right" style="padding:0px;margin:0px;font-size:8px;">
                            邮 2113
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.2cm">
                        <td align="left" style="padding:2px;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:8px;">
                            可以径行开拆
                        </td>
                        <td align="right" style="padding:0px;margin:0px;font-family:arial;font-size:12px;">
                            <b>
                                CN22
                            </b>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.2cm">
                        <td align="left" style="padding:2px;     border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:9px;">
                            May be opened officially
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
<div style="padding:0px;margin:0px;width:7.2cm;position:absolute;top:1.6cm;text-align:center;margin:0px auto;">
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.1cm;border:1px solid #000000;height:1.5cm;">
                    <tr style="padding:0px;margin:0px;border:1px solid;font-size:10px;">
                        <td align="left" style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:9px" colspan="5">
                            <div style="padding:0px;margin:0px;float:left;width:2.1cm;height:0.6cm;">
                                <img src="themes/default/images/chinapost.png" style="padding:0px;margin:0px;height:0.6cm;"
                                />
                            </div>
                            <div style="padding:0px;margin:0px;float:right;font-size:9px;width:3.5cm;height:0.6cm;">
                                请先阅读背面的注意事项
                                <br />
                                See instructions on the back
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding:2px;border-right:1px solid #000;border-bottom:1px solid #000;border-right:none;border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;font-size:2.4mm;width:2.4cm;" rowspan="2">
                            邮件种类
                            <br />
                            Category of item
                            <br />
                            (在适当的文字前划"√")
                            <br />
                            Tick as appropriate
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;overflow:hidden;width:10px;"
                            checked/>
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            礼品
                            <br />
                            Gift
                        </td>
                        <td style="padding:2px;border-right:1px solid #000;border-bottom:1px solid #000; border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;width:10px;overflow:hidden;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            商品货样
                            <br />
                            Commercial
                            <br />
                            sample
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;border:1px solid;">
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;width:10px;overflow:hidden;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            文件
                            <br />
                            Documents
                        </td>
                        <td style="padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;overflow:hidden;width:10px;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;border-left:1px solid #000;">
                            其他
                            <br />
                            Other
                        </td>
                    </tr>
                </table>
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0cm;border:1px solid #000000;border-top:0px;height:1.5cm;">
                    <tr>
                        <td style="padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;border-bottom:1px solid #000; ">
                            内件详细名称和数量
                            <br />
                            Quantity and detailed description of contents
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;border-left:1px solid #000;">
                            重量（千克）
                            <br />
                            Weight(kg)
                        </td>
                        <td style="padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;border-bottom:1px solid #000; ">
                            价值
                            <br />
                            Value
                        </td>
                    </tr>
                     <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;height:25px;">
                        <td style="padding:2px;   border-right:1px solid #000;   border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;">
                           <!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;       border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;">
                            <span  contenteditable = "true"></span>
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;       border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            <span  contenteditable = "true"><!--{$goods.Declared_value}--></span>
                        </td>
                    </tr>
            <!--{/foreach}-->
                    <tr>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000; border-top:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;">
                            协调系统税则号列和货物原产国（只对商品邮件填写）
                            <br />
                            HS tariff number and country of origin of goods(For commercial items only)
                        </td>
                        <td style="padding:2px;  border-top:1px solid #000;   border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;" rowspan="2"
                        valign="top">
                            总重量
                            <br />
                            Total Weight
                            <br />
                            <br />
                            <span  contenteditable = "true"></span>
                        </td>
                        <td style="padding:2px;    border-top:1px solid #000; border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;" rowspan="2"
                        valign="top">
                            总价值
                            <br />
                            Total Value
                            <br />
                            <br />
                            <span  contenteditable = "true"><!--{$order.vartotalprice}--></span>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm;">
                        <td style="padding:2px; border-right:1px solid #000;border-bottom:1px solid #000;    border-collapse:collapse;overflow:hidden;">
                        </td>
                    </tr>
                </table>
                <p style="padding:0px;margin:0px;margin-top:3px;font-size:6pt;text-align:left;line-height:9px;">
                    我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品
                    <br />
                    I, the undersigned,certify that the particulars given in this declaration
                    are correct and this item does not contain any dangerous articles prohibited
                    by legislation or by postal or customs regulations.
                    <br />
                    寄件人签字 Sender's signature &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <font style="padding:0px;margin:0px;font-size:8pt"></font>
                </p>
            </div>
        </div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 160}--><!-- 中国邮政小包（平邮）10*10-->
<!--{foreach from =$orders item = order name=orderitem}-->
 <DIV style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px;PADDING-RIGHT: 0px; PADDING-TOP: 0px"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style="width:8cm">
        <!--地址标签-->
            <div style=" border:1px dashed #000;padding:0px;margin:0px;height:7.8cm;width:7.9cm;margin-left:2px;margin-top:5px;">
                <div style="padding:0px;margin:0px;height:0.2cm;width:7.8cm;font-size:7pt;word-wrap:break-word;border:0;">
                    &nbsp;
                </div>
                <p style="padding:0px;margin:0px;padding:0 5px;font-size:9pt;font-weight:600;padding-top:3px;">
                    From: <!--{$params.Contact}-->
                </p>
                <p style="padding:0px;margin:0px;padding:0px 5px;font-size:8pt;line-height:16px;">
                    <!--{$params.Company}-->
&nbsp;<!--{$params.Street}-->,<!--{$params.City}-->
,<!--{$params.Province}--><br>
<!--{$params.Country}-->&nbsp;<!--{$params.Postcode}-->
                </p>
                <p style="padding:0px;margin:0px;padding:0 5px;font-size:20px;font-weight:600;line-height:20px;margin-top:1px;">
                    Send To:
                    <span style="padding:0px;margin:0px;font-weight:600;font-size:18px;">
                         <!--{$order.consignee}-->
                    </span>
                </p>
                <div style="padding-left:5px;margin:0px;text-align:left;line-height:20px;">
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt;font-size:18px;">
                        <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->
                    </p>
                    <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:5px;font-size:18px;">
                       <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}--> &nbsp;<!--{$order.zipcode}-->
                    </p>
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:18px;margin-bottom:2px">
                        <!--{$order.country}-->
                        <span style="padding:0px;margin:0px;font-size:18px">
                            (<!--{$order.Cncountry}-->)
                        </span>
                        <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;">
                        </span>
                        </span>
                    </p>
                    <p style="padding:0px;margin:0px;font-size:16px;">
                        <b><!--{$order.tel}--></b>
                    </p>
                    <div style="padding:0;margin:15px 0 0 0;text-align:left">
                    <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=50"></li>
 <center style="width:206px;margin-top:-20px;letter-spacing:4px;font-size:14px">*<!--{$order.order_sn}-->*</center>
                    </div>
                </div>
            </div>
        </div>
        <!--地址标签-->
        <div style="padding:0px;margin:0px;position:relative;top:0.3cm;width:6.8cm;height:8.9cm;border:1px solid #000;font-family:arial;font-size:12px;">
            <div style="padding:0px;margin:0px;width:6.5cm;position:absolute;height:1.8cm;left:0.1cm;text-align:center;margin:0px auto;">
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.02cm;border:0px;height:1cm;">
                    <tr style="padding:0px;margin:0px;border:0px;font-size:9px;height:0.3cm">
                        <td align="left" style="padding:0px;margin:0px;font-weight:bold;padding:2px;     border-collapse:collapse;
                        overflow:hidden;font-family:arial;font-size:12px;">
                            报关签条
                        </td>
                        <td>

                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm">
                        <td align="left" style="padding:2px;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-family:arial;font-size:10px;" height="0.2cm">
                            <b>
                                CUSTOMS DECLARATION
                            </b>
                        </td>
                        <td align="right" style="padding:0px;margin:0px;font-size:8px;">
                            邮 2113
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.2cm">
                        <td align="left" style="padding:2px;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:8px;">
                            可以径行开拆
                        </td>
                        <td align="right" style="padding:0px;margin:0px;font-family:arial;font-size:12px;">
                            <b>
                                CN22
                            </b>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.2cm">
                        <td align="left" style="padding:2px;     border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:9px;">
                            May be opened officially
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="padding:0px;margin:0px;width:6.5cm;position:absolute;top:1.4cm;left:0.1cm;text-align:center;margin:0px auto;">
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.1cm;border:1px solid #000000;height:1.5cm;">
                    <tr style="padding:0px;margin:0px;border:1px solid;font-size:10px;">
                        <td align="left" style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:9px" colspan="5">
                            <div style="padding:0px;margin:0px;float:left;width:2.1cm;height:0.6cm;">
                                <img src="http://www/cpowersoft.com/erp/themes/default/images/chinapost.png" style="padding:0px;margin:0px;height:0.6cm;"
                                />
                            </div>
                            <div style="padding:0px;margin:0px;float:right;font-size:9px;width:3.5cm;height:0.6cm;">
                                请先阅读背面的注意事项
                                <br />
                                See instructions on the back
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;font-size:2.4mm;width:2.4cm;" rowspan="2">
                            邮件种类
                            <br />
                            Category of item
                            <br />
                            (在适当的文字前划"√")
                            <br />
                            Tick as appropriate
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;overflow:hidden;width:10px;"
                            checked/>
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            礼品
                            <br />
                            Gift
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;width:10px;overflow:hidden;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            商品货样
                            <br />
                            Commercial
                            <br />
                            sample
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;border:1px solid;">
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;width:10px;overflow:hidden;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            文件
                            <br />
                            Documents
                        </td>
                        <td style="padding:0px;margin:0px;width:0.4cm;padding:0;">
                            <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:10px;overflow:hidden;width:10px;"
                            />
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;border-left:1px solid #000;">
                            其他
                            <br />
                            Other
                        </td>
                    </tr>
                </table>
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0cm;border:1px solid #000000;border-top:0px;height:1.5cm;">
                    <tr>
                        <td style="padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;border-bottom:1px solid #000; ">
                            内件详细名称和数量
                            <br />
                            Quantity and detailed description of contents
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;border-left:1px solid #000;">
                            重量（千克）
                            <br />
                            Weight(kg)
                        </td>
                        <td style="padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;border-bottom:1px solid #000; ">

                            价值
                            <br />
                            Value
                        </td>
                    </tr>
                     <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;height:25px;">
                        <td style="padding:2px;   border-right:1px solid #000;   border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;">
                           <!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;       border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;">
                            <span  contenteditable = "true"></span>
                        </td>
                        <td style="padding:2px;    border-right:1px solid #000;       border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;">
                            <span  contenteditable = "true"><!--{$goods.Declared_value}--></span>
                        </td>
                    </tr>
            <!--{/foreach}-->
                    <tr>
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000; border-top:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:3.5cm;font-size:6pt;text-align:left;">
                            协调系统税则号列和货物原产国（只对商品邮件填写）
                            <br />
                            HS tariff number and country of origin of goods(For commercial items only)
                        </td>
                        <td style="padding:2px;  border-top:1px solid #000;   border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.3cm;font-size:6pt;text-align:center;" rowspan="2"
                        valign="top">
                            总重量
                            <br />
                            Total Weight
                            <br />
                            <br />
                            <span  contenteditable = "true"></span>
                        </td>
                        <td style="padding:2px;border-top:1px solid #000; border-right:1px solid #000;border-bottom:1px solid #000;    border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;" rowspan="2" valign="top">
                            总价值
                            <br />
                            Total Value
                            <br />
                            <br />
                            <span  contenteditable = "true"><!--{$order.vartotalprice}--></span>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm;">
                        <td style="padding:2px;border-right:1px solid #000;border-bottom:1px solid #000;border-collapse:collapse;
                        overflow:hidden;">
                        </td>
                    </tr>
                </table>
                <p style="padding:0px;margin:0px;font-size:6pt;text-align:left;line-height:9px;">
                    我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品
                    <br />
                    I, the undersigned,certify that the particulars given in this declaration
                    are correct and this item does not contain any dangerous articles prohibited
                    by legislation or by postal or customs regulations.
                    <br />
                    寄件人签字 Sender's signature &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <font style="padding:0px;margin:0px;font-size:7pt">
                        SFC
                    </font>
                </p>
            </div>
        </div>
    </div>
</div>
<div style="clear:both;height:15px;"></div>
<!--{/foreach}-->
<!--{elseif $type eq 155}--><!--新加坡邮政小包(挂号)-->
<!--{foreach from =$orders item = order name=orderitem}-->
   <DIV style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; WIDTH:19cm; PADDING-RIGHT: 0px; PADDING-TOP: 0px"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style="padding:0px;margin:0px;font-family:arial;float:left;margin-top:0cm;width:7cm;height:8.9cm;border:1px solid #000;overflow:hidden;margin-top:1px;">
    <div style="padding:0px;margin:0px;font-family:arial;margin-top:0cm;width:7.2cm;height:9.4cm;border:1px solid #000;overflow:hidden">
        <div style="padding:0px;margin:0px;font-family:arial;padding:0.1cm;">
            <!--左边顶部-->
            <div style="padding:0px;margin:0px;font-family:arial;width:7.0cm;border-bottom:1px dotted #000000; height:1cm;">
                <div style="padding:0px;margin:0px;font-family:arial;float:left;width:3.7cm;font-weight:100;line-height:15pt;font-size:11px;">
                    CUSTOMS
                </div>
                <div style="padding:0px;margin:0px;font-family:arial;float:left;width:6.5cm;line-height:10pt;font-size:11px;white-space:nowrap;">
                    <span style="padding:0px;margin:0px;font-family:arial;margin-right:8px;">
                        DECLARATION
                    </span>
                    <span>
                        May be opened officially
                        <span style="padding:0px;margin:0px;font-family:arial;font-size:14px;font-weight:600;">
                            CN 22
                        </span>
                </div>
            </div>
            <!--左边顶部结束-->
            <div style="padding:0px;margin:0px;font-family:arial;width:6.8cm;">
                <table style="border:1px solid #000;
                border-collapse:collapse;
                overflow:hidden;padding:0px;margin:0px;font-family:arial;width:100%; font-size:10px;">
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                        <td colspan="3" style="border:1px solid #000;
                        border-collapse:collapse;
                        overflow:hidden;">
                            <span style="padding:0px;margin:0px;font-family:arial;float: left;">
                                Postal administration
                            </span>
                            <span style="padding:0px;margin:0px;font-family:arial;float:right;">
                                Tick as appropriate
                            </span>
                        </td>
                    </tr>
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                        <td colspan="3" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:100%;border:1px solid #000;
                        border-collapse:collapse;
                        overflow:hidden;">
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;width:1cm;border-right:1px solid #000;float:left;width:15%;">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;border-bottom:1px solid #000;">
                                    <input type="checkbox" checked />
                                </div>
                                <div>
                                    <input type="checkbox" />
                                </div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:1px solid #000;float:left;width:30%;">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;">
                                    Gift
                                </div>
                                <div>
                                    Documents
                                </div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:1px solid #000;float:left;width:15%;">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;border-bottom:1px solid #000;">
                                    <input type="checkbox" />
                                </div>
                                <div>
                                    <input type="checkbox" />
                                </div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:none;float:left;width:37%">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;">
                                    Commercial Sample
                                </div>
                                <div>
                                    Other
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;height:0.8cm:">
                        <td style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:3.7cm;">
                            Quantity and detailed
                            <br />
                            description of contents
                        </td>
                        <td align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:1.3cm;">
                            Weight
                            <br />
                            (in kg)
                        </td>
                        <td align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                            Value
                        </td>
                    </tr>
                     <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;height:25px">
                        <td valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;border-top:0;border-bottom:0; border-right:0;">
                           <!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;border-top:0;border-bottom:0">
                           <span  contenteditable = "true">0.050</span>
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;border-top:0;border-bottom:0; border-left:0">
                           <span  contenteditable = "true">$
<!--{$goods.vargoods_price|string_format:"%.2f"}--></span>
                        </td>
                    </tr>
                    <!--{/foreach}-->
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;height:1.5cm;">
                        <td valign="top" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                            <div style="padding:0px;margin:0px;font-family:arial;width:100%;border:0px solid #000;height:1.5cm;">
                                For commercial items only
                                <br />
                                <div style="padding:0px;margin:0px;font-family:arial;height:1px;">
                                    &nbsp;
                                </div>
                                <span style="padding:0px;margin:0px;font-family:arial;font-style:italic;font-size:6.5pt;">
                                    If know,HS tariff number
                                </span>
                                <br />
                                <span style="padding:0px;margin:0px;font-family:arial;font-style:italic;font-size:6.5pt;">
                                    and country of origin of goods
                                </span>
                            </div>
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                            Total weight
                            <br />
                            (in kg)
                            <br/>
                            &nbsp;&nbsp;<span  contenteditable = "true">0.200</span>
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                            Total Value
                            <br/>
                            &nbsp;&nbsp;
                            <br/>
                            <br/>
                            &nbsp;&nbsp;<span  contenteditable = "true">$<!--{$order.vartotalprice|string_format:"%.2f"}--></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                            I, the undersigned,whose name and address are given on the item,certify
                            that the particulars given in this declaration are correct and that this
                            item dose not contain any dangerous article or articles prohibited by legislation
                            or by customs regulations.
                            <div style="padding:0px;margin:0px;font-family:arial;width:6.5cm;font-size:7pt;margin-top:2px; ">
                                (8)Date and sender's signature From:ken
                            </div>
                        </td>
                    </tr>
                </table>
                <div style="padding:0px;margin:0px;font-family:arial;border-bottom:0px dotted #000000;width:6.5cm;height:2px;margin-top:10px; font-size:0px;">
                    &nbsp;
                </div>
            </div>
        </div>
    </div>
</div>
<div style="padding:0px;margin:0px;font-family:arial;float:left;margin-right:0.2cm;width:9cm;height:8.9cm;position:relative;border:1px solid #000;overflow:hidden;">
    <div style="padding:0px;margin:0px;font-family:arial;margin-top:0cm;width:9cm;height:8.9cm;border:0px solid #000;overflow:hidden">
        <div style="padding:0px;margin:0px;font-family:arial;padding:0.2cm;">
            <div style="padding:0px;margin:0px;font-family:arial;height:70%;width:100%;position: relative;">
                <div style="padding:0px;margin:0px;font-family:arial;width:58%;float:left;margin-top:0.1cm;padding-left:5px;">
                    <div style="padding:0px;margin:0px;font-family:arial;width:4.2cm;height:1.5cm;font-size: 12px;">
                        c/o ATC CHANGI AIRFREIGHT CENTRE P.O.BOX. 946 SINGAPORE 918115
                    </div>
                    <div style="padding:0px;margin:0px;font-family:arial;font-weight:600;">
                        R-852-340336
                    </div>
                    <div style="padding:0px;margin:0px;font-family:arial;margin-top:20px;margin-bottom:10px;position:relative;left:-20px;">
                    </div>
                   <div style="padding:0px;margin:0px;font-family:arial;width:8cm;word-wrap: break-word; word-break:break-all;position:absolute;">
                    <div style="padding:0px;margin:0px;font-family:arial;float:left;font-size:16px;font-weight:600;width:30px;">TO:</div>
                    <div style="padding:0px;margin:0px;font-family:arial;float:left;width:7cm;" ><!--{$order.consignee}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;clear:left;padding-left:30px;font-weight:600;"> <!--{$order.street1}-->&nbsp; <!--{$order.street2}--> </div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.tel}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.country}--></div>
                </div>
                </div>
                <div style="padding:0px;margin:0px;font-family:arial;left;margin-top:0.1cm;position:absolute;left:160px;">
                    <div style="padding:0px;margin:0px;font-family:arial;margin-bottom:0.3cm">
                        <img src="image/SINGAPORE.jpg" style="padding:0px;margin:0px;font-family:arial;width:4.2cm;height:2.4cm"/>
                    </div>
                </div>
            </div>
            <div>
                <div style="padding:0px;margin:0px;font-family:arial;float:left;width:56%;border:1px solid #000;"><center>
                    <div style="padding:0px;margin:0px;font-family:arial;font-weight:300;margin-top:10px;">SINGAPORE
                    </div></center>
                    <div>
                         <center><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=40"></center>
                          <center style="font-size:13px;margin-top:-20px;" >*<!--{$order.track_no}-->*</center>
                    </div>
                </div>
                <div style="padding:0px;margin:0px;font-family:arial;float:left;padding-left:20px;width:3.5cm;position:absolute;left:180px;">
                    <div style="padding:0px;margin:0px;font-family:arial;font-weight:600;padding-left:20px;">REGISTERED
                    </div>
                    <div style="padding:0px;margin:0px;font-family:arial;font-weight:600;padding-left:30px;">
                        AIR MAIL
                    </div>
                    <div style="padding:0px;margin:0px;font-family:arial;margin-top:20px;padding-left:30px;font-size:10px;">
                        <!--{$order.order_sn}-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div></div>
<!--{/foreach}-->
<!--{elseif $type eq 156}--><!--新加坡邮政小包(平邮)-->
<!--{foreach from =$orders item = order name=orderitem}-->
 <DIV style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; WIDTH:19cm; PADDING-RIGHT: 0px; PADDING-TOP: 0px"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style="padding:0px;margin:0px;font-family:arial; margin-left:2px;float:left;width:7cm;height:9cm;border:2px solid #000;overflow:hidden;">
    <div style="padding:0px;margin:0px;font-family:arial;margin-top:0cm;width:7.2cm;height:9.4cm;border:1px solid #000;overflow:hidden">
        <div style="padding:0px;margin:0px;font-family:arial;padding:0.1cm;">
            <!--左边顶部-->
            <div style="padding:0px;margin:0px;font-family:arial;width:7.0cm;border-bottom:1px dotted #000000; height:1cm;">
                <div style="padding:0px;margin:0px;font-family:arial;float:left;width:3.7cm;font-weight:100;line-height:15pt;font-size:11px;">CUSTOMS</div>
                <div style="padding:0px;margin:0px;font-family:arial;float:left;width:6.5cm;line-height:10pt;font-size:11px;white-space:nowrap;">
                    
                    <span style="padding:0px;margin:0px;font-family:arial;margin-right:8px;">DECLARATION</span><span>May be opened officially <span style="padding:0px;margin:0px;font-family:arial;font-size:14px;font-weight:600;">CN 22</span>
                </div>
            </div><!--左边顶部结束-->

            <div style="padding:0px;margin:0px;font-family:arial;width:6.8cm;">
                <table style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:100%; height:4.5cm;font-size:10px;" >
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;"><td colspan="3" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;"><span style="padding:0px;margin:0px;font-family:arial;float: left;">Postal administration</span><span style="padding:0px;margin:0px;font-family:arial;float:right;">Tick as appropriate</span></td></tr>
                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">
                        <td colspan="3" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:100%">
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;width:1cm;border-right:1px solid #000;float:left;width:15%;">
                                <div  style="padding:0px;margin:0px;font-family:arial;height:0.5cm;border-bottom:1px solid #000;"><input type="checkbox" checked /></div>
                                <div><input type="checkbox" /></div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:1px solid #000;float:left;width:30%;">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;">Gift</div>
                                <div>Documents</div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:1px solid #000;float:left;width:15%;">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;border-bottom:1px solid #000;"><input type="checkbox"  /></div>
                                <div><input type="checkbox"  /></div>
                            </div>
                            <div style="padding:0px;margin:0px;font-family:arial;height:1.0cm;border-right:none;float:left;width:37%">
                                <div style="padding:0px;margin:0px;font-family:arial;height:0.5cm;">Commercial Sample</div>
                                <div>Other</div>
                            </div>
                        </td>
                    </tr>
                    <tr  style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;height:0.8cm:"><td style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:3.7cm;">Quantity and detailed<br /> description of contents</td><td align="center"  style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;width:1.3cm;">Weight<br />(in kg)</td><td align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">Value</td>
                    </tr>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;">
                        <td valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;border-top:0;border-bottom:0; border-right:0;">
                           <!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;border-top:0;border-bottom:0">
                           <span  contenteditable = "true">0.050</span>
                        </td>
                        <td valign="top" align="center" style="border:1px solid #000;border-top:0;border-bottom:0; border-left:0">
                           <span  contenteditable = "true">$
<!--{$goods.vargoods_price|string_format:"%.2f"}--></span>
                        </td>
                    </tr>
                    <!--{/foreach}-->

                    <tr style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;padding:0px;margin:0px;font-family:arial;height:1.5cm;"><td  valign="top" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;" ><div style="padding:0px;margin:0px;font-family:arial;width:100%;border:0px solid #000;height:1.5cm;">For commercial items only<br /><div style="padding:0px;margin:0px;font-family:arial;height:1px;">&nbsp;</div><span style="padding:0px;margin:0px;font-family:arial;font-style:italic;font-size:6.5pt;">If know,HS tariff number</span><br />
                        <span style="padding:0px;margin:0px;font-family:arial;font-style:italic;font-size:6.5pt;">and country of origin of goods</span></div></td><td  valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">Total weight<br />(in kg)<br/>&nbsp;&nbsp;<span  contenteditable = "true">0.200</span></td><td  valign="top" align="center" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">Total Value<br/>&nbsp;&nbsp;<br/><br/>&nbsp;&nbsp;<span  contenteditable = "true">$<!--{$order.vartotalprice|string_format:"%.2f"}--></span></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border:1px solid #000;
    border-collapse:collapse;
    overflow:hidden;">   I, the undersigned,whose name and address are given on the item,certify that the particulars given in this declaration are correct and that this item dose not contain any dangerous article or articles prohibited by legislation or by customs regulations.
                            <div  style="padding:0px;margin:0px;font-family:arial;width:6.5cm;font-size:7pt;margin-top:2px; ">
                                (8)Date and sender's signature From:Bicky
                            </div>
                        </td>
                    </tr>
                </table>
                <div style="padding:0px;margin:0px;font-family:arial;border-bottom:0px dotted #000000;width:6.5cm;height:2px;margin-top:10px; font-size:0px;">&nbsp;</div>

            </div>
        </div>
    </div>
</div>

<div style="padding:0px;margin:0px;font-family:arial;float:left;margin-right:0.2cm;width:9cm;height:9cm;position:relative;border:2px solid #000;overflow:hidden;">
<div style="padding:0px;margin:0px;font-family:arial;margin-top:0cm;width:9cm;height:8.9cm;border:0px solid #000;overflow:hidden;">
        <div style="padding:0px;margin:0px;font-family:arial;height:70%;width:100%;position:relative;">
            <div style="padding:0px;margin:0px;font-family:arial;width:58%;float:left;margin-top:0.1cm;padding-left:5px;">
                <div style="padding:0px;margin:0px;font-family:arial;width:4.2cm;height:1.8cm;font-size:12px;">c/o ATC
CHANGI AIRFREIGHT CENTRE
P.O.BOX. 946
SINGAPORE 918115</div>
                <div style="padding:0px;margin:0px;font-family:arial;font-weight:600;margin-bottom:2cm;">R-852-340336</div>

                <div style="padding:0px;margin:0px;font-family:arial;width:8cm;word-wrap: break-word; top:188px; word-break:break-all;position:absolute;">
                    <div style="padding:0px;margin:0px;font-family:arial;float:left;font-size:16px;font-weight:600;width:30px;">TO:</div>
                    <div style="padding:0px;margin:0px;font-family:arial;float:left;width:7cm;" ><!--{$order.consignee}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;clear:left;padding-left:30px;font-weight:600;"> <!--{$order.street1}-->&nbsp; <!--{$order.street2}--> </div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.tel}--></div>
                    <div style="padding:0px;margin:0px;font-family:arial;padding-left:30px;"><!--{$order.country}--></div>
                </div>
            </div>
            <div style="padding:0px;margin:0px;font-family:arial;float:left;margin-top:0.1cm;position:absolute;left:170px">
                <div style="padding:0px;margin:0px;font-family:arial;margin-bottom:0.3cm"><img src="/app/images/singapore_gh1.gif" style="padding:0px;margin:0px;font-family:arial;width:4.4cm;height:2.4cm"/></div>
                <div>Ref:<!--{$order.track_no}--></div>
                <div style="padding:0px;margin:0px;font-family:arial;margin-top:10px;margin-bottom:10px;position:relative;left:-50px;">
                    <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=40"></li>
                </div>
            </div>
        </div>
        <div>

            <div style="padding:0px;margin:0px;font-family:arial;float:left;padding-left:20px;">

                <div style="padding:0px;margin:0px;font-family:arial;font-weight:600;padding-left:10px;margin-top:1.5cm;">AIR MAIL</div>
                <div style="padding:0px;margin:0px;font-family:arial;margin-top:15px;padding-left:220px;font-size:10px;"><!--{$order.order_sn}--></div>
            </div>
        </div>
</div>

</div></div>
<!--{/foreach}-->
<!--{elseif $type eq 151}--><!--瑞士邮政小包（挂号）-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="padding:0px;margin:0px;width: 9.7cm;"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
    <div style='height:0.1cm;*height:0;overflow:hidden;font-size:0;width:20cm'>
    </div>
    <div style="padding:0px;margin:0px;width:20cm;height:8.9cm;float:left;margin-top:0px;margin-bottom:0px;overflow:hidden;">
        <div style="padding:0px;margin:0px;float:left;height:8.7cm;width:8.5cm;line-height:16px;font:12pt Verdana;">
            <div style="padding:0px;margin:0px;float:left;height:2cm;width:8.4cm;border:1px dotted #000;margin-left:2px;display:inline; position:relative;">
                &nbsp;
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:6.1cm;height:1.7cm;border:1px solid #000;margin:auto; position:absolute;top:0px; left:40px; "
                align="center">
                    <tr>
                        <td colspan="2" style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:6.5cm; height:0.2cm;font-size:10px"
                        align="center">
                            <b>
                                ECONOMY
                            </b>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:3.5cm;padding-top:0px"
                        align="left">
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                If undeliverable,please
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                return to:Exchange Office
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:8px;line-height:10px; width:3.5cm;">
                                SPI HKG 00006372
                                <br />
                                8010 Zurich-Mulligen
                                <br />
                                Switzerland
                            </span>
                        </td>
                        <td style="padding:0px;margin:0px;text-align:center; font-size:9px;line-height:9px;border:1px solid #000; border-collapse:collapse;height:0.6cm;width:2cm;">
                            P.P.
                            <br />
                            Swiss Post
                            <br />
                            CH-8010 Zurich
                            <br />
                            Mulligen
                        </td>
                    </tr>
                </table>
            </div>
            <div style="padding:0px;margin:0px;float:left;height:6.64cm;width:8.4cm;margin-left:2px;margin-top:5px;display:inline;overflow:hidden;border:1px dashed #000;">
                <div style="padding:0px;margin:0px;height:0.2cm;width:8.4cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:0;">
                    &nbsp;
                </div>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;">
                    <span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;">
                       
                    </span>
                    From: <!--{$params.Contact}-->
                </p>
                <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;">
                </p>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">
                    Send To:
                    <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;">
 <!--{$order.consignee}-->
                    </span>
                </p>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">
                    Company:
                    <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;">
                    </span>
                </p>
                <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt">
                        <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->&nbsp;<!--{$order.city}-->&nbsp;<!--{if $order.state}--><!--{$order.state}-->&nbsp;<!--{/if}--></p>
                    <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;">     <!--{$order.zipcode}-->
                    </p>
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
                        <!--{$order.country}-->
                        <span style="padding:0px;margin:0px;font-size:10pt">(<!--{$order.Cncountry}-->)
                        </span>
                        <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;">
                        </span>
                        </span>
                    </p>
                    <p style="padding:0px;margin:0px;font-size:9pt;">
                    </p>
                    <div style="padding:0px;margin:0px;position:relative; margin-left:-32px;">
                        <table style="padding:0px;margin:0px;width:100%"> <tr>
                                <td style="padding:0px;margin:0px;width:90%;text-align:center">
                                    <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=30"></li>
 <center style="font-size:13px;margin-top:-20px;" >*<!--{$order.track_no}-->*</center>
                                </td>
                                <td style="padding:0px;margin:0px;font-weight:bold">
                                    C
                                </td>
                            </tr>
                        </table>
                        <span style="padding:0px;margin:0px;font-size:13px;clear:left;">

                        </span>
                    </div>
                    <span style="padding:0px;margin:0px;margin-right: 0cm; float: right; margin-top: -0.90cm;font-size:23pt;">
                        R
                    </span>
                    <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-8px;margin-right:16px;font-size:10pt">
                        ◎SWBRAM
                    </p>
                </div>
            </div>
        </div>
        <div style="padding:0px;margin:0px;position:relative;float:left;margin-top:0cm;width:7.5cm;height:8.82cm;border:0px solid #000;overflow:hidden;margin-left:0.2cm;font-family:arial;">
            <div style="padding:0px;margin:0px;margin-top:0cm;width:7.4cm;height:8.75cm;border:1px solid #000;overflow:hidden">
                <div style="padding:0px;margin:0px;padding:0.2cm 0.1cm;">
                    <div style="padding:0px;margin:0px;width:7.2cm; height:1.1cm;">
                        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:1cm;line-height:10pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:left;width:4cm">
                                <img src="image/SWISSPOST.jpg" style="padding:0px;margin:0px;width:3.8cm;height:0.8cm;"
                                />
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm;font-weight:500">
                                Postal administration
                            </li>
                        </ul>
                        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.8cm;line-height:10pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:12pt;text-align:right;width:3cm;font-weight:700;height:0.8cm">
                                CN 22
                                <br />
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm; font-weight:550;">
                                CUSTOMS DECLARATION
                            </li>
                        </ul>
                    </div>
                    <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px solid #000000; height:0.6cm; margin-top:0px;">
                        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:0.6cm;line-height:9pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm">
                                &nbsp;
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm; word-spacing:0px;">
                                (Please check on appropriate option)
                            </li>
                        </ul>
                        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.6cm;line-height:8pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:right;width:3cm;font-weight:700;">
                                (May be opened officially)
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">
                            </li>
                        </ul>
                    </div>
                    <div style="padding:0px;margin:0px;width:7.2cm; margin-top:0px; ">
                        <table style="padding:0px;margin:0px;width:100%;border:0;font-size:7pt;height:0.9cm;font-family:arial;">
                            <tr style="padding:0px;margin:0px;border:0;height:0.45cm">
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Gift
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Commercial sample
                                </td>
                            </tr>
                            <tr style="padding:0px;margin:0px;border:0;height:0.45cm" valign="bottom">
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Documents
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    checked />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <div style="padding:0px;margin:0px;word-wrap:normal;">
                                        <span style="padding:0px;margin:0px;float:left;">
                                            Other
                                        </span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table style="padding:0px;margin:0px;width:100%; font-size:5pt;height:3.8cm;"  cellpadding="0" cellspacing="0">
                            <tr style="padding:0px;margin:0px;">
                                <td style="padding:0px;margin:0px;width:3.7cm; height:0.8cm; border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-left:0;border-right:0;">
                                    (1) Quantity and detailed
                                    <br />
                                    description of contents
                                </td>
                                <td align="center" style="padding:0px;margin:0px;width:2cm; border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;">
                                    (2)Weight(kg)
                                </td>
                                <td align="center" style="padding:0px;margin:0px; border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-left:0;border-right:0;">
                                    (3)Value
                                </td>
                            </tr>
                            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;border-left:0;border-right:0;">
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;">
<font style="padding:0px;margin:0px;font-size:8pt; ">
<!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
</font></td>
<td valign="middle" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-top:0;border-bottom:0">
<font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">0.050</span>
</font>
</td>
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px">
<font style="padding:0px;margin:0px;font-size:8pt;">
<span  contenteditable = "true">$
<!--{$goods.vargoods_price|string_format:"%.2f"}--></span>
</font>
</td>
</tr>
<!--{/foreach}-->
                            <tr style="padding:0px;margin:0px;height:1cm;border-left:0;border-right:0;">
                                <td valign="top" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;width:3.7cm;border-left:0;border-right:0;">
                                    <div style="padding:0px;margin:0px;width:100%;border:0px solid #000;height:1.2cm;">
                                        <div style="padding:0px;margin:0px;width:100%; height:0.3cm; font-size:6pt; border-bottom:0px solid #000; text-decoration:underline;">
                                            For commercial items only
                                        </div>
                                        <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin:0;padding:0;">
                                            If know,HS tariff number(4) and
                                            <br />
                                            country of origin of goods(5)
                                        </span>
                                    </div>
                                </td>
                                <td valign="top" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;width:2cm;">
                                    (6) Total weight (kg)
                                    <br />
                                    <br />                    <font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">
                                        0.200</span>
</font>
                                    </font>
                                </td>
                                <td valign="top" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;border-left:0;border-right:0;">
                                    (7)Total Value
                                    <br />
                                    <br />
                                    <font style="padding:0px;margin:0px;font-size:8pt">
                                        <span  contenteditable = "true">$<!--{$order.vartotalprice|string_format:"%.2f"}--></span>
                                    </font>
                                </td>
                            </tr>
                            </tr>
                        </table>
                        <div style="padding:0px;margin:0px;font-size:5pt;margin-top:6px; width:7.2cm">
                            I, the undersigned,whose name and address are given on the item,certify
                            that the particulars given in this declaration are correct and that this
                            item dose not contain any dangerous article or articles prohibited by legislation
                            or by customs regulations.
                        </div>
                        <div style="padding:0px;margin:0px;font-size:6pt;margin-top:0px; width:7.2cm;height:0.4cm;">
                        </div>
                        <div style="padding:0px;margin:0px;width:7.2cm;font-size:6pt;margin-top:2px; height:0.3cm; border-bottom:1px solid #000;">
                            (8)Date and sender's signature &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <font style="padding:0px;margin:0px;font-size:7pt;">
                                SFC
                            </font>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 152}--><!--瑞士邮政小包（平邮）-->
<!--{foreach from =$orders item = order name=orderitem}-->
  <div style="padding:0px;margin:0px;width: 9.7cm;"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
     <div style='height:0.1cm;*height:0;overflow:hidden;font-size:0;width:20cm'>
    </div>
    <div style="padding:0px;margin:0px;width:20cm;height:8.9cm;float:left;margin-top:0px;margin-bottom:0px;overflow:hidden;">
        <div style="padding:0px;margin:0px;float:left;height:8.7cm;width:8.5cm;line-height:16px;font:12pt Verdana;">
            <div style="padding:0px;margin:0px;float:left;height:2cm;width:8.4cm;border:1px dotted #000;margin-left:2px;display:inline; position:relative;">
                &nbsp;
                <table style="padding:0px;margin:0px;border-collapse:collapse;width:6.1cm;height:1.7cm;border:1px solid #000;margin:auto; position:absolute;top:0px; left:40px; "
                align="center">
                    <tr>
                        <td colspan="2" style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:6.5cm; height:0.2cm;font-size:10px"
                        align="center">
                            <b>
                                ECONOMY
                            </b>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:3.5cm;padding-top:0px"
                        align="left">
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                If undeliverable,please
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                return to:Exchange Office
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:8px;line-height:10px; width:3.5cm;">
                                SPI HKG 00006372
                                <br />
                                8010 Zurich-Mulligen
                                <br />
                                Switzerland
                            </span>
                        </td>
                        <td style="padding:0px;margin:0px;text-align:center; font-size:9px;line-height:9px;border:1px solid #000; border-collapse:collapse;height:0.6cm;width:2cm;">
                            P.P.
                            <br />
                            Swiss Post
                            <br />
                            CH-8010 Zurich
                            <br />
                            Mulligen
                        </td>
                    </tr>
                </table>
            </div>
            <div style="border:1px dashed #000;padding:0px;margin:0px;float:left;height:6.64cm;width:8.4cm;margin-left:2px;margin-top:5px;display:inline;overflow:hidden">
                <div style="padding:0px;margin:0px;height:0.2cm;width:8.4cm;overflow:hidden;text-align:center;font-size:7pt;word-wrap:break-word;border:0;">
                    &nbsp;
                </div>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;padding-top:3px;">
                    <span style="padding:0px;margin:0px;float:right;margin-right:1.0cm;font-size:9pt;font-weight:600;">
                        <!--{$order.order_sn}-->
                    </span>
                    From: <!--{$params.Contact}-->
                </p>
                <p style="padding:0px;margin:0px;padding:0px 10px;font-size:8pt;line-height:16px;">
                </p>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;line-height:20px;margin-top:1px;">
                    Send To:
                    <span style="padding:0px;margin:0px;font-weight:600;font-size:10pt;">
                       <!--{$order.consignee}-->
                    </span>
                </p>
                <p style="padding:0px;margin:0px;padding-left:10px;font-size:9pt;font-weight:600;">
                    Company:
                    <span style="padding:0px;margin:0px;font-weight:600;font-size:12pt;">
                    </span>
                </p>
                <div style="padding:0px;margin:0px;text-align:center;line-height:20px;">
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:10pt">
                      <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->
                    </p>
                    <p style="padding:0px;margin:0px;font-weight:600;margin-bottom:2px;font-size:10pt;">
                        <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}-->&nbsp;<!--{$order.zipcode}-->
                    </p>
                    <p style="padding:0px;margin:0px;font-weight:600;font-size:9pt;margin-bottom:2px">
                        <!--{$order.country}-->
                        <span style="padding:0px;margin:0px;font-size:10pt">
                           (<!--{$order.Cncountry}-->)
                        </span>
                        <span style="padding:0px;margin:0px;border-top:3px solid #000;border-bottom:3px solid #000;font-weight:600;font-size:9pt;">
                        </span>
                        </span>
                    </p>
                    <p style="padding:0px;margin:0px;font-size:9pt;">
                        Tel: <!--{$order.tel}-->
                    </p>
                    <div style="padding:0px;margin:0px;position:relative; margin-left:-32px;">
                        <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=40"></li>
 <center style="font-size:13px;margin-top:-20px;" >*<!--{$order.track_no}-->*</center>
                    </div>
                    <p style="padding:0px;margin:0px;font-weight:bold;text-align:right;margin-top:-8px;margin-right:16px;font-size:10pt">
                        SWBAM
                    </p>
                </div>
            </div>
        </div>
        <div style="padding:0px;margin:0px;position:relative;float:left;margin-top:0cm;width:7.5cm;height:8.82cm;border:0px solid #000;overflow:hidden;margin-left:0.2cm;font-family:arial;">
            <div style="padding:0px;margin:0px;margin-top:0cm;width:7.4cm;height:8.75cm;border:1px solid #000;overflow:hidden">
                <div style="padding:0px;margin:0px;padding:0.2cm 0.1cm;">
                    <div style="padding:0px;margin:0px;width:7.2cm; height:1.1cm;">
                        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:1cm;line-height:10pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:8.5pt;text-align:left;width:4cm">
                                <img src="image/SWISSPOST.jpg" style="padding:0px;margin:0px;width:3.8cm;height:0.8cm;"
                                />
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm;font-weight:500">
                                Postal administration
                            </li>
                        </ul>
                        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.8cm;line-height:10pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:12pt;text-align:right;width:3cm;font-weight:700;height:0.8cm">
                                CN 22
                                <br />
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm; font-weight:550;">
                                CUSTOMS DECLARATION
                            </li>
                        </ul>
                    </div>
                    <div style="padding:0px;margin:0px;width:7.2cm;border-bottom:1px solid #000000; height:0.6cm; margin-top:0px;">
                        <ul style="padding:0px;margin:0px;float:left;width:4cm;font-weight:700;height:0.6cm;line-height:9pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm">
                                &nbsp;
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:left;width:4cm; word-spacing:0px;">
                                (Please check on appropriate option)
                            </li>
                        </ul>
                        <ul style="padding:0px;margin:0px;float:left;width:3cm;height:0.6cm;line-height:8pt;">
                            <li style="padding:0px;margin:0px;float:left;font-size:5pt;text-align:right;width:3cm;font-weight:700;">
                                (May be opened officially)
                            </li>
                            <li style="padding:0px;margin:0px;float:left;font-size:6pt;text-align:right;width:3cm">
                            </li>
                        </ul>
                    </div>
                    <div style="padding:0px;margin:0px;width:7.2cm; margin-top:0px; ">
                        <table style="padding:0px;margin:0px;width:100%;border:0;font-size:7pt;height:0.9cm;">
                            <tr style="padding:0px;margin:0px;border:0;height:0.45cm">
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Gift
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Commercial sample
                                </td>
                            </tr>
                            <tr style="padding:0px;margin:0px;border:0;height:0.45cm" valign="bottom">
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    Documents
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <input type="checkbox" style="padding:0px;margin:0px;display:block; padding:0px; margin:0px; height:16px;"
                                    checked />
                                </td>
                                <td style="padding:0px;margin:0px;border:0;">
                                    <div style="padding:0px;margin:0px;word-wrap:normal;">
                                        <span style="padding:0px;margin:0px;float:left;">
                                            Other
                                        </span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table style="padding:0px;margin:0px;width:100%;height:3.5cm; font-size:5pt;" cellpadding="0" cellspacing="0">
                            <tr style="padding:0px;margin:0px;">
                                <td style="border:1px solid #000;    border-collapse:collapse;    overflow:hidden;padding:0px;margin:0px;width:3.7cm; height:0.8cm;border-left:0;border-right:0;">
                                    (1) Quantity and detailed
                                    <br />
                                    description of contents
                                </td>
                                <td align="center" style="border:1px solid #000;border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;width:2cm;">
                                    (2)Weight(kg)
                                </td>
                                <td align="center" style="border:1px solid #000;border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;border-left:0;border-right:0;">
                                    (3)Value
                                </td>
                            </tr>
                                           <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<tr style="padding:0px;margin:0px;border-left:0;border-right:0;">
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px;">
<font style="padding:0px;margin:0px;font-size:8pt; ">
<!--{$goods.dec_name}-->&nbsp;*&nbsp;<!--{$goods.goods_qty}-->
</font></td>
<td valign="middle" align="center" style=" border:1px solid #000;border-collapse:collapse;    overflow:hidden;font-family:arial;border-top:0;border-bottom:0">
<font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">0.050</span>
</font>
</td>
<td valign="middle" align="center" style="border-collapse:collapse;    overflow:hidden;font-family:arial;padding:0px;margin:0px">
<font style="padding:0px;margin:0px;font-size:8pt;">
<span  contenteditable = "true">$
<!--{$goods.vargoods_price|string_format:"%.2f"}--></span>
</font>
</td>
</tr>
<!--{/foreach}-->
                            <tr style="padding:0px;margin:0px;height:1cm;border-left:0;border-right:0;">
                                <td valign="top" style="border:1px solid #000; padding:0px;margin:0px;width:3.7cm;border-left:0;border-right:0;">
                                    <div style="padding:0px;margin:0px;width:100%;border:0px solid #000;height:1.2cm;">
                                        <div style="padding:0px;margin:0px;width:100%; height:0.3cm; font-size:6pt; border-bottom:0px solid #000; text-decoration:underline;">
                                            For commercial items only
                                        </div>
                                        <span style="padding:0px;margin:0px;font-style:italic;font-size:6pt; margin:0;padding:0;">
                                            If know,HS tariff number(4) and
                                            <br />
                                            country of origin of goods(5)
                                        </span>
                                    </div>
                                </td>
                                <td valign="top" align="center" style="border:1px solid #000;padding:0px;margin:0px;width:2cm;">
                                    (6) Total weight (kg)
                                    <br />
                                    <br />
                                    <font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">
                                        0.200</span>
                                    </font>
                                </td>
                                <td valign="top" align="center" style="border:1px solid #000;padding:0px;margin:0px;border-left:0;border-right:0;">
                                    (7)Total Value
                                    <br />
                                    <br />
                                    <font style="padding:0px;margin:0px;font-size:8pt"><span  contenteditable = "true">$<!--{$order.vartotalprice|string_format:"%.2f"}--></span>
                                    </font>
                                </td>
                            </tr>
                            </tr>
                        </table>
                        <div style="padding:0px;margin:0px;font-size:5pt;margin-top:6px; width:7.2cm">
                            I, the undersigned,whose name and address are given on the item,certify
                            that the particulars given in this declaration are correct and that this
                            item dose not contain any dangerous article or articles prohibited by legislation
                            or by customs regulations.
                        </div>
                        <div style="padding:0px;margin:0px;font-size:6pt;margin-top:0px; width:7.2cm;height:0.4cm;">
                        </div>
                        <div style="padding:0px;margin:0px;width:7.2cm;font-size:6pt;margin-top:2px; height:0.3cm; border-bottom:1px solid #000;">
                            (8)Date and sender's signature &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <font style="padding:0px;margin:0px;font-size:7pt;">
                                SFC
                            </font>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <!--{/foreach}-->
<!--{elseif $type eq 2}--><!-打印拣货信息->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="border-bottom:dotted;width:450px;height:150px" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li><span class="STYLE1">*<!--{if $type eq 2}--><!--{$order.order_sn}--><!--{else}--><!--{$order.track_no}--><!--{/if}-->*</span></li>
<li><!--{$order.good_printstr}--></li>
<!--{if $order.note}--><li>备注:<!--{$order.note}--></li><!--{/if}-->
<li><br></li>
</ul>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 3}--><!-打印商业invoice->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table width="792" height="938" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr height="33">
    <td height="33" colspan="9"><div align="center">
      <h1><strong>COMMERCIAL INVOICE</strong></h1>
    </div></td>
  </tr>
  
  <tr height="18">
    <td height="50" colspan="4" bgcolor="#FFFF00" valign="top"><strong>International    Air Waybill No:<br />
    </strong></td>
    <td colspan="5" valign="top"><strong>Date of Exportation:<br />
    </strong><!--{$today}--></td>
  </tr>
  
  <tr height="19">
    <td colspan="4" height="50"><strong>Shipper/Exportation:</strong><br />
    Arinna International (HK) CO.,Ltd.</td>
    <td colspan="5" bgcolor="#FFFF00"><strong>Consignee:</strong><br />
  <!--{$order.consignee}--></td>
  </tr>
  
  <tr height="180">
    <td height="168" colspan="4" valign="top"><strong>From:</strong><br>
    Le feng lou,301,Dong Le Hua Yuan,Buxin Road<br>Luohu District, Shenzhen<br>GuangDong<br>China
    </td>
    <td colspan="5" valign="top" bgcolor="#FFFF00"><strong>To:</strong><br />
<!--{$order.consignee}--><br><!--{$order.street1}-->  <!--{$order.street2}--><br><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--><br><br><!--{$order.country}--></td>
  </tr>
  <tr height="54">
    <td width="50" height="54"><div align="center"><strong>Phone:</strong></div></td>
    <td colspan="3"> 86-0755-22258547</td>
    <td colspan="2"><div align="center"><strong>Phone:</strong></div></td>
    <td colspan="3" bgcolor="#FFFF00"><!--{$order.tel}--></td>
  </tr>
  <tr height="50">
    <td colspan="4" height="41"><strong>Country of Export:<br />
   </strong>   China</td>
    <td colspan="5" bgcolor="#FFFF00"><strong>Country of destination:<br />
  </strong>   <!--{$order.country}--></td>
  </tr>
  <tr height="38">
    <td colspan="3"><strong>Description of Goods</strong></td>
    <td width="65"><strong>Model</strong></td>
    <td width="65"><strong>QTY</strong></td>
    <td width="91"><strong>Unit Value</strong></td>
    <td width="182" colspan="2"><strong>Total Value</strong></td>
  </tr>
    <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
  <tr height="42">
    <td height="36" colspan="3">Jewelry</td>
    <td><!--{$goods.goods_sn}--></td>
    <td><!--{$goods.goods_qty}--></td>
    <td>$<!--{$goods.vargoods_price|string_format:"%.2f"}--> </td>
    <td colspan="2">$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></td>
  </tr>
  <!--{/foreach}-->
  <tr height="30">
    <td colspan="3" height="59"><strong>Total No. of pkgs</strong></td>
    <td width="235"><!--{$order.total}--></td>
    <td colspan="2"><div align="center"><strong>Total    Inv.Value</strong></div></td>
    <td colspan="3">$<!--{$order.vartotalprice|string_format:"%.2f"}--></td>
  </tr>
  
  <tr>
    <td height="21" colspan="9"><p><strong>Reason for Export：<br />
      </strong></p>    </td>
  </tr>
  <tr height="18">
    <td colspan="9"><p><strong>Shipping Details:</strong> <br />
      We certify and pledge that all information filled in this document is   conformed to the details declared to the Customs and conformed to the   actual conditions of the goods in the shipment.</p>
      <p><br />
      </p></td>
  </tr>
  
  <tr height="19">
    <td colspan="5" height="19"><div align="center"><strong>Shipper's    Signature</strong></div></td>
    <td colspan="4"><div align="center"><strong>Date</strong></div></td>
  </tr>
   <tr height="19">
    <td height="115" colspan="5" valign="bottom"><div align="center">----------------------------------</div></td>
    <td colspan="4" valign="bottom"><div align="center">--------------------------------</div></td>
  </tr>
</table>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 9}--><!-打印形式invoice->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table width="792" height="938" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr height="33">
    <td height="33" colspan="9"><div align="center">
      <h1><strong>PROFORMA INVOICE</strong></h1>
    </div></td>
  </tr>
  
  <tr height="18">
    <td height="50" colspan="4" bgcolor="#FFFF00" valign="top"><strong>International    Air Waybill No:<br />
    </strong></td>
    <td colspan="5" valign="top"><strong>Date of Exportation:<br />
    </strong><!--{$today}--></td>
  </tr>
  
  <tr height="19">
    <td colspan="4" height="50"><strong>Shipper/Exportation:</strong><br />
    Arinna International (HK) CO.,Ltd.</td>
    <td colspan="5" bgcolor="#FFFF00"><strong>Consignee:</strong><br />
  <!--{$order.consignee}--></td>
  </tr>
  
  <tr height="180">
    <td height="168" colspan="4" valign="top"><strong>From:</strong><br>
    Le feng lou,301,Dong Le Hua Yuan,Buxin Road<br>Luohu District, Shenzhen<br>GuangDong<br>China
    </td>
    <td colspan="5" valign="top" bgcolor="#FFFF00"><strong>To:</strong><br />
<!--{$order.consignee}--><br><!--{$order.street1}-->  <!--{$order.street2}--><br><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--><br><br><!--{$order.country}--></td>
  </tr>
  <tr height="54">
    <td width="50" height="54"><div align="center"><strong>Phone:</strong></div></td>
    <td colspan="3"> 86-0755-22258547</td>
    <td colspan="2"><div align="center"><strong>Phone:</strong></div></td>
    <td colspan="3" bgcolor="#FFFF00"><!--{$order.tel}--></td>
  </tr>
  <tr height="50">
    <td colspan="4" height="41"><strong>Country of Export:<br />
   </strong>   China</td>
    <td colspan="5" bgcolor="#FFFF00"><strong>Country of destination:<br />
  </strong>   <!--{$order.country}--></td>
  </tr>
  <tr height="38">
    <td colspan="3"><strong>Description of Goods</strong></td>
    <td width="65"><strong>Model</strong></td>
    <td width="65"><strong>QTY</strong></td>
    <td width="91"><strong>Unit Value</strong></td>
    <td width="182" colspan="2"><strong>Total Value</strong></td>
  </tr>
    <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
  <tr height="42">
    <td height="36" colspan="3">Jewelry</td>
    <td><!--{$goods.goods_sn}--></td>
    <td><!--{$goods.goods_qty}--></td>
    <td>$<!--{$goods.goods_price}--> </td>
    <td colspan="2">$<!--{$goods.goods_price*$goods.goods_qty}--></td>
  </tr>
  <!--{/foreach}-->
  <tr height="30">
    <td colspan="3" height="59"><strong>Total No. of pkgs</strong></td>
    <td width="235"><!--{$order.total}--></td>
    <td colspan="2"><div align="center"><strong>Total    Inv.Value</strong></div></td>
    <td colspan="3">$<!--{$order.totalprice}--></td>
  </tr>
  
  <tr>
    <td height="21" colspan="9"><p><strong>Reason for Export：<br />
      </strong></p>    </td>
  </tr>
  <tr height="18">
    <td colspan="9"><p><strong>Shipping Details:</strong> <br />
      We certify and pledge that all information filled in this document is   conformed to the details declared to the Customs and conformed to the   actual conditions of the goods in the shipment.</p>
      <p><br />
      </p></td>
  </tr>
  
  <tr height="19">
    <td colspan="5" height="19"><div align="center"><strong>Shipper's    Signature</strong></div></td>
    <td colspan="4"><div align="center"><strong>Date</strong></div></td>
  </tr>
   <tr height="19">
    <td height="115" colspan="5" valign="bottom"><div align="center">----------------------------------</div></td>
    <td colspan="4" valign="bottom"><div align="center">--------------------------------</div></td>
  </tr>
</table>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 4}-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:600px" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<div style="width:50%;float:left;margin:0;padding:0">
<ul>
<li><b>TO:</b><!--{$order.consignee}--></li>
<li><!--{$order.street1}-->  <!--{$order.street2}--></li>
<li><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></li>
<li><!--{$order.country}--></li>
<li><!--{$order.tel}--></li>                
</ul>
</div>
<div style="width:50%;float:left;margin:0;padding:0">
<ul>
<li><span class="STYLE1">*<!--{$order.order_sn}-->*</span></li>
<li>配货信息:</li>
<li><!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}-->&&<!--{$goods.goods_qty}--><br>
<!--{/foreach}-->
</li>
<!--{if $order.pay_note}--><li>备注:<!--{$order.pay_note}--></li><!--{/if}-->
</ul>
</div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 5}--><!-新加坡挂号-->
<div style="width:800px;float:left;">
<!--{foreach from =$orders item = order name=orderitem}-->
<div  style="width:380px; height:260px; float:left; padding:30px 15px 0 15px; margin-top:4px; background-color: #F90;" >
<ul>
<li>
<div style="font-size:12px;width:125px;float:left;">Return address:<br>
ALRPAK EXPRESS<br>
30  Kaki Bukit Road 3,<br>
#06-03 Empire Techno Centre<br>
Singapore 418719<br>挂号
</div>
</li>
<li style="clear:left;font-size:18px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:16px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:16px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li>
<div style="width:145px;float:left;">
<span style="font-size:16px;"><b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b><br>
</span>
</div>
<div style="text-align:right;clear:right;margin-top:-18px;"><span style="font-family:C39HrP24DhTt;font-size:30px;">*<!--{$order.order_sn}-->*</span></div>
</li>
<li><span style="font-size:8px"><!--{$order.total}-->---
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
<!--{/foreach}--></span>
</li>
</ul>
</div>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 8 == 0}-->class="pagebreak"<!--{/if}-->></div>
<!--{/foreach}-->
</div>
<!--{elseif $type eq 6}--><!-新加坡小包-->
<div style="width:800px;float:left;">
<!--{foreach from =$orders item = order name=orderitem}-->
<div  style="width:380px; height:260px; float:left; padding:30px 15px 0 15px; margin-top:4px; background-color: #F90;" >
<ul>
<li>
<div style="font-size:12px;width:125px;float:left;">Return address:<br>
ALRPAK EXPRESS<br>
30  Kaki Bukit Road 3,<br>
#06-03 Empire Techno Centre<br>
Singapore 418719<br>
</div>
</li>
<li style="clear:left;font-size:18px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:16px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:16px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li>
<div style="width:145px;float:left;">
<span style="font-size:16px;"><b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b><br>
</span>
</div>
<div style="text-align:right;clear:right;margin-top:-18px;"><span style="font-family:C39HrP24DhTt;font-size:30px;">*<!--{$order.order_sn}-->*</span></div>
</li>
<li><span style="font-size:8px"><!--{$order.total}-->---
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
<!--{/foreach}--></span>
</li>
</ul>
</div>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 8 == 0}-->class="pagebreak"<!--{/if}-->></div>
<!--{/foreach}-->
</div>
<!--{elseif $type eq 134}--><!--A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<!--{if $smarty.foreach.orderitem.index % 5 == 0}-->
<div style=" width:165mm;height:auto;page-break-after:always;clear:both;">
<!--{/if}-->
<div style="font-family:Arial;width: 190mm;">
    <table style="border: 1px dashed #999999;width: 190mm">
      <tr>
         <td width="115"  valign="top" style="border-right:#000000 1px dashed;">
            <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=35">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.order_sn}-->*</center></div></span><br />
            <span style="font-size: 9px;font-family:Arial;float:right"><!--{$smarty.now|date_format:'%Y-%m-%d'}--></span><br />
            <span style="font-size: 12px;font-family:Arial;">ID:<!--{$order.userid}-->&nbsp;</span><br />
            <span style="font-size: 12px;font-family:Arial;">订单号:<!--{$order.paypalid}-->&nbsp;</span><br />

            <span style="font-size: 12px;font-family:Arial;">物流方式:<!--{$order.ShippingService}--></span><br />

            <span style="font-size: 12px;font-family:Arial;">重量:</span><span style="font-size: 12px;font-family:Arial;"><!--{$order.weight}-->&nbsp;</span><br />

            <span style="font-size: 12px;font-family:Arial;">运费:&nbsp;<!--{$order.shipping_cost}--></span><br />
    
            <span style="font-size: 12px;font-family:Arial;"></span><br />
            
         </td>
         <td width="220" valign="top" style="border-right: #000000 1px dashed">
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="word-break: break-all;break-all;position:relative;">
               <tr>
                  <td valign="top">
                    <span style="font-size:9px;font-weight:800;" >物品数：</span>
                    <span style="font-size:25px;font-weight:800;" ><!--{$order.total}--></span><br/>
                      <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
                     <font style="font-size:10px"><!--{$goods.goods_qty}--> * <!--{$goods.goods_sn}--> <!--{$goods.goods_attribute}--></font><img src="<!--{$goods.goods_img}-->" width="75px"/>
                    <br/>
                    <!--{/foreach}-->
                   <!--{if $order.pay_note}--><br/><div style="font-size:10px">备注:<!--{$order.pay_note}--><!--{/if}--></div>
                  </td>
               </tr>
            </table>
         </td>
         <td width="420" valign="top">
            <table width="95%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                  <td colspan="2">
                  <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=30">
    <div style="font-size:11px;margin-top:-25px;letter-spacing:4px;width:206px"><center>*<!--{$order.order_sn}-->*</center></div></span>
                     <div style="font-size: 14px; font-weight: bold">
                        <span style="margin-right:2px" >Send To:  <!--{$order.consignee}--></span><br/>
                        <!--{$order.street1}-->&nbsp; <!--{$order.street2}--><br/>
                        <!--{$order.city}-->&nbsp; <!--{$order.state}--><br/>
                        ZIP:&nbsp;<!--{$order.zipcode}--><br/>
                        <!--{$order.country}-->(<!--{$order.Cncountry}-->)<br/>
                          Tel:<!--{$order.tel}-->
                     </div>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   </div><!--{if $smarty.foreach.orderitem.index % 5 == 4}-->
</div>
<!--{/if}--><!--{/foreach}-->
<!--{elseif $type eq 135}--><!--A4-->
<div style="width:820px;float:left;">
<!--{foreach from =$orders item = order name=orderitem}-->
<div  style="width:340px; height:200px; float:left; padding:5px 5px 0 15px; margin-top:4px;" >
    <table style="border: 1px dashed #999999;height:220px">
      <tr>
         <td width="115"  valign="top" style="border-right:#000000 1px dashed;">
            <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=35">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.order_sn}-->*</center></div></span><br />
            <span style="font-size: 9px;font-family:Arial;float:right"><!--{$smarty.now|date_format:'%Y-%m-%d'}--></span><br />
            <span style="font-size: 12px;font-family:Arial;">ID:<!--{$order.userid}-->&nbsp;</span><br />
            <span style="font-size: 12px;font-family:Arial;">订单号:<!--{$order.paypalid}-->&nbsp;</span><br />

            <span style="font-size: 12px;font-family:Arial;">物流方式:<!--{$order.ShippingService}--></span><br />
            <!--{if $order.pay_note}--><br/><div style="font-size:10px">备注:<!--{$order.pay_note}--><!--{/if}--></div>
         </td>
         <td width="220" valign="top" style="border-right: #000000 1px dashed">
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="word-break: break-all;break-all;position:relative;">
               <tr>
                  <td valign="top">
                    <span style="font-size:9px;font-weight:800;" >物品数：</span>
                    <span style="font-size:25px;font-weight:800;" ><!--{$order.total}--></span><br/>
                      <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
                     <font style="font-size:10px"><!--{$goods.goods_qty}--> * <!--{$goods.goods_sn}--> <!--{$goods.goods_attribute}--></font><img src="<!--{$goods.goods_img}-->" width="75px"/>
                    <br/>
                    <!--{/foreach}-->
                   
                  </td>
               </tr>
            </table>
         </td>
        </tr>
      </table>
</div>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 10 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--{/foreach}-->
<!--{elseif $type eq 136}--><!--A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<!--{if $smarty.foreach.orderitem.index % 5 == 0}-->
<div style=" width:165mm;height:auto;page-break-after:always;clear:both;">
<!--{/if}-->
<div style="font-family:Arial;height: 55mm; width: 190mm;">
    <table style="border: 1px dashed #999999; height: 60mm; width: 190mm">
      <tr>
         <td width="115"  valign="top" style="border-right:#000000 1px dashed;height:46mm;">
            <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=35">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.order_sn}-->*</center></div></span><br />
            <span style="font-size: 9px;font-family:Arial;float:right"><!--{$smarty.now|date_format:'%Y-%m-%d'}--></span><br />
            <span style="font-size: 12px;font-family:Arial;">ID:<!--{$order.userid}-->&nbsp;</span><br />
            <span style="font-size: 12px;font-family:Arial;">订单号:<!--{$order.paypalid}-->&nbsp;</span><br />

            <span style="font-size: 12px;font-family:Arial;">物流方式:<!--{$order.ShippingService}--></span><br />

            <span style="font-size: 12px;font-family:Arial;">重量:</span><span style="font-size: 12px;font-family:Arial;"><!--{$order.weight}-->&nbsp;</span><br />

            <span style="font-size: 12px;font-family:Arial;">运费:&nbsp;<!--{$order.shipping_cost}--></span><br />
    
            <span style="font-size: 12px;font-family:Arial;"></span><br />
            
         </td>
         <td width="220" valign="top" style="border-right: #000000 1px dashed">
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="word-break: break-all;break-all;position:relative;">
               <tr>
                  <td valign="top">
                    <span style="font-size:9px;font-weight:800;" >物品数：</span>
                    <span style="font-size:25px;font-weight:800;" ><!--{$order.total}--></span><br/>
                      <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
                     <font style="font-size:10px"><!--{$goods.goods_qty}--> * <!--{$goods.goods_sn}--> <!--{$goods.goods_attribute}--></font><img src="<!--{$goods.goods_img}-->" width="75px"/>
                    <br/>
                    <!--{/foreach}-->
                   <!--{if $order.pay_note}--><br/><div style="font-size:10px">备注:<!--{$order.pay_note}--><!--{/if}--></div>
                  </td>
               </tr>
            </table>
         </td>
         <td width="420" valign="top">
            <table width="95%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                  <td colspan="2">
                 
                    <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=50">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.track_no}-->*</center></div></span>
                     <div style="font-size: 14px;margin-top:10px; font-weight: bold">
                        <span style="margin-right:2px" >Send To:  <!--{$order.consignee}--></span><br/>
                        <!--{$order.street1}-->&nbsp; <!--{$order.street2}--><br/>
                        <!--{$order.city}-->&nbsp; <!--{$order.state}--><br/>
                        ZIP:&nbsp;<!--{$order.zipcode}--><br/>
                        <!--{$order.country}-->(<!--{$order.Cncountry}-->)<br/>
                          Tel:<!--{$order.tel}-->
                     </div>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   </div><div style="clear:both"></div><!--{if $smarty.foreach.orderitem.index % 5 == 4}-->
</div>
<!--{/if}--><!--{/foreach}-->
<!--{elseif $type eq 7}--><!-新加坡小包单页-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:350px;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li>
<div style="font-size:12px;width:250px;float:left;height:20px;text-align:center">
</div>
</li>
<li style="clear:left;font-size:24px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:22px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:22px;width:320px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:22px;">
<b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b><br><span style="font-size:12px"><!--{$order.allaccount}--></span>
</li>
<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=50"></li>
<li style="width:206px;margin-top:-20px;letter-spacing:4px;"><center>*<!--{$order.order_sn}-->*</center></li>
<li><span style="font-size:12px;"><!--{$order.total}-->---
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
<!--{/foreach}--></span>
<!--{if $order.note}--><br><!--{$order.note}--><!--{/if}-->
</li>
</ul>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 17}--><!-瑞士小包单页-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:350px;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li>
<div style="font-size:12px;width:250px;float:left;height:20px;text-align:center">
</div>
</li>
<li style="text-align:center;clear:left;">
<table style="font-size:10px;border: 1px solid #000000;border-collapse:collapse;" width="88%"><tr><td colspan="2" align="center" style="border-collapse:collapse;border: 1px solid #000000;"><b>PRIORITY</b></td></tr>
<tr><td width="60%" style="border-collapse:collapse;border: 1px solid #000000;">If undeliverable,please return to:<br/>Exchange Office<br/>
SPI HKG 00008205<br/>
8010 Zurich_Mulligen<br/>
Switzerland<br/>
</td><td align="center" style="border-collapse:collapse;border: 1px solid #000000;"><b>P.P.</b><br/>
Swiss Post<br/>
CH-8010 Zurich<br/>
Mulligen<br/>
</td>
</tr></table></li>
<li style="clear:left;font-size:20px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:18px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:18px;width:320px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:18px;">
<b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b><br><span style="font-size:10px"><!--{$order.allaccount}--></span>
</li>
<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=50"></li>
<li style="width:206px;margin-top:-20px;letter-spacing:4px;"><center>*<!--{$order.order_sn}-->*</center></li>
<li><span style="font-size:10px;"><!--{$order.total}-->---
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
<!--{/foreach}--></span>
<!--{if $order.note}--><br><!--{$order.note}--><!--{/if}-->
</li>
</ul>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 18}--><!-瑞士挂号单页-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:350px;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li style="text-align:center;clear:left;">
<table style="font-size:10px;border: 1px solid #000000;border-collapse:collapse;" width="88%"><tr><td colspan="2" align="center" style="border-collapse:collapse;border: 1px solid #000000;"><b>PRIORITY</b></td></tr>
<tr><td width="60%" style="border-collapse:collapse;border: 1px solid #000000;">If undeliverable,please return to:<br/>Exchange Office<br/>
SPI HKG 00008205<br/>
8010 Zurich_Mulligen<br/>
Switzerland<br/>
</td><td align="center" style="border-collapse:collapse;border: 1px solid #000000;"><b>P.P.</b><br/>
Swiss Post<br/>
CH-8010 Zurich<br/>
Mulligen<br/>
</td>
</tr></table></li>
<li style="clear:left;font-size:20px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:18px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:18px;width:330px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:18px;">
<b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b><br><span style="font-size:12px">挂号--<!--{$order.allaccount}--></span>
</li>
<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=50"></li>
<li style="width:206px;margin-top:-20px;letter-spacing:4px;"><center>*<!--{$order.order_sn}-->*</center></li>
<li><span style="font-size:12px;"><!--{$order.total}-->---
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->,
<!--{/foreach}--></span><!--{if $order.note}--><br><!--{$order.note}--><!--{/if}-->
</li>
</ul>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 113}--><!-配货单->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 6 == 0}-->class="pagebreak"<!--{/if}-->>
        <div style="width:940px;height:150px;border:3px solid #000; ">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50%" valign="top">
                    <ul style="margin-left:10px;margin-top:5px;">
                        <li style="font-size:30px;"><b>TO:</b></li>
                        <li style="font-size:26px;font-weight:800"><!--{$order.consignee}--></li>
                        <li style="font-size:26px;font-weight:800"><!--{$order.street1}--><!--{$order.street2}--></li>
                        <li style="font-size:26px;font-weight:800"><!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}--> <!--{$order.zipcode}--></li>
                        <li style="font-size:26px;font-weight:800"><!--{$order.country}-->(<!--{$order.Cncountry}-->)</li>            
                    </ul>
                </td>
                <td width="20%" valign="top">
                    <br/>
                    <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=60"></li>
                    <li style="font-size:20px;width:222px;margin-top:-20px;margin-left:-10px;"><center><b><!--{$order.order_sn}--></b></center></li></td>
                <td width="30%" valign="top" style=" border-left:3px solid #000">
                    <br/>
                     <ul style="margin-left:10px;margin-top:5px;">
                        <li style="font-size:24px;"><!--{$order.shipping}--></li>
                        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                        <li style="font-size:24px;"><!--{$goods.goods_sn}-->[<!--{$goods.location}-->]&nbsp;X&nbsp;<!--{$goods.goods_qty}-->/</li>
                        <!--{/foreach}-->
                    </ul>
                </td>
              </tr>
            </table>
    </div>
</div><!--{if !$smarty.foreach.orderitem.last}--><div style="height:38px;">&nbsp;</div><!--{/if}-->
<!--{/foreach}-->
<!--{elseif $type eq 117}--><!-国际EMS->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:1357px;height:897px; background:url(/themes/default/template/order/ems.jpg);position:relative;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->> 
    <div style="position:absolute;height:36px; left: 818px;font-size:20px; top: 151px;"><!--{$order.consignee}--></div>
    <div style="position:absolute;height:36px; left: 818px;font-size:20px; top: 211px;"><!--{$order.city}--></div>
    <div style="position:absolute;height:36px; left: 1020px;font-size:20px; top: 211px;"><!--{$order.country}--></div>
    <div style="position:absolute;height:36px; left: 818px;font-size:20px; top: 275px;"></div>
    <div style="position:absolute;height:90px; width:490px; left: 818px;font-size:20px; top: 330px; line-height:200%"><!--{$order.street1}-->&nbsp;<!--{$order.street2}-->,<!--{$order.city}-->,<!--{$order.state}--></div>
    <div style="position:absolute;height:36px; width:373px; left: 818px;font-size:20px; top: 445px;"><!--{$order.zipcode}--></div>
    <div style="position:absolute;height:36px; width:373px; left: 1025px;font-size:20px; top: 445px;"><!--{$order.tel}--></div>
</div>   
<!--{/foreach}-->
<!--{elseif $type eq 170}--><!-DHL-->
<div style="width:240mm;float:left;">
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:110mm ;border:#000 1px solid;float:left;">
   <div style="position:relative;left: 28px;top: 27px;">
        SZ-ETC
    </div>
    <div style="position:relative; width:175px;height:60px; left: 196px;top: 0px;">
        <table width="100%" height="100%" border="0px" cellspacing="0" cellpadding="0">
            <tr>
                <td rowspan="3" width="87" align="left" valign="top" style="font-size:12px;border:1px solid #000;">
                    AAA
                </td>
                <td height="8" width="87" align="left" valign="top" style="font-size:12px; border-top:1px solid #000; border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;CCC
                </td>
            </tr>
            <tr>
                <td height="8" align="left" valign="top" style="font-size:12px;border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;BBB
                </td>
            </tr>
            <tr>
                <td height="30" align="left" valign="top" style="font-size:12px;border-right:1px solid #000;border-bottom:1px solid #000;">
                    &nbsp;DD
                </td>
            </tr>
        </table>
    </div>
    <div style="position:relative;left:28px;top:-8px; width:300px;height:140px; line-height:120%">
        <ul style="width:300px; font-size:16px">
            <li>
                <b>
                    Deliver TO:
                </b>
            </li>
            <li>
                <!--{$order.consignee}-->
            </li>
            <li>
                <!--{$order.street1}-->
                &nbsp;
                <!--{$order.street2}-->
            </li>
            <li>
                <!--{$order.city}-->
                ,
                <!--{$order.state}-->
                ,
                <!--{$order.zipcode}-->
            </li>
            <li>
                <!--{$order.country}-->
            </li>
            <li>
                <!--{$order.tel}-->
            </li>
        </ul>
    </div>
    <div style="position:relative;left: 0px;top: -5px;width:100%" align="center">
        <table height="200" width="100%" border="0px" cellspacing="0" cellpadding="0">
            <tr>
                <td height="150" >
                    <table height="150" width="335px" border="0px" cellspacing="0" cellpadding="0" style="border-top:#000 3px solid;padding:0px;margin:0px;margin-left:28px;">
                        <tr>
                            <td width="265" height="150" valign="top">
                                <table style="padding:0px;margin:0px;border-collapse:collapse;width:100%;margin-top:0.1cm;height:45px;">
                                    <tr style="padding:0px;margin:0px;border:1px solid;font-size:10px;">
                                        <td align="left" height="20" style="padding:2px;border-bottom:2px solid #000;border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;font-size:9px" colspan="4">
                                            <ul style="padding:0px;margin:0px;float:left;width:5.5cm;font-weight:700;line-height:10pt;">
                                                <li style="padding:0px;margin:0px;float:left;font-size:9pt;text-align:left;width:5.5cm;line-height:80%;">
                                                    <b>
                                                        CUSTOMS&nbsp;DECLARATION
                                                    </b>
                                                </li>
                                                <li style="padding:0px;margin:0px;float:left;font-size:7pt;text-align:left;width:5.5cm;">
                                                    <b>
                                                        Postal administration(May be opened officially)
                                                    </b>
                                                </li>
                                            </ul>
                                            <ul style="padding:0px;margin:0px;float:left;width:1.5cm;line-height:10pt;">
                                                <li style="padding:0px;margin:0px;float:left;font-size:11pt;text-align:left;width:1.5cm;font-weight:700;">
                                                    CN22
                                                </li>
                                                <li style="padding:0px;margin:0px;float:left;font-size:7pt;text-align:left;width:1.5cm">
                                                    Important!
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="23" height="11" style="padding:2px; border-collapse:collapse;overflow:hidden;padding:0px;margin:0px;padding:0;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;overflow:hidden;width:10px;"
                                            />
                                        </td>
                                        <td width="55" style="padding:2px;  border-collapse:collapse;
                                        overflow:hidden;padding:0px;margin:0px;font-size:6pt;" valign="top">
                                            Gift
                                        </td>
                                        <td align="right" width="10" style="padding:0px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;width:10px;overflow:hidden;"
                                            />
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Commercial&nbsp;sample
                                        </td>
                                    </tr>
                                    <tr style="padding:0px;margin:0px;" valign="top">
                                        <td height="11" align="right" width="23" style="padding:0px;overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;width:10px;overflow:hidden;"
                                            />
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Documents
                                        </td>
                                        <td align="right" width="10" style="padding:0px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;">
                                            <input type="checkbox" style="padding:0px;margin:0px;display:block;height:10px;overflow:hidden;width:10px;"
                                            checked/>
                                        </td>
                                        <td style="padding:2px;border-collapse:collapse;
                                        overflow:hidden;margin:0px;font-size:6pt;"  valign="top">
                                            Other(Tick as appropriate)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="border-top:2px solid #000;">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left"
                                            style="font-size:11px">
                                                <tr>
                                                    <th scope="col" colspan="2" align="left" width="197" style="border-bottom:2px solid #000; border-right:2px solid #000;">
                                                        &nbsp;&nbsp;Detailed description of contents
                                                    </th>
                                                    <th scope="col" align="left" width="68" style="border-bottom:2px solid #000;">
                                                        &nbsp;&nbsp;Value
                                                    </th>
                                                </tr>
                                                <!--{assign var="x" value="0"}-->
                                                <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
                                                <!--{assign var="x" value=$x+$goods.Declared_value}-->
                                                <tr>
                                                    <td colspan="2" height="20" style="border-right:2px solid #000;">&nbsp;
                                                        <span  contenteditable = "true"><!--{$goods.goods_qty}-->&nbsp;X&nbsp;<!--{$goods.dec_name}--></span>
                                                    </td>
                                                    <td align="center"><span  contenteditable = "true">$
<!--{$goods.Declared_value|string_format:"%.2f"}--></span>
                                                    </td>
                                                </tr>
                                                <!--{/foreach}-->
                                                <tr>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000; border-right:2px solid #000;">
                                                        Origin:
                                                        <span contenteditable="true">
                                                            China
                                                        </span>
                                                    </td>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000; border-right:2px solid #000;"
                                                    align="center">
                                                        Total Weight(Kg)
                                                        <br/>
                                                        <span contenteditable="true">
                                                            0.200
                                                        </span>
                                                    </td>
                                                    <td style="border-top:2px solid #000;border-bottom:2px solid #000;" align="center">
                                                        Total Value
                                                        <br/>
                                                        <span contenteditable="true">
                                                            $<!--{$x|string_format:"%.2f"}-->
                                                        </span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-size:11px; line-height:90%;border-bottom:2px solid #000;"
                                        colspan="4">
                                            I, the undersigned,whose name and address are given on the item, certify
                                            that the particulars given in this declaration are correct and that this
                                            item dose not contain any dangerous article or articles prohibited by legislation
                                            or by customs regulations.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="font-size:11px;">
                                              <tr>
                                                <td>Date and Sender's Signature</td>
                                                <td rowspan="3" style="font-size:24px" valign="bottom"><img src="/themes/default/template/order/jacky.png"></td>
                                              </tr>
                                               <tr>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td><!--{$today}--></td>
                                              </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" valign="top">
                                <span class="STYLE1">*<!--{$order.order_sn}-->*</span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2" style="border-top:2px solid #000;">
                    <span style="padding:0px;margin:0px;margin-left: 65px; float: left; margin-top: 10px;font-size:45pt; height:80px">
                        R
                    </span>
                    <span style="padding:0px;margin:0px;margin-left: -38px; float: left; margin-top: 73px;font-size:10pt; ">
                        <b>EINSCREIBEN</b>
                    </span>
                    <div style="position:relative; width:210px; top:13px; left:-40px; line-height:80%">           
                        <center style="font-size:13px;"><b>RX&nbsp;00&nbsp;000&nbsp;000&nbsp;000</b></center>
                        <li  style="border-top:2px solid #000;"><center><img src="index.php?model=login&action=Barcode&number=RX00000000000&height=34"></center></li>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2" style="border-top:1px solid #000;font-size:12px">
                <br>&nbsp;&nbsp;&nbsp;Figure 2 Sample Integrated for Registered mail to all destinaction excep <br>&nbsp;&nbsp;&nbsp;(Note:Illustraction not drawn to scale;for sample purposes only.)
                </td>
            </tr>
        </table>
    </div>
</div>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 4 == 0}-->class="pagebreak"<!--{/if}-->></div>
<!--{/foreach}-->
</div>
<!--{elseif $type eq 13}--><!-地址拣货10*10-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="font-family:Arial;width:75mm; height:95mm;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table style="width:75mm; height:100mm; font-size:13px" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td style="height:40mm"  valign="top">
        <table width="100%"border="0" cellpadding="0" cellspacing="0">
            <tr><td style="height:30mm; font-size:14px" colspan="2"  valign="top">
                <b>Ship&nbsp;to:&nbsp;</b><br /><br/>
                <!--{$order.consignee}--><br/>
                <!--{$order.street1}-->&nbsp; <!--{$order.street2}--><br/>
                <!--{$order.city}-->,<!--{$order.state}-->&nbsp;<!--{$order.zipcode}--><br/>
                <!--{$order.country}-->(<!--{$order.Cncountry}-->)<br/>
                <!--{$order.tel}-->
            </td></tr>
        <tr><td style="height:10mm;">
            <ul>
      <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35"></li>
      <li><center style="margin-left:-20px;font-size:10px;margin-top:-25px;">*<!--{$order.track_no}-->*</center></li>
            </ul>
            </td>
            <td style="font-size:10px"><!--{$order.shipping}-->&nbsp;
            </td>
            </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td style="height:50mm"  valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr  style="height:25px; font-size:11px"><td style="height:25px; width:50%" align="left">sellerId:<!--{$order.sellerID}-->
        </td><td align="right"  style="height:25px; width:50%"><!--{$smarty.now|date_format:'%Y-%m-%d'}-->&nbsp;&nbsp;</td></tr>
          <tr><td  style="height:40mm" colspan="2" valign="top" align="center"><center>
            <table width="95%" border="0" cellpadding="0" cellspacing="0" style="font-size:14px;border-top:#000 1px solid;border-left:#000 1px solid;">
        <tr><td colspan="5" align="right" style="border-bottom:#000 1px solid;border-right:#000 1px solid;">
            总金额：<!--{$order.totalprice}-->&nbsp;
            </td></tr>
        <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr><td width="25%" style="border-bottom:#000 1px solid;border-right:#000 1px solid;">
            <b><!--{$goods.location}--></b>&nbsp;
            </td><td width="10%" align="center" style="border-bottom:#000 1px solid;border-right:#000 1px solid;"><b><!--{$goods.goods_qty}--></b>
            </td><td width="25%" align="center" style="border-bottom:#000 1px solid;border-right:#000 1px solid;"><b>
<!--{$goods.goods_sn}--></b>&nbsp;
            </td><td width="15%" style="border-bottom:#000 1px solid;border-right:#000 1px solid;">
<!--{$order.currency}-->&nbsp;
            </td><td width="25%" style="border-bottom:#000 1px solid;border-right:#000 1px solid;">
<!--{$goods.goods_price}-->&nbsp;
            </td></tr>
            <tr><td colspan="5" align="left" style="border-bottom:#000 1px solid;border-right:#000 1px solid;"><!--{$goods.goods_name}-->
            </td></tr>
            <!--{/foreach}-->
        </table>
        <table align="left">
            <tr style="text-align:left;">
            <!--{if $order.pay_note}--><td style="font-size:14px;">备注:<!--{$order.pay_note}--></td><!--{/if}-->
            </tr>
        </table>
        </center>
            </td></tr>
             <tr style="height:25px; font-size:11px"><td>
            </td><td align="right">第<!--{$smarty.foreach.orderitem.index+1}-->页&nbsp;
            </td></tr>
        </table></td>
  </tr>
</table>
   </div>
<!--{/foreach}-->
<!--{elseif $type eq 99}-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:450px" class="pagebreak">
<div style="border-bottom:3px solid #000;width:450px;height:110px"><!-- 头部start-->
<div style="width:90px;float:left;padding:5px 10px;"><p style="border:3px solid #000;font-size:70px;font-weight:bolder;width:70px;height:70px;padding:2px;display:block"><span style="margin:13px 13px 0 13px">F</span></p><p style="font-size:12px;margin-top:-5px;">From:</p></div>
<div style="width:172px;text-align:center;float:left;padding:7px 0"><p style="border-bottom:1px solid #999;width:108px;"><img src="data/chinapost.png" width="108px" height="34px"/></p><p style="margin-top:-15px"><img src="data/chinapost1.png" width="164px" height="34px"/></p><p style="margin-top:-15px">ePacket™</p></div>
<div style="float:left;width:118px;padding:8px 15px;text-align:center"><p style="border:2px solid #000;text-align:left;padding:2px 0 2px 4px;">Airmail<br />Postage Paid<br />China Post</p><p style="font-size:40px;font-weight:bold;margin-top:-15px;"><!--{$order.area}--></p></div>
</div> <!-- 头部end-->
<div style="border-bottom:3px solid #000;width:450px;height:109px;"><!-- 中部start-->
<div style="border-right:1px solid #000;width:250px;height:109px;padding:0 5px;float:left;">
<div style="font-size:12px; width:200px;word-warp:break-all;margin-top:5px;">Li Jinrong<br />
#301, Le Feng Lou, Dong Le Hua Yuan,Buxin Road Luohu<br /> Shenzhen Guangdong<br />
China 518020</div>
<div style="font-size:8px;margin-top:20px">Customs information avaliable on attached CN22.<br />
USPS Personnel Scan barcode below for delivery event information</div>
</div>
<div style="float:left;width:180px;text-align:center;padding:5px 0;font-weight:bold;">
<img src="index.php?model=login&action=Barcode&number=420<!--{$order.zipcode|truncate:5:"":true}-->&height=65" style="margin-top:5px"/><br>
ZIP <!--{$order.zipcode}-->
</div>
</div><!-- 中部end-->
<div style="border-bottom:5px solid #000;width:450px;height:109px;"><!-- 中部2start-->
<div style="font-size:30px;font-weight:bold; width:96px;height:109px;border-right:1px solid #000;float:left;"><span style="padding:25px 0 0 15px;height:90px;display:block;">TO:</span></div>
<div style="float:left;width:342px;text-align:left;padding:5px 0 0 5px;font-size:20xp;font-weight:bold;">
<!--{$order.consignee}--><br />
<!--{$order.street1}-->  <!--{$order.street2}--><br />
<!--{$order.city}-->,<!--{$order.state}--><br />
<!--{$order.country}--> <!--{$order.zipcode}--><br />
</div>
</div><!-- 中部2end-->
<div style="border-bottom:5px solid #000;width:450px;height:130px;text-align:center;padding-top:5px;font-size:16px;font-weight:bold"><!-- 底部start-->
USPS DELIVERY CONFIRMATION ®<br />
<img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=90"><br>
<!--{$order.track_no}-->
</div><!-- 底部end-->
</div>
<div style="width:450px">
<div style="height:122px;width:450px"><!-- 头部start-->
<div style="width:175px;font-size:12px;float:left;">
<img src="data/chinapost.png" width="165px"/>
<div style="float:left;width:110px;">
IMPORTANT:<br />The item/parcel may be<br />opened officially.<br />Please print in English.
</div>
<div style="float:left;border:1px solid #000;font-size:40px;width:50px;margin-left:5px;"><span style="margin:3px 0 0 15px"><!--{$order.area}--></span></div>
</div>
<div style="text-align:center;float:left;padding:35px 0 0 10px;">
<img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=53" style="margin-bottom:5px;">
<span style="font-weight:bold;"><!--{$order.track_no}--></span>
</div>
</div><!-- 头部end-->
<div style="width:450px;clear:both;border-bottom:1px solid #000;"><!-- 中部end-->
<div style="width:210px;height:140px;float:left;">
<div style="float:left;font-size:14px;word-warp:break-all;">
FROM:Li Jinrong<br />
#301, Le Feng Lou, Dong Le Hua Yuan,Buxin Road Luohu<br /> Shenzhen Guangdong<br />
China 518020</div>
<div style="margin-top:10px;font-size:14px;float:left;">PHONE:13632860062</div>
<div style="font-size:12px;border-top:1px solid #000;width:210px;">Fees(US $):</div>
<div style="font-size:12px;border-top:1px solid #000;width:210px;">Certificate No.</div>
</div>
<div style="border-left:1px solid #000;border-top:1px solid #000;width:230px;float:left;height:140px">
<div style="font-size:16px;font-weight:bold;height:120px;">
SHIP TO:<!--{$order.consignee}--><br />
<!--{$order.street1}-->  <!--{$order.street2}--><br />
<!--{$order.city}-->,<!--{$order.state}--><br />
<!--{$order.country}--> <!--{$order.zipcode}--><br />
</div>
<div style="font-size:16px;">PHONE: <!--{$order.tel}--></div>
</div>
</div><!-- 中部end-->
<div style="width:450px;height:170px;;border-bottom:1px solid #000;"><!--产品表start-->
<div style="border-bottom:1px solid #000;font-size:12px;text-align:center;height:16px;">
<div style="width:20px;border-right:1px solid #000;float:left;height:16px;text-align:right;">No</div><div style="width:30px;border-right:1px solid #000;float:left;height:16px;">Qty</div><div style="width:230px;border-right:1px solid #000;float:left;height:16px;">Description of Contents</div><div style="height:16px;width:50px;border-right:1px solid #000;float:left;">Kg.</div><div style="width:50px;border-right:1px solid #000;float:left;height:16px;">Val(US $)</div><div style="float:left;">Goods Origin</div>
</div>
<div style="height:135px;border-bottom:1px solid #000;">
<div style="width:20px;border-right:1px solid #000;float:left;height:135px;text-align:right;"></div><div style="width:30px;border-right:1px solid #000;float:left;height:135px;"></div><div style="width:230px;border-right:1px solid #000;float:left;height:135px;"></div><div style="height:135px;width:50px;border-right:1px solid #000;float:left;"></div><div style="width:50px;border-right:1px solid #000;float:left;height:135px;"></div><div style="float:left;"></div>
</div>
<div style="font-size:12px;text-align:center;">
<div style="width:20px;border-right:1px solid #000;float:left;height:18px;text-align:right;"></div><div style="width:30px;border-right:1px solid #000;float:left;height:18px;"><!--{$order.total}--></div><div style="width:230px;border-right:1px solid #000;float:left;height:18px;">Total Gross Weight (Kg.):</div><div style="height:18px;width:50px;border-right:1px solid #000;float:left;"><!--{$order.total*0.050}--></div><div style="width:50px;border-right:1px solid #000;float:left;height:18px;"><!--{$order.total*2}--></div><div style="float:left;"></div>
</div>
<div style="font-size:14px;margin-top:-150px; width:450px;height:130px;">
<div style="width:20px;border-right:1px solid #000;float:left;text-align:right;">1</div><div style="width:30px;border-right:1px solid #000;float:left;"><!--{$order.total}--></div><div style="width:230px;border-right:1px solid #000;font-size:12px;float:left;height:130px;word-wrap: break-word; word-break: normal;">fashion jewelry <!--{$order.good_eubstr}--> 流行饰品</div><div style="width:50px;border-right:1px solid #000;float:left;"><!--{$order.total*0.050}--></div><div style="width:50px;border-right:1px solid #000;float:left;"><!--{$order.total*2}--></div><div style="float:left;">China</div>
</div>
</div><!--产品表end-->
<div style="width:450px;font-size:10px;">
I certify the particulars given in this customs declaration are correct. This item does not contain any dangerous article, or articles prohibited by legislation or by postal or customs regulations. I have met all applicable export filing requirements under the Foreign Trade Regulations.
<div style="float:left;width:230px;font-size:14px;font-weight:bold;">Sender's Signature & Date Signed:</div>
<div style="float:right;width:75px;font-size:20px;font-weight:bold;">CN22</div>
</div>
</div>
<!--{/foreach}-->
<!--{elseif $type eq 77}--><!-合并打印-->
<center>傲基电子商务有限公司(<!--{$smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}-->)</center>
<table width="100%" style="border:#000 thin"><tr><td width="5%">序号</td><td width="25%">订单号</td><td width="35%">型号/数量库位</td><td width="10%">国家</td><td width="25%">订单备注</td></tr>
<!--{foreach from =$orders item = order name=orderitem}-->
<tr><td class="bbb"><!--{$smarty.foreach.orderitem.index+1}--></td><td class="bbb"><span class="STYLE1">*<!--{$order.order_sn}-->*</span></td>
<td class="bbb">
<table width="100%">
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<tr><td width="50%"><!--{$goods.goods_sn}--></td><td width="20%"><!--{$goods.goods_qty}--></td><td width="30%"><!--{$goods.location}--></td></tr>
<!--{/foreach}-->
</table>
</td>
<td class="bbb"><!--{$order.country}--></td>
<td class="bbb"><!--{$order.pay_note}-->&nbsp;<!--{$order.note}--></td>
</tr>
<!--{/foreach}-->
</table>

<!--{elseif $type eq 161}--><!--中国邮政航空小包挂号(广东)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <td valign="top" align="left"
                    style="border: 0px; font-size: 8px; padding: 0; width: 3.0cm;" colspan="2">
                <b>FROM:&nbsp;</b> <B>YZJ</B><br>
                14 -ROOM 4102 SHENZHEN POSTAL EXPRESS SUPERVISION CENTER, JUNCTION OF QIAOXIZNG RD.&SHENYUN RD.,OCT NORTH,SHENZHEN
<br>
              </td>
                
            </tr>
            <tr height="20px;"></tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <u>TO:&nbsp;</u> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->,<!--{$order.street2}-->,<!--{$order.city}-->, <!--{$order.state}-->
<br>
      </font>
        <!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--><br>
        Tel:&nbsp;<!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                <table
                    style="font-size: 8px; border-collapse: collapse; border: none; width: 1.5cm">
                 <tr>
                            <td style="border: solid #000 1px; font-size: 6px; line-height: 10px;" align="center">
                      <img src="themes/default/images/HLY-YXJ-1358759297937-S.jpg"  height="52" width="52"/>
                 </td>
                         </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 20px;height:28px;"
                            align="center"> 
                            Z-11
                        </td>
                    </tr>
                </table>
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="1" cellspacing="1"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm">
                    <tr>
                        <td colspan="2"
                            style=" width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             RC<!--{$order.track_no}-->CN
                         </b></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
                                
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style=" font-size: 8px" colspan="2" align="center">
                        中国邮政航空小包挂号(广东)&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}-->
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C>
<DIV id=C1>
<DIV id=C11><span class=cn1>
 CUSTOMS DECLARATION</span><BR><span class=cn2>(May be opened officially)</span></DIV>
<DIV id=C12><span class=cn1>CN 22</span><BR><span class=cn2>Pos 401G(4/08)</span></DIV>
<DIV id=C13><span class=cn2>Postal administration</span></DIV>
</DIV>
<DIV id=C2>
<div id=C21><IMG src="themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div id=C22><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div id=C23><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div id=C24><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
<span class=cn2><BR>(15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">HLY YZJ</div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--捡货单-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>

<!--{/foreach}-->


<!--{elseif $type eq 162}--><!--香港小包挂号A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <td valign="top" align="left"
                    style="border: 0px; font-size: 8px; padding: 0; width: 3.0cm;">
                <b>FROM:&nbsp;</b> <B>YZJ</B><br>
               P.O.BOX NO.87346,TO KWA WAN POST OFFICE, HONGKONG
<br>
              </td>
              <td align="right" valign="top"
                    style="width: 4.5cm; margin-right: 1cm;">
                  
                    <table style=" border-collapse:collapse;">
                        <tr>
                            <td style="border:1px solid #000; width:10%;" align="center">E</td>
                            <td style="border:1px solid #000; width:55%;" align="center">POSTAGE PAID HONG KONG PORT PAYE</td>
                            <td style="border:1px solid #000; width:30%;" align="center">PERMIT NO. TO238</td>
                        </tr>
                    </table>
                  
                </td>
            </tr>
            <tr style="height:10px;"></tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <u>TO:&nbsp;</u> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->,<!--{$order.street2}-->,<!--{$order.city}-->, <!--{$order.state}-->
<br>
      </font>
        <!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--><br>
        Tel:&nbsp;<!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                <table
                    style="font-size: 8px; border-collapse: collapse; border: none; width: 1.5cm">
                 <tr>
                            <td style="border: solid #000 1px; font-size: 6px; line-height: 10px;" align="center">
                      <img src="themes/default/images/HLY-YXJ-1358759297937-S.jpg"  height="52" width="52"/>
                 </td>
                         </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 20px;height:28px;"
                            align="center"> 
                            Z-2
                        </td>
                    </tr>
                </table>
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="2" cellspacing="0"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm; margin-left:3px;">
                    <tr>
                        <td>
                            <font style="font-weight:bold; font-size:50px; ">R</font>
                        </td>
                        <td colspan="1"
                            style="border: solid #000 1px; width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             RC<!--{$order.track_no}-->CN
                         </b></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
                                
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 8px" colspan="2" align="center">
                        香港小包挂号&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}-->
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C>
<DIV id=C1>
<DIV id=C11><span class=cn1>
 CUSTOMS DECLARATION</span><BR><span class=cn2>(May be opened officially)</span></DIV>
<DIV id=C12><span class=cn1>CN 22</span><BR><span class=cn2>Pos 401G(4/08)</span></DIV>
<DIV id=C13><span class=cn2>Postal administration</span></DIV>
</DIV>
<DIV id=C2>
<div id=C21><IMG src="themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div id=C22><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div id=C23><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div id=C24><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
<span class=cn2><BR>(15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">HLY YZJ</div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--捡货单-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>

<!--{/foreach}-->

<!--{elseif $type eq 163}--><!--瑞典小包挂号A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <td style="width:50%; height:2cm; border:1px solid #000; font-size:9px;" align="left">
                       PRIORITYA <br />
                    if undeliverable return to:<br />
                    Dept.0341-S01<br />
                    PO Box 4801<br />
                    Se-202 26 Malmo<br />
                    Sweden
                </td>
                <td style="border:1px solid #000; border-left:0px;">
                       <div>
                        <div style="float:left;"><div style="border:1px solid #000;width:30px; height:30px;"></div></div>
                        <div style="float:left; padding-left:5px; font-size:10px;">
                            <div>POSTEN AB<br /> INTERNATIONAL<br /> MAIL</div>
                            <div><b>PP</b>&nbsp;<B>Sweden</B></div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr style="height:10px;"></tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <u>TO:&nbsp;</u> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->,<!--{$order.city}-->, <!--{$order.state}-->
<br>
      </font>
        <!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--><br>
        Tel:&nbsp;<!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                <table
                    style="font-size: 8px; border-collapse: collapse; border: none; width: 1.5cm">
                 
                    <tr>
                        <td style="border: solid #000 1px; font-size: 20px;height:28px;"
                            align="center"> 
                            Z-2
                        </td>
                    </tr>
                </table>
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="2" cellspacing="0"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm; margin-left:3px;">
                    <tr>
                        <td>
                            <font style="font-weight:bold; font-size:50px; ">R</font>
                        </td>
                        <td colspan="1"
                            style="border: solid #000 1px; width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                              <tr>
                                <td valign="top" align="center" style="font-size: 11px">
                                    SPL HONG KONG
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
                                
                                </td>
                            </tr>
                              <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             RE<!--{$order.track_no}-->SE
                         </b></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 8px" colspan="2" align="center">
                        瑞典小包挂号&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}-->
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C style="top:-30px;">
<DIV id=C1>
    <DIV id=C11>
        <span class=cn1 style=" float:right; margin-right:10px;">CN 22</span>
    </DIV>
    <DIV id=C12>
        <br /><span class=cn2 style="float:left; margin-left:22px;">Postal administration</span><span class=cn1>CUSTOMS DECLARATION</span><BR>
    </DIV>
    <DIV id=C13><span style="font-size:8px; margin-left:-5px;">(Please check on appropriate option)</span><span class=cn2 style="float:right;font-size:8px; margin-right:100px;">(May be opened officially)</span></DIV>
</DIV>
<DIV id=C2>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
    <div style="float:left; width:60%;">
        <span class=cn2><BR>(8)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">HLY YZJ</div>
    </div>
    <div style="float:right; width:50%; text-align:right; margin-right:-30px;">
        <span style="font-weight:bold; font-size:11px;"><BR />ref no:<br /><!--{$order.paypalid}--></span><br /><span style="font-size:9px;"><!--{$smarty.now|date_format:'%A,%b,%d,%Y'}--></span>
    </div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--捡货单-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>

<!--{/foreach}-->


<!--{elseif $type eq 164}--><!--瑞典挂号(三区)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <tbody><tr>
                        <td align="center" style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:6.5cm; height:0.2cm;font-size:10px" colspan="2">
                            <b>
                                PRIORITY
                            </b>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding:0px;margin:0px;border:1px solid #000; border-collapse:collapse;width:3.5cm;padding-top:0px">
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                If undeliverable,please
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:9px;line-height:10px; ">
                                return to:Exchange Office
                            </span>
                            <br>
                            <span style="padding:0px;margin:0px;font-size:8px;line-height:10px; width:3.5cm;">
                                SPI HKG 00006372
                                <br>
                                8010 Zurich-Mulligen
                                <br>
                                Switzerland
                            </span>
                        </td>
                        <td style="padding:0px;margin:0px;text-align:center; font-size:9px;line-height:9px;border:1px solid #000; border-collapse:collapse;height:0.6cm;width:2cm;">
                            P.P.
                            <br>
                            Swiss Post
                            <br>
                            CH-8010 Zurich
                            <br>
                            Mulligen
                        </td>
                    </tr>
                </tbody>
            </tr>
             <tr style="height:10px;"></tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <u>TO:&nbsp;</u> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->,<!--{$order.city}-->, <!--{$order.state}-->
<br>
      </font>
        <!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--><br>
        Tel:&nbsp;<!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="2" cellspacing="0"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm; margin-left:3px;">
                    <tr>
                        <td>
                            <font style="font-weight:bold; font-size:50px; ">R</font>
                        </td>
                        <td colspan="1"
                            style="border: solid #000 1px; width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                              <tr>
                                <td valign="top" align="center" style="font-size: 11px">
                                    SPL HONG KONG
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
                                
                                </td>
                            </tr>
                              <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             RS<!--{$order.track_no}-->CH
                         </b></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 8px" colspan="2" align="center">
                        瑞士挂号(三区)&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}-->
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C style="top:-30px;">
<DIV id=C1>
    <DIV id=C11>
        <span class=cn1 style=" float:right; margin-right:10px;">CN 22</span>
    </DIV>
    <DIV id=C12>
        <br /><span class=cn2 style="float:left; margin-left:22px;">Postal administration</span><span class=cn1>CUSTOMS DECLARATION</span><BR>
    </DIV>
    <DIV id=C13><span style="font-size:8px; margin-left:-5px;">(Please check on appropriate option)</span><span class=cn2 style="float:right;font-size:8px; margin-right:100px;">(May be opened officially)</span></DIV>
</DIV>
<DIV id=C2>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div  style="float:left"><IMG src="http://www.cpowersoft.com/erp/themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
    <div style="float:left; width:60%;">
        <span class=cn2><BR>(8)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">HLY YZJ</div>
    </div>
    <div style="float:right; width:50%; text-align:right; margin-right:-30px;">
        <span style="font-weight:bold; font-size:11px;"><BR />ref no:<br /><!--{$order.paypalid}--></span><br /><span style="font-size:9px;"><!--{$smarty.now|date_format:'%A,%b,%d,%Y'}--></span>
    </div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--捡货单-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>

<!--{/foreach}-->


<!--{elseif $type eq 165}--><!--新加坡小包挂号(五区)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="15">
<tr>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
 <table cellpadding="0" cellspacing="0" class="tabBq1">
            <tr>
                <td valign="top" align="left"
                    style="border: 0px; font-size: 8px; padding: 0; width: 3.0cm; height:1.5cm">
                <b>FROM:&nbsp;</b> <B>YZJ</B><br>
               IF UNDELIVERRED,PLS RETURN TO:c/o ATC CHANGI AIRFREIGHT CENTRE P.O. BOX946 SINGAPORE 918115
<br>
              </td>
              <td align="right" valign="top"
                    style="width: 4.5cm; margin-right: 1cm;">
                  <div style="border:1px solid #000; width:150px; height:70px;"></div>
                    
                  
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2"
                    style="width: 7.5cm; padding: 0; height: 3.0cm" align="left">
                    <div
                    style="font-size: 12px; float: left; word-spacing: normal; width: 201px;">
                <u>TO:&nbsp;</u> <b style="font-size: 12px"><!--{$order.consignee}--></b> 
                <br>
                <font style="font-size:12px">
           <!--{$order.street1}-->,<!--{$order.street2}-->,<!--{$order.city}-->, <!--{$order.state}-->
<br>
      </font>
        <!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--><br>
        Tel:&nbsp;<!--{$order.tel}-->
                </div>
                <div
                    style="font-size: 10px; float: left; word-spacing: normal; text-align: right; width: 2cm">
                <div style="padding-top: 10px" align="right">
                <table
                    style="font-size: 8px; border-collapse: collapse; border: none; width: 1.5cm">
                 <tr>
                            <td style="border: solid #000 1px; font-size: 6px; line-height: 10px;" align="center">
                      <img src="themes/default/images/HLY-YXJ-1358759297937-S.jpg"  height="52" width="52"/>
                 </td>
                         </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 20px;height:28px;"
                            align="center"> 
                            Z-5
                        </td>
                    </tr>
                </table>
                </div>
                </div>
                </td>
            </tr>
            <tr>
      <td style="border: 0px; height: 3cm;width: 7.1cm;" colspan="2" align="left">
          <table cellpadding="2" cellspacing="0"
                    style="table-layout: fixed; border-bottom: 0; border-left: 0; border-right: 0; border-top: 0; font-size: 8px; width: 7.1cm; height: 2cm; margin-left:3px;">
                    <tr>
                        <td>
                            <font style="font-weight:bold; font-size:50px; ">R</font>
                        </td>
                        <td colspan="1"
                            style="border: solid #000 1px; width: 7.1cm; padding-left: 3px"
                            align="center">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" align="center" style="font-size: 13px"><b>
                             RQ<!--{$order.track_no}-->SG
                         </b></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
                                
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="border: solid #000 1px; font-size: 8px" colspan="2" align="center">
                        香港小包挂号&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}-->
                         </td>
                    </tr>
                    
                    <tr>
                        <td style="font-size: 6px; border: 0px" colspan="2">
                        <table>
                            <tr>
                                <td align="left"
                                    style="font-size: 6px; border: 0px"></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
    </table>        
    
</td>
<td style="border-left: 1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
﻿<table width="285" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
<DIV id=C>
<DIV id=C1>
<DIV id=C11><span class=cn1>
 CUSTOMS DECLARATION</span><BR><span class=cn2>(May be opened officially)</span></DIV>
<DIV id=C12><span class=cn1>CN 22</span><BR><span class=cn2>Pos 401G(4/08)</span></DIV>
<DIV id=C13><span class=cn2>Postal administration</span></DIV>
</DIV>
<DIV id=C2>
<div id=C21><IMG src="themes/default/images/boxyes.gif" border="0"><span class=cn2>
 Gift</span></div>
<div id=C22><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Commercial sample</span></div>
<div id=C23><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Documents</span></div>
<div id=C24><IMG src="themes/default/images/boxno.gif" border="0"><span class=cn2>
 Other</span></div>
</DIV>
<DIV id=C3>
<div id=C31><span class=cn2>Quantity(2) and detailed description of contents(1)</span></div>
<div id=C32><span class=cn2>(3)Weight<BR>(kg)</span></div>
<div id=C33><span class=cn2>(5)Value</span></div>
</DIV>
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<DIV id=C4>
<div id=C41>
<div id=C411><span class=cn2>
<!--{$goods.goods_name}-->
</span></div>
<div id=C412><span class=cn2>
X <!--{$goods.goods_qty}-->
</span></div>
</div>
<div id=C42><span class=cn2>
0.15
</span></div>
<div id=C43><span class=cn2>
<!--{$goods.vargoods_price|string_format:"%.2f"}-->
</span></div>
</DIV>
<!--{/foreach}-->
<DIV id=C5>
<div id=C51><span class=cn2><u>
 For commercial items only</u><BR>If known, HS tarrif number(7) and country of origin of goods(8)</span></div>
<div id=C52><span class=cn2>(4)Total Weight<BR>(kg)</span></div>
<div id=C53><span class=cn2>(6)Total Value</span></div>
</DIV>
<DIV id=C6>
<div id=C61></div>
<div id=C62><span class=cn2>0.15</span></div>
<div id=C63><span class=cn2>$<!--{$goods.vargoods_price*$goods.goods_qty|string_format:"%.2f"}--></span></div>
</DIV>
<DIV id=C7>
<span class=cn2>I, the 

undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>

dangerous article or articles prohibited by legislation or by postal or customs regulations.
<BR></span>
</DIV>
<DIV id=C8>
<span class=cn2><BR>(15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">HLY YZJ</div>
</DIV>
</DIV>

</td>
</tr>
</table></td>
</tr>
</table>
<div <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3 == 0}-->class="pagebreak"<!--{/if}-->></div>

<!--捡货单-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>

<!--{/foreach}-->

<!--{elseif $type eq 166}--><!--检货单(new)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:162mm;">
    <div style="float:left; width:44%; text-align:center; margin-top:10px;">
        <div><img src="index.php?model=login&action=Barcode&number=<!--{$order.paypalid}-->&height=35"></div>
        <div><!--{$order.paypalid}--></div>
    </div>
    <div style="float:right; width:55%;word-break:break-all;">
        <table style=" width:100%; border-collapse:collapse;" border="1" class="tab_center" >
            <tr>
                <td width="28%">产品名</td>
                <td width="20%">SKU</td>
                <td width="10%">数量</td>
                <td width="20%">卖家物流</td>
                <td width="20%">备注</td>
            </tr>
            <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
            <tr>
                <td><!--{$goods.goods_name}--></td>
                <td><!--{$goods.goods_sn}--></td>
                <td><!--{$goods.goods_qty}--></td>
                <td><!--{$order.ShippingService}--></td>
                <td><!--{if $order.pay_note}--><!--{$order.pay_note}--><!--{/if}--></td>
            </tr>
            <!--{/foreach}-->
        </table>
    </div>
</div>
<!--{/foreach}-->

<!--{elseif $type eq 167}--><!--ebay invoice-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div >
<table border="0" cellpadding="0" cellspacing="0" width="794">
  <tr>
    <td width="292" height="50" align="center"><span style="font-size:30px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">TAX INVOICE</span></td>
    <td width="502" rowspan="2" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif; font-weight:bold">iiBuy Pty Ltd<br>
6D/443 West Botany Street<br>
Rockdale, NSW, 2216 Australia<br>
ABN: 50 130 366 228</td>
  </tr>
  <tr>
    <td align="center"><span style="font-size:16px; font-family:Arial, Helvetica, sans-serif; font-weight:bold">eBay</span></td>
  </tr>
</table>
<!-- end #header -->
<div id="mainContent">
<table width="794" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
  <tr>
    <td >
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="27%" height="20" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order Number: <!--{$order.order_sn}--></td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Sales record:?</td>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold" >Date:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Paid time:?</td>
          </tr>
        <tr>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Placed By:?</td>
          
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">user:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Record No:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order number</td>
          </tr>
        <tr>
          <td colspan="4" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Customer Detail</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Full Name :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.consignee}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Company Name:</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"> <!--{$params.Company}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Address Line 1 :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"> <!--{$order.street1}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Address Line 2 :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.street2}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">City :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.city}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">State :</td>
          <td width="25%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.state}--></td>
          <td width="27%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Postcode: </td>
          <td width="21%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.zipcode}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Phone :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.tel}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Email :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">？同上</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">&nbsp;</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">&nbsp;</td>
          </tr>
        <tr>
          <td colspan="4" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Shipping Info</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif; font-weight:bold">Shipping Method:</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.ShippingService}--></td>
          </tr>
        </table>
    </td>
    </tr>
  <tr>
    <td bgcolor="#C0C0C0" class="STYLE1"><div align="center">Products</div></td>
  </tr>
  <tr bordercolor="#000000">
    <td>
      <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="16%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">SKU</td>
          <td width="7%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">QTY</td>
          <td width="49%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Description</td>
          <td width="15%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Item Price<font size="-4">(Inc. GST)</font></td>
          <td width="13%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Total</td>
        </tr>
        
          <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
          <tr>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif" align="center"><!--{$goods.goods_sn}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_qty}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_name}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_price|string_format:"%.2f"}--></td>
            <td ><div align="center"><!--{$goods.goods_price*$goods.goods_qty|string_format:"%.2f"}--></div></td>
          </tr>
          <!--{/foreach}-->
          
                </table>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td width="43%">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="2" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Payment</td>
                </tr>
                <tr>
                  <td width="42%" height="33" align="left" bordercolor="#000000" style="font-size:12px; font-family:Arial, Helvetica, sans-serif; font-weight:bold;">Payment Method:</td>
                  <td width="58%" align="left" style="font-size:12px; font-family:Arial, Helvetica, sans-serif; font-weight:bold;">？付款方式</td>
                </tr>
                <tr>
                  <td colspan="2" bgcolor="#E0E1E2"><div id="internal_note" align="center" style="display:none;"><strong>Internal Note</strong><br />
                  <br />
                  ORDER STATUS: <?php echo $row_Recordset2['status']; if($row_Recordset2['status'] == "transfer"){ echo " Due date: ".$row_Recordset2['transfer_due'];}?></div></td>
                </tr>
              </table>
            </td>
            <td width="57%">
              <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all">
                <tr>
                  <td width="61%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Subtotal:</td>
                  <td width="39%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？售出总价</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Insurance(optional):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？0.00</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Postage:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？0.00</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Credit Card Surcharge*:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？0.00</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Total (inc GST):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">售？出总价</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">GST:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？=售出总价/11
            </td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<div id="terms" style=" font-family:Arial, Helvetica, sans-serif; font-size:12px;width:792px">
<p><i>Terms &amp; Conditions</i><br />
  > Please choose carefully as no refund or exchange for change of mind. This invoice must be presented for proof of
  warranty, refund or exchange. Product returned for credit may incur a 20% restocking fee at the discretion of iiBuy<br/>
  > Warranty will void if label is tampered or goods are found physically damaged.<br />
  > All goods opened cannot be refunded nor exchanged, please ensure to check compatibility and model number.<br />
  > We respect your privacy. All your personal details are always kept confidential. You can view our privacy policy online.<br />
  > If you are happy with your experience, please tell others; if not please contact us.<br />
</p>
</div>
</div>
</div>
<!--{/foreach}-->


<!--{elseif $type eq 168}--><!--iiBuy invoice-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div >
<table border="0" cellpadding="0" cellspacing="0" width="794">
  <tr>
    <td width="292" align="center"><span style="font-size:30px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">TAX INVOICE</span></td>
    <td width="502" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif; font-weight:bold">iiBuy PTY LTD<br>
      6D/415-443 West Botany Street<br>
      Rockdale, NSW, 2216<br>
      Australia<br>
      ABN: 50 130 366 228</td>
  </tr>
  </table>
<!-- end #header -->
<div id="mainContent">
<table width="794" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
  <tr>
    <td >
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="27%" height="20" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order Number:<!--{$order.order_sn}--> </td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Sales record:?</td>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold" >Date:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Paid time:?</td>
          </tr>
        <tr>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Placed By:?</td>
          
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">user:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Record No:?</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order number:?</td>
          </tr>
        <tr>
          <td colspan="4" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Customer Detail</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Full Name :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.consignee}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Company Name:</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$params.Company}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Address Line 1 :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.street1}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Address Line 2 :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.street2}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">City :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.city}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">State :</td>
          <td width="25%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.state}--></td>
          <td width="27%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Postcode: </td>
          <td width="21%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.zipcode}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Phone :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.tel}--></td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Email :</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">？同上</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">&nbsp;</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">&nbsp;</td>
          </tr>
        <tr>
          <td colspan="4" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Shipping Info</td>
          </tr>
        <tr>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Shipping Method:</td>
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.ShippingService}--></td>
          </tr>
        </table>
    </td>
    </tr>
  <tr>
    <td bgcolor="#C0C0C0" class="STYLE1"><div align="center">Products</div></td>
  </tr>
  <tr bordercolor="#000000">
    <td><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
      <tr>
        <td width="16%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">SKU</td>
        <td width="7%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">QTY</td>
        <td width="49%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Description</td>
        <td width="15%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Item Price<font size="-4">(Inc. GST)</font></td>
        <td width="13%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Total</td>
      </tr>
      
      <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
      <tr>
        <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif" align="center"><table cellpadding="2" cellspacing="0" border="0" width="100%">
          <tbody>
            <tr>
              <td align="center"><!--{$goods.goods_sn}--></td>
              </tr>
          </tbody>
        </table></td>
        <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_qty}--></td>
        <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_name}--></td>
        <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><table cellpadding="2" cellspacing="0" border="0" width="100%">
          <tbody>
            <tr>
              <td align="center"><!--{$goods.goods_price|string_format:"%.2f"}--></td>
              </tr>
          </tbody>
        </table></td>
        <td ><div align="center"><!--{$goods.goods_price*$goods.goods_qty|string_format:"%.2f"}--></div></td>
      </tr>
      <!--{/foreach}-->
      
    </table></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td width="43%">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="2" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Payment</td>
                </tr>
                <tr>
                  <td width="44%" height="33" align="left" bordercolor="#000000" style="font-size:12px; font-family:Arial, Helvetica, sans-serif; font-weight:bold;">Payment Method:</td>
                  <td width="56%" align="left" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;"><span id="orderform-outerCt"><span id="fieldset-1014-outerCt"><span id="panel-1015-outerCt">？付款方式</span></span></span></td>
                </tr>
                <tr>
                  <td colspan="2" bgcolor="#E0E1E2"><div id="internal_note" align="center" style="display:none;"><strong>Internal Note</strong><br />
                  <br />
                  ORDER STATUS: <?php echo $row_Recordset2['status']; if($row_Recordset2['status'] == "transfer"){ echo " Due date: ".$row_Recordset2['transfer_due'];}?></div></td>
                </tr>
              </table>
            </td>
            <td width="57%">
              <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all">
                <tr>
                  <td width="61%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Subtotal:</td>
                  <td width="39%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？Sub-Total  调用</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Insurance(optional):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？zencart insurance 调用</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Postage:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？Shipping Method 调用</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Credit Card Surcharge*:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？Surcharge Fee 调用</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Total (inc GST):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？Grand Total 调用</td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">GST:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">？Inc GST 10% 调用
                  </td>
                </tr>
                <tr>
                  <td colspan="2" align="left" bordercolor="#000000" style="font-size:10px; font-family:Arial, Helvetica, sans-serif;">*1.5% surcharge on VISA,Master & Paypal                    </td>
                </tr>
                </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<br>
<div id="terms" style=" font-family:Arial, Helvetica, sans-serif; font-size:12px;width:792px">
  <p><i>Terms &amp; Conditions</i><br />
  > Please choose carefully as no refund or exchange for change of mind. This invoice must be presented for proof of
  warranty, refund or exchange. Product returned for credit may incur a 20% restocking fee at the discretion of iiBuy<br/>
  > Warranty will void if label is tampered or goods are found physically damaged.<br />
  > All goods opened cannot be refunded nor exchanged, please ensure to check compatibility and model number.<br />
  > iiBuy.com.au assembled computers carry a 12-month return to base warranty unless otherwise indicated. All upgrades
  or additional parts are restricted to manufacturer's warranty. Virus damage, software problems or user misuses is not
  covered by warranty. A service charge may be implemented if the faults are caused by software, misuses, improper
  handlings or no faults are found.<br />
  > We respect your privacy. All your personal details are always kept confidential. You can view our privacy policy online.<br />
  > If you are happy with your experience, please tell others; if not please contact us.<br />
</p>
</div>
</div>
</div>
<!--{/foreach}--> 

<!--{elseif $type eq 333}--> 
<style type="text/css">
.STYLE2 {font-size: 9px}
</style>
<!--{foreach from =$orders item = order name=orderitem}-->
<table  border="0" cellspacing="0" cellpadding="0" style="border:#000000 1px solid; width:110mm; height:98mm">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style=" margin-left:5px">
      <tr>
        <td width="20%" style=" margin-right:120px"><table width="84%" height="70" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #000; text-align:center; margin-right:">
          <tr>
            <td width="100" height="72" ><font style="font-family:Arial; font-size:74px">F</font>&nbsp;</td>
          </tr>
        </table></td>
        <td width="54%" align="center"><table width="78%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><img src="themes/default/images/01.jpg" width="125" height="37" /></td>
          </tr>
          <tr>
            <td align="center"><img src="themes/default/images/test01-426.png" width="138" height="2" /></td>
          </tr>
          <tr>
            <td align="center" bgcolor="#FFFFFF"><img src="themes/default/images/test01-428.png" width="170" height="35" /></td>
          </tr>
          <tr>
            <td align="center"><font style="font-family:Arial, Helvetica, sans-serif"><strong>ePacket&#8482;</strong></font></td>
          </tr>
        </table></td>
        <td width="26%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><table width="66" border="0" cellspacing="1" cellpadding="0" style="border:1px solid #000; text-align:center; margin-top:5px; margin-right:5px">
              <tr>
                <td width="47" height="45" align="left"><span style="font-family:Arial, Helvetica, sans-serif; font-size:9px; line-height:10px">Aimail<br />
                  Postage Paid<br />
                  China Post </span></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td align="center"><font style="font-family:Arial; font-size:16px"><!--{$order.isd}--></font>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="7" colspan="3" valign="top" style=" margin-right:120px"><span style="font-family:Arial, Helvetica, sans-serif; font-size:7px">From:</span></td>
      </tr>
    </table>
        <div style="font-family:Arial, Helvetica, sans-serif; font-size:7px"></div></td>
  </tr>
  <tr>
    <td height="100">
    <table width="100%" border="0" cellspacing="0" cellpadding="2" style=" border-bottom:#000 1px solid; border-top:#000 1px solid;">
      <tr>
        <td width="59%" valign="top" style="border-right:#000 1px solid;"><div style="font-family:Arial, Helvetica, sans-serif; font-size:13px; margin-left:2px;line-height:11px;"> FROM:LIU YUANZHI<br />
      No.99th.Tangxia Avenue North,<br />
      Dongguan&nbsp; <br />Dongguan GUANGDONG <br />
          CHINA 523000<br /> </div></td>
        <td width="41%" rowspan="2" valign="top"><table width="100%" border="0" cellspacing="3" cellpadding="0">
          <tr>
            <td align="center"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td align="center"><div style=" ">
                
                
                <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=372&scale=2&rotation=0&font_family=Arial.ttf&font_size=0&text=<!--{$order.zipcode}-->&thickness=30&start=NULL&code=BCGcode128">
                
                </div></td>
              </tr>
              <tr>
                <td align="center"><div style="font-size:12px"><strong>ZIP <!--{$order.zipcode}--></strong></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="20" valign="bottom" style="border-right:#000 1px solid"><div style="font-family:Arial, Helvetica, sans-serif; font-size:6.2px; margin-top:6px ;margin-left:5px; vertical-align:bottom"> Customs information avaliable on attached CN22.<br />
          USPS Personnel Scan barcode below for delivery event information </div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="15%" style=" border-right: 1px solid #000
            "><div style="font-family:Arial, Helvetica, sans-serif; font-size:14px; margin-left:5px">To:  </div>
           
        </td>
        <td width="85%"><div style="font-family:Arial; font-size:14px">
            <!--{$order.consignee}--><br />
        <!--{$order.street1}-->&nbsp; <!--{$order.street2}--> <br /> <!--{$order.city}--> &nbsp;,   <!--{$order.state}--><br /><!--{$order.country}-->&nbsp; <!--{$order.zipcode}-->
        </div><br />
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="bottom" style="border-bottom:0px"><table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-bottom:#000 5px solid; border-top:#000 5px solid">
      <tr>
        <td height="109" style="border-right:#000 1px solid; font-size: 9px;"><table width="100%" border="0" cellspacing="2" cellpadding="0">
          <tr>
            <td align="center"><span style=" font-family: Arial, Helvetica, sans-serif; font-size:14px"><strong>USPS DELIVERY CONFIRMATION</strong></span>&reg;</td>
          </tr>
          <tr>
            <td align="center" ><div > 
            
                <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=372&scale=2&rotation=0&font_family=Arial.ttf&font_size=0&text=<!--{$order.track_no}-->&thickness=35&start=NULL&code=BCGcode128"> 
            
            
            </div></td>
          </tr>
          <tr>
            <td align="center"><div style="font-size:12px"><strong><!--{$order.track_no}--></strong></div></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>

<div style="page-break-after:always;" >&nbsp;</div>
<table width="554" height="393" border="0" cellpadding="0" cellspacing="0" style="border:#000000 1px solid; width:110mm; height:72mm; font-size: 9px; font-family: Arial, Helvetica, sans-serif;"  class="pagebreak">
  <tr>
    <td height="80" valign="top"><div style="font-family:Arial, Helvetica, sans-serif; font-size:7px">
      <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr>
          <td width="38%"><table width="92%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="2" valign="top"><img src="themes/default/images/01.jpg" alt="" width="120" height="32" /></td>
            </tr>
            <tr>
              <td valign="top"><div style="font-family:Arial; font-size:7px">IMPORTANT:
                The item/parcel may be<br />
                opened officially.<br />
                Please print in English<br />
              </div></td>
              <td><table width="70%" height="32" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #000; text-align:center; margin-right:">
                <tr>
                  <td width="100" height="20" ><font style="font-family:Arial; font-size:24px"><!--{$order.isd}--></font>&nbsp;</td>
                </tr>
              </table></td>
            </tr>
          </table></td>
          <td width="62%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"><div style="">  <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=Arial.ttf&font_size=10&text=<!--{$order.track_no}-->&thickness=40&start=NULL&code=BCGcode128"/> </div></td>
            </tr>
            <tr>
              <td align="center"><div style="font-size:12px"><strong><!--{$order.track_no}--></strong></div></td>
            </tr>
          </table></td>
        </tr>
      </table>
    </div></td>
  </tr>
  <tr>
  
    <td height="143" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="52%" style="border-bottom: 1px solid #000; border-right: 1px #000 solid"><div style="font-family:Arial; font-size:13px; "> FROM:LIU YUANZHI<br />
      No.99th.Tangxia Avenue North,<br />
      Dongguan&nbsp; <br />Dongguan GUANGDONG <br />
          CHINA 523000<br />
          <br />
          <br />
          <br /> 
          
         
          PHONE:13544073190</div></td>
        <td width="48%" rowspan="2" valign="top" style="border-top:#000 solid 1px"><div style=" font-size:13px; font-family:Arial, Helvetica, sans-serif">SHIP TO: <!--{$order.consignee}--><br />
        <!--{$order.street1}-->,<!--{$order.street2}-->  <!--{$order.city}-->, <!--{$order.state}--><!--{$order.country}-->&nbsp; <!--{$order.zipcode}--><br></div></td>
      </tr>
      <tr >
        <td style="border-bottom: 1px solid #000; border-right:#000 solid 1px"><div style=" font-size:12px">Fees(US $):</div></td>
      </tr>
      <tr >
        <td height="16" style="border-bottom: 1px solid #000; border-right:#000 solid 1px"><div style="font-family:Arial; font-size:12px">Certificate No.</div></td>
        <td style="border-bottom: 1px solid #000"><div style=" font-size:12px">PHONE: <!--{$order.tel}--></div></td>
      </tr>
      <tr >
        <td height="16" colspan="2" style="border-bottom: 1px solid #000; border-right:#000 solid 1px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"  style="border-bottom: 1px solid #000; border-right:#000 1px solid"><span class="STYLE2">No</span></td>
            <td align="center"  style="border-bottom: 1px solid #000; border-right:#000 1px solid"><span class="STYLE2">Qty</span></td>
            <td align="center"  style="border-bottom: 1px solid #000; border-right:#000 1px solid"><span class="STYLE2">Description of Contents</span></td>
            <td align="center"  style="border-bottom: 1px solid #000; border-right:#000 1px solid"><span class="STYLE2">Kg.</span></td>
            <td align="center"  style="border-bottom: 1px solid #000; border-right:#000 1px solid"><span class="STYLE2">Val（us$）
            </span></td>
            <td align="center"  style="border-bottom: 1px solid #000; "><span class="STYLE2">Goods Origin</span></td>
          </tr>
          
           <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
              <!--{assign var='xx' value=$smarty.foreach.goodsitem.index+1}-->    
           <!--{/foreach}-->
           
          <tr>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[0].goods_qty}-->  1 <!--{else}--> &nbsp; <!--{/if}-->   </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[0].goods_qty}--> <!--{$order.goodsarr[0].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;"> <!--{if $order.goodsarr[0].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[0].goods_sn}--> <!--{$order.goodsarr[0].location}--> <!--{else}--> &nbsp; <!--{/if}--> </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[0].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[0].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
              <td align="center"  style=" "> <!--{if $order.goodsarr[0].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}--> </td>
          </tr>
           <tr>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[1].goods_qty}-->  2 <!--{else}--> &nbsp; <!--{/if}-->   </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[1].goods_qty}--> <!--{$order.goodsarr[1].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}--> </td>
             <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;"> <!--{if $order.goodsarr[1].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[1].goods_sn}--> <!--{$order.goodsarr[1].location}--><!--{else}--> &nbsp; <!--{/if}--> </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[1].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[1].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
              <td align="center"  style=" "> <!--{if $order.goodsarr[1].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
          </tr>
          <tr>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[2].goods_qty}-->  3 <!--{else}--> &nbsp; <!--{/if}-->   </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[2].goods_qty}--> <!--{$order.goodsarr[2].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}--> </td>
             <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;">  <!--{if $order.goodsarr[2].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[2].goods_sn}--> <!--{$order.goodsarr[2].location}--><!--{else}--> &nbsp; <!--{/if}--> </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[2].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[2].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
              <td align="center"  style=" "> <!--{if $order.goodsarr[2].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
          </tr>
          <tr>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[3].goods_qty}-->  4 <!--{else}--> &nbsp; <!--{/if}-->   </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[3].goods_qty}--> <!--{$order.goodsarr[3].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;">  <!--{if $order.goodsarr[3].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[3].goods_sn}--> <!--{$order.goodsarr[3].location}--><!--{else}--> &nbsp; <!--{/if}--> </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[3].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[3].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
              <td align="center"  style=" "> <!--{if $order.goodsarr[3].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
          </tr>
          <tr>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[4].goods_qty}-->  5 <!--{else}--> &nbsp; <!--{/if}-->   </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[4].goods_qty}--> <!--{$order.goodsarr[4].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}--> </td>
             <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;">  <!--{if $order.goodsarr[4].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[4].goods_sn}--> <!--{$order.goodsarr[4].location}--><!--{else}--> &nbsp; <!--{/if}--> </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[4].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
             <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[4].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
              <td align="center"  style=" "> <!--{if $order.goodsarr[4].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
          </tr>
          <!--{if $xx>6}-->
              <tr>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->  6 <!--{else}--> &nbsp; <!--{/if}-->   </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}--> <!--{$order.goodsarr[5].goods_qty}--> <!--{else}--> &nbsp; <!--{/if}--></td>
                 <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;">  <!--{if $order.goodsarr[5].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[5].goods_sn}--> <!--{$order.goodsarr[5].location}--> <b style='color:red;font-size:12px;'>需要扫描</b><!--{else}--> &nbsp; <!--{/if}--> </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
                  <td align="center"  style=" "> <!--{if $order.goodsarr[5].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
              </tr>
          <!--{else}-->
              <tr>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->  6 <!--{else}--> &nbsp; <!--{/if}-->   </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{$order.goodsarr[5].goods_qty}-->&nbsp; </td>
                 <td height="100%" align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;font-size:12px;">  <!--{if $order.goodsarr[5].goods_qty}--> Accessories 配件 <!--{$order.goodsarr[5].goods_sn}--> <!--{$order.goodsarr[5].location}--><!--{else}--> &nbsp; <!--{/if}--> </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->   0.01 <!--{else}--> &nbsp; <!--{/if}-->  </td>
                 <td align="center"  style=" border-right:#000 1px solid;border-bottom: 0px solid #000;"> <!--{if $order.goodsarr[5].goods_qty}-->   1<!--{else}--> &nbsp; <!--{/if}-->  </td>
                  <td align="center"  style=" "> <!--{if $order.goodsarr[5].goods_qty}-->  China <!--{else}--> &nbsp; <!--{/if}-->  </td>
              </tr>
          <!--{/if}-->
          
          <tr>
            <td align="center"  style="border-right:#000 1px solid; border-top: #000 1px solid;">&nbsp;</td>
            <td align="center"  style="border-right:#000 1px solid; border-top: #000 1px solid;"><strong> <!--{$xx}--> </strong>&nbsp;</td>
            <td align="left"  style="border-top: #000 1px solid; "><div style=" font-size:10px">Total Gross Weight (Kg.):</div></td>
            <td align="center"  style=" border-right:#000 1px solid;border-top: #000 1px solid; "> <!--{$xx*0.01}--> </td>
            <td align="center"  style= "border-right:#000 1px solid; border-top: #000 1px solid;"> <!--{$xx*1}--> </td>
            <td align="center"  style=" border-top: #000 1px solid;">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="2" valign="top" ></td>
  </tr>
  <tr>
    <td ></td>
  </tr>
  <tr>
    <td  valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="2"><div style="font-family:Arial; font-size:6px">I certify the particulars given in this customs declaration are correct. This item does not contain any dangerous article, or articles prohibited by<br />
      legislation or by postal or customs regulations. I have met all applicable export filing requirements under the Foreign Trade Regulations. </div></td>
        </tr>
      <tr>
        <td><div style="font-family:Arial; font-size:8px"><strong>Sender's Signature &amp; Date Signed:</strong></div></td>
        <td align="left"><div style="font-family:Arial; font-size:18.5px; text-align:left">CN22</div></td>
      </tr>
    </table></td>
  </tr>
</table>
<!--{/foreach}-->


<!--{elseif $type eq 169}-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table style="border: 0px #707070 dashed; width: 360px; height: 350px; word-wrap: break-word;">
<tbody>
<tr style="border: 0px #707070 solid;">
<td valign="top" style="border: 0px #707070 solid; font-family: Arial; font-size: 11px;font-weight: bold;">
<div class="printSource" style="float: left; margin-left: 4px; margin-top: 10px;margin-right: 4px; width: 355px; height: 340px;">
<div style="width: 320px; height: 336px; border: 1px #707070 solid; font-family: Arial, Helvetica, sans-serif;
font-size: 12px;">
<div style="width: 100px; float: left;"><img src="themes/default/images/express/ccpost.jpg" style="width: 82px; height: 36px" alt="pic" /></div>
<div style="font-size: 10px; font-weight: bold; float: left;">航&nbsp;&nbsp;&nbsp;&nbsp;空<br />
<span style="margin-left: -15px">Small Packet</span><br />
<span>BY AIR</span></div>
<div style="text-align: center; margin-top: 10px; font-size: 14px;">CA加拿大&nbsp;&nbsp;5</div>
<div style="border: 1px #707070 solid; border-top: 0px; clear: both; border-left: 0px;
border-right: 0px; height: 0px;">&nbsp;</div>
<div style="width: 320px; height: 30px;">
<div style="padding-top: 5px;">协议客户:<span style="margin-left: 10px; font-size: 11px; font-weight: bold;">HH (44030622269000)</span></div>
</div>
<div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
height: 0px;">&nbsp;</div>
<div style="width: 320px; height: 50px;"><span style="font-size: 11px; font-weight: bold;">FROM：</span><span style="font-size: 11px;
font-weight: bold;">Longhua new district shenzhen city, guangdong province people avenue</span>
<div style="margin-top: 5px; font-size: 12px; font-weight: bold;">Zip：518000<span style="margin-left: 80px;">Tel： </span></div>
</div>
<div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
height: 0px;">&nbsp;</div>
<div style="width: 320px; height: 110px; text-align: left; font-weight: bold; float: left;"><span style="font-size: 12px;">TO:</span>
<div style="margin-left: 30px; margin-top: -14px; height: 95px;">Mary Hanna                 <br />
22 Whitlock Cres  <br />
Ajax&nbsp;&nbsp;&nbsp;Ontario<br />
CANADA(加拿大)</div>
<div style="clear: both;"><span style="font-weight: bold; padding-top: 0px;">Zip:</span>L1Z 2B2 <span style="font-weight: bold;
margin-left: 40px;">Tel:</span> 4166297181&nbsp;&nbsp;</div>
</div>
<div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
height: 0px; clear: both;">&nbsp;</div>
<div style="clear: both; width: 320px; height: 20px; padding-top: 5px;">退件单位:<span style="margin-left: 10px; font-weight: bold; font-size: 13px;">深圳大宗收寄处理中心</span></div>
<div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px;
height: 0px;">&nbsp;</div>
<div style="width: 320px; text-align: center; margin-top: 2px; height: 50px;"><span><img src='../../BarCode.aspx?TrackingNo=RI098904935CN' style='width: 280px;height:38px;'/></span><br />
RI098904935CN</div>
<div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px;
height: 0px;">
<div style="width: 320px; margin-top: 5px;">订单号: 62937426220308</div>
</div>
</div>
</div>
</td>
</tr>
</tbody>
</table> 
    
<!--{/foreach}-->


<!--{/if}-->
</body>