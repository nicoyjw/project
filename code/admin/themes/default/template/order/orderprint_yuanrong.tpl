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
-->
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
		alert(errorMsg);
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
<!--{elseif $type eq 10}--><!-打印拣货信息->
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
<!--{elseif $type eq 5}--><!-新加坡挂-->
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
<!--{elseif $type eq 8}--><!-新加坡挂号单页-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="width:350px;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li style="clear:left;font-size:24px;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:22px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:22px;width:330px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:22px;">
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
<!--{elseif $type eq 134}--><!--A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<!--{if $smarty.foreach.orderitem.index % 4 == 0}-->
<div style=" width:165mm;height:auto;page-break-after:always;clear:both;">
<!--{/if}-->
<div style="font-family:Arial;height: 60mm; width: 190mm;">
    <table style="border: 1px dashed #999999; height: 65mm; width: 190mm">
      <tr>
         <td width="115"  valign="top" style="border-right:#000000 1px dashed;height:50mm;">
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
                      <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=30">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.track_no}-->*</center></div></span><br />
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   </div><!--{if $smarty.foreach.orderitem.index % 4 == 3}-->
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

<!--{elseif $type eq 151}--><!--瑞士邮政小包（挂号）-->
<!--{foreach from =$orders item = order name=orderitem}-->
  <div style="padding:0px;margin:0px;width: 9.7cm;"  <!--{if !$smarty.foreach.orderitem.last && !$smarty.foreach.orderitem.first && ($smarty.foreach.orderitem.index+1) % 3== 0}-->class="pagebreak"<!--{/if}-->>
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
                     <span id="labelspan" style="text-align:center;"><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=35">
    <div style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.track_no}-->*</center></div></span><br />
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   </div><div style="clear:both"></div><!--{if $smarty.foreach.orderitem.index % 5 == 4}-->
</div>
<!--{/if}--><!--{/foreach}-->
<!--{elseif $type eq 132}--><!--10*5-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div style="font-family:Arial;" <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
  <table style=" height: 45mm; width: 100mm;">
      <tr>    
         <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                  <td>
                       <span id="labelspan"><li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=35"></li>
    <li style="font-size:13px;margin-top:-20px;letter-spacing:4px;width:206px"><center>*<!--{$order.order_sn}-->*</center></li></span>
                  </td>
               </tr>
               <tr>
                  <td  valign="top" >
                     <div style="font-size: 15px; font-weight: bold">
                        <span style="margin-right:2px" >Send&nbsp;To:</span><br/>
                        <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;"><!--{$order.consignee}--></span><br/>
                        <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;"><!--{$order.street1}-->&nbsp; <!--{$order.street2}--></span><br/>
                        <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;"><!--{$order.city}-->&nbsp; <!--{$order.state}--></span><br/>
                        <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;">ZIP:&nbsp;<!--{$order.zipcode}--></span><br/>
                        <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;"><!--{$order.country}-->(<!--{$order.Cncountry}-->)</span><br/>
                  <span style="font-size: 14px;font-weight:600;line-height:0.9;font-family:Arial;">Tel:<!--{$order.tel}--></span><br/>
                     </div>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   </div><!--{/foreach}-->



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
<!--{elseif $type eq 161}--><!--中国邮政航空小包挂号(广东)A4-->
<!--{foreach from =$orders item = order name=orderitem}-->
<table cellspacing="25" cellpadding="0" style="width:96mm">
<tr class="pagebreak"> 
<td valign="top"  style="width:92mm;height:85mm;border-left:1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;padding:5;padding-bottom:0;">
    <table style="font-size:12px;font-family:'PT Sans',Verdana,Tahoma,Arial,sans-serif;">
        <tr>
            <td style="padding:0;margin:0;text-align:left;height:15mm;" valign="top">
            </td>
        </tr>
    </table>                      
    <table width="100%" cellpadding="0" cellspacing="0" class="tabBq1">  
        <tr style="height:38mm">
            <td align="left" valign="middle" style="padding-left:5px" >
                <div style="font-size:11px;float:left; word-spacing: normal;font-family:'PT Sans',Verdana,Tahoma,Arial,sans-serif;width:245px;">
                    <div style=" line-height: 16px;"><font style="font-size:14px">TO:</font> <b><!--{$order.consignee}--></b></div>
                    <div style=" line-height: 16px;"><!--{$order.street1}-->&nbsp;<!--{$order.street2}-->&nbsp;<!--{$order.city}-->, <!--{$order.state}--></div>
                    <div style=" line-height: 16px;"><!--{$order.country}-->&nbsp;<!--{$order.Cncountry}-->&nbsp; <!--{$order.zipcode}--></div>
                    <div style=" line-height: 16px;">Tel:&nbsp;<!--{$order.tel}--></div>
                </div>
          </td>
         </tr>
          <tr valign="bottom">
            <td colspan="2" width="75mm" align="center" valign="middle" style="border:solid 1px #000; height:25mm; text-align: center;">
               <table cellspacing="0" cellpadding="0" >
                    <tr>
                        <td align="left" width="95px"><font style="font-weight:bold; font-size:50px; ">R</font></td>
                        <td align="left" valign="middle">
                            <img src="common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=0&font_size=8&text=<!--{$order.track_no}-->&thickness=55&start=NULL&code=BCGcode128">
                            <br>
                            <div align="center" style="font-size: 13px"><b><!--{$order.track_no}--></b></div>

                        </td>
                    </tr>
               </table> 
            </td>
        </tr> 
        <tr>
            <td colspan="2" valign="bottom" style="font-size:10px;border-bottom : 1px solid #000;border-top: 1px solid #000;border-left: 1px solid #000;border-right: 1px solid #000;font-family:sans-serif;" align="center" colspan="2">中国邮政航空小包挂号&nbsp;<!--{$order.order_sn}-->&nbsp;RefNo:<!--{$order.paypalid}--></td>
        </tr>
    </table>
