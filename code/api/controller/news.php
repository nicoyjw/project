<?php

/**
 * Created by PhpStorm.
 * User: WuRiWen
 * Date: 2016/3/21
 * Time: 21:18
 */
class news extends Controller
{
    private $news;

    function __construct()
    {
        parent::__construct();
        $this->news = new newsModel();
    }

    //添加&编辑
    function edit(){
        $data = postData();
        $result = $this->news->save($_GET['tab'], $data);
        echo $this->json->encode($result);
    }
    //查看所有
    function check_all(){
        $where = array ($_GET["key"] => $_GET["val"]);
        $result = $this->news->find ($_GET['tab'] , $where , getPageLimit ());
        echo $this->json->encode ($result);
    }
    function check_by_id()
    {
        $where = array ("_id" => new MongoId($_GET["id"]));
        $result = $this->news->findOne ($_GET['tab'] , $where);
        echo $this->json->encode ($result);
    }
    function check_one()
    {
        $where = array ($_GET["key"] => $_GET["val"]);
        $result = $this->news->findOne ($_GET['tab'] , $where);
        echo $this->json->encode ($result);
    }

    function remove(){
        $result = $this->news->removeById($_GET['tab']);
        echo $this->json->encode($result);
    }
    function remove_superclass(){
        $result = $this->news->removeById($_GET['tab1']);
        $where = array ("pid" => $_GET['id']);
        $result2 = $this->news->remove ($_GET['tab2'], $where);
        echo $this->json->encode($result2);
    }

    //批量删除
    function remove_lists()
    {
        $ids = array();
        $data = postData();
        foreach ($data["ids"] as $v) {
            $ids[] = new MongoId($v);
        }

        $where = array("_id" => array('$in' => $ids));
        $result = $this->news->remove($_GET['tab'], $where);
        echo $this->json->encode($result);
    }



}