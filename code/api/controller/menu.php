<?php

/**
 * User: 冯晓飞
 * Date: 2016/1/15
 * Time: 13:54
 */
class menu extends Controller   
{
    private $menu;

    function __construct()
    {
        parent::__construct();

        $this->menu = new menuModel();

    }
    //region admin menu
    //查询所有菜单
    function get_menus()
    {
        $where = array('used' => true);
        $sort = array('sort' => -1);
        $result = $this->menu->find('menus', $where, getPageLimit());
        echo $this->json->encode($result);
    }

    //添加菜单
    function add_menu()
    {
        $data = postData();
        $result = $this->menu->save('menus', $data);
        echo $this->json->encode($result);
    }

    //删除菜单 单条
    function remove_menu()
    {
        $result = $this->menu->removeById('menus');
        echo $this->json->encode($result);
    }

    //删除菜单
    function remove_menus()
    {
        $ids = array();
        foreach (postData() as $v) {
            $ids[] = new MongoId($v);
        }
        $where = array("_id" => array('$in' => $ids));
        $result = $this->menu->remove('menus', $where);
        echo $this->json->encode($result);
    }

    //更新菜单
    function edit_menu()
    {
        $data = postData();
        $result = $this->menu->save('menus', $data);
        echo $this->json->encode($result);
    }

//endregion
}