<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/3/23
 * Time: 16:10
 */

if (isset($_GET['code'])){
    echo $_GET['code'];
}else{
    echo "NO CODE";
}
$rand = $_GET['state'];
//用户扫描二维码跳转的地址
//会弹出授权的按钮，确认授权后会跳到回调地址上带上code
$url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx84c591e35782a34d&redirect_uri=http://localhost/api/weixin/callbacks.php&response_type=code&scope=snsapi_userinfo&state=".$rand;

header('location:'.$url);
