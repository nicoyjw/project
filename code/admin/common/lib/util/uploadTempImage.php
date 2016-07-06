<html>
<body>
<?php

function request_post($remote_server,$content){ 
   $http_entity_type = 'application/x-www-from-urlencoded'; //���͵ĸ�ʽ
    $context = array( 
        'http'=>array( 
            'method'=>'POST',
            'header'=>"Content-type: " .$http_entity_type ."\r\n". 
                      'Content-length: '.strlen($content), 
            'content'=>$content) 
         ); 
    $stream_context = stream_context_create($context); 
    $data = file_get_contents($remote_server,FALSE,$stream_context);
	$result=json_decode($data,true);
	if($result['success']){
		return $result;
	}else{
		throw new Exception($result['error_code']);exit();
	}
}


//
// Function: 获取远程图片并把它保存到本地
//
//
//   确定您有把文件写入本地服务器的权限
// 
//
// 变量说明:
// $url 是远程图片的完整URL地址，不能为空。
// $filename 是可选变量: 如果为空，本地文件名将基于时间和日期
// 自动生成.

function GrabImage($url,$filename="") {
   if($url==""):return false;endif;

   if($filename=="") {
     $ext=strrchr($url,".");
     if($ext!=".gif" && $ext!=".jpg"):return false;endif;
     $filename=date("dMYHis").$ext;
   }

   ob_start();
   readfile($url);
   $img = ob_get_contents();
   ob_end_clean();
   $size = strlen($img);

   $fp2=@fopen($filename, "a");
   fwrite($fp2,$img);
   fclose($fp2);

   return $filename;
}


/*$img=GrabImage("http://www.php100.com","");
if($img):echo '<pre><img src="'.$img.'"></pre>';else:echo "false";endif;  */


?>
</body>
</html>
