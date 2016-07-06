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
.STYLE4 {font-size: 14px; font-weight: bold; }
.STYLE5 {font-family: Arial, Helvetica, sans-serif}
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
<!--{$goods.goods_qty}-->&nbsp;&nbsp;<!--{$goods.dec_name}-->
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
<!--{elseif $type eq 158}--><!-- 中国邮政小包（挂号）10*10 -->
<!--{foreach from =$orders item = order name=orderitem}-->
 <DIV style="PADDING-BOTTOM: 0px; width:350px;MARGIN: 0px; PADDING-LEFT: 0px;PADDING-RIGHT: 0px; PADDING-TOP: 0px"  <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<!--地址标签-->
<ul>
<li>
<div style="font-size:12px;width:325px;float:left;height:5px;text-align:center">
</div>
</li>
<li style="clear:left;font-size:20;margin-top:4px"><b>TO:<!--{$order.consignee}--></b></li>
<li style="font-size:20px;"><b><!--{$order.street1}-->  <!--{$order.street2}--></b></li>
<li style="font-size:20px;"><b><!--{$order.city}-->,<!--{$order.state}-->,<!--{$order.zipcode}--></b></li>
<li style="font-size:20px;">
<b><!--{$order.country}-->(<!--{$order.Cncountry}-->)</b><br>
<b><!--{$order.tel}--></b>
</li>
<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.track_no}-->&height=30"></li>
<li style="width:206px;margin-top:-20px;letter-spacing:4px;margin-left:20px;">*<!--{$order.track_no}-->*</li>
<li><span style="font-size:12px;">
<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
<b style="font-size:14px"><!--{$goods.goods_sn}--></b>&nbsp;&nbsp;&nbsp;&nbsp;
 <!--{/foreach}-->
</li>
</ul>
</div>
<!--地址标签-->

<div style="clear:both;height:15px;" class="pagebreak"></div>
<div style="padding:0px;margin-left:10px;position:relative;top:0.3cm;width:7.2cm;height:8.9cm;border:1px solid #000;font-family:arial;font-size:12px;">
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
                        <td style="padding:2px;    border-top:1px solid #000; border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;" rowspan="2"
                        valign="top">
                            总价值
                            <br />
                            Total Value
                            <br />
                            <br />
                            <span  contenteditable = "true"></span>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm;">
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;">
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
<!--{elseif $type eq 160}--><!-- 中国邮政小包（平邮）-->
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
                        <td style="padding:2px;    border-top:1px solid #000; border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
                        overflow:hidden;padding:0px;margin:0px;width:1.5cm;font-size:6pt;text-align:center;" rowspan="2"
                        valign="top">
                            总价值
                            <br />
                            Total Value
                            <br />
                            <br />
                            <span  contenteditable = "true"></span>
                        </td>
                    </tr>
                    <tr style="padding:0px;margin:0px;height:0.3cm;">
                        <td style="padding:2px;    border-right:1px solid #000;    border-bottom:1px solid #000;    border-collapse:collapse;
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
<table border="0" cellpadding="0" cellspacing="0" width="794">
  <tr>
    <td>&nbsp;</td>
    <td style="font-size:30px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">TAX INVOICE</td>
  </tr>
