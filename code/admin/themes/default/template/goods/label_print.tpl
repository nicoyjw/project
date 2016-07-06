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
  <input id="idPrint3" type="button" value="打印预览" onClick="hideplace();">
	</div>
</div> 
<!--{foreach from =$goodslist item = goods name=goodsitem}-->
<div  style="text-align:center; font-size:12px;" <!--{if $smarty.foreach.goodsitem.last}--><!--{else}-->class="pagebreak"<!--{/if}-->>
<ul>
<li><img src="index.php?model=login&action=Barcode&number=<!--{$goods.goods_sn}-->&type=1&height=35"></li>
<li><!--{$goods.stock_place}--></li>
</ul>
</div>
<!--{/foreach}-->
</body>