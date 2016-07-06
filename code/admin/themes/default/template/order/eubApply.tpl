<style>
#listpart{ background:#000;}
#listpart tr td{ background:#fff;}
</style>
  <center>申报清单<br/>生成日期：<!--{$smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}--> </center>
  <table width="100%"  border="1" cellspacing="0" cellpadding="0" id="listpart" style="BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px;BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px;BORDER-COLLAPSE: collapse; vertical-align:text-top">
  <tr><td>编号</td><td>包裹跟踪号</td><td width="100px">寄件人</td><td width="18%">内件信息</td><td width="48px">数量</td><td  width="70px" align="center">重量<br/>（公斤）</td><td width="80px">原产地</td><td width="80px">申报价值<br/>（美元）</td><td>收件人</td></tr>
  <!--{foreach from =$orders key=index item =order }-->
<tr>
    <td align="left" valign="top"><!--{$index+1}--></td>
    <td align="left" valign="top"><!--{$order.track_no}--></td>
    <td align="left" valign="top"  width="150px"><!--{$deliver.Contact}--><br><!--{$deliver.Street}--> <!--{$deliver.District}--> DISTRICT <br><!--{$deliver.City}--> <!--{$deliver.Province}--><br><!--{$deliver.Country}--> <!--{$deliver.zipcode}--></td>
    <td align="left" valign="top">
    	<!--{foreach from =$order.goods item =goodsinfo }-->
        <!--{$goodsinfo.dec_name}-->    <!--{$goodsinfo.dec_name_cn}--><br />
        <!--{/foreach}-->
    </td>
    <td align="left" valign="top">
    	<!--{foreach from =$order.goods item =goodsinfo }-->
        <!--{$goodsinfo.qty}--><br />
        <!--{/foreach}-->
    </td>
     <td align="left" valign="top">
    	<!--{foreach from =$order.goods item =goodsinfo }-->
        <!--{$goodsinfo.weight}--><br />
        <!--{/foreach}-->
    </td>
    <td  align="left" valign="top">
    	<!--{foreach from =$order.goods item =goodsinfo }-->
        China<br />
        <!--{/foreach}-->
    </td>
    <td align="left" valign="top">
    	<!--{foreach from =$order.goods item =goodsinfo }-->
        <!--{$goodsinfo.Declared_value}--><br />
        <!--{/foreach}-->
    </td>
    <td align="left" valign="top"><!--{$order.consignee}--><br><!--{$order.street1}--><!--{$order.street2}--><br><!--{$order.city}--><!--{$order.state}--><br><!--{$order.country}--><br><!--{$order.zipcode}--></td>
</tr>
<!--{/foreach}-->
</table>
