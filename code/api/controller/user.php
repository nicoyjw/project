<?php

class user extends Controller
{

    private $user;

    function __construct()
    {
        parent::__construct ();
        $this->user = new userModel();
    }


    //查找所有用户
    function get_users()
    {
        $where = array ();
        $result = $this->user->find ('users' , $where , getPageLimit ());
        echo $this->json->encode ($result);
    }

    //添加用户
    function add_user()
    {
        $data = postData ();
        $result = $this->user->save ('users' , $data);
        echo $this->json->encode ($result);
    }


    function back_login(){
        $where = array ('name' =>$_GET['name'],'password' =>$_GET['password']);
        $user = $this->user->findOne ("backuser" ,$where);
        echo $this->json->encode ($user);

    }
    //删除用户
    function remove_user()
    {
        $result = $this->user->removeById ('users');
        echo $this->json->encode ($result);
    }

    //根据random去删除weixin表下的记录
    function remove_weixin()
    {
        $where = array ("random" => $_GET['random']);
        $result = $this->user->remove ('wechat' , $where);
        echo $this->json->encode ($result);
    }

    //批量删除用户
    function remove_users()
    {
        $ids = array ();
        $data = postData ();
        foreach ($data["ids"] as $v) {
            $ids[] = new MongoId($v);
        }

        $where = array ("_id" => array ('$in' => $ids));
        $result = $this->user->remove ('users' , $where);
        echo $this->json->encode ($result);
    }

    //修改角色信息
    function push_role()
    {
        $where = array ('_id' => new MongoId($_GET["id"]));
        $data = postData ();
        $result = $this->user->push ("users" , $where , $data);
        echo $this->json->encode ($result);
    }


    //用户注册
    function register()
    {
        $data = postData ();
        if (strtolower ($data["checkimg"]) != strtolower ($_SESSION["checkimg"])) {
            $this->outError ("验证码错误.");
            exit;
        }
        $data = array_remove ($data , "checkimg");
        $result = $this->user->save ('users' , $data);
        echo $this->json->encode ($result);
    }

    //验证用户名是否存在
    function check_exist()
    {
        $name = $_GET["name"];
        $email = $_GET["email"];
        if(isset($name) &&  !isset($email) ){
            $where = array ('name' => $name);
        }else if(isset($email) &&  !isset($name)){
            $where = array ('email' => $email);
        }else{
            $this->outError ("参数错误.");
        }

        $result = $this->user->find ("users" , $where);
        echo $this->json->encode ($result);
    }

    //修改密码
    function pass_change()
    {
        $params = postData ();
        $name = $params["name"];
        $oldPass = $params["oldpass"];
        $newPass = $params["newpass"];

        $checkimg = $_SESSION["checkimg"];

        log_debug ('SESSION:' . $checkimg . '  data:' . $params["checkimg"]);
        if (strtolower ($params["checkimg"]) != strtolower ($_SESSION["checkimg"])) {
            $this->outError ("验证码错误.");
            exit;
        }

        if (is_null ($name) || empty($name) || is_null ($oldPass) || empty($oldPass) || is_null ($newPass) || empty($newPass)) {
            $result = $this->user->paramsErr ();
            echo $this->json->encode ($result);
            exit;
        }

        $where = array ('name' => $name , "password" => $oldPass);

        $result = $this->user->findOne ("users" , $where);

        if ($result["success"]) {
            if (is_array ($result["data"])) {
                $newData = $result["data"];
                $newData["password"] = $newPass;
                $where = array ('_id' => new MongoId($newData["_id"]));
                $result = $this->user->update ('users' , $newData , $where);
            } else {
                $result["success"] = false;
                $result["error"] = "原密码错误!";
            }
        }

        echo $this->json->encode ($result);
    }

    //忘记密码，重置密码
    function pass_reset()
    {


        $params = postData ();
        $type = $params["type"];
        $name = $params["name"];
        $tel = $params["telephone"];
        $email = $params["email"];


        if (is_null ($type) || empty($type)) {
            $result = $this->user->paramsErr ();
            echo $this->json->encode ($result);
            exit;
        }


        if ($type == "email") {

            $checkimg = $_SESSION['checkimg'];
            log_debug ('SESSION _ checkimg:' . $checkimg . '  data:' . $params["checkimg"]);
            if (isset($params["checkimg"]) && strtolower ($params["checkimg"]) != strtolower ($_SESSION["checkimg"])) {
                $this->outError ("验证码错误.");
                exit;
            }

            if (is_null ($name) || empty($name) || is_null ($email) || empty($email)) {
                $result = $this->user->paramsErr ();
                echo $this->json->encode ($result);
                exit;
            }

            $result = $this->user->passResetByEmail ($name , $email);

        } else {

            $telCode = $_SESSION["telCode"];
            log_debug ('session TelCode: ' . $telCode . '  data:' . $params['telcode']);
            if (md5 ($telCode) !== $params["telcode"]) {
                $this->outError ("手机验证码错误");
                exit;
            }

            if (is_null ($name) || empty($name) || is_null ($tel) || empty($tel)) {
                $result = $this->user->paramsErr ();
                echo $this->json->encode ($result);
                exit;
            }

            $result = $this->user->passResetByTelephone ($name , $tel);
        }

        echo $this->json->encode ($result);
    }