</table>
<!-- end #header -->
<div id="mainContent">
<table width="794" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
  <tr>
    <td width="1046" >
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="27%" height="20" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order Number: </td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.track_no}--></td>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold" >Date:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.paid_time}--></td>
        </tr>
        <tr>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Placed By:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><?php echo $row_Recordset2['users_id']; ?></td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Record No:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><?php echo $recordnumber00; ?></td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.consignee}-->&nbsp;</td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.email}--></td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.shipping}--></td>
        </tr>
      </table>
    </td>
    <td width="270" colspan="3" align="right"><img src="http://61.144.222.46/erp/themes/default/images/iibuy_logo.jpg" width="270" height="343"/></td>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#C0C0C0" class="STYLE1"><div align="center">Products</div></td>
  </tr>
  <tr bordercolor="#000000">
    <td colspan="4">
      <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="16%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">It No</td>
          <td width="7%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">QTY</td>
          <td width="49%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Description</td>
          <td width="15%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Item Price<font size="-4">(Inc. GST)</font></td>
          <td width="13%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Total</td>
        </tr>
		<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
          <tr>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif" align="center"><!--{$goods.goods_sn}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_qty}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_name}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_price}--></td>
            <td ><div align="center"><!--{$goods.goods_price*$goods.goods_qty}--></div></td>
          </tr>
		<!--{/foreach}-->
        </table>
      </td>
    </tr>
    <tr>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="2" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Payment</td>
                </tr>
                <tr>
                  <td width="52%" height="33" align="right" bordercolor="#000000" style="font-size:13px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;">Payment Method:</td>
                  <td width="48%" align="right" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;"><span style="font-size:14px; font-family:Arial, Helvetica, sans-serif">4564</span></td>
                </tr>
                <tr>
                  <td colspan="2" bgcolor="#E0E1E2"><div id="internal_note" align="center" style="display:none;"><strong>Internal Note</strong><br />
                  <!--{$order.note}--><br />
                  ORDER STATUS: <?php echo $row_Recordset2['status']; if($row_Recordset2['status'] == "transfer"){ echo " Due date: ".$row_Recordset2['transfer_due'];}?></div></td>
                </tr>
              </table>
            </td>
            <td>
              <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all">
                <tr>
                  <td width="61%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Subtotal:</td>
                  <td width="39%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center"><!--{$order.total}--></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Insurance(optional):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
                  <?php	echo number_format($totalicf,2);?></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Postage:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center"><?php echo $ebay_shipfee;?></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Credit Card Surcharge*:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
        </td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Total (inc GST):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">

                  </td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">GST:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
                  <?php echo number_format(($total+$ebay_shipfee)/11,2);?>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="font-size:10px; font-family:Arial, Helvetica, sans-serif;" bordercolor="#000000" align="left">*1.85% surcharge on VISA,Master &amp Paypal, 3% surcharge on AMEX.</td>
                </tr>
                <tr>
                  <td colspan="2" style="font-size:10px; font-family:Arial, Helvetica, sans-serif;" bordercolor="#000000" align="left">NOTE: Some goods cannot be delivered by air or post.<br />
                  Insurance: $2 per $100.00<br />
                  ie. Up to $100.00 = $2; $101.00 - $200 = $4.00<br />
                  A 20% non-refundable deposit required in advance<br />
                  For conditions, please visit www.iibuy.com.au</td>
                </tr>
                <tr>
                  <td colspan="2"><div align="center">&nbsp;</div></td>
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
  > iiBuy.com.au assembled computers carry a 24-month return to base warranty unless otherwise indicated. All upgrades
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
<!--{elseif $type eq 11}--><!-打印形式invoice->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table border="0" cellpadding="0" cellspacing="0" width="794">
  <tr>
    <td>&nbsp;</td>
    <td style="font-size:30px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">TAX INVOICE</td>
  </tr>
