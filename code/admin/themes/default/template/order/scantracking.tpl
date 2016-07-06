<style type="text/css">
<!--
.STYLE1 {
    font-size: larger;
    font-weight: bold;
}
-->
</style>
<script src="//www.cpowersoft.com/console/1.0/js/baselib-all.js"></script>
<div id="main">
    <div id="content" >
        <table style="width:100%"><tr><td><div class='moduleTitle'>
<h2>订单扫描 </h2>
</div>

<div class='listViewBody'>
<div id='Accountsadvanced_searchSearchForm' style='display:none' class="edit view search advanced"></div>
<div id='Accountssaved_viewsSearchForm' style='display: none';></div>
</form>
 
<table cellpadding='0' cellspacing='0' width='100%' border='0' class='list view'>
    <tr class='pagination'>
        <td width="65%">
            <table border='0' cellpadding='0' cellspacing='0' width='100%' class='paginationTable'>
                <tr>
                  <td nowrap="nowrap" class='paginationActionButtons'><form action="orderloadcsv.php" enctype="multipart/form-data" method="post" >
                    <table width="71%" border="0" align="center">
                      <tr>
                        <td width="21%">订单号</td>
                        <td width="56%"><input name="order" type="text" id="order_sn"  style="font-size:86px; width:500px ; height:90px ">&nbsp;</td>
                        <td width="23%">:</td>
                      </tr>
                      <tr>
                        <td>跟踪号</td>
                        <td><input name="tracknumber" type="text" id="track_no" style="font-size:86px; width:800px ; height:90px "></td>
                        <td width="23%"><span style="font-size:180px">
                        
                        </span></td>
                      </tr>
                      <tr>
                        <td colspan="3">&nbsp;</td>
                      </tr>
                    </table>
                  </form>
                  </td>
                </tr>
            </table>        </td>
    </tr>
        

              
        <tr class='pagination'>
        <td>
            <table border='0' cellpadding='0' cellspacing='0' width='100%' class='paginationTable'>
                <tr>
                    <td nowrap="nowrap" class='paginationActionButtons'></td>
                    </tr>
            </table>        </td>
    </tr></table>


    <div class="clear"></div>
    <div id="info"></div>
    
    
    <div style="color: red;font-size:18px;" id="error"></div>
<script language="javascript">

$(function(){
    
    $('#order_sn').bind('keydown',function(event){
   
      if(event.keyCode == 13 && $(this).val() !== ''){
            $('#track_no').focus();    
            
        }
        
    });
    
    
    
    
    $('#track_no').bind('keydown',function(event){
        if(event.keyCode == 13){
            $('#tracknumber').focus();    
                var param = {                      
                "track_no": $(this).val(),
                "order_sn": $('#order_sn').val()
            }
            $.ajax({         
                url: "index.php?model=order&action=savetrack",
                type:'POST',
                data: param,                                                             
                dataType: "text",    
                timeout: 60000,
                success:function(data) {
                    if(eval("("+data+")").success){   
                               
                        $('#info').html($('#info').html()+'<br><span style="color:grred">'+$('#order_sn').val()+'录入成功</span>'); 
                        $('#order_sn').val('');
                        $('#track_no').val('');
                        $('#order_sn').focus();  
                        $('#error').html('');            
                    }else{
                        $('#error').html(eval("("+data+")").msg);
                    }
                }
            });
        }
        
        
        
        
        
        
        
    });
    
      
})
</script>