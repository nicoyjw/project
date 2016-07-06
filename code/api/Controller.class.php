<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 控制器基类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package   Common
 * @version   v0.1
 */

/**
 * 控制器基类
 * @package Common
 */
abstract class Controller extends App
{

    /**
     * 构造函数
     */
    function __construct()
    {
        $this->json = App::getRegistry ('json');
    }

    /**
     * 错误 未知页面
     */
    function _noAction($actionName)
    {
        $this->outError ('action: ' . $actionName . ' 未定义 .');
    }

    /**
     * 输出结果
     */
    function outData($data)
    {
        echo $this->json->encode ($data);
    }

    /**
     * 输出成功结果
     */
    function outSuccessData($data)
    {
        $result = array ("success" => true , "data" => $data);
        echo $this->json->encode ($result);
    }

    /**
     * 输出错误
     */
    function outError($msg)
    {
        $result = array ("success" => false , "error" => $msg);
        echo $this->json->encode ($result);
    }

    /**
     * 权限检测
     *
     * @param $authz 权限检查
     */
    function actionCheck($authz)
    {
        if (!check_authz ($authz)) {
            echo "{success:false,msg:'您没有此操作的权限，请联系系统管理员!'}";
            exit;
        } else {
            return true;
        }
    }

    //endregion
}

?>