</td>
</tr>
<tr class="pagebreak">   
<td valign="top" style="width:92mm;height:85mm;border-left:1px;border: 1px;border-bottom-style: dashed;border-left-style: dashed;border-right-style: dashed;border-top-style: dashed;border-color: #000;">
    <table cellpadding="0" cellspacing="0" style="font-size: 11px;font-family:Arial,sans-serif;">
        <tr>
            <td style="border-bottom:1px solid #000;padding:5px">DECLARATION<br>(May be opened officially)<br>Postal administration</td>
            <td style="border-bottom:1px solid #000;padding:5px"> <b style="font-size: 14px;">CN 22</b><br>Pos 401G(4/08)</td>
        </tr>
        <tr>
            <td valign="middle" style="border-bottom:1px solid #000;padding:5px">
                <IMG src="themes/default/images/boxyes.gif" border="0">Gift<br>
                <IMG src="themes/default/images/boxno.gif" border="0"> Documents
            </td>
            <td valign="middle"  style="border-bottom:1px solid #000;padding:5px">
                <IMG src="themes/default/images/boxno.gif" border="0">Commercial sample<br>
                <IMG src="themes/default/images/boxno.gif" border="0"> Other
            </td>
        </tr>
        <tr>
            <td width="60%" style="border-right:1px solid #000;border-bottom:1px solid #000;padding-left:5px;">
                Quantity and detailed description of contents
            </td>
            <td style="border-bottom:1px solid #000;">
                <table style="font-size:11px;font-family:Arial,sans-serif;" cellpadding="0" cellspacing="0">
                   <tr height="30px">
                      <td width="80px" style="border-right:1px solid #000;">Weight (kg)</td>
                      <td style="padding-left:5px;">Value</td>
                   </tr>
                </table>
            </td>
        </tr>                        
        
        <tr height="25px">
            <td width="60%" align="center" style="border-right:1px solid #000;border-bottom:1px solid #000;padding-left:5px;">                 
                 <span>bag &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;包&nbsp;&nbsp;&nbsp;&nbsp;X &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</span>
            </td>
            <td style="border-bottom:1px solid #000;">
                <table style="font-size:11px;font-family:Arial,sans-serif;" cellpadding="0" cellspacing="0">
                   <tr height="30px">
                      <td width="80px" align="center" style="border-right:1px solid #000;">0.2</td>
                      <td align="center" style="padding-left:15px;">10</td>
                   </tr>
                </table>
            </td>
        </tr>             
        <tr>
            <td valign="middle" width="60%" style="border-right: 1px solid #000;border-bottom:1px solid #000;padding-left:5px;">
                For commercial items only</u><BR>If known, HS tarrif number and country of origin of goods
            </td>
            <td valign="middle" style="border-bottom:1px solid #000;">
                <table style="font-size:10px;font-family:Arial,sans-serif;" cellpadding="0" cellspacing="0">
                   <tr style="height:45px;">
                      <td width="80px" style="border-right: 1px solid #000;">Total Weight<br>&nbsp;&nbsp;&nbsp;&nbsp;(kg)</td>
                      <td align="center">Total Value</td>
                   </tr>
                </table>
            </td>
        </tr>
        <tr height="25px">
            <td width="60%" style="border-right: 1px solid #000;border-bottom:1px solid #000;padding-left:5px;">
                &nbsp;
            </td>
            <td style="border-bottom:1px solid #000;">
                <table style="font-size:10px;font-family:Arial,sans-serif;" cellpadding="0" cellspacing="0">
                   <tr height="28px">
                      <td width="115px" align="center" style="border-right: 1px solid #000;">0.2</td>
                      <td width="55px" align="center">10</td>
                   </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-bottom:1px solid #000;padding-left:5px;" colspan="2">
                I, the undersigned, whose name and address are given on the item, certify that the particulars given in this declaration are correct and that this item does not contain any <br>dangerous article or articles prohibited by legislation or by postal or customs regulations.
            </td>
        </tr>
        <tr>
            <td style="padding-left:5px;" colspan="2">
                (15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold">YUANRONG</div>
            </td>
        </tr>
    </table>
</td>
</tr>         
<!--{/foreach}-->         
</table>  
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
                    <li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=50"></li>
 <center style="width:206px;margin-top:-20px;letter-spacing:4px;font-size:14px">*<!--{$order.track_no}-->*</center>
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




<!--{elseif $type eq 169}-->
<!--{foreach from =$orders item = order name=orderitem}-->
       <table style="border: 0px solid rgb(112, 112, 112); width: 700px; height: 340px; word-wrap: break-word;">
<tbody>
    <tr style="border: 0px #707070 solid; height: auto;">
        <td style="border: 1px #707070 dashed; font-family: Arial; font-size: 11px; font-weight: bold;">
         <div class="printSource" style="float: left; margin-left: 4px; margin-top: 10px;margin-right: 4px; width: 355px; height: 350px;">
            <div style="width: 320px; height: 348px; border: 1px #707070 solid; font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;">
            <div style="width: 100px; float: left;"><img src="themes/default/images/express/ccpost.jpg" style="width: 82px; height: 36px" alt="pic" /></div>
            <div style="font-size: 10px; font-weight: bold; float: left;">航&nbsp;&nbsp;&nbsp;&nbsp;空<br />
            <span style="margin-left: -15px">Small Packet</span><br />
            <span>BY AIR</span></div>
            <div style="text-align: center; margin-top: 10px; font-size: 14px;"><!--{$order.countryCode}--><!--{$order.Cncountry}-->&nbsp;&nbsp;</div>
            <div style="border: 1px #707070 solid; border-top: 0px; clear: both; border-left: 0px;
            border-right: 0px; height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 30px;">
            <div style="padding-top: 5px;">协议客户:<span style="margin-left: 10px; font-size: 11px; font-weight: bold;">HH (44030622269000)</span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 50px;"><span style="font-size: 11px; font-weight: bold;">FROM：</span><span style="font-size: 11px;
            font-weight: bold; font-family: Arial; "><!--{$params.Contact}-->  <!--{$params.Company}-->
            &nbsp;<!--{$params.Street}-->,<!--{$params.City}-->,<!--{$params.Province}-->  <!--{$params.Country}-->&nbsp;  </span>
            <div style="margin-top: 5px; font-size: 12px; font-weight: bold; font-family: Arial;">Zip：<!--{$params.Postcode}--><span style="margin-left: 80px;">Tel：<!--{$params.tel}--> </span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 110px; text-align: left; font-weight: bold; float: left; font-family: Arial;"><span style=" font-family: Arial;font-size: 12px;">TO:</span>
            <div style="margin-left: 30px; margin-top: -14px; height: 95px;"><!--{$order.consignee}--><br />
             <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->  <br />
            <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}--> &nbsp;<br />
            <!--{$order.country}--> <span style="padding:0px;margin:0px; font-family: Arial;font-size:18px"> (<!--{$order.Cncountry}-->)
                                    </span></div>
            <div style="clear: both;"><span style="font-weight: bold; padding-top: 0px; font-family: Arial;">Zip:</span><!--{$order.zipcode}--> <span style="font-weight: bold;
            margin-left: 40px; font-family: Arial;">Tel:</span> <!--{$order.tel}-->&nbsp;&nbsp;</div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px; clear: both;">&nbsp;</div>
            <div style="clear: both; width: 320px; height: 20px; padding-top: 5px; font-family: Arial;">退件单位:<span style="margin-left: 10px; font-weight: bold; font-size: 13px;">深圳大宗收寄处理中心</span></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; text-align: center; margin-top: 2px; height: 50px; font-family: Arial;"><span><img src='common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=0&font_size=0&text=<!--{$order.track_no}-->&thickness=45&start=NULL&code=BCGcode128' style='width: 250px;height:38px;'/></span><br />
            <!--{$order.track_no}--></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px; font-family: Arial;
            height: 0px;">
            <div style="width: 320px; margin-top: 5px; font-family: Arial;">订单号: <!--{$order.paypalid}--></div>
            </div>
            </div>
            </div>
        </td>
        <td style="border: 1px #707070 dashed;">
                <div style="margin-left: 2px;display: block; padding-top: 0px; margin-top: 10px; width: 322px; height: 350px; border-color: White;" class="ShowDeclaration" id="divA_R0362OI14080200007">
                <div style="width: 320px; height: 350px; font-family: Arial, Helvetica, sans-serif;  font-size: 11px; font-weight: bold; border: 1px #000000 solid;">
                <ul style="margin:0;padding:2px;">
                    <li style="width: 30%;float:left; vertical-align: top;"><img src="themes/default/images/express/ccpost.jpg" style="height:30px" alt="pic" /></li>
                    <li style=" vertical-align: top;width: 45%;float:left; text-align: center;"><span style="font-size: 10px; font-weight: normal;line-height:20px; vertical-align: top;">报关签条</span>&nbsp;<br/><span style="font-size: 11px;font-weight: normal;margin-top:15px;">(CUSTOMS DECLARATION)</span></li>
                    <li style="vertical-align: top;width: 15%;float:right;text-align: right;font-size: 10px;font-weight: bold;"><span style="line-height:20px; vertical-align: top;">邮2113</span><br/><span style="font-size: 11px;font-weight: normal;">CN22</span></li>
                </ul>
                <div style="width: 320px; clear: both; border-top : 1px #000000 solid; border-bottom: 1px #000000 solid;"><span style="font-weight: normal;">可以径行开拆</span> <span style="margin-left: 100px;font-weight: bold;">May be opened officially</span></div>

                <div style="width: 91px; height: 56px; font-weight: normal; border: 1px #000000 solid;  border-left: 0px; border-top: 0px; border-bottom: 0px; float: left; text-align: center;  vertical-align: middle;">邮件种类 Category of Item 请在适当的内容前划"√"</div>
                <div style="width: 235px; height: 28px; margin-left: 93px; font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left; line-height: 40px;">√</div>
                <div style="width: 70px; height: 28px; float: left; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-right: 0px; text-align: center;">礼品<br>
                Gift</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; text-align: center; border: 1px #000000 solid;  border-top: 0px; border-left: 0px; border-right: 0px;">商品货样<br>
                Commercial sample</div>
                </div>
                <div style="width: 235px; height: 28px; margin-left: 93px; margin-left: 93px\9;  font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left;border-bottom:0px;">&nbsp;</div>
                <div style="width: 70px; height: 28px; margin-left: 0px; float: left; margin-top: 0px;  text-align: center;border-bottom:0px;">文档<br>
                Document</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  text-align: center; border-bottom:0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; margin-left: 0px; margin-top: 2px;  text-align: center;border-bottom:0px;">其他<br>
                Other</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; font-size: 11px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">内件详细名称和数量（Quantity and detailed description of contents)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">重量(KG) Weight(KG)</div>
                <div style="float: left; width: 60px; text-align: center; height: 30px;">价值<br>Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 40px; font-size: 10px; font-weight: normal;">
                
                
                <!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->  
                
                    <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;"><!--{$goods.dec_name}-->&nbsp;&nbsp;*<!--{$goods.goods_qty}--><br></div>
                    <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;"><!--{$goods.total_weight_val|string_format:"%.2f"}-->KG</div>
                    <div style="float: left; width: 60px; text-align: center; height: 40px;">USD<!--{$goods.total_dec_val|string_format:"%.2f"}--></div>
                
                
                <!--{/foreach}-->
                
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 30px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">协调系统税则号列和货物原产国(只对 商品邮件填写)JS tariff number and country of origin of goods(For commercial                 items only)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">总重量(KG) Total weight (KG)</div>
                <div style="float: left; width: 60px; text-align: center;">总价值 <br>Total Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 20px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;">&nbsp;</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;"><!--{$order.dec_weight_total|string_format:"%.2f"}-->KG</div>
                <div style="float: left; width: 60px; text-align: center; height: 20px;">USD<!--{$order.dec_val_total|string_format:"%.2f"}--></div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="font-weight: normal; width: 320px;">我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品(I the undersigned certify that the particulars             given in this declaration are correct and this item does not contain any angerous             articles prohi bited by legislation or by postal or customs regulations)寄件人签字（Sender’s signature)：YUANRONG</div>
                </div>
            </div>
        </td>    
    </tr>