</table>
<!-- end #header -->
<div id="mainContent">
<table width="794" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
  <tr>
    <td width="1046" >
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="27%" height="20" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Order Number: </td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.track_no}--></td>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold" >Date:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.paid_time}--></td>
        </tr>
        <tr>
          <td  style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Placed By:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><?php echo $row_Recordset2['users_id']; ?></td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold">Record No:</td>
          <td style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><?php echo $recordnumber00; ?></td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.consignee}-->&nbsp;</td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.email}--></td>
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
          <td colspan="3" style="font-size:12px; font-family:Arial, Helvetica, sans-serif;font-weight:bold"><!--{$order.shipping}--></td>
        </tr>
      </table>
    </td>
    <td width="270" colspan="3" align="right"><img src="http://61.144.222.46/erp/themes/default/images/gameegg_logo.png" width="270" height="343"/></td>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#C0C0C0" class="STYLE1"><div align="center">Products</div></td>
  </tr>
  <tr bordercolor="#000000">
    <td colspan="4">
      <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all; font-family: Arial, Helvetica, sans-serif;">
        <tr>
          <td width="16%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">It No</td>
          <td width="7%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">QTY</td>
          <td width="49%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Description</td>
          <td width="15%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Item Price<font size="-4">(Inc. GST)</font></td>
          <td width="13%" align="center" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#E0E1E2">Total</td>
        </tr>
		<!--{foreach from =$order.goodsarr item = goods name=goodsitem}-->
          <tr>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif" align="center"><!--{$goods.goods_sn}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_qty}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_name}--></td>
            <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;" align="center"><!--{$goods.goods_price}--></td>
            <td ><div align="center"><!--{$goods.goods_price*$goods.goods_qty}--></div></td>
          </tr>
		<!--{/foreach}-->
        </table>
      </td>
    </tr>
    <tr>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="2" style="font-size:16px; font-family:Arial, Helvetica, sans-serif;font-weight:bold; background-color:#C0C0C0" align="center">Payment</td>
                </tr>
                <tr>
                  <td width="52%" height="33" align="right" bordercolor="#000000" style="font-size:13px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;">Payment Method:</td>
                  <td width="48%" align="right" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;"><span style="font-size:14px; font-family:Arial, Helvetica, sans-serif">4564</span></td>
                </tr>
                <tr>
                  <td colspan="2" bgcolor="#E0E1E2"><div id="internal_note" align="center" style="display:none;"><strong>Internal Note</strong><br />
                  <!--{$order.note}--><br />
                  ORDER STATUS: <?php echo $row_Recordset2['status']; if($row_Recordset2['status'] == "transfer"){ echo " Due date: ".$row_Recordset2['transfer_due'];}?></div></td>
                </tr>
              </table>
            </td>
            <td>
              <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" style="word-break:break-all">
                <tr>
                  <td width="61%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Subtotal:</td>
                  <td width="39%" style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center"><!--{$order.total}--></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Insurance(optional):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
                  <?php	echo number_format($totalicf,2);?></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Postage:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center"><?php echo $ebay_shipfee;?></td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Credit Card Surcharge*:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
        </td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">Total (inc GST):</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">

                  </td>
                </tr>
                <tr>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="right">GST:</td>
                  <td style="font-size:14px; font-family:Arial, Helvetica, sans-serif;font-weight:bold;" bordercolor="#000000" align="center">
                  <?php echo number_format(($total+$ebay_shipfee)/11,2);?>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="font-size:10px; font-family:Arial, Helvetica, sans-serif;" bordercolor="#000000" align="left">*1.85% surcharge on VISA,Master &amp Paypal, 3% surcharge on AMEX.</td>
                </tr>
                <tr>
                  <td colspan="2" style="font-size:10px; font-family:Arial, Helvetica, sans-serif;" bordercolor="#000000" align="left">NOTE: Some goods cannot be delivered by air or post.<br />
                  Insurance: $2 per $100.00<br />
                  ie. Up to $100.00 = $2; $101.00 - $200 = $4.00<br />
                  A 20% non-refundable deposit required in advance<br />
                  For conditions, please visit www.iibuy.com.au</td>
                </tr>
                <tr>
                  <td colspan="2"><div align="center">&nbsp;</div></td>
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
  > iiBuy.com.au assembled computers carry a 24-month return to base warranty unless otherwise indicated. All upgrades
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
<!--{elseif $type eq 14}-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table  width="100%" height="" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top">
      <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" style="border:1px dashed #999999">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="75%" class="STYLE5">
                  <table width="112%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
<img src="http://61.144.222.46/erp/themes/default/images/logoEbay.gif" alt="" width="119" height="49" /></td>
<?php }?>
                      <td><font size="2px">If not delivered please<br /> 
                      return to <br />
                      PO BOX 388<br />
                      ROCKDALE NSW 2216</font></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><span style="font-weight:bold">ebayaccount</span></td>
                            <td>userid</td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
                </td>
                <td width="25%" align="right" valign="middle" class="STYLE5">
                  <table width="10px" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                    <tr>
                      <td align="center" valign="middle">POSTAGE PAID AUSTRALIA</td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
              <tr>
                <td width="22%" valign="top" bgcolor="#FFFFFF" class="STYLE5"><span class="STYLE4">Send To</span></td>
                <td width="78%" align="left" bgcolor="#FFFFFF" class="STYLE5"><span class="STYLE4"><?php echo $addressline;?></span></td>
              </tr>
              <tr>
                <td colspan="2" valign="top" bgcolor="#FFFFFF" class="STYLE5">
                  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
                    <tr>
                      <td bgcolor="#FFFFFF">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center">
                            <img src="barcode128.class.php?data=<?php if($ordertype == '1'){echo $order_no;}elseif($ordertype == '2'){echo $ordersn;}else{echo $ebay_id;}?>" alt=""/></td>
                          </tr>
                          <tr>
                            <td align="center"></td>
                          </tr>
                        </table>
                      </td>
                      <td bgcolor="#FFFFFF" align="center"><!--{$order.shipping}--><br />
                     <!--{$order.paid_time}--></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td><span class="STYLE5"></span></td>
        </tr>
        <tr>
          <td height="35">
            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
 <tr>
                <td bgcolor="#FFFFFF" class="STYLE5"><img src="index.php?model=login&action=Barcode&number=<!--{$goods.goods_sn}-->&height=34" alt=""/><br /><!--{$goods.goods_sn}-->&nbsp;</td>
                <td bgcolor="#FFFFFF" class="STYLE5"><b><!--{$goods.location}--></b>&nbsp;</td>
                <td align="center" bgcolor="#FFFFFF" class="STYLE5">
                <font size="2px">
