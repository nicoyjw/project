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
<!--{if $smarty.foreach.orderitem.index % 5 == 0}-->
<div style=" width:125mm;height:auto;page-break-after:always;clear:both;margin:5px 0 0 5mm">
<!--{/if}-->
<div style="font-family:Arial;width: 125mm;text-align:center">
    <table style="width: 125mm">
      <tr>
         <td width="136" valign="top" >
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="word-break: break-all;break-all;position:relative;">
               <tr>
                  <td valign="top">
                  	<ul style="font-size:11px; text-align:left;">
                        <li>Lin</li>
                        <li>Lusenstr.1</li>
                        <li>93083 Obertraubling</li>
                        <li>Deutschland</li>
                    </ul>
                  </td>
               </tr>
            </table>
         </td>
         <td width="244" valign="top">
            <table width="95%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                  <td>
                     <div style="font-size: 15px; font-weight: bold">
                       	<!--{$order.consignee}--><br/>
                        <!--{$order.street1}-->&nbsp; <!--{$order.street2}--><br/>
                        <!--{$order.city}-->&nbsp; <!--{$order.state}--><!--{$order.zipcode}--><br/>
                        <!--{$order.country}--><br/><br/>
                     </div>
                     <div style="font-size:11px;"><!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
<!--{$goods.goods_sn}--><!--{if $goods.goods_qty > 1}-->&<!--{$goods.goods_qty}--><!--{/if}-->
<!--{/foreach}--></span></div>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
   </table>
   <div style="height:20px"></div>
   </div><!--{if $smarty.foreach.orderitem.index % 5 == 4}-->
</div>
<!--{/if}--><!--{/foreach}-->
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
<!--{/if}-->
</body>