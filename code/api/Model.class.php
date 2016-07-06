<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 逻辑层基类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package   Model
 * @version   v0.1
 */
abstract class Model
{

    public $db;
    public $redis;

    function __construct($db = null , $host = null)
    {

        if (empty($host)) $host = "mongodb://202.104.151.209:27017";

        if (empty($db)) $db = "shipping4el";

        $this->db = new mongoHelper($db , $host);

        $this->redis = new redisHelper("202.104.151.209" , 6379 , "huliansu@2013");

    }

    /**
     * 公共查找列表方法
     *
     * @param $collection  string 表名
     * @param $where       array  搜索条件
     * @param $condition   array  附加条件  limit，start，sort
     *
     * @return array
     */
    function find($collection , $where , $condition)
    {
        try {

            $result['data'] = $this->db->find ($collection , $where , $condition);
            $result['count'] = $this->db->count ($collection , $where);
            $result['success'] = is_array ($result['data']);
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    /**
     * 获取指定条件的数据总数
     *
     * @param $collection  string 表名
     * @param $where       array  搜索条件
     *
     * @return array
     */
    function count($collection , $where)
    {
        try {
            $result['count'] = $this->db->count ($collection , $where);
            $result['success'] = true;
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    /*
     * @$keys 分组的key  array ("category" => 1);
     * @$initial = array ("items" => array ());
     * @$reduce = "function (obj, prev) { prev.items.push(obj.name); }";
     * @where 过滤条件
     *
     * */
    function group($keys , $initial , $reduce , $where)
    {
        return $this->db->group ($keys , $initial , $reduce , $where);
    }

    function save($collection , $data)
    {
        try {
            if (isset($_GET["id"])) {
                $where = array ("_id" => new MongoId($_GET["id"]));
                $flag = $this->db->edit ($collection , $where , $data);
                $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
            } else {
                $flag = $this->db->add ($collection , $data);
                $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
            }
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    function push($collection , $where , $data)
    {
        try {
            $flag = $this->db->push ($collection , $where , $data);
            $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    function update($collection , $data , $where)
    {
        try {
            if (isset($where)) {
                $flag = $this->db->edit ($collection , $where , $data);
                $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
            } else {
                $result['success'] = false;
                $result['error'] = "参数错误";
            }

        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    function remove($collection , $where)
    {
        try {
            $flag = $this->db->remove ($collection , $where);
            $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    function removeById($collection)
    {
        try {
            $where = array ("_id" => new MongoId($_GET["id"]));
            $flag = $this->db->remove ($collection , $where);
            $result["success"] = is_bool ($flag) ? $flag : is_array ($flag);
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    //查找一条数据
    function findOne($table , $where)
    {
        try {
            $result['data'] = $this->db->findOne ($table , $where);
            $result['success'] = is_array ($result["data"]);
        } catch (Exception $e) {
            log_error ($e);
            $result['success'] = false;
            $result['error'] = $e->getMessage ();
        }
        return $result;
    }

    function paramsErr()
    {
        $result = array ();
        $result["success"] = false;
        $result["error"] = "参数错误";
        return $result;
    }

    //region Redis

    function redis_set($key , $value , $timeout)
    {
        try {
            $this->redis->set ($key , $value , $timeout);
        } catch (Exception $e) {
            log_error ($e);
        }
    }

    function redis_get($key)
    {
        try {
            return $this->redis->get ($key);
        } catch (Exception $e) {
            log_error ($e->getMessage ());
        }
    }

    //endregion

    /*
     * 发送短信
     *
     * */
    function sendMsg($tel , $content)
    {
        $post_data = array ('token' => '6b517d4134797cf29f129240def46bba123' , 'content' => $content , 'tel' => $tel);

        $ch = curl_init ();
        curl_setopt ($ch , CURLOPT_POST , 1);
        curl_setopt ($ch , CURLOPT_HEADER , 0);
        curl_setopt ($ch , CURLOPT_URL , 'http://www.93myb.com/api/message/sendMsg.php');
        curl_setopt ($ch , CURLOPT_POSTFIELDS , http_build_query ($post_data));
        curl_setopt ($ch , CURLOPT_RETURNTRANSFER , 1);

        $result = array ("success" => true);

        //        $result = curl_exec ($ch);
        //
        //        if (!isset($result["success"]) || !$result["success"]) {
        //            $result ["success"] = false;
        //            $result["error"] = "短信服务器异常,稍后再试！";
        //        }

        return $result;
    }

}

?>