</font></td>
              </tr>          

            </table>
            <div align="right" class="STYLE5">
            <div align="right">
            Record No: &nbsp;&nbsp
</div>
            <br />
            </div></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>
<!--{/foreach}-->


<!--{elseif $type eq 4}-->
<!--{foreach from =$orders item = order name=orderitem}-->
<div <!--{if $smarty.foreach.orderitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<table  width="100%" height="" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top">
      <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" style="border:1px dashed #999999">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="75%" class="STYLE5">
                  <table width="112%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
<img src="http://61.144.222.46/erp/themes/default/images/logoEbay.gif" alt="" width="119" height="49" /></td>
<?php }?>
                      <td><font size="2px">If not delivered please<br /> 
                      return to <br />
                      PO BOX 388<br />
                      ROCKDALE NSW 2216</font></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><span style="font-weight:bold">ebayaccount</span></td>
                            <td><!--{$order.allaccount}--></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
                </td>
                <td width="25%" align="right" valign="middle" class="STYLE5">
                  <table width="10px" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                    <tr>
                      <td align="center" valign="middle">POSTAGE PAID AUSTRALIA</td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
              <tr>
                <td width="22%" valign="top" bgcolor="#FFFFFF" class="STYLE5"><span class="STYLE4">Send To</span></td>
                <td width="78%" align="left" bgcolor="#FFFFFF" class="STYLE5"><span class="STYLE4"><b style="font-size: 12px"><!--{$order.consignee}--></b> 
				<br>
           <!--{$order.street1}-->
<br><!--{$order.city}-->, <!--{$order.state}-->, <!--{$order.zipcode}-->
<br><!--{$order.country}--><br>
        <!--{$order.country}-->&nbsp;(<!--{$order.Cncountry}-->)<br>
		<!--{$order.tel}--></span></td>
              </tr>
              <tr>
                <td colspan="2" valign="top" bgcolor="#FFFFFF" class="STYLE5">
                  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
                    <tr>
                      <td bgcolor="#FFFFFF">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center">
                            <img src="index.php?model=login&action=Barcode&number=<!--{$goods.goods_sn}-->&height=34" alt=""/></td>
                          </tr>
                          <tr>
                            <td align="center"></td>
                          </tr>
                        </table>
                      </td>
                      <td bgcolor="#FFFFFF" align="center"><!--{$order.shipping}--><br />
                     <!--{$order.paid_time}--></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td><span class="STYLE5"></span></td>
        </tr>
        <tr>
          <td height="35">
          
            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#000000">
             <!--{foreach from =$order.goodsarr item = goods name=goodsitem}}-->
			 <tr>
                <td bgcolor="#FFFFFF" class="STYLE5">
                <ul>
                	<li><img src="index.php?model=login&action=Barcode&number=<!--{$order.order_sn}-->&height=34" alt=""/></li>
                    <li style="width:206px;margin-top:-20px;letter-spacing:4px;"><center><!--{$goods.goods_sn}--></center></li>
                </ul>
                </td>
                <td bgcolor="#FFFFFF" class="STYLE5"><b><!--{$goods.location}--></b>&nbsp;</td>
                <td align="center" bgcolor="#FFFFFF" class="STYLE5"><font size="2px"></font></td>
              </tr>          
			<!--{/foreach}-->
            </table>
            <div align="right" class="STYLE5">
            <div align="right">
            Record No: &nbsp;&nbsp;<!--{$order.sellsrecord}-->
</div>
            <br />
            </div></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
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
						 	*<!--{$order.track_no}-->*
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
<span class=cn2><BR>(15)Date and sender's signature</span> <div style="text-align:right;padding-right:20px;font-style: italic;font-weight:bold"></div>
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
<!--{/if}-->
</body>