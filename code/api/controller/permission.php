<?php
/**
 * User: fengxiaofei
 * Date: 2016/1/12
 * Time: 10:39
 */
include_once('../controller/Config.php');

class permission extends Controller
{
    private $permission;

    function __construct()
    {
        parent::__construct();
        $this->logistic = new logisticModel();
    }

    /** 保存用户所有权限到Redis中
     * @param $user_id
     */
    function setUserPermissions($user_id)
    {
        $permissions = array();

        $db = new mongoHelper();
        $user = $db->find("users", array("_id" => new MongoId($user_id)));
        $where = array('code' => array('$in' => $user[0]['roles']));
        $roles = $db->find('roles', $where);

        foreach ($roles as $value) {
            $permissions = array_merge($value['permissions'], $permissions);
        }

        $permissions = array_unique($permissions);
        $redis = new redisHelper();
        $redis->set(Config::$user_permission_key . $user_id, json_encode($permissions));

        return $permissions;
    }

    /** 从Redis中获取用户所有权限
     * @param $userId
     */
    function getUserPermissions($user_id)
    {
        $redis = new redisHelper();
        $result = $redis->get(Config::$user_permission_key . $user_id);
        return json_decode($result);
    }

    /** 验证用户是否有权限
     * @param $userId用户标识
     * 操作权限
     */
    function hasPermission($user_id, $permission)
    {
        $permissions = $this->getUserPermissions($user_id);
        return in_array($permission, $permissions);
    }
}

?>