<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                  | 
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015 (http://www.cpowersoft.com)        |
// |                                                              |
// | 要查看完整的版权信息和许可信息                               |
// | 或者访问 http://www.cpowersoft.com 获得详细信息              |
// +--------------------------------------------------------------+

/**
 * 敦煌网API接口
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class DH extends Controller{
    /**
     * 初始化页面信息
     */
    function __construct(){
        parent::__construct();
        
    }
    /**
     * 速卖通账号授权
     */
    function actionAuth(){
        $object = new ModelDH();
        $_SESSION['dh_account_name'] = $_POST['account_name'];
        $url = $object -> geturl($_POST);
        echo "{success:true,msg:'".$url."'}";exit;
    }
    /**
     * 速卖通账号授权
     */
    function actionOverAuth(){
        $object = new ModelDH();
        
        if($_SESSION['dh_account_id'] > 0){
            $object->updateDhAccount($_POST['account_name'],$_SESSION['dh_account_id']);
            $dd = new ModelDd();
            $dd->cacheDHaccount();
            $_SESSION['dh_account_id'] = '';
            echo 'OK';exit();  
        }else{                      
            echo '授权失败';exit();
        }
    }
    function actionLoadDHOrder(){
        $object = new ModelDH();
        try {
            
            $msg = $object->loadorder($_GET);  
            /*if(isset($msg['reauth']) && !empty($msg['reauth']) && $msg['reauth'] == 'reauth'){
                $html = '<div style="text-align:center;font-size:14px;color:red">token已失效，请重新授权！点击下面链接，登录速卖通帐号，授权成功请将code复制并粘贴到以下接收框中,点击提交！<br/><br/><br/><form action="index.php?model=aliexpress&action=OverAuth" method="POST" ><input type="hidden" id="account" name="account" value="'.$_GET['id'].'" />code:<input type="text" id="code" name="code"/><input type="submit" value="提交"/> </form></div><br/><br/><br/>
                <iframe height="500px" width="100%" src="'.$msg['url'].'" id="myframe" id="myframe" frameborder="0" target="_self"></iframe>';
                echo $html;exit();        
            }*/
            echo $msg;exit();
        } catch (Exception $e) {
                $errorMsg = $e->getMessage();
        }
        if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
        $this->name = 'loading';
        $this->dir = 'system';
        $this->show();     
    }   
}

?>