</tbody>
</table>
<!--{/foreach}-->
<!--{elseif $type eq 170}-->
<!--{foreach from =$orders item = order name=orderitem}-->
       <table style="border: 0px solid rgb(112, 112, 112); width: 700px; height: 340px; word-wrap: break-word;">
<tbody>
    <tr style="border: 0px #707070 solid; height: auto;">
        <td style="border: 1px #707070 dashed; font-family: Arial; font-size: 11px; font-weight: bold;">
         <div class="printSource" style="float: left; margin-left: 4px; margin-top: 10px;margin-right: 4px; width: 355px; height: 350px;">
            <div style="width: 320px; height: 348px; border: 1px #707070 solid; font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;">
            <div style="width: 100px; float: left;"><img src="themes/default/images/express/ccpost.jpg" style="width: 82px; height: 36px" alt="pic" /></div>
            <div style="font-size: 10px; font-weight: bold; float: left;">航&nbsp;&nbsp;&nbsp;&nbsp;空<br />
            <span style="margin-left: -15px">Small Packet</span><br />
            <span>BY AIR</span></div>
            <div style="text-align: center; margin-top: 10px; font-size: 14px;"><!--{$order.countryCode}--><!--{$order.Cncountry}-->&nbsp;&nbsp;</div>
            <div style="border: 1px #707070 solid; border-top: 0px; clear: both; border-left: 0px;
            border-right: 0px; height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 30px;">
            <div style="padding-top: 5px;">协议客户:<span style="margin-left: 10px; font-size: 11px; font-weight: bold;"></span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 50px;"><span style="font-size: 11px; font-weight: bold;">FROM：</span><span style="font-size: 11px;
            font-weight: bold; font-family: Arial; "><!--{$params.Contact}-->  <!--{$params.Company}-->
            &nbsp;<!--{$params.Street}-->,<!--{$params.City}-->,<!--{$params.Province}-->  <!--{$params.Country}-->&nbsp;  </span>
            <div style="margin-top: 5px; font-size: 12px; font-weight: bold; font-family: Arial;">Zip：<!--{$params.Postcode}--><span style="margin-left: 80px;">Tel：<!--{$params.tel}--> </span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 110px; text-align: left; font-weight: bold; float: left; font-family: Arial;"><span style=" font-family: Arial;font-size: 12px;">TO:</span>
            <div style="margin-left: 30px; margin-top: -14px; height: 95px;"><!--{$order.consignee}--><br />
             <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->  <br />
            <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}--> &nbsp;<br />
            <!--{$order.country}--> <span style="padding:0px;margin:0px; font-family: Arial;font-size:18px"> (<!--{$order.Cncountry}-->)
                                    </span></div>
            <div style="clear: both;"><span style="font-weight: bold; padding-top: 0px; font-family: Arial;">Zip:</span><!--{$order.zipcode}--> <span style="font-weight: bold;
            margin-left: 40px; font-family: Arial;">Tel:</span> <!--{$order.tel}-->&nbsp;&nbsp;</div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px; clear: both;">&nbsp;</div>
            <div style="clear: both; width: 320px; height: 20px; padding-top: 5px; font-family: Arial;">退件单位:<span style="margin-left: 10px; font-weight: bold; font-size: 13px;">福建龙岩</span></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; text-align: center; margin-top: 2px; height: 50px; font-family: Arial;"><span><img src='common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=0&font_size=0&text=<!--{$order.track_no}-->&thickness=45&start=NULL&code=BCGcode128' style='width: 250px;height:38px;'/></span><br />
            <!--{$order.track_no}--></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px; font-family: Arial;
            height: 0px;">
            <div style="width: 320px; margin-top: 5px; font-family: Arial;">订单号: <!--{$order.paypalid}--></div>
            </div>
            </div>
            </div>
        </td>
    </tr>
    <tr style="border: 0px #707070 solid; height: auto;">
        <td style="border: 1px #707070 dashed;">
                <div style="margin-left: 2px;display: block; padding-top: 0px; margin-top: 10px; width: 322px; height: 350px; border-color: White;" class="ShowDeclaration" id="divA_R0362OI14080200007">
                <div style="width: 320px; height: 350px; font-family: Arial, Helvetica, sans-serif;  font-size: 11px; font-weight: bold; border: 1px #000000 solid;">
                <ul style="margin:0;padding:2px;">
                    <li style="width: 30%;float:left; vertical-align: top;"><img src="themes/default/images/express/ccpost.jpg" style="height:30px" alt="pic" /></li>
                    <li style=" vertical-align: top;width: 45%;float:left; text-align: center;"><span style="font-size: 10px; font-weight: normal;line-height:20px; vertical-align: top;">报关签条</span>&nbsp;<br/><span style="font-size: 11px;font-weight: normal;margin-top:15px;">(CUSTOMS DECLARATION)</span></li>
                    <li style="vertical-align: top;width: 15%;float:right;text-align: right;font-size: 10px;font-weight: bold;"><span style="line-height:20px; vertical-align: top;">邮2113</span><br/><span style="font-size: 11px;font-weight: normal;">CN22</span></li>
                </ul>
                <div style="width: 320px; clear: both; border-top : 1px #000000 solid; border-bottom: 1px #000000 solid;"><span style="font-weight: normal;">可以径行开拆</span> <span style="margin-left: 100px;font-weight: bold;">May be opened officially</span></div>

                <div style="width: 91px; height: 56px; font-weight: normal; border: 1px #000000 solid;  border-left: 0px; border-top: 0px; border-bottom: 0px; float: left; text-align: center;  vertical-align: middle;">邮件种类 Category of Item 请在适当的内容前划"√"</div>
                <div style="width: 235px; height: 28px; margin-left: 93px; font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left; line-height: 40px;">√</div>
                <div style="width: 70px; height: 28px; float: left; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-right: 0px; text-align: center;">礼品<br>
                Gift</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; text-align: center; border: 1px #000000 solid;  border-top: 0px; border-left: 0px; border-right: 0px;">商品货样<br>
                Commercial sample</div>
                </div>
                <div style="width: 235px; height: 28px; margin-left: 93px; margin-left: 93px\9;  font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left;border-bottom:0px;">&nbsp;</div>
                <div style="width: 70px; height: 28px; margin-left: 0px; float: left; margin-top: 0px;  text-align: center;border-bottom:0px;">文档<br>
                Document</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  text-align: center; border-bottom:0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; margin-left: 0px; margin-top: 2px;  text-align: center;border-bottom:0px;">其他<br>
                Other</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; font-size: 11px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">内件详细名称和数量（Quantity and detailed description of contents)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">重量(KG) Weight(KG)</div>
                <div style="float: left; width: 60px; text-align: center; height: 30px;">价值<br>Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 40px; font-size: 10px; font-weight: normal;">
                
                
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;">bag&nbsp;&nbsp;*&nbsp;&nbsp;1<br></div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;">0.20KG</div>
                <div style="float: left; width: 60px; text-align: center; height: 40px;">USD5.00</div>
               
                
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 30px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">协调系统税则号列和货物原产国(只对 商品邮件填写)JS tariff number and country of origin of goods(For commercial                 items only)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">总重量(KG) Total weight (KG)</div>
                <div style="float: left; width: 60px; text-align: center;">总价值 <br>Total Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 20px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;">&nbsp;</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;">0.20KG</div>
                <div style="float: left; width: 60px; text-align: center; height: 20px;">USD5.00</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="font-weight: normal; width: 320px;">我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品(I the undersigned certify that the particulars             given in this declaration are correct and this item does not contain any angerous             articles prohi bited by legislation or by postal or customs regulations)寄件人签字（Sender’s signature)：YUANRONG</div>
                </div>
            </div>
        </td>
    </tr>