    //验证邮箱地址
    function email_check()
    {
        $data = postData ();
        $checkimg = $_SESSION["checkimg"];

        log_debug ('SESSION:' . $checkimg . '  data:' . $data["checkimg"]);
        if (strtolower ($data["checkimg"]) != strtolower ($_SESSION["checkimg"])) {
            $this->outError ("验证码错误.");
            exit;
        }

        $key = $this->user->redis_get (CFG_REDIS_ENCRYPT);
        $email = $data["email"];

        $params = "id=" . $data['_id'] . "&email=" . $data['email'] . "&name=" . $data["name"] . "&time=" . time ();

        $encrypt = encrypt ($params , $key);
        log_debug ("encrypt : params:" . $params . " key:" . $key . " result:" . $encrypt . "  urlencode: " . urlencode ($encrypt));
        $encrypt = urlencode ($encrypt);
        $url = "http://www.el56.com/user.html#/user/emailchecked?&p=" . $encrypt;

        $content = "<div>点击以下连接进行验证 <a href = '" . $url . "' > 验证邮箱地址</a> </div> ";
        $this->user->sendEmail ($email , "易联物流邮箱验证" , $content);
        $this->outSuccessData ("");
    }

    function params_decrypt()
    {
        $params = postData ();
        $param = urldecode ($params[p]);
        $key = $this->user->redis_get (CFG_REDIS_ENCRYPT);

        $decrypt = decrypt ($param , $key);
        log_debug ("decrypt : params:" . $param . " key:" . $key . " result:" . $decrypt);

        $this->outSuccessData ($decrypt);
    }

    function email_check_submit()
    {
        $data = postData ();
        $where = array ("_id" => new MongoId($data["id"]));
        $user = array ("email" => $data["email"] , "emailchecked" => true);
        $result = $this->user->update ("users" , $user , $where);
        echo $this->json->encode ($result);
    }

    function tel_check()
    {
        $data = postData ();
        $where = array ("_id" => new MongoId($data["id"]));
        $telCode = $_SESSION["telCode"];
        log_log ("sessionTelCode:" . $telCode . ", md5TelCode:" . md5 ($telCode) . ",data:" . $data["code"]);
        if (md5 ($telCode) !== $data["code"]) {
            $this->outError ("手机验证码错误");
            exit;
        }

        $user = array ("telephone" => $data["telephone"] , "telchecked" => true);
        $result = $this->user->update ("users" , $user , $where);
        echo $this->json->encode ($result);
    }

    function check_session()
    {
        $user = $_SESSION["user"];
        if (is_null ($user)) {
            $this->outError ("用户未登录");
        } else {
            $this->outSuccessData ($user);
        }
    }

    //用户登录
    function login()
    {
        $data = postData ();
        $name = $this->user->findOne ("users" , array ("name" => $data['name']));
        if(!isset($name["data"])){
            $email = $this->user->findOne ("users" , array ("email" => $data['name']));
            if(!isset($email["data"])){
                $this->outError ("用户名或邮箱不存在");
                exit;
            }
        }else
        $result1 = $this->user->findOne ("users" , array ("password" => $data['password'],"email" => $data['name']));
        if(!isset($result1["data"])){
            $result2 = $this->user->findOne ("users" , array ("password" => $data['password'],"name" => $data['name']));
            if(!isset($result2["data"])){
                $this->outError ("密码错误");
                exit;
            }
            echo $this->json->encode ($result2);

        }else{
            echo $this->json->encode ($result1);
        }

    }


    function check_api(){
        $where = array ('type' => 'apiKey');
        $user = $this->user->findOne ("news" ,$where);
        return $user['data']['paritiesKey'];
    }

    //查询汇率api的所有国家以及code
    function country_code(){
        $key = $this->check_api();
        //初始化curl
        $ch = curl_init();
        //设置选线
        curl_setopt($ch,CURLOPT_URL,"http://op.juhe.cn/onebox/exchange/list?key=".$key);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $output = curl_exec($ch);
        //释放curl
        $output = curl_exec($ch);
        print_r($output);
    }


    //汇率兑换
    function parities(){
        //接收参数
        $key = $this->check_api();
        $from = $_GET['from'];
        $to = $_GET['to'];
        //初始化curl
        $ch = curl_init();
        //设置选线
        curl_setopt($ch,CURLOPT_URL,"http://op.juhe.cn/onebox/exchange/currency?key=".$key."&from=".$from."&to=".$to);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $output = curl_exec($ch);
        //释放curl
        $output = curl_exec($ch);
        print_r($output);
    }

}