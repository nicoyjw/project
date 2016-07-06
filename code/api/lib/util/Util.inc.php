<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+

/**
 * 常用函数
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package   Util
 * @version   v0.1
 */

/**
 * 调试使用情况
 */
function debug_using()
{
    echo '执行时间：' . (array_sum (explode (' ' , microtime ())) - $GLOBALS['_start_time_']) . ' 秒.<br>';
    if (function_exists ('memory_get_usage')) {
        echo '内存使用：' . number_format (memory_get_usage ()) . ' 字节.<br>';
    }
}

/**
 * 将提交的数据进行html格式编码
 *
 * @param array $array 处理的数组
 * @param array $lists 要处理的数组中key的数组
 *
 * @return array
 */
function specConvert(&$array , $lists)
{
    if (!defined ('CFG_CHARSET')) {
        define ('CFG_CHARSET' , 'utf-8');
    }
    foreach ($lists as $value) {
        $array[$value] = htmlspecialchars ($array[$value] , ENT_COMPAT , CFG_CHARSET);
        $array[$value] = str_replace ("\n" , "<br>" , $array[$value]);
        $array[$value] = trim ($array[$value]);
    }
    return $array;
}

/**
 * 将specConvert编码后的数据解码
 *
 * @param array $array 处理的数组
 * @param array $lists 要处理的数组中key的数组
 *
 * @return array
 */
function specDeConvert(&$array , $lists)
{
    if (!defined ('CFG_CHARSET')) {
        define ('CFG_CHARSET' , 'utf-8');
    }
    foreach ($lists as $value) {
        $array[$value] = html_entity_decode ($array[$value] , ENT_COMPAT , CFG_CHARSET);
        $array[$value] = str_replace ("<br>" , "\n" , $array[$value]);
    }
    return $array;
}

/**
 * 双字节字符截取
 *
 * @param string $content
 * @param int $length
 *
 * @return string
 */
function substrs($content , $length)
{
    if (!defined ('CFG_CHARSET')) {
        define ('CFG_CHARSET' , 'utf-8');
    }
    if ($length && strlen ($content) > $length) {
        if (CFG_CHARSET != 'utf-8') {
            $retstr = '';
            for ($i = 0; $i < $length - 2; $i++) {
                $retstr .= ord ($content[$i]) > 127 ? $content[$i] . $content[++$i] : $content[$i];
            }
            return $retstr . ' ..';
        } else {
            return utf8_trim (substr ($content , 0 , $length * 3));
        }
    }
    return $content;
}

/**
 * utf8去除空格
 *
 * @param string $str
 *
 * @return string
 */
function utf8_trim($str)
{
    $hex = '';
    $len = strlen ($str);
    for ($i = strlen ($str) - 1; $i >= 0; $i -= 1) {
        $hex .= ' ' . ord ($str[$i]);
        $ch = ord ($str[$i]);
        if (($ch & 128) == 0) return substr ($str , 0 , $i);
        if (($ch & 192) == 192) return substr ($str , 0 , $i);
    }
    return ($str . $hex);
}

/**
 * 给数组信息转义
 *
 * @param mixed $value
 *
 * @return mixed
 */
function addslashes_deep($value)
{
    if (empty($value)) {
        return $value;
    } else {
        return is_array ($value) ? array_map ('addslashes_deep' , $value) : addslashes (trim ($value));
    }
}

/**
 * 把文件路径转换成URL
 *
 * @param string $path 要转换的路径
 *
 * @return string
 */
function pathToUrl($path)
{
    $path = str_replace (getRootPath () , '' , $path);
    $path = str_replace ('\\' , '/' , $path);
    $path = str_replace ('//' , '/' , $path);
    return $path;
}

/**
 * ext取分页数组
 *
 * @return array
 */
function getPageLimit()
{
    $result = array ();
    $result['limit'] = $_REQUEST['ps'];
    $result['start'] = $_REQUEST['ps'] * ($_REQUEST['pi'] - 1);
    return $result;
}

/**
 *通过Key删除数组
 */
function array_remove($data , $key)
{

    if (is_null ($data) || is_null ($key)) {
        return null;
    }
    if (!array_key_exists ($key , $data)) {
        return $data;
    }
    $keys = array_keys ($data);
    $index = array_search ($key , $keys);
    if ($index !== FALSE) {
        array_splice ($data , $index , 1);
    }

    return $data;
}

/**
 *获取Post传递的值 返回格式为对象
 * 提出tk信息和SessionId
 */
function postData()
{
    $str = file_get_contents ("php://input");
    $data = json_decode (urldecode ($str) , true);
    $data = array_remove ($data , "tk");
    $data = array_remove ($data , "PHPSESSID");
    return $data;
}

/**
 * 获取Post传递的TK值
 */
function getPostTk()
{
    $str = file_get_contents ("php://input");
    $data = json_decode (urldecode ($str) , true);
    return $data["tk"];
}

function getPostSessionId()
{
    $sessionId = "";
    $str = file_get_contents ("php://input");
    if (isset($str) && !empty($str)) {
        $data = json_decode (urldecode ($str) , true);
        $sessionId = $data["PHPSESSID"];
    } else {
        $sessionId = $_GET["PHPSESSID"];
    }
    return $sessionId;
}

/**
 * 检查管理员权限
 *
 * @access  public
 *
 * @param   string $authz
 *
 * @return  boolean
 */
function check_authz($authz)
{
    return (preg_match ('/,*' . $authz . ',*/' , $_SESSION['action_list']) || $_SESSION['action_list'] == 'all');
}


function arrayToObject($e)
{
    if (gettype ($e) != 'array') return;
    foreach ($e as $k => $v) {
        if (gettype ($v) == 'array' || getType ($v) == 'object') $e[$k] = (object)arrayToObject ($v);
    }
    return (object)$e;
}

function objectToArray($e)
{
    $e = (array)$e;
    foreach ($e as $k => $v) {
        if (gettype ($v) == 'resource') return;
        if (gettype ($v) == 'object' || gettype ($v) == 'array') $e[$k] = (array)objectToArray ($v);
    }
    return $e;
}

function encrypt($data , $key)
{
    $char = "";
    $str = "";
    $key = md5 ($key);
    $x = 0;
    $len = strlen ($data);
    $l = strlen ($key);
    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) {
            $x = 0;
        }
        $char .= $key{$x};
        $x++;
    }
    for ($i = 0; $i < $len; $i++) {
        $str .= chr (ord ($data{$i}) + (ord ($char{$i})) % 256);
    }
    return base64_encode ($str);
}

function decrypt($data , $key)
{
    $char = "";
    $str = "";
    $key = md5 ($key);
    $x = 0;
    $data = base64_decode ($data);
    $len = strlen ($data);
    $l = strlen ($key);
    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) {
            $x = 0;
        }
        $char .= substr ($key , $x , 1);
        $x++;
    }
    for ($i = 0; $i < $len; $i++) {
        if (ord (substr ($data , $i , 1)) < ord (substr ($char , $i , 1))) {
            $str .= chr ((ord (substr ($data , $i , 1)) + 256) - ord (substr ($char , $i , 1)));
        } else {
            $str .= chr (ord (substr ($data , $i , 1)) - ord (substr ($char , $i , 1)));
        }
    }
    return $str;
}

function local_time()
{
    return time () + 60 * 60 * 8;
}


?>