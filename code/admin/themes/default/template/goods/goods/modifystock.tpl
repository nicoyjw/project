<!--{include file="header.tpl"}-->
<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	loadend();
});
	function changeshelfstock(value,goods_id,shelf_id,type){
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=goods&action=changeshelfstock',
					   loadMask:true,
					   params: { shelf_id: shelf_id,value:value,goods_id:goods_id,type:type },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
		}
		function clearvar(goods_id,shelf_id)
		{
					Ext.getBody().mask("Updating Data .waiting...","x-mask-loading");
					Ext.Ajax.request({
					   url: 'index.php?model=goods&action=clearvar',
					   loadMask:true,
					   params: { shelf_id: shelf_id,goods_id:goods_id },
						success:function(response,opts){
							var res = Ext.decode(response.responseText);
							Ext.getBody().unmask();
								if(res.success){
								Ext.example.msg('MSG',res.msg);
								}else{
								Ext.Msg.alert('ERROR',res.msg);
								}						
							}
						});
		}
</script>
<table border="1">
<tr><td>货架名</td><td width="50">产品数量</td><td width="100">货架位置</td><td width="50">报警库存</td><td>操作</td></tr>
<!--{foreach from =$shelflist item = shelf}-->
<tr><td><!--{$shelf.name}--></td><td><input size="10" type="text" name="<!--{$shelf.shelf_id}-->" value="<!--{$shelf.value}-->" onchange="changeshelfstock(this.value,<!--{$shelf.goods_id}-->,<!--{$shelf.shelf_id}-->,1)"></td><td><input type="text" name="place<!--{$shelf.shelf_id}-->" value="<!--{$shelf.stock_place}-->" onchange="changeshelfstock(this.value,<!--{$shelf.goods_id}-->,<!--{$shelf.shelf_id}-->,2)"></td><!--{if $shelf.is_main eq 1}--><td><input type="text" size="10" name="warn<!--{$shelf.shelf_id}-->" value="<!--{$shelf.warn_qty}-->" onchange="changeshelfstock(this.value,<!--{$shelf.goods_id}-->,<!--{$shelf.shelf_id}-->,3)"></td><td><input type="button" value="清空锁定库存" onclick="clearvar(<!--{$shelf.goods_id}-->,<!--{$shelf.shelf_id}-->)"/></td><!--{else}--><td></td><td></td><!--{/if}--></tr>
<!--{/foreach}-->
</table>
<!--{include file="footer.tpl"}-->
