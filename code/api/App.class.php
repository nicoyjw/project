<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @package   Common
 * @version   v0.1
 */
class App
{

    /**
     * 构造函数
     */
    function __construct()
    {
        //设置为中国时区
        date_default_timezone_set ('PRC');
        // nothing
    }

    /**
     * 运行程序
     *
     */
    function run()
    {
       
        $cotrollerName = $_GET['model'];

        $file = 'controller/' . $cotrollerName . '.php';
        $modelFile = 'model/' . $cotrollerName . '.php';

        if (is_file ($file)) {
            include ($file);
            include ($modelFile);

            $cotroller = new $cotrollerName();

            $actionName = $_REQUEST['action'];

            if (method_exists ($cotroller , $actionName)) {

                //数据验证 防止网络篡改

                if (!$this->ValidData ()) {
                    log_error ("数据验证失败，请重新尝试！");
                    $cotroller->outError ("数据验证失败，请重新尝试！");
                    exit;
                }
                //客户端如果保存SessionId 重新初始化Session
                $sessionId = getPostSessionId ();
                if (isset($sessionId) && !is_null ($sessionId) && !empty($sessionId)) {
                    session_id ($sessionId);
                    session_start ();
                }
                log_log ("Call Action : $cotrollerName ---> $actionName");
                $cotroller->{$actionName}();
            } else if (method_exists ($cotroller , '_noAction')) {
                $cotroller->_noAction ($actionName);
            } else {
                throw new Exception('no Action');
            }
        } else {
            throw new Exception('no cotroller');
        }
    }

    function ValidData()
    {
        $data = postData ();
        if (empty($data)) return true;

        $arr = $this->joinData ($data);
        sort ($arr);

        $str = implode ("" , $arr);
        $str = strtr ($str , array (' ' => ''));
        $str = strtolower ($str);

        $tk = getPostTk ();
        $md5 = md5 ($str);

        return $md5 == $tk;
    }

    function joinData($data)
    {
        if (empty($data) || is_null ($data) || !is_array ($data)) return false;

        $arr = array ();

        foreach ($data as $key => $value) {

            if (is_bool ($value)) {
                $temp = $value ? "1" : "0";
                $arr[] = $key . $temp;
            } else if (is_string ($value) && ($value == "undefined" || $value == "null")) {
                var_dump ($key , $value);
                continue;
            } else if (!is_array ($value)) {
                $arr[] = $key . $value . "";
            } else {
                $join = $this->joinData ($value);
                if (is_array ($join)) $arr = array_merge ($arr , $join);
            }
        }

        return $arr;
    }

    /**
     * 注册一个公共变量
     *
     * @param string $key
     * @param mixed $value
     */
    public static function setRegistry($key , $value)
    {
        if (isset($GLOBALS['registry'][$key])) {
            throw new Exception($key . '已被注册');
        }
        $GLOBALS['registry'][$key] = $value;
    }

    /**
     * 返回已注册的公共变量
     *
     * @param string $key
     *
     * @return mixed
     */
    public static function getRegistry($key)
    {
        if (!isset($GLOBALS['registry'][$key])) {
            throw new Exception('没有' . $key . '这个注册变量！');
        }
        return $GLOBALS['registry'][$key];
    }
}

?>