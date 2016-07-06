<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/3/23
 * Time: 16:06
 */

class recode
{
    const __URL__ = 'http://localhost';           //绝对路径

    protected $filename = '';      //图片名称

    //加载核心文件
    function __construct($file =''){
        include_once('phpqrcode.php');
        if($file != '' && $file){
            $this->filename = dirname(__FILE__).'/'.$file;
        }else{
            $this->filename = dirname(__FILE__).'/oauth.png';
        }
    }

    //创建一个二维码文件
    public function code($data){

        $errorCorrectionLevel = 'L';  // 纠错级别：L、M、Q、H

        $matrixPointSize = 4;  // 点的大小：1到10

        QRcode::png($data, $this->filename, $errorCorrectionLevel, $matrixPointSize, 2);

        return str_replace('/var/www/html',self::__URL__,$this->filename);
    }

    //输入二维码到浏览器
    public function showCode($data){
        header("Pragma: no-cache");
        header("Cache-control: no-cache");
        QRcode::png($data);
    }
}

//https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx84c591e35782a34d&redirect_uri=http://wx.93myb.com/WX_callback.php&response_type=code&scope=snsapi_userinfo&state=lxc123&connect_redirect=1#wechat_redirect