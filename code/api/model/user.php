<?php

/**
 * User: 冯晓飞
 * Date: 2016/1/15
 * Time: 17:33
 */
class userModel extends Model
{
    /**
     * 构造函数
     */
    function __construct()
    {
        parent::__construct ("yltd");
    }


    function passResetByEmail($name , $email)
    {
        $where = array ('name' => $name , "email" => $email);
        $result = $this->findOne ("users" , $where);
        log_debug ($where);
        if (!$result["success"]) {
            $result["error"] = "用户名或邮箱地址不存在";
            unset($result["data"]);
            return $result;
        }

        $user = $result["data"];
        $key = $this->redis_get (CFG_REDIS_ENCRYPT);

        $params = "id=" . $user['_id'] . "&time=" . time ();

        $encrypt = encrypt ($params , $key);
        $encrypt = urlencode ($encrypt);

        $url = 'http://' . $_SERVER['HTTP_HOST'] . "/user.html#/user/doreset?&p=" . $encrypt;

        $content = "<div>点击以下连接 <a href = '" . $url . "' > 重置密码</a> </div> ";
        return $this->sendEmail ($email , "易联物流密码重置" , $content);
    }

    function passResetByTelephone($name , $tel)
    {
        $where = array ('name' => $name , "telephone" => $tel);

        $result = $this->findOne ("users" , $where);

        if (!$result["success"]) {
            $result["error"] = "用户名与手机号码不存在";
            unset($result["data"]);
            return $result;
        }

        $user = $result["data"];
        $password = $this->create_password ();

        $data = array ("password" => md5 ($password));
        $where = array ('_id' => new MongoId($user["_id"]));
        $result = $this->update ('users' , $data , $where);

        if ($result["success"]) {
            log_debug ($password);
            $result["data"] = $password;
            //SendMsg
            $content = "【93贸易宝】您的密码已重置，新密码为 " . $password . "打死都不能告诉别人哦！";
            $this->sendMsg ($tel , $content);
        }

        return $result;

    }

    //生成随机密码
    function create_password($pw_length = 8)
    {
        $randpwd = '';
        for ($i = 0; $i < $pw_length; $i++) {
            $randpwd .= chr (mt_rand (33 , 126));
        }
        return $randpwd;
    }


    function sendEmail($to , $subject , $content)
    {
        try {
            include ('./lib/util/smtp.php');
            $smtpserver = "smtp.163.com";
            $smtpserverport = 25;
            $smtpusermail = "互联速网络科技有限公司";
            $smtpuser = "huliansu@163.com";//SMTP服务器的用户帐号
            $smtppass = "huliansu2013";//SMTP服务器的用户密码
            $mailsubject = $subject;
            $mailtype = "HTML";
            $smtpemailto = $to;

            $smtp = new smtp($smtpserver , $smtpserverport , true , $smtpuser , $smtppass);
            //是否显示发送的调试信息
            $smtp->debug = false;

            $state = $smtp->sendmail ($smtpemailto , $smtpuser , $smtpusermail , $mailsubject , $content , $mailtype);

            //  log_debug ("sendMail:  " . $state . "  smtpserver:" . $smtpserver . "  smtpserverport:" . $smtpserverport . "  smtpuser:" . $smtpuser . "  smtppass:" . $smtppass . "  smtpemailto:" . $smtpemailto . "  smtpusermail:" . $smtpusermail . "  mailsubject:" . $mailsubject . " content:" . $content . " mailtype:" . $mailtype);

            $result = array ("success" => true , "data" => $state);


        } catch (Exception $e) {
            $result = array ("success" => false , "error" => $e);
        }

        return $result;
    }
}