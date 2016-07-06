<?php

/**
 * User: 冯晓飞
 * Date: 2016/1/15
 * Time: 13:54
 */
class role extends Controller
{

    private $role;

    function __construct()
    {
        parent::__construct();
        $this->role = new roleModel();
    }
//region admin role

    //查找所有角色
    function get_roles()
    {
        $where = array('used' => true);
        $sort = array('sort' => -1);
        $result = $this->role->find('roles', $where, getPageLimit());
        echo $this->json->encode($result);
    }

    //添加角色
    function add_role()
    {
        $data = postData();
        $result = $this->role->save('roles', $data);
        echo $this->json->encode($result);
    }

    //编辑角色
    function edit_role()
    {
        $data = postData();
        $result = $this->role->save('roles', $data);
        echo $this->json->encode($result);
    }

    //删除角色
    function remove_role()
    {
        $result = $this->role->removeById('roles');
        echo $this->json->encode($result);
    }

    //批量删除角色
    function remove_roles()
    {
        $ids = array();
        foreach (postData() as $v) {
            $ids[] = new MongoId($v);
        }
        $where = array("_id" => array('$in' => $ids));
        $result = $this->role->remove('roles', $where);
        echo $this->json->encode($result);
    }

    
}