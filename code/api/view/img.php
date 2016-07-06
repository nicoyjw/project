<?php

session_start ();
header ("Access-Control-Allow-Origin: *");
header ('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header ('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
header ('Access-Control-Allow-Credentials: true');

define ('CFG_LOG_LEVEL' , 6);
define ('CFG_PATH_ROOT' , dirname (dirname (__FILE__)) . '/');

require ('../lib/util/Util.log.php');
date_default_timezone_set ('PRC');
//session_start();
//新建画布
$i = imagecreatetruecolor (100 , 34);
//分配颜色
$color = imagecolorallocate ($i , 255 , 255 , 255);
//填充颜色
imagefill ($i , 0 , 0 , $color);
//300个点随机出现	位置  	颜色
for ($j = 0; $j <= 300; $j++) {
    $x = mt_rand (0 , 150);//位置
    $y = mt_rand (0 , 35);
    //颜色
    $color = imagecolorallocate ($i , mt_rand (0 , 255) , mt_rand (0 , 255) , mt_rand (0 , 255));
    //画点
    imagesetpixel ($i , $x , $y , $color);
}

//4条线随机颜色  位置
for ($j = 0; $j < 4; $j++) {
    //随机颜色
    $color = imagecolorallocate ($i , mt_rand (0 , 255) , mt_rand (0 , 255) , mt_rand (0 , 255));
    //随机位置
    $x1 = 0;
    $y1 = mt_rand (0 , 30);
    $x2 = 150;
    $y2 = mt_rand (0 , 30);
    //画线
    imageline ($i , $x1 , $y1 , $x2 , $y2 , $color);
}

//随机产生4位字符串  随机颜色 	随机位置

//合并带有范围的数组
$arr = array_merge (range ('a' , 'z') , range ('A' , 'Z') , range (1 , 9));
//把数组的值转化成字符串 	用'' 分割
$str = join ('' , $arr);
//打乱字符串  	截取4位字符串
$strsix = substr (str_shuffle ($str) , 0 , 4);

//把验证码放到session

$_SESSION['checkimg'] = strtolower ($strsix);
$sessionId = session_id ();
setCookie ('PHPSESSID' , $sessionId , time () + 3600 , '/');

//log_debug ("checkimg:　　" . $_SESSION['checkimg'] . '  PHPSESSID: ' . $sessionId);

for ($j = 0; $j < strlen ($strsix); $j++) {
    //截取一个字符串
    $char = substr ($strsix , $j , 1);
    //随机颜色
    $color = imagecolorallocate ($i , mt_rand (0 , 255) , mt_rand (0 , 255) , mt_rand (0 , 255));
    //随机角度
    $angle = mt_rand (-15 , 15);
    //字的位置
    $x = 10 + $j * 20;
    $y = 30;
    //写到图片上
    imagefttext ($i , 20 , $angle , $x , $y , $color , 't1.ttf' , $char);
}

//$img = imagepng($i);

//用n表示短整型数据s，用N表示整形数据i
$format = "ncode/A64username/Ncount";
$length = 2 + 64 + 4;

//二进制流转化成字符串
function bin2string($str , $format , $length)
{
    for ($i = 0 , $c = strlen ($str); $i < $c; $i += $length) {
        $arr = unpack ("@$i/$format" , $str);
        foreach ($arr as &$value) {
            if (is_string ($value)) {
                $value = strtok ($value , "\0");
            }
        }
    }
    return $arr;
}

header ('Content-type: image/jpg');
//调用
imagepng ($i);