</tbody>
</table>
<!--{/foreach}-->
<!--{elseif $type eq 171}-->
<!--{foreach from =$orders item = order name=orderitem}-->
       <table style="border: 0px solid rgb(112, 112, 112); width: 700px; height: 340px; word-wrap: break-word;">
<tbody>
    <tr style="border: 0px #707070 solid; height: auto;">
        <td style="border: 1px #707070 dashed; font-family: Arial; font-size: 11px; font-weight: bold;">
         <div class="printSource" style="float: left; margin-left: 4px; margin-top: 10px;margin-right: 4px; width: 355px; height: 350px;">
            <div style="width: 320px; height: 348px; border: 1px #707070 solid; font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;">
            <div style="width: 100px; float: left;"><img src="themes/default/images/express/ccpost.jpg" style="width: 82px; height: 36px" alt="pic" /></div>
            <div style="font-size: 10px; font-weight: bold; float: left;">航&nbsp;&nbsp;&nbsp;&nbsp;空<br />
            <span style="margin-left: -15px">Small Packet</span><br />
            <span>BY AIR</span></div>
            <div style="text-align: center; margin-top: 10px; font-size: 14px;"><!--{$order.countryCode}--><!--{$order.Cncountry}-->&nbsp;&nbsp;</div>
            <div style="border: 1px #707070 solid; border-top: 0px; clear: both; border-left: 0px;
            border-right: 0px; height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 30px;">
            <div style="padding-top: 5px;">协议客户:<span style="margin-left: 10px; font-size: 11px; font-weight: bold;"></span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 50px;"><span style="font-size: 11px; font-weight: bold;">FROM：</span><span style="font-size: 11px;
            font-weight: bold; font-family: Arial; "><!--{$params.Contact}-->  <!--{$params.Company}-->
            &nbsp;<!--{$params.Street}-->,<!--{$params.City}-->,<!--{$params.Province}-->  <!--{$params.Country}-->&nbsp;  </span>
            <div style="margin-top: 5px; font-size: 12px; font-weight: bold; font-family: Arial;">Zip：<!--{$params.Postcode}--><span style="margin-left: 80px;">Tel：<!--{$params.tel}--> </span></div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; height: 110px; text-align: left; font-weight: bold; float: left; font-family: Arial;"><span style=" font-family: Arial;font-size: 12px;">TO:</span>
            <div style="margin-left: 30px; margin-top: -14px; height: 95px;"><!--{$order.consignee}--><br />
             <!--{$order.street1}-->&nbsp; <!--{$order.street2}-->  <br />
            <!--{$order.city}-->,<!--{if $order.state}--><!--{$order.state}-->,<!--{/if}--> &nbsp;<br />
            <!--{$order.country}--> <span style="padding:0px;margin:0px; font-family: Arial;font-size:18px"> (<!--{$order.Cncountry}-->)
                                    </span></div>
            <div style="clear: both;"><span style="font-weight: bold; padding-top: 0px; font-family: Arial;">Zip:</span><!--{$order.zipcode}--> <span style="font-weight: bold;
            margin-left: 40px; font-family: Arial;">Tel:</span> <!--{$order.tel}-->&nbsp;&nbsp;</div>
            </div>
            <div style="border: 1px #707070 solid; border-top: 0px; border-left: 0px; border-right: 0px;
            height: 0px; clear: both;">&nbsp;</div>
            <div style="clear: both; width: 320px; height: 20px; padding-top: 5px; font-family: Arial;">退件单位:<span style="margin-left: 10px; font-weight: bold; font-size: 13px;">武汉大宗处理中心</span></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px;
            height: 0px;">&nbsp;</div>
            <div style="width: 320px; text-align: center; margin-top: 2px; height: 50px; font-family: Arial;"><span><img src='common/lib/barcodegen/html/image.php?filetype=PNG&dpi=72&scale=1&rotation=0&font_family=0&font_size=0&text=<!--{$order.track_no}-->&thickness=45&start=NULL&code=BCGcode128' style='width: 250px;height:38px;'/></span><br />
            <!--{$order.track_no}--></div>
            <div style="border: 1px #707070 solid; border-bottom: 0px; border-left: 0px; border-right: 0px; font-family: Arial;
            height: 0px;">
            <div style="width: 320px; margin-top: 5px; font-family: Arial;">订单号: <!--{$order.paypalid}--></div>
            </div>
            </div>
            </div>
        </td>
    </tr>
    <tr style="border: 0px #707070 solid; height: auto;">
        <td style="border: 1px #707070 dashed;">
                <div style="margin-left: 2px;display: block; padding-top: 0px; margin-top: 10px; width: 322px; height: 350px; border-color: White;" class="ShowDeclaration" id="divA_R0362OI14080200007">
                <div style="width: 320px; height: 350px; font-family: Arial, Helvetica, sans-serif;  font-size: 11px; font-weight: bold; border: 1px #000000 solid;">
                <ul style="margin:0;padding:2px;">
                    <li style="width: 30%;float:left; vertical-align: top;"><img src="themes/default/images/express/ccpost.jpg" style="height:30px" alt="pic" /></li>
                    <li style=" vertical-align: top;width: 45%;float:left; text-align: center;"><span style="font-size: 10px; font-weight: normal;line-height:20px; vertical-align: top;">报关签条</span>&nbsp;<br/><span style="font-size: 11px;font-weight: normal;margin-top:15px;">(CUSTOMS DECLARATION)</span></li>
                    <li style="vertical-align: top;width: 15%;float:right;text-align: right;font-size: 10px;font-weight: bold;"><span style="line-height:20px; vertical-align: top;">邮2113</span><br/><span style="font-size: 11px;font-weight: normal;">CN22</span></li>
                </ul>
                <div style="width: 320px; clear: both; border-top : 1px #000000 solid; border-bottom: 1px #000000 solid;"><span style="font-weight: normal;">可以径行开拆</span> <span style="margin-left: 100px;font-weight: bold;">May be opened officially</span></div>

                <div style="width: 91px; height: 56px; font-weight: normal; border: 1px #000000 solid;  border-left: 0px; border-top: 0px; border-bottom: 0px; float: left; text-align: center;  vertical-align: middle;">邮件种类 Category of Item 请在适当的内容前划"√"</div>
                <div style="width: 235px; height: 28px; margin-left: 93px; font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left; line-height: 40px;">√</div>
                <div style="width: 70px; height: 28px; float: left; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-right: 0px; text-align: center;">礼品<br>
                Gift</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; text-align: center; border: 1px #000000 solid;  border-top: 0px; border-left: 0px; border-right: 0px;">商品货样<br>
                Commercial sample</div>
                </div>
                <div style="width: 235px; height: 28px; margin-left: 93px; margin-left: 93px\9;  font-weight: normal;">
                <div style="width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; text-align: center; float: left;border-bottom:0px;">&nbsp;</div>
                <div style="width: 70px; height: 28px; margin-left: 0px; float: left; margin-top: 0px;  text-align: center;border-bottom:0px;">文档<br>
                Document</div>
                <div style="float: left; width: 16px; height: 28px; border: 1px #000000 solid; border-top: 0px;  text-align: center; border-bottom:0px;">&nbsp;</div>
                <div style="float: left; width: 123px; height: 28px; margin-left: 0px; margin-top: 2px;  text-align: center;border-bottom:0px;">其他<br>
                Other</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; font-size: 11px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">内件详细名称和数量（Quantity and detailed description of contents)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 30px;">重量(KG) Weight(KG)</div>
                <div style="float: left; width: 60px; text-align: center; height: 30px;">价值<br>Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 40px; font-size: 10px; font-weight: normal;">
                
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;">bag&nbsp;&nbsp;*&nbsp;&nbsp;1<br></div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 40px;">0.20KG</div>
                <div style="float: left; width: 60px; text-align: center; height: 40px;">USD5.00</div>
               
                
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 30px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">协调系统税则号列和货物原产国(只对 商品邮件填写)JS tariff number and country of origin of goods(For commercial                 items only)</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 55px;">总重量(KG) Total weight (KG)</div>
                <div style="float: left; width: 60px; text-align: center;">总价值 <br>Total Value</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="width: 320px; height: 20px; font-weight: normal;">
                <div style="float: left; width: 180px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;">&nbsp;</div>
                <div style="float: left; width: 70px; border: 1px #000000 solid; border-top: 0px;  border-left: 0px; border-bottom: 0px; text-align: center; height: 20px;">0.20KG</div>
                <div style="float: left; width: 60px; text-align: center; height: 20px;">USD5.00</div>
                </div>
                <div style="border: 1px #000000 solid; border-top: 0px; clear: both; border-left: 0px;  border-right: 0px; height: 0px;">&nbsp;</div>
                <div style="font-weight: normal; width: 320px;">我保证上述申报准确无误，本函件内未装寄法律或邮政和海关规章禁止寄递的任何危险物品(I the undersigned certify that the particulars             given in this declaration are correct and this item does not contain any angerous             articles prohi bited by legislation or by postal or customs regulations)寄件人签字（Sender’s signature)：YUANRONG</div>
                </div>
            </div>
        </td>
    </tr>
</tbody>
</table>
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
<!--{/if}-->
</body>