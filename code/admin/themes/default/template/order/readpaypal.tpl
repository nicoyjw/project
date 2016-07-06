<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
    loadend();
});
</script>
<link rel="stylesheet" type="text/css" href="https://www.paypalobjects.com/WEBSCR-570-20090422-1/css/core/paypal.css">
<link rel="stylesheet" type="text/css" href="https://www.paypalobjects.com/WEBSCR-570-20090422-1/css/pages/pageTransactionDetails.css">
<link rel="stylesheet" type="text/css" href="https://www.paypalobjects.com/WEBSCR-570-20090422-1/css/pages/pageGPWizard.css">
<div id="xptContentMain"><table align="center" border="0" cellpadding="0" cellspacing="0" id="xptContentContainer" width="600">
<tr><td><img alt="" border="0" height="1" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="600"></td></tr>
<tr><td><div id="xptTitle"><table align="center" border="0" cellpadding="0" cellspacing="0" class="main">
<tr><td class="heading" width="100%"><h1>Transaction Details</h1></td></tr>
<tr><td><img alt="" border="0" height="2" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="1"></td></tr>
<tr><td><hr></td></tr>
<tr><td><img alt="" border="0" height="4" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="1"></td></tr>
</table></div></td></tr>
<tr><td valign="top">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td class="topSpacer" width="155"><img alt="" border="0" height="1" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="155"></td>
<td class="topSpacer" width="6"><img alt="" border="0" height="1" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="6"></td>
<td class="topSpacer" width="100%"><img alt="" border="0" height="1" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="1"></td>
</tr>
<tr>
  <td colspan="3">
<span class="emphasis">eBay Payment Received</span> <span class="small">(Unique Transaction ID #<!--{$ebayorder.paypalid}-->)</span> <br>
<br>
当前订单号:<!--{$ebayorder.order_sn}--><br>
<br>
<br></td>
</tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br>
    <span class="emphasis">Notes:</span>
    
    <br>
	<!--{$paypalorder.NOTE}-->
    
    <br class="h10"></td></tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
<tr valign="top">
<td align="right" class="label">Total Amount:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.AMT}--> <!--{$paypalorder.CURRENCYCODE}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Fee amount:</td>
<td><br class="textspacer"></td>
<td class="small">-<!--{$paypalorder.FEEAMT}--> <!--{$paypalorder.CURRENCYCODE}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Net amount:</td>
<td><br class="textspacer"></td>
<td class="small"><!--{$paypalorder.TAXAMT}--> <!--{$paypalorder.CURRENCYCODE}--></td>
</tr>
<br class="textSpacer">
<tr valign="top">
<td align="right" class="label">Date:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.TIMESTAMP}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Time:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.ORDERTIME}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Status:</td>
<td><br class="textSpacer"></td>
<td class="small"><span><!--{$paypalorder.PAYMENTSTATUS}--></span></td>
</tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
<tr valign="top"><td colspan="3"><table align="center" border="0" cellpadding="3" cellspacing="0" width="100%">
<tr valign="top"><td colspan="2">
<table align="center" border="0" cellpadding="0" cellspacing="0" class="tableGreyOutsideBorder" id="ebay-item-info" width="100%"><tr><td><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" class="smallFontTable">
<tr bgcolor="#e2e0e0"><td><table align="center" border="0" cellpadding="2" cellspacing="0" width="100%">
<thead><tr>
<td class="item-number" width="15%"><span class="emphasis">Item #</span></td>
<td class="item-title" width="40%"><span class="emphasis">Item Title</span></td>
<td align="center" class="qty" width="9%"><span class="emphasis">Qty</span></td>
<td align="center" class="price" width="17%"><span class="emphasis">Price</span></td>
</tr></thead>
<tbody>
<!--{foreach from =$paypalorder.goods item = goods name=goodsitem}-->
<tr bgcolor="#FFFFFF">
<td class="item-number" width="15%"><!--{$goods.L_NUMBER}--></td>
<td class="item-title" width="40%"><!--{$goods.L_NAME}--> </td>
<td align="center" class="qty" width="9%"><!--{$goods.L_QTY}--></td>
<td align="center" class="price" width="17%"><!--{$goods.L_AMT}--> </td>
</tr>
<!--{/foreach}-->
</tbody>
</table></td></tr></table></td></tr></table>
<br>
</td></tr>
<tr valign="top">
<td align="right">Shipping &amp; Handling via Standard Delivery<br><span class="small">(includes any seller handling fees)</span>:</td>
<td align="right">--</td>
</tr>
<tr valign="top">
<td align="right">
<label for="wbn_insurance">Shipping Insurance</label><span class="small"> :</span></td>
<td align="right">--</td>
</tr>
<tr><td align="right" colspan="2" height="10" valign="top"><img height="1" width="125" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/greyline.gif" border="0" alt=""></td></tr>
<tr>
<td align="right" class="emphasis">Total:</td>
<td align="right" width="16%"><!--{$paypalorder.AMT}--> <!--{$paypalorder.CURRENCYCODE}--></td>
</tr>
</table>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
</td></tr>
<tr valign="top">
<td align="right" class="label">Shipping Address:</td>
<td><br class="textSpacer"></td>
<td class="small">
<!--{$paypalorder.SHIPTONAME}-->-----<!--{$ebayorder.consignee}--><br>
<!--{$paypalorder.SHIPTOSTREET}-->-----<!--{$ebayorder.street1}--><br>
<!--{$paypalorder.SHIPTOSTREET2}-->-----<!--{$ebayorder.street2}--><br>
<!--{$paypalorder.SHIPTOCITY}-->-----<!--{$ebayorder.city}--><br />
<!--{$paypalorder.SHIPTOSTATE}-->-----<!--{$ebayorder.state}--><br />
<!--{$paypalorder.SHIPTOZIP}-->-----<!--{$ebayorder.zipcode}--><br>
<!--{$paypalorder.SHIPTOCOUNTRYNAME}-->-----<!--{$ebayorder.country}--><br>
</td>
</tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
<tr valign="top">
<td align="right" class="label">Payment From:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.SHIPTONAME}-->  (The sender of this payment is <span class="emphasis"><!--{$paypalorder.PAYMENTSTATUS}--></span>)</td>
</tr>
<tr valign="top">
<td align="right" class="label">Buyer's ID:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.BUYERID}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Buyer's Email:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.EMAIL}--></td>
</tr>
<tr valign="top">
<td align="right" class="label">Payment Sent to:<br> </td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.RECEIVEREMAIL}--></td>
</tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
<tr><td colspan="3"><br class="h10"></td></tr>
<tr valign="top">
<td align="right" class="label">Payment Type:</td>
<td><br class="textSpacer"></td>
<td class="small"><!--{$paypalorder.PAYMENTTYPE}--></td>
</tr>
<tr><td colspan="3"><hr class="dotted"></td></tr>
</table>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td class="separationLine"><img alt="" border="0" height="2" src="https://www.paypalobjects.com/WEBSCR-570-20090422-1/en_US/i/scr/pixel.gif" width="1"></td></tr>
</table>
</td></tr>
</table></div>
<!--{include file="footer.tpl"}-->
