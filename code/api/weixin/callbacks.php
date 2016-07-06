<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/3/23
 * Time: 16:12
 */

header('content-type:text/html;charset=utf-8');
session_start();
//调用使用curl
function getContents($url){
    //使用curl进行模拟请求获取字符串
    $ch = curl_init();
    //配置选项
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);//允许请求的内容以文件流的形式返回
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);//禁用https验证
    curl_setopt($ch, CURLOPT_URL, $url);//设置请求的url地址
    //执行发送
    $str = curl_exec($ch);
    //关闭curl
    curl_close($ch);
    return $str;
}

//调用刷新access_token		返回josn
//$appid     公众号的唯一标识
//$refresh_token   填写通过access_token获取到的refresh_token参数
function resets($appid,$refresh_token){
    $url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=".$appid."&grant_type=refresh_token&refresh_token=".$refresh_token;
    $str = getContents($url);
    return $str;
}

	if(isset($_GET['code'])){
        $code = $_GET['code'];
    }


	$url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx84c591e35782a34d&secret=42004e5968139b81c1910744bb347512&code=".$code."&grant_type=authorization_code";


	//判断是否远程抓取
	if(ini_get('allow_fopen_url')=='1'){
        $str = file_get_contents($url);
    }else{
        $str = getContents($url);
    }

	//获取access_token
	$data = json_decode($str,true);
	$token = $data['access_token'];
	//获取openid
	$openid = $data['openid'];
	//获取$refresh_token
	$refresh_token = $data['refresh_token'];

	$url = "https://api.weixin.qq.com/sns/userinfo?access_token=".$token."&openid=".$openid;

	$userinfo = getContents($url);
	$userinfo = json_decode($userinfo,true);

	//获取用户名称
	//$_SESSION['nickname'] = $userinfo['nickname'];
	//获取用户性别（值为1时是男性，值为2时是女性，值为0时是未知）
	//$_SESSION['sex'] = $userinfo['sex'];
	//获取用户头像
	//$face = isset($userinfo['headimgurl'])?$userinfo['headimgurl']:'';
	//$_SESSION['face'] = $face;





    /***
     *
     *  1.保存这个注册的用户   /ice/Saveuser.php
     *  2.创建一个type为8的account
     *
     */





/*
    $mongo = new Mongo("mongodb://localhost:27017");
    $database   = $mongo->selectDB('admin');
    //$collection = $database->selectCollection('users');
    //$user = $collection->findOne(array("wechatid"=>$openid));
    $wxcollection = $database->selectCollection('weixin');
    $info = array('name'=>$userinfo['nickname'],'wechatid' => $openid,'random'=>$_GET['state']);
    $result = $wxcollection->insert($info);*/
    if($result){
        print_r('授权成功');
    }else{
        print_r('授权失败');
    }





