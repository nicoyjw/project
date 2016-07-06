<style>
#listpart{ background:#000;}
#listpart tr td{ background:#fff;}
</style>
  <div id="center">
  <center><h1><!--{$order_sn}--><img src="index.php?model=login&action=Barcode&number=<!--{$order_sn}-->&height=48"></h1></center>
  <!--{$infopart}-->
  <table width="100%"  border="1" cellspacing="1" cellpadding="0" id="listpart">
  <!--{$listheader}-->
  <!--{foreach from =$listpart item = order name=orderitem}-->
  <tr>
  	<!--{ if $showimg eq 1}-->
    <td><img src="<!--{$order.goods_img}-->" width= 100 /></td><!--{/if}-->
    <td><!--{ if $order.url}--><!--{$order.goods_sn}--><!--{/if}-->
    
  </td>
    
    <td><!--{$order.supplier_goods_sn}--></td>
    
    <td><!--{$order.goods_name}--></td>
    
    <td><!--{$order.goods_qty}--></td>
    <!--{if $view_cost eq 1}--><td><!--{$order.goods_price}--></td><!--{/if}-->
    <td><!--{$order.remark}--></td></tr>
  	<!--{/foreach}-->
  </table>
  </div>
<a href="" target="_blank"></a>